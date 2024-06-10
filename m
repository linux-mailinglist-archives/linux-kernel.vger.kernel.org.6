Return-Path: <linux-kernel+bounces-207850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D7C901CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905F61F21782
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359686F2E3;
	Mon, 10 Jun 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrKGzo7Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687041A87
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008340; cv=none; b=oRFBli2IOnXqgC9d9OAFk4/U9c2fQaho0eQ0gaid2q1CF2XOScTsDMg3GM6KZs1P06sfUXUJnBqfmHdBuTaW1fBBWLrGp4uAt4/gVnoC10Tv/vpZjunu+6CyNTsGOKbCEw2EdLHo7/HfM0gSkLIWNIUVbXtSEZXGjv14RaxAfZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008340; c=relaxed/simple;
	bh=NMlcYcmuSGPRF4yrItr4CuF2mNzLKhvU6KEPBL0SggE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEGi1u4QI3AMcBcXpmYO3XmgQrN9+G2Q/ih5GcDP9K4Z38sJNUoYTN19HlIBxx08D0N/fCMeIcFk699nJaUPVQjhT2x6SlB4547FPB6uICUr4Fb69L94jf6oLCnvvBNbrvD6vOmDaT2bzChesM58RJFyT1jWepkkDXQj2tYnGeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrKGzo7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718008337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSRcH/8de8I+xRtp7H6QKboIq4H1BR83RocjPY6icfE=;
	b=RrKGzo7QciwVDC+hXcsroVcKDHF8wZDjayiedqd3DvdejgddAywofDEz6JQEDixlgBnl+m
	vvnpETG52MMYm+HFohBQvy6OnUi9+tlSb/ZnyHsSRjmdp0IbGYQhXl56vinVnptblvF5Ke
	/YDMbxwFjvqutgBcmYabwsSPxxFiDeA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-UfG3fbjhNc6kPkSnNudvQQ-1; Mon, 10 Jun 2024 04:32:15 -0400
X-MC-Unique: UfG3fbjhNc6kPkSnNudvQQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6e8aa42033so119008566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008335; x=1718613135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSRcH/8de8I+xRtp7H6QKboIq4H1BR83RocjPY6icfE=;
        b=nUpzseRQ32o04ht+tm65/EqzJ24VyfQXuzCNINyBQK1Y9MOCrFxTiBEBDXTPkL/nPJ
         hbklL+0Ij4eI16vpz8fcbJ1wzTxrnkDacyIbj4nQV7zsJf/bDu/gA6kyjip0oC98cZE2
         gchah398B7D+Etw7gYjoeWg+G52CcQNtIzBzbFaR3XESETutYokneu45+Gs5gFLU0tdX
         LR0TmbQFg7xEJn4k4rhnBdeWSHQqfoXqGocXJPlgNh+MxuKdumwXTqF0THWhl6zQKs+v
         5O3LOioouj1OvOkiZK/UhC3bzuZj6BvGfrNNQZ0SJEvCgTYAlEZogIoVPYzCFsTar5X0
         uEtA==
X-Forwarded-Encrypted: i=1; AJvYcCWRz0Xl3WLhK0jOhNwJoGQU5gCpE0nDehT1sX0K1eOIWb/yNtToOPnYOVvu7UNo9c+bJTwaBSEAHun0OD85dwBRKftKydta54+OrTzQ
X-Gm-Message-State: AOJu0YwSJkJMksffkTMEFQ91sqO4A3rcVMfCVyc0ZO3sbfZIzy3REwUM
	/EQolue+TtZNZ9DmjPkO1/IkJ5mZ2qPw1XWcvscnKaheIisAXPSqP+tIkUThgWfECXCu1S5EWpD
	jIvrsaY4uiar6ON1cTPEuvtyYv+SOalmPMQmWtI8I9nDdqchp2h5gSTR+skyZHg==
X-Received: by 2002:a17:906:6b01:b0:a6f:117c:60c1 with SMTP id a640c23a62f3a-a6f117c6798mr232882666b.55.1718008334488;
        Mon, 10 Jun 2024 01:32:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNdowhmu00ckKngsHHAEOjW9e2OU6ATnmpJMzLrmBT1lN3+KYrPR1LaT6Wx0JstaTndpl+FQ==
X-Received: by 2002:a17:906:6b01:b0:a6f:117c:60c1 with SMTP id a640c23a62f3a-a6f117c6798mr232880166b.55.1718008334104;
        Mon, 10 Jun 2024 01:32:14 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8df2c332sm55431a12.61.2024.06.10.01.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:32:13 -0700 (PDT)
Message-ID: <b5de3aaf-24e4-4bb1-b34a-f9f45efc0eac@redhat.com>
Date: Mon, 10 Jun 2024 10:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tiny: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240609-md-drivers-gpu-drm-tiny-v1-1-6905fe4ada50@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240609-md-drivers-gpu-drm-tiny-v1-1-6905fe4ada50@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/9/24 7:20 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/bochs.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/cirrus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/tiny/gm12u320.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/gpu/drm/tiny/bochs.c    | 1 +
>  drivers/gpu/drm/tiny/cirrus.c   | 1 +
>  drivers/gpu/drm/tiny/gm12u320.c | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index c23c9f0cf49c..d15f4d3baeab 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -736,4 +736,5 @@ drm_module_pci_driver_if_modeset(bochs_pci_driver, bochs_modeset);
>  
>  MODULE_DEVICE_TABLE(pci, bochs_pci_tbl);
>  MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_DESCRIPTION("DRM Support for bochs dispi vga interface (qemu stdvga)");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index 4e3a152f897a..89484f7084bd 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -760,4 +760,5 @@ static struct pci_driver cirrus_pci_driver = {
>  drm_module_pci_driver(cirrus_pci_driver)
>  
>  MODULE_DEVICE_TABLE(pci, pciidlist);
> +MODULE_DESCRIPTION("Cirrus driver for QEMU emulated device");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
> index 0187539ff5ea..07c6640022c2 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> @@ -755,4 +755,5 @@ static struct usb_driver gm12u320_usb_driver = {
>  
>  module_usb_driver(gm12u320_usb_driver);
>  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
> +MODULE_DESCRIPTION("GM12U320 driver for USB projectors");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240609-md-drivers-gpu-drm-tiny-a3370189f560
> 


