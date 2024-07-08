Return-Path: <linux-kernel+bounces-244886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C890092AAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B40FB21B2D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5914E2E2;
	Mon,  8 Jul 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk05P5MP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C407748A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472742; cv=none; b=jvizlr9PX9JhzWPZAHz1Ib9rKCSKjD0SqGnqN+xrCcubTGYYdEN/o38LkuPgX4XjXybAjTpmMB/A5+BUaIlCs0iksOZZR2mOOdXXyIqJZcPEFx7izHpe2Tb7MdHoTcGETx1B7MiMj0E+Z6dHSJJFuNgxRByuJK/R0NSRJF8eJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472742; c=relaxed/simple;
	bh=IGaR7LGwpT/KAmYvhjkDDui+Uh4VSx3txyeL1hv+aqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR7PqBeZnimmHLhmgQ+PiwQuODYdig697SkTwV+dwxMwS8J8pch+2xIVd3NMwSN9R1LfbbIeThZiujoVWzwBZ37u43fCWEDURal7/zD0/Ktt7U0GZByRJPSnsgCzDy7oh2tJkiReON20Q7yxT0MavEVnEbAgi1ObGQCd099njuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk05P5MP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF5CC4AF12
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720472742;
	bh=IGaR7LGwpT/KAmYvhjkDDui+Uh4VSx3txyeL1hv+aqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dk05P5MPLi5vXXX0v5zzKqVo82j2lyrCaRhvKf4gRYDuDGVZIj5hlb0FqtecUNsxE
	 PAbqRbYnBkgI0UIwNbiL6XLBObX/dOIf7PLMh30aFP12TDkKGTCP71usBwhxW9FLv0
	 9hincewbRxvKBPWC5E32wTLdRndR/d2FN2GQbWGrG/aT31rdOTnn/qBd/KzDo9had6
	 aMOQfVcRDwPNK/+A5BExt5TY8vaX/JOQiZPOGV42gUwb5C8LkkYv/fX2to4yUXIg2B
	 6A0QAagpAE8ySI6DWoRr3MakNFENPRJ6nJLupPavD3MWQdjfJ06KDGJ4e0cOGK9jeM
	 ChvTuBMdlQMoQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so19252681fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:05:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXp8B/vas3yS/SKQtBH2n+V0ePTP6/GDFixYSxPfIe2Z7bq+X1t1tuADLx/aPIaIyeJX3fOJyt0jMj5IC/vV+SY3+xRR3jU+4AwfoP
X-Gm-Message-State: AOJu0YxYjs4hS6VQy5QOxUmNqNcEK8F/bKRsFYxfb5StG04Tx1doVg+I
	8wsy61JuI/LGOr3sBQ8w7nEAd26MANUXFwEZboIF4cW1XjPVPWferNLOCN/2rH+MC9qG/bLKnwC
	36sgwrawvqMVGBkf15EggcdZw2qs=
X-Google-Smtp-Source: AGHT+IFcnjNBj8+wlN//kVrwmERePruWzITvs8ibYwjh8M6YIz7A+y9FfNaXX+BYS3rt5R+R8dAjTvCmP3K6j2223GE=
X-Received: by 2002:a2e:8784:0:b0:2ec:4aac:8fd4 with SMTP id
 38308e7fff4ca-2eeb30b4cb1mr4854591fa.1.1720472740490; Mon, 08 Jul 2024
 14:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local> <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local> <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local> <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local> <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local> <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
In-Reply-To: <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 8 Jul 2024 23:05:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
Message-ID: <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
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

On Mon, 8 Jul 2024 at 22:41, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> On Mon, Jul 08, 2024 at 09:58:10PM +0200, Borislav Petkov wrote:
> > On Mon, Jul 08, 2024 at 02:29:05PM -0500, Steve Wahl wrote:
> > > Yes, this is about AMD machines which support SEV, running bare metal.
> > > ("Server" is in question, one of my testers is known to be using a
> > > laptop, so the facilities must be present in non-servers as well.)
> >
> > No, they can't be. SEV is supported only on server, not on client. This laptop
> > has a different problem it seems.
>
> Ahhh.  On the laptop, it's not looking *at* the CC blob that's the
> problem.
>
> Its looking *for* the CC blob in the EFI config table; the CC blob
> probably does not exist in that table on the laptop.  But the EFI
> config table needs to be identity mapped, to look through it and see
> that the CC blob is not there, and the EFI config table is not mapped.
>
> I think the existence of the CC blob in the EFI config table is being
> used, more or less, as a flag as to whether we need to do SEV related
> code.  Without mapping the EFI config table, we can't look for that
> blob.
>

We have run into this exact problem before - I don't have time to
check lore right now (it's 11pm here) but 'CC blob' and 'EFI config
table' are the keywords that may help you track down the thread.

So first of all, let's define some terminology:
- the EFI system table is the EFI root table that contains some magic
numbers and pointers to various other assets in memory, one of which
is:
- the EFI config table array, which is just a list of (GUID, pointer)
tuples, the length of which is recorded in the EFI system table
- an EFI config table is some asset elsewhere in memory that is
identified by its GUID.

The EFI config table array can grow and shrink at boot time, which is
why it is a separate allocation, as this allows it to be realloc()'ed.
This means any bootloader that intends to map the primary EFI table
should also map the EFI config table array, which may be elsewhere
entirely.

> > > As far as I can see it, the effort you're putting into finding a
> > > different solution must mean you find something less than desirable
> > > about the solution I have offered.  But at this point, I don't
> > > understand why;
> >
> > Why would we parse the CC blob which is destined *solely* for a SEV- *guest*,
> > when booting the baremetal kernel which is *not* a guest?
> >
> > This is the solution I'm chasing - don't do something you're not supposed to
> > or needed to do.
>
> What you're saying suggests that, maybe, my patch #2 will not be
> necessary.  The CC blob will never be present except for in a guest.
> But can you do a kexec to a new kernel within that guest?  If so,
> patch #2 might still be necessary.
>
> Anyway, I think the references you're trying to eliminate when they're
> not needed are the references used to determine if the SEV feature is
> to be used in this specific boot iteration or not.
>

It would be better if we did not have to rely on page fault handling
to map the EFI config table array this early. This is not strictly
related to SEV, but the CC blob happens to be the EFI config table
that is accessed before the page fault handler is installed.

So regardless of how we fix any SEV-guest specific issues, we should
ensure that kexec infrastructure creates the mappings of the EFI
system table and the EFI config table array upfront.

