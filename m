Return-Path: <linux-kernel+bounces-428455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE09E0EB6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9146165817
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354B1DF979;
	Mon,  2 Dec 2024 22:11:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5551DED42;
	Mon,  2 Dec 2024 22:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177472; cv=none; b=GRLeu5ovPOi5EI9SKofFH+9IcG6RjVCM+nlMMJTUt3sA5RvzLGbG+hJuUv8xQAO++6OCUsRXViqItR8qSQTCYQVAL6fFbdc8mHq7epiZaLCo/qOfGJgAhrsFVnKQIg03Ie25ysibzS2kSwKmu+qKeAw12d1UIo9KUUj5Nhtps2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177472; c=relaxed/simple;
	bh=NSi7TuoPYDA86OB0yX+c1buguqPzahAs/u3jPIT5Ouw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh8E+K82AUUNWBGKOiyVmljFrKyODPR63JbO/vzmdFRflH1s3RRdkn+i1COfLd7bCTzC9Z5I/cLh0CzuAIzj4fzL4Llx/y54eb5HRQwJ6tTUh3krn1lo87A/OpslLr3BF+C3cs6E3durm9ihvlQxRtsUcAfSMBz+s3D5c4tBsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4B2M4aRF010385;
	Mon, 2 Dec 2024 16:04:36 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4B2M4YP4010381;
	Mon, 2 Dec 2024 16:04:34 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Mon, 2 Dec 2024 16:04:34 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Rob Herring <robh@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Saravana Kannan <saravanak@google.com>, linuxppc-dev@lists.ozlabs.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
Message-ID: <20241202220434.GU29862@gate.crashing.org>
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au> <87plmi7jjz.fsf@mpe.ellerman.id.au> <20241127214232.GQ29862@gate.crashing.org> <CAL_JsqKhp8bW66koP8JPSkXmrCjA+oQh6NZte_uphiLTC_=7Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKhp8bW66koP8JPSkXmrCjA+oQh6NZte_uphiLTC_=7Rw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i

On Mon, Dec 02, 2024 at 08:18:22AM -0600, Rob Herring wrote:
> On Wed, Nov 27, 2024 at 3:47 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > On Tue, Nov 26, 2024 at 02:36:32PM +1100, Michael Ellerman wrote:
> > > Michael Ellerman <mpe@ellerman.id.au> writes:
> > > > "Rob Herring (Arm)" <robh@kernel.org> writes:
> > > >> While OpenFirmware originally allowed walking parent nodes and default
> > > >> root values for #address-cells and #size-cells, FDT has long required
> > > >> explicit values. It's been a warning in dtc for the root node since the
> > > >> beginning (2005) and for any parent node since 2007. Of course, not all
> > > >> FDT uses dtc, but that should be the majority by far. The various
> > > >> extracted OF devicetrees I have dating back to the 1990s (various
> > > >> PowerMac, OLPC, PASemi Nemo) all have explicit root node properties.
> > > >
> > > > I have various old device trees that have been given to me over the
> > > > years, and as far as I can tell they all have these properties (some of
> > > > them are partial trees so it's hard to be 100% sure).
> > > >
> > > > So LGTM.
> > >
> > > Turns out I was wrong.
> > >
> > > The warning about #size-cells hits on some powermacs, possible fixup
> > > patch here:
> > >
> > >   https://lore.kernel.org/linuxppc-dev/20241126025710.591683-1-mpe@ellerman.id.au/
> >
> > The Open Firmware specification is extremely clear that a "missing"
> > "#size-cells" property means this bus has the default value of 1.
> 
> And the default for #address-cells is 2, but yet every architecture
> except Sparc has that wrong.

?

Almost all architectures (that run Linux) use 64-bit addressing, both
32-bit and 64-bit architectures.

> If I have a node without #size-cells, is the default of 1 used or do
> we check parent nodes? My read of the spec would be the former, but
> the kernel does the latter.

The former is correct.  The latter makes no sense at all!  The whole
point of the "bus" abstraction is that you get a new addressing domain
there.

Yes, these days you numerically find it most often with PCI sub-domains,
but those are boring.  In most cases you *do* have different adressing
on your child busses, and even if the addressing is the same, addresses
on the child bus are not normally a subset of those on the parent bus.

> > https://www.openfirmware.info/data/docs/of1275.pdf (page 186).
> >
> > DTC or FDT might want to do things differently, but expecting decades
> > older stuff to conform to its ill-conceived unnecessarily super wordy
> > stuff is, well, not a plan that is likely to work very well :-)
> 
> That is not the intention. The intention is to identify what doesn't
> conform and exclude those systems from this check (or apply a fixup if
> that works).

So *always* use the OF definition, at least on OF systems?  Where
everything is meant to conform, but conform to OF, not conform to this
"OF-like-but-very-different-in-crucial-spots" thing :-)


Segher

