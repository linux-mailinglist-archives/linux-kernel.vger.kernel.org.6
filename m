Return-Path: <linux-kernel+bounces-401080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E409C15C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A44281EB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63281CDFA6;
	Fri,  8 Nov 2024 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pgIRNKS4"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F232BB15
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041825; cv=none; b=UEAXRaV9DphbQwZH6ROkvPrgKLBQHz9UwhjdFe8Rg+VNSomMiIYc9Wnw5UbfCArYECw+y3VVM/H5FUNuy+rXY6fgkLIZSLK65SA0qHjW3K7jcndOC60gmchUroiDLJHUA09IQWs/ixp4C33gnqKaUuq4B19JEj/G1XcaxCviWOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041825; c=relaxed/simple;
	bh=Ab3HMO3eKLgARO53MMIiVeWUY/vd9IniSh9diIM+Mdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Busq8buG2YmkXOcGxnoviThdpXk9seEUBLfxgmt2ff9RPoAxAWQnPrh5CaSVN9fWtOwXI1rWLLLu6Y0TnBLdr43J1I+G3AjJi0LEm2onxgPvwKDMulHD9YdW7PS7yrUAuTXWpbHl6y2OfPXhRIcsc59ustmoEeiHP6scoP9616s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pgIRNKS4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cd76c513cso16573245ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041823; x=1731646623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYxs/iAi9D4dvnBjz30eD6LEjanF6nsQbGyEsY5CVZU=;
        b=pgIRNKS4DWeyFj+2b90+hmhe6s1K8XXOkNl4xkjcN2F+Fz1tIrelvarYFnCClu9mP1
         o2S6W4g9eHMIsPK0PssaFXiDEnBx298qMwc4c6asvZx2MMCebD8UAH3LpNAD4qJsdy0E
         9MReD98VogMc7x5kzL6mQfGGWjfch2mk41gD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041823; x=1731646623;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYxs/iAi9D4dvnBjz30eD6LEjanF6nsQbGyEsY5CVZU=;
        b=NBVMJ1b+0imJ0eQeKqZQ5sJx8ohxRxQfV3+TObqFNdMaTNw6XMz8wWiJ5HzK3l4SfU
         eJbB+77XC2fFATM/KCOWG2B5IIymyJG2OmKkt1Iv9Xr+f5AL49pXCs4kXeGnaU4gkbFy
         BLURJFoKE4cV+q5581NbjXjWuEV81hFYZeE2ShjzcCbfMLhv26RXUrazMiMqX+Zr9ZJc
         UZlZ+budnYEN6xkxQgLH2ar65dO8U92G1AqWQEpFGtfEel8IXUP9MyOmKBvuEZ9xWPlg
         JLHtDQB/ZAB/glc2FpnmJZALNQhcXmUXfrxb+WSe622qWwLpZxImyQX1CHdNo4y/xUbE
         f13A==
X-Forwarded-Encrypted: i=1; AJvYcCXp26qH6QVZekesnclttzKmh0Bm9fTqBXX2wW00Wz0lrtkxiZSvNAA8a/YNZ1P8Y5vfXwTrdBBOAwUG0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNSq9j/kKSMLiJ97o1yaH5km4VhQO2hWqB+uYuSGs3mSRqRci
	4QGjEFWLwEZ8R9Mcspg5uY5v/fAVwjOQEHhIeLqgOSIQrN3jFXNFZxw0gpG5l3k=
X-Google-Smtp-Source: AGHT+IHSJD2nYvmtst0NABiKe+u1fp77FUf9fw5OcmO5zZDo1U9OgoqPCXRncmfsc4fru4WgRiaSKA==
X-Received: by 2002:a17:902:e890:b0:20c:b0c7:92c9 with SMTP id d9443c01a7336-21183589b2dmr19384295ad.34.1731041823027;
        Thu, 07 Nov 2024 20:57:03 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2f7sm21743925ad.77.2024.11.07.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:57:02 -0800 (PST)
Date: Thu, 7 Nov 2024 20:56:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 2/6] net: Add control functions for irq
 suspension
Message-ID: <Zy2aG_ObPOIGKU0g@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241108023912.98416-1-jdamato@fastly.com>
 <20241108023912.98416-3-jdamato@fastly.com>
 <20241107202119.525a3b76@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107202119.525a3b76@kernel.org>

On Thu, Nov 07, 2024 at 08:21:19PM -0800, Jakub Kicinski wrote:
> On Fri,  8 Nov 2024 02:38:58 +0000 Joe Damato wrote:
> > +EXPORT_SYMBOL(napi_suspend_irqs);
> 
> One more nit after all.. please drop the exports, epoll code can't
> be a module. Feel free to repost without the 24h wait.

Done. Thanks for catching that and letting me re-send so quickly.

