Return-Path: <linux-kernel+bounces-203200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD78FD7CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B202286A04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14C15EFA3;
	Wed,  5 Jun 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+EfNYz2"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E3139D00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620686; cv=none; b=rDoB6Xv6Hz72rcbm2rSECzmymfIbk99gV/olWzpMvy7gzAoljVZOG8WYfeukbZul6fa4yUAitiKP1r/q3/hWnO2CHQeO1KztmGNow0p8LLWw3NLElr0+TP4C31p1PXI+iRneKN02fKgjODw+ZyluuVNR/fTIfthU7pxCHauSJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620686; c=relaxed/simple;
	bh=wsLJd9XTOh93kdrrnru+GG79W5fq9gLz1FNeFRrMDVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDZnm+t2ivmq0w8mmOMF3YziKZZc9rkqLky+zrQm6gxNRieesi9KrhOSOVT28vdjSctw+coyaS11yJKdSNRKl8KMucGxXA2dIfbHPERNoVmc4m9gRYPVNkoK1AqLS6lcO3YXqA8n40u1Sf2hOFTYnslxopL80eO8lcjV4zzQFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+EfNYz2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4215bfce9e1so4125e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717620683; x=1718225483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhkerP75B24Op+xfotSfzaERTrqVZe8jsZgVlTOH2Ys=;
        b=U+EfNYz2Wpe5qSopx3COJhgM1xGFSH472+vLvtKhU8l0n05ehVEEkxdVZ0NjQEtarC
         u5tk/feSNuqeZlDApeMPPBTU+p/vWJg/BP/Ed9ySU6ZV3hHTJg0ezbnjvBAqM9waR5C9
         2ZOLm3LLawWYnsMtel9U6Z/yf2+wMsZ+YKvYCowHY8MBjBvtCWO3eryHejLi3PYniqXF
         Qh7kuhi+7oxGeKGn7pOb/ybPiaozY5ASxy5CwXPCl2bLqR1AEpKwJgMk3OvA8wqZxX1u
         WfPkyZ2FwDzrSro4bC3o7CTxpId04sVe1ctGQxDvduNHIm91Y5+wPPVK9nWLGXoA/JtQ
         bWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620683; x=1718225483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhkerP75B24Op+xfotSfzaERTrqVZe8jsZgVlTOH2Ys=;
        b=vV4gyRcApkCZFEt1JyyRyJhuCJM6qoaCqr8iRDyy0S8Bvs4dreMBkEjAF31c1KFdk8
         jqAy/CzT3TxQyvY111tHrXXsOKi45j4Hk4SmlLePgUXgfYow50zRy4zZZikx7aFeZJEB
         /WI11ZMHG0TMjN2aPFdoRvRmWliygTd3Unyk0WlwTXmj9QZuz94EmRRaoLyCF9kmfda2
         5oAeDPuRwu+3jtxor8UwmajHtoHrGamsSGTcLNjR8IZ9SeDJ8IL1xLASjNivCbV39Kqk
         7rQcNE1NP201jrUP2ZDQ9oS9iOETrtgSFyFeNlHHzXi4UdRyIW3SYYndPXTnBMQuYi07
         dkWw==
X-Forwarded-Encrypted: i=1; AJvYcCWlS5/pZawq1X+Vdw0Y1OuIlmyu1URiTBPKRpiBHd5rIlDlzJBCQ5HWGDAjvWwVpFBJ0o1hnnXmCxAz9PRuW2NwhaKvFGFsEJa36h9N
X-Gm-Message-State: AOJu0YzYll4baHh41+0rcLyzhKvvxsGldn7+XQawHTaAo5xJLELz46OL
	KyISUtKMFGthpVYfeIQ1++Bj/htdXmII9jVT7QxfMU3w5SmsqCmS/mymQw6X8dPUCiyKPQTNhAO
	L+lyPH8U2mk24dLx7Dv0UcmJ/NHG/y8xz1mzI
X-Google-Smtp-Source: AGHT+IEbMkRvjlPVwJXh19m4/vlW5KmmCBj8sixyJ075AgGSspg6XUuNQ2l0LJG9f+TDKbhVbHCJyGM3Ds0tDYSm4jg=
X-Received: by 2002:a05:600c:3ba9:b0:41c:ab7:f9af with SMTP id
 5b1f17b1804b1-4215c0da3e7mr52655e9.3.1717620682273; Wed, 05 Jun 2024 13:51:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck> <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck> <ZcOQ-0pzA16AEbct@casper.infradead.org>
 <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com> <ZcT4DH7VE1XLBvVc@casper.infradead.org>
 <917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev>
In-Reply-To: <917FFC7F-0615-44DD-90EE-9F85F8EA9974@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 5 Jun 2024 14:50:44 -0600
Message-ID: <CAOUHufYF2E-hM-u8eZc+APZAsMX3pOAmto7kB3orH5_MRgvSkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
To: Muchun Song <muchun.song@linux.dev>, Frank van der Linden <fvdl@google.com>, 
	David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jane Chu <jane.chu@oracle.com>, 
	Will Deacon <will@kernel.org>, Nanyong Sun <sunnanyong@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, wangkefeng.wang@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 5:00=E2=80=AFAM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
> > On Feb 8, 2024, at 23:49, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Feb 07, 2024 at 06:24:52PM -0800, Jane Chu wrote:
> >> On 2/7/2024 6:17 AM, Matthew Wilcox wrote:
> >>> While this array of ~512 pages have been allocated to hugetlbfs, and =
one
> >>> would think that there would be no way that there could still be
> >>> references to them, another CPU can have a pointer to this struct pag=
e
> >>> (eg attempting a speculative page cache reference or
> >>> get_user_pages_fast()).  That means it will try to call
> >>> atomic_add_unless(&page->_refcount, 1, 0);
> >>>
> >>> Actually, I wonder if this isn't a problem on x86 too?  Do we need to
> >>> explicitly go through an RCU grace period before freeing the pages
> >>> for use by somebody else?
> >>>
> >> Sorry, not sure what I'm missing, please help.
> >
> > Having written out the analysis, I now think it can't happen on x86,
> > but let's walk through it because it's non-obvious (and I think it
> > illustrates what people are afraid of on Arm).
> >
> > CPU A calls either get_user_pages_fast() or __filemap_get_folio().
> > Let's do the latter this time.
> >
> >        folio =3D filemap_get_entry(mapping, index);
> > filemap_get_entry:
> >        rcu_read_lock();
> >        folio =3D xas_load(&xas);
> >        if (!folio_try_get_rcu(folio))
> >                goto repeat;
> >        if (unlikely(folio !=3D xas_reload(&xas))) {
> >                folio_put(folio);
> >                goto repeat;
> >        }
> > folio_try_get_rcu:
> >        folio_ref_try_add_rcu(folio, 1);
> > folio_ref_try_add_rcu:
> >        if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
> >                /* Either the folio has been freed, or will be freed. */
> >                return false;
> > folio_ref_add_unless:
> >        return page_ref_add_unless(&folio->page, nr, u);
> > page_ref_add_unless:
> >        atomic_add_unless(&page->_refcount, nr, u);
> >
> > A rather deep callchain there, but for our purposes the important part
> > is: we take the RCU read lock, we look up a folio, we increment its
> > refcount if it's not zero, then check that looking up this index gets
> > the same folio; if it doesn't, we decrement the refcount again and retr=
y
> > the lookup.
> >
> > For this analysis, we can be preempted at any point after we've got the
> > folio pointer from xa_load().
> >
> >> From hugetlb allocation perspective,  one of the scenarios is run time
> >> hugetlb page allocation (say 2M pages), starting from the buddy alloca=
tor
> >> returns compound pages, then the head page is set to frozen, then the
> >> folio(compound pages) is put thru the HVO process, one of which is
> >> vmemmap_split_pmd() in case a vmemmap page is a PMD page.
> >>
> >> Until the HVO process completes, none of the vmemmap represented pages=
 are
> >> available to any threads, so what are the causes for IRQ threads to ac=
cess
> >> their vmemmap pages?
> >
> > Yup, this sounds like enough, but it's not.  The problem is the person
> > who's looking up the folio in the pagecache under RCU.  They've got
> > the folio pointer and have been preempted.  So now what happens to our
> > victim folio?
> >
> > Something happens to remove it from the page cache.  Maybe the file is
> > truncated, perhaps vmscan comes along and kicks it out.  Either way, it=
's
> > removed from the xarray and gets its refcount set to 0.  If the lookup
> > were to continue at this time, everything would be fine because it woul=
d
> > see a refcount of 0 and not increment it (in page_ref_add_unless()).
> > And this is where my analysis of RCU tends to go wrong, because I only
> > think of interleaving event A and B.  I don't think about B and then C
> > happening before A resumes.  But it can!  Let's follow the journey of
> > this struct page.
> >
> > Now that it's been removed from the page cache, it's allocated by huget=
lb,
> > as you describe.  And it's one of the tail pages towards the end of
> > the 512 contiguous struct pages.  That means that we alter vmemmap so
> > that the pointer to struct page now points to a different struct page
> > (one of the earlier ones).  Then the original page of vmemmap containin=
g
> > our lucky struct page is returned to the page allocator.  At this point=
,
> > it no longer contains struct pages; it can contain literally anything.
> >
> > Where my analysis went wrong was that CPU A _no longer has a pointer
> > to it_.  CPU A has a pointer into vmemmap.  So it will access the
> > replacement struct page (which definitely has a refcount 0) instead of
> > the one which has been freed.  I had thought that CPU A would access th=
e
> > original memory which has now been allocated to someone else.  But no,
> > it can't because its pointer is virtual, not physical.
> >
> >
> > ---
> >
> > Now I'm thinking more about this and there's another scenario which I
> > thought might go wrong, and doesn't.  For 7 of the 512 pages which are
> > freed, the struct page pointer gathered by CPU A will not point to a
> > page with a refcount of 0.  Instead it will point to an alias of the
> > head page with a positive refcount.  For those pages, CPU A will see
> > folio_try_get_rcu() succeed.  Then it will call xas_reload() and see
> > the folio isn't there any more, so it will call folio_put() on somethin=
g
> > which used to be a folio, and isn't any more.
> >
> > But folio_put() calls folio_put_testzero() which calls put_page_testzer=
o()
> > without asserting that the pointer is actually to a folio.
> > So everything's fine, but really only by coincidence; I don't think
> > anybody's thought about this scenario before (maybe Muchun has, but I
> > don't remember it being discussed).
>
> I have to say it is a really great analysis, I haven't thought about the
> case of get_page_unless_zero() so deeply.
>
> To avoid increasing a refcount to a tail page struct, I have made
> all the 7 tail pages read-only when I first write those code.

I think making tail page metadata RO is a good design choice. Details below=
.

> But it
> is a really problem, because it will panic (due to RO permission)
> when encountering the above scenario to increase its refcount.
>
> In order to fix the race with __filemap_get_folio(), my first
> thought of fixing this issue is to add a rcu_synchronize() after
> the processing of HVO optimization and before being allocated to
> users. Note that HugePage pages are frozen before going through
> the precessing of HVO optimization meaning all the refcount of all
> the struct pages are 0. Therefore, folio_try_get_rcu() in
> __filemap_get_folio() will fail unless the HugeTLB page has been
> allocated to the user.
>
> But I realized there are some users who may pass a arbitrary
> page struct (which may be those 7 special tail page structs,
> alias of the head page struct, of a HugeTLB page) to the following
> helpers, which also could get a refcount of a tail page struct.
> Those helpers also need to be fixed.
>
>   1) get_page_unless_zero
>   2) folio_try_get
>   3) folio_try_get_rcu
>
> I have checked all the users of 1), If I am not wrong, all the users
> already handle the HugeTLB pages before calling to get_page_unless_zero()=
.
> Although there is no problem with 1) now, it will be fragile to let users
> guarantee that it will not pass any tail pages of a HugeTLB page to
> 1). So I want to change 1) to the following to fix this.
>
>         static inline bool get_page_unless_zero(struct page *page)
>         {
>                 if (page_ref_add_unless(page, 1, 0)) {
>                         /* @page must be a genuine head or alias head pag=
e here. */
>                         struct page *head =3D page_fixed_fake_head(page);
>
>                         if (likely(head =3D=3D page))
>                                 return true;
>                         put_page(head);
>                 }
>
>                 return false;
>         }
>
> 2) and 3) should adopt the similar approach to make sure we cannot increa=
se
> tail pages' refcount. 2) and 3) will be like the following (only demonstr=
ate
> the key logic):
>
>         static inline bool folio_try_get(struct folio *folio)/folio_ref_t=
ry_add_rcu
>         {
>                 if (folio_ref_add_unless(folio, 1, 0)) {
>                         struct folio *genuine =3D page_folio(&folio->page=
);
>
>                         if (likely(genuine =3D=3D folio))
>                                 return true;
>                         folio_put(genuine);
>                 }
>
>                 return false;
>         }
>
> Additionally, we also should alter RO permission of those 7 tail pages
> to RW to avoid panic().

We can use RCU, which IMO is a better choice, as the following:

get_page_unless_zero()
{
  int rc =3D false;

  rcu_read_lock();

  if (page_is_fake_head(page) || !page_ref_count(page)) {
        smp_mb(); // implied by atomic_add_unless()
        goto unlock;
  }

  rc =3D page_ref_add_unless();

unlock:
  rcu_read_unlock();

  return rc;
}

And on the HVO/de-HOV sides:

  folio_ref_unfreeze();
  synchronize_rcu();
  HVO/de-HVO;

I think this is a lot better than making tail page metadata RW because:
1. it helps debug, IMO, a lot;
2. I don't think HVO is the only one that needs this.

David (we missed you in today's THP meeting),

Please correct me if I'm wrong -- I think virtio-mem also suffers from
the same problem when freeing offlined struct page, since I wasn't
able to find anything that would prevent a **speculative** struct page
walker from trying to access struct pages belonging to pages being
concurrently offlined.

If this is true, we might want to map a "zero struct page" rather than
leave a hole in vmemmap when offlining pages. And the logic on the hot
removal side would be similar to that of HVO.



> There is no problem in the following helpers since all of them already
> handle HVO case through _compound_head(), they will get the __genuine__
> head page struct and increase its refcount.
>
>   1) try_get_page
>   2) folio_get
>   3) get_page
>
> Just some thoughts from mine, maybe you guys have more simple and gracefu=
l
> approaches. Comments are welcome.
>
> Muchun,
> Thanks.
>
>

