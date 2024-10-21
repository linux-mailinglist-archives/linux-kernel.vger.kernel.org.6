Return-Path: <linux-kernel+bounces-374989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD029A72DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F14CB21BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6CE1FB3D2;
	Mon, 21 Oct 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euhGju1L"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944B1FB3C3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537401; cv=none; b=T13ZwQ7beCTOP2bn/Ok3VBPRKEjYnKte6rc3sNbGouKu9DgWsvD4JM8z+hlvc8j16oiA7LLBKkC0cRQhq6dEMiWJxUv0SOHqz42K7QabB927AgZAzQTvQD0/nZgk1BmxonOd2l0aZGZ/FQJ01GTdQxwJogWA9Haa4mvUI8vil38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537401; c=relaxed/simple;
	bh=LETpUrrq++PNB4Cvb1fLdlqOpX4xrxJJQoe4xDSvBgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmcnyavEbfW5KO8u4rtAlBcKFXPpnIs31WJ2/eOFrSk541tB4qrHNVjSTAlGhiVHBH6eN2xzoJoB/tKP7Zx/izJsCOQuU9rUyWXAVTMEUQppk5mVbjMHuyaDhC4e1llLi8BoMtcVDg+rIqqpEChgRNNKvPYRxmUd3+7JpiYj5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euhGju1L; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso4338125276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729537396; x=1730142196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvl5j8GY6xxT48+PDh05t1YeQhkFTt/d7c/rGxhmWmQ=;
        b=euhGju1L5hJFRKHGD9snobvYxQROON2s8dZ5kCVbPXhmyTCZukAhrjCHscHUCOyGuK
         O8K6cIMZh2Ag/llaBH1R7hXHWnVdE+Dw/llaPL62Q+88MaYMGjbU6TEUwzyvf4EcJjEJ
         HGEqVCY/9s5kQFJqKXyCHQi16aX4n22IvIYqebm2spDc5gcrN4eHRtEl8qoq971ghO5U
         IyO1m7+WwS0nJxyfvry8HmIkM0x6kIu1CF4SOanwPLopTZa2ts/UYJA8LHbpW9oQUaYd
         ilRPEBHGoF/QsfuSME5VSE4nPiGtIrL+YODfL+ie1R9cMiSSOaTe4ttMDE6hXDCzNcOi
         YEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729537396; x=1730142196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvl5j8GY6xxT48+PDh05t1YeQhkFTt/d7c/rGxhmWmQ=;
        b=j+Tl+Dosd2QmHOFzva/fRH2CRXG31TInyeTFXrtpzIrDsJEt04GotgzEoi/NKGQR73
         AaxtohmuZUx90x6nXAvVnPOZvKp+bk9I40rIAcDjkWb65yFU6wTsDxUiARolMpBdfAVf
         I3iz4C6emoILMqhjeOgovOERLV7sDd5licQIsjbulWks4es6e3mt33FqRISds7he1QGC
         qZcsq71c4G+lm5Pad//4R5pfwRCBUfYUvhmV5rAufFDDq2LghtUgtUEgTIoa1k8dR6je
         SA2Q+qXJjJCBvkA/WAxp12YGaTvmc2LxNlRjLlOqbXjPKu8oY93i+4hRGM1MFjF9D8A0
         z59g==
X-Forwarded-Encrypted: i=1; AJvYcCUv/DBJLU+eiDhJ+RgP008AruwQO+qS52xlTHfMLgOw4PmPGV8AcMfLSl8MqZ2FyijScCyxZasmWdttjqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoiABb6sm2s8R7KkvcKjvLkP2JV4JcdYtvks3RPHxCr0yq/Ym
	zyF/jByS5kqZhhNo10Pt56W6yLIZMV+0ZRuv4bmJJ3DFYISolv/GyndjtoNggmOUradHQvXYWYs
	LBCJpG+SIOdtNjEIiAEuERe3cljabNzWBtJBDmQ==
X-Google-Smtp-Source: AGHT+IFw6ofUQkqzWyNMI2FtgBN3vvVTDk3qQDpOKITNNWCcXB/ic89esi1afFvp5h98Sem6vY56OuWzqFJAnFUCjYc=
X-Received: by 2002:a05:690c:488a:b0:6e3:28ec:1a7f with SMTP id
 00721157ae682-6e5bf9e81aemr126667917b3.23.1729537396350; Mon, 21 Oct 2024
 12:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930100610.782363-1-shiyongbang@huawei.com>
 <20240930100610.782363-5-shiyongbang@huawei.com> <xeemxeld4cqpx47kzb5qqsawk7mu5kje6r7n335dhe2s7ynw6m@eaiowriiilgr>
 <277b126d-e17c-4ef9-a6fe-56f36061606e@huawei.com>
In-Reply-To: <277b126d-e17c-4ef9-a6fe-56f36061606e@huawei.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 22:03:05 +0300
Message-ID: <CAA8EJpontTXUd0TzvwJZ4gCZ2i6vdB8+PqE+W3ChCuBH3WkfaA@mail.gmail.com>
Subject: Re: [PATCH drm-dp 4/4] drm/hisilicon/hibmc: add dp module in hibmc
To: s00452708 <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, kong.kongxinwei@hisilicon.com, 
	liangjian010@huawei.com, chenjianmin@huawei.com, lidongming5@huawei.com, 
	libaihan@huawei.com, shenjian15@huawei.com, shaojijie@huawei.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 14:54, s00452708 <shiyongbang@huawei.com> wrote:
>
> Thanks, I will modify codes according to your comments, and I also
> replied some questions or reasons why I did it below.
>
> > On Mon, Sep 30, 2024 at 06:06:10PM +0800, shiyongbang wrote:
> >> From: baihan li <libaihan@huawei.com>
> >>
> >> To support DP interface displaying in hibmc driver. Add
> >> a encoder and connector for DP modual.
> >>
> >> Signed-off-by: baihan li <libaihan@huawei.com>
> >> ---
> >>   drivers/gpu/drm/hisilicon/hibmc/Makefile      |   2 +-
> >>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 195 ++++++++++++++++++
> >>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  17 +-
> >>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
> >>   4 files changed, 217 insertions(+), 2 deletions(-)
> >>   create mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> >>

[...]

> >> +
> >> +static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
> >> +{
> >> +    int count;
> >> +
> >> +    count = drm_add_modes_noedid(connector, connector->dev->mode_config.max_width,
> >> +                                 connector->dev->mode_config.max_height);
> >> +    drm_set_preferred_mode(connector, 800, 600); /* default 800x600 */
> > What? Please parse EDID instead.
> > I'll add aux over i2c r/w and get edid functions in next patch.

At least please mention that it's a temporal stub which will be changed later.

> >> +
> >> +    return count;
> >> +}
> >> +

[...]

> >> @@ -116,10 +120,17 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
> >>              return ret;
> >>      }
> >>
> >> +    /* if DP existed, init DP */
> >> +    if ((readl(priv->mmio + DP_HOST_SERDES_CTRL) &
> >> +         DP_HOST_SERDES_CTRL_MASK) == DP_HOST_SERDES_CTRL_VAL) {
> >> +            ret = hibmc_dp_init(priv);
> >> +            if (ret)
> >> +                    drm_err(dev, "failed to init dp: %d\n", ret);
> >> +    }
> >> +
> >>      ret = hibmc_vdac_init(priv);
> >>      if (ret) {
> >>              drm_err(dev, "failed to init vdac: %d\n", ret);
> >> -            return ret;
> > Why?
> > We have two display cables, if VGA cannot work, this change makes DP
> > still work.

But that has nothing to do with init errors. If initialising (aka
probing) VGA fails, then the driver init should fail. At the runtime
the VGA and DP should be independent and it should be possible to
drive just one output, that's true.

-- 
With best wishes
Dmitry

