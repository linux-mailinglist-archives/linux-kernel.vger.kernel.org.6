Return-Path: <linux-kernel+bounces-410823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9FE9CE165
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BA5281DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE651D0DDF;
	Fri, 15 Nov 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIZb8wdN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F11CEAD6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681360; cv=none; b=n1TPz7/5p4Ngd0Ljwh4JDxfylxEEEPFV5+Hc/rAL3VttKMlDDbUZCssfGOA3XncTLNUmrF26q4JMy2cFPHtRjpcWJMPY7yiDFXHr/49m0mJp8hT2Ea3DwO4BHhVRSxcrLA/qpYtIy4UngX9fJ5W/sXQRAwqLybAS/N5m2pTwkzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681360; c=relaxed/simple;
	bh=pwP3Yudtxmufy2mppfZAjBzhfUu8E5bPcMUj5XSIbmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5YzSDr1duJzbDqmYPP/kCBpseWzFNghQL9E6hX0hehYF2QTEDKISoi5t+yEB+uuhtHMtzpzrM6agx4xJMduEC8rM2dVho1GTEJWGfZDPHRAFF087O/z3fR0vrzXbXy9C3AC3mAEWbNxg5PwYXolNKaMTwYWWa6zdalph4o33Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LIZb8wdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731681357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hG6xLxPh/x5Oj9/65JNNs/XoNai/htMbWRdFrzW0cYA=;
	b=LIZb8wdN8BWu0xYvxjo1ByBlCMJIbF4LwMNV52Bs78NUSPev/3IyZewMLgOtgg8Ochjefj
	oQgKP0Q4VUaKCssZPHgSlvDHO/7qe2t7J5j+fGid4wjTYcduyPZomB2GAkpAVnVeTVn0HU
	fUkT6VR3wkZZvORmHSrL9X45HDnPdEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-0zJGdzkpOfSoJJUq1a3wTQ-1; Fri, 15 Nov 2024 09:35:55 -0500
X-MC-Unique: 0zJGdzkpOfSoJJUq1a3wTQ-1
X-Mimecast-MFC-AGG-ID: 0zJGdzkpOfSoJJUq1a3wTQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3822f550027so103454f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:35:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681354; x=1732286154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG6xLxPh/x5Oj9/65JNNs/XoNai/htMbWRdFrzW0cYA=;
        b=N3BykhrL2KHttFhdKFXS8FWX/1xYDvmhSNs1wc2kDoXgcnXg7b12Ea7H3esu93Zbsq
         AmS5MxvwxCX+B5SdU8HzsEIGnJZsnRziDG9vpd5Y7KFNRuCKu+FcsJ1U+RNK25Es41J0
         iW44v3uk8R9oWPumTUd7XU906m5KTQtjkxPPu1jmSHOgdaSQSlGuq9uyYTWD6Zv19dX0
         llx/BlUHC870jo8DcNAB3Kidk14ar7Z9eKf2JgEIUtjxYmopjzFEwfJWOQMpmn0pDXtf
         Oyn6RtruXi5E0zv0OoitgnS8brxxGEPiV3QQUi7wdP3YcsPOf08YzwFL6w+79+mnhMSm
         xdoA==
X-Forwarded-Encrypted: i=1; AJvYcCWY6+SlE+LyxOWA+nv2SIwlI9f3zUZYK4DVT2LvtyYDAD7HxvVQZvyuyT5foxI65B1MrGGp/7bBspvyYpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVNjRxg28bSkJf+ORizIVdsKjf+zlPBm9Tw96oXDL8qJYfMuW
	HioM/lOQZHyyR3Cr93eK8lEugchI1zw92+iWzKm6LRZB2yZgQqWKCJNfoNruTbScOagSigT/x+X
	dV4TvMYoIDKu9W0NU8zMwvI5xS6TEut5csV4AEnj9ZgAvxqug+7LrGKqs9Q/+3MY/TGpxdw==
X-Received: by 2002:a05:6000:1ac5:b0:382:319f:3abd with SMTP id ffacd0b85a97d-382319f3bfdmr274807f8f.36.1731681353940;
        Fri, 15 Nov 2024 06:35:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEwZG8/3+7a7sgOXiGaxta3MQuTiLXV+EcNr9aAXsXquoYJhyS561B/2ti5A7APdJPgT+2nA==
X-Received: by 2002:a05:6000:1ac5:b0:382:319f:3abd with SMTP id ffacd0b85a97d-382319f3bfdmr274782f8f.36.1731681353489;
        Fri, 15 Nov 2024 06:35:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adade8dsm4560992f8f.41.2024.11.15.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 06:35:53 -0800 (PST)
Message-ID: <4a6d4704-27a2-457a-8b7b-3b306539bc6d@redhat.com>
Date: Fri, 15 Nov 2024 15:35:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/mgag200: Apply upper limit for clock variable
To: Murad Masimov <m.masimov@maxima.ru>, Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Mathieu Larouche <mathieu.larouche@matrox.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20241115141449.709-1-m.masimov@maxima.ru>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241115141449.709-1-m.masimov@maxima.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 15:14, Murad Masimov wrote:
> If the value of the clock variable is higher than 800000, the value of the
> variable m, which is used as a divisor, will remain zero, because
> (clock * testp) will be higher than vcomax in every loop iteration, which
> leads to skipping every iteration and leaving variable m unmodified.
> 
> Return -EINVAL just after the loop, if m is still 0.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Thanks for this patch.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: e829d7ef9f17 ("drm/mgag200: Add support for a new rev of G200e")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
> ---
>   drivers/gpu/drm/mgag200/mgag200_g200se.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> index 7a32d3b1d226..4d65ead63d66 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
> @@ -249,6 +249,9 @@ static int mgag200_g200se_04_pixpllc_atomic_check(struct drm_crtc *crtc,
>   		}
>   	}
> 
> +	if (m == 0)
> +		return -EINVAL;
> +
>   	fvv = pllreffreq * n / m;
>   	fvv = (fvv - 800000) / 50000;
>   	if (fvv > 15)
> --
> 2.39.2
> 


