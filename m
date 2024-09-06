Return-Path: <linux-kernel+bounces-319018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2696F688
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE8C1C21611
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798171CDA31;
	Fri,  6 Sep 2024 14:19:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4A1DFE3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632354; cv=none; b=n04e5d1a7gj+dOUsFHFybG6qsOkFT5IYs85w2njflFUbCFQUzy7NMVmqkrisJNwc+9Riget/vC74Ba2z73r2t20v+OFL4cAqP4rzNwdEdZG6W8lG+o7hv9MhVUyoZ4+e2N+UwAM1xGOT8v7CBISuiopCF1WnGeOzJrgiO7cvRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632354; c=relaxed/simple;
	bh=I582Hf8j53IwMAaTgdqtko4DfVnwcoLOx2FwpWdt3GQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4yybRlZfcp4HEf75Re23lpbXUKOaDWBrGbCY1JhaD9/7z38kQJdxkn0vfhF4sTKbfCKC8PIOS8tvZUFUczQVuQA2aw+8AKKpi0j2JVIn8ULqz0EcBWKF+yVBaiYL2b2o8gipsXKsM93aHYPBrfVf5bi4yoPYjQyzGmdC27O+3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZnh-0002wL-F0; Fri, 06 Sep 2024 16:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZng-005xuF-Dc; Fri, 06 Sep 2024 16:19:00 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1smZng-000ATQ-17;
	Fri, 06 Sep 2024 16:19:00 +0200
Message-ID: <984d928a37b3db11ae53c07da672ccae0d79734f.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/9] reset: amlogic: convert driver to regmap
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Date: Fri, 06 Sep 2024 16:19:00 +0200
In-Reply-To: <20240906-meson-rst-aux-v4-1-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
	 <20240906-meson-rst-aux-v4-1-08824c3d108b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-09-06 at 15:34 +0200, Jerome Brunet wrote:
> To allow using the same driver for the main reset controller and the
> auxiliary ones embedded in the clock controllers, convert the
> the Amlogic reset driver to regmap.
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/reset/reset-meson.c | 79 ++++++++++++++++++++++++---------------=
------

This patch should also make RESET_MESON select REGMAP.

>  1 file changed, 43 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 1e9fca3e30e8..9dd38cc209e2 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -11,36 +11,43 @@
>  #include <linux/of.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> =20
> -#define BITS_PER_REG	32
> -
>  struct meson_reset_param {
>  	int reg_count;
>  	int level_offset;
>  };
> =20
>  struct meson_reset {
> -	void __iomem *reg_base;
>  	const struct meson_reset_param *param;
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock;
> +	struct regmap *map;
>  };
> =20
> +static void meson_reset_offset_and_bit(struct meson_reset *data,
> +				       unsigned long id,
> +				       unsigned int *offset,
> +				       unsigned int *bit)
> +{
> +	unsigned int stride =3D regmap_get_reg_stride(data->map);

You know this is always 4. Having a #define for this (that is also used
to initialize regmap_config.reg_stride, and for now nr_resets, below)
instead of going through an exported function would allow the compiler
to optimize this all away:

> +
> +	*offset =3D (id / (stride * BITS_PER_BYTE)) * stride;
> +	*bit =3D id % (stride * BITS_PER_BYTE);
> +}
> +
>  static int meson_reset_reset(struct reset_controller_dev *rcdev,
> -			      unsigned long id)
> +			     unsigned long id)
>  {
>  	struct meson_reset *data =3D
>  		container_of(rcdev, struct meson_reset, rcdev);
> -	unsigned int bank =3D id / BITS_PER_REG;
> -	unsigned int offset =3D id % BITS_PER_REG;
> -	void __iomem *reg_addr =3D data->reg_base + (bank << 2);
> +	unsigned int offset, bit;
> =20
> -	writel(BIT(offset), reg_addr);
> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
> =20
> -	return 0;
> +	return regmap_write(data->map, offset, BIT(bit));
>  }
> =20
>  static int meson_reset_level(struct reset_controller_dev *rcdev,
> @@ -48,25 +55,13 @@ static int meson_reset_level(struct reset_controller_=
dev *rcdev,
>  {
>  	struct meson_reset *data =3D
>  		container_of(rcdev, struct meson_reset, rcdev);
> -	unsigned int bank =3D id / BITS_PER_REG;
> -	unsigned int offset =3D id % BITS_PER_REG;
> -	void __iomem *reg_addr;
> -	unsigned long flags;
> -	u32 reg;
> +	unsigned int offset, bit;
> =20
> -	reg_addr =3D data->reg_base + data->param->level_offset + (bank << 2);
> +	meson_reset_offset_and_bit(data, id, &offset, &bit);
> +	offset +=3D data->param->level_offset;
> =20
> -	spin_lock_irqsave(&data->lock, flags);
> -
> -	reg =3D readl(reg_addr);
> -	if (assert)
> -		writel(reg & ~BIT(offset), reg_addr);
> -	else
> -		writel(reg | BIT(offset), reg_addr);
> -
> -	spin_unlock_irqrestore(&data->lock, flags);
> -
> -	return 0;
> +	return regmap_update_bits(data->map, offset,
> +				  BIT(bit), assert ? 0 : BIT(bit));

Matter of taste, perhaps, but the BIT() could be moved into
meson_reset_offset_and_bit().

>  }
> =20
>  static int meson_reset_assert(struct reset_controller_dev *rcdev,
> @@ -119,30 +114,42 @@ static const struct of_device_id meson_reset_dt_ids=
[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);
> =20
> +static const struct regmap_config regmap_config =3D {
> +	.reg_bits   =3D 32,
> +	.val_bits   =3D 32,
> +	.reg_stride =3D 4,
> +};
> +
>  static int meson_reset_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct meson_reset *data;
> +	void __iomem *base;
> =20
> -	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> =20
> -	data->reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(data->reg_base))
> -		return PTR_ERR(data->reg_base);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> =20
> -	data->param =3D of_device_get_match_data(&pdev->dev);
> +	data->param =3D of_device_get_match_data(dev);
>  	if (!data->param)
>  		return -ENODEV;
> =20
> -	spin_lock_init(&data->lock);
> +	data->map =3D devm_regmap_init_mmio(dev, base, &regmap_config);
> +	if (IS_ERR(data->map))
> +		return dev_err_probe(dev, PTR_ERR(data->map),
> +				     "can't init regmap mmio region\n");
> =20
>  	data->rcdev.owner =3D THIS_MODULE;
> -	data->rcdev.nr_resets =3D data->param->reg_count * BITS_PER_REG;
> +	data->rcdev.nr_resets =3D data->param->reg_count * BITS_PER_BYTE
> +		* regmap_config.reg_stride;
>  	data->rcdev.ops =3D &meson_reset_ops;
> -	data->rcdev.of_node =3D pdev->dev.of_node;
> +	data->rcdev.of_node =3D dev->of_node;
> =20
> -	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
> +	return devm_reset_controller_register(dev, &data->rcdev);
>  }
> =20
>  static struct platform_driver meson_reset_driver =3D {

regards
Philipp

