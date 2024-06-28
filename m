Return-Path: <linux-kernel+bounces-234592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8691C85E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A702883BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E080BF5;
	Fri, 28 Jun 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFgFx2TF"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028EE5339D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611088; cv=none; b=q65IhBkP4XDOpnhZxMaj6zMlv2u4ghyA1CTqfKlyRrLD3xLARQubvruftLSveFAuLsYQLIpxwNHPpzDF5r9+hJkTxfMt/nCTYOly6PEj85zlXcaz8lWJ2SxGqYVV80YgaMQ6Vt3pa5JacB0BX+ZfW1oPwvB+eKJUg2z83TD4G7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611088; c=relaxed/simple;
	bh=CtggTfmotgQY42z4hrkA9q5LtAQ+RWQdooL1NI15YbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI2n+QK1dOable+FtLsqysTnle2f/OHRMl0qVESvMsmk3ENmvR9y+r0gQ1mbRJ68LynfVgRls0Tpe0YHS7u74RefSF4+jmvogj6xnHJV1QIvb7dk9E07c0aQ9eyNlBQ1ozNccdddbBc3dnrAFljNtMrB6FSmCLufB3Zse1q/J1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFgFx2TF; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c8dccd0fa9so757466a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719611086; x=1720215886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DubuFETnT0dyqatA7lSmZY+Vs7DIyyvK1no9Y8gOx38=;
        b=DFgFx2TFIFBY1O7zlmv0iQY2qgR/gR9VugzpZOwg/I+LTlllPzZEucKlvn8f1tK1Je
         5pNmQ/bGePeMi4eB5mtlJ45evhEE3kJHDGA+HiNxf03XOQcqjyBVLid3UHkZV6Osry7U
         McG9zXmQ2h+QFi53qIcWAfCqTQ7Tw7Zil4oKR9VlO6lMZVHeXEgpm5Klo8ZK1vcCd2rA
         Bff4CZaJerHRWh8JG2O9Wy1gvdmVuj6v7ugdDsB79qjCv7bwcdp8Bxp7R+hgx4TPSGPe
         5Hf7g3tAa5TJNH/dAbw5xVkx+jhC+1+yiEdKAuEuoqK7nOVlu/wN3vbhRwY5Jnr7gAnh
         82kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719611086; x=1720215886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DubuFETnT0dyqatA7lSmZY+Vs7DIyyvK1no9Y8gOx38=;
        b=tjzl3A9zRrHNXCpi0Z5CKpEQ9WY4uCZsTHbfMB3pV0yvzIRRD5QOK2fVbvXqxSMHFB
         +1wcnJCJrSeyxguYb0Vw/p5Jh/xcWfJraY9xk2olE5Jp7xEfq6zgJFx60kTsKtQDJFBF
         a/FQt6xNsKUz6vZUoYZTz0yVJQto6V88JmpD3j5YkQxrhQt6Ovua4EvGowH55MvcG4ad
         n9gXsG/q3Yg6JWnrHplD/G/NifI8ZL/TtauYWxxrlnNvEe8kODbauAAT8VzcRcsNF6J/
         sLVq3ZIiXy/5v8ohzJBt6x06pl+b9O5NIWHqs+Z3Z7F+/Dxtf3vDAxO9Y2PV83KFPov+
         /iIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEvHc9tWCu32YetJtE2gtO3MND31AeHkBUbj963S/4PGChw/yY3cyBCUVW44++77TI00NemqSNR0MY1c3vfe2J4R2sN8TJ5+4CkJU7
X-Gm-Message-State: AOJu0YzOYWulnARY8ZeOPeHfucRkDIz8XS/ZpqIThrMuNFiRMsDfp0T5
	nYgVwGTQc5+s6llT+OwfT+akpY5m+sV+eD7kSFRlvjwAhyXGwHgY
X-Google-Smtp-Source: AGHT+IH+5VYC5V34ZB3U73ePclfXnKCTmbEYsVuuuFk/T706oMclVdzLXX8sga4PNh1EMwTZOR/SUQ==
X-Received: by 2002:a17:90b:a50:b0:2c8:880:fba5 with SMTP id 98e67ed59e1d1-2c86146d12bmr17092067a91.34.1719611086103;
        Fri, 28 Jun 2024 14:44:46 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9c98:1988:ce15:c0ac])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e99b1sm2134010a91.54.2024.06.28.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:44:45 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:44:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
	Daniel Mack <daniel@zonque.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>, soc@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] ARM: pxa: use software nodes/properties for GPIOs
Message-ID: <Zn8uywbvZDDVSjT0@google.com>
References: <20240628180852.1738922-1-dmitry.torokhov@gmail.com>
 <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9dd921-56a6-48cf-9f25-b8bb079c4249@app.fastmail.com>

Hi Arnd,

On Fri, Jun 28, 2024 at 10:59:53PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 28, 2024, at 20:08, Dmitry Torokhov wrote:
> > This series converts legacy pxa boards (spitz, gumstix) to use software
> > nodes/properties to describe various GPIOs instead of relying on GPIO
> > lookup tables. The benefit is that structure and behavior is closer to
> > DT-described GPIOs.
> >
> > The very first patch ("ARM: spitz: fix GPIO assignment for backlight")
> > is actually a fix that IMO should be applied sooner rather than later,
> > the rest of patches are enhancements. The reason it is sent with the
> > rest of the series is that later changes contextually depend on it.
> >
> > The last patch ("ARM: spitz: Use software nodes for the ADS7846
> > touchscreen") soft-depends on corresponding changes by Linus Walleij to
> > the ads7846 driver in input tree. It compiles without it, but the device
> > will not sync with display refreshes. I have created an immutable branch
> > (branched from v6.9) at:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git ib/ads7846-hsync
> >
> > in case you wish to pull it in.
> >
> > Regretfully it was only compiled as I do not have access to the relevant
> > hardware.
> 
> Hi Dmitry,
> 
> I'm happy to pull these in directly, hopefully with some extra
> review or ack from the maintainers. If there are no negative
> comments, feel free to resend them to soc@kernel.org for me
> to pick up.
> 
> Is your goal to of the series to eventually convert all
> gpio descriptors over to software nodes, or are you working
> towards converting all of mach-pxa to DT?
> 
> In the latter case, note that the reason we kept these
> specific board files is that they have reasonable support in
> qemu and you can probably figure out how to test them if you
> try hard enough. I have not tried myself though, and there is
> a high chance that current kernels won't boot without extra
> fixes.
> 
> If your goal is to change all board files to software nodes,
> I think we should take a step back, since most of those boards
> are likely to get removed anyway. Two years ago, I removed
> almost 90% of the board files remaining at the time after
> showing that they were pretty much all unused. I kept the
> ones that either had known users, or that someone wanted to
> keep for some reason and work on doing the DT conversion.
> For most of these (including PXA), there has been no work
> on this in the past two years, so I think we should ask the
> same question again and see which ones we can just remove
> this time.

I would like to eventually switch everything to the software
nodes/property entries. The GPIO lookup tables were introduced before we
had software nodes and were really convenient way to describe GPIOs on
non-ACPI non-DT boards. However now that we have software
nodes/properties we can move away from both custom platform data and
lookup tables in the board code and remove platform data support from
the drivers, unifying the driver behavior.

I am not in any rush with this, so if some boards are on a cutting block
I am happy to wait. I started poking at Spitz and the rest of mach-pxa
because Linus W sent out a patch to ads7846 ;) and I also remembered
that you already dropped bunch of PXA boards that were no longer
relevant so I assumed spitz and gumstix still have some use.

Could you tell me which ones are likely to stay vs ones that might go? I
think arch/arm/mach-s3c/mach-crag* is staying? jornada720?

Thanks.

-- 
Dmitry

