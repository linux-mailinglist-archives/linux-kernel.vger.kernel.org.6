Return-Path: <linux-kernel+bounces-171105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1508BDFCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F122850BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839E7828B;
	Tue,  7 May 2024 10:33:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903EA4F8A3
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078002; cv=none; b=F8FbdTZQ040Fn6aSnpPgVko8xjQW2dGsD2hI++mHAdezEOmfSECYEHRAmkYEJ8wRjcc/9uwzzeSf0fMB0rM4ZEcF3G48tNnH7Wk7Ox8duhcm0FA5MFE2iPgqhsAjao/qJCVdcNNk2FFooXXYlEbf7+22M6s57sEJPzrULbSL010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078002; c=relaxed/simple;
	bh=0CM1hEbxtRDXolAOaa23UC3tCXNMEBfzOWL4AIpv9bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO0lWJDpsJwYhYR+sgKGM2ms8xbwOCS1I4qZMlgzW3JXph/yvRIwCE2lkICRmWz5PfTrz5KOwmSocsXbXNwH3hagU9/JyTo9zUq2wWCHPRDpYYdIM4XIYeqSytqua1jFyAk6OAMt9lI2PDZMPP34RvFRxi5BfkNeoahdy9uc8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s4I8C-0003JN-GZ; Tue, 07 May 2024 12:33:08 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s4I8B-0004nD-BH; Tue, 07 May 2024 12:33:07 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s4I8B-00GOiE-0q;
	Tue, 07 May 2024 12:33:07 +0200
Date: Tue, 7 May 2024 12:33:07 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <ZjoDYzVNOk06-Q3D@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
 <20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
 <20240506160508.6c60d50f@xps-13>
 <20240506175106.2ab7c844@xps-13>
 <ZjnUXtWGR3cmtYB0@pengutronix.de>
 <20240507094538.745fb5a9@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507094538.745fb5a9@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, May 07, 2024 at 09:45:38AM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> s.hauer@pengutronix.de wrote on Tue, 7 May 2024 09:12:30 +0200:
> 
> > On Mon, May 06, 2024 at 05:51:06PM +0200, Miquel Raynal wrote:
> > > Hi Miquel,
> > > 
> > > miquel.raynal@bootlin.com wrote on Mon, 6 May 2024 16:05:08 +0200:
> > >   
> > > > Hi Sascha,
> > > > 
> > > > s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:30 +0200:
> > > >   
> > > > > To support software ECC we still need the driver provided read_oob,
> > > > > read_page_raw and write_page_raw ops, so set them unconditionally
> > > > > no matter which engine_type we use. The OOB layout on the other hand
> > > > > represents the layout the i.MX ECC hardware uses, so set this only
> > > > > when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.
> > > > > 
> > > > > With these changes the driver can be used with software BCH ECC which
> > > > > is useful for NAND chips that require a stronger ECC than the i.MX
> > > > > hardware supports.
> > > > > 
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > ---
> > > > >  drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
> > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> > > > > index fc70c65dea268..f44c130dca18d 100644
> > > > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > > > @@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
> > > > >  	chip->ecc.bytes = host->devtype_data->eccbytes;
> > > > >  	host->eccsize = host->devtype_data->eccsize;
> > > > >  	chip->ecc.size = 512;
> > > > > -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> > > > > +
> > > > > +	chip->ecc.read_oob = mxc_nand_read_oob;
> > > > > +	chip->ecc.read_page_raw = mxc_nand_read_page_raw;
> > > > > +	chip->ecc.write_page_raw = mxc_nand_write_page_raw;  
> > > 
> > > A second thought on this. Maybe you should consider keeping these for
> > > on-host operations only.
> > > 
> > > The read/write_page_raw operations are supposed to detangle the data
> > > organization to show a proper [all data][all oob] organization to the
> > > user.  
> > 
> > Let me take one step back. The organisation in the raw NAND is like this
> > when using hardware ECC:
> > 
> > [512b data0][16b oob0][512b data1][16b oob1][512b data2][16b oob2][512b data3][16b oob3]
> > 
> > For a standard 2k+64b NAND. The read/write_page_raw operations detangle
> > this and present the data to the user like this:
> > 
> > [2048b data][64b OOB]
> > 
> > Is this the correct behaviour or should that be changed?
> 
> I believe so, yes.
> 
> > (Side note: The GPMI NAND driver behaves differently here. It has the
> > same interleaved organisation on the chip and also presents the same
> > interleaved organisation to the user when using read_page_raw)
> 
> I'd say the GPMI driver is wrong?
> 
> > With my current approach for software ECC the same layout is used on the
> > NAND chip. It would interleave the data with the OOB on the NAND chip
> > and, since using the same read/write_page_raw operations, also presents
> > [2048b data][64b OOB] to the user.
> 
> No need, I believe the only reason for interleaving is that your
> hardware ECC engine works like that (writes the ECC bytes slightly
> after each chunk of data). So if you don't use on-host hardware ECC,
> you don't need to deal with this data layout.

Right, I could use a different layout for software ECC. Using the same
layout for both hardware and software ECC is just quite convenient as
the same mxc_nand_read_page_raw()/mxc_nand_write_page_raw() could be
used for both software and hardware ECC.

Another thing that might be worth considering is that if we use
different functions for raw read/write page is that we would get
different views on the same raw page data if we switch from software to
hardware ECC or the other way round which might be confusing.

> 
> > This works fine currently, but means that NAND_CMD_RNDOUT can't be used.
> > Using NAND_CMD_RNDOUT to position the cursor at offset 512b for example
> > doesn't give you the second subpage, but instead oob0. Positioning the
> > cursor at offset 2048 doesn't give you the start of OOB, but some
> > position in the middle of data3.
> > 
> > Ok, NAND_CMD_RNDOUT can't be used for hardware ECC and there's no way
> > around it. For software ECC we could change the organisation in the chip
> > to be [2048b data][64b oob]. With that NAND_CMD_RNDOUT then could be
> > used with software ECC.
> > 
> > You say that NAND_CMD_RNDOUT is a basic command that is supported by all
> > controllers, and yes, it is also supported with the mxc_nand controller.
> > You just can't control how many bytes are transferred between the NAND
> > chip and the controller. When using NAND_CMD_RNDOUT to read a few bytes
> > at a certain page offset we'll end up reading 512 bytes discarding most
> > of it. For the next ECC block we would move the cursor forward using
> > another NAND_CMD_RNDOUT command, again read 512 bytes and discard most
> > it (altough the desired data would have been in the first read already).
> 
> I'm not sure the controller limitations are so bad in this case. The
> core helpers (using the same example) will ask for:
> - 512b at offset 0
> - 512b at offset 512...
> - and finally 64b at offset 2048.
> In practice it does not look like a huge drawback? I don't understand
> in which case so much data would be read and then discarded?

Yes, you're right. I misread the code and thought the core would read
the ECC separately for each subpage. In fact it doesn't do so, the ECC
is always read in one go even for multiple subpages.

> 
> > So I think NAND_CMD_RNDOUT should really be avoided for this controller,
> > eventhough we might be able to support it.
> 
> I also mentioned the monolithic accessors which try to avoid these
> random column changes. You probably want to check them out, they might
> just avoid the need for NAND_CMD_RNDOUT by forcing full page accesses
> directly. The reason why they were introduced is not exactly our
> current use case, but it feels like they might be handy.
> 
> 658beb663960 ("mtd: rawnand: Expose monolithic read/write_page_raw() helpers")
> 0e7f4b64ea46 ("mtd: rawnand: Allow controllers to overload soft ECC hooks")

Yes, I already make use of 0e7f4b64ea46. My problem is only the ecc.read_subpage
hook which can't be overwritten and AFAIK this is the only way
NAND_CMD_RNDOUT might be used in my case.

I think my favourite solution would be to:

- store data/OOB interleaved for both hardware and software ECC
- For software ECC use a similar OOB layout as used with hardware
  ECC. This allows us to read a subpage including its ECC data in
  a single step (just like with hardware ECC the controller just
  reads 512b + 16b for each subpage)
- Allow to disable subpage reads in the NAND core

As a further optimisation we could make ecc.read_subpage overwritable
for ecc->engine_type == NAND_ECC_ENGINE_TYPE_SOFT && ecc->algo ==
NAND_ECC_ALGO_BCH. With the OOB layout described above that would be
easily implementable with the mxc_nand controller.

What do you think?

If you insist I would go the path of making NAND_CMD_RNDOUT work for
software ECC, although I think it would cause me extra work with no
clear gain for me.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

