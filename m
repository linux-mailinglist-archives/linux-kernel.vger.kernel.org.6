Return-Path: <linux-kernel+bounces-335477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0897E63F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7083E1F215FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861E1381D9;
	Mon, 23 Sep 2024 06:57:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969952940D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074627; cv=none; b=GkVNK7eYh7m4EV1NiHLiKJqXMXhHUHZNDieXJ8f8Zb2ZWkW2LopxgRow6JoWdKqbOZ4Sqq35Mn9slaTH6XDhqVP1RC98z935OrlQ3Oy42bN0yOMJkObQC0D1JsN8z+P9T9mDFy35CbFqSy7Gm3iC317q0+F/b+Yz2GFgfu/kAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074627; c=relaxed/simple;
	bh=gARsj6RaIqK+2FBXnjH/v3nbNbDt2tLudUzos7LWYkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+ya8Yp5AR4gBl232/TZry1m8GCdSdCwK6EDRR3ygFiYzESqIhRc/0TqM3V8X6XcOslYKdqwMQEMxFH+7tg2PG7T2r2wLv85d2jm67sdaYZZfvBopr0bD7TdWr0ZUcD4KJ7VmXXP1pZ8RP/Cy29WZaNMYXwSTs31XC+ZHKjTSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1ssczs-0000bS-CI; Mon, 23 Sep 2024 08:56:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1ssczr-000teD-7N; Mon, 23 Sep 2024 08:56:35 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1ssczr-007QLc-0P;
	Mon, 23 Sep 2024 08:56:35 +0200
Date: Mon, 23 Sep 2024 08:56:35 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Hui-Ping Chen <hpchen0nvt@gmail.com>, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, esben@geanix.com,
	linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <ZvERI9fscLBC09_F@pengutronix.de>
References: <20240920063749.475604-1-hpchen0nvt@gmail.com>
 <20240920063749.475604-3-hpchen0nvt@gmail.com>
 <9245120b-9901-45c3-9a6e-600653f94bba@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9245120b-9901-45c3-9a6e-600653f94bba@marvell.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Amit,

On Mon, Sep 23, 2024 at 01:19:03AM +0530, Amit Singh Tomar wrote:
> Hi,
> 
> > +static int ma35_nand_do_write(struct nand_chip *chip, const u8 *addr, u32 len)
> > +{
> > +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +	dma_addr_t dma_addr;
> > +	int ret = 0, i;
> > +	u32 reg;
> > +
> > +	if (len != mtd->writesize) {
> > +		for (i = 0; i < len; i++)
> > +			writel(addr[i], nand->regs + MA35_NFI_REG_NANDDATA);
> > +		return 0;
> > +	}
> > +
> > +	ma35_nand_dmac_init(nand);
> > +
> > +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> > +
> > +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
> > +	/* To mark this page as dirty. */
> > +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
> > +	if (reg & 0xffff0000)
> > +		writel(reg & 0xffff, nand->regs + MA35_NFI_REG_NANDRA0);
> > +
> > +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_TO_DEVICE);
> > +	ret = dma_mapping_error(nand->dev, dma_addr);
> > +	if (ret) {
> > +		dev_err(nand->dev, "dma mapping error\n");
> > +		return -EINVAL;
> Shouldn't this return -ENOMEM or simply ret when there's an error? Also,
> should we consider unmapping the page with dma_unmap_single in that case?

When dma_map_single() returns an error the pages are not mapped, no
need to unmap then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

