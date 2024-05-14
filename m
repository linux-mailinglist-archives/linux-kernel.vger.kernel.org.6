Return-Path: <linux-kernel+bounces-178500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A658C4E97
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D401C214C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E055473A;
	Tue, 14 May 2024 09:18:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CA4F88C
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715678298; cv=none; b=jpn797UyfGqqZtnsMjt3qYZ0L6hPdwyEH9RboA1zu1bXDJWvhbCek8qhWzyKbRlfocnBw1l0xpeyIgmBuZrFY3OqyLKTl5457cRQq/MYNbGZZb8rDkYDL9pln5G+vJdAUsCcIHY/4SxMZM9/gcphLY0pHljT+YxNYtOon8o2/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715678298; c=relaxed/simple;
	bh=6WFupDorTnnTbujD8AQ3ipi6gdsL4EaklWex+IzeaJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gva/rM2vsZWsXfFjV1nJte/1HqgJ8zlYnyd/J/ltrFIwr2q6/yBRlYrlbetpgvpQQn1YUBsMkJstNrg5IIolUtfKBNneGIavz9Nyd0otxL3HgPIONSzTHMaZvhyNJELpcHiYB6lSaNlPz7esRzTfnu2pB0c26oXXGRAQaw4NusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s6oIP-0000zQ-Fl; Tue, 14 May 2024 11:18:05 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s6oIN-001KT6-6G; Tue, 14 May 2024 11:18:03 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s6oIN-00BEFM-0K;
	Tue, 14 May 2024 11:18:03 +0200
Date: Tue, 14 May 2024 11:18:03 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <ZkMsS1jj-ZTpZyE1@pengutronix.de>
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

Ok.

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

Ok.

> 
> And this is actually very wrong.
> 
> You should call wait_op_done() instead.

No, I don't think so. wait_op_done() is called to wait for the interrupt
of the controller indicating a basic operation is done. A basic operation
can be that a command is being sent or an address byte has been sent to
the chip during an address cycle.

With this arbitrary example:

	struct nand_op_instr instrs[] = {
		NAND_OP_CMD(NAND_CMD_READ0, 0),
		NAND_OP_ADDR(4, addrs, 0),
		NAND_OP_CMD(NAND_CMD_READSTART, NAND_COMMON_TIMING_NS(conf, tWB_max)),
		NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tR_max),
				 NAND_COMMON_TIMING_NS(conf, tRR_min)),
		NAND_OP_DATA_IN(len, buf, 0),
	};

I'll call wait_op_done() once for NAND_CMD_READ0, four times for the NAND_OP_ADDR,
then once again for the NAND_CMD_READSTART command and four times (on i.MX27, once
per subpage) for the NAND_OP_DATA_IN operation. Calling wait_op_done() for the
NAND_OP_WAIT_RDY operation woul only timeout because there is no operation in flight
currently.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

