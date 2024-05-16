Return-Path: <linux-kernel+bounces-180951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A268C7555
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651A11F21E26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5918A1459F6;
	Thu, 16 May 2024 11:36:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C03F145A05
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859409; cv=none; b=IiKjq1ZJozANQUqjAVc/Qpz3W9pTEUjKyE68rmiB1R21SM9UM58ZeeRhYrfphNr1ozwZmWwV74p+kW/yJvi4MtRRCX/9/VOlUDSs6MwiyobYC5PzCOnwd2b2+R0NoVdTQppGviciS113fsy1zn2bOImy1rbu0wUpUzwq3JjzkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859409; c=relaxed/simple;
	bh=CTavtiGpG7ILOOHp9yowuOhIXoFP2hGxQnS1LKNpHSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSt7pWFTePKMheVjtGKSfsgeq1KUs30iM0ZpRBFVDrFIBh8TfkNusn1dU/cXqYZ66u0RK/CyzAYUcfRso9Wced60HBk+aacZZl66a1NT6HqydMUtLqE1e7KGchWriTwN9PHiB112ytk+gyXg9SCXvnGSC8xwudthreHx8j1s518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZPf-0007gw-Mt; Thu, 16 May 2024 13:36:43 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZPe-001hfo-Fw; Thu, 16 May 2024 13:36:42 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s7ZPe-00Eqac-1I;
	Thu, 16 May 2024 13:36:42 +0200
Date: Thu, 16 May 2024 13:36:42 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <ZkXvyiuB4B2Fbz4l@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
 <20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
 <20240516103214.57a8ce33@xps-13>
 <ZkXfJ6n-06YqOr39@pengutronix.de>
 <20240516124405.2da1aa23@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516124405.2da1aa23@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 16, 2024 at 12:44:05PM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> s.hauer@pengutronix.de wrote on Thu, 16 May 2024 12:25:43 +0200:
> 
> > On Thu, May 16, 2024 at 10:32:14AM +0200, Miquel Raynal wrote:
> > > Hi Sascha,
> > >   
> > > > +static const struct nand_op_parser mxcnd_op_parser = NAND_OP_PARSER(
> > > > +	NAND_OP_PARSER_PATTERN(mxcnd_do_exec_op,
> > > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > > +			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > > > +			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > > > +			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)),  
> > > 
> > > CMD, ADDR, CMD, DATA is the RNDOUT pattern. So it is now working fine?  
> > 
> > Yes, RNDOUT is working now.
> 
> Excellent!
> 
> > > Or did you forget to adapt the patterns to your use case?  
> > 
> > Although it looks like the patterns from the pl35x-nand-controller.c,
> > there is one slight difference. The 'false' in the NAND_OP_PARSER_PAT_CMD_ELEM
> > above has the effect that a plain NAND_OP_PARSER_PAT_DATA_IN_ELEM is
> > disallowed.
> 
> I'm not sure I follow, the above pattern means: a single command cycle
> is supported, no?

A single command cycle indeed is and shall be supported. The
pl35x-nand-controller.c I copied this from has
NAND_OP_PARSER_PAT_CMD_ELEM(true). With all elements being optional this
also allows a single NAND_OP_PARSER_PAT_DATA_IN_ELEM()
(supported_op.data_only_read becomes true). I can't support that, so I
made the CMD mandatory.

Sascha

> 
> Miquèl
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

