Return-Path: <linux-kernel+bounces-180958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681E88C7574
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1281C2122C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B58145A09;
	Thu, 16 May 2024 11:48:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773E026AD0
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715860120; cv=none; b=GE+j+Ni0TMoyZJgPkonVv0ij7KQvFrGgv/DQT301JFEab1uWL08UBLYWo4k07yZhOkO6Er0sR0aU2wngP2M/azGdckcRHCZ0Qesf2dQxvs3QLKVaNXfBMUDWANFKaEAEOPDo8Ol8gKxjjcBrCvwB0Odo3kLjN50ig8riY/p/VY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715860120; c=relaxed/simple;
	bh=mHH8ds+0VZ4unF0VY0gZRjYkLC4SrJlPPaUUO2d7NXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7L4BnOTDjm0KpRAX4bRaY5qDClKynt6uQau4FAYfLQeM8jRE0f43RLFpCc/Xs+K8wk03oEDYNIIVkespkOpzdg+U3vk4IJwbxH2K+l3FI89n+Ouv5surrRcd3BcPDEVHL8ngiROV/SZQB0iMDHwITOkDf0znmnudqyElj0E94E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZbB-0002rM-GM; Thu, 16 May 2024 13:48:37 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZbB-001hhR-0h; Thu, 16 May 2024 13:48:37 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZbA-00EqdY-31;
	Thu, 16 May 2024 13:48:36 +0200
Date: Thu, 16 May 2024 13:48:36 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: onfi: read parameter pages in one go
Message-ID: <ZkXylC2xrlqGW_xV@pengutronix.de>
References: <20240514134140.1050141-1-s.hauer@pengutronix.de>
 <20240516101350.78e5ee29@xps-13>
 <20240516115812.02908822@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516115812.02908822@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 16, 2024 at 11:58:12AM +0200, Miquel Raynal wrote:
> 
> miquel.raynal@bootlin.com wrote on Thu, 16 May 2024 10:13:50 +0200:
> 
> > Hi Sascha,
> > 
> > s.hauer@pengutronix.de wrote on Tue, 14 May 2024 15:41:40 +0200:
> > 
> > > nand_read_data_op() is not supported by all NAND controllers.
> > > nand_change_read_column_op() is not supported or at least is hard to
> > > support by NAND controllers that use a different page layout than
> > > expected by the NAND core.  
> > 
> > I'm sorry but RNDOUT is not so hard to support, and I know no NAND
> > controller without this feature (I think even the first mxc controller
> > supports it?). However, the command does not exist on small page NANDs
> > (512 bytes).
> 
> Nevermind, the ONFI spec (in all versions) states that RNDOUT are
> allowed during parameter page reads, regardless of the size of the chip
> (at least, that is not mentioned).

I could imagine that there are no ONFI compliant chips with small pages,
I don't know how to verify this though.

Anyway, this was a try to make reading the parameter pages a bit more
straight forward. It seems the MXC NAND controller can't support reading
three parameter pages in one go either. It works in software ECC mode
because I reverse the syndome type layout the controller introduces, but
it can't work with hardware ECC. So disregard this patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

