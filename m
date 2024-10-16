Return-Path: <linux-kernel+bounces-367641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29199A04CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94014286F01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A22036FD;
	Wed, 16 Oct 2024 08:55:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E42156665
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068952; cv=none; b=UJbZ6cC/eb0M+jeQVVPfqUYZwpfe8KW7gQ31m79j66Dfym0xFnJliejV6VIXrAzzA1NThGTv2yvxkmJzQRUX2SxHPhvCS7ApYwwQnj4eA9arRyoIH5DgwL/mGsbv4fjfHrMetrJx1FaI8KERs66bgxSvymKtsROXBk5aPdLu20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068952; c=relaxed/simple;
	bh=2IXlqIJksTMhL5iFuI9VLfULEEsS/whZT0PZwVg6O9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuY6ipNT6IjvlZ05llHzcGE/l6UBlVP36QWnzvTB5Lrk9//TA5ouULmhCj2fx8YAGFGILgXBYFB9q2eUshYuXYvJIGZOJNpV4MhsvDFvs9i6wkI5Bf/V4Ag3faLXnEh4OwAoFOuB5tCe8TVh8aKApGhL3XFY4hF8KstBXxVF1QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465ADFEC;
	Wed, 16 Oct 2024 01:56:19 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04EAC3F528;
	Wed, 16 Oct 2024 01:55:47 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:55:38 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <Zw9_imsl2KLf7_GY@J2N7QTR9R3>
References: <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
 <CACRpkdY79nbBoaHe6ijuyJS9dDduNw_sv1J90pz121YDgCvC3Q@mail.gmail.com>
 <Zw51fhCkmCYrTOeV@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEcLD3PWd-9osjo9AOe5Jg-NMOmJ8afB_x7VeboueLoeQ@mail.gmail.com>
 <Zw59x0LVS-kvs9Jv@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXEnhHkxywh8TH1i=fmyAR8cXZ8D-rvV43X-N7GpCf2Axw@mail.gmail.com>
 <Zw6Jk74-d0mhR0jx@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXG3bwMGpArYNUm-qMO7PPgb3--wy5kp-3Ks2Uv9M479xg@mail.gmail.com>
 <Zw6X9KQT0-z7r7SY@J2N7QTR9R3.cambridge.arm.com>
 <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGGmsWs2XpM7zLURjKp67Uz2ePi1pSV1=rPCMgviLVUgw@mail.gmail.com>

On Tue, Oct 15, 2024 at 07:28:06PM +0200, Ard Biesheuvel wrote:
> On Tue, 15 Oct 2024 at 18:27, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Oct 15, 2024 at 06:07:00PM +0200, Ard Biesheuvel wrote:
> > > On Tue, 15 Oct 2024 at 17:26, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > Looking some more, I don't see how VMAP_STACK guarantees that the
> > > > old/active stack is mapped in the new mm when switching from the old mm
> > > > to the new mm (which happens before __switch_to()).
> > > >
> > > > Either I'm missing something, or we have a latent bug. Maybe we have
> > > > some explicit copying/prefaulting elsewhere I'm missing?
> > >
> > > We bump the vmalloc_seq counter for that. Given that the top-level
> > > page table can only gain entries covering the kernel space, this
> > > should be sufficient for the old task's stack to be mapped in the new
> > > task's page tables.
> >
> > Ah, yep -- I had missed that. Thanks for the pointer!
> >
> > From a superficial look, it sounds like it should be possible to extend
> > that to also handle the KASAN shadow of the vmalloc area (which
> > __check_vmalloc_seq() currently doesn't copy), but I'm not sure of
> > exactly when we initialise the shadow for a vmalloc allocation relative
> > to updating vmalloc_seq.
> >
> 
> Indeed. It appears both vmalloc_seq() and arch_sync_kernel_mappings()
> need to take the vmalloc shadow into account specifically. And we may
> also need the dummy read from the stack's shadow in __switch_to - I am
> pretty sure I added that for a reason.

I believe that's necessary for the lazy TLB switch, at least for SMP:

	// CPU 0			// CPU 1

	<< switches to task X's mm >>

					<< creates kthread task Y >>
					<< maps task Y's new stack >>
					<< maps task Y's new shadow >>

					// Y switched out
					context_switch(..., Y, ..., ...);

	// Switch from X to Y
	context_switch(..., X, Y, ...) {
		// prev = X
		// next = Y

		if (!next->mm) { 
			// Y has no mm
			// No switch_mm() here
			// ... so no check_vmalloc_seq()
		} else {
			// not taken
		}

		...

		// X's mm still lacks Y's stack + shadow here

		switch_to(prev, next, prev);
	}

... so probably worth a comment that we're faulting in the new
stack+shadow for for lazy tlb when switching to a task with no mm?

In the lazy tlb case the current/old mappings don't disappear from the
active mm, and so we don't need to go add those to the new mm, which is what
we need check_vmalloc_seq() for.

Mark.

