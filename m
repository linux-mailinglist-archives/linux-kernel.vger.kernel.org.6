Return-Path: <linux-kernel+bounces-262740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179693CC10
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84731C214D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170FA816;
	Fri, 26 Jul 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwA0QrsK"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898063C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953468; cv=none; b=DoSr/hNllTIWN9Jbl2IL6KfO2fn+Oj3KgzqmM5KpdBhMYB5DPiBTI90Wr4o1s6iWQsV8+zWcjyiQAnfdRkQwrYLTgZv1Z9dP+n//XlwWPTZGD413RflDxmaPkgRCLXXCA/dFhSLDA7/TK+yxKG9662t7x225kfNgJWot4r2/bzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953468; c=relaxed/simple;
	bh=+8Z7zuHj1HIHyJJJHcyCi1jQAlMEEJC4ALWlLiUTuD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5K2KHF1+c3ynYX/3PuGbbtsftl1I3Q2jTaLyxAoEViD6wQZIvVq/BzTJLfchel9CEMvUw40BaYOJFb7nZf8xqa/ol64uVq+mccrIbdsbMFDdPwjGglpOk72+9sl0Dn8wCTJEiUc+n5irSMwOU+upJ54cWu+TGwGocXLqt4Dwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwA0QrsK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fee2bfd28so47091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721953465; x=1722558265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77qlRcL4PUP5h8ZRxtqeaydLFX3D5DF3IEwpxS5zrYg=;
        b=zwA0QrsKgZisgV/If59m2g4BlhIH5pQY70xxy8of0XTsXuQsU/YisntMMgh0RFLSva
         pvm5K7tD5F4XJyguaR9SYwPZS5+2ZEmmGZUc98G2M7yu0JYrqQb0VQunRxWZfn00PAQ8
         GA4/SBPyV9dEhAFxTlyi1Buh2yoQRiUsZfkiZ/aXSzNK1YCg8iiqgShDZywK1C7RHUK+
         w66MuL77oe0u4NzI0wiPoXr+6N+6N0crP25M+LcJe/Zyk+S5bF3jTc+4rs8Wk8wtqs7k
         Be0fweXeHFAVdZNT1e0zyimhzsKQ0UwRfr1lXvtmtt4qH/Mpck1J0PxJSeXfWD5fYrIL
         mldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721953465; x=1722558265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77qlRcL4PUP5h8ZRxtqeaydLFX3D5DF3IEwpxS5zrYg=;
        b=M7KXUHXVp2mSliw0YvU3+EkR/oMpmZfseW1nUXc3svs7YyJwTkkl8mt17NbNozliqj
         clMFQa1Ub0vh+SaKB1KbaemUKM3hlR5+8OVBYj7/4uVI0vasncfvFdoQjurIIzQYZrHs
         0yuw46pa0AI9qVmtO15RZzC3ww9s5M4MamutkpNS3wuw73HXJtSC7nMZNnCsF4Rc2tJC
         Vho1syb6ZcN/pSTXEEEWCZCyuufnjxp3LjZfPJ0S33xeAiRa83aNQIGb2Yqyfv8q4zPo
         g82+uyzlwGVsLv1jt/P6XH00keNF5cAv3RpC7Lsr/QJ77spESqVnc27nQY1OJlzKG2y0
         m7Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUQSh+OYna/qQx1q//cu/lzXPGCvo4erzY1cwxVuzEBmIYdhG3OIOFrHHIZkODeztLZOqW2+pWH/F0OwyrJhB5pQujl7QgRImLfzqLR
X-Gm-Message-State: AOJu0YyqATE+Ux6n6lntzebKrdhVhzdL35NxWCzRnI/gKFtPBBNDeHBR
	vKlimcRH0+sTszITMX7nQXDM5JSKXP0Aqj12udlBSMSWbjjoa8WBM5BxJJcApGE04n2sAPVal3Z
	7t4XQQ+Ih9XfLivcSExzrnb8lY/+I7LKQlpyt46Xn80V66vnwdHUSyGs=
X-Google-Smtp-Source: AGHT+IFxRpjgJ6wObQXGzkn9wNtJ+JxPuAaUrFwCV1R1K/Oz3SbJ3MmktuoDvJaW8UnM7obg5LRzDolOme3IjG1RkEI=
X-Received: by 2002:ac8:7e8f:0:b0:447:d78d:773b with SMTP id
 d75a77b69052e-44ff3a6e49amr1570931cf.6.1721953465392; Thu, 25 Jul 2024
 17:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715192142.3241557-1-peterx@redhat.com> <20240715192142.3241557-9-peterx@redhat.com>
 <CADrL8HVH8ff+_Szrmn4ZCyAkm9gDc2oY4VVo3r+6RN_ms6pbhw@mail.gmail.com> <ZqLUjQb2BjedihOx@x1n>
In-Reply-To: <ZqLUjQb2BjedihOx@x1n>
From: James Houghton <jthoughton@google.com>
Date: Thu, 25 Jul 2024 17:23:48 -0700
Message-ID: <CADrL8HWGf9BD5WX_zu7TW9NQXVXUwmaeHU6EGRJkSXyk2zesmg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] mm/mprotect: fix dax pud handlings
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Dave Jiang <dave.jiang@intel.com>, Rik van Riel <riel@surriel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	linuxppc-dev@lists.ozlabs.org, Matthew Wilcox <willy@infradead.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Oscar Salvador <osalvador@suse.de>, 
	Mel Gorman <mgorman@techsingularity.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Huang Ying <ying.huang@intel.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Hugh Dickins <hughd@google.com>, x86@kernel.org, 
	Nicholas Piggin <npiggin@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:41=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jul 25, 2024 at 11:29:49AM -0700, James Houghton wrote:
> > > -               pages +=3D change_pmd_range(tlb, vma, pud, addr, next=
, newprot,
> > > +
> > > +               if (pud_leaf(pud)) {
> > > +                       if ((next - addr !=3D PUD_SIZE) ||
> > > +                           pgtable_split_needed(vma, cp_flags)) {
> > > +                               __split_huge_pud(vma, pudp, addr);
> > > +                               goto again;
> >
> > IIUC, most of the time, we're just going to end up clearing the PUD in
> > this case. __split_huge_pud() will just clear it, then we goto again
> > and `continue` to the next pudp. Is that ok?
> >
> > (I think it's ok as long as: you never map an anonymous page with a
> > PUD,
>
> I think this is true.
>
> > and that uffd-wp is not usable with non-hugetlb PUD mappings of
> > user memory (which I think is only DAX?).
>
> Uffd-wp has the async mode that can even work with dax puds.. even though=
 I
> don't think anyone should be using it.  Just like I'm more sure that nobo=
dy
> is using mprotect() too with dax pud, and it further justifies why nobody
> cared this much..
>
> What uffd-wp would do in this case is it'll make pgtable_split_needed()
> returns true on this PUD, the PUD got wiped out, goto again, then
> change_prepare() will populate this pud with a pgtable page.  Then it goe=
s
> downwards, install PMD pgtable, then probably start installing pte marker=
s
> ultimately if it's a wr-protect operation.

Ah, I didn't understand this patch correctly. You're right, you'll
install PMDs underneath -- I thought we'd just find pud_none() and
bail out. So this all makes sense, thanks!

>
> > So it seems ok today...?)
>
> Yes I think it's ok so far, unless you think it's not. :)
>
> >
> > Also, does the comment in pgtable_split_needed() need updating?
>
> /*
>  * Return true if we want to split THPs into PTE mappings in change
>  * protection procedure, false otherwise.
>  */
>
> It looks to me it's ok for now to me? THP can represents PUD in dax, and =
we
> indeed want to break THPs (no matter PUD/PMD) finally into PTE mappings.

Oh, heh I was thinking of the other comment:

/*
* pte markers only resides in pte level, if we need pte markers,
* we need to split.  We cannot wr-protect shmem thp because file
* thp is handled differently when split by erasing the pmd so far.
*/

I guess this is fine too, it just kind of reads as if this function is
only called for PMDs. *shrug*

>
> >
> > Somewhat related question: change_huge_pmd() is very careful not to
> > clear the PMD before writing the new value. Yet change_pmd_range(),
> > when it calls into __split_huge_pmd(), will totally clear the PMD and
> > then populate the PTEs underneath (in some cases at least), seemingly
> > reintroducing the MADV_DONTNEED concern. But your PUD version, because
> > it never re-populates the PUD (or PMDs/PTEs underneath) does not have
> > this issue. WDYT?

I guess I'm wrong about this -- your PUD version is the same as the
PMD version in this respect: both clear the PUD/PMD and then install
lower page table entries.

>
> Could you elaborate more on the DONTNEED issue you're mentioning here?

In change_huge_pmd(), there is a comment about not clearing the pmd
before setting the new value. I guess the issue is: if a user is
MADV_DONTNEEDing some memory and happens to see a cleared PMD, it will
just move on. But in this case, if change_huge_pmd() temporarily
cleared a PMD, then MADV_DONTNEED saw it and moved on, and then
change_huge_pmd() installed a new PMD, the MADV_DONTNEED has basically
skipped over the PMD, probably not what the user wanted. It seems like
we have the same issue when a PMD is cleared when we're splitting it.

But yeah, given that your PUD version is apparently no different from
the PMD version in this respect, maybe this question isn't very
interesting. :)

>
> >
> > Thanks for this series!
>
> Thanks for reviewing it, James.

