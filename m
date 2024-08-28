Return-Path: <linux-kernel+bounces-305242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0252962BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE77285E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E81AB538;
	Wed, 28 Aug 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meTAqnNk"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4021AB535
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857907; cv=none; b=QVA7wo0BafIuDxrfmwPRRjkDPkmMyLQvRjh15fV1+YzxPyW7HpcaFriC3v/kpv4aU8YTZYbnDsChp0LbIVgAHdbvl/39Vo8/5W/m/wgXNjMC9/0URUOAnFNHuqIxg2vG6iYtWR+3J8grrRqpqhMNIpTvJL7zIXjaHKQYsqIl6Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857907; c=relaxed/simple;
	bh=QpYhBzV+yaoDBMQ/fcOQAAYHC+gX2LXKD1fp6vi2ZHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh6UaMu5PzngoCDbLgjFnTcXcYVbMfk1ANb1EwT2Y/zc0OIIwvHsVXTzr9NRe6IoiX7kP8+q7sWZpX8UX4P9UPfTm5Ytou8Oedj3OUNW6L/72tDsSsJzHBc/TANo6icNCNvhRVrbtSboCPpvgypyppAw+ZcPcvFVjT2gShpAVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=meTAqnNk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e116ec43a4aso7704511276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724857905; x=1725462705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpwE48l/IMh8SOpKCeyLL7/+QtmITVgAbzW4ivc7bD4=;
        b=meTAqnNkRGepbBwLFrXocK+AsCzDenOFcmh8Cdie03n5XkbyRiwvjbW++N2zEnE1xO
         UhnUvIBBC3uzzk6jqdAwFIg/QAYFLNe435SmdOSh9F56/NhUua4QgL/dYzlTpNQFH/TD
         b3PEpLytTLfSPVrAWkdsMKDmRWHzALrgef6Tyk0EI21QpConft3WRGczAdDd44S5G5UB
         aoSA7L81+Dzx5riHz3+ZRFmLRPk3bTlyW+LXyZtRghnYAr9z3r4CKNLEBVNLXswhjG9+
         WEhM+D1ULv2H5in7uXgcMDnk/nh/gJKbZvHGZ5TJBPZiXkb+truPZ06qwJanTFwsYanw
         Ofqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857905; x=1725462705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpwE48l/IMh8SOpKCeyLL7/+QtmITVgAbzW4ivc7bD4=;
        b=sqWcjHRn9kqfVevLZHkB3O2xBzwCeHdf98rhWZbGjBLBRtbvwlJNU/w/9ox10es9LK
         NvudU/+NbNAO/XVNKZnpGQHhiTXo8IOSAgwk/SmOGnw5vp4DfaTkI2WVO1VdUSmX1KPS
         AtIPf4RSu0t0fAVHAwVD7FzDw/JKBvRg8/ZWGPgRjHtnO86bZbXlFbWAEVu12DWS4FaK
         CCUqLVi+OfmiB2J1s7I+x5I8tKYQHx13sb8pS9RvjyN1G/kUp56SHkazSP/WGo+xzJWw
         Pig+HD9ODBrHB6Rol5IIkd1HHdhH4wAYPH3DO7BppPxrOWeaMe0SBmUuTbHGE2h5cg+z
         64UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHO/ixb4flEaKkWN7k1NfPE1+r/9VFlxmG+JZgqdSqVMESxLGGbeGdGI8LN30b4Dw0203668Ee7aqQcF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5KEW+gkdRYJh9UdAozsucYzzeqCHkB6AuJN+4D4ovbmOIblFE
	dF1t4XmvcZZqfgrjgsk3C/ICiXzZBXOv7Bvw1NMsOkOxQSwzUXPPXbADIsOHWMPeV99SeZOCuxP
	hYtkmUeCNUNEWWff2Mq7OAHCx+xEmDFzjmWembg==
X-Google-Smtp-Source: AGHT+IE7CB9ls1GFKOjrUzbw5hOqUHyf+hifGdDexmkraaeqpfoek/di3j2sJAd4cp3CeBhWE+mU/vMmQSms6tlNdzU=
X-Received: by 2002:a05:6902:1683:b0:e0b:3c9d:12bb with SMTP id
 3f1490d57ef6-e17a83bcb51mr19054563276.12.1724857905103; Wed, 28 Aug 2024
 08:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:11:08 +0200
Message-ID: <CAPDyKFrN9L+u_X7Ur+j--i-tewd31EXzwCojOP+Sxuyxpk4Phg@mail.gmail.com>
Subject: Re: [PATCH 0/9] mmc: convert to devm_clk_get_enabled() API
To: zhangxirui <xirui.zhang@vivo.com>
Cc: Robert Richter <rric@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Michal Simek <michal.simek@amd.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 09:34, zhangxirui <xirui.zhang@vivo.com> wrote:
>
> This series use devm_clk_get_enabled() to simplify code
> and avoids the calls to clk_disable_unprepare()

I agree that it simplifies code - but it also changes the behaviour,
in which order clocks are getting unprepared/disabled during the
->remove() phase. In other words, this needs to be thoroughly tested
and not just considered as a trivial cleanup series.

For example, if there is a PM domain attached to the mmc host device,
is it really okay to allow powering-off the PM domain before the
clocks are being gated? This could potentially happen if we apply the
$subject series.

Kind regards
Uffe

>
> zhangxirui (9):
>   mmc: cavium-thunderx: Use devm_clk_get_enabled() helpers
>   mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
>   mmc: dw_mmc-hi3798cv200: Use devm_clk_get_enabled() helpers
>   mmc: mvsdio: Use devm_clk_get_enabled() helpers
>   mmc: mxcmmc: Use devm_clk_get_enabled() helpers
>   mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
>   mmc: sdhci: milbeaut: Use devm_clk_get_enabled() helpers
>   mmc: sdhci-of-arasan: Use devm_clk_get_enabled() helpers
>   mmc: sdhci_f_sdh30: Use devm_clk_get_enabled() helpers
>
>  drivers/mmc/host/cavium-thunderx.c    |  7 +-----
>  drivers/mmc/host/davinci_mmc.c        |  8 +-----
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 28 +++------------------
>  drivers/mmc/host/mvsdio.c             | 13 +++-------
>  drivers/mmc/host/mxcmmc.c             | 25 +++----------------
>  drivers/mmc/host/mxs-mmc.c            | 13 +++-------
>  drivers/mmc/host/sdhci-milbeaut.c     | 25 +++----------------
>  drivers/mmc/host/sdhci-of-arasan.c    | 31 ++++-------------------
>  drivers/mmc/host/sdhci_f_sdh30.c      | 36 ++++++++-------------------
>  9 files changed, 35 insertions(+), 151 deletions(-)
>
> --
> 2.25.1
>

