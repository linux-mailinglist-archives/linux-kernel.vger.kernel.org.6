Return-Path: <linux-kernel+bounces-248354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B804992DC15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7232F2817C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6411F14AD3B;
	Wed, 10 Jul 2024 22:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2G6n3eI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D714A605;
	Wed, 10 Jul 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720651781; cv=none; b=h00owo4fnJ3GVzeG2NsMXOl2+vdmzNFs+UpO9Nw0heDfy6oA51APkA/tsnzNKO8WR4UHSqElwkWAP7jxu9etTqvgRJSQcyaQy0zo8smQaDZ2lZq19FGlNw92jFD+RjMrAibEAjz/NMeNqMFp/QlIQhqpgNYPrIHP5MhYfGP+N2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720651781; c=relaxed/simple;
	bh=duthhsCiMaf6+uYQBqrPWZwMJtFLktyeXPQfhoZLBK8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rBwWkh421+kK/rXSH7FEJAPGJyXYjeERtv5h6/8po75mcCjhx+gm3qI2k5OeKR2D6kd7JLGYqcUQ2SOFS8OC2i/YsReheUxrsZyYOx05UuYOxOzf/cdP6SutYBsXfh0s4z+4gQC62BwLw0E1+fYFHX86wyRbPXi86uoqsEd1Jmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2G6n3eI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5EDC32781;
	Wed, 10 Jul 2024 22:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720651781;
	bh=duthhsCiMaf6+uYQBqrPWZwMJtFLktyeXPQfhoZLBK8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=l2G6n3eIgTuRCXBmGTi2GFdLbX8g+Hpmz0n3jJIxIdhxE0yB9zIb47iyYSje/PRnf
	 v6XPBi0MN4jip4cMkBo6D/ua15qWgK0WouDNoKaTygqPzzbXEjDLBPnLnldXlMxPaP
	 Yv9idnlkozzWfdTqb3Wz9XQ2rbdBJ5Ro1LqZfQCadRLRMe1kgB0SeLwg5KiVc9IYQ2
	 D276Iq6wWTeLP8WsmPvrxx0OLP/E7p/QDhUD0/qn8a7fQ6BIyaaZ4S9J5bGutsB9ui
	 CAQLezJIEKyU/Ioa2HSdeViffBVLFOPdMlJDhkDUpAaL8CcyGmk9JqE1h/4OqLsPYi
	 yGgq/EZYVsAWQ==
Message-ID: <88d1dbd92e922ad002367d8dac67d0eb.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710162526.2341399-8-jbrunet@baylibre.com>
References: <20240710162526.2341399-1-jbrunet@baylibre.com> <20240710162526.2341399-8-jbrunet@baylibre.com>
Subject: Re: [PATCH 7/8] reset: amlogic: add auxiliary reset driver support
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Jan Dakinevich <jan.dakinevich@salutedevices.com>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 10 Jul 2024 15:49:38 -0700
User-Agent: alot/0.10

Quoting Jerome Brunet (2024-07-10 09:25:16)
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index e34a10b15593..5cc767d50e8f 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
[...]
> +
> +int devm_meson_rst_aux_register(struct device *dev,
> +                               struct regmap *map,
> +                               const char *adev_name)
> +{
> +       struct meson_reset_adev *raux;
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       raux =3D kzalloc(sizeof(*raux), GFP_KERNEL);
> +       if (!raux)
> +               return -ENOMEM;
> +
> +       ret =3D ida_alloc(&meson_rst_aux_ida, GFP_KERNEL);

Do we expect more than one device with the same name? I wonder if the
IDA can be skipped.

> +       if (ret < 0)
> +               goto raux_free;
> +
> +       raux->map =3D map;
> +
> +       adev =3D &raux->adev;
> +       adev->id =3D ret;
> +       adev->name =3D adev_name;
> +       adev->dev.parent =3D dev;
> +       adev->dev.release =3D meson_rst_aux_release;
> +       device_set_of_node_from_dev(&adev->dev, dev);
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret)
> +               goto ida_free;
> +
> +       ret =3D __auxiliary_device_add(adev, dev->driver->name);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(dev, meson_rst_aux_unregister_ade=
v,
> +                                       adev);
> +
> +ida_free:
> +       ida_free(&meson_rst_aux_ida, adev->id);
> +raux_free:
> +       kfree(raux);
> +       return ret;
> +

Nitpick: Drop extra newline?

> +}
> +EXPORT_SYMBOL_GPL(devm_meson_rst_aux_register);
> +
> +MODULE_DESCRIPTION("Amlogic Meson Reset driver");
>  MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> +MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
>  MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/soc/amlogic/meson-auxiliary-reset.h b/include/soc/am=
logic/meson-auxiliary-reset.h
> new file mode 100644
> index 000000000000..8fdb02b18d8c
> --- /dev/null
> +++ b/include/soc/amlogic/meson-auxiliary-reset.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_AMLOGIC_MESON_AUX_RESET_H
> +#define __SOC_AMLOGIC_MESON_AUX_RESET_H
> +
> +#include <linux/err.h>
> +
> +struct device;
> +struct regmap;
> +
> +#ifdef CONFIG_RESET_MESON
> +int devm_meson_rst_aux_register(struct device *dev,
> +                               struct regmap *map,
> +                               const char *adev_name);
> +#else
> +static inline int devm_meson_rst_aux_register(struct device *dev,
> +                                             struct regmap *map,
> +                                             const char *adev_name)
> +{
> +       return -EOPNOTSUPP;

Shouldn't this be 'return 0' so that the clk driver doesn't have to care
about the config?

