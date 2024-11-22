Return-Path: <linux-kernel+bounces-417914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D09D5AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C358F283AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9818A6DE;
	Fri, 22 Nov 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cUIFdHPq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D183184522
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262816; cv=none; b=VaBiKb0Xh4acw3thbUQqVkBNpJ+9UtwZdCPSUM2m2qPDp7oGd/PeveqSHICedxHxltySJYU/TDn8tH4blH4JKYfMN9+wfNpAVftXObMi1bN04JZfNvthU1lyaFgTzfJcW29oQb5tv1QlNd4S9YZJic1lxGgJW1S8ZeV3rotcyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262816; c=relaxed/simple;
	bh=Qi4/idXLvnIThje2gN76UzBa1XdNh7XOjU86E3VjFGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPIrhbMXlRypBmt8fGs0/rnF5iERHXdWc5VPiWNjFRU1VUoUeCQjnG1JizvKyzTGhkcNIBtRuqO8Rx/oD7cSn/sqcT0H9jguBomVZpbINVPAG9raVV4mDwjGwKkResp7OvWqfL6T1/MbAcQi5Y200cS7G012Snx3jR7+zZ1Un4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cUIFdHPq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-212a3067b11so3857375ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732262813; x=1732867613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EheqArWCj4tc46f2BqzjXCWprDHEPhu6m5IV043oQTA=;
        b=cUIFdHPqsXs1c3u61CqpZLtj0VY+X4PR6epBiV8x4ptKZA41aj+nXx24/C8ehX0bgh
         D2CZxsvjNfkQSfljVxaoDF5Z4KVSmsFLESpIZAhoGsfld3grE7WOtHW745FJwAl3tvK3
         4esFlpT0byxFwwTzxXSktbkKP7m1BlUVWSGtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732262813; x=1732867613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EheqArWCj4tc46f2BqzjXCWprDHEPhu6m5IV043oQTA=;
        b=v6atUKWoTeDPFAQLmva0kwbVoWtOup88YcD8PAZcoZUZpvZWyjxLM9lvhhv8EIztvg
         MSHu4RI3h25hoQvEiKCniYN5Mi2jo6xR83FDDZZirvC7ru/2gEjA5GTFjxL2U8j4reVT
         kcctAxbg/nv6rkAgiv68g9u+MJF9HRSS5LanXED/EugjC4rT1U64yVKI73shTmBZPWZX
         9y66jI/cM9RuIKnhWtkzzlXZF8carL7Ok2Eeooi5gZs8eXt79dXSNZRN/m2H7J7xGQLB
         oztX7FL4cSl2zJHX1+6b3yPMMIlVqRG+fS12OkJdPc3bCWhu/GSE0QrEkNC+fdWveizW
         KKdw==
X-Forwarded-Encrypted: i=1; AJvYcCXkWgW+ikYigdx0wwwA6i1yUOXZKATmLxlj0LmshXdtV2kHdFzIiHt50WPyjlx9AfrW4gXH4+m18SlgCuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9ufhPv4maDq7oT+xQcsCcNtmhIgsPxs9MBPVZ/TJfpejS6EH
	CiqAyrRTe0pcnRmsRc5V5aT0WOYhuQIaHvIJxP0KRws2VWRNJMDjymZ/2SCeKobF3Lsf2OdEEl0
	=
X-Gm-Gg: ASbGncvoagZJsuEKv2p23USuKCsd6XarXfwqZV2RADyZI8UY6Pu0xKFa5sH9YCJXs1X
	v7X+bfz9rORFZKs4W/zy8NJfSbWYwlFpLiACHZHf/MYqjuCgIIvm4DcpP79GSKYym2nCrSsLVld
	1hpKREysVkUZNA+/b/OUNkHisfx876lwZzhIKR4j8wWcfVaTP7exLFB+UuCjhvGRtdx5wwPX4FM
	HcIQaPm9ClVVdbruSUZ1RWM7aRnHqVPdcGzt0vk47+DLABYDiS7Ah58sazth3Tw5bzF83zu/W1/
	D+2sHIiILTaguvU1
X-Google-Smtp-Source: AGHT+IEvS9cWF1kA0MDSc6Gv30EptKP1Hm501soZbMffIuFu5GQu9ybBG5atM6ahMPaDuRmt+9egJg==
X-Received: by 2002:a17:902:cec9:b0:212:23e5:6202 with SMTP id d9443c01a7336-2129f67b3f6mr19520245ad.6.1732262813413;
        Fri, 22 Nov 2024 00:06:53 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfa1edsm10543465ad.158.2024.11.22.00.06.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 00:06:52 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso1254603a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:06:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUf6tBV315RYjSbpNlRIqytBkNCsdXMbyGmtp4H1aN33MoQltNak4EmFdRrjwlbMwbpT6+m/wi1P1Yzypw=@vger.kernel.org
X-Received: by 2002:a05:6a21:999d:b0:1db:e328:dd13 with SMTP id
 adf61e73a8af0-1e09e3fe116mr2932241637.11.1732262812168; Fri, 22 Nov 2024
 00:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54307d9c-a9bf-4bc1-b15d-60c5ba53d0ea@stanley.mountain> <Z0A6Rc-HUPcsIw8z@kekkonen.localdomain>
In-Reply-To: <Z0A6Rc-HUPcsIw8z@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:06:40 +0100
X-Gmail-Original-Message-ID: <CANiDSCuQFmrPTLTFs0GPJ209EEKN=MCg8cK3xcsxp8c2eEMhVg@mail.gmail.com>
Message-ID: <CANiDSCuQFmrPTLTFs0GPJ209EEKN=MCg8cK3xcsxp8c2eEMhVg@mail.gmail.com>
Subject: Re: drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready()
 warn: iterator 'i' not incremented
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 22 Nov 2024 at 09:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Dan,
>
> On Fri, Nov 22, 2024 at 10:45:53AM +0300, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   28eb75e178d389d325f1666e422bc13bbbb9804c
> > commit: 93da10eee90b2ffa4b496dd4a6ea276c57461fb6 media: intel/ipu6: Fix direct dependency Kconfig error
> > config: alpha-randconfig-r072-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221147.N6w23gDo-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 14.2.0
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > | Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> >
> > smatch warnings:
> > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> >
> > vim +/i +752 drivers/media/pci/intel/ipu-bridge.c
> >
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  745  static int ipu_bridge_ivsc_is_ready(void)
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  746  {
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  747     struct acpi_device *sensor_adev, *adev;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  748     struct device *csi_dev;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  749     bool ready = true;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  750     unsigned int i;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  751
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03 @752     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  753  #if IS_ENABLED(CONFIG_ACPI)
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  754             const struct ipu_sensor_config *cfg =
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  755                     &ipu_supported_sensors[i];
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  756
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  757             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  758  #else
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  759             while (true) {
> >                                                                                                         ^^^^^^^^^^^^^^
> >
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  760                     sensor_adev = NULL;
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  761  #endif
> > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  762                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  763                             continue;
> >
> >
> > These continues make sense in for_each_acpi_dev_match() but not in a while (true) {
> > loop.  We're stuck forever.
>
> The non-ACPI case is there just for the looks... I think what should be
> done is to make the entire loop conditional to CONFIG_ACPI. I can post a
> patch.

I saw your mail after I sent my patch :)
https://patchwork.linuxtv.org/project/linux-media/patch/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org/

If we make the entire loop conditional then we would not compile test the loop.

Regards!



>
> >
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  764
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  765                     adev = ipu_bridge_get_ivsc_acpi_dev(sensor_adev);
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  766                     if (!adev)
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  767                             continue;
> >                                                                                                                         ^^^^^^^^
> >
> >
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  768
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  769                     csi_dev = ipu_bridge_get_ivsc_csi_dev(adev);
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  770                     if (!csi_dev)
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  771                             ready = false;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  772
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  773                     put_device(csi_dev);
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  774                     acpi_dev_put(adev);
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  775             }
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  776     }
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  777
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  778     return ready;
> > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  779  }
> >
>
> --
> Kind regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

