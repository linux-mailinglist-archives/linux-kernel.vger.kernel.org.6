Return-Path: <linux-kernel+bounces-374487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657F9A6B00
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282612844DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E41F81BA;
	Mon, 21 Oct 2024 13:50:45 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FBE192D69
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518644; cv=none; b=eKnFRnXeCepjJMKyoy+huFpyC+M0TmW7RbqyXyU4NgVn0SsmaGKdtX1u8AS77na2fO3yEFI5HVlww4Ev3ltmTkwSQCHJCQ136Cj5yn65Rl+Gz0PvBJC8W2oSHStzg6nqaPTFJx3CVLP1h3s1d+axb/1wtshhJSM0kTr8vvhiji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518644; c=relaxed/simple;
	bh=CLYO1aAUS7URgDuYAhbQyeqSOkvWYCdEqcu59EKnV5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNnrmUkzVvW1fXpWp1i1ETAOFw0UV9fCroESmKI54iUZSeYz9orEvK56SRMBQVmqSRVrZP0GvKg7hAEo6ZWUpB/GmsNlBKDabV2H4Rb2r4knwcbg31HVchkfMwSzYaQ+oOd73ydrB8/v/QetlZzaYNBBj7MJG2BHb1pba0CTw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f629a7aaso809906366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518639; x=1730123439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4TZAugSycYJrzC0dWLDimXwGKVdGBYj+61rbtzXUs0=;
        b=RaWZPU44htV8lzl7nit2k2DuzsqqSoJsjHNRwO3VK7GPeI6uf4xS36oH5EveU6G3PM
         QA9N0Y00eD6HCJuiYIV5QM3BtzPMU2+K9uIFnhrZ01tahZ7oDuYFWm/ogsPAK5SfykCG
         he9YyviyXBHGF8IrtO2hV0Ku7Z7V9k0H518TaFI8z8jh4SvdF1KC95rlt1xJxpGFac52
         8bVmTR2KCIhjuZt+iClAE6h6tOOLjyFhWH/TzX+g6nWMDIM5mYmVf0ean/61I3yid8OB
         QDokYdonI1/S6/Q/T3jKcjnjMZ6siSr6apKY6W3Xhx/s1Dr+PYxwOz9oLJs3mH7ZOxBh
         JEEg==
X-Forwarded-Encrypted: i=1; AJvYcCVCQ7DvblSi7pamnYWr4rBMcNOFpCgl0vg2O5y/UmnJSfbBJ1PpmHWJW/uApUXOwY4Ub54OBEY4xIy536U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCP7JiVjXZzWo+ggjKirxWS5qZVTqpek5JIyr/fmDu8d1Btv+
	jAA87amLVweU296y0kLzKlgcVs/lmc2FgMy8p5O6k4GcJ/1BKiB3r5XoXbZcF30=
X-Google-Smtp-Source: AGHT+IHLa0jez7/uqlfyYnU5hOC1zz7B8eax0mg6HUgZeNyYsbSaSlTy9iiCeK4w2ShnIP59keF69g==
X-Received: by 2002:a17:907:944b:b0:a9a:1617:e860 with SMTP id a640c23a62f3a-a9a4cc3ac81mr1613411166b.22.1729518638181;
        Mon, 21 Oct 2024 06:50:38 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91559a1csm206746766b.125.2024.10.21.06.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 06:50:37 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1026839166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnvDPQMjVzmeGDN8fGelXS6BP30NWmdwj5igf0r4+gNDOtxV8oB6hxlZATzHopnMpkvMSAaBfAPMEMyLo=@vger.kernel.org
X-Received: by 2002:a17:907:720a:b0:a9a:3c94:23c4 with SMTP id
 a640c23a62f3a-a9a6a569d3amr1407518466b.22.1729518637269; Mon, 21 Oct 2024
 06:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <4623805.lGaqSPkdTl@skuld-framework> <09e480d7-3ef6-4352-a484-91733ad7d231@arm.com>
 <CAOgh=FwEv3LjA7bfcOvWK7kZEcKRyLpQmTqWn5WDsSsYwGqu+A@mail.gmail.com> <649d7aa6-4163-4969-ba14-777f0e9cddb1@arm.com>
In-Reply-To: <649d7aa6-4163-4969-ba14-777f0e9cddb1@arm.com>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 21 Oct 2024 09:49:59 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9phqMqXCVAEjtXKadKGUmZcuSnFLDn=7C4+MaUu9KpYw@mail.gmail.com>
Message-ID: <CAEg-Je9phqMqXCVAEjtXKadKGUmZcuSnFLDn=7C4+MaUu9KpYw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Eric Curtin <ecurtin@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>, 
	Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>, 
	Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 7:51=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 21/10/2024 12:32, Eric Curtin wrote:
> > On Mon, 21 Oct 2024 at 12:09, Ryan Roberts <ryan.roberts@arm.com> wrote=
:
> >>
> >> On 19/10/2024 16:47, Neal Gompa wrote:
> >>> On Monday, October 14, 2024 6:55:11=E2=80=AFAM EDT Ryan Roberts wrote=
:
> >>>> Hi All,
> >>>>
> >>>> Patch bomb incoming... This covers many subsystems, so I've included=
 a core
> >>>> set of people on the full series and additionally included maintaine=
rs on
> >>>> relevant patches. I haven't included those maintainers on this cover=
 letter
> >>>> since the numbers were far too big for it to work. But I've included=
 a link
> >>>> to this cover letter on each patch, so they can hopefully find their=
 way
> >>>> here. For follow up submissions I'll break it up by subsystem, but f=
or now
> >>>> thought it was important to show the full picture.
> >>>>
> >>>> This RFC series implements support for boot-time page size selection=
 within
> >>>> the arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), b=
ut to
> >>>> date, page size has been selected at compile-time, meaning the size =
is
> >>>> baked into a given kernel image. As use of larger-than-4K page sizes=
 become
> >>>> more prevalent this starts to present a problem for distributions.
> >>>> Boot-time page size selection enables the creation of a single kerne=
l
> >>>> image, which can be told which page size to use on the kernel comman=
d line.
> >>>>
> >>>> Why is having an image-per-page size problematic?
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>>>
> >>>> Many traditional distros are now supporting both 4K and 64K. And thi=
s means
> >>>> managing 2 kernel packages, along with drivers for each. For some, i=
t means
> >>>> multiple installer flavours and multiple ISOs. All of this adds up t=
o a
> >>>> less-than-ideal level of complexity. Additionally, Android now suppo=
rts 4K
> >>>> and 16K kernels. I'm told having to explicitly manage their KABI for=
 each
> >>>> kernel is painful, and the extra flash space required for both kerne=
l
> >>>> images and the duplicated modules has been problematic. Boot-time pa=
ge size
> >>>> selection solves all of this.
> >>>>
> >>>> Additionally, in starting to think about the longer term deployment =
story
> >>>> for D128 page tables, which Arm architecture now supports, a lot of =
the
> >>>> same problems need to be solved, so this work sets us up nicely for =
that.
> >>>>
> >>>> So what's the down side?
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >>>>
> >>>> Well nothing's free; Various static allocations in the kernel image =
must be
> >>>> sized for the worst case (largest supported page size), so image siz=
e is in
> >>>> line with size of 64K compile-time image. So if you're interested in=
 4K or
> >>>> 16K, there is a slight increase to the image size. But I expect that
> >>>> problem goes away if you're compressing the image - its just some ex=
tra
> >>>> zeros. At boot-time, I expect we could free the unused static storag=
e once
> >>>> we know the page size - although that would be a follow up enhanceme=
nt.
> >>>>
> >>>> And then there is performance. Since PAGE_SIZE and friends are no lo=
nger
> >>>> compile-time constants, we must look up their values and do arithmet=
ic at
> >>>> runtime instead of compile-time. My early perf testing suggests this=
 is
> >>>> inperceptible for real-world workloads, and only has small impact on
> >>>> microbenchmarks - more on this below.
> >>>>
> >>>> Approach
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> The basic idea is to rid the source of any assumptions that PAGE_SIZ=
E and
> >>>> friends are compile-time constant, but in a way that allows the comp=
iler to
> >>>> perform the same optimizations as was previously being done if they =
do turn
> >>>> out to be compile-time constant. Where constants are required, we us=
e
> >>>> limits; PAGE_SIZE_MIN and PAGE_SIZE_MAX. See commit log in patch 1 f=
or full
> >>>> description of all the classes of problems to solve.
> >>>>
> >>>> By default PAGE_SIZE_MIN=3DPAGE_SIZE_MAX=3DPAGE_SIZE. But an arch ma=
y opt-in to
> >>>> boot-time page size selection by defining PAGE_SIZE_MIN & PAGE_SIZE_=
MAX.
> >>>> arm64 does this if the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_=
SIZE
> >>>> Kconfig, which is an alternative to selecting a compile-time page si=
ze.
> >>>>
> >>>> When boot-time page size is active, the arch pgtable geometry macro
> >>>> definitions resolve to something that can be configured at boot. The=
 arm64
> >>>> implementation in this series mainly uses global, __ro_after_init
> >>>> variables. I've tried using alternatives patching, but that performs=
 worse
> >>>> than loading from memory; I think due to code size bloat.
> >>>>
> >>>> Status
> >>>> =3D=3D=3D=3D=3D=3D
> >>>>
> >>>> When CONFIG_ARM64_BOOT_TIME_PAGE_SIZE is selected, I've only impleme=
nted
> >>>> enough to compile the kernel image itself with defconfig (and a few =
other
> >>>> bits and pieces). This is enough to build a kernel that can boot und=
er QEMU
> >>>> or FVP. I'll happily do the rest of the work to enable all the extra
> >>>> drivers, but wanted to get feedback on the shape of this effort firs=
t. If
> >>>> anyone wants to do any testing, and has a must-have config, let me k=
now and
> >>>> I'll prioritize enabling it first.
> >>>>
> >>>> The series is arranged as follows:
> >>>>
> >>>>   - patch 1:    Add macros required for converting non-arch code to =
support
> >>>>                 boot-time page size selection
> >>>>   - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption=
 from
> >>>> all non-arch code
> >>>>   - patches 37-38: Some arm64 tidy ups
> >>>>   - patch 39:           Add macros required for converting arm64 cod=
e to
> >>> support
> >>>>                 boot-time page size selection
> >>>>   - patches 40-56: arm64 changes to support boot-time page size sele=
ction
> >>>>   - patch 57:           Add arm64 Kconfig option to enable boot-time=
 page
> >>> size
> >>>>                 selection
> >>>>
> >>>> Ideally, I'd like to get the basics merged (something like this seri=
es),
> >>>> then incrementally improve it over a handful of kernel releases unti=
l we
> >>>> can demonstrate that we have feature parity with the compile-time bu=
ild and
> >>>> no performance blockers. Once at that point, ideally the compile-tim=
e build
> >>>> options would be removed and the code could be cleaned up further.
> >>>>
> >>>> One of the bigger peices that I'd propose to add as a follow up, is =
to make
> >>>> va-size boot-time selectable too. That will greatly simplify LPA2 fa=
llback
> >>>> handling.
> >>>>
> >>>> Assuming people are ammenable to the rough shape, how would I go abo=
ut
> >>>> getting the non-arch changes merged? Since they cover many subsystem=
s, will
> >>>> each piece need to go independently to each relevant maintainer or c=
ould it
> >>>> all be merged together through the arm64 tree?
> >>>>
> >>>> Image Size
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> The below shows the size of a defconfig (+ xfs, squashfs, ftrace, kp=
robes)
> >>>> kernel image on disk for base (before any changes applied), compile =
(with
> >>>> changes, configured for compile-time page size) and boot (with chang=
es,
> >>>> configured for boot-time page size).
> >>>>
> >>>> You can see the that compile-16k and 64k configs are actually slight=
ly
> >>>> smaller than the baselines; that's due to optimizing some buffer siz=
es
> >>>> which didn't need to depend on page size during the series. The boot=
-time
> >>>> image is ~1% bigger than the 64k compile-time image. I believe there=
 is
> >>>> scope to improve this to make it
> >>>> equal to compile-64k if required:
> >>>> | config      | size/KB | diff/KB |  diff/% |
> >>>> |
> >>>> |-------------|---------|---------|---------|
> >>>> |
> >>>> | base-4k     |   54895 |       0 |    0.0% |
> >>>> | base-16k    |   55161 |     266 |    0.5% |
> >>>> | base-64k    |   56775 |    1880 |    3.4% |
> >>>> | compile-4k  |   54895 |       0 |    0.0% |
> >>>> | compile-16k |   55097 |     202 |    0.4% |
> >>>> | compile-64k |   56391 |    1496 |    2.7% |
> >>>> | boot-4K     |   57045 |    2150 |    3.9% |
> >>>>
> >>>> And below shows the size of the image in memory at run-time, separat=
ed for
> >>>> text and data costs. The boot image has ~1% text cost; most likely d=
ue to
> >>>> the fact that PAGE_SIZE and friends are not compile-time constants s=
o need
> >>>> instructions to load the values and do arithmetic. I believe we coul=
d
> >>>> eventually get the data cost to match the cost for the compile image=
 for
> >>>> the chosen page size by freeing
> >>>> the ends of the static buffers not needed for the selected page size=
:
> >>>> |             |    text |    text |    text |    data |    data |   =
 data |
> >>>> |
> >>>> | config      | size/KB | diff/KB |  diff/% | size/KB | diff/KB |  d=
iff/% |
> >>>> |
> >>>> |-------------|---------|---------|---------|---------|---------|---=
------|
> >>>> |
> >>>> | base-4k     |   20561 |       0 |    0.0% |   14314 |       0 |   =
 0.0% |
> >>>> | base-16k    |   20439 |    -122 |   -0.6% |   14625 |     311 |   =
 2.2% |
> >>>> | base-64k    |   20435 |    -126 |   -0.6% |   15673 |    1359 |   =
 9.5% |
> >>>> | compile-4k  |   20565 |       4 |    0.0% |   14315 |       1 |   =
 0.0% |
> >>>> | compile-16k |   20443 |    -118 |   -0.6% |   14517 |     204 |   =
 1.4% |
> >>>> | compile-64k |   20439 |    -122 |   -0.6% |   15134 |     820 |   =
 5.7% |
> >>>> | boot-4K     |   20811 |     250 |    1.2% |   15287 |     973 |   =
 6.8% |
> >>>>
> >>>> Functional Testing
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> I've build-tested defconfig for all arches supported by tuxmake (whi=
ch is
> >>>> most) without issue.
> >>>>
> >>>> I've boot-tested arm64 with CONFIG_ARM64_BOOT_TIME_PAGE_SIZE for all=
 page
> >>>> sizes and a few va-sizes, and additionally have run all the mm-selft=
ests,
> >>>> with no regressions observed vs the equivalent compile-time page siz=
e build
> >>>> (although the mm-selftests have a few existing failures when run aga=
inst
> >>>> 16K and 64K kernels - those should really be investigated and fixed
> >>>> independently).
> >>>>
> >>>> Test coverage is lacking for many of the drivers that I've touched, =
but in
> >>>> many cases, I'm hoping the changes are simple enough that review mig=
ht
> >>>> suffice?
> >>>>
> >>>> Performance Testing
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>
> >>>> I've run some limited performance benchmarks:
> >>>>
> >>>> First, a real-world benchmark that causes a lot of page table manipu=
lation
> >>>> (and therefore we would expect to see regression here if we are goin=
g to
> >>>> see it anywhere); kernel compilation. It barely registers a change. =
Values
> >>>> are times,
> >>>> so smaller is better. All relative to base-4k:
> >>>> |             |    kern |    kern |    user |    user |    real |   =
 real |
> >>>> |
> >>>> | config      |    mean |   stdev |    mean |   stdev |    mean |   =
stdev |
> >>>> |
> >>>> |-------------|---------|---------|---------|---------|---------|---=
------|
> >>>> |
> >>>> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |   =
 0.3% |
> >>>> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |   =
 0.3% |
> >>>> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |   =
 0.2% |
> >>>>
> >>>> The Speedometer JavaScript benchmark also shows no change. Values ar=
e runs
> >>>> per
> >>>> min, so bigger is better. All relative to base-4k:
> >>>> | config      |    mean |   stdev |
> >>>> |
> >>>> |-------------|---------|---------|
> >>>> |
> >>>> | base-4k     |    0.0% |    0.8% |
> >>>> | compile-4k  |    0.4% |    0.8% |
> >>>> | boot-4k     |    0.0% |    0.9% |
> >>>>
> >>>> Finally, I've run some microbenchmarks known to stress page table
> >>>> manipulations (originally from David Hildenbrand). The fork test
> >>>> maps/allocs 1G of anon memory, then measures the cost of fork(). The=
 munmap
> >>>> test maps/allocs 1G of anon memory then measures the cost of munmap(=
)ing
> >>>> it. The fork test is known to be extremely sensitive to any changes =
that
> >>>> cause instructions to be aligned differently in cachelines. When usi=
ng this
> >>>> test for other changes, I've seen double digit regressions for the
> >>>> slightest thing, so 12% regression on this test is actually fairly g=
ood.
> >>>> This likely represents the extreme worst case for regressions that w=
ill be
> >>>> observed across other microbenchmarks (famous last
> >>>> words). Values are times, so smaller is better. All relative to base=
-4k:
> >>>> |             |    fork |    fork |  munmap |  munmap |
> >>>> |
> >>>> | config      |    mean |   stdev |   stdev |   stdev |
> >>>> |
> >>>> |-------------|---------|---------|---------|---------|
> >>>> |
> >>>> | base-4k     |    0.0% |    1.3% |    0.0% |    0.3% |
> >>>> | compile-4k  |    0.1% |    1.3% |   -0.9% |    0.1% |
> >>>> | boot-4k     |   12.8% |    1.2% |    3.8% |    1.0% |
> >>>>
> >>>> NOTE: The series applies on top of v6.11.
> >>>>
> >>>> Thanks,
> >>>> Ryan
> >>>>
> >>>>
> >>>> Ryan Roberts (57):
> >>>>   mm: Add macros ahead of supporting boot-time page size selection
> >>>>   vmlinux: Align to PAGE_SIZE_MAX
> >>>>   mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is l=
arge
> >>>>   mm/page_alloc: Make page_frag_cache boot-time page size compatible
> >>>>   mm: Avoid split pmd ptl if pmd level is run-time folded
> >>>>   mm: Remove PAGE_SIZE compile-time constant assumption
> >>>>   fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
> >>>>   fs: Remove PAGE_SIZE compile-time constant assumption
> >>>>   fs/nfs: Remove PAGE_SIZE compile-time constant assumption
> >>>>   fs/ext4: Remove PAGE_SIZE compile-time constant assumption
> >>>>   fork: Permit boot-time THREAD_SIZE determination
> >>>>   cgroup: Remove PAGE_SIZE compile-time constant assumption
> >>>>   bpf: Remove PAGE_SIZE compile-time constant assumption
> >>>>   pm/hibernate: Remove PAGE_SIZE compile-time constant assumption
> >>>>   stackdepot: Remove PAGE_SIZE compile-time constant assumption
> >>>>   perf: Remove PAGE_SIZE compile-time constant assumption
> >>>>   kvm: Remove PAGE_SIZE compile-time constant assumption
> >>>>   trace: Remove PAGE_SIZE compile-time constant assumption
> >>>>   crash: Remove PAGE_SIZE compile-time constant assumption
> >>>>   crypto: Remove PAGE_SIZE compile-time constant assumption
> >>>>   sunrpc: Remove PAGE_SIZE compile-time constant assumption
> >>>>   sound: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: fec: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: marvell: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: hns3: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: e1000: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: igbvf: Remove PAGE_SIZE compile-time constant assumption
> >>>>   net: igb: Remove PAGE_SIZE compile-time constant assumption
> >>>>   drivers/base: Remove PAGE_SIZE compile-time constant assumption
> >>>>   edac: Remove PAGE_SIZE compile-time constant assumption
> >>>>   optee: Remove PAGE_SIZE compile-time constant assumption
> >>>>   random: Remove PAGE_SIZE compile-time constant assumption
> >>>>   sata_sil24: Remove PAGE_SIZE compile-time constant assumption
> >>>>   virtio: Remove PAGE_SIZE compile-time constant assumption
> >>>>   xen: Remove PAGE_SIZE compile-time constant assumption
> >>>>   arm64: Fix macros to work in C code in addition to the linker scri=
pt
> >>>>   arm64: Track early pgtable allocation limit
> >>>>   arm64: Introduce macros required for boot-time page selection
> >>>>   arm64: Refactor early pgtable size calculation macros
> >>>>   arm64: Pass desired page size on command line
> >>>>   arm64: Divorce early init from PAGE_SIZE
> >>>>   arm64: Clean up simple cases of CONFIG_ARM64_*K_PAGES
> >>>>   arm64: Align sections to PAGE_SIZE_MAX
> >>>>   arm64: Rework trampoline rodata mapping
> >>>>   arm64: Generalize fixmap for boot-time page size
> >>>>   arm64: Statically allocate and align for worst-case page size
> >>>>   arm64: Convert switch to if for non-const comparison values
> >>>>   arm64: Convert BUILD_BUG_ON to VM_BUG_ON
> >>>>   arm64: Remove PAGE_SZ asm-offset
> >>>>   arm64: Introduce cpu features for page sizes
> >>>>   arm64: Remove PAGE_SIZE from assembly code
> >>>>   arm64: Runtime-fold pmd level
> >>>>   arm64: Support runtime folding in idmap_kpti_install_ng_mappings
> >>>>   arm64: TRAMP_VALIAS is no longer compile-time constant
> >>>>   arm64: Determine THREAD_SIZE at boot-time
> >>>>   arm64: Enable boot-time page size selection
> >>>>
> >>>>  arch/alpha/include/asm/page.h                 |   1 +
> >>>>  arch/arc/include/asm/page.h                   |   1 +
> >>>>  arch/arm/include/asm/page.h                   |   1 +
> >>>>  arch/arm64/Kconfig                            |  26 ++-
> >>>>  arch/arm64/include/asm/assembler.h            |  78 ++++++-
> >>>>  arch/arm64/include/asm/cpufeature.h           |  44 +++-
> >>>>  arch/arm64/include/asm/efi.h                  |   2 +-
> >>>>  arch/arm64/include/asm/fixmap.h               |  28 ++-
> >>>>  arch/arm64/include/asm/kernel-pgtable.h       | 150 +++++++++----
> >>>>  arch/arm64/include/asm/kvm_arm.h              |  21 +-
> >>>>  arch/arm64/include/asm/kvm_hyp.h              |  11 +
> >>>>  arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
> >>>>  arch/arm64/include/asm/memory.h               |  62 ++++--
> >>>>  arch/arm64/include/asm/page-def.h             |   3 +-
> >>>>  arch/arm64/include/asm/pgalloc.h              |  16 +-
> >>>>  arch/arm64/include/asm/pgtable-geometry.h     |  46 ++++
> >>>>  arch/arm64/include/asm/pgtable-hwdef.h        |  28 ++-
> >>>>  arch/arm64/include/asm/pgtable-prot.h         |   2 +-
> >>>>  arch/arm64/include/asm/pgtable.h              | 133 +++++++++---
> >>>>  arch/arm64/include/asm/processor.h            |  10 +-
> >>>>  arch/arm64/include/asm/sections.h             |   1 +
> >>>>  arch/arm64/include/asm/smp.h                  |   1 +
> >>>>  arch/arm64/include/asm/sparsemem.h            |  15 +-
> >>>>  arch/arm64/include/asm/sysreg.h               |  54 +++--
> >>>>  arch/arm64/include/asm/tlb.h                  |   3 +
> >>>>  arch/arm64/kernel/asm-offsets.c               |   4 +-
> >>>>  arch/arm64/kernel/cpufeature.c                |  93 ++++++--
> >>>>  arch/arm64/kernel/efi.c                       |   2 +-
> >>>>  arch/arm64/kernel/entry.S                     |  60 +++++-
> >>>>  arch/arm64/kernel/head.S                      |  46 +++-
> >>>>  arch/arm64/kernel/hibernate-asm.S             |   6 +-
> >>>>  arch/arm64/kernel/image-vars.h                |  14 ++
> >>>>  arch/arm64/kernel/image.h                     |   4 +
> >>>>  arch/arm64/kernel/pi/idreg-override.c         |  68 +++++-
> >>>>  arch/arm64/kernel/pi/map_kernel.c             | 165 ++++++++++----
> >>>>  arch/arm64/kernel/pi/map_range.c              | 201 +++++++++++++++=
+--
> >>>>  arch/arm64/kernel/pi/pi.h                     |  63 +++++-
> >>>>  arch/arm64/kernel/relocate_kernel.S           |  10 +-
> >>>>  arch/arm64/kernel/vdso-wrap.S                 |   4 +-
> >>>>  arch/arm64/kernel/vdso.c                      |   7 +-
> >>>>  arch/arm64/kernel/vdso/vdso.lds.S             |   4 +-
> >>>>  arch/arm64/kernel/vdso32-wrap.S               |   4 +-
> >>>>  arch/arm64/kernel/vdso32/vdso.lds.S           |   4 +-
> >>>>  arch/arm64/kernel/vmlinux.lds.S               |  48 +++--
> >>>>  arch/arm64/kvm/arm.c                          |  10 +
> >>>>  arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
> >>>>  arch/arm64/kvm/hyp/nvhe/host.S                |  10 +-
> >>>>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +-
> >>>>  arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c    |  16 ++
> >>>>  arch/arm64/kvm/mmu.c                          |  39 ++--
> >>>>  arch/arm64/lib/clear_page.S                   |   7 +-
> >>>>  arch/arm64/lib/copy_page.S                    |  33 ++-
> >>>>  arch/arm64/lib/mte.S                          |  27 ++-
> >>>>  arch/arm64/mm/Makefile                        |   1 +
> >>>>  arch/arm64/mm/fixmap.c                        |  38 ++--
> >>>>  arch/arm64/mm/hugetlbpage.c                   |  40 +---
> >>>>  arch/arm64/mm/init.c                          |  26 +--
> >>>>  arch/arm64/mm/kasan_init.c                    |   8 +-
> >>>>  arch/arm64/mm/mmu.c                           |  53 +++--
> >>>>  arch/arm64/mm/pgd.c                           |  12 +-
> >>>>  arch/arm64/mm/pgtable-geometry.c              |  24 +++
> >>>>  arch/arm64/mm/proc.S                          | 128 ++++++++---
> >>>>  arch/arm64/mm/ptdump.c                        |   3 +-
> >>>>  arch/arm64/tools/cpucaps                      |   3 +
> >>>>  arch/csky/include/asm/page.h                  |   3 +
> >>>>  arch/hexagon/include/asm/page.h               |   2 +
> >>>>  arch/loongarch/include/asm/page.h             |   2 +
> >>>>  arch/m68k/include/asm/page.h                  |   1 +
> >>>>  arch/microblaze/include/asm/page.h            |   1 +
> >>>>  arch/mips/include/asm/page.h                  |   1 +
> >>>>  arch/nios2/include/asm/page.h                 |   2 +
> >>>>  arch/openrisc/include/asm/page.h              |   1 +
> >>>>  arch/parisc/include/asm/page.h                |   1 +
> >>>>  arch/powerpc/include/asm/page.h               |   2 +
> >>>>  arch/riscv/include/asm/page.h                 |   1 +
> >>>>  arch/s390/include/asm/page.h                  |   1 +
> >>>>  arch/sh/include/asm/page.h                    |   1 +
> >>>>  arch/sparc/include/asm/page.h                 |   3 +
> >>>>  arch/um/include/asm/page.h                    |   2 +
> >>>>  arch/x86/include/asm/page_types.h             |   2 +
> >>>>  arch/xtensa/include/asm/page.h                |   1 +
> >>>>  crypto/lskcipher.c                            |   4 +-
> >>>>  drivers/ata/sata_sil24.c                      |  46 ++--
> >>>>  drivers/base/node.c                           |   6 +-
> >>>>  drivers/base/topology.c                       |  32 +--
> >>>>  drivers/block/virtio_blk.c                    |   2 +-
> >>>>  drivers/char/random.c                         |   4 +-
> >>>>  drivers/edac/edac_mc.h                        |  13 +-
> >>>>  drivers/firmware/efi/libstub/arm64.c          |   3 +-
> >>>>  drivers/irqchip/irq-gic-v3-its.c              |   2 +-
> >>>>  drivers/mtd/mtdswap.c                         |   4 +-
> >>>>  drivers/net/ethernet/freescale/fec.h          |   3 +-
> >>>>  drivers/net/ethernet/freescale/fec_main.c     |   5 +-
> >>>>  .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +-
> >>>>  drivers/net/ethernet/intel/e1000/e1000_main.c |   6 +-
> >>>>  drivers/net/ethernet/intel/igb/igb.h          |  25 +--
> >>>>  drivers/net/ethernet/intel/igb/igb_main.c     | 149 +++++++------
> >>>>  drivers/net/ethernet/intel/igbvf/netdev.c     |   6 +-
> >>>>  drivers/net/ethernet/marvell/mvneta.c         |   9 +-
> >>>>  drivers/net/ethernet/marvell/sky2.h           |   2 +-
> >>>>  drivers/tee/optee/call.c                      |   7 +-
> >>>>  drivers/tee/optee/smc_abi.c                   |   2 +-
> >>>>  drivers/virtio/virtio_balloon.c               |  10 +-
> >>>>  drivers/xen/balloon.c                         |  11 +-
> >>>>  drivers/xen/biomerge.c                        |  12 +-
> >>>>  drivers/xen/privcmd.c                         |   2 +-
> >>>>  drivers/xen/xenbus/xenbus_client.c            |   5 +-
> >>>>  drivers/xen/xlate_mmu.c                       |   6 +-
> >>>>  fs/binfmt_elf.c                               |  11 +-
> >>>>  fs/buffer.c                                   |   2 +-
> >>>>  fs/coredump.c                                 |   8 +-
> >>>>  fs/ext4/ext4.h                                |  36 ++--
> >>>>  fs/ext4/move_extent.c                         |   2 +-
> >>>>  fs/ext4/readpage.c                            |   2 +-
> >>>>  fs/fat/dir.c                                  |   4 +-
> >>>>  fs/fat/fatent.c                               |   4 +-
> >>>>  fs/nfs/nfs42proc.c                            |   2 +-
> >>>>  fs/nfs/nfs42xattr.c                           |   2 +-
> >>>>  fs/nfs/nfs4proc.c                             |   2 +-
> >>>>  include/asm-generic/pgtable-geometry.h        |  71 +++++++
> >>>>  include/asm-generic/vmlinux.lds.h             |  38 ++--
> >>>>  include/linux/buffer_head.h                   |   1 +
> >>>>  include/linux/cpumask.h                       |   5 +
> >>>>  include/linux/linkage.h                       |   4 +-
> >>>>  include/linux/mm.h                            |  17 +-
> >>>>  include/linux/mm_types.h                      |  15 +-
> >>>>  include/linux/mm_types_task.h                 |   2 +-
> >>>>  include/linux/mmzone.h                        |   3 +-
> >>>>  include/linux/netlink.h                       |   6 +-
> >>>>  include/linux/percpu-defs.h                   |   4 +-
> >>>>  include/linux/perf_event.h                    |   2 +-
> >>>>  include/linux/sched.h                         |   4 +-
> >>>>  include/linux/slab.h                          |   7 +-
> >>>>  include/linux/stackdepot.h                    |   6 +-
> >>>>  include/linux/sunrpc/svc.h                    |   8 +-
> >>>>  include/linux/sunrpc/svc_rdma.h               |   4 +-
> >>>>  include/linux/sunrpc/svcsock.h                |   2 +-
> >>>>  include/linux/swap.h                          |  17 +-
> >>>>  include/linux/swapops.h                       |   6 +-
> >>>>  include/linux/thread_info.h                   |  10 +-
> >>>>  include/xen/page.h                            |   2 +
> >>>>  init/main.c                                   |   7 +-
> >>>>  kernel/bpf/core.c                             |   9 +-
> >>>>  kernel/bpf/ringbuf.c                          |  54 ++---
> >>>>  kernel/cgroup/cgroup.c                        |   8 +-
> >>>>  kernel/crash_core.c                           |   2 +-
> >>>>  kernel/events/core.c                          |   2 +-
> >>>>  kernel/fork.c                                 |  71 +++----
> >>>>  kernel/power/power.h                          |   2 +-
> >>>>  kernel/power/snapshot.c                       |   2 +-
> >>>>  kernel/power/swap.c                           | 129 +++++++++--
> >>>>  kernel/trace/fgraph.c                         |   2 +-
> >>>>  kernel/trace/trace.c                          |   2 +-
> >>>>  lib/stackdepot.c                              |   6 +-
> >>>>  mm/kasan/report.c                             |   3 +-
> >>>>  mm/memcontrol.c                               |  11 +-
> >>>>  mm/memory.c                                   |   4 +-
> >>>>  mm/mmap.c                                     |   2 +-
> >>>>  mm/page-writeback.c                           |   2 +-
> >>>>  mm/page_alloc.c                               |  31 +--
> >>>>  mm/slub.c                                     |   2 +-
> >>>>  mm/sparse.c                                   |   2 +-
> >>>>  mm/swapfile.c                                 |   2 +-
> >>>>  mm/vmalloc.c                                  |   7 +-
> >>>>  net/9p/trans_virtio.c                         |   4 +-
> >>>>  net/core/hotdata.c                            |   4 +-
> >>>>  net/core/skbuff.c                             |   4 +-
> >>>>  net/core/sysctl_net_core.c                    |   2 +-
> >>>>  net/sunrpc/cache.c                            |   3 +-
> >>>>  net/unix/af_unix.c                            |   2 +-
> >>>>  sound/soc/soc-utils.c                         |   4 +-
> >>>>  virt/kvm/kvm_main.c                           |   2 +-
> >>>>  172 files changed, 2185 insertions(+), 951 deletions(-)
> >>>>  create mode 100644 arch/arm64/include/asm/pgtable-geometry.h
> >>>>  create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
> >>>>  create mode 100644 arch/arm64/mm/pgtable-geometry.c
> >>>>  create mode 100644 include/asm-generic/pgtable-geometry.h
> >>>>
> >>>> --
> >>>> 2.43.0
> >>>
> >>> This is a generally very exciting patch set! I'm looking forward to s=
eeing it
> >>> land so I can take advantage of it for Fedora ARM and Fedora Asahi Re=
mix.
> >>>
> >>> That said, I have a couple of questions:
> >>>
> >>> * Going forward, how would we handle drivers/modules that require a p=
articular
> >>> page size? For example, the Apple Silicon IOMMU driver code requires =
the
> >>> kernel to operate in 16k page size mode, and it would need to be disa=
bled in
> >>> other page sizes.
> >>
> >> I think these drivers would want to check PAGE_SIZE at probe time and =
fail if an
> >> unsupported page size is in use. Do you see any issue with that?
> >>
> >>>
> >>> * How would we handle an invalid selection at boot?
> >>
> >> What do you mean by invalid here? The current policy validates that th=
e
> >> requested page size is supported by the HW by checking mmfr0. If no pa=
ge size is
> >> passed on the command line, or the passed value is not supported by th=
e HW, then
> >> the we default to the largest page size supported by the HW (so for Ap=
ple
> >> Silicon that would be 16k since the HW doesn't support 64k). Although =
I think it
> >> may be better to change that policy to use the smallest page size in t=
his case;
> >> 4k is the safer bet for compat and will waste much less memory than 64=
k.
> >>
> >>> Can we program in a
> >>> fallback when the "wrong" mode is selected for a chip or something si=
milar?
> >>
> >> Do you mean effectively add a machanism to force 16k if the detected H=
W is Apple
> >> Silicon? The trouble is that we need to select the page size, very ear=
ly in
> >> boot, before start_kernel() is called, so we really only have generic =
arch code
> >> and the command line with which to make the decision.
> >
> > Yes... I think a build-time CONFIG for default page size, which can be
> > overridden by a karg makes sense... Even on platforms like Apple
> > Silicon you may want to test very specific things in 4k by overriding
> > with a karg.
>
> Ahh, yes, that would certainly work. I'll work it into the next version.
>

Could we maybe extend to have some kind of way to include a table of
SoC IDs that certain modes are disabled (e.g. 64k on Apple Silicon)
and preferred modes when no arg is set (16k for Apple Silicon)? That
way it'd work something like this:

1. Table identification of 4/16/64 depending on identified SoC
2. Unidentified ones follow build-time default
3. karg forces a mode regardless


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

