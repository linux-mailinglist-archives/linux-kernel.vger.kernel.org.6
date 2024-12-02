Return-Path: <linux-kernel+bounces-428483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3609E0F11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DC6281D72
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA71DB940;
	Mon,  2 Dec 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/5rJHri"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88581D79B4;
	Mon,  2 Dec 2024 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180170; cv=none; b=uvr7tDU4wW2WOXeiZAem7RIlLJTOX4nKtn6seNssGH1iYjibEMycsRi1/6rC/yBCzVSsWYBeXuMWKRkcyUkPrgHjcAN298yxpOumi22FjVEhjnc3GwMUjftZ6FWqGc69DgN+ogtqloGRDkuZLEip4vVQ00RMM5RSc82iPNa2BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180170; c=relaxed/simple;
	bh=C390/U3lQIPd9DTFWuMmUpP8GWQW0gL7hXO3NhmNEoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwaudG1S4GziGQEYANorknlS799UECa1qLouhiRi0/kN9sMY90aLzvPqRTrhvCRcePj7NR5O0KP+Ne+Juo+A95QjMldScN/b5cbqtqKFTlSCzrAQGW3p3rEH/I3e/0qMsRPA1TySZocoyqYlggQhmNC5tAr3D7muUp9Mc/43R4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/5rJHri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67929C4CEDD;
	Mon,  2 Dec 2024 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733180170;
	bh=C390/U3lQIPd9DTFWuMmUpP8GWQW0gL7hXO3NhmNEoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r/5rJHriXWguekh0f3N3wpCM6DHd8Febo2Z89o3XFa+sqg6Sc5mw1sdkIpBVPJIjP
	 fPeVZSKVqzt8dAJTyzb+SX4+90hzsWu5mhWINAOB7Qu/gjF6dTj1FBtYmHFqsGZ3S6
	 AyiMKR39vdB31rXhQwNq1ASmb3nY4MhLv2Lz/PFYZZqHHJDMs0wokItOiSEAzEAvXC
	 EFZVQno86P0pHvhArboKTcZ+OKZjLD2/4WKaJoDGr2xcNQWEwGz3AlsD7OQFRnBdno
	 kiT2j7Ry5pt86rVvFb/nf/4U52g+DMvRRZw3KKkjDdW6XADxUaKHN2ie/TmOqwAXXF
	 vln9XWzgVCAZQ==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e399f8bb391so1926760276.2;
        Mon, 02 Dec 2024 14:56:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKNL1K0GCsJdaMR34sJOqxC7TsGaxt8kI/qbkoVfA9lW0RrZ3vWl+CTtYHpXRhmz6b98sf40HmJWCO@vger.kernel.org, AJvYcCW0zFZPKKidHKU9wb0+BYX7snx9mRRY/saOejYNoZP5zzOMBgH7b23FrCNALTRjooso7Kch1Ie2jQayohOX@vger.kernel.org
X-Gm-Message-State: AOJu0YytdOk3o1HIlxv4mAcvQ1/YylGy5+C4Suv/Sg5yq8S+t66+srnW
	OAIqOammYcSv8m1XI8mYxEOd5bbR3BYLi76TaRpc4JsMnOUyvdwiPUqASgzt57/PlfKy5TLw79T
	Hyd2LQqET0lepFO20j5ky5WHQqA==
X-Google-Smtp-Source: AGHT+IEqo9P4Zr3/vlhz9V+X1UM634ot9hRB2b4JJ5/kLZJov8aEvuWuPHXqi5ULgy6Qx9wsrwTqWQ6sVwGERMSPO/I=
X-Received: by 2002:a05:6902:338a:b0:e38:87bf:8e65 with SMTP id
 3f1490d57ef6-e39d35a8631mr282616276.0.1733180169551; Mon, 02 Dec 2024
 14:56:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106171028.3830266-1-robh@kernel.org> <87jzdfcm3l.fsf@mpe.ellerman.id.au>
 <87plmi7jjz.fsf@mpe.ellerman.id.au> <20241127214232.GQ29862@gate.crashing.org>
 <CAL_JsqKhp8bW66koP8JPSkXmrCjA+oQh6NZte_uphiLTC_=7Rw@mail.gmail.com> <20241202220434.GU29862@gate.crashing.org>
In-Reply-To: <20241202220434.GU29862@gate.crashing.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 2 Dec 2024 16:55:58 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL5FHPNQWGdBEz9UpD7cq3We-czPV8OmwD=0w5Eu10=kA@mail.gmail.com>
Message-ID: <CAL_JsqL5FHPNQWGdBEz9UpD7cq3We-czPV8OmwD=0w5Eu10=kA@mail.gmail.com>
Subject: Re: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Saravana Kannan <saravanak@google.com>, 
	linuxppc-dev@lists.ozlabs.org, Conor Dooley <conor@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:09=E2=80=AFPM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Mon, Dec 02, 2024 at 08:18:22AM -0600, Rob Herring wrote:
> > On Wed, Nov 27, 2024 at 3:47=E2=80=AFPM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Tue, Nov 26, 2024 at 02:36:32PM +1100, Michael Ellerman wrote:
> > > > Michael Ellerman <mpe@ellerman.id.au> writes:
> > > > > "Rob Herring (Arm)" <robh@kernel.org> writes:
> > > > >> While OpenFirmware originally allowed walking parent nodes and d=
efault
> > > > >> root values for #address-cells and #size-cells, FDT has long req=
uired
> > > > >> explicit values. It's been a warning in dtc for the root node si=
nce the
> > > > >> beginning (2005) and for any parent node since 2007. Of course, =
not all
> > > > >> FDT uses dtc, but that should be the majority by far. The variou=
s
> > > > >> extracted OF devicetrees I have dating back to the 1990s (variou=
s
> > > > >> PowerMac, OLPC, PASemi Nemo) all have explicit root node propert=
ies.
> > > > >
> > > > > I have various old device trees that have been given to me over t=
he
> > > > > years, and as far as I can tell they all have these properties (s=
ome of
> > > > > them are partial trees so it's hard to be 100% sure).
> > > > >
> > > > > So LGTM.
> > > >
> > > > Turns out I was wrong.
> > > >
> > > > The warning about #size-cells hits on some powermacs, possible fixu=
p
> > > > patch here:
> > > >
> > > >   https://lore.kernel.org/linuxppc-dev/20241126025710.591683-1-mpe@=
ellerman.id.au/
> > >
> > > The Open Firmware specification is extremely clear that a "missing"
> > > "#size-cells" property means this bus has the default value of 1.
> >
> > And the default for #address-cells is 2, but yet every architecture
> > except Sparc has that wrong.
>
> ?
>
> Almost all architectures (that run Linux) use 64-bit addressing, both
> 32-bit and 64-bit architectures.

I'm just telling you what Linux uses for defaults for at least 20 years.

> > If I have a node without #size-cells, is the default of 1 used or do
> > we check parent nodes? My read of the spec would be the former, but
> > the kernel does the latter.
>
> The former is correct.  The latter makes no sense at all!  The whole
> point of the "bus" abstraction is that you get a new addressing domain
> there.

I agree, but that's what the kernel does (again, for 20+ years).
Walking the parents is really what I want to get rid of here. My
choices were drop that behavior and see who I break, or add a warning
and see who notices. I went the nicer route of a warning.

> Yes, these days you numerically find it most often with PCI sub-domains,
> but those are boring.  In most cases you *do* have different adressing
> on your child busses, and even if the addressing is the same, addresses
> on the child bus are not normally a subset of those on the parent bus.
>
> > > https://www.openfirmware.info/data/docs/of1275.pdf (page 186).
> > >
> > > DTC or FDT might want to do things differently, but expecting decades
> > > older stuff to conform to its ill-conceived unnecessarily super wordy
> > > stuff is, well, not a plan that is likely to work very well :-)
> >
> > That is not the intention. The intention is to identify what doesn't
> > conform and exclude those systems from this check (or apply a fixup if
> > that works).
>
> So *always* use the OF definition, at least on OF systems?  Where
> everything is meant to conform, but conform to OF, not conform to this
> "OF-like-but-very-different-in-crucial-spots" thing :-)

I'm pretty sure there are OF systems that don't conform, so it is not
that simple. There's this comment in of_irq_parse_raw() for example:

        /* Look for this #address-cells. We have to implement the old linux
         * trick of looking for the parent here as some device-trees rely o=
n it
         */

Maybe that's from some system long dropped and we don't need it
anymore. I have no idea. That's what I'm trying to find out with this
patch.

We also don't really have a way to distinguish OF from FDT (where we'd
need to). It is somewhat just by arch, but PPC always passes an FDT to
the kernel for both FDT and OF systems.

Rob

