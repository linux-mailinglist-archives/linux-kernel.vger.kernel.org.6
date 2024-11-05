Return-Path: <linux-kernel+bounces-396289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C19BCAFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714C7B227F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B61D2B2A;
	Tue,  5 Nov 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzNokglV"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656D1D0950
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803828; cv=none; b=t37PoSE3838csGhEUEpPBEDKJem/hAYIr9nLf5UvUGgYUq2isycGICkNgkSS7+4tNEsqlsg0gwpqRiCN0NhOBU0I/6JOhI0tEVP72lcLVXP44csULBal4mYFo8OOwPw9OfCAKCAs3vWRrXK4EVkSoL+uC+CqdFir3DYcOBV3bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803828; c=relaxed/simple;
	bh=xmho4vMlZQ0sfT2x62KsArl0/PvhMVGkAJpvMPtx3fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GsmIdAWO11Gtek/sNvi8r3TTBw80sMsHtVHJhmlcI1qM4M6A78AISk2q7eZ2NNIvrjH4JkdCU/NmMoZI8KcgOgvOJkmbzQeFms6MDkxePg0PNChecteyW0hsbNPH0NbLNveAHtezb/npBZUmd51oMysAHJl0OuxsNqBdyjmfNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QzNokglV; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2918664a3fso4272656276.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730803825; x=1731408625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tcLHhgY/7JDthrxKCQ/K4USCyZ0HCKKxDBN31BvrBJA=;
        b=QzNokglVuS7fpxZNre0hgs3QRE9olZQebLScuo+G++pcZx6sMfMNU71K+nPVllUpqf
         8+wywbnRlSelkiVlgzmQcRF1e2FqxHS63NQIvqjKLF5m/ElAVIB1Q5B80Wcv+eRwdutT
         0PhYXu/dmrehANQETtMPt/gswXE6kWBz7YWyobfLAjiWZ47qb9N08g4LsAJBC9acmxae
         uXGke/tjokelp3YtO8ptaXTDKmGmkPDJ45lp1o0c9K3kAU6n9Mdr+PJBwSkmJaaF/4ih
         Cuk1P8w2ea15uOwlvsuA0H8mhUx9gZiBhx7JCZ9NTiLBNRgHMJCRjpWvZH6jnJhXanI5
         cR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803825; x=1731408625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcLHhgY/7JDthrxKCQ/K4USCyZ0HCKKxDBN31BvrBJA=;
        b=hYHexWiFRR9q8ogLNi6U5e23JHnzsMO5A8NXif2CZAYUzaed/8fhInah6BCoCLVCDc
         a5hHGM/tPlvsDWVt2gUAZifqE3mZPo8e2LSjpBaMPkbPdGVY5ZPTTs+GKeZtzvBUtQHo
         TkJDlmdYnBEwsdyCvf3Nt7Aw4p2qVbT6JpnzZCkMv67vgiOBDwwbMqAC1L+DGix62MxD
         cEXJcfyl1gmmGZW4De/wFgV9YwcMnozxOJS5qihx+v42jzYuH6ET+e1g41ypsbXjlWVx
         I2wxFVxq4FN7AR6y8An/zCoUCJY5+uSciHs+sQmQdregO8oJEZFAk89vbxVwHj5EWYmM
         pYyg==
X-Forwarded-Encrypted: i=1; AJvYcCWMYA89MrP+Z2SAeBbbtetHh53BpAdg3BRrrYGKHgukruCo9DvC5VshLNbGYPZO0u+oom1oKw6FVmw9kYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyATKFOgbrY21f6W/xuWch1kpTMumaGyhvK6wdAekwMo6qFur63
	6F3rSmBGyMoi18TB3sJYWaPM0nbra9V+PwZ1EteUbuDeMZoJnPsBVRTA1iwQ9NhKB37zmv6onYy
	t7nAa00v22X6l3yXR08NRSvfTzORxZ+UZdL0b0Q==
X-Google-Smtp-Source: AGHT+IGvKG/7lB41w2cTCGY4XF224YUlYXy4b7EKwqjtZf9lwXlgT73R+wocm5vnvPHixEYI8CaW/u9+yC/WMUo4CTM=
X-Received: by 2002:a25:2e44:0:b0:e30:c87a:f391 with SMTP id
 3f1490d57ef6-e3301836a58mr12105098276.27.1730803825206; Tue, 05 Nov 2024
 02:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101105028.2177274-1-shiyongbang@huawei.com>
 <20241101105028.2177274-4-shiyongbang@huawei.com> <3ke3n6mkxdcllgjohhudv6xi6csnqzpahaocpofmn26l6jdu6c@xpy2z7yeiijq>
 <35cf8895-fbc5-4ab4-bd52-d322990cefde@huawei.com>
In-Reply-To: <35cf8895-fbc5-4ab4-bd52-d322990cefde@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Nov 2024 10:50:14 +0000
Message-ID: <CAA8EJpoU9Pq4ZpvXj1hzpAgm+Vb002Q=AdTKo2ix4dcAaHNe4Q@mail.gmail.com>
Subject: Re: [PATCH V3 drm-dp 3/4] drm/hisilicon/hibmc: add dp hw moduel in hibmc
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 06:06, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> > On Fri, Nov 01, 2024 at 06:50:27PM +0800, Yongbang Shi wrote:
> >> From: baihan li <libaihan@huawei.com>
> >>
> >> Build a dp level that hibmc driver can enable dp by
> >> calling their functions.
> >>
> >> Signed-off-by: baihan li <libaihan@huawei.com>
> >> Signed-off-by: yongbang shi <shiyongbang@huawei.com>
> >> ---
> >> ChangeLog:
> >> v2 -> v3:
> >>    - fix build errors reported by kernel test robot <lkp@intel.com>
> >>      Closes: https://lore.kernel.org/oe-kbuild-all/202410250931.UDQ9s66H-lkp@intel.com/
> >> v1 -> v2:
> >>    - changed some defines and functions to former patch, suggested by Dmitry Baryshkov.
> >>    - sorting the headers including in dp_hw.h and hibmc_drm_drv.c files, suggested by Dmitry Baryshkov.
> >>    - deleting struct dp_mode and dp_mode_cfg function, suggested by Dmitry Baryshkov.
> >>    - fix build errors reported by kernel test robot <lkp@intel.com>
> >>      Closes: https://lore.kernel.org/oe-kbuild-all/202410040328.VeVxM9yB-lkp@intel.com/
> >>    v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> >> ---
> >>   drivers/gpu/drm/hisilicon/hibmc/Makefile    |   2 +-
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c  | 237 ++++++++++++++++++++
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h  |  31 +++
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h |  41 ++++
> >>   4 files changed, 310 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> >>
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> index 94d77da88bbf..214228052ccf 100644
> >> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> @@ -1,5 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> >> -           dp/dp_aux.o dp/dp_link.o
> >> +           dp/dp_aux.o dp/dp_link.o dp/dp_hw.o
> >>
> >>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> >> new file mode 100644
> >> index 000000000000..214897798bdb
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> >> @@ -0,0 +1,237 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +// Copyright (c) 2024 Hisilicon Limited.
> >> +
> >> +#include <linux/io.h>
> >> +#include <linux/delay.h>
> >> +#include "dp_config.h"
> >> +#include "dp_comm.h"
> >> +#include "dp_reg.h"
> >> +#include "dp_hw.h"
> >> +#include "dp_link.h"
> >> +#include "dp_aux.h"
> >> +
> >> +static int hibmc_dp_link_init(struct dp_dev *dp)
> >> +{
> >> +    dp->link.cap.lanes = 2;
> >> +    dp->link.train_set = devm_kzalloc(dp->dev->dev,
> >> +                                      dp->link.cap.lanes * sizeof(u8), GFP_KERNEL);
> > Can you replace it just with an array, removing a need for an additional
> > allocation?
> >
> >> +    if (!dp->link.train_set)
> >> +            return -ENOMEM;
> >> +
> >> +    dp->link.cap.link_rate = 1;
> > Ok, this is why I don't link using indices for link rates. Which rate is
> > this? Unlike cap.lanes this is pure magic number. I think it should be
> > handled other way around: store actual link rate and convert to the
> > register value when required.
> >
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void hibmc_dp_set_tu(struct dp_dev *dp, struct drm_display_mode *mode)
> >> +{
> >> +    u32 tu_symbol_frac_size;
> >> +    u32 tu_symbol_size;
> >> +    u32 rate_ks;
> >> +    u8 lane_num;
> >> +    u32 value;
> >> +    u32 bpp;
> >> +
> >> +    lane_num = dp->link.cap.lanes;
> >> +    if (lane_num == 0) {
> >> +            drm_err(dp->dev, "set tu failed, lane num cannot be 0!\n");
> >> +            return;
> >> +    }
> >> +
> >> +    bpp = DP_BPP;
> > Where is this defined? Is it hibmc-specific or a generic value?
> >
> >> +    rate_ks = hibmc_dp_get_link_rate(dp->link.cap.link_rate) * DP_LINK_RATE_CAL;
> > same question
>
> Hi Dmitry,
> Thanks for your detailed suggestions and questions. These two are defined in dp_config.h.

Please move defines to the corresponding patch, when the values are
being used. Also if these defines are HIBMC-specific, please use the
corresponding prefix (when one sees DP_foo they expect a constant
defined in the standard, not a driver-specific value).



-- 
With best wishes
Dmitry

