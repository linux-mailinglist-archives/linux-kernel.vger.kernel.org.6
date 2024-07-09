Return-Path: <linux-kernel+bounces-245071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B892ADE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A1E1F22E93
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957413CF6A;
	Tue,  9 Jul 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz3xrphx"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22D347A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720489476; cv=none; b=XU35fP+dLroX5zrV+6j1ZjRD7SeiaYGjQtnCEFaPY/smyLvrl63ZIUy+QFFx3Gp3Aj01V+ftDjmafJeiRiiWuJRvMYbLDRrwmIh9rpz1ig8KhsUTs//WkLexQv8REUynelG4wztV7JzfxtWr4NzmSIZPM0LMr6bfoW4YI5ZiaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720489476; c=relaxed/simple;
	bh=sdOJm9Z+Rrobjli2x5KtQupuJKfwPzoOOLPs6UXdhAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9p98o2mo1zrsDfLjxrshJX8Om8WbGT1j6x+uLK24sM7JyDz76DAM3TuroBJsOP+fXyiHoORW0BZsJz0i77m+AmrWsIq2p3JpEHhjXCEP7DysAu5vE1kWX1YGsmzloq9S7z6vj4xosyr1bTaiUn3voNLpVZJyRiMRESMS2mJPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz3xrphx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso26004065ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720489474; x=1721094274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7JwVPtkjnXuNlozYkqpZNw80t4p50gXWxEmF3epp84=;
        b=Fz3xrphxr/ZORLU76gSmWpx/Dgf9XEOrv6Q2yxl4Fve09DmnShFRnAj+Fw95CHRxeN
         xQxkPz/vqTVZ2oW3aItyJqNQHqKGj/I2pyzsyodpd9b4SJ3X376xPRiAwmNXIcG2dQJA
         LleUJzjhTYdO6gSTi8cnEO10Ntb9X2rDR8wEO9zmvKz1tFiBswYWkqVhhNgI0w0MG787
         Ma+9T8T3mmCy1NAsfvx5aDK/UoFFNw747GIJsVjnXg0h1pqQn18xBp9TzdCkcvP68FpZ
         aRUqTzuY+r+2umZiM3dR7/8dXL3xmMEbXyLu3pIj28XB/RWDbkUPza7xIJ2mauji3ChO
         Fuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720489474; x=1721094274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7JwVPtkjnXuNlozYkqpZNw80t4p50gXWxEmF3epp84=;
        b=gnZ0gWPAWcqI4ZJBxsTqSm0T5VZeB18BNjbohY1zHdZlfnSrcyUBWFY+Y2sxB45k0u
         3nsb0hEwJBCubZBSBaGhvhIq/p/1RnDt248+9edDjlPwtytpPBP7h+v2BgKHURU060AF
         B/k70ue1v4m6bbz3+HrfcqE7Z4hZhjvUrMCZLlWSmw9vKIhuz2K+LvOWsERmW1l5E5k6
         b+NJCcyf+47wIrHVipwZs0WTNRXM2khDHiGKuVmfpJeiIw3wXpevzkiiqmL+dX3NrJ26
         kk9U6YWkioEItSxZA9QJff+2jd+DJDdbsWdhsAZUjCOe5mVL95bIYs/zqZFUTMK7IEyG
         /ykQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbQwYBNUL1BSSsVUuisw3M2Bftx88PNGO1KNVRPMv9KhJe96fJ0uk9ffQJFUe6lmM3NV8H8y1MxcJ6LpUwYr0TUd15I2pSVuU72KK3
X-Gm-Message-State: AOJu0Yz2FTA7JaswXFWDcsl2g4jhwerfTFFmJTqcbSnevlrYvUAeCYze
	0dlu+nJFOjAZseGZX4B+aJUykc7nK1DNmFH6IN/b1ch4MRIZQJUb
X-Google-Smtp-Source: AGHT+IEGRgF6WH6W+fLpO2gg+v0EPIgumYh7bbxFBukp6w+Svkfg/57ie1z+Mr5bos7qmDXFjYhyog==
X-Received: by 2002:a05:6a20:4388:b0:1c0:ee57:a9a5 with SMTP id adf61e73a8af0-1c2984ce6bemr962165637.42.1720489473967;
        Mon, 08 Jul 2024 18:44:33 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6c53sm4910245ad.153.2024.07.08.18.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 18:44:33 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	da.gomez@samsung.com,
	david@redhat.com,
	hughd@google.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	ziy@nvidia.com
Subject: [PATCH v1] mm: shmem: Rename mTHP shmem counters
Date: Tue,  9 Jul 2024 13:44:13 +1200
Message-Id: <20240709014413.18044-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
References: <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 9, 2024 at 12:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 08/07/2024 12:36, Barry Song wrote:
> > On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> The legacy PMD-sized THP counters at /proc/vmstat include
> >> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
> >> rather confusingly refer to shmem THP and do not include any other types
> >> of file pages. This is inconsistent since in most other places in the
> >> kernel, THP counters are explicitly separated for anon, shmem and file
> >> flavours. However, we are stuck with it since it constitutes a user ABI.
> >>
> >> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> >> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> >> same "file_" prefix in the names. But in future, we may want to add
> >> extra stats to cover actual file pages, at which point, it would all
> >> become very confusing.
> >>
> >> So let's take the opportunity to rename these new counters "shmem_"
> >> before the change makes it upstream and the ABI becomes immutable.
> >
> > Personally, I think this approach is much clearer. However, I recall
> > we discussed this
> > before [1], and it seems that inconsistency is a concern?
>
> Embarrassingly, I don't recall that converstation at all :-| but at least what I
> said then is consistent with what I've done in this patch.
>
> I think David's conclusion from that thread was to call them FILE_, and add both
> shmem and pagecache counts to those counters, meaning we can keep the same name
> as legacy THP counters. But those legacy THP counters only count shmem, and I
> don't think we would get away with adding pagecache counts to those at this
> point? (argument: they have been around for long time and there is a risk that
> user space relies on them and if they were to dramatically increase due to
> pagecache addition now that could break things). In that case, there is still
> inconsistency, but its worse; the names are consistent but the semantics are
> inconsistent.
>
> So my vote is to change to SHMEM_ as per this patch :)

I have no objections. However, I dislike the documentation for
thp_file_*. Perhaps we can clean it all up together ?

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 709fe10b60f4..65df48cb3bbb 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -417,21 +417,22 @@ thp_collapse_alloc_failed
 	the allocation.
 
 thp_file_alloc
-	is incremented every time a file huge page is successfully
-	allocated.
+	is incremented every time a file (including shmem) huge page is
+	successfully allocated.
 
 thp_file_fallback
-	is incremented if a file huge page is attempted to be allocated
-	but fails and instead falls back to using small pages.
+	is incremented if a file (including shmem) huge page is attempted
+	to be allocated but fails and instead falls back to using small
+	pages.
 
 thp_file_fallback_charge
-	is incremented if a file huge page cannot be charged and instead
-	falls back to using small pages even though the allocation was
-	successful.
+	is incremented if a file (including shmem) huge page cannot be
+	charged and instead falls back to using small pages even though
+	the allocation was successful.
 
 thp_file_mapped
-	is incremented every time a file huge page is mapped into
-	user address space.
+	is incremented every time a file (including shmem) huge page is
+	mapped into user address space.
 
 thp_split_page
 	is incremented every time a huge page is split into base
 	
>
> >
> > [1] https://lore.kernel.org/linux-mm/05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com/
> >
> >
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> ---
> >>
> >> Hi All,
> >>
> >> Applies on top of today's mm-unstable (2073cda629a4) and tested with mm
> >> selftests; no regressions observed.
> >>
> >> The backstory here is that I'd like to introduce some counters for regular file
> >> folio allocations to observe how often large folio allocation succeeds, but
> >> these shmem counters are named "file" which is going to make things confusing.
> >> So hoping to solve that before commit 66f44583f9b6 ("mm: shmem: add mTHP
> >> counters for anonymous shmem") goes upstream (it is currently in mm-stable).
> >>
> >> Admittedly, this change means the mTHP stat names are not the same as the legacy
> >> PMD-size THP names, but I think that's a smaller issue than having "file_" mTHP
> >> stats that only count shmem, then having to introduce "file2_" or "pgcache_"
> >> stats for the regular file memory, which is even more inconsistent IMHO. I guess
> >> the alternative is to count both shmem and file in these mTHP stats (that's how
> >> they were documented anyway) but I think it's better to be able to consider them
> >> separately like we do for all the other counters.
> >>
> >> Thanks,
> >> Ryan
> >>
> >>  Documentation/admin-guide/mm/transhuge.rst | 12 ++++++------
> >>  include/linux/huge_mm.h                    |  6 +++---
> >>  mm/huge_memory.c                           | 12 ++++++------
> >>  mm/shmem.c                                 |  8 ++++----
> >>  4 files changed, 19 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> >> index 747c811ee8f1..8b891689fc13 100644
> >> --- a/Documentation/admin-guide/mm/transhuge.rst
> >> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >> @@ -496,16 +496,16 @@ swpout_fallback
> >>         Usually because failed to allocate some continuous swap space
> >>         for the huge page.
> >>
> >> -file_alloc
> >> -       is incremented every time a file huge page is successfully
> >> +shmem_alloc
> >> +       is incremented every time a shmem huge page is successfully
> >>         allocated.
> >>
> >> -file_fallback
> >> -       is incremented if a file huge page is attempted to be allocated
> >> +shmem_fallback
> >> +       is incremented if a shmem huge page is attempted to be allocated
> >>         but fails and instead falls back to using small pages.
> >>
> >> -file_fallback_charge
> >> -       is incremented if a file huge page cannot be charged and instead
> >> +shmem_fallback_charge
> >> +       is incremented if a shmem huge page cannot be charged and instead
> >>         falls back to using small pages even though the allocation was
> >>         successful.
> >>
> >> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >> index acb6ac24a07e..cff002be83eb 100644
> >> --- a/include/linux/huge_mm.h
> >> +++ b/include/linux/huge_mm.h
> >> @@ -269,9 +269,9 @@ enum mthp_stat_item {
> >>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>         MTHP_STAT_SWPOUT,
> >>         MTHP_STAT_SWPOUT_FALLBACK,
> >> -       MTHP_STAT_FILE_ALLOC,
> >> -       MTHP_STAT_FILE_FALLBACK,
> >> -       MTHP_STAT_FILE_FALLBACK_CHARGE,
> >> +       MTHP_STAT_SHMEM_ALLOC,
> >> +       MTHP_STAT_SHMEM_FALLBACK,
> >> +       MTHP_STAT_SHMEM_FALLBACK_CHARGE,
> >>         MTHP_STAT_SPLIT,
> >>         MTHP_STAT_SPLIT_FAILED,
> >>         MTHP_STAT_SPLIT_DEFERRED,
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 9ec64aa2be94..f9696c94e211 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -568,9 +568,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
> >>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> >>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
> >>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
> >> -DEFINE_MTHP_STAT_ATTR(file_alloc, MTHP_STAT_FILE_ALLOC);
> >> -DEFINE_MTHP_STAT_ATTR(file_fallback, MTHP_STAT_FILE_FALLBACK);
> >> -DEFINE_MTHP_STAT_ATTR(file_fallback_charge, MTHP_STAT_FILE_FALLBACK_CHARGE);
> >> +DEFINE_MTHP_STAT_ATTR(shmem_alloc, MTHP_STAT_SHMEM_ALLOC);
> >> +DEFINE_MTHP_STAT_ATTR(shmem_fallback, MTHP_STAT_SHMEM_FALLBACK);
> >> +DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTHP_STAT_SHMEM_FALLBACK_CHARGE);
> >>  DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >>  DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >>  DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >> @@ -581,9 +581,9 @@ static struct attribute *stats_attrs[] = {
> >>         &anon_fault_fallback_charge_attr.attr,
> >>         &swpout_attr.attr,
> >>         &swpout_fallback_attr.attr,
> >> -       &file_alloc_attr.attr,
> >> -       &file_fallback_attr.attr,
> >> -       &file_fallback_charge_attr.attr,
> >> +       &shmem_alloc_attr.attr,
> >> +       &shmem_fallback_attr.attr,
> >> +       &shmem_fallback_charge_attr.attr,
> >>         &split_attr.attr,
> >>         &split_failed_attr.attr,
> >>         &split_deferred_attr.attr,
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 921d59c3d669..f24dfbd387ba 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -1777,7 +1777,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> >>                         if (pages == HPAGE_PMD_NR)
> >>                                 count_vm_event(THP_FILE_FALLBACK);
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> -                       count_mthp_stat(order, MTHP_STAT_FILE_FALLBACK);
> >> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
> >>  #endif
> >>                         order = next_order(&suitable_orders, order);
> >>                 }
> >> @@ -1804,8 +1804,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
> >>                                 count_vm_event(THP_FILE_FALLBACK_CHARGE);
> >>                         }
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK);
> >> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_FALLBACK_CHARGE);
> >> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
> >> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
> >>  #endif
> >>                 }
> >>                 goto unlock;
> >> @@ -2181,7 +2181,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
> >>                         if (folio_test_pmd_mappable(folio))
> >>                                 count_vm_event(THP_FILE_ALLOC);
> >>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> -                       count_mthp_stat(folio_order(folio), MTHP_STAT_FILE_ALLOC);
> >> +                       count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
> >>  #endif
> >>                         goto alloced;
> >>                 }
> >> --
> >> 2.43.0
> >>
> >

Thanks
Barry

