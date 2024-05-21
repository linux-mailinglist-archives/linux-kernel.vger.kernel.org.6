Return-Path: <linux-kernel+bounces-185123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20478CB0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B3A28226C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1343142E68;
	Tue, 21 May 2024 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOfkezcf"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E51E87C;
	Tue, 21 May 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303330; cv=none; b=kChFqliFm6g0RXq3R6NFD4N8ArJjau1QgqqeBYLwhut2BIx9QYYXZ8unjOWmQ/bqghYnzwRGY80b4Z4HnCehA6Kbx7gDhc5UB0TS95oZ8Ijoc7kdQbyEfmqraelchhe9QIr3JzPv6hV0PGrXRfnOC+Y4z/4sWC8Bh6ozr624P+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303330; c=relaxed/simple;
	bh=qQUTdNoH9EJfDz8thyPxG2U8xbgzJYTIMBEe94qzdEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WakNDbMQbYq3gG/+lt1UIsRXldjn8fmXpL/g7ETR8s1wDyVKTb1gn7g4qw6ucH2iNAGoISvO2rsw/ZU8Fq+U9VJttNmInib9L5A2dIC71WnPeXKfeujWGuVzm2O038ilH0QQQZLN24VPdOc33TpOIleYc56l4VizCJ4xrEz6zNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOfkezcf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42011507a54so21157035e9.0;
        Tue, 21 May 2024 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716303326; x=1716908126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgFYEo7mUeHhZiZwJPhoRw4RWn2GtW8/d5ROVxJwNOI=;
        b=OOfkezcf0igVtMcr3btmkT1GjdKAQVDC0vO0yRSjPtaTCW9GVw9cIxlj4dheEtRU3k
         hZLXkjcaEUfMWS730JouJxw3KMWfwBDGwK5R8xjA/0e+RNhQURJWVFGumA+LcsVJF4sE
         yZ/v5AVd3NRfLfTH0r32Benfd3k8pXhgFV8rB61XzaafWadWDj8bLnXKn1R532tnCtEX
         rmkfyAr95x5A5N7jRkhm2kjxXMkk5MKOmK1b439D1M3eRwfBlnZaI/K+g1kx3WV60Sgj
         CBpPTBI01AqXlGXStxjPg+zk4Kj879IkWlPuefCrzNLx675ttY0PFPjOmzDJi3YlCOdp
         lQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303326; x=1716908126;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgFYEo7mUeHhZiZwJPhoRw4RWn2GtW8/d5ROVxJwNOI=;
        b=kUd1XdBt0cVHNOEthKxNs3gwVjrO/3JzAx0XZLbHRPwPH1S6DCmwwiwjXBS5EqNrTu
         KLW1VMHPqSbwTkpUrhzlKL0zYNLNhTlVQYkJrKHhA38i+UJHVCbb7ikRbHjM2A89vkyr
         7bmwSsysQMolYvCdkgucaMLvCs1bhdF5zqsrvXztsSJo9o5IICs51StUGAm+lrtSwRxu
         dnFVEde3mCvikbvth6OYb+OENlvfMhzv5UzLwjHZtQOHT0eSRct7AIsQegPIpDEpazbu
         pWXetNKWeZOimJUz0KACfq4UQ/tjXb/7+xuSNU4OJapPfQDx17eaZ4CMERTnLrgFK3o8
         E3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUzVUaFguUI0dhcSZGArhDm8u7oF9SqdxgdZUPblKw2JKBZIDoRDwBd2UTBdZjBYMwONC/Ak+Us4PgUyChsxPUx0CCIWXjg9sTj2XybvqaKV2GXzPPLi9+0vxSt6y9ND3mG6RjvNsCjlQ==
X-Gm-Message-State: AOJu0Yz88mMDgr2jZ9xOxJ/eyYhvkhox5x2TbOaNS7O7Cdas7HfPXo9A
	Py2eyw1+O8vSYkm8IePNOnPrSed9QDM94yJyl8UxogPiWone+EM=
X-Google-Smtp-Source: AGHT+IFrHomcDs7Dce0C4dVgcTRil0b/TRFoFdb/mH2vEEgT78QLQyY9BJNv1nbQtoO2cJ6BQ7Xr3w==
X-Received: by 2002:a05:600c:292:b0:41b:8041:53c2 with SMTP id 5b1f17b1804b1-420e19f136emr88565265e9.15.1716303326052;
        Tue, 21 May 2024 07:55:26 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f40:4600:9379:7e4d:c178:234d? ([2a02:810b:f40:4600:9379:7e4d:c178:234d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41ff063d8cesm433554415e9.46.2024.05.21.07.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 07:55:25 -0700 (PDT)
Message-ID: <7aaf1d86-5682-4fdd-9f8e-e30039791577@gmail.com>
Date: Tue, 21 May 2024 16:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/10] drm/verisilicon : support DC8200 and inno hdmi
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 hjc@rock-chips.com, andy.yan@rock-chips.com, xingyu.wu@starfivetech.com,
 p.zabel@pengutronix.de, jack.zhu@starfivetech.com,
 shengyang.chen@starfivetech.com, keith <keith.zhao@starfivetech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <3222561.5fSG56mABF@diego>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <3222561.5fSG56mABF@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Heiko,

Am 21.05.24 um 10:03 schrieb Heiko Stübner:
> Hi Alex,
>
> Am Dienstag, 21. Mai 2024, 12:58:07 CEST schrieb keith:
>> Verisilicon/DC8200 display controller IP has 2 display pipes and each
>> pipe support a primary plane and a cursor plane .
>> In addition, there are four overlay planes as two display pipes common resources.
>>
>> The first display pipe is bound to the inno HDMI encoder.
>> The second display pipe is bound to a simple encoder, which is used to
>> find dsi bridge by dts node.
>>
>> Patch 1 adds YAML schema for JH7110 display pipeline.
>>
>> Patches 2 to 3 add inno common api and match the ROCKCHIP inno hdmi driver
>> by calling the common api.
>> The collating public interface is based on ROCKCHIP inno hdmi,
>> and it can be resused by JH7110 inno hdmi.
>> Those common api are tested on rk-3128 SDK, which kernel version is 4.x.
> as you were working on the rk3128-inno-hdmi variant recently
> and I don't really have a rk3036 or rk3128 in working condition
> right now, could you give this series a try.

Sure, I'm going to check this soon.

Regards,

Alex

> For reference, the full series is at lore:
> https://lore.kernel.org/dri-devel/20240521105817.3301-1-keith.zhao@starfivetech.com/
>
> and generalizes the inno-hdmi driver into the bridge model we
> have in a number of other places already.
>
>
> Thanks
> Heiko
>
>
>
>> step1, make sure the process is consistent with the latest kernel version.
>> step2, just remove the interface and add a common interface.
>>
>> Patches 4 to 8 add kms driver for dc8200 display controller.
>>
>> Patch 9 adds inno hdmi support for JH7110 display pipeline.
>>
>> Patch 10 adds a simple encoder.
>>
>> This patchset should be applied on next branch.
>>
>> V1:
>> Changes since v1:
>> - Further standardize the yaml file.
>> - Dts naming convention improved.
>> - Fix the problem of compiling and loading ko files.
>> - Use drm new api to automatically manage resources.
>> - Drop vs_crtc_funcs&vs_plane_funcs, subdivide the plane's help interface.
>> - Reduce the modifiers unused.
>> - Optimize the hdmi driver code
>>
>> V2:
>> Changes since v2:
>> - fix the error about checking the yaml file.
>> - match drm driver GEM DMA API.
>> - Delete the custom crtc property .
>> - hdmi use drmm_ new api to automatically manage resources.
>> - update the modifiers comments.
>> - enabling KASAN, fix the error during removing module
>>
>> V3:
>> Changes since v3:
>> - Delete the custom plane property.
>> - Delete the custom fourcc modifiers.
>> - Adjust the calculation mode of hdmi pixclock.
>> - Add match data for dc8200 driver.
>> - Adjust some magic values.
>> - Add a simple encoder for dsi output.
>>
>> V4:
>> Changes since v4:
>> - Delete the display subsystem module as all crtcs and planes are a driver.
>> - Delete the custom struct, directly use the drm struct data.
>> - Tidy up the inno hdmi public interface.
>> - Add a simple encoder for dsi output.
>>
>> keith (10):
>>    dt-bindings: display: Add YAML schema for JH7110 display pipeline
>>    drm/bridge: add common api for inno hdmi
>>    drm/rockchip:hdmi: migrate to use inno-hdmi bridge driver
>>    drm/vs: Add hardware funcs for vs.
>>    drm/vs: add vs mode config init
>>    drm/vs: add vs plane api
>>    drm/vs: add ctrc fun
>>    drm/vs: add vs drm master driver
>>    drm/vs: Innosilicon HDMI support
>>    drm/vs: add simple dsi encoder
>>
>>   .../display/bridge/innosilicon,inno-hdmi.yaml |   49 +
>>   .../display/rockchip/rockchip,inno-hdmi.yaml  |   27 +-
>>   .../starfive/starfive,dsi-encoder.yaml        |   92 ++
>>   .../starfive/starfive,jh7110-dc8200.yaml      |  169 +++
>>   .../starfive/starfive,jh7110-inno-hdmi.yaml   |   75 ++
>>   .../soc/starfive/starfive,jh7110-syscon.yaml  |    1 +
>>   MAINTAINERS                                   |   11 +
>>   drivers/gpu/drm/Kconfig                       |    2 +
>>   drivers/gpu/drm/Makefile                      |    1 +
>>   drivers/gpu/drm/bridge/Kconfig                |    2 +
>>   drivers/gpu/drm/bridge/Makefile               |    1 +
>>   drivers/gpu/drm/bridge/innosilicon/Kconfig    |    6 +
>>   drivers/gpu/drm/bridge/innosilicon/Makefile   |    2 +
>>   .../gpu/drm/bridge/innosilicon/inno-hdmi.c    |  587 +++++++++
>>   .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |   97 ++
>>   drivers/gpu/drm/rockchip/Kconfig              |    1 +
>>   drivers/gpu/drm/rockchip/Makefile             |    2 +-
>>   drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  517 ++++++++
>>   .../{inno_hdmi.h => inno_hdmi-rockchip.h}     |   45 -
>>   drivers/gpu/drm/rockchip/inno_hdmi.c          | 1073 -----------------
>>   drivers/gpu/drm/verisilicon/Kconfig           |   23 +
>>   drivers/gpu/drm/verisilicon/Makefile          |   11 +
>>   .../gpu/drm/verisilicon/inno_hdmi-starfive.c  |  481 ++++++++
>>   .../gpu/drm/verisilicon/inno_hdmi-starfive.h  |  152 +++
>>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  241 ++++
>>   drivers/gpu/drm/verisilicon/vs_crtc.h         |   17 +
>>   drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 1060 ++++++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  493 ++++++++
>>   drivers/gpu/drm/verisilicon/vs_drv.c          |  721 +++++++++++
>>   drivers/gpu/drm/verisilicon/vs_drv.h          |   98 ++
>>   drivers/gpu/drm/verisilicon/vs_modeset.c      |   36 +
>>   drivers/gpu/drm/verisilicon/vs_modeset.h      |   10 +
>>   drivers/gpu/drm/verisilicon/vs_plane.c        |  487 ++++++++
>>   drivers/gpu/drm/verisilicon/vs_plane.h        |   26 +
>>   drivers/gpu/drm/verisilicon/vs_simple_enc.c   |  190 +++
>>   drivers/gpu/drm/verisilicon/vs_simple_enc.h   |   25 +
>>   drivers/gpu/drm/verisilicon/vs_type.h         |   84 ++
>>   include/drm/bridge/inno_hdmi.h                |   69 ++
>>   38 files changed, 5840 insertions(+), 1144 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
>>   create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,dsi-encoder.yaml
>>   create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
>>   create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
>>   create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
>>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
>>   rename drivers/gpu/drm/rockchip/{inno_hdmi.h => inno_hdmi-rockchip.h} (85%)
>>   delete mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>>   create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>>   create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.c
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.h
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
>>   create mode 100644 include/drm/bridge/inno_hdmi.h
>>
>>
>
>
>

