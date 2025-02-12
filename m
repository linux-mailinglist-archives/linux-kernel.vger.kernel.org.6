Return-Path: <linux-kernel+bounces-510937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC381A323D0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560FC16045B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F4209677;
	Wed, 12 Feb 2025 10:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvAfAW0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1482AF19
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357273; cv=none; b=dq4bSlxpLkxUsV9NJebqzfMZ2LEnxH6ju/gt2R0YTpwpvToGaBf72AwuEnQKGtnkGEjjBDUkWa/UxDtY1QgjBRwu1IErAzxNIXfleDe4Hb8S+UewMFsRzVN1GOA8ET/ceqkbAYNdW0fT4vaIg+VMGGrWI88YUMohgVM9yjGVXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357273; c=relaxed/simple;
	bh=g8j4CilaLUVrCCWjDHpwjdDMGvZbQTRI6rlTr3qSGGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDCsCfI+sFo4hqpjpiooYZQMM9JaxAYM8tmzqVZKAqBT448ipCr8QVsbzoW+rekskWwD49EFA61zMipoB33FJ1AJ0khx+oZkwNsnrjiGg/eKqjjyCCMJTL/PFCL6lWPzKp0FiKSjx+/HY6n7SJbn5xvhaU8Qh8l/KS8EBEEHGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvAfAW0f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739357270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjdUa3EI6jjPQESFxZ7QAmDE55PpxL5gJTNRXqkiL/U=;
	b=QvAfAW0faU2m2rDi34rBDczaeZ5v+Q9ZINe/YCvgeoNRMV5BY0DsfyqgUQQGtc5Pl5xbDX
	dkt6v9x/NBe/RFoJIFfJIbDL1fOJUFDjJo4ms48SXMNUWHZK+VxLEaFDGX4SKqjNTWwqes
	ffczT8Pc4z/BKROFZDTqPeENN4Ojkw0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-K20bV3hCP8me-6-WGydC6g-1; Wed, 12 Feb 2025 05:47:49 -0500
X-MC-Unique: K20bV3hCP8me-6-WGydC6g-1
X-Mimecast-MFC-AGG-ID: K20bV3hCP8me-6-WGydC6g
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5de5005c0d6so4139119a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357268; x=1739962068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjdUa3EI6jjPQESFxZ7QAmDE55PpxL5gJTNRXqkiL/U=;
        b=hr0sx66Ok0OJipyw63Dnz2q8Amgo2b3/RjedmLXYdgcTniU0k8Vhgzw0HVzo7YiKQM
         a/iFEKYJTSKBXYw9GcP5VTv72mhHGM6YEPcvbBOP1nrd1N8dB7LHjt7/IsVYXF7b0Tqv
         zlTTv7/oNXZP1ZdmlzVrnbb8Y2lJ8DKLWvYSkaIy4EOgU1YsGaq18jv3eInRZeVTkirP
         chzT5KxQnCAXnl59eet4M5vIqzCkW4sAl6Ep2vEW8nff8ZcrBNyJUYcj/k2X5oL4EZJP
         GGLLpKzMLMr8Zl31xHqXpFKOF2jXH9GbhcsVltwabxdskAsCyhmnWp9SDyZ31S1SPL++
         UJuw==
X-Forwarded-Encrypted: i=1; AJvYcCW62ys+PU/lwCvPp9ho8aAxxVH7u4KI0GvTwA8/JFkrw+P6a1NtRGz6qVFo3aIyqCtLbJc6ATrSC78015A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllN7W7+QPpsxmtvH3vjO8VzfoReD7/QvlVKjFSx/6KkX2Ss/K
	m6jp3vLTT7Seikh40AfOAbYRMrqjSz8P12w5AgIbbeV+ayfOicT0tyKsTPzbKEF5Eq/3/en/SJ2
	a7BazgUSF702s5XZO92nqvYv4k5PMDuJP+pFamNiobE9+hAEidAZPfsH9JUfAOA==
X-Gm-Gg: ASbGnctTSHsbsrvxKX+hlY52AOT4ve9IQb29EheHOuGMNU/UXK4Ttmbg/GD8nU6Fwah
	YlxwHbOoWSGgHkSFOV4oVQXJqD7J/5MzIFMRD87qgCtaIGSvo8j6ej/UszoQFg/gO0WkAQQplDg
	cksUArEjkKEole9Fd/bC1+b9kiXJSR/fkNGn8JK2Is1+5YjDm1wqO/pPp0TTsUEEAkR7uB8J9/R
	EXDW7flyrXJMRjTgmZ6xNwqqV0Q7U29sZtQkmZdJSGmvIqdbRNdkMhcAUFSdY0dZCsi59lPDjz/
	iERKrYqY8FJqTyc3cb/RFiwFQF8jy1gyAbKq+8q2CHbsehhdw1asWx4sIchvKCZmc2+ydqnk7z9
	ExobHOAmiAOqZJ40DI3SDXiTegzuL+blWrpWQnYjUEMd+hg+d4P9cjvM=
X-Received: by 2002:a05:6402:4024:b0:5d0:efaf:fb73 with SMTP id 4fb4d7f45d1cf-5deaddc10acmr2533482a12.15.1739357268045;
        Wed, 12 Feb 2025 02:47:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+cfN/r2H+5+T27gFwPIpiEUhEl9EoQtBpdey6qTwiUKTmPoUzMtEHwPD5XLyb0CzEKyhwIw==
X-Received: by 2002:a05:6402:4024:b0:5d0:efaf:fb73 with SMTP id 4fb4d7f45d1cf-5deaddc10acmr2533451a12.15.1739357267633;
        Wed, 12 Feb 2025 02:47:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4f4f4daesm9370661a12.21.2025.02.12.02.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:47:46 -0800 (PST)
Message-ID: <3572b4b0-5d32-4331-b241-567701c2cf7b@redhat.com>
Date: Wed, 12 Feb 2025 11:47:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] drm: panel-orientation-quirks: Add quirks for AYA
 NEO Flip DS and KB
To: John Edwards <uejji@uejji.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Paco Avelar <pacoavelar@hotmail.com>
References: <20250124204648.56989-2-uejji@uejji.net>
 <20250124204648.56989-6-uejji@uejji.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250124204648.56989-6-uejji@uejji.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Thank you for your patches and sorry for being slow to respond.

On 24-Jan-25 9:46 PM, John Edwards wrote:
> From: Andrew Wyatt <fewtarius@steamfork.org>
> 
> The AYA NEO Flip DS and KB both use a 1080x1920 portrait LCD panel.  The
> Flip DS additionally uses a 640x960 portrait LCD panel as a second display.
> 
> Add DMI matches to correctly rotate these panels.
> 
> Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
> Co-developed-by: John Edwards <uejji@uejji.net>
> Signed-off-by: John Edwards <uejji@uejji.net>
> Tested-by: Paco Avelar <pacoavelar@hotmail.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index f9c975338..c5acf2628 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -93,6 +93,12 @@ static const struct drm_dmi_panel_orientation_data onegx1_pro = {
>  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
>  };
>  
> +static const struct drm_dmi_panel_orientation_data lcd640x960_leftside_up = {
> +	.width = 640,
> +	.height = 960,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
>  static const struct drm_dmi_panel_orientation_data lcd720x1280_rightside_up = {
>  	.width = 720,
>  	.height = 1280,
> @@ -202,6 +208,18 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_MATCH(DMI_PRODUCT_NAME, "AIR"),
>  		},
>  		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {    /* AYA NEO Flip DS Bottom Screen */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FLIP DS"),
> +	},

Since this '}' is closing the .matches initializer it should be indented 2 tabs,
note I think we can fix this up while merging things so no need for a v3
(assuming Thomas agrees).

> +		.driver_data = (void *)&lcd640x960_leftside_up,
> +	}, {    /* AYA NEO Flip KB/DS Top Screen */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_MATCH(DMI_PRODUCT_NAME, "FLIP"),
> +	},

Since this '}' is closing the .matches initializer it should be indented 2 tabs

> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {	/* AYA NEO Founder */
>  		.matches = {
>  		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYA NEO"),

Regards,

Hans




