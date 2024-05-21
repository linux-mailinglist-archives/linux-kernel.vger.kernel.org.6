Return-Path: <linux-kernel+bounces-185168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 488168CB180
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CBB1F2329C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C584145A03;
	Tue, 21 May 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GODuF1Mb"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5767446B4;
	Tue, 21 May 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305808; cv=none; b=lYngpgkxYCiJpIpYfnKFJPw/CLPbMHHyAgkhip2HIKQ+MA7UponYnTxgeXFLKTWb+xXDB6XhuesMTPeqYnAMrmzhp4NwB/jAOVksdh9MP+b8F9J3IceGXJ4sMi9gM6sLjyZwNx0fRZnKolm9S0kRa5rRi18wzN6hVlLPPn5KTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305808; c=relaxed/simple;
	bh=Qhlpp/9gxnvCq3s8M76hX0jWF3LlDce4Gq5tP9cjHrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ktz22Rbg6kRBE2CTyT9aX1xSTOLcwIjEuFp518fucesH1uhUFGmmIb72bIrfhzZhR/FPN+plM/dEThE+UE8H1FRuAlKG8PLW0UyPTUg9rKdD2oufuaI8Q0zQLW+Fs/9vD0lspE2Q2GeK2PcBF/X9t68FqOZL6v4MN9OxofbPI+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GODuF1Mb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4202ca70287so24325415e9.3;
        Tue, 21 May 2024 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716305805; x=1716910605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46MBRG1SoxQr9SxFCn07JGJ8jdLms6wT8cP/QcL3Nhw=;
        b=GODuF1Mb19cJHukZgQk1Qr8Ja6dO6jfxtpfsX3jWR+uiC46V/R2ij/HYLVvHjugRFN
         FH0D0gjVDo2dJs9/hY6oOPGjpMYBSai9wjFZw4i2Dn+ysWyorSFOKSw0TkyFqQcuvR1X
         aLZQKc/vlxN6ruFvi4yi06o7WW/p2UGKR9uXbEG04qEX6VMMSdvamVG7L6rQVLsSUv3M
         rU689CabgNGKm4NS3yCKR5xL/7hRKOD++9DlbNaBAzFEB5lAJWKcDiHte99QTByjUtVc
         SQRl9rXmv+34hUSvkJHmjqxqOtsGULiH7LR/tFmyEVLyV8DuFnBcjZN1Y/x129BzqM2D
         tGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716305805; x=1716910605;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46MBRG1SoxQr9SxFCn07JGJ8jdLms6wT8cP/QcL3Nhw=;
        b=ntsOlPrIx5I1PyrA+9NkQ2E9d7Nj6p4PDwKVQiwsmCMP2fB4oaAXoOuP/lLg8Y3GJb
         JFP7H0A3J4oJkEZiOjMu/TyAGsqkDRevUKIK3+zd2F8J/ORDX74xzak9oKWKJK91UoIy
         XGFRzdtVJM6KvAxYCK/53bqDqAGCguPOgXENmiJDjmpWNpgHV8ndhoMG0eeUFOabbs/q
         BxglRTcDPMbL0+oK1w/WCBmYG/ZKo/qpQlU7kNep3kWiDdsIAxr+0ujsQPoMSqRSygqL
         Idk8Z7FQ4ZfPIUF91+TL849D63FTf1rCIGfIMMagQcvv2WliW5/m5hBgqYDXy9mDlGgQ
         05JQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2T1gv87YR8q+4gZWbmgXP3udLr/4MUFw9H6vEyui3eI37Qk34BGwZmZsWFlUgV+KrIqUgZIXr1J+mn09pgDTLf3ZLuSm9D3wejeq233o4H8XOts/8afoRLGXCwVC0grcoJCY/7CDdXA==
X-Gm-Message-State: AOJu0YzTjFmLLwMNS6tpdIDDi7/yiT32h7LDgPoQe6a83wg9aXUvIlDb
	MSd2jEGbs0cq2NONa5df2ABAa+bA3LraY4KLgnjSsma4l5s3Bvs=
X-Google-Smtp-Source: AGHT+IFi6H7xCiBQJNeJFOntXvHJMi8HPJVCQ5T8EDXf2/2DlOHcElz5RxvKkaL/QDJl/17ygKhYrg==
X-Received: by 2002:a05:600c:1c9e:b0:420:29dd:84e3 with SMTP id 5b1f17b1804b1-42029dd8829mr162105465e9.26.1716305804872;
        Tue, 21 May 2024 08:36:44 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:a828:7263:6693:6f6a? ([2a02:810b:f40:4600:a828:7263:6693:6f6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42010940845sm391038675e9.35.2024.05.21.08.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:36:44 -0700 (PDT)
Message-ID: <58ddfc8f-1995-4f41-9d63-35a00c6f92b9@gmail.com>
Date: Tue, 21 May 2024 17:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] drm/bridge: add common api for inno hdmi
To: keith <keith.zhao@starfivetech.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 xingyu.wu@starfivetech.com, p.zabel@pengutronix.de,
 jack.zhu@starfivetech.com, shengyang.chen@starfivetech.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-3-keith.zhao@starfivetech.com>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20240521105817.3301-3-keith.zhao@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keith,

thanks a lot for working on this. See some general remarks below
Am 21.05.24 um 12:58 schrieb keith:
> Add INNO common api so that it can be used by vendor
> drivers which implement vendor specific extensions to Innosilicon HDMI.
> 
> Signed-off-by: keith <keith.zhao@starfivetech.com>
> ---
>   MAINTAINERS                                   |   2 +
>   drivers/gpu/drm/bridge/Kconfig                |   2 +
>   drivers/gpu/drm/bridge/Makefile               |   1 +
>   drivers/gpu/drm/bridge/innosilicon/Kconfig    |   6 +
>   drivers/gpu/drm/bridge/innosilicon/Makefile   |   2 +
>   .../gpu/drm/bridge/innosilicon/inno-hdmi.c    | 587 ++++++++++++++++++
>   .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |  97 +++
>   include/drm/bridge/inno_hdmi.h                |  69 ++
>   8 files changed, 766 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
>   create mode 100644 include/drm/bridge/inno_hdmi.h
> 
...

> +	drm_encoder_helper_add(encoder, pdata->helper_private);
> +
> +	hdmi->connector.polled = DRM_CONNECTOR_POLL_HPD;
> +
> +	drm_connector_helper_add(&hdmi->connector,
> +				 &inno_hdmi_connector_helper_funcs);
> +
> +	drmm_connector_init(drm, &hdmi->connector,
> +			    &inno_hdmi_connector_funcs,
> +			    DRM_MODE_CONNECTOR_HDMIA,
> +			    hdmi->ddc);
> +
I really don't want to anticipate bridge maintainer's feedback, but new
bridge drivers must not contain connector creation. That must happen
somewhere else.
Also I'm neither seeing any drm_brige struct nor drm_bridge_funcs, which
are both essential for a bridge driver. I don't think moving a part of a
driver to .../drm/bridge/ makes it a bridge driver.

Regeards,
Alex

> +	drm_connector_attach_encoder(&hdmi->connector, encoder);
> +
> +	return 0;
> +}
> +
...


