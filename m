Return-Path: <linux-kernel+bounces-510938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20FA323D2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C901635EF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7EF208964;
	Wed, 12 Feb 2025 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V02AFA3z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FC2AF19
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739357288; cv=none; b=fPkWiVVyzcRxcjfQk2DKsmedHnN08UaRWEGgYoF9tvMth+S8TWP5YwsldkgpXH/QY0eOr6PtQxskQi854fIrm/F39DUKrmlILIIj+7HMMArJ2iKDQU/3pT01s/pugguB3icfCoO2c7LpEtlyUWTVgCYMSdTyGJWQq6rq0PZh3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739357288; c=relaxed/simple;
	bh=OMmze8X9oAlajdV8Foj550TjMw3mXVnIoItA51bBYHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkDweVNyWrQ+Pt5QdYBE8/AtyGjb0qbD7uim0f+XrnQn5tF1u/sUkgYsy34MZEO6kmJj6OMw5H3ePCUiUG3okFRuy6vSdhpALn5LfzFD3TNhHXf87w99SC+/EIG6IsBkmfRS7uLpYd2LxbjS7emGdAdFDtmpo20yWMv/3/GaFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V02AFA3z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739357285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fsMpkvryDt2LzZ0h4OPEHC7XVpjdmg/PwbED44BwIQ=;
	b=V02AFA3zMsJrhAFwRteucEjdMdyeASW9HmwV6KwhE/8VBv6Ahc25Pn2aB5p1CJxk3ZlbSx
	E1HctArkouPHh+N/G7J1t2QQ0jQXDp2+fMIzoLhm+elmhuCSHprIsQmlxKTVNGGx8Nz2Gg
	eeijQDBuAyCXlnHnp4bSavc73FbGMmM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0xeAW_bcNP6LbElmtc9Thw-1; Wed, 12 Feb 2025 05:48:04 -0500
X-MC-Unique: 0xeAW_bcNP6LbElmtc9Thw-1
X-Mimecast-MFC-AGG-ID: 0xeAW_bcNP6LbElmtc9Thw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab7cae13359so74941266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739357283; x=1739962083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fsMpkvryDt2LzZ0h4OPEHC7XVpjdmg/PwbED44BwIQ=;
        b=xGVMCe7OeMW7Ts4XLtEea2Rh28esrqsb0OMm2ykfcWsxG1/NcPA0ygAZmUVjGCK7Ho
         5mdN7dpundp0UbOGSvsk+J5rRhIJO09FXXoiAwj2yDpyNJ9CQ0NeB5Db6pG8sLNImtgB
         5FtUQgDIE7SCT0LtikvBKxFbFuQ11sIwRpLMOaSxTwjLVLiwHix4iX4mPFwwQU6CCaNe
         SKJk5eAV7FLRbm67XYb8xL+rV6Y5/q4DrHMh9jJdx5fbFlUOg3NhAbbXLVfnfZZzY6XV
         4utmIXQTU6bFLnMRJTvCCj18ZdeaYG6XSmtJSEM7in2e6/BLW4eimmpYKirJxCDL7Gmt
         sf2A==
X-Forwarded-Encrypted: i=1; AJvYcCX9DY9pmPq+jbi6PKc5i6qJBHpMuhwcIxSaksmDqfZsMx2zs1W/kNepusAtPTfVRA8wPV7GQIiyZ6ksZGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7bZy3WViYHy4+cArDFztjDWvomBHXlrvu1ZE4aR+1m4cqbYh
	eJd6MazS/BGv2/ZJVyrFGjFN0hsAsXxcNbC2hAVDZ046oaz5NpX2aF/zh9x/Y0u+yYrzmd2vEAv
	EdlZXhr8Mv1qVc3wBdrtsEsIfzntQ+Iz8Uf1/nXAmDKn/1GIo5GJ0/Q03eTfuCQ==
X-Gm-Gg: ASbGnctSEoPDWWeIHbUnTN7Wl6uE8Kps8T5RbW8t0M9wKzU4MZv7NYefNiBT8ZdFvzi
	FaZFGnuw1BiG0fAURXTGrQR7c9l4G4D4rKCILx9gSPXz2oV2y234/771E2MThKuQP9xkhtU/rJC
	Cwc9QbuLxSli2zGFbv926jZLrkXZF7yktvVSqAHoU7zvAe7s0ausU3KNSAcyKnGf3AkalAAIrn3
	x0RHKgBVmh+BsRxg9oBgSJmqVQo6CKt57B/P+5l+1rIK0sTgPuI4Zn/oHXdvL/LX4YQqMKkPme4
	SLpItalCgl1/7iCdjhMwOc9Huv7ZxSJZtf35aYDdcW7Bj2OVzrjoM9SfpTLT065cnbX2esoJG0K
	dJ9iPpWJH+OMZFv/slnrVd7jzl3hZAmo5xamaUAqhYAZ+FFg2PFMW8Iw=
X-Received: by 2002:a17:907:1c29:b0:ab7:bd8c:3501 with SMTP id a640c23a62f3a-ab7db35bf15mr680650566b.18.1739357283033;
        Wed, 12 Feb 2025 02:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkdB7Pi0J1+nM7qlAaDy/GDdKVi9B1YckCYUNv866WaVvUJfQA1SBNJ+NyM9ozbis0yn7i6w==
X-Received: by 2002:a17:907:1c29:b0:ab7:bd8c:3501 with SMTP id a640c23a62f3a-ab7db35bf15mr680648966b.18.1739357282577;
        Wed, 12 Feb 2025 02:48:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7f6064185sm102447366b.175.2025.02.12.02.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 02:48:02 -0800 (PST)
Message-ID: <eec5bb5f-80ad-469e-b3bc-1e8bb2de36a2@redhat.com>
Date: Wed, 12 Feb 2025 11:48:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm: panel-orientation-quirks: Add quirk for AYA
 NEO Slide
To: John Edwards <uejji@uejji.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Andrew Wyatt <fewtarius@steamfork.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250124204648.56989-2-uejji@uejji.net>
 <20250124204648.56989-8-uejji@uejji.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250124204648.56989-8-uejji@uejji.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 24-Jan-25 9:46 PM, John Edwards wrote:
> From: Andrew Wyatt <fewtarius@steamfork.org>
> 
> The AYANEO Slide uses a 1080x1920 portrait LCD panel.  This is the same
> panel used on the AYANEO Air Plus, but the DMI data is too different to
> match both with one entry.
> 
> Add a DMI match to correctly rotate the panel on the AYANEO Slide.
> 
> This also covers the Antec Core HS, which is a rebranded AYANEO Slide with
> the exact same hardware and DMI strings.
> 
> Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
> Signed-off-by: John Edwards <uejji@uejji.net>
> Tested-by: John Edwards <uejji@uejji.net>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index c5acf2628..9e6708cd1 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -244,6 +244,12 @@ static const struct dmi_system_id orientation_data[] = {
>  		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
>  		},
>  		.driver_data = (void *)&lcd1600x2560_rightside_up,
> +	}, {	/* AYA NEO SLIDE */
> +		 .matches = {
> +		   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		   DMI_MATCH(DMI_PRODUCT_NAME, "SLIDE"),
> +	},

Since this '}' is closing the .matches initializer it should be indented 2 tabs

> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>  	}, {    /* AYN Loki Max */
>  		.matches = {
>  			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),

Regards,

Hans



