Return-Path: <linux-kernel+bounces-185776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883008CBAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49875282972
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFD1768F0;
	Wed, 22 May 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2hozexq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA5770F3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356282; cv=none; b=m7P4ZYHj6tgz7xO8d0Ln165+IKikg4/4/9Ge61JNOKgSQIzgq4Joc6kdh7zdaJpqYwp5vWNxdgkJf6LJbks1kpJ0WlO59om15PK5muh1t40ere5tJGvzqCVXY741z5iBK201X0sDZBMtnAI7UY4/Q+gE2zQhXVkOpXa+BOBWfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356282; c=relaxed/simple;
	bh=M1vbEr2bfMwCsAGSyfbUsIYjbPt2pCi9j+BsYgQuGiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n20pnqMWNwX4Kn5yOaD/srf/QgCaH8Mhec4PvfOlAm8C7BJezu+5e41UV6MZqNAzZYQXbwsZxumQSA0W60y0ThNCgidF97M+Gzbzxq1LeLPls2iAwSeogNpK75FziaqBQQNnv26KJ5qBZbVAv0BpqRS85rpu0bOYV9+vEGmiTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2hozexq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so7523635e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716356278; x=1716961078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+HVAN6BzVPlHnPG0INZtHqTbC1FXGAbGa9Ct3lqJdo=;
        b=C2hozexqo46P9pOQIwQrTOdD6gvJODKfr/+FLXUiC5dQHGV2HlGet7itjdewhNy5ol
         RSmrQIUXecU8cD0UOB83fv7yR9EmRFNpws2cvDaxsGJz7yeTKxHwqpBXf6fx3/tf0rOS
         uJAlHmU33Mnvs6dgekhOjzPQut9NnJEN9D7YewMRJuTgaBQ8Lq3AXAH1QFImK/SBO5tD
         Y4yv1/i1+MIZJNK8d5OD4ildFP/+vVpjUZWsC9UzmCd19cvJ+d5ennATqNb8rp+wwfQ8
         aVPv3pDJFojodwplc7LNdkRoxQF5Gg+opk+68QZK3tye1DZXeK/9S3tomIX8YGmdIIMy
         u0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716356278; x=1716961078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+HVAN6BzVPlHnPG0INZtHqTbC1FXGAbGa9Ct3lqJdo=;
        b=lPvcc5al4kIu+AGtfv/t651azw+J+M8bdmEkd6XCwgkI4fLJn4Tw8KK0o5YZ1b2Pi/
         W73v8uVrpGGPGI4L3oTkKjYT2HSlmPUgfbGg0es8MTLrqokVSYvTIS4waEAY3TZxKwWC
         Q/cIKUhwut2QgN1WPxQQQPNcpdknxdN4W/5nov67YmsTGVPUKBt0L8Pr3PcxvC8rsXS8
         Z05RTfqh/54T+0a4DmZH1LColmt28dc/RbJCvg0QXabqF4zdD7WkwIHYi26O6QVJ9Wcc
         aNefAGNQ7WG894WYaTI8DrtPTq24dXw3Dno1dnsAjjbb/TryFRIf2i1kNPEZWWT3wrgA
         uRog==
X-Forwarded-Encrypted: i=1; AJvYcCWKY0AvM/jbUQuMh4dLgsTGIKBwujg35EWQ78iQ2hnCDk7AAF76eJ2x3Ht1HxoedlCccyTaga7g2CF1uHK9pg9ij7aaCknC16C1VQQt
X-Gm-Message-State: AOJu0Yz7NlBQGsJxj8KQ7R22o8xQrBxjE3DXXhjhiOazK91GrAtB+XJM
	/Ygv/4h0Wm34gQz/P7VeQkcvb7AJKmPR91Aur+6mvs6SxWMaLuMCoCgBKCdAoilx2zp4B5kD29B
	UkzTCzLszIvu1bPKwW8a5E6gAfZk=
X-Google-Smtp-Source: AGHT+IETkj3/Sw70uEPOnu1OWXXa+6Yv0OxgUJ6sufXAKQtRsOujf5WfGCqvRLwEruRToq65PwmNuzFY57OXnZ1JuY4=
X-Received: by 2002:a05:6512:3607:b0:523:48f2:e3fd with SMTP id
 2adb3069b0e04-526bdc53aa0mr370920e87.16.1716356278377; Tue, 21 May 2024
 22:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
 <ZhxwIh2M8jr6IZaF@dread.disaster.area> <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl> <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
 <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com> <2652f0c1-acc9-4288-8bca-c95ee49aa562@marcinwanat.pl>
In-Reply-To: <2652f0c1-acc9-4288-8bca-c95ee49aa562@marcinwanat.pl>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 22 May 2024 13:37:46 +0800
Message-ID: <CAGWkznE0psiqZYSRjF+Joq73--Yo-xUhGD0gnBa42fYC55BFdA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Marcin Wanat <private@marcinwanat.pl>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 11:47=E2=80=AFPM Marcin Wanat <private@marcinwanat.=
pl> wrote:
>
> On 21.05.2024 03:00, Zhaoyang Huang wrote:
> > On Tue, May 21, 2024 at 8:58=E2=80=AFAM Zhaoyang Huang <huangzhaoyang@g=
mail.com> wrote:
> >>
> >> On Tue, May 21, 2024 at 3:42=E2=80=AFAM Marcin Wanat <private@marcinwa=
nat.pl> wrote:
> >>>
> >>> On 15.04.2024 03:50, Zhaoyang Huang wrote:
> >>> I have around 50 hosts handling high I/O (each with 20Gbps+ uplinks
> >>> and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
> >>> kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT af=
fected.
> >>> However, with long-term kernels 6.1.XX and 6.6.XX,
> >>> (tested at least 10 different versions), this lockup always appears
> >>> after 2-30 days, similar to the report in the original thread.
> >>> The more load (for example, copying a lot of local files while
> >>> serving 20Gbps traffic), the higher the chance that the bug will appe=
ar.
> >>>
> >>> I haven't been able to reproduce this during synthetic tests,
> >>> but it always occurs in production on 6.1.X and 6.6.X within 2-30 day=
s.
> >>> If anyone can provide a patch, I can test it on multiple machines
> >>> over the next few days.
> >> Could you please try this one which could be applied on 6.6 directly. =
Thank you!
> > URL: https://lore.kernel.org/linux-mm/20240412064353.133497-1-zhaoyang.=
huang@unisoc.com/
> >
>
> Unfortunately, I am unable to cleanly apply this patch against the
> latest 6.6.31
Please try below one which works on my v6.6 based android. Thank you
for your test in advance :D

mm/huge_memory.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd90822b..5899906c326a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2498,7 +2498,7 @@ static void __split_huge_page(struct page *page,
struct list_head *list,
 {
  struct folio *folio =3D page_folio(page);
  struct page *head =3D &folio->page;
- struct lruvec *lruvec;
+ struct lruvec *lruvec =3D folio_lruvec(folio);
  struct address_space *swap_cache =3D NULL;
  unsigned long offset =3D 0;
  unsigned int nr =3D thp_nr_pages(head);
@@ -2513,9 +2513,6 @@ static void __split_huge_page(struct page *page,
struct list_head *list,
  xa_lock(&swap_cache->i_pages);
  }

- /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
- lruvec =3D folio_lruvec_lock(folio);
-
  ClearPageHasHWPoisoned(head);

  for (i =3D nr - 1; i >=3D 1; i--) {
@@ -2541,9 +2538,6 @@ static void __split_huge_page(struct page *page,
struct list_head *list,
  }

  ClearPageCompound(head);
- unlock_page_lruvec(lruvec);
- /* Caller disabled irqs, so they are still disabled here */
-
  split_page_owner(head, nr);

  /* See comment in __split_huge_page_tail() */
@@ -2560,7 +2554,6 @@ static void __split_huge_page(struct page *page,
struct list_head *list,
  page_ref_add(head, 2);
  xa_unlock(&head->mapping->i_pages);
  }
- local_irq_enable();

  if (nr_dropped)
  shmem_uncharge(head->mapping->host, nr_dropped);
@@ -2631,6 +2624,7 @@ int split_huge_page_to_list(struct page *page,
struct list_head *list)
  int extra_pins, ret;
  pgoff_t end;
  bool is_hzp;
+ struct lruvec *lruvec;

  VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
  VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
@@ -2714,6 +2708,14 @@ int split_huge_page_to_list(struct page *page,
struct list_head *list)

  /* block interrupt reentry in xa_lock and spinlock */
  local_irq_disable();
+
+ /*
+ * take lruvec's lock before freeze the folio to prevent the folio
+ * remains in the page cache with refcnt =3D=3D 0, which could lead to
+ * find_get_entry enters livelock by iterating the xarray.
+ */
+ lruvec =3D folio_lruvec_lock(folio);
+
  if (mapping) {
  /*
  * Check if the folio is present in page cache.
@@ -2748,12 +2750,16 @@ int split_huge_page_to_list(struct page *page,
struct list_head *list)
  }

  __split_huge_page(page, list, end);
+ unlock_page_lruvec(lruvec);
+ local_irq_enable();
  ret =3D 0;
  } else {
  spin_unlock(&ds_queue->split_queue_lock);
 fail:
  if (mapping)
  xas_unlock(&xas);
+
+ unlock_page_lruvec(lruvec);
  local_irq_enable();
  remap_page(folio, folio_nr_pages(folio));
  ret =3D -EAGAIN;
--=20
2.25.1

