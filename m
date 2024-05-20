Return-Path: <linux-kernel+bounces-183765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FB8C9DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E752845C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A61339B8;
	Mon, 20 May 2024 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjECXG9t"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E90367
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209684; cv=none; b=hBFb6bkJVaasP1CGDRiSMfypbTJzgXV8Mj+Usn+8e8Ios5ujI9ljvl9+xVSMOrAeYL7Y/C33g0y8bccRjiAJ7D1SY5mtaIAyYhoGLRWuaYwQA4Vg5gHPjSzFaMr8jUlj2+/tcXn8Wf+DoP8+ithnqjtDTQTUVh8L4Vm7srs7iv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209684; c=relaxed/simple;
	bh=VLJYwRbEs6zn5i8TGBXdzx7fqbzIQEsCUP/+nCE98xk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e+AAI8182qHV4wXN4vtBnmICsEv1HEv8lWxObW9gjI+ZgIPUhJqUQ0WFb3ytaaCQo5z0gc5h2yIT6oYUcuT0PxMwSrD38kiFyaE+L00qBsPgLCLxOVNohQYgUU/jcLeom5LfmjdVFSpxnWO/ahsLHmoe8FNGreH0Ii84YmvFBzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjECXG9t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec486198b6so67012555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716209682; x=1716814482; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsaS7hwC6SGwZpxPNV/aTtZM8wWRDwUCiBIx6wA+SRA=;
        b=YjECXG9tXNDKuM1kAVVJmpfw0Ji9iK8FJ0y7SPy8dseMlvY+KWVcYCfYQHAQLheQdA
         s4L2DT4+wFSP65ltISGWk37rn99C5cSP7TUY+oGrOtrcUEQ3rp/6UIOc8P72Gb17LP8u
         rrKVdM3ehdydKkjWXn6obnoKo1FUnPiAueA3hi/oiGHSEPf1OGbDg0V6jkxymgdS1X1X
         n//MPU7Dn+tSS7zIu1HLZ06tyKUej3WSmNbWkwaknU820gtLaeBIs4Hq1cXD5WgX2wta
         5I7hqpGhhwwjPouD3UTJkkU0myl58SkYu9gWmh3CPqaj67cNTLVoEk068VcetUnvYrfj
         HNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209682; x=1716814482;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PsaS7hwC6SGwZpxPNV/aTtZM8wWRDwUCiBIx6wA+SRA=;
        b=pP4ze88q5b1J5lj7EoGXHqXJdY2jE0j8s9DS0o0eCQovN0lXY3aYUFQ1v5BkkdOkV9
         VSU5Uf8CBTSSarymr12wqwENanL6qytlPItn9maXgv9pB/IqhdOynpFuwn3AOvM5E94X
         8QqeA6fDJyXBmtgPxFN4cUS44qWoeSFufI8PZa+Uw29K34ZwD2Q90g2mjSvGtSRAb5Ru
         sbR1Zk0iZ69jrbrNoEQ5VmeTVPprlCgOXe23TQrB20DYd0u4Of5jdgpXXTgHhKEw9JUN
         ikBWasHPgQg1s5ea41KOaCv3T91VXEX3l3zLFEuABYW/GsbTboaDxnwUAVJMsLUntutg
         KEEQ==
X-Gm-Message-State: AOJu0Yw8cKqEZog7j/4/CPR/vx7YO0bLdFRqCcAJuL38hkUREEOpU2VX
	AIiJr2Bztbg/1FLVq7I2Pep3qYGv7Zfh3CCabo7rwM3s+Py5MBby
X-Google-Smtp-Source: AGHT+IGQD5voDad482etfAFYqJItSYWnKfB4jvZBywe8XpDGx+z9MFzihkDpII2A9KT8cmADi+Mg7g==
X-Received: by 2002:a05:6a00:b51:b0:6ed:88e5:53d4 with SMTP id d2e1a72fcca58-6f4e02aa365mr35041612b3a.8.1716209682074;
        Mon, 20 May 2024 05:54:42 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4eccc3b91sm16004093b3a.66.2024.05.20.05.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 05:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 22:54:35 +1000
Message-Id: <D1EHK0STZ19E.3CTOAWG7LVBPK@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
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
 <ac9f4f2d6e571e4579a8125b81eaa88fbddd6187.1715971869.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ac9f4f2d6e571e4579a8125b81eaa88fbddd6187.1715971869.git.christophe.leroy@csgroup.eu>

On Sat May 18, 2024 at 5:00 AM AEST, Christophe Leroy wrote:
> On book3s/64, the only user of hugepd is hash in 4k mode.
>
> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
>
> Rework hash-4k to use contiguous PMD and PUD instead.
>
> In that setup there are only two huge page sizes: 16M and 16G.
>
> 16M sits at PMD level and 16G at PUD level.
>
> pte_update doesn't know page size, lets use the same trick as
> hpte_need_flush() to get page size from segment properties. That's
> not the most efficient way but let's do that until callers of
> pte_update() provide page size instead of just a huge flag.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-4k.h  | 15 --------
>  arch/powerpc/include/asm/book3s/64/hash.h     | 38 +++++++++++++++----
>  arch/powerpc/include/asm/book3s/64/hugetlb.h  | 38 -------------------
>  .../include/asm/book3s/64/pgtable-4k.h        | 34 -----------------
>  .../include/asm/book3s/64/pgtable-64k.h       | 20 ----------
>  arch/powerpc/include/asm/hugetlb.h            |  4 ++
>  .../include/asm/nohash/32/hugetlb-8xx.h       |  4 --
>  .../powerpc/include/asm/nohash/hugetlb-e500.h |  4 --
>  arch/powerpc/include/asm/page.h               |  8 ----
>  arch/powerpc/mm/book3s64/hash_utils.c         | 11 ++++--
>  arch/powerpc/mm/book3s64/pgtable.c            | 12 ------
>  arch/powerpc/mm/hugetlbpage.c                 | 19 ----------
>  arch/powerpc/mm/pgtable.c                     |  2 +-
>  arch/powerpc/platforms/Kconfig.cputype        |  1 -
>  14 files changed, 43 insertions(+), 167 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/=
include/asm/book3s/64/hash-4k.h
> index 6472b08fa1b0..c654c376ef8b 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
> @@ -74,21 +74,6 @@
>  #define remap_4k_pfn(vma, addr, pfn, prot)	\
>  	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
> =20
> -#ifdef CONFIG_HUGETLB_PAGE
> -static inline int hash__hugepd_ok(hugepd_t hpd)
> -{
> -	unsigned long hpdval =3D hpd_val(hpd);
> -	/*
> -	 * if it is not a pte and have hugepd shift mask
> -	 * set, then it is a hugepd directory pointer
> -	 */
> -	if (!(hpdval & _PAGE_PTE) && (hpdval & _PAGE_PRESENT) &&
> -	    ((hpdval & HUGEPD_SHIFT_MASK) !=3D 0))
> -		return true;
> -	return false;
> -}
> -#endif
> -
>  /*
>   * 4K PTE format is different from 64K PTE format. Saving the hash_slot =
is just
>   * a matter of returning the PTE bits that need to be modified. On 64K P=
TE,
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/inc=
lude/asm/book3s/64/hash.h
> index faf3e3b4e4b2..509811ca7695 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -4,6 +4,7 @@
>  #ifdef __KERNEL__
> =20
>  #include <asm/asm-const.h>
> +#include <asm/book3s/64/slice.h>
> =20
>  /*
>   * Common bits between 4K and 64K pages in a linux-style PTE.
> @@ -161,14 +162,10 @@ extern void hpte_need_flush(struct mm_struct *mm, u=
nsigned long addr,
>  			    pte_t *ptep, unsigned long pte, int huge);
>  unsigned long htab_convert_pte_flags(unsigned long pteflags, unsigned lo=
ng flags);
>  /* Atomic PTE updates */
> -static inline unsigned long hash__pte_update(struct mm_struct *mm,
> -					 unsigned long addr,
> -					 pte_t *ptep, unsigned long clr,
> -					 unsigned long set,
> -					 int huge)
> +static inline unsigned long hash__pte_update_one(pte_t *ptep, unsigned l=
ong clr,
> +						 unsigned long set)
>  {
>  	__be64 old_be, tmp_be;
> -	unsigned long old;
> =20
>  	__asm__ __volatile__(
>  	"1:	ldarx	%0,0,%3		# pte_update\n\
> @@ -182,11 +179,38 @@ static inline unsigned long hash__pte_update(struct=
 mm_struct *mm,
>  	: "r" (ptep), "r" (cpu_to_be64(clr)), "m" (*ptep),
>  	  "r" (cpu_to_be64(H_PAGE_BUSY)), "r" (cpu_to_be64(set))
>  	: "cc" );
> +
> +	return be64_to_cpu(old_be);
> +}
> +
> +static inline unsigned long hash__pte_update(struct mm_struct *mm,
> +					 unsigned long addr,
> +					 pte_t *ptep, unsigned long clr,
> +					 unsigned long set,
> +					 int huge)
> +{
> +	unsigned long old;
> +
> +	old =3D hash__pte_update_one(ptep, clr, set);
> +
> +	if (huge && IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> +		unsigned int psize =3D get_slice_psize(mm, addr);
> +		int nb, i;
> +
> +		if (psize =3D=3D MMU_PAGE_16M)
> +			nb =3D SZ_16M / PMD_SIZE;
> +		else if (psize =3D=3D MMU_PAGE_16G)
> +			nb =3D SZ_16G / PUD_SIZE;
> +		else
> +			nb =3D 1;
> +
> +		for (i =3D 1; i < nb; i++)
> +			hash__pte_update_one(ptep + i, clr, set);
> +	}
>  	/* huge pages use the old page table lock */
>  	if (!huge)
>  		assert_pte_locked(mm, addr);
> =20
> -	old =3D be64_to_cpu(old_be);
>  	if (old & H_PAGE_HASHPTE)
>  		hpte_need_flush(mm, addr, ptep, old, huge);
> =20

Nice series, I don't know this hugepd code very well but I'll try.
Why do you have to replicate the PTE entry here? The hash table refill
should always be working on the first PTE of the page otherwise we have
bigger problems.

What paths look at the N > 0 PTEs of a contiguous page entry?

Thanks,
Nick

