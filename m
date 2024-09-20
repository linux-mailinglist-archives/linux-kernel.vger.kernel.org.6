Return-Path: <linux-kernel+bounces-334171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012D297D375
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC843282711
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6713A268;
	Fri, 20 Sep 2024 09:10:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDA139D13
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726823437; cv=none; b=e9BFplEM056p/osT9MxeaGHN20bc/2RVyP7CX6XJ9uQreCPrln0bvPW1BA7MbkoSKJlykayHEGlET2t5qYGWKVq2kaVgdYO38eXH/sFHr+f+B1Yxvhs9JFxapLYnt4aJj1zc4JvWEI5Cn4NIRwr4rm2vTcPC2ipDG4Ql3+n3iF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726823437; c=relaxed/simple;
	bh=DgJEbKRUNdBaOZ1pwvlSKrNJaayM+9t0IHIxvuNr7Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWNikUdEW2B1KzI43gvbHdkz6iL8fA2hDLcAydldsdCHsg0Z5FYuuO0tLHOJlX7pTu3cKX5zHgGfHWz8buiTIJYkq+R0pH/Z4+/GzPunlRIg6PIZwCHm492PFy1NwFK8btRIWSe+AH/FEeDMVbn19G4orFjcsmRU8S9hA0/16dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1srZeN-0007IG-6w; Fri, 20 Sep 2024 11:10:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1srZeJ-000Dah-Pf; Fri, 20 Sep 2024 11:09:59 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1srZeJ-001rh8-2C;
	Fri, 20 Sep 2024 11:09:59 +0200
Date: Fri, 20 Sep 2024 11:09:59 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] mtd: spi-nor: support vcc-supply regulator
Message-ID: <20240920090959.67y7h57yirtahfuh@pengutronix.de>
References: <20240920-spi-v1-0-97f220c2e10c@nxp.com>
 <20240920-spi-v1-2-97f220c2e10c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920-spi-v1-2-97f220c2e10c@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-09-20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> spi nor flash needs power supply to work properly. The power supply
> maybe software controllable per board design. So add the support
> for an optional vcc-supply regulator.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mtd/spi-nor/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 9d6e85bf227b..0449afe6bb20 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/mtd/spi-nor.h>
>  #include <linux/mutex.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -3462,6 +3463,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
>  
> +	ret = devm_regulator_get_enable_optional(dev, "vcc");
> +	if (ret)

This returns -ENODEV if no regulator was specified. In general all
SPI-NOR devices need a VCC supply, so don't use the regulator optional
API here, please check the regulator API doc.

In contrast to that the dt-bindings should have the vcc-supply as
optional to not cause a regression for exisiting systems.

Regards,
  Marco

> +		return ret;
> +
>  	ret = spi_nor_hw_reset(nor);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.37.1
> 
> 
> 

