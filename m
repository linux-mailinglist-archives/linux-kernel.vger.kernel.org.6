Return-Path: <linux-kernel+bounces-194830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839468D42A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B43BD1C210BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10888E56C;
	Thu, 30 May 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAU4jijR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196028FA;
	Thu, 30 May 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030910; cv=none; b=WK6983ugcKfnmuxCp5+3Ske+CcxklZKLSDcPS0TeGPFsDgDp/jNRY9qjfn7BDXx6EdNxT7lyu4BYmBXV260Rv/fRLn9Ro6byIsbCXuqwJMAw4ydwmrmYtwVDrCIgMZWEY77LbGEmav0Y7HhJxex5OihMNxdjD+DzHsmNnkCEzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030910; c=relaxed/simple;
	bh=cJmlKGOTHQ+BuDd8duP8qVpIxhVbfAXEM3GOcqyoUNM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=lDwYSIKU7tQERdAGuJEif7pdJF4t6f4+AwUFmfU4FPrJuJIiKPacG1zMMhYubA6yPmp75oy83kYltUNO1nXuQb6J4oMxZLdXaQv8fDC40ALC7qkvSOaIz2h1xGKy2QaOGeYFC1FrUUoK0wTndpAsorLcDQdPbW1YFvqCgnCrpRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAU4jijR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB83FC113CC;
	Thu, 30 May 2024 01:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717030909;
	bh=cJmlKGOTHQ+BuDd8duP8qVpIxhVbfAXEM3GOcqyoUNM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UAU4jijRZ/Fq/r8kmyA+N+BqLvcBIjDf3ftlLK35kx2DX0kVbKcs2+p+rpGdy95Uy
	 vKiGifkrQ7mrTj9+gzKxHWt9ILNfGCLcQJkW2eSN+n7m8jqWDVOuRzJrAgcWyM7ofr
	 iYNy293DqaDz/XA0Q0oJrDWvOwP55jPNxcXn5KYyOaeAhxjWeYEi//kRwrCD5Cawf6
	 qPovzCywNwNnJ1hNSU6KXMs9ieNwBYzy3yYWId/d5+cHYXNRXaTaJ9puKJmbMTDbDj
	 0KPA9h/B+fFTjnr/8PmakSWOJpdvjjF8GIu8v4/EpUhXxCFULUVUxZEv2ZoI+6DZ9Y
	 9zL1LABWQTbbQ==
Message-ID: <68518f93af68cbc0153c8bd765dc885f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240516150842.705844-9-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com> <20240516150842.705844-9-jbrunet@baylibre.com>
Subject: Re: [RFC PATCH 8/9] clk: meson: add auxiliary reset helper driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 29 May 2024 18:01:47 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-05-16 08:08:38)
> Add an helper module to register auxiliary reset drivers from
> Amlogic clock controller.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/Kconfig             |  5 ++
>  drivers/clk/meson/Makefile            |  1 +
>  drivers/clk/meson/meson-clk-rst-aux.c | 84 +++++++++++++++++++++++++++
>  drivers/clk/meson/meson-clk-rst-aux.h | 14 +++++
>  4 files changed, 104 insertions(+)
>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.c
>  create mode 100644 drivers/clk/meson/meson-clk-rst-aux.h
>=20
> diff --git a/drivers/clk/meson/meson-clk-rst-aux.h b/drivers/clk/meson/me=
son-clk-rst-aux.h
> new file mode 100644
> index 000000000000..386a55a36cd9
> --- /dev/null
> +++ b/drivers/clk/meson/meson-clk-rst-aux.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2024 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + */
> +
> +#ifndef __MESON_CLK_RST_AUX_H
> +#define __MESON_CLK_RST_AUX_H
> +
> +int devm_meson_clk_rst_aux_register(struct device *dev,
> +                                   struct regmap *map,
> +                                   const char *adev_name);

I'd prefer we move the device creation and registration logic to
drivers/reset as well. See commit 098c290a490d ("clock, reset:
microchip: move all mpfs reset code to the reset subsystem") for some
inspiration.

One thing I haven't really thought about too much is if they're two
different modules. One for clk and one for reset. If the device
registration API is a symbol the clk module depends on then maybe that
is better because it means both modules are loaded, avoiding a
round-trip through modprobe. It also makes sure that the drivers are
either both builtin or both modular.

