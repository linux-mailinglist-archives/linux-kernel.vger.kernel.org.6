Return-Path: <linux-kernel+bounces-418050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E129D5C69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D7F1F22423
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB411DE3D9;
	Fri, 22 Nov 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqCmheme"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D11DE3AB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732269005; cv=none; b=TV7Ha4y8qMvb0eJBG3kCvPh2rALmT0efUtH9fGfhAVKFbq7BjHm68o6opz1AmGpwt19v8u4McDDvzC8rxmQ/0NNTT4zfNKIxHsvw04LMq5CkkGv0e1kgliytdFSxtvOAonX1LPmnGPqz6pwhfC/hAU0VH9ypmIYBAheco2Swt2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732269005; c=relaxed/simple;
	bh=PvEGdxriQ64q0nn9Stq2sPLaEpishpGozwR3OcVmBwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irquNeZHak/60d0PfP7hnVGa5EJJDPGTloKUxq2JSjUQqLmLsL3hSrOVSFoOzkwBTTzEEW0x4ZH6q90WWFWnm+ZQmWkZXi1+L9+CnKe9bCgQo76VyTySmQNOuNL6guvkL1JwjRAg6gy4a39VTcbm2a0HU0BDRvVoHfgmUAgRjK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OqCmheme; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2967af48248so1084313fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732269002; x=1732873802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hVK3siImP8xz7KIb6KpsrNuBusfSPJqPiJxMHJ1HiJQ=;
        b=OqCmhemeGGK1k8JdXWWd2alM/p7fl1rHeDVh4zF+2o0ahGXqeF/WvMv5BX3t0vUXX3
         bjNPexX5Qgms542HTjSUfFLgyc1j9gtlY1wATu1UH87XjrZORJhLT2I7IYlQ3jIAgooW
         TtOrKf2h4aVh5d+pKGw0HhRUtIYl0fMb+UOI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732269002; x=1732873802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVK3siImP8xz7KIb6KpsrNuBusfSPJqPiJxMHJ1HiJQ=;
        b=rm/t5lKtgFR/UZZr+6sj8n8Z0b2unG3HYDcH0NoARKpJUUMy00KD5SdO1iitRvb674
         KxP1kqezJ6T3yeiq5dKRzdgLG6sVrv7u22dFXytwaeA1sU+192KtP6G63iNFerFVcSPs
         lKJWQc32pn6MX0NOGdXzshj8uEr9qMCnSexe7q3k9mwZPDNVyyTrk1Ct695f3Sv1adpv
         5XYTVI74oa65uSha+B8aS7Y3k2eKsb2VFLK2bk41/+RNDOBUkCH/6nv1pJlk1DWHBOTT
         sS1SWdGOYwLig89wQPWBW8ifvC+T+JZgCuk+/ijidXkxalg9UXNe7lEU23082Mzki6qm
         zcxw==
X-Forwarded-Encrypted: i=1; AJvYcCWA5pqUfjRGtO0jNocUgWOzq+qOfxvCAJ+jfJ6O3ZxHOA3qgeW0Ev4gsH8tsAW2hFaOP5/6iqmYGRtTqTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNw6GHBUEr+iJBWBpe9EDYOLZaEAevyIlS4isdWUiKiegTrmU
	fpjozqprW7pxsN1aU77mBRkMMzQ7Etalu1oUJZRfXQrkSZJBmYJ5Nyrq4kZ0y17OiOQuRRR9ewk
	=
X-Gm-Gg: ASbGncuubHrdcC9LdlZXqPhBopiE//NtKu7cGusirKtCNkwThlCFbcQu9DX5EBECl+c
	2W04LCU1gUb+dJnwff49TWE3IrxKaTidHzQmjnjKaTYwNUNsF+saGpMeZeW579IXUJkzpJCW1Af
	wWOS4Bo5BfDdefq9oSfjcnyXrntqHrcE04SxOPXSx1xGCE2YikngHRd7WRPczPKRk4Kc3G3bAv1
	o4YLmQwEvgV0MHSji/TLe+hIOWL04JTGpC+0njGDQKz+G41kqepoOE5jkqM+w/p2CUyTPkDJ8L8
	nApwY8XG2cBPErN6
X-Google-Smtp-Source: AGHT+IEw6ZlA+tv20OjqnDjog3snaOMuqNOt4/+xDt6ZzKuL3Ux4W4PltbUozgzyo1RWV5p5A3fVKw==
X-Received: by 2002:a05:6871:3230:b0:297:26c3:e0ab with SMTP id 586e51a60fabf-29726c3e82bmr1079257fac.32.1732269002099;
        Fri, 22 Nov 2024 01:50:02 -0800 (PST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f069765e21sm333613eaf.17.2024.11.22.01.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 01:50:00 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5fa17a79dso1190307b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:49:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkaf/hSRb/4z2mK5gc0wYd7ZrJI5QgCETjtYvg1bR5e0az4ZmZJU7ynFsFzM5JXt2NClBWioaKlvRSBeU=@vger.kernel.org
X-Received: by 2002:a05:6808:1590:b0:3e7:6468:1fd5 with SMTP id
 5614622812f47-3e915a5886cmr2412276b6e.34.1732268998797; Fri, 22 Nov 2024
 01:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <54307d9c-a9bf-4bc1-b15d-60c5ba53d0ea@stanley.mountain>
 <Z0A6Rc-HUPcsIw8z@kekkonen.localdomain> <CANiDSCuQFmrPTLTFs0GPJ209EEKN=MCg8cK3xcsxp8c2eEMhVg@mail.gmail.com>
 <Z0A8njOPBMtkb5wJ@valkosipuli.retiisi.eu>
In-Reply-To: <Z0A8njOPBMtkb5wJ@valkosipuli.retiisi.eu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 10:49:47 +0100
X-Gmail-Original-Message-ID: <CANiDSCtRife4KNYmCFX56hroGJCHTQvSWdwwMRHGC7mpVbKCYQ@mail.gmail.com>
Message-ID: <CANiDSCtRife4KNYmCFX56hroGJCHTQvSWdwwMRHGC7mpVbKCYQ@mail.gmail.com>
Subject: Re: drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready()
 warn: iterator 'i' not incremented
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

On Fri, 22 Nov 2024 at 09:11, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Fri, Nov 22, 2024 at 09:06:40AM +0100, Ricardo Ribalda wrote:
> > Hi
> >
> > On Fri, 22 Nov 2024 at 09:01, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Fri, Nov 22, 2024 at 10:45:53AM +0300, Dan Carpenter wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   28eb75e178d389d325f1666e422bc13bbbb9804c
> > > > commit: 93da10eee90b2ffa4b496dd4a6ea276c57461fb6 media: intel/ipu6: Fix direct dependency Kconfig error
> > > > config: alpha-randconfig-r072-20241122 (https://download.01.org/0day-ci/archive/20241122/202411221147.N6w23gDo-lkp@intel.com/config)
> > > > compiler: alpha-linux-gcc (GCC) 14.2.0
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > > | Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > > >
> > > > smatch warnings:
> > > > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> > > >
> > > > vim +/i +752 drivers/media/pci/intel/ipu-bridge.c
> > > >
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  745  static int ipu_bridge_ivsc_is_ready(void)
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  746  {
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  747     struct acpi_device *sensor_adev, *adev;
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  748     struct device *csi_dev;
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  749     bool ready = true;
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  750     unsigned int i;
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  751
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03 @752     for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  753  #if IS_ENABLED(CONFIG_ACPI)
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  754             const struct ipu_sensor_config *cfg =
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  755                     &ipu_supported_sensors[i];
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  756
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  757             for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  758  #else
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  759             while (true) {
> > > >                                                                                                         ^^^^^^^^^^^^^^
> > > >
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  760                     sensor_adev = NULL;
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  761  #endif
> > > > 8810e055b57543 drivers/media/pci/intel/ipu-bridge.c       Ricardo Ribalda 2024-05-01  762                     if (!ACPI_PTR(sensor_adev->status.enabled))
> > > > c66821f381aed2 drivers/media/pci/intel/ipu-bridge.c       Wentong Wu      2023-08-03  763                             continue;
> > > >
> > > >
> > > > These continues make sense in for_each_acpi_dev_match() but not in a while (true) {
> > > > loop.  We're stuck forever.
> > >
> > > The non-ACPI case is there just for the looks... I think what should be
> > > done is to make the entire loop conditional to CONFIG_ACPI. I can post a
> > > patch.
> >
> > I saw your mail after I sent my patch :)
> > https://patchwork.linuxtv.org/project/linux-media/patch/20241122-fix-ipu-v1-1-246e254cb77c@chromium.org/
> >
> > If we make the entire loop conditional then we would not compile test the
> > loop.
>
> I'm fine with the patch as such but don't you think we might get just a
> different warning from this one? :-) I'm fine trying this though.

I have send a new series to fix it for real. Until the acpi guys
review the code we can land the first patch of the series. I have
tested it with smatch and sparse and it seems to be fine.

>
> --
> Sakari Ailus



-- 
Ricardo Ribalda

