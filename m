Return-Path: <linux-kernel+bounces-554649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47503A59AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8A16D8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AF222FDFB;
	Mon, 10 Mar 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A9g/0upB"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B722FDF0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623931; cv=none; b=Tn5/bN0/cOpPE+kLvQDNXL6GA72DQxk1RWPitnGAxV6wNLqcHmX6Z9WguUaNmJwgbcgIR7bJUx7T0Hj80bGBJbvV9ilwf/J4fuwI4QaScNDm8qLCQA5xt3aXEvAu9yV6UkfcjFj/yrEl3btnjHdIaGF2km3bqO03BtAnHbLLg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623931; c=relaxed/simple;
	bh=nWkFwwrLc+aYxF0iZWY2bTRbIpx7h70e0m3QKsoBFUo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akQHCBDTzHjts0oYIVpWpOama8WQSZFzes6j2o6V1gRgT4j/y4K2vUkuP3o0oL66t+KRrVg7G7eBRY0hEKfj6IMm27pNzIi1VgjUpUr8Sf5gnhk2teSJ3cXbEJc23VHddOLrHZP1M77DsLXVdYEN3A1zdD4obEXwnoWF5EpMS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A9g/0upB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso660498366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741623927; x=1742228727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Z0f+eg+DGAv8ZQV/jNF7Kb50O1PslkOh6D6/Tb4Gs=;
        b=A9g/0upBx1fIABuJOwifCj6OWijnrVIKsOGxjtPEgWmYBgQLwmxIlQJM0N/4GukjP2
         rFby8wj2faBd1uiMcas6t2DzyOJ/45NBjhdKUyizcElWXA2299KKNlyA3Gs18YOIY5lU
         D8c1qZgtcMROFBvJCpIvcmTtxwteVRPuP6NSBXp5atsjv5FR9OW6icrmy+o29MiYVTxh
         xuQazBk0RVvpQ4HyuR2f/l/g8wzUMWq53YM9oKYiAHtgbURi/5xD0Y/IQdD5GkNTjTcr
         S5U/w7VV5+uHzLO5uzEqzzhJoC50+dQ5T4RgOf0omG+NVsJosYICoc8AQesk5AexkPfK
         FXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741623927; x=1742228727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6Z0f+eg+DGAv8ZQV/jNF7Kb50O1PslkOh6D6/Tb4Gs=;
        b=o+B+/mucCsooWTYMZZBDbZh6LQITtU2OmB6f7AqlVrJY3DB+hSAKUsoEDw4o5aisrx
         J3QXBJNpq33ujiymAu6GklNL4bturwryo897igROwVojP8oWwybjJwzW+w868L/gz2Ig
         9Yo8jl9QjfJrCWnEee6lgCSydS51UbwTEQYT9gFjr1Z4acox1OL9Qf8eOGpEcftpvTtn
         yAN4AhoArzuTynOeL2jwaqNX4uhpPOdgGp0T1yAbFbAgwYVEXa84lHGdkD4LrQy/QzsD
         CQPHTQfp2H4M35H64jpRiTYVOlFaEg1JjrXqLlHO478UB0Ot1lzU/CbYA7R6lkxwBMax
         2WJg==
X-Forwarded-Encrypted: i=1; AJvYcCVPgpVwooU/ZTgKIHwGTn42ROUk8NSlGdYkk2wPGEmcNdxYDJT4X0+ndDUSUp6+RQdeo/Me8sekxOcuV2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nddX9LadzaE7Bc6h7h6fv1JPO/VfzU8Re+qDhe7ZdRperMeA
	APzGss3ErWd1O3z5z76E6CGshsuuPGC1VnHmdDSba/Chg5F6yWTlccgXnUtvKu8=
X-Gm-Gg: ASbGncsmfHTxTJIqDdT9ugkHqupdbe6HgaQHMaUEbySIpUCb5yihfvqy9G0Gsw/Gap/
	tVSN5yUFzt87X21d443pXBWhyr9ylhSyfs7Q5zSf+O2GxMYlwIjACOS0CP1+6E+aiqjoPQNZkGz
	qkiC9cM2wLMPTtaRPvWVsNqflfTvMO4WZVJ55CGIuuT/UpUr0jHtFwp9MsEk7ZmBdHlYlmEo5de
	iBrer8EuWDkCD49vwLlEVdjAwakwpLGvxQiQs+UkR3fwUYFRhwHfeTqcUSXS9XwBdpPrj8x1jcw
	iizjogdqM4qdKsbA1mbIC4nRisJoX0i4fsgySnyap0Vdh8WFZw5SK8HdC7iKbhhMajdjVUjJT18
	bJ5c3DONzrMiK
X-Google-Smtp-Source: AGHT+IEF4RrMX0Se6BFeWVbwyO+I7ul3eer8KyKrzFnfeVIwfzLuGjn2ndfHjDR1WQOdWyC5VAq9Sg==
X-Received: by 2002:a17:907:93c6:b0:abf:5778:f949 with SMTP id a640c23a62f3a-ac2b9ea163bmr21665566b.42.1741623927360;
        Mon, 10 Mar 2025 09:25:27 -0700 (PDT)
Received: from localhost (host-87-14-236-98.retail.telecomitalia.it. [87.14.236.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2b8584feesm19463766b.6.2025.03.10.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:25:26 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 10 Mar 2025 17:26:36 +0100
To: Phil Elwell <phil@raspberrypi.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Herve Codina <herve.codina@bootlin.com>, andrew@lunn.ch,
	Arnd Bergmann <arnd@arndb.de>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	bhelgaas@google.com, brgl@bgdev.pl,
	Catalin Marinas <catalin.marinas@arm.com>,
	Conor Dooley <conor+dt@kernel.org>, derek.kiernan@amd.com,
	devicetree@vger.kernel.org, dragan.cvetic@amd.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, krzk+dt@kernel.org,
	kw@linux.com, Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	lpieralisi@kernel.org, luca.ceresoli@bootlin.com,
	manivannan.sadhasivam@linaro.org, masahiroy@kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, saravanak@google.com,
	Stephen Boyd <sboyd@kernel.org>, thomas.petazzoni@bootlin.com,
	Stefan Wahren <wahrenst@gmx.net>, Will Deacon <will@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v6 00/10] Add support for RaspberryPi RP1 PCI device
 using a DT overlay
Message-ID: <Z88SvEmaZYfysQ-k@apocalypse>
References: <CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com>
 <20250213171435.1c2ce376@bootlin.com>
 <CAMEGJJ1++aeE7WWLVVesbujME+r2WicEkK+CQgigRRp2grYf=A@mail.gmail.com>
 <Z87wTfChRC5Ruwc0@apocalypse>
 <CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com>

Hi Phil,

On 14:21 Mon 10 Mar     , Phil Elwell wrote:
> Hi Andrea,
> 

...

> 
> This is indeed our current DT usage for the Pi 5 family - a single DTB
> describing each board - although I would like to make it clear that
> overlays can then be applied on top of it describing the attached
> peripherals.

Indeed. Thanks for specifying that.

> 
> > 2 - RP1 LOADED FROM OVERLAY BY THE FW
> >
> > In this case the rp1 dt node is loaded from overlay directly by the fw and the
> > resulting devicetree is exactly equal to the monolithic dtb scenario.
> > In order for that overlay to be loaded by fw, just add 'dtoverlay=rp1' in
> > 'config.txt'.
> 
> This halfway house combines the advantages and disadvantages of
> scenarios 1 and 3. Compared to scenario 3 it gains support for
> applying overlays that make use of interfaces provided by RP1 - I2C,
> SPI, UARTs etc. Compared to scenario 1 it loses the ability for the
> base DTB to refer to elements of RP1, other than by replacing these
> DTB elements with overlays that must be loaded after the RP1 overlay.
> As such, we would see that as a backwards step and not use it.

This is in fact the second side of the problem I was mentioning: being
able to reference RP1 nodes from base tree (this of course arise only for
case 2 and 3, i.e. in case overlays are used). Some solutions to this have
been added by Herve (nexus nodes) and it seems promising, but I still
don't have a complete and tested solution.
My intention here is to verify if it is worth spending time on figuring
out a solution for the overlay case, since in case we only accept the
monolithic approach we won't use overlay for rp1 at all.

My idea is that we can still provide the dtbs for all three cases for the
user to choose from (so to potentially benefit from all advantages every
single solution provides), and refine the overlay case as we go, since we
can still fallback to the monolithic dtb in case we can't find a viable
solution to the across-overlay referencing issue.  But I'd like a confirm
from upstream too.
I think that this problem should really be addressed sooner or later (I'm
hinting at fpga hw, but lately we're seeing other appliances of this paradigm
arising more often), so maybe this is a good opportunity to lay the ground
for a proper solution that could be generalized for other situations too, but
again, not at the cost of slowing down rpi5 upstream efforts.

> 
> > 3 - RP1 LOADED FROM OVERLAY AT RUNTIME
> >
> > Here it's the rp1 driver that loads the overlay at runtime, which is the case
> > that this patchset originally proposed. The devicetree ends up like this:
> >
> >   axi {
> >     pcie@120000 {
> >       pci@0,0 {
> >         dev@0,0 {

...

> >         / {
> >                 ... all rpi5 board dts ...
> >                 &pcie2 {
> >                         #include "rp1-nexus.dtsi"
> >                 };
> >         };
> >
> >
> > with only minimal changes to the rp1 driver code, I can confirm that all those
> > scenarios can coexits and are working fine. Before processding with a new patchset
> > I'd like to have some thoughts about that, do you think this is a viable approach?
> 
> Thank you for this - the creation of a core RP1 declaration that can
> be tailored to multiple applications using different wrappers is
> exactly what I had in mind. I agree that your partitioning scheme can
> cater for the 3 usage scenarios, but for the reasons outlined above I
> think scenario 2 is not useful to us, although it isn't impossible
> that U-boot might see things differently; I see no harm in having it
> supported, but I wouldn't want anyone to go to unnecessary effort to
> make it work.

In all truth, this is in fact exactly your proposal (we discussed internally with
Dave also), just slightly re-arranged by me.
I agree with you about not wasting time, as I also mentioned above.

Many thanks,
Andrea

> 
> Phil

