Return-Path: <linux-kernel+bounces-375000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA79A7301
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8998C1C21A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA38A1FBC9A;
	Mon, 21 Oct 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p4Za1PRR"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD901F942E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537882; cv=none; b=o3ElMLuzlqFonFWNG0Kwp3+OYWwIz1b1oDKjvoI7CVd983as1uEvvnYoZJTDjMsl79t/51EP4vQuvFc1RhnDkIYNEw5TCGZZgiR3riiSnCzQTHSSMnwL4OajE01A563e0Wl8XGmvi619soPvpK9m2DFc6ix9RmUbbhLQh7aFIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537882; c=relaxed/simple;
	bh=6KKxH3zjaukqSH+37YYjkKlkvqGZnxxBesQhH50U5Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFFk4RZBOaV4n60wHxBePraBPIHcuA7zl6nnNGpFN07KYjihLfYbAjAC71KELGRxgnbIAPvC3O6Y2VtF6GjqgcoQAc/ti3TtWjWadZz1LtY83dv9OS3VALDlD5ehHsickSG05qTUk+2uBvLhAGLZg1/l+++42o+gqdT9kNCrN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p4Za1PRR; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e59a9496f9so54353767b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729537879; x=1730142679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/46rT7qZaHMrXH+D9ho6f1HAKACXK0e68cmApVPza48=;
        b=p4Za1PRR6mbKcV0TbLec4AsmUA6a/Aw7Yqn8wDAfNlzRTrZsRh5YMEjc7bh9I5iI+J
         C4CLz7TgpxeRTuSgERjL5qd7u8SXBhqcdH3Agfdk8GdQnOg5DdXTSC3+j0/IbjyAnRNe
         D2cgJlkgHIZKc+rIoJk4+0zJuq4H6JDJIcWX5RUA8YXgc6mMfJyGcfOW1Z8VzlVit5Zq
         /oO7Ol+CTp/XS8E0NmakjeZKFxnrf+7IFQS/TDMjPDvZvnr0qsMOtQa4gxHhdXEPwYlm
         Jy13QkH9nL2hmMyCrVaciIzYqDvRJph8mfLznh+KopYz4j9Fu7tkP1UweLtTkTo9Fh72
         ie2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537879; x=1730142679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/46rT7qZaHMrXH+D9ho6f1HAKACXK0e68cmApVPza48=;
        b=K7U05dN31xVD91BCoNuAkIFmnU8J8cH+n7l1MRazoB7YXJBQ7x3m+gCucPBNdjoQvR
         ma8iCYCnnMmKC+VdpS7BRei/KrxXT5D0UQiBAtr0rDV6cKgw6y7ZH7errBlmC3CuquOw
         qDh3sEsh3pHHXleNQg8Y4G0xxJW64aiKOSyIueoGMV7AxrWwpJDeiVczqzoySYdRJDCs
         0sXvG8ZdD988afRzO2Ti+XjcP67MAZ6gnSHlqw5QjWhejRJWz7ZavIB4RbFdIUzIC5Qr
         DcCnqemGxP42oGaKgOsPGfcVCLQ4kOqwua9TEq7B7fg/rYA1hfXE1EBTb5QP2r6R7UXR
         Q2lA==
X-Forwarded-Encrypted: i=1; AJvYcCXD+w+quIYSX2rapDG/9kowJnsNqR9enYNVHCwSk7yhmn0raW9g8mPHDXO+t9Pjj6//WVonuYWrTvIxILQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOuxiPAqpsajlZaqoRiJR3lgdTyiMTDceOA3e7zSSuUZSHWxf
	Bm+HkTL+ijVUxFc/PAGyRlcWDAcbfpDFvSJh4A7da9U0KqPXixAWBKp+0WQvig1dkl3AUVh6CN4
	CzrrsSHTxypuj6AfQcf4wZuTXUe7V5JHPl6vihQ==
X-Google-Smtp-Source: AGHT+IE50840gfrhIlHnI8IWVXrdwhJPgN1AcLZFAPN7gDJn915Lj1OE3NzM+QPshp0P84IBdPXg1C6/WJ/NnySPopk=
X-Received: by 2002:a05:690c:700a:b0:6dd:cdd7:ce5a with SMTP id
 00721157ae682-6e7d824d029mr800267b3.18.1729537879474; Mon, 21 Oct 2024
 12:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930100610.782363-1-shiyongbang@huawei.com>
 <20240930100610.782363-4-shiyongbang@huawei.com> <eslfc3ejjjpbw5wuf4khcoixeaitpb47iwf6kug7cryplcxcui@sieiyekdpczn>
 <c95252f7-12a7-49b8-8bf6-2ff3ada845ff@huawei.com>
In-Reply-To: <c95252f7-12a7-49b8-8bf6-2ff3ada845ff@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 22:11:09 +0300
Message-ID: <CAA8EJppmrizqHjqYrRBVdjpTYLbPrrX+2wzeFhnVumifN_B0nQ@mail.gmail.com>
Subject: Re: [PATCH drm-dp 3/4] drm/hisilicon/hibmc: add dp kapi moduel in
 hibmc drivers
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 15:22, Yongbang Shi <shiyongbang@huawei.com> wrote:
>
> Hi Dmitry,
> There're some format problems with the previous replies. Send it again here.
> Thanks for your advices, I'll resolve the problems you mentioned.
>
> > On Mon, Sep 30, 2024 at 06:06:09PM +0800, shiyongbang wrote:
> >> From: baihan li <libaihan@huawei.com>
> >>
> >> Build a kapi level that hibmc driver can enable dp by
> >> calling these kapi functions.
> >>
> >> Signed-off-by: baihan li <libaihan@huawei.com>
> >> ---
> >>   drivers/gpu/drm/hisilicon/hibmc/Makefile      |  2 +-
> >>   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    | 20 ++++++++
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c  | 12 ++---
> >>   drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h  | 48 +++++++++++++++++++
> >>   4 files changed, 75 insertions(+), 7 deletions(-)
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> >>
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/Makefile b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> index 94d77da88bbf..693036dfab52 100644
> >> --- a/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/Makefile
> >> @@ -1,5 +1,5 @@
> >>   # SPDX-License-Identifier: GPL-2.0-only
> >>   hibmc-drm-y := hibmc_drm_drv.o hibmc_drm_de.o hibmc_drm_vdac.o hibmc_drm_i2c.o \
> >> -           dp/dp_aux.o dp/dp_link.o
> >> +           dp/dp_aux.o dp/dp_link.o dp/dp_kapi.o
> >>
> >>   obj-$(CONFIG_DRM_HISI_HIBMC) += hibmc-drm.o
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> >> new file mode 100644
> >> index 000000000000..a6353a808cc4
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_config.h
> >> @@ -0,0 +1,20 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/* Copyright (c) 2024 Hisilicon Limited. */
> >> +
> >> +#ifndef DP_CONFIG_H
> >> +#define DP_CONFIG_H
> >> +
> >> +#define DP_BPP 24
> >> +#define DP_SYMBOL_PER_FCLK 4
> >> +#define DP_MIN_PULSE_NUM 0x9
> >> +#define DP_MSA1 0x20
> >> +#define DP_MSA2 0x845c00
> >> +#define DP_OFFSET 0x1e0000
> >> +#define DP_HDCP 0x2
> >> +#define DP_INT_RST 0xffff
> >> +#define DP_DPTX_RST 0x3ff
> >> +#define DP_CLK_EN 0x7
> >> +#define DP_SYNC_EN_MASK 0x3
> >> +#define DP_LINK_RATE_CAL 27
> > I think some of these defines were used in previous patches. Please make
> > sure that at each step the code builds without errors.
> >
> >> +
> >> +#endif
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> >> index 4091723473ad..ca7edc69427c 100644
> >> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.c
> >> @@ -64,12 +64,12 @@ static void hibmc_dp_set_tu(struct hibmc_dp_dev *dp, struct dp_mode *mode)
> >>      rate_ks = dp->link.cap.link_rate * DP_LINK_RATE_CAL;
> >>      value = (pixel_clock * bpp * 5000) / (61 * lane_num * rate_ks);
> >>
> >> -    if (value % 10 == 9) { /* 10: div, 9: carry */
> >> -            tu_symbol_size = value / 10 + 1; /* 10: div */
> >> +    if (value % 10 == 9) { /* 9 carry */
> >> +            tu_symbol_size = value / 10 + 1;
> >>              tu_symbol_frac_size = 0;
> >>      } else {
> >> -            tu_symbol_size = value / 10; /* 10: div */
> >> -            tu_symbol_frac_size = value % 10 + 1; /* 10: div */
> >> +            tu_symbol_size = value / 10;
> >> +            tu_symbol_frac_size = value % 10 + 1;
> >>      }
> >>
> >>      drm_info(dp->dev, "tu value: %u.%u value: %u\n",
> >> @@ -158,7 +158,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
> >>      dp_write_bits(dp->base + DP_VIDEO_CTRL,
> >>                    DP_CFG_STREAM_HSYNC_POLARITY, mode->h_pol);
> >>
> >> -    /* MSA mic 0 and 1*/
> >> +    /* MSA mic 0 and 1 */
> >>      writel(DP_MSA1, dp->base + DP_VIDEO_MSA1);
> >>      writel(DP_MSA2, dp->base + DP_VIDEO_MSA2);
> >>
> >> @@ -167,7 +167,7 @@ static void hibmc_dp_link_cfg(struct hibmc_dp_dev *dp, struct dp_mode *mode)
> >>      dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_RGB_ENABLE, 0x1);
> >>      dp_write_bits(dp->base + DP_VIDEO_CTRL, DP_CFG_STREAM_VIDEO_MAPPING, 0);
> >>
> >> -    /*divide 2: up even */
> >> +    /* divide 2: up even */
> >>      if (timing_delay % 2)
> >>              timing_delay++;
> >>
> > This should be squashed into the previous commits.
> >
> >> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> >> new file mode 100644
> >> index 000000000000..6b07642d55b8
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_kapi.h
> >> @@ -0,0 +1,48 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/* Copyright (c) 2024 Hisilicon Limited. */
> >> +
> >> +#ifndef DP_KAPI_H
> >> +#define DP_KAPI_H
> >> +
> >> +#include <linux/types.h>
> >> +#include <drm/drm_device.h>
> >> +#include <drm/drm_encoder.h>
> >> +#include <drm/drm_connector.h>
> >> +#include <drm/drm_print.h>
> >> +#include <linux/delay.h>
> > Sort the headers, please.
> >
> >> +
> >> +struct hibmc_dp_dev;
> >> +
> >> +struct dp_mode {
> >> +    u32 h_total;
> >> +    u32 h_active;
> >> +    u32 h_blank;
> >> +    u32 h_front;
> >> +    u32 h_sync;
> >> +    u32 h_back;
> >> +    bool h_pol;
> >> +    u32 v_total;
> >> +    u32 v_active;
> >> +    u32 v_blank;
> >> +    u32 v_front;
> >> +    u32 v_sync;
> >> +    u32 v_back;
> >> +    bool v_pol;
> >> +    u32 field_rate;
> >> +    u32 pixel_clock; // khz
> > Why do you need a separate struct for this?
>
> I can try to use drm_mode function and refactor this struct, but they're insufficient for our scenarios.
> Here's change template bellow:

But you are generating the data from struct drm_display_mode. Please
use the existing struct instead and generate the blank and porch
timings when you have to program them.
There is really no need to define another struct just to temporarily
hold the same data.

> struct dp_mode {
>          sturct videomode mode;
>          u32 h_total;
>          u32 h_blank;
>          u32 v_total;
>          u32 v_blank;
>          u32 field_rate;
> };
> static void dp_mode_cfg(struct dp_mode *dp_mode, struct drm_display_mode *mode)
> {
>          dp_mode->field_rate = drm_mode_vrefresh(mode);
>          drm_display_mode_to_videomode(mode, &dp_mode->vmode);
>          dp_mode->h_total = mode->htotal;
>          dp_mode->h_blank = mode->htotal - mode->hdisplay;
>          dp_mode->v_total = mode->vtotal;
>          dp_mode->v_blank = mode->vtotal - mode->vdisplay;
> }
>

-- 
With best wishes
Dmitry

