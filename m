Return-Path: <linux-kernel+bounces-396514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118B9BCE37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CFA1F22D83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A631D63F7;
	Tue,  5 Nov 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzgTSedb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09B1D1738
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814174; cv=none; b=l0kvjMYZUqK2rcceKWDfk6oc38Fgc/iT9asC2zo9nwSfldiIN3CYn0BBpxHzKgOcVsIaxoaNBMZ27mcNMKxAeJV/rk55tH1PSrDNzbz0wlBvXOlbo+iJYJ0q7BGvrJSJcOSiRzkemMtVXVbJmOXTIaFaQ0BnZSHOf9cXnCxpVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814174; c=relaxed/simple;
	bh=VNsFk/VY+IEN3C4HvFRdJUsc670ff/88rJ0xlPEEtXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwHLPejBbcno5Ti8+zXLN57vIU6zdbUvSg+qjIXlBC00GGpEux4MulVqfxEoCzAoj3cynrnsGDP79FrgP3vMtQqxwxM6m+c/ebNhJf0jPPGAecrzpWEFsNny35HBtH3/GwY5NdOH/0gA9ZdzwWfFEGrUmroztbFBkwkia2sC0Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzgTSedb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso48531855e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730814171; x=1731418971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X0LbOpMZOfJ1mTtJjscfxvbSnIthvppCCAm3mmuCY90=;
        b=BzgTSedbUKSXIKvK/IiEKCRk3FrId2xeFmacqWPMX+vEpNfbFvr7RRzouVbe+bqMbs
         +HBQ/1xThxfYd2mBXIEUi2b+OlslgojkR2IQzk9sERD2YCH1CKvyTxCaOQTnqMgHyka3
         /nB3ejn4XwDJbx7kqAabKBaUPf9Jh2FkFOOFVV1ARZiTRAsYXoQWq9AxZ71gzHkpHXjM
         03Cq3sdREd3gUneYwVOqbqFYNVq7QtQArxw6iFhfhrXaKVECqfyXQ03aqDey492porT8
         JjRL0U4h6noHtbw5xQ5uFPdDK4Cry1vsUPBTc4bmsixcj7ydeXENqii7c/msv7Uo+9e1
         xl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730814171; x=1731418971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0LbOpMZOfJ1mTtJjscfxvbSnIthvppCCAm3mmuCY90=;
        b=BdY/89dIfowc0IFaa5iKKSklRnLsJgJKsl83dnSyOiaMNPwVBIF10Wf3Dx0gfGqo01
         e+3PUNUWAvb1qC/uITn56gRadNuPCbfKh1OgdAuMxC03HWFjHaIYdC17VfV8tbM8RmZ6
         DcGFwkT73Xu3eGUjCHnc8MOjc/AN7NTBAUi3qahGuKmO8ehry12QEUhvMcZGUhhLBael
         snowTgJUwKmD/pdFN1Eid+91A5PwBX+dpMjv1TKlPAxkVgFhYzlXFjiok4mzFR1Mabh+
         wiEyEfR6s3yQzU4oi5/pjjHrNrtiORueFjuxuBbAXwlKzoZyD/L0eSgblo5qJGlqw8bX
         jCqw==
X-Forwarded-Encrypted: i=1; AJvYcCWL6f+TwCSAQPpVcLY3/GmdqxFlgzIFaRLA5AJSrgTtn9qFsaF3QfJsLlzF/suGmzhofiOviNE9WG37DS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbuZOgUXQsFRme6YvrJsUDkvuXvQHuM26GV8+su2+L+jFmdERO
	HcGfoh8U+rpPzfj4mlCCfCXvjV8yfwpFlNfpi1l2RV+vtEyUkNCrdG1T5qYa
X-Google-Smtp-Source: AGHT+IGSRpiVtLmnl2SvsyIOgr8V4SogtNxBWIzlwsHXFZC77En47v/x605qfDqc+TKFF3urgB6Drw==
X-Received: by 2002:a05:6000:21c8:b0:381:c7b7:706d with SMTP id ffacd0b85a97d-381c7b770a1mr10846876f8f.27.1730814170864;
        Tue, 05 Nov 2024 05:42:50 -0800 (PST)
Received: from [10.254.108.83] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e725dsm16275267f8f.56.2024.11.05.05.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 05:42:50 -0800 (PST)
Message-ID: <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
Date: Tue, 5 Nov 2024 14:42:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
To: Jiqian Chen <Jiqian.Chen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-3-Jiqian.Chen@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20241105060531.3503788-3-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 05.11.24 um 07:05 schrieb Jiqian Chen:
> VPCI of Xen doesn't support resizable bar. When discrete GPU is used on
> PVH dom0 which using the VPCI, amdgpu fails to probe, so we need to
> disable this capability for PVH dom0.

What do you mean VPCI doesn't support resizeable BAR?

This is mandatory to be supported or otherwise general PCI resource 
assignment won't work either.

In other words you can't hotplug something if that here doesn't work either.

Regards,
Christian.

>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> Reviewed-by: Huang Rui <Ray.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b3fb92bbd9e2..012feb3790dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1619,6 +1619,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>   		return 0;
>   
> +	/* Bypass for PVH dom0 which doesn't support resizable bar */
> +	if (xen_initial_domain() && xen_pvh_domain())
> +		return 0;
> +
>   	/* Bypass for VF */
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;


