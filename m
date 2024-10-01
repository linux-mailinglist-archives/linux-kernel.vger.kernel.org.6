Return-Path: <linux-kernel+bounces-346626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78198C6E5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838DCB22060
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F131BDAB3;
	Tue,  1 Oct 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nwQ9EuUc"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805061925B8
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815051; cv=none; b=PAy8Oe9hADQSieSTFKT3dL875ilZy5/paSJ4FsxNC8mpD5XHwhIfZu3l/y1N7vLzhqr+ISr2z2IWGANiv23sE0jSDLuU2T2mhRatOifNfeNyUY4213dsOSnkdFH/PNHK6v4Ev4AP+8fwt9OsfNoJVdV8/7P0nWDv3nWrw0pkJts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815051; c=relaxed/simple;
	bh=ysjV7DFTS8G5S7VFux9lMUVNZMhtzd8HLff23IKgLOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSCAZDIEiW0XgCIK4ll3zmF1E6CUZ0HsLt+3l6TCRDrmIpydON3TKa1B5iI07EOGTvJn8DWg9WRQycInmGFl5W2vZuqnlgQLnLmPGJ2m6W0P23DUTYzFRXif/CdOFnWbkmRWu2o+8BdTr4TV8wXuPjNO7H/5K/PSs5IqhqmjcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nwQ9EuUc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7fnSGYhniQwLAJoqqmgeDP6zdAognPdAB/UHbLqgj10=; b=nwQ9EuUczb92u4w9
	OxhpSgqKBefhixFpJfhHESG9v2gP0xrDG4pfFb8At2gpuq9hXgrIOtgl6qrjGyT5s39I+Y6QCQY6X
	7lv4o/A/K1m0TnOm8cUnQq7TtDf+0iOlp/udMQ211uEH4rp6Dg6A7ooHpWO41uZuyk6Esskm51emU
	zDxDaipqvy++8DHQiDWlS5pdZPCHes7IV6fti+RsWiJIcuc1mepUwkUHNxsVhhomju+voXmveHG/F
	ACGFonZ8pAOtDedSuViBhxENqhrQPhcINwRRNFgBoU07MJ0sWd5eFZt8Bv6l4ZIgyTAmptrZDBD6f
	mXtk7m27mP9tPrEb1A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1svjcU-008Jvz-3A;
	Tue, 01 Oct 2024 20:37:18 +0000
Date: Tue, 1 Oct 2024 20:37:18 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: nicolas.ferre@microchip.com, miquel.raynal@bootlin.com, richard@nod.at,
	linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: of atmel_pmecc_destroy_user
Message-ID: <Zvxdfh3FobjpvcRb@gallifrey>
References: <ZvmIvRJCf6VhHvpo@gallifrey>
 <20240930090817.0a86e538@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20240930090817.0a86e538@collabora.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 20:36:38 up 146 days,  7:50,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Boris Brezillon (boris.brezillon@collabora.com) wrote:
> Hi David,
> 
> On Sun, 29 Sep 2024 17:05:01 +0000
> "Dr. David Alan Gilbert" <linux@treblig.org> wrote:
> 
> > Hi Boris and co,
> >   One of my scripts noticed that 'atmel_pmecc_destroy_user'
> > isn't called anywhere; I was going to delete it, but hmm, I wonder
> > if it's actually a missing call and leaking (in the unlikely case
> > the device was ever removed).
> > 
> > It was added by your:
> >   commit f88fc122cc34c2545dec9562eaab121494e401ef
> >   Author: Boris Brezillon <bbrezillon@kernel.org>
> >   Date:   Thu Mar 16 09:02:40 2017 +0100
> > 
> >     mtd: nand: Cleanup/rework the atmel_nand driver
> > 
> > and I see the allocation in:
> >      user = kzalloc(size, GFP_KERNEL);
> >        in
> >      nand->pmecc = atmel_pmecc_create_user(nc->pmecc, &req);
> >        called in atmel_nand_pmecc_init
> >          from atmel_nand_ecc_init
> >            from atmel_hsmc_nand_ecc_init
> >  
> > But I don't see any freeing.
> > 
> > (I don't knowingly have hardware to test a fix, although I guess
> > there's probably one somewhere....)
> > 
> > Suggestions?
> 
> There's definitely a leak. I haven't looked at NAND stuff for a while
> though, so I'll let Miquel advise you on where
> atmel_pmecc_destroy_user() should be called.

I see Miquel has posted a fix.

Thanks to both of you!

Dave

> Regards,
> 
> Boris
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

