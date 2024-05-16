Return-Path: <linux-kernel+bounces-180902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F083A8C7498
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA61D2845C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D8214389B;
	Thu, 16 May 2024 10:25:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92F143898
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855155; cv=none; b=FfCqE6ocz6XcFdFP0znBpXSM8bWM40Eg8ulx1BcI5imdqnIWK5cdavvUmwDup5Zo2BaoIifIfQDigyr2vlYz2RjBJwDai5dKf6IwOR//udPZE4g/qg2dTfK0wCLe37un+RhRPDJ3BKkAOezBnPSGzTQ6cN+vWZuyPatkDdb8G7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855155; c=relaxed/simple;
	bh=IPtgZuups6F+a4Fqarl6T/Cojz57fikXb4I5WZNsdb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY4S/2PZ2o5pze4p73fo9iuKBs0+SlvdjzPFocG5LEk/g9+LMWRWrdmOzNFmbGNdrsuCesqSiWW2y5zIa7T8T+QFVcBmMlRLNPPeaTMFiGhft+R+q5fqKFK6xbx9F/whoYwmGUPIs3DsMHSIQDyx3CoFN6o2uzKVlQjL5Ql6V/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1s7YIz-0003ji-7V; Thu, 16 May 2024 12:25:45 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1s7YIx-001h9K-52; Thu, 16 May 2024 12:25:43 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1s7YIx-00Epwj-0D;
	Thu, 16 May 2024 12:25:43 +0200
Date: Thu, 16 May 2024 12:25:43 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <ZkXfJ6n-06YqOr39@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
 <20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
 <20240516103214.57a8ce33@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516103214.57a8ce33@xps-13>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, May 16, 2024 at 10:32:14AM +0200, Miquel Raynal wrote:
> Hi Sascha,
> 
> > +static const struct nand_op_parser mxcnd_op_parser = NAND_OP_PARSER(
> > +	NAND_OP_PARSER_PATTERN(mxcnd_do_exec_op,
> > +			       NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > +			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > +			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > +			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > +			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)),
> 
> CMD, ADDR, CMD, DATA is the RNDOUT pattern. So it is now working fine?

Yes, RNDOUT is working now.

> Or did you forget to adapt the patterns to your use case?

Although it looks like the patterns from the pl35x-nand-controller.c,
there is one slight difference. The 'false' in the NAND_OP_PARSER_PAT_CMD_ELEM
above has the effect that a plain NAND_OP_PARSER_PAT_DATA_IN_ELEM is
disallowed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

