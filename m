Return-Path: <linux-kernel+bounces-170817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0248BDC69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CBF1F22301
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3F13C3CB;
	Tue,  7 May 2024 07:28:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308713C800
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066915; cv=none; b=ccncyEdvTw3FjlFCBB1k76gxdFwZUFvn3DyjLspdVBv/YZJeFJ9KHWXhc+tiQs76m+QZ1x05aPB/d1uZ1s5ihXMKKiI69E13UvvUbOcU5r8YoFJTsEXJjvDfPka51T3Cc79UddF+6sl2s88ta1sJDBm/+8Ft1Ghms8BbGD8RThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066915; c=relaxed/simple;
	bh=LVPnJmQHPGYoQXViC4fQJin94h4QA819bTFm23wlacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZLgTDnTsoh2yDeBZPXCWWXL+Je3HZHHsdWurlqyVtgOUQYEnxsWcWWDsYwbnFeCJE5Mu18Mu/BS9IKwKb/JAhD9zx0mAxVjVWJqiN06rPA3qSw5jvhdQ61ssAy0hIC+N6lwwezcto5C2udiWiqd3PD8aR5+9kZrMALm7JSn0AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s4FFS-0001gp-P9; Tue, 07 May 2024 09:28:26 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s4FFR-0003Ng-Lh; Tue, 07 May 2024 09:28:25 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s4FFR-00GMOi-1s;
	Tue, 07 May 2024 09:28:25 +0200
Date: Tue, 7 May 2024 09:28:25 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: mxc_nand: disable subpage reads
Message-ID: <ZjnYGfRuecAIY-3F@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
 <20240417-mtd-nand-mxc-nand-exec-op-v1-4-d12564fe54e9@pengutronix.de>
 <ZiDCKGlG4MZ23Tqo@pengutronix.de>
 <20240418113244.6e535d3f@xps-13>
 <ZiEHUz3wicDJscGP@pengutronix.de>
 <20240419114507.5d25d8cd@xps-13>
 <ZiZBsjtDDhDe7x8f@pengutronix.de>
 <20240506184108.7b1b344d@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506184108.7b1b344d@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, May 06, 2024 at 06:41:08PM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> s.hauer@pengutronix.de wrote on Mon, 22 Apr 2024 12:53:38 +0200:
> 
> > On Fri, Apr 19, 2024 at 11:46:57AM +0200, Miquel Raynal wrote:
> > > Hi Sascha,
> > > 
> > > s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 13:43:15 +0200:
> > >   
> > > > On Thu, Apr 18, 2024 at 11:32:44AM +0200, Miquel Raynal wrote:  
> > > > > Hi Sascha,
> > > > > 
> > > > > s.hauer@pengutronix.de wrote on Thu, 18 Apr 2024 08:48:08 +0200:
> > > > >     
> > > > > > On Wed, Apr 17, 2024 at 09:13:31AM +0200, Sascha Hauer wrote:    
> > > > > > > The NAND core enabled subpage reads when a largepage NAND is used with
> > > > > > > SOFT_ECC. The i.MX NAND controller doesn't support subpage reads, so
> > > > > > > clear the flag again.
> > > > > > > 
> > > > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > > > ---
> > > > > > >  drivers/mtd/nand/raw/mxc_nand.c | 2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
> > > > > > > index f44c130dca18d..19b46210bd194 100644
> > > > > > > --- a/drivers/mtd/nand/raw/mxc_nand.c
> > > > > > > +++ b/drivers/mtd/nand/raw/mxc_nand.c
> > > > > > > @@ -1667,6 +1667,8 @@ static int mxcnd_probe(struct platform_device *pdev)
> > > > > > >  	if (err)
> > > > > > >  		goto escan;
> > > > > > >  
> > > > > > > +	this->options &= ~NAND_SUBPAGE_READ;
> > > > > > > +      
> > > > > > 
> > > > > > Nah, it doesn't work like this. It turns out the BBT is read using
> > > > > > subpage reads before we can disable them here.
> > > > > >
> > > > > > This is the code in nand_scan_tail() we stumble upon:
> > > > > > 
> > > > > > 	/* Large page NAND with SOFT_ECC should support subpage reads */
> > > > > > 	switch (ecc->engine_type) {
> > > > > > 	case NAND_ECC_ENGINE_TYPE_SOFT:
> > > > > > 		if (chip->page_shift > 9)
> > > > > > 			chip->options |= NAND_SUBPAGE_READ;
> > > > > > 		break;
> > > > > > 
> > > > > > 	default:
> > > > > > 		break;
> > > > > > 	}
> > > > > > 
> > > > > > So the code assumes subpage reads are ok when SOFT_ECC is in use, which
> > > > > > in my case is not true. I guess some drivers depend on the
> > > > > > NAND_SUBPAGE_READ bit magically be set, so simply removing this code is
> > > > > > likely not an option.  Any ideas what to do?    
> > > > > 
> > > > > Can you elaborate why subpage reads are not an option in your
> > > > > situation? While subpage writes depend on chip capabilities, reads
> > > > > however should always work: it's just the controller selecting the
> > > > > column where to start and then reading less data than it could from the
> > > > > NAND cache. It's a very basic NAND controller feature, and I remember
> > > > > this was working on eg. an i.MX27.    
> > > > 
> > > > On the i.MX27 reading a full 2k page means triggering one read operation
> > > > per 512 bytes in the NAND controller, so it would be possible to read
> > > > subpages by triggering only one read operation instead of four in a row.
> > > > 
> > > > The newer SoCs like i.MX25 always read a full page with a single read
> > > > operation. We could likely read subpages by temporarily configuring the
> > > > controller for a 512b page size NAND.
> > > > 
> > > > I just realized the real problem comes with reading the OOB data. With
> > > > software BCH the NAND layer hardcodes the read_subpage hook to
> > > > nand_read_subpage() which uses nand_change_read_column_op() to read the
> > > > OOB data. This uses NAND_CMD_RNDOUT and I have now idea if/how this can
> > > > be implemented in the i.MX NAND driver. Right now the controller indeed
> > > > reads some data and then the SRAM buffer really contains part of the
> > > > desired OOB data, but also part of the user data.  
> > > 
> > > NAND_CMD_RNDOUT is impossible to avoid,  
> > 
> > Apparently it has been possible until now. NAND_CMD_RNDOUT has never
> > been used with this driver and it also doesn't work like expected.
> > 
> > One problem is that the read_page_raw() and write_page_raw() are not
> > implemented like supposed by the NAND layer. The i.MX NAND controller
> > uses a syndrome type ECC layout, meaning that the user data and OOB data
> > is interleaved, so the raw r/w functions should normally pass/expect the
> > page data in interleaved format. Unfortunately the raw functions are not
> > implemented like that, instead they detangle the data themselves. This
> > also means that setting the cursor using NAND_CMD_RNDOUT will not put
> > the cursor at a meaningful place, as the raw functions are not really
> > exect/return the raw page data.
> > 
> > This could be fixed, but the raw operations are also exposed to
> > userspace, so fixing these would mean that we might break some userspace
> > applications.
> 
> As answered to patch 3/4 I believe you need other raw page helpers for
> the software ECC path, just because the existing functions are tight to
> the on-host ECC logic and do what they are expected to do (I believe).
> 
> Creating another set of raw page helpers should be straightforward to
> do if that's really needed (mainly for performance purposes, but we're
> not yet there). Using the core helpers should work, the only thing is
> supporting properly the NAND_CMD_RNDOUT path, which should be possible
> at a rather low cost, it really is a very very basic command, I know no
> controller without this feature, even old ones.
> 
> > The other point is that with using software BCH ecc the NAND layer
> > requests me to read 7 bytes at offset 0x824. This can't be really
> > implemented in the i.MX NAND driver. It only allows us to read a full
> > 512 byte subpage, so whenever the NAND layer requests me to read a few
> > bytes the controller will always transfer 512 bytes from which I then
> > ignore most of it (and possibly trigger another 512 bytes transfer when
> > reading the ECC for the next subpage).
> 
> If you manage to get the NAND_CMD_RNDOUT op working I believe you'll be
> tempted to use memcpy32_fromio() with just a slightly rounded up length.

The overhead due to word rounding in memcpy32_fromio() is negligible, my
concern is that the controller will read 512 bytes from the NAND chip SRAM
to the controllers internal SRAM each time this command is used.

> 
> > I think these issues can all be handled somehow, but this comes at a
> > rather high price, both in effort and the risk of breaking userspace.
> > It would be far easier to tell the NAND layer not to do subpage reads.
> 
> I understand it may feel like that but that is likely not the right
> approach. I just think about another possibility: using monolithic
> reads if the controller is too constrained this way you might end up
> avoiding the RNDOUT command (might require a bit of tweaking in the
> core, I no longer remember exactly).

Not sure if I understand you correctly. I think using monolithic reads
is exactly what I am trying to archieve with disallowing subpage reads.

Subpage reads are rather unnecessary anyway. They are a performance
improvement when scanning the NAND for bad blocks and while reading
the UBI EC and VID headers. The former can be avoided with a
BBT and the latter with UBI fastmap (at least for the boot time critical
path when attaching a UBI).

> 
> Good luck, I really appreciate this effort.

Thanks. I'll do my best to get this done.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

