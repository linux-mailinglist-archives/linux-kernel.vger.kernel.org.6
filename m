Return-Path: <linux-kernel+bounces-238988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF20925494
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBCF2855E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF09136E27;
	Wed,  3 Jul 2024 07:24:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847E134415
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719991493; cv=none; b=dUHgtJiztqTS1SHanPqfrN/p/NaGVxxX0LA/j6UhazBjezAc/Ab1ws/IWJ86vcMd+KJqDZ+O1r2rOPishClBLQUGAWpYNw4HSjYHnwTpYkukCH8XMJXHdY/Iu1SDdKiVG+gcd6yzWWux4e3zGlqFCg1ssgZxTNMNnFqwynLDDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719991493; c=relaxed/simple;
	bh=AEy82RQVKwdoF1XRWzeaE3LayoayJxqZSOC3BPnZs/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rko5AD4iKB5EX7NHwtWOoLe4UVHOr3PiqyyEqEQs1LH2wvfzwCAhGYlHVihxze48p07HGR/t0biYD5iLhqYfxI2h6V/JcOws6QPElR0EdQSGxcZmMNPKg2fZOR82dQuS72t9SaoWyaA+fRZASRs4JM3eDuzHq83pgh7dlQRWHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sOuM8-0002CJ-Cr; Wed, 03 Jul 2024 09:24:44 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sOuM7-006nQf-Tu; Wed, 03 Jul 2024 09:24:43 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sOuM7-00CPUX-2T;
	Wed, 03 Jul 2024 09:24:43 +0200
Date: Wed, 3 Jul 2024 09:24:43 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] [RFC] mwifiex: Fix NULL pointer deref
Message-ID: <ZoT8uxpUvW-V7K-Y@pengutronix.de>
References: <20240619070824.537856-1-s.hauer@pengutronix.de>
 <87wmmll5mf.fsf@kernel.org>
 <ZnSHcZttq79cJS3l@google.com>
 <ZnVCzx3-pvbcYQLm@pengutronix.de>
 <ZnmcvsXZHnQ36auI@gaggiata.pivistrello.it>
 <ZoQBYMRLVAwM0O0j@pengutronix.de>
 <ZoRku6FmNA8d8lkR@gaggiata.pivistrello.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoRku6FmNA8d8lkR@gaggiata.pivistrello.it>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2024 at 10:36:11PM +0200, Francesco Dolcini wrote:
> On Tue, Jul 02, 2024 at 03:32:16PM +0200, Sascha Hauer wrote:
> > On Mon, Jun 24, 2024 at 06:20:14PM +0200, Francesco Dolcini wrote:
> > > On Fri, Jun 21, 2024 at 11:07:27AM +0200, Sascha Hauer wrote:
> 
> ...
> 
> > > > 
> > > > From 3357963821294ff7de26259a154a1cb5bab760cb Mon Sep 17 00:00:00 2001
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Date: Tue, 18 Jun 2024 12:20:20 +0200
> > > > Subject: [PATCH] mwifiex: Do not return unused priv in
> > > >  mwifiex_get_priv_by_id()
> > > > 
> > > > mwifiex_get_priv_by_id() returns the priv pointer corresponding to the
> > > > bss_num and bss_type, but without checking if the priv is actually
> > > > currently in use.
> > > > Unused priv pointers do not have a wiphy attached to them which can lead
> > > > to NULL pointer dereferences further down the callstack.
> > > > Fix this by returning only used priv pointers which have priv->bss_mode
> > > > set to something else than NL80211_IFTYPE_UNSPECIFIED.
> > > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> I guess you should send it as a proper patch?

Yes, I just did this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

