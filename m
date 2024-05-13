Return-Path: <linux-kernel+bounces-177385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933ED8C3DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B445283E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE51487FE;
	Mon, 13 May 2024 09:09:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4514831C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715591347; cv=none; b=ru4SlWY8j1/LVxi9gTX7zgqhZAYbKDVftQry6k/qUffL/AGtm4r29qVCcfqCcZnZztH0sRe+pX09eFpG37qO+vYbDSia/g+LjN6l7DUkSQQh75RsutanAnJ9Prw7Df5t7juFDc6x9ks/6JlOnOesWJgZCJ4R5eMK4hzQ54+tx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715591347; c=relaxed/simple;
	bh=sbh6ASvzgtzWwW72bT4wmulKeqbsrA4U0esMJnF2a08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM8cNgxuse79V2PWQv8uvX7SntQcKcDcFmCoEr5VVvKa9exZPIdqGE4vz/pdqhmns3Ue85ZKdA6MUPEkrKk/wIpSJ4IlLDP8K+I8CWMuJfoISDyp//tX9N3Xb7VUs9ROSPXVUTMmLOJ9GAS7Vu1mxfwJUmRMDgU2mTn9nQQwouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Rfx-0003kD-GW; Mon, 13 May 2024 11:08:53 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Rfv-0018qs-Hv; Mon, 13 May 2024 11:08:51 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6Rfv-009R8E-1W;
	Mon, 13 May 2024 11:08:51 +0200
Date: Mon, 13 May 2024 11:08:51 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <ZkHYo6-8SC4RMlsG@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
 <20240508-mtd-nand-mxc-nand-exec-op-v2-2-6b7366b7831f@pengutronix.de>
 <20240513091902.2c00d30a@xps-13>
 <20240513093256.363861d1@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513093256.363861d1@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Miquel,

On Mon, May 13, 2024 at 09:32:56AM +0200, Miquel Raynal wrote:
> 
> miquel.raynal@bootlin.com wrote on Mon, 13 May 2024 09:19:02 +0200:
> 
> > Hi Sascha,
> > 
> > > @@ -1717,9 +1465,111 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
> > >  	return host->devtype_data->setup_interface(chip, chipnr, conf);
> > >  }
> > >  
> > > +static int mxcnd_exec_op(struct nand_chip *chip,
> > > +			 const struct nand_operation *op,
> > > +			 bool check_only)
> > > +{
> > > +	struct mxc_nand_host *host = nand_get_controller_data(chip);
> > > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > > +	int i, j, buf_len;
> > > +	void *buf_read = NULL;
> > > +	const void *buf_write = NULL;
> > > +	const struct nand_op_instr *instr;
> > > +	bool readid = false;
> > > +	bool statusreq = false;
> > > +
> > > +	dev_dbg(host->dev, "%s: %d instructions\n", __func__, op->ninstrs);  
> > 
> > Maybe you want to get rid of this debug line.
> > 
> > > +
> > > +	if (check_only)
> > > +		return 0;
> > > +
> > > +	for (i = 0; i < op->ninstrs; i++) {
> > > +		instr = &op->instrs[i];
> > > +
> > > +		nand_op_trace("  ", instr);
> > > +
> > > +		switch (instr->type) {
> > > +		case NAND_OP_WAITRDY_INSTR:
> > > +			/*
> > > +			 * NFC handles R/B internally. Therefore, this function
> > > +			 * always returns status as ready.  
> > 
> > This is no longer a standalone function, maybe:
> > 
> > "The controller handles the R/B pin internally, therefore there is
> > nothing to do here."
> 
> And this is actually very wrong.
> 
> You should call wait_op_done() instead.
> 
> > 
> > > +			 */
> > > +			break;
> > > +		case NAND_OP_CMD_INSTR:
> > > +			if (instr->ctx.cmd.opcode == NAND_CMD_PAGEPROG)
> > > +				host->devtype_data->send_page(mtd, NFC_INPUT);
> 
> Actually this is not the right place. You should trigger the transfer
> from controller SRAM to NAND (and the other way around) in the
> NAND_OP_DATA_OUT_INSTR case.
> 
> Here you should just call ->send_cmd.

I tried to get away here with using the standard nand_write_page_raw()
function. This does multiple NAND_OP_DATA_OUT_INSTR ops before finally
sending a NAND_CMD_PAGEPROG command. With software BCH ECC I collect all
data being written in memory and copy it to the controller SRAM en bloc.
I have to do this after the final NAND_OP_DATA_OUT_INSTR op. During a
NAND_OP_DATA_OUT_INSTR I don't know if this is going to be the last one
or if other NAND_OP_DATA_OUT_INSTR ops follow, so I do the copy to SRAM
right before a NAND_CMD_PAGEPROG.

I could move the ->send_page() call to NAND_OP_DATA_OUT_INSTR, but then
I have to overwrite the ecc->write_page_raw() hook. Also it must be
clear that the NAND core will never do multiple NAND_OP_DATA_OUT_INSTR
when programming a page.

Side note: I decided to collect the page data in a memory buffer rather
than in the controller SRAM directly because it seemed too complicated
and error prone to find the correct offset in SRAM for random column
addresses. Also the SRAM can only do word and halfword accesses, so I
additionally would have to emulate byte accesses with read-modify-write
halfword accesses. While certainly doable I'd like to defer this to a
future optimisation exercise.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

