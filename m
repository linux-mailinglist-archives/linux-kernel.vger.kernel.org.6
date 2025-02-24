Return-Path: <linux-kernel+bounces-528904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E8A41DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B0A17B496
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629FF25D531;
	Mon, 24 Feb 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="smvSQqpT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA70A264A9E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396441; cv=none; b=sp87K9TYfBBwb1HqJ/kDpTC33tzM84/CgElnze+cFxvcPsX/a9upz42IuUMAmtNrf0+pOl5sWi4nC+wJh0YrbywsvBlCtD3houwnJz9LVXfLTHmTeAQgITPmcha3IVM0IbCH0kfwHBFc91i77yxRY8RQ9+fDY0SvHgqZdzDCHRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396441; c=relaxed/simple;
	bh=uVUI9XT3ntm/IJHQ8VdbiNgxGQ63ksKn5ue/m1VRUYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kf4uZt6mXfg2dTLluuyFQKCwxaFPU5eXIyXBE/4FWvjy1BCBgGC+PmJRwGoYOZ24xp4lQh23/Ul/CHI4ISQZTNaYCItWyLne+UmX6MWcfsxrEyMDjlrHLxWO5SFNEQ709htZL0et7t+gmkdDzQAav0qs6hDZp6A6GJ8qcjAb9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=smvSQqpT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6289084a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740396437; x=1741001237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPK2zF8A/QoLIlZ7H4rce8LDxvSgapo6R5EV/XU26lw=;
        b=smvSQqpT1iNyAw4TqYZqACvPQgnTTKF6jPY1finqkDcYHrIA2RITOqFnZpniehSq4B
         RsZg6GdcKqaSnmEDwozoVpraectASso5bNz/l2sbKIaY3pYXlOOzIQOT7FSNZG+JVBgG
         Yt+p6HES/IONQIGVuOXma5cfyAR9qr/GT99aXBhmkZ9XrEBiQrv8wuB624VD6M9kpE44
         tCIg+ck+KqcEtL/QbbJ5ghsd34bdV9Qr/4KqbduHZA+ofg+LmEcppvCkfoV0sAp7vMni
         qq3suHhL07ymygXKI5efNAzh1mxH0UCcgYoFEjZtRtsM8qBKKj/9WFKtnEv+T/LFfVNt
         ds9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740396437; x=1741001237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPK2zF8A/QoLIlZ7H4rce8LDxvSgapo6R5EV/XU26lw=;
        b=Gxx4L9LzzyLPgR4TrOr73Yxfl5i33rqCiCHGMKLWXFZypJp8o0E0ZhlrASpcEZZvOq
         wmVrmBk6K4bMlEOTNu+auGUilHkBqe4Tx0AIu6pHCNkIyPB2CUu4N83uQsdbGkvyVtpW
         LQVox4VHV49Udv2D2Xhsoh8SPY2Ka4yiDrtf7dGaMttRPykvRQVPrnvPeCvFOSR59XI3
         jf2nb3UVkK+eN1zbewe9xSp05w2FrlTsY1hRKtIfemyGHi7X4yNIX8TuYX4e5x+0OdJZ
         rSFMehJoh6mfn6Ykb00jHQt7mPIAuZ4QoAygVZn7uZVnNaSDgng7D02Av6xW56pFUVcl
         KNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnz4C3SB7oU5I+ubZjDywATuBQe48Mvfo7KDqAsi4Diev7Ra2EkzsxUxja84Qkt3SmPh4PmZnblP9XjhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZNZ7/YozGQGpRyyHKbDbR5qzEv6x7wWy7iGi+VR8T7ABRLvRN
	Q7uBK4ztoOiz4NPFxwDtzWYX6L27J5j4BrLcI88oKQHf8CuoVwJZ6plD4V2pGWWZZVt5t0li4BS
	CInIoql9Cl+RGwdKULwkfcNEht6G4bSTDRoiRYw==
X-Gm-Gg: ASbGncuva+f7rBT5dOavq5Uyy8LZA3Ru52CeVMRL2sJU1RBMfk7y7PxRAZY1qWTq5Di
	M9CvGq58sPlvuPTaN6Qgfk6Qn16xaX+W7h2LwsMy6U6uTGOlaaHEQyQNFvnywD/u4AnbOPQ0faZ
	UPoDxfRBc=
X-Google-Smtp-Source: AGHT+IFzHPiP7HgEi1iLeAsUfPrgcPiwkLzFkdvMUmpitpPx5I5iW5pGV+bPYBd/LufmeWzu4SPrwChI7bwpkBQUkUA=
X-Received: by 2002:a05:6402:274b:b0:5dc:db28:6afc with SMTP id
 4fb4d7f45d1cf-5e0b6fdf732mr13463545a12.0.1740396436756; Mon, 24 Feb 2025
 03:27:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140419.1702389-1-ryan.roberts@arm.com> <20250217140419.1702389-3-ryan.roberts@arm.com>
In-Reply-To: <20250217140419.1702389-3-ryan.roberts@arm.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 24 Feb 2025 12:27:03 +0100
X-Gm-Features: AWEUYZkGhzPlXZwydhM9MLmyrXrPvhtmhDQdRWEVf0EDYo_eOVstS6UzcJ92dwo
Message-ID: <CAHVXubiBS-m91bpx-NbKdkcSk3HdStTxY8QLVTKxxozL2Od8Qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] arm64: hugetlb: Fix huge_ptep_get_and_clear() for
 non-present ptes
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	David Hildenbrand <david@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

On Mon, Feb 17, 2025 at 3:04=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> arm64 supports multiple huge_pte sizes. Some of the sizes are covered by
> a single pte entry at a particular level (PMD_SIZE, PUD_SIZE), and some
> are covered by multiple ptes at a particular level (CONT_PTE_SIZE,
> CONT_PMD_SIZE). So the function has to figure out the size from the
> huge_pte pointer. This was previously done by walking the pgtable to
> determine the level and by using the PTE_CONT bit to determine the
> number of ptes at the level.
>
> But the PTE_CONT bit is only valid when the pte is present. For
> non-present pte values (e.g. markers, migration entries), the previous
> implementation was therefore erroniously determining the size. There is
> at least one known caller in core-mm, move_huge_pte(), which may call
> huge_ptep_get_and_clear() for a non-present pte. So we must be robust to
> this case. Additionally the "regular" ptep_get_and_clear() is robust to
> being called for non-present ptes so it makes sense to follow the
> behaviour.
>
> Fix this by using the new sz parameter which is now provided to the
> function. Additionally when clearing each pte in a contig range, don't
> gather the access and dirty bits if the pte is not present.
>
> An alternative approach that would not require API changes would be to
> store the PTE_CONT bit in a spare bit in the swap entry pte for the
> non-present case. But it felt cleaner to follow other APIs' lead and
> just pass in the size.
>
> As an aside, PTE_CONT is bit 52, which corresponds to bit 40 in the swap
> entry offset field (layout of non-present pte). Since hugetlb is never
> swapped to disk, this field will only be populated for markers, which
> always set this bit to 0 and hwpoison swap entries, which set the offset
> field to a PFN; So it would only ever be 1 for a 52-bit PVA system where
> memory in that high half was poisoned (I think!). So in practice, this
> bit would almost always be zero for non-present ptes and we would only
> clear the first entry if it was actually a contiguous block. That's
> probably a less severe symptom than if it was always interpretted as 1
> and cleared out potentially-present neighboring PTEs.
>
> Cc: stable@vger.kernel.org
> Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit"=
)
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  arch/arm64/mm/hugetlbpage.c | 40 ++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 06db4649af91..614b2feddba2 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -163,24 +163,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
>                              unsigned long pgsize,
>                              unsigned long ncontig)
>  {
> -       pte_t orig_pte =3D __ptep_get(ptep);
> -       unsigned long i;
> -
> -       for (i =3D 0; i < ncontig; i++, addr +=3D pgsize, ptep++) {
> -               pte_t pte =3D __ptep_get_and_clear(mm, addr, ptep);
> -
> -               /*
> -                * If HW_AFDBM is enabled, then the HW could turn on
> -                * the dirty or accessed bit for any page in the set,
> -                * so check them all.
> -                */
> -               if (pte_dirty(pte))
> -                       orig_pte =3D pte_mkdirty(orig_pte);
> -
> -               if (pte_young(pte))
> -                       orig_pte =3D pte_mkyoung(orig_pte);
> +       pte_t pte, tmp_pte;
> +       bool present;
> +
> +       pte =3D __ptep_get_and_clear(mm, addr, ptep);
> +       present =3D pte_present(pte);
> +       while (--ncontig) {
> +               ptep++;
> +               addr +=3D pgsize;
> +               tmp_pte =3D __ptep_get_and_clear(mm, addr, ptep);
> +               if (present) {
> +                       if (pte_dirty(tmp_pte))
> +                               pte =3D pte_mkdirty(pte);
> +                       if (pte_young(tmp_pte))
> +                               pte =3D pte_mkyoung(pte);
> +               }
>         }
> -       return orig_pte;
> +       return pte;
>  }
>
>  static pte_t get_clear_contig_flush(struct mm_struct *mm,
> @@ -401,13 +400,8 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, =
unsigned long addr,
>  {
>         int ncontig;
>         size_t pgsize;
> -       pte_t orig_pte =3D __ptep_get(ptep);
> -
> -       if (!pte_cont(orig_pte))
> -               return __ptep_get_and_clear(mm, addr, ptep);
> -
> -       ncontig =3D find_num_contig(mm, addr, ptep, &pgsize);
>
> +       ncontig =3D num_contig_ptes(sz, &pgsize);
>         return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
>  }
>
> --
> 2.43.0
>

Thanks for ccing me on this fix, we have the same issue (in
huge_pte_clear() too) in riscv. I'll come up with a fix and wait for
you guys to merge this.

That only comforts my idea to merge both riscv and arm64 implementations :)

Thanks again,

Alex

