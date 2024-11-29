Return-Path: <linux-kernel+bounces-425863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F729DEBF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B735163467
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185F1A0BE1;
	Fri, 29 Nov 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TCOswHG/"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7221A3029
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732903971; cv=none; b=V2lvptthvCX4j4HUy693rSs1rQzA1GdFdwsRen7NDxWSokV876O5mxERHEeAJT+vQ1e+lgkglG5ByrH017S/Ko8tW2n1etg9VU3rzFRatMWMTYXLrxFpXlI0eSDfCIKEUXxIR76GI4iBPrMxAnts92kArh9HykcUAsSZ8QimMvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732903971; c=relaxed/simple;
	bh=8m5EkwHWXTgiJwnuArld1Pc2dzxSHyhvXjaEvUO7Ng8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQL1fpwOaDFFZhgFh4Z46XQ2BgTqpbl9bwtZqMNK/EH5x97U38HGKNOTaGZgJEcF77bkCGL0oRWMQDmLvd+JSR3OvyvHy5NEYnnlI+qOjvOl6Cn3zIEQPMqcon4XKAdDwCT7B3AOztKj/tt3VuFKTEq+n36DGyQEk7rqnyH53rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TCOswHG/; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73BFD20002;
	Fri, 29 Nov 2024 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732903961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=agrCji/PzHghXXELIiWdgYLBGtoBMSEMrQmMun4PhKI=;
	b=TCOswHG/5rcssTH0+xbAqtK6sG5e7+GpeamLQBtYNofJKrq2B0aiJB6eXVX33HgPUBONJ0
	81HtguzDO1Gm41DMMxgg4Kbp+8uAVEdcnommHWlskydTgehjsDECdfjb8pfszWmwww808C
	n487RHKXRngQwzY5qGRyNSzJ3QFRFn2PSlvleISm31HNRGBvt+1Q7c8PAn4ecWhb9KKQQf
	1vT8Dogd5Oq15P0M2L4SpSRYHJpayG0nLb7eopkPwGJhN22GEeRBuFK9sXRQS863nu+eoT
	UcK2CnlfwnOG90jPrXoeppL1lv7VcHx33db3FUF+/qmmNhnau270Zs5zDRDrNg==
Date: Fri, 29 Nov 2024 19:12:39 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: Kconfig: Make MCHP_LAN966X_PCI depend on OF, not
 select it
Message-ID: <20241129191239.69b649e8@bootlin.com>
In-Reply-To: <CANiDSCtVdPh4YX1pgRQ+M+KGTD+k5UPxWhZM09FBiT5+hDifjw@mail.gmail.com>
References: <20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org>
	<20241129184500.6d72a7e1@bootlin.com>
	<CANiDSCtVdPh4YX1pgRQ+M+KGTD+k5UPxWhZM09FBiT5+hDifjw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Ricardo,

On Fri, 29 Nov 2024 18:57:09 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Thanks for the headsup
> 
> On Fri, 29 Nov 2024 at 18:45, Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Fri, 29 Nov 2024 10:41:17 +0000
> > Ricardo Ribalda <ribalda@chromium.org> wrote:
> >  
> > > Most (maybe all?) the drivers depend on OF instead of selecting it. This
> > > is more convenient for CI because we can have test scripts that do:
> > > make allyesconfig
> > > scripts/config -d OF
> > > make olddefconfig
> > >
> > > Without this patch, OF cannot be disabled that way.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/misc/Kconfig | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index 902c306bc972..2ea5f40ff4e4 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -612,8 +612,7 @@ config MARVELL_CN10K_DPI
> > >
> > >  config MCHP_LAN966X_PCI
> > >       tristate "Microchip LAN966x PCIe Support"
> > > -     depends on PCI
> > > -     select OF
> > > +     depends on PCI && OF
> > >       select OF_OVERLAY
> > >       select IRQ_DOMAIN
> > >       help
> > >
> > > ---
> > > base-commit: 7af08b57bcb9ebf78675c50069c54125c0a8b795
> > > change-id: 20241129-lan966x-depend-8bc69b4954e5
> > >  
> >
> > Not sure it should be done that way (See [1]). Also I pointed out this
> > patch in the discussion.
> >  
> 
> I have no strong opinion for my version or:
> 
> depends on PCI && OF_OVERLAY
> 
> 
> Shall I send a v2 or you prefer to handle it yourself?

You can send a v2 with
  depends on PCI
  depends on OF_OVERLAY

If you send a v2, can you add people listed in
  https://lore.kernel.org/all/dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol/

Best regards,
Hervé

