Return-Path: <linux-kernel+bounces-294009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF459587A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702E21C21C82
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12D19007D;
	Tue, 20 Aug 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXXsbLgr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B22745C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159632; cv=none; b=Dkpzn/1qiOdG5ek4M4qUp7wSLgFfPen95vxDjkwwyuYfSPTRT1VEXAWcSP1i1dXIgwmQaiHFMZZWiBhZee1612LcJ2EebyLTPmbbrKGyHmobwCq6WcZ7WKelKL/QQI36GU92977XWVTS3NLIFs4wLzefZaFYqH0BMdF7Hd3qh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159632; c=relaxed/simple;
	bh=uhrLadRMTglIPn3Zn3SZWPzmTNTTKZiHQxUwnCdahcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EedybdqjvF06TtmS2XlYl+KpFDFSxObAUngZuNHVRPbMB8RdQ68X2BJGRyfiQ3ftqJh+LgGhW89VNv2aceJ/Gq/EmGVQYiZ64eB8mSV5/itebFWq1iohSm/q8LrbCZDkweVuJpgzLus/Ujz57MtddcGo8vfKPvtICam30kqQFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXXsbLgr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724159629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZA9NsmYfHqlh7uFA5Iq6DDdHEhytABPy8E65xYTnnY=;
	b=cXXsbLgrlFzNk2GyF4pelZoEq+VRF+RJ1djtc6dIZNIZQ/eat1wof28I/G3/2E1FVd+HRy
	ps98x7oBDDuOXhlc3/y4PQnMx3doETOBHp/bDOT6jTIUecOZ72A2yo5DHnYZ/lLDKtUQE+
	4OdEz7XA0m570AX2S1kIaaSnVOWiCFI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-tDwa5Kz2MxGkPtGZrrcEkg-1; Tue, 20 Aug 2024 09:13:48 -0400
X-MC-Unique: tDwa5Kz2MxGkPtGZrrcEkg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718a4d3a82so3111462f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159626; x=1724764426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZA9NsmYfHqlh7uFA5Iq6DDdHEhytABPy8E65xYTnnY=;
        b=D4kc1hhAWDmF5E+egO8Atb50/rGcc+EatCvYOSWMXIOweBNJ1iS9rlV3PZ4cv11Hnj
         wO3rQ2bNJpGes2kYT+DRyhGZ1Ga69qs0ba3RJ0yrhY+qywdIHbe+LG8ps1wzf260dVth
         E3uo88UrVZJKllEilIuPDpBDMc0aU6yVik8yRuLtWmmH3IYYgXTrR3huBWbQ0PRscq68
         8NzdKijnYcAwfSIoBDQW8mZ1VB8CdS4yMGO+WqwsQX/VemO/zsLNl6FwIsnq/qFhT1oy
         fAboFPYn3XXcAN0t0FGJkmLZzeZ7//9kxBzIUOTH7lx/JLiXSFZmjr9FRX96bD9MBO7N
         ajFA==
X-Forwarded-Encrypted: i=1; AJvYcCVkhvaStG1x95FVgx2uvpsA6TB8hdM4UKYon/WtZGj/rwFhNUgC7uG9AiKYN4MRnwnLDknBqvgGO4ftrjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+r1Og5y4sdFnuBOh9/t0Gy9n5iQ6+pYvufbopOfCdIAbqc8Fe
	h3M5QSr6fG589JN6ZFEtZAmE1xuIJBRX1jJSd5L1MaFacMdNXWZc7LcNT1AlxSOcr7AIbLi+gh2
	CQP/O2VYOECW+MggzwOSoWcvhwVgTwdxq/oLyTYOyDfCJqyCGLhRa+sR8ew788Q==
X-Received: by 2002:a5d:4e4e:0:b0:368:327c:372b with SMTP id ffacd0b85a97d-3719444bfa6mr9305625f8f.19.1724159626054;
        Tue, 20 Aug 2024 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzI6GnucFTXbBS1llruGpj59nWY1C+0+wKIAAyQncc21XjuGko7iEFzA9mv0ekZasAiQdM5A==
X-Received: by 2002:a5d:4e4e:0:b0:368:327c:372b with SMTP id ffacd0b85a97d-3719444bfa6mr9305594f8f.19.1724159625543;
        Tue, 20 Aug 2024 06:13:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898abf2csm13028775f8f.107.2024.08.20.06.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:13:45 -0700 (PDT)
Message-ID: <a95f1211-0f1b-4957-8e31-1b53af888cb5@redhat.com>
Date: Tue, 20 Aug 2024 15:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ip6: ndisc: fix incorrect forwarding of proxied
 ns packets
To: Nils Fuhler <nils@nilsfuhler.de>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815151809.16820-2-nils@nilsfuhler.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815151809.16820-2-nils@nilsfuhler.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/24 17:18, Nils Fuhler wrote:
> When enabling proxy_ndp per interface instead of globally, neighbor
> solicitation packets sent to proxied global unicast addresses are
> forwarded instead of generating a neighbor advertisement. When
> proxy_ndp is enabled globally, these packets generate na responses as
> expected.
> 
> This patch fixes this behaviour. When an ns packet is sent to a
> proxied unicast address, it generates an na response regardless
> whether proxy_ndp is enabled per interface or globally.
> 
> Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>

I have mixed feeling WRT this patch. It looks like a fix, but it's 
changing an established behaviour that is there since a lot of time.

I think it could go via the net-next tree, without fixes
tag to avoid stable backports. As such I guess it deserves a self-test 
script validating the new behavior.

> ---
> v1 -> v2: ensure that idev is not NULL
> 
>   net/ipv6/ip6_output.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index ab504d31f0cd..0356c8189e21 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
>   		return -ETIMEDOUT;
>   	}
>   
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>   	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
>   		int proxied = ip6_forward_proxy_check(skb);
>   		if (proxied > 0) {

Note that there is similar chunk in ndisc_recv_na() that also ignores 
idev->cnf.proxy_ndp, why don't you need to such function, too?

Thanks,

Paolo


