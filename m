Return-Path: <linux-kernel+bounces-261839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237F93BCC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C63F28115F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1228616DC0F;
	Thu, 25 Jul 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6rwL/Gk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A16D9B7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890506; cv=none; b=ETLU4k6fB4ciVWD7EmpqP2GF5EVpEwcg/Gq3KBiChOnTHFWjg/FXTyYGY7rF23xWrhxLEbbTkRIjKdQMc/iV74LOBgdAm7UZnzWXJi8hD+lQuOtAtfAFLSXxrdBeqPgXbAIySNBSAROAsMgeQbDOZmpp2HVbJl8W9RqCaWxYwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890506; c=relaxed/simple;
	bh=iZkJssa1HPux1cfO7DzXuQvvHYerkUKMKDTMblmlv0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcr0suS1nKrv2VmDT+bBO2SrrcM0zd/PL6zVSyGztD8LzrwcYEg/zuRgYzh7V0RIqGnXZVm8Qj8w8Z7pXhrd9eplPsAGOV3GrwY/lPGDL0WPDb1m2JuZm/4t2GyCNk2raBNnMpBtxPPMqd1BjpuUGlgnv72j1PxaaDfpVLR+J0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6rwL/Gk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so2972555e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721890503; x=1722495303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuTN+kDGENu6xXBj1NgEgyRLozzKhv55rcnYOX8KmhY=;
        b=E6rwL/Gkqudc+r4hZEYi4xu3khnNhMpNJRfJHCocFaZ5h1DYa8PSTd3V/r4WiSKk9X
         mIPfPdYadttoO8CKjbkxSPZtEQZ5zrFHpEsWEMdW9zBfrcjUBUGU7Bxnms6C4N7Uw1Wk
         ydFLzH9M2p2ilHsYnkxFryoRV9/ARnOHfiOdoLAtX+J5b5WRhph2xae9/FA4ZaSlf/Zh
         q4BAWk9G9kNfMJxhs8TPMuk3pb4LL9meDvGRNV8fAh2bJWHxOJivCgzNN/2AB+XiALG4
         vHTsw5fhZSc3lTwpk6Q98mmL9eGlSNl7hODPXSWwowXLnT/OUdhrhmFMiD6qF75HFhDW
         /3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721890503; x=1722495303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuTN+kDGENu6xXBj1NgEgyRLozzKhv55rcnYOX8KmhY=;
        b=vAvhlztfAi5YCRr4PiLuxa6QS4J2qKOWmljos/TQocQillyCPfVl2WaX0KtVs4oAgZ
         bgOzRMyu6JPjNTvHFs7BGusLzJTo+10IzRyqQ3m3fgr4o2vXJA54ujl2Az3MN2rVf+ju
         WdasKPx0GTYNMMSFF6E+5LmA8YdeEUY46MhOH5DxT6aOxP/aTjlS2b05bJBjHejRwbAC
         FqZnf6JJ0Ahoep3neApsesFIF57dmhiUYGtKEuuygKfeyGB6Xdj1EyUBDK7QfooPlgp7
         Oa3MY3e8nrLkMwkTl6QmiOmihN3PINEQJEaQgJwzcKbOiauG2S4yfalzFpyuWG05rvAd
         +8+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH/g6hwE2HGfKon9EvDafj7HjyuXX9yKqjhbHucP+KQiUFFDUEvOszuEJCybm5YvFZnri8jToBRcFhIK44Se2bNul50sUNl7+kF8h2
X-Gm-Message-State: AOJu0Yx3we7PX4BrNdgMReMZPGKU61vtRah8Nt4A8XxIrktn3jgmEzdg
	LxAQ8icbaaqiKeZ7ndAueLGGAFZj/dg+LgEezywSyai1nDe/2/yF
X-Google-Smtp-Source: AGHT+IFDb4sD3pOsedkk0/LWcAY+LieYVY8mqTFh3+iKOmjF2aCcPCDJSzJfeDUWQWKsLRFm3/Y0fw==
X-Received: by 2002:a05:600c:3147:b0:426:64c1:8388 with SMTP id 5b1f17b1804b1-42803b5b18fmr10801735e9.17.1721890502686;
        Wed, 24 Jul 2024 23:55:02 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f92c7cb3sm61764035e9.0.2024.07.24.23.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 23:55:02 -0700 (PDT)
Message-ID: <d384eb76-502c-4a46-9aa9-44671440b417@gmail.com>
Date: Thu, 25 Jul 2024 08:55:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] drm/amd/display: use swap() in sort()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, harry.wentland@amd.com
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.07.24 um 09:37 schrieb Jiapeng Chong:
> Use existing swap() function rather than duplicating its implementation.
>
> ./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c:17:29-30: WARNING opportunity for swap().
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9573
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c    | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> index 717536d7bb30..8e68a8094658 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
> @@ -7,16 +7,12 @@
>   
>   static void sort(double *list_a, int list_a_size)
>   {
> -	double temp;
>   	// For all elements b[i] in list_b[]
>   	for (int i = 0; i < list_a_size - 1; i++) {
>   		// Find the first element of list_a that's larger than b[i]

While at it please also replace all // comments by using /* */.

Apart from that looks good to me.

Regards,
Christian.

>   		for (int j = i; j < list_a_size - 1; j++) {
> -			if (list_a[j] > list_a[j + 1]) {
> -				temp = list_a[j];
> -				list_a[j] = list_a[j + 1];
> -				list_a[j + 1] = temp;
> -			}
> +			if (list_a[j] > list_a[j + 1])
> +				swap(list_a[j], list_a[j + 1]);
>   		}
>   	}
>   }


