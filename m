Return-Path: <linux-kernel+bounces-424900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3899DBAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0769281DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F231BD9C1;
	Thu, 28 Nov 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQMB5UZX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99383232
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809676; cv=none; b=AYJEIta0ejEYN1dAvPiFoygvmo0+SVgqZ+QyZXSeiIvl68M+YkI5JJOaMgewtZULADcJ8uEbDbY2zYH5o/QqxnIC0xxALs0+86bR1BMs99bwheomXfSGXQ32kEetbzGm85d7eC2XLi/Tk0zZcUW5lKJq6K4QweMPU1sxgDbyiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809676; c=relaxed/simple;
	bh=xNwLFOiaktqkdOudFbfy/3IrYA5qb4kuNOGwYSAq204=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LdeMBhhBuc9zZi75x4MULauuP/XorXMKakvmRpX4LkSCIvkQS9a7kJ8BiNJcporpPs0baF492e4EBqy0XX9lIJnTu7jLzTrAkQyLzi6rYOTNzZV8Hdm4XFHW5DwnUozzZ7TM40qTeGD9SkF2NBLkl/p6M0Ixn1DOIiCrqsUkVd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQMB5UZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732809673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/snLliwdrOrvrRkcmLpKV0p5kB2MTqjZDsVsrRSzH5c=;
	b=ZQMB5UZXLXI5S7NWd7zYr/o4QGb0OCt+VvGqEfDwGzqrXQ/fTQ3lCWUG3DZuy3YgIk9Lxb
	Tg4XVR2dVA+NOUJZb8EhNIpmGq19dMhFICf+/08BmIPiFta8VO7Hiv4S9HY3HpfYu22mOC
	Ai2vq5pB+vZste7vBVKhunjRySvHXlw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-8GxRDHDkN-6XuNpa8lX86w-1; Thu, 28 Nov 2024 11:01:12 -0500
X-MC-Unique: 8GxRDHDkN-6XuNpa8lX86w-1
X-Mimecast-MFC-AGG-ID: 8GxRDHDkN-6XuNpa8lX86w
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349e08ae91so7054145e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809671; x=1733414471;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/snLliwdrOrvrRkcmLpKV0p5kB2MTqjZDsVsrRSzH5c=;
        b=UGENaNnzExNjpKDiSe/USxhu70o2OhLfCm2b3BvWXKUPSevolhNmIll6XGBGAmPPNU
         3xqnbS99bDx0VWmjNP7srbjPK+qacRaxIO4vijlAA2KycdhNXAd5X620xnGMa9J4R7Lt
         QOah9CTMDCs6IbEVG6RnAAWB5fz2byASTSpp5oYR+WpIaKOjg32zNrdnGB50byDBSNhg
         NJYb19djXksYDDPO3syK+k1neCB11Tftw2JLQW48lVI5ExWTfTbyOkdUpdtEph/aQkW6
         AyHi9zTQtGNaCFJrK7HAA52gurEIOjYOx27chVgwZ1JjND0uDyNrYa/bRbr9hfmjklBO
         ieFw==
X-Forwarded-Encrypted: i=1; AJvYcCVAKIYRoLaEsuyWskEIjYj9+Dzr8VsjMA02hxKUfDPEvFPU90RmxZVy9RCCiwuRIQwSI0nqIb3PXvai+UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgevj0YC/6s+XjuEwV+hIjK1R/SQ9q1uO64AErxeujFiy8GLD
	olnHcxoaIi0v/IRSl6657lpghOY2lRd3FEKYI2+MJMJsGDNtUsPb9lJuD7GgwykDMuhBSBFvN9k
	6U0cRocMVmFMtYuiJ44mx8M27xsZq05ogEAdzOhAfAszqOR7jaopMVJn4w+gg+LbT/shwBw==
X-Gm-Gg: ASbGnct7kjPTpqnpMebBvDdd1gOubCRXJWrEeM1p6LeNCYWAkbY1Xk2gUnCacTR+wMM
	yQttJUbVu+zdSd/zO1P7JLak//fwOj0RJLm0GKLxaw3WOpX5Fu1SVRaYt08NZHFFxjWHy+ErFzb
	zuq5bsWV10lBFe84kXJKlCTscypEDfa3nF++IeR5tEsPoUU8hJG0Ey+LvNRN5rS2go1KgfYro0l
	WFiQ/Pwx4DcO2EvhS9c9sLBPDqcWpVaw7Pi+QTcLVsCDObS0oGN5Chp9zxUsbXPY6It+1SVTPuE
X-Received: by 2002:a05:6000:188c:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385c6edb164mr6773105f8f.45.1732809670509;
        Thu, 28 Nov 2024 08:01:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDMfgarNqWf7Ko8HtUjuOqir5qCf1R9Ml7TTy0ZO/N8evzPXPbgUXgXwPzPKKwhAmOvvl6mA==
X-Received: by 2002:a05:6000:188c:b0:381:b68f:d14b with SMTP id ffacd0b85a97d-385c6edb164mr6772842f8f.45.1732809668345;
        Thu, 28 Nov 2024 08:01:08 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36855sm1963119f8f.36.2024.11.28.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 08:01:07 -0800 (PST)
Message-ID: <29c9e4c9-9d94-41ee-96a3-990e65b2b47d@redhat.com>
Date: Thu, 28 Nov 2024 17:01:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Networking for v6.13-rc1
From: Paolo Abeni <pabeni@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241128142738.132961-1-pabeni@redhat.com>
 <Z0iC2DuUf9boiq_L@sashalap> <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Content-Language: en-US
In-Reply-To: <a4213a79-dd00-4d29-9215-97eb69f75f39@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 16:46, Paolo Abeni wrote:
> On 11/28/24 15:48, Sasha Levin wrote:
>> On Thu, Nov 28, 2024 at 03:27:38PM +0100, Paolo Abeni wrote:
>>>      ipmr: add debug check for mr table cleanup
>>
>> When merging this PR into linus-next, I've noticed it introduced build
>> errors:
>>
>> /builds/linux/net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
>>    320 | static bool ipmr_can_free_table(struct net *net)
>>        |             ^~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> The commit in question isn't in linux-next and seems to be broken.
> 
> My fault, I'm sorry.
> 
> I can't reproduce the issue here. 

I see it now. It's clang with CONFIG_DEBUG_NET=n. Apparently clang is
too smart with BUILD_BUG_ON_INVALID().

A trivial fix would be:
---
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 383ea8b91cc7..c5b8ec5c0a8c 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -437,7 +437,7 @@ static void ipmr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);

-	DEBUG_NET_WARN_ON_ONCE(!ipmr_can_free_table(net));
+	WARN_ON_ONCE(!ipmr_can_free_table(net));

 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 4147890fe98f..7f1902ac3586 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -416,7 +416,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
 {
 	struct net *net = read_pnet(&mrt->net);

-	DEBUG_NET_WARN_ON_ONCE(!ip6mr_can_free_table(net));
+	WARN_ON_ONCE(!ip6mr_can_free_table(net));

 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |


