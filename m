Return-Path: <linux-kernel+bounces-174440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06F8C0EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F7284037
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA2130E4D;
	Thu,  9 May 2024 11:13:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5312FF8E;
	Thu,  9 May 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253220; cv=none; b=HwB6cX6lpQMZnZ8pR8Lf//a9YVrCGK6elp60+LmfNt3IFuWGss/R6un48x3RmJO6ojlWCE+CQSE8SO1dEr9B7QTvYmmHw80abV0v4nkflkZ+wDqzZP3G+g9ohQYK1jilLleaRq9TybNkiABAQctAbZRxPFh1wB/C8GsUv5ZeI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253220; c=relaxed/simple;
	bh=BHSGlKUMbh6We/MDoY819/cZjVhr7tCn9O1b/b0XEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdzDTW88p9HspoMZBovvVgEYw23L93xK1OdmS/y5k6wZK2Q806G6is5wWqj5d2Bj3QReHEfW7+AAZUWV8GFKkwRM7QDVxHxejGHdVBRsiaanaT/mt2S1Q9pjOOI4sPq6JpnojnrJhWWHpBfv7sdSptexi7It3PdyNOJGvbaRHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B24C116B1;
	Thu,  9 May 2024 11:13:33 +0000 (UTC)
Date: Thu, 9 May 2024 12:13:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Zayd Qumsieh <zayd_qumsieh@apple.com>,
	Justin Lu <ih_justin@apple.com>,
	Ryan Houdek <Houdek.Ryan@fex-emu.org>,
	Mark Brown <broonie@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florent Revest <revest@chromium.org>,
	David Hildenbrand <david@redhat.com>,
	Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>,
	Zev Weiss <zev@bewilderbeest.net>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
Message-ID: <Zjyv23IuJFrk9Zh0@arm.com>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
 <20240411132853.GA26481@willie-the-truck>
 <87seythqct.fsf@draig.linaro.org>
 <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXFqG7D2Q_T_NXZ-y3NYOjK6d8bP8ihJTeFz8TUJ77W7tw@mail.gmail.com>

On Tue, May 07, 2024 at 04:52:30PM +0200, Ard Biesheuvel wrote:
> On Tue, 7 May 2024 at 12:24, Alex Bennée <alex.bennee@linaro.org> wrote:
> > I think the main use case here is for emulation. When we run x86-on-arm
> > in QEMU we do currently insert lots of extra barrier instructions on
> > every load and store. If we can probe and set a TSO mode I can assure
> > you we'll do the right thing ;-)
> 
> Without a public specification of what TSO mode actually entails,
> deciding which of those barriers can be dropped is not going to be as
> straight-forward as you make it out to be.
> 
> Apple's TSO mode is vertically integrated with Rosetta, which means
> that TSO mode provides whatever Rosetta needs to run x86 code
> correctly, and that it could mean different things on different
> generations of the micro-architecture. And whether Apple's TSO is the
> same as Fujitsu's is anyone's guess afaik.

Indeed. Apart from using impdef registers, that's what I think is the
second biggest problem with this feature (and the corresponding
patches). We don't know the precise memory model, we can't tell whether
this TSO bit is stored in the TLB. If it is, is it per ASID/VMID? The
other problem Marc raised is what memory model is between two CPUs where
only one has the TSO bit set? Does it only break the TSO model or is
there a chance that it also breaks the default relaxed model? What other
TSO flavours are out there, how do they compare with the Apple one?

> Running a game and seeing it perform better is great, but it is not
> the kind of rigor we usually attempt to apply when adding support for
> architectural features. Hopefully, there will be some architectural
> support for this in the future, but without any spec that defines the
> memory model it implements, I am not convinced we should merge this.

There is FEAT_LRCPC (available on Apple Silicon from M2 onwards). Rather
than having a big knob to turn TSO on or off, this feature introduces
instructions that permit a code generator to get the TSO semantics in a
more efficient way (e.g. using LDAPR+STLR instead of the stricter
LDAR+STLR; not sure how well these are implemented on the Apple
Silicon). There are further improvements in FEAT_LRCPC{2,3} (with the
latter adding support for SIMD but not available in hardware yet). So
the direction from Arm is pretty clear, acknowledging that there is a
need for such TSO emulation but not in the way of undocumented impdef
registers. Whether more is needed here, I guess people working on
emulators could reach out to Arm or CPU vendors with suggestions (the
path to the architects is not straightforward, usually legal has a say,
but it's doable, there are formal channels already).

I see the impdef hardware TSO options as temporary until CPU
implementations catch up to architected FEAT_LRCPC*. Given the problems
already stated in this thread, I think such hacks should be carried
downstream and (hopefully) will eventually vanish. Maybe those TSO knobs
currently make an emulation faster than FEAT_LRCPC* but that's feedback
to go to the microarchitects on the implementation (or architects on
what other instructions should be covered).

-- 
Catalin

