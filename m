Return-Path: <linux-kernel+bounces-570426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9EA6B039
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8341E884C13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B1214223;
	Thu, 20 Mar 2025 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eoX0mlxd"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26F51EB1AE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508098; cv=none; b=BzHb07B5Y7IXHMfh6zX6n3cTZs2W2TEqOkkQvKYHYxsC8I+fdbul37s6zCBd6onpgJF7YruIbAxRndW/c6Cr0sr4GbIweWwfq/sgqx7ZVMCn7Wd5hAAeMo00UswlJrPbkSvclgnSddX74jPZ8Dp4xQlyS5ga6a2arT6uYEoT9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508098; c=relaxed/simple;
	bh=Yg6H4vxZ/ypZ9QWZ72i/Vu4mvqZmQtAU3zw/DO+b4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPMj44PQq4WFgfDzt2UTjDTF/XaoVlO4c59Coyza2MUSAHQvuWLTMwtCOCX6v0MKHW3dgjIIhllfV2HISZjaddMtZgiswWln6xqux9Q1zvxdfiGH7ZTnMFyw237xvUtpNiNtqvJsfQIMdgoT0QJVglaQ8qKqASbKY6xokbXmcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eoX0mlxd; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D3C6420487;
	Thu, 20 Mar 2025 22:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742508093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaCKPJlwcuwqGD/thqS4n6Nbplq365BJsUtRQbhpno8=;
	b=eoX0mlxdGPblU6qH1a3qTEhGU4jwNb+QkTTYzYytDQWWmCNogODfRMqL+vHZFVT4jK87uW
	vJUs9/ZXA0OqBUfcNoCaZdeA0GD9Ph7DhZS7k91w3SUn2n4LQsOWeW3b3pDEI/iQuGSpL5
	5+jYV7TAJSckeks092rjv786izvGIqIT1enOtNsQ3ddxJXyYlnqKftaOjnOCh78dv8Q9GC
	ic2OufvNArgmAd53jFkM3dr6OksezBOIyXP0VbPI/H5b5vtNCpxentbk+OIEMYYyNgmdX6
	cZ6rbEfv+IAG3scall1p1wSSPVv/ddKMNmakw7N+64G06hmBOIh+yDrKOyviOw==
Date: Thu, 20 Mar 2025 23:01:31 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Qasim Ijaz <qasdev00@gmail.com>, miquel.raynal@bootlin.com,
	linux-i3c@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in
 dynamic address assignment
Message-ID: <2025032022013134061aaa@mail.local>
References: <20250317101516.19157-1-qasdev00@gmail.com>
 <Z9l3waI5EdrWmYC3@lizhi-Precision-Tower-5810>
 <Z9mGK0x8fsWvbTvo@qasdev.system>
 <Z9rEPLAmxrqP61sz@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9rEPLAmxrqP61sz@lizhi-Precision-Tower-5810>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeelfeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhgfdvffdviefhtdfgffehleekieffjeetieevtdeuheeivdeujeelffehjeeiveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepiedprhgtphhtthhopefhrhgrnhhkrdhlihesnhigphdrtghomhdprhgtphhtthhopehqrghsuggvvhdttdesghhmrghilhdrt
 ghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On 19/03/2025 09:18:52-0400, Frank Li wrote:
> On Tue, Mar 18, 2025 at 02:41:47PM +0000, Qasim Ijaz wrote:
> > On Tue, Mar 18, 2025 at 09:40:17AM -0400, Frank Li wrote:
> > > On Mon, Mar 17, 2025 at 10:15:16AM +0000, Qasim Ijaz wrote:
> > > > svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int
> > > > however it initialises it with i3c_master_get_free_addr() which
> > > > returns a signed int type and then attempts to check if dyn_addr is
> > > > less than 0. Unsigned integers cannot be less than 0, so the check
> > > > is essentially redundant. Furthermore i3c_master_get_free_addr()
> > > > could return -ENOMEM which an unsigned int cannot store.
> > > >
> > > > Fix this by capturing the return value of i3c_master_get_free_addr()
> > > > in a signed int ‘dyn_addr_ret’. If that value is negative, return
> > > > an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once
> > > > we know it’s valid.
> > > >
> > > > Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> > > > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > > > ---
> > >
> > > Thank you for your patch, but similar one was already applied
> > > https://lore.kernel.org/linux-i3c/174225158210.1593610.10018812780731849409.b4-ty@bootlin.com/T/#m5120e1c362e7e57f4cab139a45410fde421c2f37
> > >
> >
> > Hi Frank
> >
> > I sent a fix for this issue on the 9th March, which is before the patch
> > you linked which was sent on the 10th March.
> 
> Yes, but perfer original owner to fix this type minor fix.
> 

This is absolutely not what I said, the first one that is sent and is
applicable should be applied.

See how you didn't fix this trivial issue:

https://lore.kernel.org/linux-i3c/20250319-i3c-fix-clang-fallthrough-v1-1-d8e02be1ef5c@kernel.org/T/#u

> https://lore.kernel.org/linux-i3c/174129444617.1163689.11942276093411687387.b4-ty@bootlin.com/T/#t
> 
> Frank
> >
> > You can view my orignal patch here:
> >
> > https://lore.kernel.org/all/20250309164314.15039-1-qasdev00@gmail.com/
> >
> > Thanks
> > Qasim
> > > Frank
> > > >  drivers/i3c/master/svc-i3c-master.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > > index f22fb9e75142..eea08f00d7ce 100644
> > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > @@ -998,9 +998,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > > >  			 * filling within a few hundred nanoseconds, which is significantly
> > > >  			 * faster compared to the 64 SCL clock cycles.
> > > >  			 */
> > > > -			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > > -			if (dyn_addr < 0)
> > > > +			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > > +			if (dyn_addr_ret < 0)
> > > >  				return -ENOSPC;
> > > > +			dyn_addr = dyn_addr_ret;
> > > >
> > > >  			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> > > >
> > > > --
> > > > 2.39.5
> > > >
> >
> > --
> > linux-i3c mailing list
> > linux-i3c@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-i3c
> 
> -- 
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

