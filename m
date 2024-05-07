Return-Path: <linux-kernel+bounces-170795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8398BDC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0471F24BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4012F583;
	Tue,  7 May 2024 07:12:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FE61292E4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065975; cv=none; b=H1jjFozxheipmV9HGdNmkuSIXw2aM9pELMoPkEsvA6IL/r+7L2dVH1OegLyk5HDzA7PM1iQpZrx4GCMApMaMzXb0021+6khExxg54KjXVidv3P+SKlwfRcm5fvhlz0uaVJVQbSz2CJLt6OuG3rO3taj/v+eHQUJ81owvMx13nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065975; c=relaxed/simple;
	bh=jx4QM2+hqykjqBrZD5Vz7z8aLy28+8IOi8v2KPsTlU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLEd3GM17wRvCqKi0VQVyM2FFkwiQ/cwVOvJuDyyeMGrkKDqhsa3Mvgtzxwz1ifjsG0MPpXBysDFEG2tPtUW+BQiUlRNp+1vVIqC8hQRE6kYZJLqHvicBOazBEvPAth8YLFVV/tfM58X6jPHkPdJ8ZzQYQm5zQI0lfAokZuQyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s4F03-0006tH-Up; Tue, 07 May 2024 09:12:31 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s4F02-0003M0-KH; Tue, 07 May 2024 09:12:30 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s4F02-00GMEv-1j;
	Tue, 07 May 2024 09:12:30 +0200
Date: Tue, 7 May 2024 09:12:30 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <ZjnUXtWGR3cmtYB0@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
 <20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
 <20240506160508.6c60d50f@xps-13>
 <20240506175106.2ab7c844@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506175106.2ab7c844@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, May 06, 2024 at 05:51:06PM +0200, Miquel Raynal wrote:
> Hi Miquel,
> 
> miquel.raynal@bootlin.com wrote on Mon, 6 May 2024 16:05:08 +0200:
> 
> > Hi Sascha,
> > 
> > s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:30 +0200:
> > 
> > > To support software ECC we still need the driver provided read_oob,
> > > read_page_raw and write_page_raw ops, so set them unconditionally
> > > no matter which engine_type we use. The OOB layout on the other hand
> > > represents the layout the i.MX ECC hardware uses, so set this only
> > > when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.
> > > 
> > > With these changes the driver can be used with software BCH ECC which
> > > is useful for NAND chips that require a stronger ECC than the i.MX
> > > hardware supports.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > ---
> > >  drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> > > index fc70c65dea268..f44c130dca18d 100644
> > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > @@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
> > >  	chip->ecc.bytes = host->devtype_data->eccbytes;
> > >  	host->eccsize = host->devtype_data->eccsize;
> > >  	chip->ecc.size = 512;
> > > -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> > > +
> > > +	chip->ecc.read_oob = mxc_nand_read_oob;
> > > +	chip->ecc.read_page_raw = mxc_nand_read_page_raw;
> > > +	chip->ecc.write_page_raw = mxc_nand_write_page_raw;
> 
> A second thought on this. Maybe you should consider keeping these for
> on-host operations only.
> 
> The read/write_page_raw operations are supposed to detangle the data
> organization to show a proper [all data][all oob] organization to the
> user.

Let me take one step back. The organisation in the raw NAND is like this
when using hardware ECC:

[512b data0][16b oob0][512b data1][16b oob1][512b data2][16b oob2][512b data3][16b oob3]

For a standard 2k+64b NAND. The read/write_page_raw operations detangle
this and present the data to the user like this:

[2048b data][64b OOB]

Is this the correct behaviour or should that be changed?
(Side note: The GPMI NAND driver behaves differently here. It has the
same interleaved organisation on the chip and also presents the same
interleaved organisation to the user when using read_page_raw)


With my current approach for software ECC the same layout is used on the
NAND chip. It would interleave the data with the OOB on the NAND chip
and, since using the same read/write_page_raw operations, also presents
[2048b data][64b OOB] to the user.

This works fine currently, but means that NAND_CMD_RNDOUT can't be used.
Using NAND_CMD_RNDOUT to position the cursor at offset 512b for example
doesn't give you the second subpage, but instead oob0. Positioning the
cursor at offset 2048 doesn't give you the start of OOB, but some
position in the middle of data3.

Ok, NAND_CMD_RNDOUT can't be used for hardware ECC and there's no way
around it. For software ECC we could change the organisation in the chip
to be [2048b data][64b oob]. With that NAND_CMD_RNDOUT then could be
used with software ECC.

You say that NAND_CMD_RNDOUT is a basic command that is supported by all
controllers, and yes, it is also supported with the mxc_nand controller.
You just can't control how many bytes are transferred between the NAND
chip and the controller. When using NAND_CMD_RNDOUT to read a few bytes
at a certain page offset we'll end up reading 512 bytes discarding most
of it. For the next ECC block we would move the cursor forward using
another NAND_CMD_RNDOUT command, again read 512 bytes and discard most
it (altough the desired data would have been in the first read already).

So I think NAND_CMD_RNDOUT should really be avoided for this controller,
eventhough we might be able to support it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

