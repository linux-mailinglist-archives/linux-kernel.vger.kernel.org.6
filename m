Return-Path: <linux-kernel+bounces-179656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722278C62E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236302831F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3882A4F1EE;
	Wed, 15 May 2024 08:29:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912304EB3C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761753; cv=none; b=OIozuusQuPLdz4yKGTNpyIYgrDxQ0Gf88ZCOJHqU19mt2B4QVRNaCxGi4p9J50r3ipOyiBanjBU5sgipnewG7pOgb6tkM4p6a28AeNaWQHN0ZycXtntozQG/oGeT6JqpwKYQO5YM0vg7vmkmKR8eemITlPTVRirEIyBIzhs0cJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761753; c=relaxed/simple;
	bh=h8JJy40CeScFOY1UfC+uiBwK75aSQ8l/lPgianlVLeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR+nTQMzacENJbN8Uag/KrjexALCrty7Q9DQMZzpzac4KiUxamo37sG/6E7BeqmDxXHilyOc8bf+XJ/Lr3bzgG06MULQDzROZDMP5+N8+UF4Ois0kucZmPPWbkO1N9wv8LhGIh4nEhHsIBsx5/dXbVdrA7Eo1myqmWq0aobQFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s7A0V-0004hv-TA; Wed, 15 May 2024 10:29:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s7A0T-001VCp-G5; Wed, 15 May 2024 10:29:01 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s7A0T-00D0m8-1I;
	Wed, 15 May 2024 10:29:01 +0200
Date: Wed, 15 May 2024 10:29:01 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mtd: nand: mxc_nand: support software ECC
Message-ID: <ZkRyTT7FcDQ-5UeV@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
 <20240514-mtd-nand-mxc-nand-exec-op-v3-3-3e6f45fd3d82@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514-mtd-nand-mxc-nand-exec-op-v3-3-3e6f45fd3d82@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, May 14, 2024 at 04:25:19PM +0200, Sascha Hauer wrote:
> With these changes the driver can be used with software BCH ECC which
> is useful for NAND chips that require a stronger ECC than the i.MX
> hardware supports.
> 
> The controller normally interleaves user data with OOB data when
> accessing the NAND chip. With Software BCH ECC we write the data
> to the NAND in a way that the raw data on the NAND chip matches the
> way the NAND layer sees it. This way commands like NAND_CMD_RNDOUT
> work as expected.
> 
> This was tested on i.MX27 but should work on the other SoCs supported
> by this driver as well.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 73 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> index 6f8b8f4b118ec..ae4cff2584a2d 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1404,10 +1404,10 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
>  	chip->ecc.bytes = host->devtype_data->eccbytes;
>  	host->eccsize = host->devtype_data->eccsize;
>  	chip->ecc.size = 512;
> -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
>  
>  	switch (chip->ecc.engine_type) {
>  	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
>  		chip->ecc.read_page = mxc_nand_read_page;
>  		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
>  		chip->ecc.read_oob = mxc_nand_read_oob;
> @@ -1417,6 +1417,8 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
>  		break;
>  
>  	case NAND_ECC_ENGINE_TYPE_SOFT:
> +		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
> +		chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
>  		break;
>  
>  	default:
> @@ -1472,6 +1474,59 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
>  	return host->devtype_data->setup_interface(chip, chipnr, conf);
>  }
>  
> +static void copy_page_to_sram(struct mtd_info *mtd, const void *buf, int buf_len)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct mxc_nand_host *host = nand_get_controller_data(this);
> +	unsigned int no_subpages = mtd->writesize / 512;
> +	int oob_per_subpage, i;
> +
> +	oob_per_subpage = (mtd->oobsize / no_subpages) & ~1;
> +
> +	/*
> +	 * During a page write the i.MX NAND controller will read 512b from
> +	 * main_area0 SRAM, then oob_per_subpage bytes from spare0 SRAM, then
> +	 * 512b from main_area1 SRAM and so on until the full page is written.
> +	 * For software ECC we want to have a 1:1 mapping between the raw page
> +	 * data on the NAND chip and the view of the NAND core. This is
> +	 * necessary to make the NAND_CMD_RNDOUT read the data it expects.
> +	 * To accomplish this we have to write the data in the order the controller
> +	 * reads it. This is reversed in copy_page_from_sram() below.
> +	 */
> +	for (i = 0; i < no_subpages; i++) {
> +		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
> +		buf += 512;
> +
> +		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
> +			      oob_per_subpage);
> +		buf += oob_per_subpage;
> +	}
> +}

I noticed the nandbiterr test won't work with this. It needs the following
fixup. The problem is that the core wants to write only user data
without OOB, so we have to make sure the remaining SRAM is filled up
with 0xff.

I'll wait some time for other comments before sending a v4 with this
included.

Sascha

-----------------------------8<--------------------------------

From 8287fc3b44c22811350467f00b5652c94a816a36 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 15 May 2024 10:25:29 +0200
Subject: [PATCH] fixup! mtd: nand: mxc_nand: support software ECC

---
 drivers/mtd/nand/raw/mxc_nand.c | 35 ++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index ae4cff2584a2d..9d50f41b3d5a1 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1474,6 +1474,15 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
 	return host->devtype_data->setup_interface(chip, chipnr, conf);
 }
 
+static void memff16_toio(void *buf, int n)
+{
+	__iomem u16 *t = buf;
+	int i;
+
+	for (i = 0; i < (n >> 1); i++)
+		__raw_writew(0xffff, t++);
+}
+
 static void copy_page_to_sram(struct mtd_info *mtd, const void *buf, int buf_len)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
@@ -1492,14 +1501,34 @@ static void copy_page_to_sram(struct mtd_info *mtd, const void *buf, int buf_len
 	 * necessary to make the NAND_CMD_RNDOUT read the data it expects.
 	 * To accomplish this we have to write the data in the order the controller
 	 * reads it. This is reversed in copy_page_from_sram() below.
+	 *
+	 * buf_len can either be the full page including the OOB or user data only.
+	 * When it's user data only make sure that we fill up the rest of the
+	 * SRAM with 0xff.
 	 */
 	for (i = 0; i < no_subpages; i++) {
-		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
+		int now = min(buf_len, 512);
+
+		if (now)
+			memcpy16_toio(host->main_area0 + i * 512, buf, now);
+
+		if (now < 512)
+			memff16_toio(host->main_area0 + i * 512 + now, 512 - now);
+
 		buf += 512;
+		buf_len -= now;
+
+		now = min(buf_len, oob_per_subpage);
+		if (now)
+			memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len,
+				      buf, now);
+
+		if (now < oob_per_subpage)
+			memff16_toio(host->spare0 + i * host->devtype_data->spare_len + now,
+				     oob_per_subpage - now);
 
-		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
-			      oob_per_subpage);
 		buf += oob_per_subpage;
+		buf_len -= now;
 	}
 }
 
-- 
2.39.2



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

