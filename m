Return-Path: <linux-kernel+bounces-229884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2941917588
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78566282AB2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA156D527;
	Wed, 26 Jun 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkdcp6gO"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A4D51D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365000; cv=none; b=Eh5HPuzOJoLD9MeAVEqMw3+3ARNvK0MprpeUTjFbSKyBUtQv+mm6pc7C4lhQTzRyqThL4FbrNooqYrmyrbFgLDarTwBLtKQfMWFnKFINC44bo1G+51t//lb0L+k4i6uAUL8lK5c78WfDvleKJx6+O5RCxSfMkHHpAYE9kfGH2Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365000; c=relaxed/simple;
	bh=i41zU70QSzKoh7Z0WpJNbSsRYnogskxrw8Sg0DP8yDg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=jIen9z5+VfmPK0ELTabJzlTdC5skLJ1Y/XP83B0kmuPUR7R9M7/oJSpMEqi2WslSIVyvUGtnxUWIJj7KWcKDiNLgvOuctW/NayA1bLid5gOUplhXLWShTGpjb2hK+nQL+ntMkAuwMrehrtPitrEeCFFGaZGnK73G9TySBUZkJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkdcp6gO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f4a5344ec7so401525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719364998; x=1719969798; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4B0rJOt+TwGvnGU5npNqzbhof2wF8oGmpu7vqDya1w=;
        b=Gkdcp6gOoPtxWvcyH2ErBn0862Mk6oFgGywEGUVcMrlPtBhjdvWQQMBRgQ+mIpC3E+
         KqUEvnB4XyXJ+PJ5857A0OYo2jugToyXeEksZOeXzGx7qNJ/J2cmMnuGjodclhnebbOI
         bDbEzj2BZplZiXwaCVPBEmny6Ke4WO64aPO4boN5JDqO7mhTtr7GfMacga7y0nF/KvYm
         dyXpotU/hS9m/aMd2/t/w+kkjizuasnnkEZ35D95spjDJnqr4xwq0wVIzkbj5zlTlq2C
         oP+6llM/ZwYy9RhuBl0RipMtd6hqt+X9zxum8q3+kCKSzicv3boClg68qQjXR2X2HPkG
         hxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719364998; x=1719969798;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4B0rJOt+TwGvnGU5npNqzbhof2wF8oGmpu7vqDya1w=;
        b=bcvdaz2E3grLFXEO0e5C05GgqIUf/RCcDKwRYdJk6sVT26pnRXGNtzlf0fO1yEc38V
         OzkiyrrCjX4SJJCMgs50E8a0dPHLh7y8BIgrvANnY/PMKt/Kc9lptt50dgMBqAgXVx72
         8cRPNsnL/Dm3EGMQtLp8cAwO05FEYwuTiPU0IkwVGbpwKzuUqU1of20GJVG9c/ZTlEtM
         8E0CUDW81Rm2MZKHhpPrvqKgYrN+LW3lm7biG8lblx1pxARmB0jhHHpEPiJa68o7/HVI
         K2zeVlTabwTPi1yoFAAgucK+qnHAy/vnzlREW+tbEQNjfGvUtiYVgw/1/srD9L0gTAkE
         QQbA==
X-Gm-Message-State: AOJu0YzKJLkeBp13ZN8k21eR6JIAV5q+UqVRluq/zBebspeQcu6nU2QO
	xGSGa317aP1LE9QnHq0aVXwtQ9YL7t9cCV1ZL170uG4WmGVLatWKThcCBQ==
X-Google-Smtp-Source: AGHT+IEqVqDw1A2NGO/alG4xT0pZfiNKGUIkmcWKhLu+8DBykPZWCX+p598Z0xCi0cvGZzLtolmp2Q==
X-Received: by 2002:a17:902:7441:b0:1f4:a04e:8713 with SMTP id d9443c01a7336-1fa5e6bde38mr60633605ad.28.1719364997855;
        Tue, 25 Jun 2024 18:23:17 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5d29sm87734655ad.154.2024.06.25.18.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 18:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 11:23:11 +1000
Message-Id: <D29K0SVIUJDR.2HQTLIJG4R7VG@gmail.com>
To: "LEROY Christophe" <christophe.leroy2@cs-soprasteria.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Peter Xu" <peterx@redhat.com>, "Oscar Salvador" <osalvador@suse.de>,
 "Michael Ellerman" <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 21/23] powerpc/64s: Use contiguous PMD/PUD instead of
 HUGEPD
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
 <23f3fe9e8fe37cb164a369850d4569dddf359fdf.1719240269.git.christophe.leroy@csgroup.eu> <D28TSEV6QV38.2NWPFRY8KCQK7@gmail.com> <a8f76535-2d5a-4f25-83be-31aab1cd38c4@cs-soprasteria.com>
In-Reply-To: <a8f76535-2d5a-4f25-83be-31aab1cd38c4@cs-soprasteria.com>

On Tue Jun 25, 2024 at 3:20 PM AEST, LEROY Christophe wrote:
>
>
> Le 25/06/2024 =C3=A0 06:49, Nicholas Piggin a =C3=A9crit=C2=A0:
> > On Tue Jun 25, 2024 at 12:45 AM AEST, Christophe Leroy wrote:
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
> >=20
> > [snip]
> >=20
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
> >> +	if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && huge) {
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
> >> +		WARN_ON_ONCE(nb =3D=3D 1);	/* Should never happen */
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
> > We definitely need a bit more comment and changelog about the atomicity
> > issues here. I think the plan should be all hash-side access just
> > operates on PTE[0], which should avoid that whole race. There could be
> > some cases that don't follow that. Adding some warnings to catch such
> > things could be good too.
>
> That seems to be the case indeed, as we have the following in=20
> hash_page_mm():
>
> #ifndef CONFIG_PPC_64K_PAGES
> 	/*
> 	 * If we use 4K pages and our psize is not 4K, then we might
> 	 * be hitting a special driver mapping, and need to align the
> 	 * address before we fetch the PTE.
> 	 *
> 	 * It could also be a hugepage mapping, in which case this is
> 	 * not necessary, but it's not harmful, either.
> 	 */
> 	if (psize !=3D MMU_PAGE_4K)
> 		ea &=3D ~((1ul << mmu_psize_defs[psize].shift) - 1);
> #endif /* CONFIG_PPC_64K_PAGES */

Yeah, for that one it works (comment needs updating to say that it
*is* necessary). I think that's the main thing but there's other
possible places where it might not hold -- KVM too, not just the
hash refill.

> >=20
> > I'd been meaning to do more on this sooner, sorry. I've started
> > tinkering with adding a bit of debug code. I'll see if I can help with
> > adding a bit of comments.
>
> Yes would we very welcome, I guess you'll send it as followup/fixup=20
> patch to the series ?

Yeah, the basic approach I think is good, so it wouldn't be a
big rework.

>
> >=20
> > [snip]
> >=20
> >> diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/=
book3s64/hugetlbpage.c
> >> index 5a2e512e96db..83c3361b358b 100644
> >> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
> >> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
> >> @@ -53,6 +53,16 @@ int __hash_page_huge(unsigned long ea, unsigned lon=
g access, unsigned long vsid,
> >>   		/* If PTE permissions don't match, take page fault */
> >>   		if (unlikely(!check_pte_access(access, old_pte)))
> >>   			return 1;
> >> +		/*
> >> +		 * If hash-4k, hugepages use seeral contiguous PxD entries
> >> +		 * so bail out and let mm make the page young or dirty
> >> +		 */
> >> +		if (IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> >> +			if (!(old_pte & _PAGE_ACCESSED))
> >> +				return 1;
> >> +			if ((access & _PAGE_WRITE) && !(old_pte & _PAGE_DIRTY))
> >> +				return 1;
> >> +		}
> >>  =20
> >>   		/*
> >>   		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
> >=20
> > I'm hoping we wouldn't have to do this, if we follow the PTE[0] rule.
>
> But we still need all entries to be updated so that page walker which=20
> don't know they must use PTE[0] get the right information ?

Ah yeah. Maybe for ACCESSED|DIRTY we can slightly adjust that rule
and apply it to all PTEs. If we can do that then it takes care of
a few other cases too.

Bug what is the consequence of two pte_update racing? Let's say
page_vma_mkclean_one vs setting dirty. Can you end up with some
PTEs dirty and some not?

Thanks,
Nick

