Return-Path: <linux-kernel+bounces-401953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574679C2183
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888F71C23C76
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1742519309B;
	Fri,  8 Nov 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLSZ3bGR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717E194C79
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081783; cv=none; b=jezWPHGj0H41FC8Xv1qW378s6qJIj4NgwMgIAyLfwU3PZW0xQ3tl7MV7+rZCoTANSIguYJELgrDKZT26N8P/m8HxSFWYCVQw6vSbwDdY/K+yGJTWGI3IQeKB9VL7WKh0+a7sYZsdY3M564kEZ7Z4DVutF9fNThxTprsnbBw/f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081783; c=relaxed/simple;
	bh=Dkl1ieEc1BAg1ZDaYT7VtIs7itFlvZ0wDVhM9n7ovBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR0oI9XjVdx1TDi9tTvHZ4uQXRI+aZSnhBUii6d9LTFgY3sbVC1a/IknzuGtfbmWYEPWnU7+H3j9ejH6WkhfjY+ksl5bTMM54pDdjjehHJ3W/SizOkh/dRVNED/mP4o80/LYiX54g3j17o7XWRXMdkS13N96Wvsz6kpJkAp9SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLSZ3bGR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731081780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KodwbNUeuehD+z2uf2ly+jd4Lxh5FbYEBZu9aS+ypso=;
	b=bLSZ3bGRt4cxNvVICOghx4IilkwPXaLOlFGpTxrz4bO3xRmB3NE+c06rJThdnwG4yg+9D1
	o1e041V8cl1hiVd6fyvReMcYxwfiLxjnNRyl3JYYvahjwHMaIisB5j6YTU3rsWrsFZ4lmT
	3S+rtsN1nGII2dl7YQuKFeOJLtcDhvU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-oj9ImJnDPoa0eWWuJK2oJg-1; Fri, 08 Nov 2024 11:02:59 -0500
X-MC-Unique: oj9ImJnDPoa0eWWuJK2oJg-1
X-Mimecast-MFC-AGG-ID: oj9ImJnDPoa0eWWuJK2oJg
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539fbf73a2fso1871461e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081777; x=1731686577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KodwbNUeuehD+z2uf2ly+jd4Lxh5FbYEBZu9aS+ypso=;
        b=TaD0C+LrIp5iyNAoQfSp+oz0avA8wUVHvMP2dB3fwCBn5LzeEUQa/yK41rub4wOLs2
         YrZ6TPN1oT1806BVUtofYrmjJ0qxL8pKDuj4/OmN5MGvfQVlMbQVNxT9ceXHOvSYXOkz
         V2PTkzpB8xlzYzH+4Yza4lnExT3q2FkyBOZr4EzhFNKQZKs4T0mlVF8Z186TP9jSLjZN
         6/6i2z1CDNfj7O7goqj3FD4HccP6lBuIzPObegJ0r4K6pjHPNIw5BCV9SAHDMS0LK0om
         uxB5X4INWqxqE2nGGl0gVKHaLTZLKf9HNH3s73bxWBUvx4NumPT2P/Jo391FT71KRU4y
         6FFw==
X-Forwarded-Encrypted: i=1; AJvYcCWoj8oC4bgFOCzxCQZdS4dxjMtam7Jo1jUuc4XRLLJwSN1fKfMD1lOfPT65rgQsfoxTEEmHoCUA0U3zUJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWHG3julgMLx3F6+K0TUH5Tn4aO1VuomGxPmtn4hOozlZuhTj
	KfsThqCoiG3hCxRgVTtqbFpcSDTB8GjdpwOtzbAar0fYclpT0yq0QEShzIch3K4EmpaVpYLkGl5
	iVJVxPwK6ja7Jpin6mbpNOGT6yZYhWU2C3OSF93W04xvNZFSf+Pu6guA1c3OIvJJf0MGbKw==
X-Received: by 2002:a05:6512:3d0f:b0:53d:8274:a300 with SMTP id 2adb3069b0e04-53d862c5bbfmr1437104e87.34.1731081777240;
        Fri, 08 Nov 2024 08:02:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXUwhruY1WxPZM2lD15BwhIP8JhX3dp+oHUK/E9prDaGfWq7Kte9cKFc1RP7RvGorjuU5tSQ==
X-Received: by 2002:a05:6512:3d0f:b0:53d:8274:a300 with SMTP id 2adb3069b0e04-53d862c5bbfmr1437063e87.34.1731081776647;
        Fri, 08 Nov 2024 08:02:56 -0800 (PST)
Received: from debian (2a01cb058d23d60039a5c1e29a817dbe.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:39a5:c1e2:9a81:7dbe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm72642485e9.17.2024.11.08.08.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:02:56 -0800 (PST)
Date: Fri, 8 Nov 2024 17:02:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] net: Implement fault injection forcing skb
 reallocation
Message-ID: <Zy42LfWaiWHJ12Nw@debian>
References: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-fault_v6-v6-1-1b82cb6ecacd@debian.org>

On Thu, Nov 07, 2024 at 08:11:44AM -0800, Breno Leitao wrote:
> Introduce a fault injection mechanism to force skb reallocation. The
> primary goal is to catch bugs related to pointer invalidation after
> potential skb reallocation.

Nice to see this kind of debug option being worked on!

> +static bool should_fail_net_realloc_skb(struct sk_buff *skb)
> +{
> +	struct net_device *net = skb->dev;

It's confusing to see a variable called "net" pointing to a struct
net_device. "net" generally refers to struct net.

In case v7 is needed, it'd be nice to call this variable "dev".

Looks good to me otherwise.

Acked-by: Guillaume Nault <gnault@redhat.com>


