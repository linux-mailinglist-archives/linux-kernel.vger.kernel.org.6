Return-Path: <linux-kernel+bounces-388084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489029B5A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B2BB224AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC1519922F;
	Wed, 30 Oct 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOsVpwHx"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A681198837
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730258456; cv=none; b=Fvke2SYoOQLStmABJ1uivzJZKitYWvX/5z18SrNl++NWrPeypqKAvoZhatDLQ02DLcr71LEEf9wW8scNWSmkxQgP54OkTas2ZuujxQqJbBGJFb7wC/Ipvo00vEmlLUxpQgm6D5ZEsoLZ5LE0GSo9eoLNr4a/GZKLeqQn9e0QujA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730258456; c=relaxed/simple;
	bh=qg3/sYGFBDjf0CPem8T8M0uvF4Ao1HGJ9RHdl+3LCv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0vtchEx/q6xGj/0G9zizJSl5r75rfpHQqx0CSi5PL/0PGSVfKb6n9uJFZmQGtblgzE8A5eenj+kiZ2D7VqzUqwhvjid0tza7FOUTDrkpKtFWqfNnYwjvhBV4xV5dleeDvh3cYhLII4vX9x4YC3ndF2zcaVIsUFfyQrp1Z3eO1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FOsVpwHx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e3a97a6010so70732957b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730258453; x=1730863253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GhwxQj1utf80B72sGdNfRKzLMLZGfEcldvV9/fNbZyo=;
        b=FOsVpwHxkjLTzEbijubjTY7fhIU9xb8g7oyKukpkuVkTeNMofHj8a9odTYxB7KVIxs
         stQMq7VYziKb+iT9dsQnrBRsY2Sq5qP8YA9TqfbdKwOM5PIuO/nARJVJ+r8e33vWvd7p
         G+X2JgzwhSnVgdDEdKAUyvOv27Fql4Qy0p7ZApqO0X43ak3NMGya2ueOLD3YKj0BZgGZ
         xvyiyCX0nQlykoqTilGeJSpLNH7bfmYctpAkNIkUnjqa5iwS8ARmRrCdAsoMw8q8LeJo
         0aPsyscSoQuzsYas01OYAzmVQJZETSXWNMYQohxWzedmom3cHL1AtMT7c0wnyRXx+c5A
         ctbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730258453; x=1730863253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhwxQj1utf80B72sGdNfRKzLMLZGfEcldvV9/fNbZyo=;
        b=Zcfqbq35RcMyBL7hOSJi2xKqaogR1pR8MYxtVixsQgHpGes5MXj8jJAx2909c5XYjQ
         QSxN0xKjCyoX9lHww5bjxFAsroFubXTUGCNpO5Q+R8wunWuEC+be8LumJui7VGB/Idui
         TLPBHcZLRiAiAUDB0p92AIsr7k8fNAiKC15J40dIZfLSHigV0FY/gEQaZdtPaeiyHSmN
         2X30APBL5FJZKw6jtBTZ86PcBTwtffBAp+USe0gIzwHPZVT1Lte9ybusfjYeqgT2tUtM
         9mW+Dc97iH+QtfeRsdP88TcyvQVIjMZ1hKfmW6XhG6TQjfJy8VjafX1djVPkFoGvmB6X
         a2yA==
X-Forwarded-Encrypted: i=1; AJvYcCUEkAL8KvEgiCNTlr+BykLeX1rljNsSt+VQefQLetPA/GvhUoQNxhTWsOL5+WECSdBZI2N6BOOPVs5KEPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpRpwIm5W70aX4/GI5a/hAxFiR4faOpzPQh6zW5IIaVwMrpKg
	xwj5OGRHdKoYjXDFHQHzi4WHO4pftsu9sU0HjqG8aQEP/zXaIZRTizpZzRBUbC8CctRdYlKhRqh
	KU+YNpR8j5+Rg5Vifm+dVyXQW9QKRCSZkmDnhXQ==
X-Google-Smtp-Source: AGHT+IFLiGFVvX1f36/HNeQe2CZovY3JMjIFKBP1+C2WNJqZKHiRxAHMieCw1+KIFYDqLZ5ERJmT4auyzpM6VhqfLKk=
X-Received: by 2002:a05:690c:ec5:b0:6ea:3ba2:6b0d with SMTP id
 00721157ae682-6ea3ba26cf1mr20336287b3.9.1730258453475; Tue, 29 Oct 2024
 20:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022124148.1952761-1-shiyongbang@huawei.com>
 <20241022124148.1952761-3-shiyongbang@huawei.com> <k5d3ny7dl4tgsy2y2kagz3d3s5rg74qaazck3xxbqpwlrjjd2i@e4dohu4uuwsr>
 <20625fdb-15d3-4b7e-a5e1-e917cf9ce3d5@huawei.com>
In-Reply-To: <20625fdb-15d3-4b7e-a5e1-e917cf9ce3d5@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 30 Oct 2024 05:14:57 +0200
Message-ID: <CAA8EJpoMHrTw069bkSiNG3q6J2SftGBCbYwgpr4yjeporVK1nw@mail.gmail.com>
Subject: Re: [PATCH V2 drm-dp 2/4] drm/hisilicon/hibmc: add dp link moduel in hibmc
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 16:15, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> > On Tue, Oct 22, 2024 at 08:41:46PM +0800, Yongbang Shi wrote:
> >> From: baihan li <libaihan@huawei.com>
> >>
> >> Add link training process functions in this moduel.
> > We should probably have a bounty for a developer who finally writes a
> > generic DP link training helpers.
> >
> >> Signed-off-by: baihan li <libaihan@huawei.com>
> > Missing SoB
> >
> >> ---
> >> ChangeLog:
> >> v1 -> v2:
> >>    - using drm_dp_* functions implement dp link training process, suggested by Jani Nikula.
> >>    - fix build errors reported by kernel test robot <lkp@intel.com>
> >>      Closes: https://lore.kernel.org/oe-kbuild-all/202410031735.8iRZZR6T-lkp@intel.com/
> >>    v1:https://lore.kernel.org/all/20240930100610.782363-1-shiyongbang@huawei.com/
> >> ---
> >>   drivers/gpu/drm/hisilicon/hibmc/Makefile     |   2 +-
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c | 344 +++++++++++++++++++
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h |  25 ++
> >>   3 files changed, 370 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.h
> >>
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> index 8770ec6dfffd..94d77da88bbf 100644
> >> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> @@ -1,5 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> >> -           dp/dp_aux.o
> >> +           dp/dp_aux.o dp/dp_link.o
> >>
> >>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> >> new file mode 100644
> >> index 000000000000..b02a536e0689
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> >> @@ -0,0 +1,344 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +// Copyright (c) 2024 Hisilicon Limited.
> >> +
> >> +#include <linux/delay.h>
> >> +#include <drm/drm_device.h>
> >> +#include <drm/drm_print.h>
> >> +#include "dp_comm.h"
> >> +#include "dp_reg.h"
> >> +#include "dp_link.h"
> >> +#include "dp_aux.h"
> >> +
> >> +const u8 link_rate_map[] = {DP_LINK_BW_1_62, DP_LINK_BW_2_7,
> >> +                        DP_LINK_BW_5_4, DP_LINK_BW_8_1};
> >> +
> >> +static int dp_link_training_configure(struct dp_dev *dp)
> >> +{
> >> +    u8 buf[2];
> >> +    int ret;
> >> +
> >> +    /* DP 2 lane */
> >> +    dp_write_bits(dp->base + DP_PHYIF_CTRL0, DP_CFG_LANE_DATA_EN,
> >> +                  dp->link.cap.lanes == DP_LANE_NUM_2 ? 0x3 : 0x1);
> >> +    dp_write_bits(dp->base + DP_DPTX_GCTL0, DP_CFG_PHY_LANE_NUM,
> >> +                  dp->link.cap.lanes == DP_LANE_NUM_2 ? 0x1 : 0);
> >> +
> >> +    /* enhanced frame */
> >> +    dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_FRAME_MODE, 0x1);
> >> +
> >> +    /* set rate and lane count */
> >> +    buf[0] = dp_get_link_rate(dp->link.cap.link_rate);
> >> +    buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
> >> +    ret = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, sizeof(buf));
> >> +    if (ret != sizeof(buf)) {
> >> +            drm_err(dp->dev, "dp aux write link rate and lanes failed, ret: %d\n", ret);
> >> +            return ret;
> >> +    }
> >> +
> >> +    /* set 8b/10b and downspread */
> >> +    buf[0] = 0x10;
> >> +    buf[1] = 0x1;
> >> +    ret = drm_dp_dpcd_write(&dp->aux, DP_DOWNSPREAD_CTRL, buf, sizeof(buf));
> >> +    if (ret != sizeof(buf))
> >> +            drm_err(dp->dev, "dp aux write 8b/10b and downspread failed, ret: %d\n", ret);
> >> +
> >> +    ret = drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
> >> +    if (ret)
> >> +            drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >> +static int dp_link_pattern2dpcd(struct dp_dev *dp, enum dp_pattern_e pattern)
> >> +{
> >> +    switch (pattern) {
> >> +    case DP_PATTERN_NO:
> >> +            return DP_TRAINING_PATTERN_DISABLE;
> >> +    case DP_PATTERN_TPS1:
> >> +            return DP_TRAINING_PATTERN_1;
> >> +    case DP_PATTERN_TPS2:
> >> +            return DP_TRAINING_PATTERN_2;
> >> +    case DP_PATTERN_TPS3:
> >> +            return DP_TRAINING_PATTERN_3;
> >> +    case DP_PATTERN_TPS4:
> >> +            return DP_TRAINING_PATTERN_4;
> >> +    default:
> >> +            drm_err(dp->dev, "dp link unknown pattern %d\n", pattern);
> >> +            return -EINVAL;
> > Why do you need the extra defines / wrappers? Can you use
> > DP_TRAINING_PATTERN_foo directly?
>
> Hi Dmitry,
> Thanks for your all of these good advices and questions. I will resply as soon as possible.
> For this point, I also need this enum dp_pattern_e value to write in my dp reg at TPS stage, so I made this map here.

I'd suggest to do it other way around: use standard defines and when
necessary map them for the register write.

-- 
With best wishes
Dmitry

