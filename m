Return-Path: <linux-kernel+bounces-409686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BF9C9099
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E6E0B2A445
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2098183088;
	Thu, 14 Nov 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bi3R5xqy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3630117A583
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602876; cv=none; b=CD5BkzXc9T5AqzwghScP9cQVJe1dg57quWukTnjcqCUfEFoaFrkq7TOasaxff2niD2/kJ1z/A55C6IDYepovyN/8p20M0wFiyM+95jwFRZ0osWg5PR6SRr7GxgmAELrx6EHKHT7lgAJN4B5qbj1r3ngzuU+WOrKHvEA5Rd5qtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602876; c=relaxed/simple;
	bh=L9QR+Xnt4AuLdQLtfrKZ5nJK2f8hK/iPjxRNWtd2AZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpPm46cmluzUgeZDH2wZG/A8G7pr6F16Wct2aCZlK/ichK3TdAMVcH/ip0/7C8PlQyEs2L/BqiFMO9SJJ9P29qaOMo3DhpQu02hMzpLMkSPAnv2muPtSPnBZD6OBRyT7vCmEM/Hwo9lGanVo8iK1quvgebshgfEHx1/Z9TLeHRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bi3R5xqy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731602873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xt0gEA03H8u8VTaljHFvzZY8AomqqKaL5KraLABqcHM=;
	b=bi3R5xqy+weicsoLWFS/e54g4n4YeGVCYhB3ig9ulpTzxbkLzCsLedsZBAlYMaNz+3XmQe
	nGtcn+c0G2n7v2I5E/znuiV+rLZ26WF55r3lfcP7L+jsnyAB4rIZhovLxe0egVAmdcp/SL
	IJDgw/TgelnUVVBOr6WBI/f9LMlK0Zw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-kluAzSiZOIq0m1hEv4b3zg-1; Thu, 14 Nov 2024 11:47:51 -0500
X-MC-Unique: kluAzSiZOIq0m1hEv4b3zg-1
X-Mimecast-MFC-AGG-ID: kluAzSiZOIq0m1hEv4b3zg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso6286735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602870; x=1732207670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xt0gEA03H8u8VTaljHFvzZY8AomqqKaL5KraLABqcHM=;
        b=plUYq5vuxwbdYMT9yJtUZTazNNYhDssHAEr3mzG0t9F6+rkiMVpv83pzec7SdjOgP7
         6HSVQ27OG9Lxhe43bt4GJWPW5lZFNyXxRbYDSLd4VaplX4QjcE9t8rJ13ScWLaEmdJcu
         E92NnTG+R/i1ysA4W/TIqVJ0PPZ0MZIEOQ4r4iP+C+4pnH6L64y/2opuHdXgK9wYQXya
         CI93cJ2ucWb/uGOyxcILkVazHC4wYbp7cSwJDWcS+m6suFLX8SxT8PIYL9Ffbtc68put
         RjBR5iAZp2TbHTGE7Xrwk+yHFGNuo5H5JLbHFin0VG+sEcpeIdPwX9EXgQhWG79thzKL
         ZBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOtOP2fzaEjsgu616+zyk/23LUxp6FFsG63OT36uCWPRVJx4uBa/eFmBvGPgRevlcVes9Iuvrj8Q72Sz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEcyCgPHxEW4y4pEKltX1tHpeqW/C/hcxnc+hTnWgZDJYxC2TE
	ATY0tt3GuXwdmO1rBrUl731+dq7OG3Mpc8dUT4lrxFIEFi6ye8TxJ1iRPlxDTjc6kG2/uuWFCI0
	6GqhjaUII1ev3o9cpTW/T2C6L8+uG9Binz8rKwc16R3J0oYlSvlKPDtlPcVTP0Q==
X-Received: by 2002:a05:600c:3514:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-432b74fde60mr209807175e9.7.1731602870328;
        Thu, 14 Nov 2024 08:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO6XVDKE6FFt2PaV/J3jbU1cAd/6xYIC/fSOli4LEa0urBBzONnSFV8DMwoGka0LBFFtnxQw==
X-Received: by 2002:a05:600c:3514:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-432b74fde60mr209806975e9.7.1731602869912;
        Thu, 14 Nov 2024 08:47:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265668sm29139835e9.10.2024.11.14.08.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 08:47:49 -0800 (PST)
Message-ID: <a394af10-8428-4d19-84cf-f21ec63f23f5@redhat.com>
Date: Thu, 14 Nov 2024 17:47:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/mgag200: Apply upper limit for clock variable
To: Murad Masimov <m.masimov@maxima.ru>, Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20241111163306.860-1-m.masimov@maxima.ru>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241111163306.860-1-m.masimov@maxima.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2024 17:33, Murad Masimov wrote:
> If the value of the clock variable is higher than 800000, the value of the
> variable m, which is used as a divisor, will remain zero, because
> (clock * testp) will be higher than vcomax in every loop iteration, which
> leads to skipping every iteration and leaving variable m unmodified.
> 
> Clamp value of the clock variable between the lower and the upper limits.
> It should be correct, since there is already a similar lower limit check.

I don't think it is correct.

If the clock asked is > 800000, then delta > premitteddelta, and it will 
return -EINVAL.
With your patch it will instead configure the clock to 800000 which is 
too low for the mode asked and will result in corrupted output.

Best regards,

-- 

Jocelyn

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e829d7ef9f17 ("drm/mgag200: Add support for a new rev of G200e")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
> ---
>   drivers/gpu/drm/mgag200/mgag200_g200se.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index 7a32d3b1d226..4934c27b084e 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -216,8 +216,7 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
>   	m = n = p = s = 0;
>   	delta = 0xffffffff;
> 
> -	if (clock < 25000)
> -		clock = 25000;
> +	clock = clamp(clock, 25000L, 800000L);
>   	clock = clock * 2;
> 
>   	/* Permited delta is 0.5% as VESA Specification */
> --
> 2.39.2
> 


