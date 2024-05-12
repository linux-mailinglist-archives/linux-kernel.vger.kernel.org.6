Return-Path: <linux-kernel+bounces-176950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470888C37C4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486CD1C2095C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1C4D5A5;
	Sun, 12 May 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WgcqKrFz"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEE2AD18
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534773; cv=none; b=NpgIJF6smQ1BbqiJ0lPyVEPi5iJnhefr+qYh1GO3eajjKtS106i8A9/I+0Rpxq8A2rcBZatKW9ruUVZajss+eYfavLlaon2L7BY8BgPsC0iKxZrYUb1wxF4kUC3nckoN8DVL9w5J1at2oSDsqtn4ayE3qzbtlFTyd62IV+sMao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534773; c=relaxed/simple;
	bh=xNMBE1eDq2BkW9ZD3WrYcNezwvFQKpiPbbHlIyqJ+4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQHUitPBd5FeLN32zYJTPHJe4uYnRqeD/BQod1n+3tnXeYOkE5zhqLWt6Wjk5JpQLFkCkVjIs29X1X4RhD9yw2CEukEujBSJoC+RdweRGn2UjeZGAZH8Wb+c0/op7boyM/nwQGu31DTjjjdDjcYEuB1/wQVS2SMyj1hIwV2f3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WgcqKrFz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a8f0d941so854034466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 10:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715534769; x=1716139569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rp1j3tK1OJVirvDudGud0MNNZLke5KUalkhcuIeFIk=;
        b=WgcqKrFz/D8/nnIJGTQ+aBSAvBw2vQlYgDngvejtOcQDQw0D48zxd5idKU+o+GBVcH
         UP1LCcYqbRwu9BoCV4KZun6STWEVILZd8CHwq8roWV9XtwLgZaCQUrwa9JDYF4+QMdZe
         jWnImHbhxDLEUC/P/J/0XI5OoeDNEQyKfldToobB/L3JQ4BqME3qPDR0jSoRVx1O0D4w
         I1SFLB/T9iFtNB5jQV/9UVjGle3wPgL4XT14VghrIjLH9A/koWe69H9ly9Q6eyv7wS1u
         V2PxHqXEEZ0gpCLwYWYauiUx4X+FavbRybicvEul7joTaZ43aD50Q9/Us8+HvRaGAGVR
         jnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715534769; x=1716139569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rp1j3tK1OJVirvDudGud0MNNZLke5KUalkhcuIeFIk=;
        b=WABdmxkhULB6TvNKOzJPj5qvTwmg6JGTjHyFMI1INWLxA+8rketR++Hr9O0vwkH6O0
         1E8RJP5ZpdY/ootWw8GfcE9GELc4kLmT0JEEpZnCtK2X8/QhIUKE+FdEI6TXX+FmVzGk
         gDYSRnhJ4No/FbDVue5ekIwwDvY4O9pS/3mT4gK8IbYIe9sWTXT6nwCxtTEkd1Vhw9tN
         QjOiKSxLJ/lglGBfJpKCl8bxkqJzIR6X4pD3XJmCqRUTETetnBsVHquPRRqhc0ziDFCQ
         4q0xRgImEkw6MIrIC5mYDjt4HgVwee2dNaUSh5Q0y0cyzWYlVysAgR2Lvq4afeFkoB8p
         vAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXB/WC3CUhJUomwixqG9V8x636wsmDlSzG0vVJj0AL4xNEBieZmnJatS5BMnmmYVHk4qWOJL/pPNhUJysCulNuVXO1WhW7J4/nldyux
X-Gm-Message-State: AOJu0Ywf5p56HvLfAzOO4qGL11HUuXcZrCPom1zlKyuj1DsNEMyykrc7
	UL4WDEu14XJ3X8y0aoCCA8DrX4eSPOET+2IhPbZ5oetoGdqfsi19EqzHsMQv4cILWHn6eOlK18Y
	7U7i+HClNHIspJVjtXr9OxzrfBjsAZHO+BraI6g==
X-Google-Smtp-Source: AGHT+IGfyPbzeLrU5udFiEWzczMwwxKepDEGvfHppqzXC9YS60xa54DW1mYug80BN/LUVrhw2FhktXpJfB9RmgP7f3M=
X-Received: by 2002:a17:907:9405:b0:a5a:542d:ae0a with SMTP id
 a640c23a62f3a-a5a542daf06mr279619566b.63.1715534769414; Sun, 12 May 2024
 10:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508113419.18620-1-alexghiti@rivosinc.com> <6d37f914-d139-48ea-be63-c428ac767cc1@arm.com>
In-Reply-To: <6d37f914-d139-48ea-be63-c428ac767cc1@arm.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Sun, 12 May 2024 19:25:56 +0200
Message-ID: <CAHVXubhmihZA50pdaek4=fx83ycdOyuYkRmVLPtZk59uKBoWPw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/9] Merge arm64/riscv hugetlbfs contpte support
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Fri, May 10, 2024 at 3:49=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 08/05/2024 12:34, Alexandre Ghiti wrote:
> > This patchset intends to merge the contiguous ptes hugetlbfs implementa=
tion
> > of arm64 and riscv.
> >
> > Both arm64 and riscv support the use of contiguous ptes to map pages th=
at
> > are larger than the default page table size, respectively called contpt=
e
> > and svnapot.
> >
> > The riscv implementation differs from the arm64's in that the LSBs of t=
he
> > pfn of a svnapot pte are used to store the size of the mapping, allowin=
g
> > for future sizes to be added (for now only 64KB is supported). That's a=
n
> > issue for the core mm code which expects to find the *real* pfn a pte p=
oints
> > to. Patch 1 fixes that by always returning svnapot ptes with the real p=
fn
> > and restores the size of the mapping when it is written to a page table=
.
> >
> > The following patches are just merges of the 2 different implementation=
s
> > that currently exist in arm64 and riscv which are very similar. It pave=
s
> > the way to the reuse of the recent contpte THP work by Ryan [1] to avoi=
d
> > reimplementing the same in riscv.
>
> Hi Alexandre,
>
> I've skimmed through this series and the one that moves contpte. I can se=
e there
> is definitely value in sharing the implementation, and the rough shape of=
 things
> seems appropriate. I had some minor concerns about making it harder to im=
plement
> potential future arm64 errata workarounds but on reflection, most of the
> now-shared code is really just wrapping the primitives that are still arc=
h-specific.
>
> I'm going to need to spend proper time reviewing it to give detailed feed=
back,
> but I'll be out on paternity leave for 3 weeks from end of Monday at the =
latest.

Too bad, I expected to discuss that with you at LSF/MM...But congrats!
Hope your wife is fine :)

> So realistically I won't be able to do the detailed review until at least=
 the
> first week of June.
>
> Some high level thoughts:
>
>  - huge_ptep_* functions could be working on different sized huge ptes - =
arm64
> supports contpte, pmd, contpmd and pud. Is keeping them in contpte.c
> appropriate?

Hmm indeed, I'll see what I can do.

> Perhaps it's better to keep huge_pte and contpte separate? Also, it
> only works on arm64 because we can get away with calling the lower-level =
pte
> functions even when the huge_pte is actually a contpmd/pmd/pud, because t=
he
> format is the same. That might present challenges to other arches if the =
format
> is different?

Yes, but I think that if that happens, we could get away with it by
choosing the right function depending on the size of the mapping?

>
>  - It might be easier to review if the arm64 stuff is first moved (withou=
t
> changes) then modified to make it suitable for riscv, then for riscv to b=
e
> hooked up. At the moment I'm trying to follow all 3 parts per-function.

Ok, let me give it a try during your paternity leave!

>
> Thanks,
> Ryan

Thanks,

Alex

>
>
> >
> > This patchset was tested by running the libhugetlbfs testsuite with 64K=
B
> > and 2MB pages on both architectures (on a 4KB base page size arm64 kern=
el).
> >
> > [1] https://lore.kernel.org/linux-arm-kernel/20240215103205.2607016-1-r=
yan.roberts@arm.com/
> >
> > Changes in v2:
> >   - Rebase on top of 6.9-rc3
> >
> > Alexandre Ghiti (9):
> >   riscv: Restore the pfn in a NAPOT pte when manipulated by core mm cod=
e
> >   riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
> >   mm: Use common huge_ptep_get() function for riscv/arm64
> >   mm: Use common set_huge_pte_at() function for riscv/arm64
> >   mm: Use common huge_pte_clear() function for riscv/arm64
> >   mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
> >   mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
> >   mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
> >   mm: Use common huge_ptep_clear_flush() function for riscv/arm64
> >
> >  arch/arm64/Kconfig                  |   1 +
> >  arch/arm64/include/asm/pgtable.h    |  56 +++++-
> >  arch/arm64/mm/hugetlbpage.c         | 291 +---------------------------
> >  arch/riscv/Kconfig                  |   1 +
> >  arch/riscv/include/asm/hugetlb.h    |   2 +-
> >  arch/riscv/include/asm/pgtable-64.h |  11 ++
> >  arch/riscv/include/asm/pgtable.h    | 153 +++++++++++++--
> >  arch/riscv/mm/hugetlbpage.c         | 227 ----------------------
> >  arch/riscv/mm/pgtable.c             |   6 +-
> >  mm/Kconfig                          |   3 +
> >  mm/Makefile                         |   1 +
> >  mm/contpte.c                        | 272 ++++++++++++++++++++++++++
> >  12 files changed, 480 insertions(+), 544 deletions(-)
> >  create mode 100644 mm/contpte.c
> >
>

