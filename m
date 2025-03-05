Return-Path: <linux-kernel+bounces-546671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A079A4FD84
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6273AB287
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08311FECD1;
	Wed,  5 Mar 2025 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMSTyuZm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89913226D05
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173756; cv=none; b=HSQSsPiB/Dz82YUVpdeQ5UYLbIoWQtU2NABuKbAlFmGl3bTbSa/rsqKr9kvNUd8iA7TfDVttqebtR7//UzzhAZq9eW2usonj7SlHijhn7Rk4o/PPBHu2NioC0iMyrir1N8GM9jTe8KsEd3AeVMwsqvBWeydqTTdJJpocOyQmkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173756; c=relaxed/simple;
	bh=/+L0wAOKozUodZ9tTzm3767cEww8MplolxX07nvX9VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uy0VFu3aodLbhH9glgyXK0t+muoWqn08rCZmwK/i3LGgbtsgHJn7YgFQpmKNwoA3wOe8wU7E16an4AuPs06N9wcEGyRk3JPa0LvN1OC/HgqO54M3reZExmVvOsB1KC76vSt20BYfxgkX97ngGEY5AF+GPf6R9rcRCieXTZGD7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMSTyuZm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741173753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0gZVE/AeQPIxGT3xE3l9BJh5bFLtI7lvrK9jIYDx2s=;
	b=WMSTyuZmkSbr49raXMQpFUJ21MH7Nr1jxB4IRUIs8jZsofUzaLj4VBpUp//bdxZ0O51Y9p
	9PCJdUyfI/kwvZEUZ+Ddsjy3NWXlPtUvxznUns810zJr9AR7sY5eEFv+iNXhbzsaHtIQes
	IkU1GnO/Viq586S9lsgXVloLUbHvEi0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-MdYRlPw8P3Kch-duwUT75A-1; Wed, 05 Mar 2025 06:22:32 -0500
X-MC-Unique: MdYRlPw8P3Kch-duwUT75A-1
X-Mimecast-MFC-AGG-ID: MdYRlPw8P3Kch-duwUT75A_1741173751
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abec83a498cso691638566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 03:22:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173751; x=1741778551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0gZVE/AeQPIxGT3xE3l9BJh5bFLtI7lvrK9jIYDx2s=;
        b=fgDV4tSan18jVtvWusZ3U5Wch9EguBVzcGEZxHWROGzii3LES4guyxoPvn64PkgjPx
         3Es+nsZhyeOezkachpS+loD5iTgJwTVttZlEW1F0k6rVToebyLalmrMZm3kqihvsXom4
         CsISTLyEnsgUHpd8a1FImrflGRx76aLGLWw4mwqvsBOrEBHnQqtVXiIVzNNPED4OnAVC
         nzAO7CjPMKy9U2Cdd3FhOHgst1THdZ2vjJ75umrEdTk6gI9R6Ewh17vgbsClGrEPeLPB
         B0FxF+bP4psOYoCRZJda4PauD6jRVlsaT+SwgaGyw7IlB0GxtgD62jMfRWmksMGkSrkt
         F3JA==
X-Forwarded-Encrypted: i=1; AJvYcCVrALK6bMVG3/bPAwiWGYpToIzGPAU8zo342sLMzNcgucSoscGSJA6mv+5/qz93tiVeztD92w9SXBzWwQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznR6ZrVyX7B7JlSSLtD8sL1Vi2xQXIdGbv/YsW6Ux/dXK4D6jc
	EqzW3PQJ7rpJ2QwspLwtWsbIE2HeMcRYb66nbPp4vXbevB9P7t7riJsxlZbBuW8emz4+IQIMySg
	ZdqjhgtzKTu7U7HVk4fqyQ+W3AXvoxxYqdq7qlvXtSYnDvnI3rN02PuuQ8jFu9Q==
X-Gm-Gg: ASbGncsw4nTg8P3hwSp84BbN1vpolHU7mkqHnPZIBekrc9zjuGN4UkpjnrseBTU1i3M
	fKF3DFI6DN19eYRHw/Hg2VrSIn3L2C/3hDYRMLcyipXhCwFgQuCYqQusA/2YOCOaWzmaEYFX0F8
	bPD51yCmru349D9Jt4o7OgxcOfooR2XB33Wwb5oPSVeoDE2qhWTAf3wGf6b7ev+na1o183YUj57
	Hb0Yg7OnPkrLWW7SoyrzpfTD9h1Jjvad72F3Ti3u+phihpLaQ+ikar7TZfuUziFA/m3gfKMZReJ
	tjnck9RG/xXxNjK1Ms1qFcOxB8sIXpQH7o+P8G6P2A2FEYqEdZw83ijU2QDwPFFsXuXgN1H7JCe
	M5JWsoHHnEHnxyBr0iDFGB3yg/d0PApqSmzVN8wx5/d6Lc/I9mxl9BmMLCJemQdpTeQ==
X-Received: by 2002:a17:907:c283:b0:abf:67de:2f21 with SMTP id a640c23a62f3a-ac20d9f39bamr225421866b.22.1741173750840;
        Wed, 05 Mar 2025 03:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEwTypJN88Dnlriv+HlSev8Xp7KW80Pj6JYPkkT/a/MYDOAa511GjrMO140U8EH2tn8E3w1g==
X-Received: by 2002:a17:907:c283:b0:abf:67de:2f21 with SMTP id a640c23a62f3a-ac20d9f39bamr225419766b.22.1741173750414;
        Wed, 05 Mar 2025 03:22:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b9956sm1131748466b.16.2025.03.05.03.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 03:22:29 -0800 (PST)
Message-ID: <ecb132a7-40e9-4f31-9a03-4abcd6d0b1a1@redhat.com>
Date: Wed, 5 Mar 2025 12:22:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86: dell-uart-backlight: Make
 dell_uart_bl_serdev_driver static
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304160639.4295-1-ilpo.jarvinen@linux.intel.com>
 <20250304160639.4295-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250304160639.4295-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 4-Mar-25 5:06 PM, Ilpo Järvinen wrote:
> Sparse reports:
> 
> dell-uart-backlight.c:328:29: warning: symbol
> 'dell_uart_bl_serdev_driver' was not declared. Should it be static?
> 
> Fix it by making the symbol static.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/dell/dell-uart-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-uart-backlight.c b/drivers/platform/x86/dell/dell-uart-backlight.c
> index 50002ef13d5d..8f868f845350 100644
> --- a/drivers/platform/x86/dell/dell-uart-backlight.c
> +++ b/drivers/platform/x86/dell/dell-uart-backlight.c
> @@ -325,7 +325,7 @@ static int dell_uart_bl_serdev_probe(struct serdev_device *serdev)
>  	return PTR_ERR_OR_ZERO(dell_bl->bl);
>  }
>  
> -struct serdev_device_driver dell_uart_bl_serdev_driver = {
> +static struct serdev_device_driver dell_uart_bl_serdev_driver = {
>  	.probe = dell_uart_bl_serdev_probe,
>  	.driver = {
>  		.name = KBUILD_MODNAME,


