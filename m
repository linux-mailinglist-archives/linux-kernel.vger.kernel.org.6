Return-Path: <linux-kernel+bounces-528077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE6A41340
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B311C16A553
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622FF70824;
	Mon, 24 Feb 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEFfPGci"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6C4A1D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740363362; cv=none; b=upRbMGHKp8yuKtE1SSAtaekWuyFCiIFhTSZHZLzAPfUIIZmnIsN7eJYR9J7nNmmRQEWiZf32RgL8X0iKQ2eVqU4lfiw2bUh81Tp5MlPs1IGqACjuKeJ1OED+lLjkoDYlAZwVuldDloYdarKUYOiYyRzZE4AsgIagiWBvMrXZaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740363362; c=relaxed/simple;
	bh=OZ57DLeYVQeJBZ23OF+2av3NRPTTcBQrLC0nD0ukQeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVdQUnDHYUqidHs2jna3BsyqZt+mK28EeXz/oGaI0S2Q7LgyoFTj455qHPGWCro109Jnt68+KsLqWzaqb3qyn9xbcbAHVeVA3viUPa19+cy9ix+hh9CC6q+viYq/HJ9Fu9yAPJkXYqbpVX4aw4BkGd8zmA+7n/ECqJng4nffxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LEFfPGci; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54529eeb38aso3293929e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740363359; x=1740968159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03x282i+KbbFm+Sge0tO2WLnHAQK0oVCuq/xqv36OUQ=;
        b=LEFfPGcibYjFE+fnCpGXD7hL9icA/ceC87fkmVC3CoUEob/BGRMZrwoWjLwuw1hGLd
         efG6fosuLwBRiB4JDudlxtRaRsQimXtGfiCXnPBU/bXgqj5GHsZUbV5To45s2fQjFzNo
         4Ug3i+hXn/wP6ABaG6UAvUfh/xCxG+ifDHEAU0J96uhx0/DxYHawLoZ2uW8YX7FozJm6
         u7WQyArwZdxYiTkunrIi8lSbh8G/VDYc/GjbpkpLBQM7qRfFb6lfrnZT4+2P1YtLmGnr
         EwG8XMRhnySMWN1d4yS3ciTkf3xyY42ywhnewYW2K6UBUKZmf52zrMhLVktawtz0Utpd
         R60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740363359; x=1740968159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03x282i+KbbFm+Sge0tO2WLnHAQK0oVCuq/xqv36OUQ=;
        b=mDkSPEFHFckB8P4lnbVEuECkXGKU/q2MnWKCh3zEsaYbnBJFnN71M4c9lgS2OoV0R3
         muLDtRWP3bYwq9DHr+214RTIOojnJ5SmjvRvDJ1DNm+fdvhC1Fiqo5x6iu0GiVvQ4ENo
         fTyZd0tCDk+a5cwKkAV5sPZa0hSZ2MXH8QAjT5rM4Ar5Jkfg56nXkU1jCCv7vtecveQO
         1IyGoRuyXdSc0jNdgmYTVCRjgMZrc4wiPzLV0xZsxVWFuH5oVVpCe3XJiM9QAje1DfjA
         ONf9jaaoMASOtJKxDS77V7DhSDvkHVNNgoHYXQwal26LKoCWgedLSQA6UmYLo8NTd183
         qqLw==
X-Forwarded-Encrypted: i=1; AJvYcCWoKqHzwWo4qh52c2j5zenFcI7xsW1EcigSjt6IfNh33fRgWYvw3LTC1goLCQ+zZrO9LGlDlp4BuiYgwmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegkALfVjivo0bmPzId66K9LfNfv++p0RadHi21s8tPms0M/lo
	w1cnTkE6yfQRFur/lbpdxYw6jooopEjt3+QHPB+AUpMcCNRFjgTbOloiXvE0El0=
X-Gm-Gg: ASbGncs4mzLekUC9WmIrQknEO4On6IoZMScl681uHpNi9TPQSs9M2nWAz3Mgv2r3wN5
	WhhM4qmXPvbcP/UfXPK89Y54axNZjL0e0G4KpRCbyF5PTeEzf6ogEDn6Dt5AVqRirox37SJj4Av
	U/JSb9saGS1DmHmYr6Y76TD+Wuno4hMDudxyRVZc89hWXnBJpHvFNUsLRrECsG8PjmV6p4RGzJ9
	IsVJ6147BDX6iZTPAG2GVY4B72Le31EAEp6RQX8hlJHvGrI0D1Nu61K5iijLv0Kw6h+uPHuDeMB
	th3VM2xj8whtJaIJnDJ8htW1WlQVQ1ATegaJRWaVlkF4hfqY0YG2TVNw8KxjDUxB5uk40xGWfZt
	MthLRLw==
X-Google-Smtp-Source: AGHT+IFD8yCSJdHxEzXcKOScOwjk4piZVuSgJw/kfPjGZPJZeEQwe/7hrMUi7SPPp71EVSbw+qv4rA==
X-Received: by 2002:a05:6512:3094:b0:545:f0a:bf50 with SMTP id 2adb3069b0e04-54838f5b86emr4428391e87.35.1740363358410;
        Sun, 23 Feb 2025 18:15:58 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526745abcsm3068485e87.252.2025.02.23.18.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:15:57 -0800 (PST)
Date: Mon, 24 Feb 2025 04:15:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, liangjian010@huawei.com, 
	chenjianmin@huawei.com, lidongming5@huawei.com, libaihan@huawei.com, 
	shenjian15@huawei.com, shaojijie@huawei.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 3/8] drm/hisilicon/hibmc: Add dp serdes cfg in
 dp process
Message-ID: <scjsgypzxx7pkd255qf3t45nnqytp7q2urdvwo6zdffubawsa3@p6duklhgw3rv>
References: <20250222025102.1519798-1-shiyongbang@huawei.com>
 <20250222025102.1519798-4-shiyongbang@huawei.com>
 <d77bfuqor2rsd5tg4abywkckiqwy7j5xr43p73to2ofwpirws3@4m4g7hkvji2a>
 <c9d59963-2ebd-4a6f-bdff-1616ed8afec0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d59963-2ebd-4a6f-bdff-1616ed8afec0@huawei.com>

On Sat, Feb 22, 2025 at 06:32:35PM +0800, Yongbang Shi wrote:
> > On Sat, Feb 22, 2025 at 10:50:56AM +0800, Yongbang Shi wrote:
> > > From: Baihan Li <libaihan@huawei.com>
> > > 
> > > Add dp serdes cfg in link training process, and related adapting
> > > and modificating. Change some init values about training,
> > > because we want completely to negotiation process, so we start with
> > > the maximum rate and the electrical characteristic level is 0.
> > > 
> > > Signed-off-by: Baihan Li <libaihan@huawei.com>
> > > Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> > > ---
> > > ChangeLog:
> > > v2 -> v3:
> > >    - change commit to an imperative sentence, suggested by Dmitry Baryshkov.
> > >    - put HIBMC_DP_HOST_SERDES_CTRL in dp_serdes.h, suggested by Dmitry Baryshkov.
> > > v1 -> v2:
> > >    - splittting the patch and add more detailed the changes in the commit message, suggested by Dmitry Baryshkov.
> > > ---
> > >   .../gpu/drm/hisilicon/hibmc/dp/dp_config.h    |  1 +
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  5 ++-
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 ++++++++++++++++---
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h   |  1 +
> > >   .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.h    |  6 ++++
> > >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  8 ++---
> > >   6 files changed, 43 insertions(+), 11 deletions(-)
> > > 
> > Mostly LGTM.
> > 
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> > > index 812d0794543c..e0537cc9af41 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.h
> > > @@ -4,12 +4,15 @@
> > >   #ifndef DP_SERDES_H
> > >   #define DP_SERDES_H
> > > +#include "dp_comm.h"
> > No, please include it directly, where required. This simplifies possible
> > inter-header dependencies.
> 
> Okay.
> 
> 
> > > +
> > >   #define HIBMC_DP_HOST_OFFSET		0x10000
> > >   #define HIBMC_DP_LANE0_RATE_OFFSET	0x4
> > >   #define HIBMC_DP_LANE1_RATE_OFFSET	0xc
> > >   #define HIBMC_DP_LANE_STATUS_OFFSET	0x10
> > >   #define HIBMC_DP_PMA_LANE0_OFFSET	0x18
> > >   #define HIBMC_DP_PMA_LANE1_OFFSET	0x1c
> > > +#define HIBMC_DP_HOST_SERDES_CTRL	0x1f001c
> > >   #define HIBMC_DP_PMA_TXDEEMPH		GENMASK(18, 1)
> > >   /* dp serdes TX-Deempth Configuration */
> > > @@ -24,6 +27,9 @@
> > >   #define DP_SERDES_VOL2_PRE1		0x4500
> > >   #define DP_SERDES_VOL3_PRE0		0x600
> > >   #define DP_SERDES_BW_8_1		0x3
> > > +#define DP_SERDES_BW_5_4		0x2
> > > +#define DP_SERDES_BW_2_7		0x1
> > > +#define DP_SERDES_BW_1_62		0x0
> > >   #define DP_SERDES_DONE			0x3
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > index e6de6d5edf6b..67d39e258cac 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> > > @@ -28,9 +28,7 @@
> > >   #include "hibmc_drm_drv.h"
> > >   #include "hibmc_drm_regs.h"
> > > -#define HIBMC_DP_HOST_SERDES_CTRL		0x1f001c
> > > -#define HIBMC_DP_HOST_SERDES_CTRL_VAL		0x8a00
> > > -#define HIBMC_DP_HOST_SERDES_CTRL_MASK		0x7ffff
> > > +#include "dp/dp_serdes.h"
> > >   DEFINE_DRM_GEM_FOPS(hibmc_fops);
> > > @@ -122,8 +120,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
> > >   	}
> > >   	/* if DP existed, init DP */
> > > -	if ((readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL) &
> > > -	     HIBMC_DP_HOST_SERDES_CTRL_MASK) == HIBMC_DP_HOST_SERDES_CTRL_VAL) {
> > > +	ret = readl(priv->mmio + HIBMC_DP_HOST_SERDES_CTRL);
> > > +	if (ret) {
> > Why?
> 
> Becuase this is a serdes deempth configuration which is changed if we start cfg serdes.
> The HIBMC_DP_HOST_SERDES_CTRL_VAL is default value, but we may change it. We can just
> check if it is not zero. If it's not zero, it has dp block and we can init it.

=> commit message, please.

> 
> 
> > >   		ret = hibmc_dp_init(priv);
> > >   		if (ret)
> > >   			drm_err(dev, "failed to init dp: %d\n", ret);
> > > -- 
> > > 2.33.0
> > > 

-- 
With best wishes
Dmitry

