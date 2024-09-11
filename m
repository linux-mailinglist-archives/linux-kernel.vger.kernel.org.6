Return-Path: <linux-kernel+bounces-324925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DF29752B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B35E282D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D2187FEB;
	Wed, 11 Sep 2024 12:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2wL9wXW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8178C91
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058527; cv=none; b=kIkj6TILvh1e0Xs2j8fIbYoiLbSoqxt1sAvdDwDggKpLf/NOBS9vzqTZ8Vmgp3lHhlUxHvNJkgfKGYz27FU8J0q819SJ13HSC28ih6eyKnkN5NS5KIM13ReoYVLDy0sKO9hELFf+EZEgiijVpFQBwxoZzNxRU7/oCLF5TSaH7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058527; c=relaxed/simple;
	bh=68M9wWQ6D0/4boJfmPkluVdt1rWMxJpu6wIq5jUm6wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFYHqI47HuAMRNhm4eris5nOziGb3qr3MHSI1fSqCKb71FIFH4/jN94z89oFveLKiIMuZx6hNUZpPjKrvz/h+XGknNOTYwZt+mq/4DhP69wBd/4GdaPxHS5J/3DLzzGayC7JtTj4/aWJ8xmvCCECUUgUUYp2bnBci0iYs5i/Gis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2wL9wXW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726058524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0ptzBQhQOoA0oeKPkPmWFxxMGMZSMXArLR2ZEqlrxY=;
	b=b2wL9wXW74NHPipATGLUmFk+RI34c1G49BksEQQdCe+HtoXpGjftkFnh8Dl5xzXbBzdxWW
	y9jpypxdNjHfId13sxFM3EbQthSnBiZSphV9IkBxtzoBGeBSYF0ZnUiE3Qkb+YRVZbq88G
	+e33UzvlCF+0JKiKzg34jNsUMUQURLU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-6wvfhq-5OvSHZ8AvZhVQwQ-1; Wed, 11 Sep 2024 08:42:03 -0400
X-MC-Unique: 6wvfhq-5OvSHZ8AvZhVQwQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so4527635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726058522; x=1726663322;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0ptzBQhQOoA0oeKPkPmWFxxMGMZSMXArLR2ZEqlrxY=;
        b=ZhFHf/b7kmzm0dz6vNfGtAdoiQhl0BBiz9BaY/liFuA/aaQlX6weTiIDJQUD9g7+DD
         /zdbOy0LNIBgSqhlo2irjnHnpdTjWsoTqPolOh3UVyGtx6t6vTgTGscOy4XaXyJVV3gh
         zGtX9k+YmgQ3RRT7nWg9zOLNYWVI625iUzgL/WvwX4Oi6MJi5yR8lBO0iT4LaXfjyrDt
         R6KdiWCM5yEuzAVJE3YK49Zmrfdq+R2s2BCxMi1c3lbOBpgslk1fxBn7Ir/Z2JFwymkv
         qF5RDDDNefDCEFv5iq40fczGHAKBTF6BSi9KhDJjCPVMBKugegYZ/Y3tZMjyYMXEQbJz
         2aXA==
X-Forwarded-Encrypted: i=1; AJvYcCWJcNqqFnbhZXVMkXP1YKluANgGobyAsv3+p2DIlYVq2PVVZRgThHUUFAiPPgSZzqmO/ohYZrA/QSZvUrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmYBKNWekgao/mjZFJ83WG0fQlH3hLwC3Bf3Sda+mmp4Jse+Uv
	OAYTu3ktL8FEN86bVaEihNbjJZb4bxBqCSoJywm7s2+ztCvpuOhLePcZBP+XA9PH7is37oa2OhT
	NyIlgv0BpKs6XIV7BavELvoDkUCOZNjNP9PvT6ZG13xgC1BLVSScUb2R0nhBhaA==
X-Received: by 2002:a05:600c:3b9c:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42cbddb7904mr38733175e9.2.1726058522435;
        Wed, 11 Sep 2024 05:42:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyWqZ1yjNpZ6SU2nZ/H8bqXLB+fc34r7zTlF3XmhhAnRSHVIk8h1MkTxjZqwZOwfY9aj9Ymw==
X-Received: by 2002:a05:600c:3b9c:b0:42c:b332:1619 with SMTP id 5b1f17b1804b1-42cbddb7904mr38732785e9.2.1726058521473;
        Wed, 11 Sep 2024 05:42:01 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01a8ee7sm58414305e9.0.2024.09.11.05.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:42:01 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:42:00 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netlink: specs: mptcp: fix port endianness
Message-ID: <ZuGQGPDUS6o2B5ai@dcaratti.users.ipa.redhat.com>
References: <20240911091003.1112179-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240911091003.1112179-1-ast@fiberby.net>

hello Asbjørn,

On Wed, Sep 11, 2024 at 09:10:02AM +0000, Asbjørn Sloth Tønnesen wrote:
> The MPTCP port attribute is in host endianness, but was documented
> as big-endian in the ynl specification.
> 
> Below are two examples from net/mptcp/pm_netlink.c showing that the
> attribute is converted to/from host endianness for use with netlink.
> 
> Import from netlink:
>   addr->port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]))
> 
> Export to netlink:
>   nla_put_u16(skb, MPTCP_PM_ADDR_ATTR_PORT, ntohs(addr->port))
> 
> Where addr->port is defined as __be16.
> 
> No functional change intended.
> 
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

not sure why we are doing addresses in network byte order
and ports in host byte order for endpoints. But it's like this since the
very beginning, so this host ordering in spec is correct.

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


