Return-Path: <linux-kernel+bounces-245274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD292B08A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39A71F23534
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD914374C;
	Tue,  9 Jul 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+VIsAyN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D71420D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507796; cv=none; b=MlM72z0mwrQrAScpbU/zB77pvQfkgMsKIeNBNdZ6oNTpGejgf7GpUCBZzmFZAjhBC9obx4frX3KKEB6SLLKB+eKwNYoFr1nrZJ1PHcLzwTUrKto1i1uC3foPG2/0AQJvA2Kvt4qlXbx6imZqr7KodOF1Rp5uCQv4W/oZFCEvDGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507796; c=relaxed/simple;
	bh=ZI3nhBOs01vCGhDy6YO+HDIc/uvkApSJbIx/e/ndpmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8oBVP81fM4XuO0d7vDSS2vGQwEqcnUBr3DCRxyrqOIuIATqTzsXCPpwkSd4Lm7D9ksZv2XyP3IjcH0axwOQYdru+SqD1PP1lkAWncmC9Z/18tiz0L+YvCC/5IB4zP+MFTz/6eReG991R9R30dHcx6Rqg0N2pTBGEBarKt7nHyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+VIsAyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04276C4AF16
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720507796;
	bh=ZI3nhBOs01vCGhDy6YO+HDIc/uvkApSJbIx/e/ndpmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q+VIsAyN0ICkOBJbAywNk+H8bGojrvfX7mVgGyj9YP1F/azcS802aTRkv3wgvDC6G
	 rnk9bKB/tF1EPRL3xByaSbRqRJwC252wRVCVbA4HCfOz5kxZ4evMdvBnWx0eIAuor7
	 i3ZDIJd2JRAEMQztaOcasNmCv80Imr4LwdGbO4JyEeKj9rRp+jb1rK1ursZHXjWK2N
	 mAnmsLXz6BpN5jybB0VGIwtdWHThw7298BwNYCLQW/cjeAnR/vyyMr57tYFzDYNmNn
	 fNKatrHJ4mEZLNvKbx85iGI6XFMIveR4h249aWjdhHiNJGM3gnPgPlzOmlEpIYZMI3
	 5YeeC6ZWwmzMw==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eea8ea8c06so20142801fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBcbbCs/2aJSKg8OX+xONBohYg/cqYZ1EijvxgpVGH0kx6d/g9y5PiFKeWLKPVf4t/NC5vD3vHBrMbDIEltspOHv6MFVGyX1D3lcQM
X-Gm-Message-State: AOJu0YwtuWLeGBmCjWb5HtXSMgvtBpGUKPyKJJkehbVPc2MOt8ZIxvbM
	U8+5/pPVvlA8L+I8e0yf/dZSNXgXmbxwLQuUI092gOYhJAKGb/0xExfWk2sVFrWPZubgaFGvwkW
	20m02KhjSgKBUJN6xkL4FCaYI65E=
X-Google-Smtp-Source: AGHT+IEWp5XmJmTMy8Jp/Xze2qbky4Lyk8eshMwouoPdtybFRxYKNDFSk5UAe+S3dViToCq1h91B7+35xwyI7FAUpTc=
X-Received: by 2002:a2e:9bd8:0:b0:2ee:7d3c:66f with SMTP id
 38308e7fff4ca-2eeb3188d32mr10583761fa.34.1720507794290; Mon, 08 Jul 2024
 23:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local> <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local> <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local> <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local> <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com> <ZoxX9mckeu046zed@swahl-home.5wahls.com>
In-Reply-To: <ZoxX9mckeu046zed@swahl-home.5wahls.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 9 Jul 2024 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
Message-ID: <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>, Ashish Kalra <ashish.kalra@amd.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>, 
	Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 23:20, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> On Mon, Jul 08, 2024 at 11:05:29PM +0200, Ard Biesheuvel wrote:
> > On Mon, 8 Jul 2024 at 22:41, Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > On Mon, Jul 08, 2024 at 09:58:10PM +0200, Borislav Petkov wrote:
> > > > On Mon, Jul 08, 2024 at 02:29:05PM -0500, Steve Wahl wrote:
> > > > > Yes, this is about AMD machines which support SEV, running bare metal.
> > > > > ("Server" is in question, one of my testers is known to be using a
> > > > > laptop, so the facilities must be present in non-servers as well.)
> > > >
> > > > No, they can't be. SEV is supported only on server, not on client. This laptop
> > > > has a different problem it seems.
> > >
> > > Ahhh.  On the laptop, it's not looking *at* the CC blob that's the
> > > problem.
> > >
> > > Its looking *for* the CC blob in the EFI config table; the CC blob
> > > probably does not exist in that table on the laptop.  But the EFI
> > > config table needs to be identity mapped, to look through it and see
> > > that the CC blob is not there, and the EFI config table is not mapped.
> > >
> > > I think the existence of the CC blob in the EFI config table is being
> > > used, more or less, as a flag as to whether we need to do SEV related
> > > code.  Without mapping the EFI config table, we can't look for that
> > > blob.
> > >
> >
> > We have run into this exact problem before - I don't have time to
> > check lore right now (it's 11pm here) but 'CC blob' and 'EFI config
> > table' are the keywords that may help you track down the thread.
> >
> > So first of all, let's define some terminology:
> > - the EFI system table is the EFI root table that contains some magic
> > numbers and pointers to various other assets in memory, one of which
> > is:
> > - the EFI config table array, which is just a list of (GUID, pointer)
> > tuples, the length of which is recorded in the EFI system table
> > - an EFI config table is some asset elsewhere in memory that is
> > identified by its GUID.
> >
> > The EFI config table array can grow and shrink at boot time, which is
> > why it is a separate allocation, as this allows it to be realloc()'ed.
> > This means any bootloader that intends to map the primary EFI table
> > should also map the EFI config table array, which may be elsewhere
> > entirely.
> >
> > > > > As far as I can see it, the effort you're putting into finding a
> > > > > different solution must mean you find something less than desirable
> > > > > about the solution I have offered.  But at this point, I don't
> > > > > understand why;
> > > >
> > > > Why would we parse the CC blob which is destined *solely* for a SEV- *guest*,
> > > > when booting the baremetal kernel which is *not* a guest?
> > > >
> > > > This is the solution I'm chasing - don't do something you're not supposed to
> > > > or needed to do.
> > >
> > > What you're saying suggests that, maybe, my patch #2 will not be
> > > necessary.  The CC blob will never be present except for in a guest.
> > > But can you do a kexec to a new kernel within that guest?  If so,
> > > patch #2 might still be necessary.
> > >
> > > Anyway, I think the references you're trying to eliminate when they're
> > > not needed are the references used to determine if the SEV feature is
> > > to be used in this specific boot iteration or not.
> > >
> >
> > It would be better if we did not have to rely on page fault handling
> > to map the EFI config table array this early. This is not strictly
> > related to SEV, but the CC blob happens to be the EFI config table
> > that is accessed before the page fault handler is installed.
> >
> > So regardless of how we fix any SEV-guest specific issues, we should
> > ensure that kexec infrastructure creates the mappings of the EFI
> > system table and the EFI config table array upfront.
>
> I think that's exactly what this patch series does.
>
> The mapping of the EFI system table is/was already present in
> map_efi_systab.  Patch #1 in this series adds the efi_config_table to
> what gets mapped.
>

Excellent. Please update the commit log to make it very clear that it
is the EFI config table *array* (the GUID/pointer tuple list) that is
being mapped, without any regard for the meaning of the individual
entries.

Also, the patch seems to be lacking your signed-off-by.

> Patch #2 adds the CC blob to the identity map as well, if present,
> since if present it is also dereferenced before the page fault handler
> can be put into place.  Given what's been discussed, this patch might
> not be necessary; I don't know enough to say whether kexec-ing a new
> kernel within a SEV guest makes sense.  I'm pretty certain it can
> cause no harm, though.
>

I'd prefer it if that is addressed within the context of the SEV guest
work. The memory setup is quite intricate, and dealing with individual
types of EFI config tables is something we should avoid in general. I
still maintain that the best approach would be to map all of DRAM 1:1
instead of mapping patches left and right (as this is what EFI does),
but if we need to do so, let's keep it as generic as we possibly can.

> And patch #3 fixes the UV platform problem as discussed, which will
> not cause the previous reported regression if patches #1 and #2 are
> already in place.
>

I wasn't cc'ed on any of the patches so I don't know exactly what was
discussed.

Please cc me and linux-efi@ on your next revision.

