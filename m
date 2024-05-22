Return-Path: <linux-kernel+bounces-185648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93008CB865
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426551F26F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDE428FD;
	Wed, 22 May 2024 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgs3tjRg"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BE2595
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716340442; cv=none; b=T+f8XcUfFn5sR9hjSTebxIJIX6GDqS8VOkw1mOj0xhz2sQcq4TSSjefhEUf9IbAcRZjLLzS3YVag8q7gcPRKr3YFl8Gh1U2ac0xeQUbZnqAzeLVW2iysfmVWfbBl+4RDj+1X2tyeZAbRMvArjl7udBo0AnHpyUVfOzXcI1L/BIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716340442; c=relaxed/simple;
	bh=uN7XbyMTKTaRAXmKpGXJuIFdZa1b9x/JGdk1uuzJQTA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BI/cKVwKHw4POlOYRw4s6ki8AKbVSv6r34+ufiBTEAtc88Jg1JOk3F2eTXb42qqFxYYtf/UCoxukmbvVOezl3BRDd7bBFvTIK3w/7LytMCFSUSJAlGLGEaUVc+a3w5c87h8zj/8FyHyGsPjM4CzoBxqVQFeeOCq/vIWk9z9Z5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgs3tjRg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso849443b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716340440; x=1716945240; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ucokp0AAkm1JrdVm50A3xJsq/C1UNhIjxFEJPxYe7E=;
        b=Dgs3tjRglG/DIdSl3dHHuXpz9xy3MveqQpbSYJ2CiP6djQ2uhUJmYSpv/3Mswgd7lC
         /g9jhSUtP6pNnCw7DfMSkbfQOu75GnrQuUVjKptxID8hCnEFYa2xZzsLdqAop7SOdHGD
         +r0v3Ygw8PKrxg+VoF2KYWgPvk0r9wQa/qnHKWTfJjSYHTCeuYEKQdIdROFCKp3tVIoL
         4JLb4cy8KdYxlyR9Zz2EVrPL9OzHd6iw9ERUbP0uPqz5bH8cvvBDsbXcUpwYmUnBj7iL
         SUdzylGjcPklmg81IR9choXJ/4obAZkFsihMj7Xw+7xmCctCgodA6Hypg7tWVmhAxUFT
         eezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716340440; x=1716945240;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Ucokp0AAkm1JrdVm50A3xJsq/C1UNhIjxFEJPxYe7E=;
        b=R0WW+meE6YYoeZcBgX0qMXKp9v8Ui1WLf/p4/geo8jhRIJ/Az6+r0eCKLQT4TF3cV4
         i/wvxunUpu3axgXHlor3NjsmxudEDW20c4t5l4lAGf+e7Z2dl9nVTxyqsIGMaN2j2K2o
         Y6tRmXilMqhhqep30EJmWsjg1T76jxAOkVrsptMRo7stDxJBeaJvAkzoOaH0PQ1GHAtc
         IhduMzztvwW158wjYUJDAO4jiTh60QmfETfFtylhVk7BiwHsh9Oq3fVug6//5YkOtEbR
         JsZHlfL6xZq4U0VJb3/YTLYTNAENMSDegzH4E2QKJEHF7gB8MTetoJ/20JoGrqpU/hDO
         l+ng==
X-Gm-Message-State: AOJu0YzNAOA/LfIImayQRIgh5qHCYiE8xDrFJ8l24gUT0lyHLM3Txoet
	1GGGbEb79OpJkvI5KSBaX35oc+L3QUuRmb3PQ/zw1nila0avdpb/
X-Google-Smtp-Source: AGHT+IEeVFE7TfOpUrd1nI8e4z4RKvVMRMKWzoj8PEjSm761mXEMfBxfjcGLSveVOlL3LkbU11N+RQ==
X-Received: by 2002:a05:6a20:c909:b0:1b0:1025:2d5 with SMTP id adf61e73a8af0-1b1f88a6e1fmr780915637.36.1716340440370;
        Tue, 21 May 2024 18:14:00 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd930a3bf0sm1972833a91.5.2024.05.21.18.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 18:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 11:13:53 +1000
Message-Id: <D1FRWM5DHHOT.3EAJGCLO0YTND@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v2 18/20] powerpc/64s: Use contiguous PMD/PUD
 instead of HUGEPD
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Jason Gunthorpe" <jgg@nvidia.com>, "Peter Xu"
 <peterx@redhat.com>, "Oscar Salvador" <osalvador@suse.de>, "Michael
 Ellerman" <mpe@ellerman.id.au>
X-Mailer: aerc 0.17.0
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
 <ac9f4f2d6e571e4579a8125b81eaa88fbddd6187.1715971869.git.christophe.leroy@csgroup.eu> <D1EHK0STZ19E.3CTOAWG7LVBPK@gmail.com> <99575c2c-7840-4fa4-b84e-aaddc7fef4cb@csgroup.eu>
In-Reply-To: <99575c2c-7840-4fa4-b84e-aaddc7fef4cb@csgroup.eu>

On Tue May 21, 2024 at 2:43 AM AEST, Christophe Leroy wrote:
>
>
> Le 20/05/2024 =C3=A0 14:54, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Sat May 18, 2024 at 5:00 AM AEST, Christophe Leroy wrote:
> >> On book3s/64, the only user of hugepd is hash in 4k mode.
> >>
> >> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
> >>
> >> Rework hash-4k to use contiguous PMD and PUD instead.
> >>
> >> In that setup there are only two huge page sizes: 16M and 16G.
> >>
> >> 16M sits at PMD level and 16G at PUD level.
> >>
> >> pte_update doesn't know page size, lets use the same trick as
> >> hpte_need_flush() to get page size from segment properties. That's
> >> not the most efficient way but let's do that until callers of
> >> pte_update() provide page size instead of just a huge flag.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   arch/powerpc/include/asm/book3s/64/hash-4k.h  | 15 --------
> >>   arch/powerpc/include/asm/book3s/64/hash.h     | 38 +++++++++++++++--=
--
> >>   arch/powerpc/include/asm/book3s/64/hugetlb.h  | 38 -----------------=
--
> >>   .../include/asm/book3s/64/pgtable-4k.h        | 34 -----------------
> >>   .../include/asm/book3s/64/pgtable-64k.h       | 20 ----------
> >>   arch/powerpc/include/asm/hugetlb.h            |  4 ++
> >>   .../include/asm/nohash/32/hugetlb-8xx.h       |  4 --
> >>   .../powerpc/include/asm/nohash/hugetlb-e500.h |  4 --
> >>   arch/powerpc/include/asm/page.h               |  8 ----
> >>   arch/powerpc/mm/book3s64/hash_utils.c         | 11 ++++--
> >>   arch/powerpc/mm/book3s64/pgtable.c            | 12 ------
> >>   arch/powerpc/mm/hugetlbpage.c                 | 19 ----------
> >>   arch/powerpc/mm/pgtable.c                     |  2 +-
> >>   arch/powerpc/platforms/Kconfig.cputype        |  1 -
> >>   14 files changed, 43 insertions(+), 167 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/power=
pc/include/asm/book3s/64/hash-4k.h
> >> index 6472b08fa1b0..c654c376ef8b 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> >> @@ -74,21 +74,6 @@
> >>   #define remap_4k_pfn(vma, addr, pfn, prot)	\
> >>   	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
> >>  =20
> >> -#ifdef CONFIG_HUGETLB_PAGE
> >> -static inline int hash__hugepd_ok(hugepd_t hpd)
> >> -{
> >> -	unsigned long hpdval =3D hpd_val(hpd);
> >> -	/*
> >> -	 * if it is not a pte and have hugepd shift mask
> >> -	 * set, then it is a hugepd directory pointer
> >> -	 */
> >> -	if (!(hpdval & _PAGE_PTE) && (hpdval & _PAGE_PRESENT) &&
> >> -	    ((hpdval & HUGEPD_SHIFT_MASK) !=3D 0))
> >> -		return true;
> >> -	return false;
> >> -}
> >> -#endif
> >> -
> >>   /*
> >>    * 4K PTE format is different from 64K PTE format. Saving the hash_s=
lot is just
> >>    * a matter of returning the PTE bits that need to be modified. On 6=
4K PTE,
> >> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/=
include/asm/book3s/64/hash.h
> >> index faf3e3b4e4b2..509811ca7695 100644
> >> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> >> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> >> @@ -4,6 +4,7 @@
> >>   #ifdef __KERNEL__
> >>  =20
> >>   #include <asm/asm-const.h>
> >> +#include <asm/book3s/64/slice.h>
> >>  =20
> >>   /*
> >>    * Common bits between 4K and 64K pages in a linux-style PTE.
> >> @@ -161,14 +162,10 @@ extern void hpte_need_flush(struct mm_struct *mm=
, unsigned long addr,
> >>   			    pte_t *ptep, unsigned long pte, int huge);
> >>   unsigned long htab_convert_pte_flags(unsigned long pteflags, unsigne=
d long flags);
> >>   /* Atomic PTE updates */
> >> -static inline unsigned long hash__pte_update(struct mm_struct *mm,
> >> -					 unsigned long addr,
> >> -					 pte_t *ptep, unsigned long clr,
> >> -					 unsigned long set,
> >> -					 int huge)
> >> +static inline unsigned long hash__pte_update_one(pte_t *ptep, unsigne=
d long clr,
> >> +						 unsigned long set)
> >>   {
> >>   	__be64 old_be, tmp_be;
> >> -	unsigned long old;
> >>  =20
> >>   	__asm__ __volatile__(
> >>   	"1:	ldarx	%0,0,%3		# pte_update\n\
> >> @@ -182,11 +179,38 @@ static inline unsigned long hash__pte_update(str=
uct mm_struct *mm,
> >>   	: "r" (ptep), "r" (cpu_to_be64(clr)), "m" (*ptep),
> >>   	  "r" (cpu_to_be64(H_PAGE_BUSY)), "r" (cpu_to_be64(set))
> >>   	: "cc" );
> >> +
> >> +	return be64_to_cpu(old_be);
> >> +}
> >> +
> >> +static inline unsigned long hash__pte_update(struct mm_struct *mm,
> >> +					 unsigned long addr,
> >> +					 pte_t *ptep, unsigned long clr,
> >> +					 unsigned long set,
> >> +					 int huge)
> >> +{
> >> +	unsigned long old;
> >> +
> >> +	old =3D hash__pte_update_one(ptep, clr, set);
> >> +
> >> +	if (huge && IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> >> +		unsigned int psize =3D get_slice_psize(mm, addr);
> >> +		int nb, i;
> >> +
> >> +		if (psize =3D=3D MMU_PAGE_16M)
> >> +			nb =3D SZ_16M / PMD_SIZE;
> >> +		else if (psize =3D=3D MMU_PAGE_16G)
> >> +			nb =3D SZ_16G / PUD_SIZE;
> >> +		else
> >> +			nb =3D 1;
> >> +
> >> +		for (i =3D 1; i < nb; i++)
> >> +			hash__pte_update_one(ptep + i, clr, set);
> >> +	}
> >>   	/* huge pages use the old page table lock */
> >>   	if (!huge)
> >>   		assert_pte_locked(mm, addr);
> >>  =20
> >> -	old =3D be64_to_cpu(old_be);
> >>   	if (old & H_PAGE_HASHPTE)
> >>   		hpte_need_flush(mm, addr, ptep, old, huge);
> >>  =20
> >=20
> > Nice series, I don't know this hugepd code very well but I'll try.
> > Why do you have to replicate the PTE entry here? The hash table refill
> > should always be working on the first PTE of the page otherwise we have
> > bigger problems.
>
> I don't know how book3s/64 works exactly, but on nohash, when you get a=
=20
> TLB miss exception the only thing you have is the address and you don't=
=20
> know yes it is a hugepage so you get the PTE as if it was a 4k page and=
=20
> it is only when you read that PTE that you know it is a hugepage.
>
> Ok, on book3s/64 the page size seems to be encoded inside the segment so=
=20
> maybe it is a bit different but anyway the TLB miss exception (or DSI ?)=
=20
> can happen at any address.

Right.

If you think of the hash page table as a software loaded TLB (which
is how Linux kind of thinks of it), then DSI is a TLB miss. hash_page_x
calls find the Linux pte and load that translation into hash page table.

One of the hard parts is keeping them coherent with low overhead. This
requires pte bits H_PAGE_BUSY as a lock and H_PAGE_HASHPTE which means
it might be in the hash table. So Linux PTE and hash PTE have to be
1:1 in general.

There are probably cases where we could get away from 1:1, but I would
much prefer not to. Maybe read-only access would be okay though. But
the hash_page will have to always operate on the 0th pte, which I think
we get via segment size masking, same for any set / update / clear of
the pte.

> >=20
> > What paths look at the N > 0 PTEs of a contiguous page entry?
> >=20
>
> pte_offset_kernel() or pte_offset_map_lock() will land on any contiguous=
=20
> PTE based on the address handed to pte_index(), as if it was a standard=
=20
> (4k or 64k) page.
>
> pte_index() doesn't know it is a hugepage, that's the reason why we need=
=20
> to duplicate the entry.

From the mm/ side of things, hugetlb page tables are always walked via
the huge vma which knows the page size and could align address... I
guess except for fast gup? Which should be read-only. So okay you do
need to replicate huge ptes for fast gup at least. Any others?

There's going to need to be a little more to it. __hash_page_huge sets
PTE accessed and dirty for example, so if we allow any PTE readers to
check the non-0th pte we would have to do something about that.

How do you deal with dirty/accessed bits for other subarchs?

We could just remove the hash_page setting of those bits and just cause
a fault and require Linux mm to set them. At least for hugepages we
could do that probably without any real performance worry.

Thanks,
Nick

