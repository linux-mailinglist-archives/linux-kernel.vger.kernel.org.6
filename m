Return-Path: <linux-kernel+bounces-177399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6728C3DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD34C1C214ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19051487CD;
	Mon, 13 May 2024 09:19:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D214830A
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591985; cv=none; b=QW6gSCrYdXO73t57h30i84U5YE2Oxv781PLhWGjEKNJKOJ8r4q1y9/p6AKBWWzqJRSNpSsl3JTCSbK4e6WwZJWaHShB93aw3xt0MG0B2BAHdMN6flkoa8oipgIsRkFqtjCtvHt2iFx4I7N+NmUbrJM+YXqxuTTOQyZvtQd3DVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591985; c=relaxed/simple;
	bh=PjwBmQHTHh/yc6AW42sNAytsgWZr1G98mAsrKpYIuAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5k4wevRoLiPmIWZmIfnFVh8D/HIyPA2JJ8HYA0UXa6nnlwhbNNB89B7hQ8ezQgjb0Uk53wWvs1kEwpga4wCMnGzpND7IdHPIVyu8n1lVQAFCsSoiBSfNHomwOHvCJ9Dkqua0La7PL7/daN3x29UvveucW+2vYFlnQMRow48KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6RqL-00069R-KZ; Mon, 13 May 2024 11:19:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6RqK-0018sg-M6; Mon, 13 May 2024 11:19:36 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6RqK-009RDT-1v;
	Mon, 13 May 2024 11:19:36 +0200
Date: Mon, 13 May 2024 11:19:36 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mtd: nand: mxc_nand: support software ECC
Message-ID: <ZkHbKGAuBPN3KOVW@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
 <20240508-mtd-nand-mxc-nand-exec-op-v2-3-6b7366b7831f@pengutronix.de>
 <20240513094217.4c1a0fc2@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513094217.4c1a0fc2@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, May 13, 2024 at 09:42:17AM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> s.hauer@pengutronix.de wrote on Wed, 08 May 2024 13:08:29 +0200:
> 
> > With these changes the driver can be used with software BCH ECC which
> > is useful for NAND chips that require a stronger ECC than the i.MX
> > hardware supports.
> > 
> > The controller normally interleaves user data with OOB data when
> > accessing the NAND chip. With Software BCH ECC we write the data
> > to the NAND in a way that the raw data on the NAND chip matches the
> > way the NAND layer sees it. This way commands like NAND_CMD_RNDOUT
> > work as expected.
> > 
> > This was tested on i.MX27 but should work on the other SoCs supported
> > by this driver as well.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/raw/mxc_nand.c | 84 ++++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 75 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> > index 1e8b4553e03ba..7004fd57c80f7 100644
> > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > @@ -178,6 +178,7 @@ struct mxc_nand_host {
> >  	int			used_oobsize;
> >  	int			active_cs;
> >  	unsigned int		ecc_stats_v1;
> > +	unsigned int		column;
> >  
> >  	struct completion	op_completion;
> >  
> > @@ -1397,10 +1398,10 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
> >  	chip->ecc.bytes = host->devtype_data->eccbytes;
> >  	host->eccsize = host->devtype_data->eccsize;
> >  	chip->ecc.size = 512;
> > -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> >  
> >  	switch (chip->ecc.engine_type) {
> >  	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> > +		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> >  		chip->ecc.read_page = mxc_nand_read_page;
> >  		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
> >  		chip->ecc.read_oob = mxc_nand_read_oob;
> > @@ -1465,6 +1466,54 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
> >  	return host->devtype_data->setup_interface(chip, chipnr, conf);
> >  }
> >  
> > +static void copy_page_to_sram(struct mtd_info *mtd)
> > +{
> > +	struct nand_chip *this = mtd_to_nand(mtd);
> > +	struct mxc_nand_host *host = nand_get_controller_data(this);
> > +	void *buf = host->data_buf;
> > +	unsigned int n_subpages = mtd->writesize / 512;
> > +	int oob_per_subpage, i;
> > +
> > +	/* mtd->writesize is not set during ident scanning */
> > +	if (!n_subpages)
> > +		n_subpages = 1;
> > +
> > +	oob_per_subpage = (mtd->oobsize / n_subpages) & ~1;
> > +
> > +	for (i = 0; i < n_subpages; i++) {
> > +		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
> > +		buf += 512;
> > +
> > +		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
> > +			      oob_per_subpage);
> > +		buf += oob_per_subpage;
> > +	}
> > +}
> > +
> > +static void copy_page_from_sram(struct mtd_info *mtd)
> > +{
> > +	struct nand_chip *this = mtd_to_nand(mtd);
> > +	struct mxc_nand_host *host = nand_get_controller_data(this);
> > +	void *buf = host->data_buf;
> > +	unsigned int n_subpages = mtd->writesize / 512;
> > +	int oob_per_subpage, i;
> > +
> > +	/* mtd->writesize is not set during ident scanning */
> > +	if (!n_subpages)
> > +		n_subpages = 1;
> > +
> > +	oob_per_subpage = (mtd->oobsize / n_subpages) & ~1;
> > +
> > +	for (i = 0; i < n_subpages; i++) {
> > +		memcpy16_fromio(buf, host->main_area0 + i * 512, 512);
> > +		buf += 512;
> > +
> > +		memcpy16_fromio(buf, host->spare0 + i * host->devtype_data->spare_len,
> > +				oob_per_subpage);
> > +		buf += oob_per_subpage;
> > +	}
> > +}
> > +
> >  static int mxcnd_exec_op(struct nand_chip *chip,
> >  			 const struct nand_operation *op,
> >  			 bool check_only)
> > @@ -1496,8 +1545,11 @@ static int mxcnd_exec_op(struct nand_chip *chip,
> >  			 */
> >  			break;
> >  		case NAND_OP_CMD_INSTR:
> > -			if (instr->ctx.cmd.opcode == NAND_CMD_PAGEPROG)
> > +			if (instr->ctx.cmd.opcode == NAND_CMD_PAGEPROG) {
> > +				if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST)
> > +					copy_page_to_sram(mtd);
> >  				host->devtype_data->send_page(mtd, NFC_INPUT);
> > +			}
> 
> Same as before: data moves should not happen here.
> 
> >  
> >  			host->devtype_data->send_cmd(host, instr->ctx.cmd.opcode, true);
> >  
> > @@ -1506,6 +1558,8 @@ static int mxcnd_exec_op(struct nand_chip *chip,
> >  			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
> >  				statusreq = true;
> >  
> > +			host->column = 0;
> > +
> 
> This is risky but maybe this is the trick to get NAND_CMD_RNDOUT
> working? If yes maybe it is worth separating from this patchset, if
> possible, with a comment explaining what this is all about (the
> controller's SRAM being some kind of 1:1 mapping with the NAND SRAM,
> thus we need to write the data at the correct offset in the controller
> SRAM, I guess?).

I don't think it's possible to separate introducing the host->column
variable to a separate patch, because this variable is only used with
NAND_ECC_ENGINE_TYPE_SOFT and on the other hand NAND_ECC_ENGINE_TYPE_SOFT
only works with this variable.

Anyway, adding a description what this is all about is a good idea and
I'll do this. In fact I already tried to add one when I found out that
it's really hard to put it into words, so I sent without it ;)

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

