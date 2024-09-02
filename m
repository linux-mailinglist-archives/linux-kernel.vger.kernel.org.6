Return-Path: <linux-kernel+bounces-311047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592B4968449
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9C9B259AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD61D4608;
	Mon,  2 Sep 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+7AkZ7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DE142E9D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271885; cv=none; b=avL04A/0yBnpoXN2ZGq8CrJmLjGpZJrQJplR7mQNHDkdCqGeTAHdk0SS6Rll6c7wRBTuvEozw6BlB62iYlD5rLinajhgYhux3YGwc6mvln0IzpiCGCWlZOerlQTOU9Zz+B2aB9dioYuWHMpInYW0I8GbcrxVlxYvHKC7st7eiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271885; c=relaxed/simple;
	bh=rHSE5GJBbFtpswpn2ChSjpPYB08VFsSB+DaZqumjp5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DToOuKe5PpZzzo6BwsDz5n0UUqa2H8SPDNFDc4tfY4j2HWDFcxzaznz0/bzOtHOtNXQ6c+LIgxDw25rNe0Q1ZGU5dD/+zvP1rcOjER1DVvVoTxQrKcOTeaincdivOUQV/zw+jSXW/I5jZxMFrNBvUkMypb1s/KCfZGvlrtH8Yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+7AkZ7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725271883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uP3eFfEaqOfXTe3+PuBVxVruDu0h3AsswyFqYW83Vo=;
	b=d+7AkZ7My3h9vfc8uFaZ9gDd714EtuoWTsSszzpycRH3EizNZ//LcXjLmZa7Mt4I1PyDSk
	xKGDKFjPX8uk0sFNsQxm16NoiDWR9bnpXUMB5AY510rOI+1K2T+BUI/EXOlFBqJdAN/XXU
	hCRMGXfC902tjZSuku3jYC2TxkXbaeU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ydkoOUdsP5SmK-olH-CjUw-1; Mon, 02 Sep 2024 06:11:22 -0400
X-MC-Unique: ydkoOUdsP5SmK-olH-CjUw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c24e546f3fso1117737a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271881; x=1725876681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uP3eFfEaqOfXTe3+PuBVxVruDu0h3AsswyFqYW83Vo=;
        b=r/pDrS0pqmhPv1hHa27TgiI/Mk2rvUiEFjvkq8bDLRPl1MrgqYOdbVFEpTxT/PM4aM
         leOSY+pFa/FjkTbyQJKHC+QSaIzYq44v3+UJGiBxocqRzsdiSzLglxNN5PnIqEbQG2QZ
         8tsK7UJ/PcBQRl5ITeyE6e/tJ+5ayLQjtOD5C8VUwf3FETx/MyojPpirwtnEIF1O6KFX
         jwB1hDFil9h7F8ububIBM8fRV0xNGzP5gj6YcIUewpyt/AORWQHxVcTwaZBLqGAt4y5/
         hNOJbKgZBAdwFz9XLE/tDIi1caASi1WRN79wDskzM/u1FTWrmiOPSMR7eJPvqwXZJjDq
         INGA==
X-Forwarded-Encrypted: i=1; AJvYcCUuKiH+Z8mgJF2Mpqha2vFFkxN5Fw0KL01JGCwN5vi4Ky2dO9z9aSuxwpV1ab+I5/p2nYO7N4zShW2AzlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6SDKG5KOv+rKZOA8lffbeQ1pguvv4UmtydrMwtmMDX0MbyDN
	xP2OAkCZcybadHHitVbClSRWsAJDl1r7aUtT9HRq/Njb6pA/dQIuPfC9iuW7Jnx/CUrdh7n+UOD
	7GzNfvOjlBuX3TPS/TNvDzLOr7hJzycfqA9IZmMABGZq5u+2KxISGxPXN0NsZYA==
X-Received: by 2002:a05:6402:90c:b0:5c0:8ea7:3deb with SMTP id 4fb4d7f45d1cf-5c24236da8bmr4462237a12.22.1725271880836;
        Mon, 02 Sep 2024 03:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTNBBa/kEMoVHxbKZbEtOLcOUPpssqmcz4rwny64KU9r4Q9jmk4fhy7UbqXupII0EuIlzR+A==
X-Received: by 2002:a05:6402:90c:b0:5c0:8ea7:3deb with SMTP id 4fb4d7f45d1cf-5c24236da8bmr4462210a12.22.1725271880367;
        Mon, 02 Sep 2024 03:11:20 -0700 (PDT)
Received: from [192.168.171.203] ([109.38.145.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c24e5f0aa2sm2286373a12.85.2024.09.02.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 03:11:19 -0700 (PDT)
Message-ID: <65d131fe-952e-45f7-9284-652c23b6abb6@redhat.com>
Date: Mon, 2 Sep 2024 12:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: atomisp: bnr: fix trailing statement
To: Kartik Kulkarni <kartik.koolks@gmail.com>, mchehab@kernel.org,
 akari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
References: <20240731103353.39245-1-kartik.koolks@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240731103353.39245-1-kartik.koolks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/31/24 12:33 PM, Kartik Kulkarni wrote:
> Fix checkpatch error trailing statements should be on next line in
> ia_css_bnr.host.c:48
> 
> Signed-off-by: Kartik Kulkarni <kartik.koolks@gmail.com>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans




> ---
> v2: Move Signed-off-by line above the exclusion block
> ---
>  .../atomisp/pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c      | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c
> index 457a004e1..b75cfd309 100644
> --- a/drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c
> +++ b/drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c
> @@ -45,7 +45,8 @@ ia_css_bnr_dump(
>      const struct sh_css_isp_bnr_params *bnr,
>      unsigned int level)
>  {
> -	if (!bnr) return;
> +	if (!bnr)
> +		return;
>  	ia_css_debug_dtrace(level, "Bayer Noise Reduction:\n");
>  	ia_css_debug_dtrace(level, "\t%-32s = %d\n",
>  			    "bnr_gain_all", bnr->gain_all);


