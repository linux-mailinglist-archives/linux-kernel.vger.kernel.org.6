Return-Path: <linux-kernel+bounces-205416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D926D8FFB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92A01C255F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16E1BC4E;
	Fri,  7 Jun 2024 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ORj/CHAN"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8D2572
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737083; cv=none; b=W5JWKb8jNjw+YsosS6CqaIbQwTs6/QvUXErOcp6FNUabnh0oc/qIR6YsO2SHKoj5ZhUD5WT+ASDcYGs71II/LyEs9DWhfk2fen/uXAxSldJWsVU/bEe8bSGV4Hlrz+xvH7hO7EUDaz1hrADRTJeVAfH7hJb18O2q29V4RGhcThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737083; c=relaxed/simple;
	bh=nuB7asa+gkGnMxAOLDQ2n99jDEu/mUcO2pRRdiaoPXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWTgWflLNoD5l5+GCqcPMBMRMJ+ldcauCSGCIXSe1I3fv1WWWo9m24qirXFKSFcceG47CCHCa3aEyC5C/BTOkDj1RPT17ZLOvu6WAGf2tFWNdFzQ7C1TEURIgHMIIwpAFfRWdOUaPz1aWvPBAObiOQhRoEMFOwUnKRJj2ZrpyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ORj/CHAN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 207D620075;
	Fri,  7 Jun 2024 13:11:17 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1717737078;
	bh=pmFxTJwyxuLxhl3FWXaWxR15Gy9I8J8ELzbL7Dosd7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ORj/CHANTj6LVHMbmVPFkoCJDPADQuuzkKTuy8WDc1sLBYFZczYrGNk5zMzvjUDfR
	 hEzzKBO6DGbt/bFXcMbu+kjeskzDwdttS4ctRizjrfD6/6v0HAqEB1H5RNEUdARtf8
	 LYQC8J3xUrHYH+gPswyYomkSPkvC4odehsENPRKQytpJ6MpCm34g7P/7xAYwHya4Cc
	 3LOkELAPzAdHgi8nyBdhM1Olswg2c15HMzV2sg4B4rVG1mSr8tdhu0CemB6uDvqsw3
	 vrk5YG9VHh9CVEtmZIGSK3SdjkkN8BEnicG2Y312tlmylJBUaYgm8ihhERFgu0VtvL
	 tQ4vvEWi4PYeg==
Message-ID: <3decb5293cb8fb2e8725600a8c5c930c32178602.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: dw: Fix IBI intr signal programming
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "Aniket ." <aniketmaurya@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley
	 <joel@jms.id.au>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 13:11:16 +0800
In-Reply-To: <CAMmmMt3u=DB5onXdayMN5ZHvCmdnam4wOo0hKizve4K0LnZLZQ@mail.gmail.com>
References: <20240606124816.723630-1-aniketmaurya@google.com>
	 <3c6c319f3aaa60428fd28f4d95c71dc9a8150081.camel@codeconstruct.com.au>
	 <CAMmmMt3u=DB5onXdayMN5ZHvCmdnam4wOo0hKizve4K0LnZLZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Aniket,

> > I think we're OK in this case (just not reading the value out of the
> > SIR_REQ_REJECT register), but any thoughts on adding corresponding
> > switches in the driver so we can support those configurations? These
> > would be represented as DT config of the specific hardware instance - a=
t
> > the most granular, just by the specific compatible string.
>=20
> We can go with some DT quirk, but I don't see the strong need to do this
> here.

Oh definitely - the behaviour here doesn't need any special handling
that would warrant a quirk/etc.

This is more for handling IP configuration options we may see in future.
For example, I believe support for target/secondary mode is entirely
optional too.

> > Could we use the SIR mask for this, but just read it from a field in th=
e
> > struct dw_i3c_master, instead of IBI_SIR_REQ_REJECT?
> >=20
> > This would mean that there's no possibility of the counter going out of
> > sync from the SIR settings - say, on underflow if we get a spurious
> > disable.
>=20
> Yes, we can keep a SW SIR mask instead of a counter. It would replace
> all the places where we read IBI_SIR_REQ_REJECT.
> Both methods are okay, but if you think the mask might come in handy in
> some situations rather than just the count, we can go with that.
> Let me know your thoughts on this.

I think keeping the mask value locally would be best. this means we

 1) cannot get the counter and mask out of sync; and
 2) don't need to do a read-modify-write on a register that is only
    updated by the driver.

Cheers,


Jeremy

