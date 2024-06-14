Return-Path: <linux-kernel+bounces-215523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8890941F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03128281AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4A186E5A;
	Fri, 14 Jun 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ4Ey6+K"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE631850B4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403894; cv=none; b=RBsbrtVgdO5epspIeuzLLGBB19T5YvZqfI+/j8eUcoZGCMYkoQgR4MUNz5toXvBhZLLX6cR1Jk8Bo3T6kLDSxOFBZeICoAn18kUfMOuRJSeKlJ0DaqgmbzxP2adVck5MJaa2MChuv90/uCEtE5uU4mf5GOTTxhQwSM9VWq7NpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403894; c=relaxed/simple;
	bh=bVZ1hAMuypYVc+JkugEt/+SkbdD2KDmBlV0rJQlC+4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klX9W7N3Koz9e35tQ9MYbH5ZIRT6gY5KdUx7JG+pMaJDB5A2WcNDpOuH945jNyJIgIMOzNSU4JE9yQreez+fXYLs2IuNCbPQxAXJEjRvA1iamsYRjMZWXeBf9WhiQhJm141pe2IomoVmLfwHsuatbC7IUlsxEWmoUVNzOeysVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ4Ey6+K; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4eb3277badcso781982e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718403892; x=1719008692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih2fA5Wax68aj8KVDoPb/EodfFp99EDrYIr3CW+2D0Y=;
        b=eZ4Ey6+KqABvYkSbfGQokcp3nBSRL5Qny2lcRc/heF51FDi3EGi2IsOfObNlXA2xTq
         5ItOW0GkzLMBMMFW9wGC9OM23VDIT8BncN5Vkx0ndugDU+II7aA4+CHVnMlh1pseS6MS
         qC4l4qsMZljlr6OnXaIJSt0TF6yU2WMu6a/vBWOrAymzw9CwxfmJ56MgpahQAdKbG2oH
         ZlRypUIllnzwKpKqUx11QcuoWqsE5XRFRQYHUBJWP6SGeaXBO4mdTt3v10Ahn8G4rjMc
         HAj9ZJt9CzT6n/y6nVYVpZUhaYsk1DJuW9dliXpvrHRtqcqa8SnPKW44aBFNBxPQeLJJ
         XUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718403892; x=1719008692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih2fA5Wax68aj8KVDoPb/EodfFp99EDrYIr3CW+2D0Y=;
        b=RBfCb0hcN43+GbVS0KpuL6zu2MwM8Mf1V/5TuD4zvxAyDGHBKhcXo4Ouk64UHy6eM3
         lAukwTlC+TgJoOoWevZGnQzvpTB02+6YNMJRYJFISuLEuI8Isc5qE9TAvksCEXkTW65V
         YA50QB4BGc/WKAAGss9BSA+wAdw7mTlfo3QVz8rkImVuRRNFje53RrVQfd5IJKA3K+P5
         SZHV9p8DDAlMPAatltWH5o0VN7jbOTFiuiU089vhUUJgFFqXWtOnFikv+rX1wFHZJ5U7
         b8p81I67QBYVXtccJ4asBfY7yCJt5IuJ0e4P6vBC+2h5cQawuNLjoQKXlo1Trqd6WGEs
         Lh5A==
X-Forwarded-Encrypted: i=1; AJvYcCXy6+qS1v7PHcjH/cYs4C1qrxQGBpiME0YSoG/kKhMs3lfTxrLoiswwvhq2Ouu/1XNa6SV4nx0gA0H0fyr4QMFphTBN25Lw55bmV+Vc
X-Gm-Message-State: AOJu0YwRUEHpD9FnoXxplngoM+gvqnHb3LOtRCq9X27qKkR5z9IU3UoK
	6SnCWaI7JdyA3mKnmU/6SIWJ93OuCJXTIcAwQ0PY3Wu7acEAEyKeTBV3ATD0qwiMz9zbEvZ7DXz
	F3IS6o5Ssm72qnpifKXYfJmX5SXw=
X-Google-Smtp-Source: AGHT+IF1U1FhPkWf9tA5ZiH6VlXt+AeiUC2VItUL1s0lrAitzST8yLQce2+xj1VLtYOOWix//ETOAq1FR2wQK9igbjU=
X-Received: by 2002:a05:6122:8d5:b0:4eb:25bb:b56f with SMTP id
 71dfb90a1353d-4ee3ff38290mr4490223e0c.13.1718403891617; Fri, 14 Jun 2024
 15:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-4-21cnbao@gmail.com>
 <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
 <b0b4a134-1d40-4eef-94f3-5c4593b55e78@redhat.com> <CAGsJ_4zDoevXiNOTbSefU4WfoPEpbkhArc1niTBFRPsMHu5j8w@mail.gmail.com>
 <cac7d354-bcf3-4d7f-866a-9665568a50a0@redhat.com> <CAGsJ_4xfPPz8oOe79nPxues0PkEem8O2Q+0zo6pU8uDGO1kMkg@mail.gmail.com>
 <e151cfd9-c0a5-4536-a490-77dc47aa3ed6@redhat.com> <CAGsJ_4wss6++EP8hSyuc3sPqtLgqqjs7DOUfQ5aCK36Bn+VbBg@mail.gmail.com>
 <CAGsJ_4yiVs48XKTMkijS95MwXfxcRkRv0j0rj7cFjKCi2AcYZg@mail.gmail.com>
 <aa2d9d4f-8f06-4388-afe3-ed4b626d41e2@redhat.com> <CAGsJ_4wJjp5kTRt=MAQ7umS-uSw9uyUthj1z5urmo5t084aUwQ@mail.gmail.com>
 <c50287f2-1c83-438b-ba4a-c08ef91b5ba9@redhat.com>
In-Reply-To: <c50287f2-1c83-438b-ba4a-c08ef91b5ba9@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 15 Jun 2024 10:24:40 +1200
Message-ID: <CAGsJ_4yGPz7oLCzS_tYHkihbjyCfxmxjAfq9t_XYcpReEy674A@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:10=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >> I don't think that is required? We are only working with anon folios. =
Or
> >> were you able to trigger this? (which would be weird)
> >
> > I didn't trigger this. but I am not sure if kfifo is always anon based =
on
> > the code context.
> >
> > for page,  it is 100% anon(otherwise "goto out"), but I am not quite
> > sure about kpage
> > by the code context.
> >
> > static int try_to_merge_one_page(struct vm_area_struct *vma,
> >                                   struct page *page, struct page *kpage=
)
> > {
> >          pte_t orig_pte =3D __pte(0);
> >          int err =3D -EFAULT;
> >
> >          if (page =3D=3D kpage)                      /* ksm page forked=
 */
> >                  return 0;
> >
> >          if (!PageAnon(page))
> >                  goto out;
> >          ....
> > }
> >
> > Then I saw this
> >
> > static int replace_page(struct vm_area_struct *vma, struct page *page,
> >                          struct page *kpage, pte_t orig_pte)
> > {
> >          ...
> >          VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
> >          VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(k=
page),
> >                          kfolio);
> > }
> >
> > If kfolio is always anon, we should have used
> > VM_BUG_ON_FOLIO(PageAnonExclusive(kpage), folio)
> > just like
> > VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
> > without "folio_test_anon(kfolio)".
> >
> > So I lost my way.
>
> try_to_merge_one_page() is either called with a KSM page (anon) from
> try_to_merge_with_ksm_page() or with the shared zeropage (!anon and must
> never become anon) from cmp_and_merge_page().
>
> So in replace_page(), we either have an ksm/anon page or the shared
> zeropage.
>
> We never updated the documentation of replace_page() to spell out that
> "kpage" can also be the shared zeropage.
>
> Note how replace_page() calls folio_add_anon_rmap_pte() not for the
> shared zeropage.
>
> If we would have to craft a new anon page things would be going terribly
> wrong.
>
> So not, this (!anon -> anon) must not happen and if it were to happen,
> it would be a real bug and your check in  folio_add_anon_rmap_pte()
> would catch it.

Thanks very much for the explanation. I wonder if the below can help
improve the doc. If yes, I may add a separate patch for it in v2.

diff --git a/mm/ksm.c b/mm/ksm.c
index d2641bc2efc9..56b10265e617 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1411,14 +1411,13 @@ static int replace_page(struct vm_area_struct
*vma, struct page *page,
                goto out_mn;
        }
        VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
-       VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage)=
,
-                       kfolio);
-
        /*
         * No need to check ksm_use_zero_pages here: we can only have a
         * zero_page here if ksm_use_zero_pages was enabled already.
         */
        if (!is_zero_pfn(page_to_pfn(kpage))) {
+               VM_BUG_ON_FOLIO(!folio_test_anon(kfolio) ||
PageAnonExclusive(kpage),
+                       kfolio);
                folio_get(kfolio);
                folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE=
);
                newpte =3D mk_pte(kpage, vma->vm_page_prot);

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

