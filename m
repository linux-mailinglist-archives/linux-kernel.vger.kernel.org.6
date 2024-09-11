Return-Path: <linux-kernel+bounces-325699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A2975D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3881B21CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78909181BA8;
	Wed, 11 Sep 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0GYmNqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6DD1E4B2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094771; cv=none; b=BpMibOVX3a44Rj/cXblVmLGktqDWrDXyHcoATzAgilK2Xg7VipdxDm3VWBTCeuHJ80LLRbqtQ2Mu9Y3zGHjjflsgh3vI63EveUInts5GUgM1GPAMoeHHv4mWRYlITaaY372+ndKjLMpVt7A2cdI8rvhqAjk98OjT424C3/sACHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094771; c=relaxed/simple;
	bh=SaVjiMHqiWEHtkoLIIuw8TcnbIgrRnECfxJOrUPR8xI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CuTNNJlNTjB0zcFqj+NRHSL0ksdt1fogZUekthzJwVI8obA/GYUXlPgYVg6LXD0l8Aw8AfFgrdhz7WvvcdDIIbbi82tZ8GXmopU7FHKT2g+fapsRvQ2ZkO6EtYp87rA7pyL+O8pPekkhLQh63o5qRTH2Fe1Cq1ybYFEwjlJYzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0GYmNqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6836BC4CEC0;
	Wed, 11 Sep 2024 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726094771;
	bh=SaVjiMHqiWEHtkoLIIuw8TcnbIgrRnECfxJOrUPR8xI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=u0GYmNqRgoRxJ6efGKOAi3dPZBvNUc0aA3Npu2UWvA7oaYkb4CwGWgKHB08u9qSUO
	 0l9pFkxdznvH5TbyVZqsDl+MlrM0j0cyYqjimYKo/TEj0+YvB7gvFOlK4y/2ANjqKL
	 dHD6+dieCWHOhqIEcO0PpqnAToLawKYG2847n5aako4x9Ay0Gr0K/6J7TmW7lWNGmR
	 C/5JJ2a33NtAz+l/VOwA3tyYeImYAyCLVXzwUdrVjOmJbK44g93Cc5eMi7WxX98yDN
	 /eSp1yXxQywX/Tq7qiDOX5uHrlyU6p0zDDLySmZbQLc3lfHuUzACufC5CcEqU6Funw
	 1RnGxQkDKuMoQ==
Message-ID: <080600661d43e4c39ea4b20b05e3e141.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240909-ep93xx-v12-2-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me> <20240909-ep93xx-v12-2-e86ab2423d4b@maquefel.me>
Subject: Re: [PATCH v12 02/38] ARM: ep93xx: add regmap aux_dev
From: Stephen Boyd <sboyd@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Nikita Shubin <nikita.shubin@maquefel.me>, Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 11 Sep 2024 15:46:09 -0700
User-Agent: alot/0.10

Quoting Nikita Shubin via B4 Relay (2024-09-09 01:10:27)
> diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus=
/ep93xx.h
> index 56fbe2dc59b1..a27447971302 100644
> --- a/include/linux/soc/cirrus/ep93xx.h
> +++ b/include/linux/soc/cirrus/ep93xx.h
> @@ -3,6 +3,18 @@
>  #define _SOC_EP93XX_H
> =20
>  struct platform_device;
> +struct regmap;
> +struct spinlock_t;
> +
> +enum ep93xx_soc_model {
> +       EP93XX_9301_SOC,
> +       EP93XX_9307_SOC,
> +       EP93XX_9312_SOC,
> +};
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/compiler_types.h>
> +#include <linux/container_of.h>
> =20
>  #define EP93XX_CHIP_REV_D0     3
>  #define EP93XX_CHIP_REV_D1     4
> @@ -10,6 +22,20 @@ struct platform_device;
>  #define EP93XX_CHIP_REV_E1     6
>  #define EP93XX_CHIP_REV_E2     7
> =20
> +struct ep93xx_regmap_adev {
> +       struct auxiliary_device adev;
> +       struct regmap *map;
> +       void __iomem *base;
> +       spinlock_t *lock;
> +       void (*write)(struct regmap *map, spinlock_t *lock, unsigned int =
reg,
> +                     unsigned int val);
> +       void (*update_bits)(struct regmap *map, spinlock_t *lock,
> +                           unsigned int reg, unsigned int mask, unsigned=
 int val);
> +};

Why can't the single 'struct regmap' be passed as the auxiliary device's
platform_data? The lock could be put into the regmap locking routines
and the write/update_bits would be standard regmap API calls. Doing that
would make the auxiliary device driver simpler because it wouldn't
depend on this struct.

The device name could encode the SoC number as well so the auxiliary
device driver could match different names and do different things.

