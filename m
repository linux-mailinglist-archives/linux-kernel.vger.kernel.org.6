Return-Path: <linux-kernel+bounces-402167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4099C249B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B891F21468
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3C9233D72;
	Fri,  8 Nov 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2Bi2FTO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA57233D64
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731089096; cv=none; b=IcK+FJHlTZupR8ngNobH7CKRCFhJlsnFLCm4F0zz+/BpcyK1PF89A85Ee/8z6/ZObFHhEKAzxHPyh00YONR/5mjdWhShFLbybU1yfQAG696Czt9onVP8YqkjI6doIrqYpr0I3qG1YyTz6lY6LvTtd0lsAo6kubzf9LIpuqmOwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731089096; c=relaxed/simple;
	bh=8AZVL9gMG6qybamE87HfK41H6Zu9BeLnnBaAKkRhhsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQPxwiZhMjxNy/v1re1pyRupd+c1WLaI0GJekQrIv9dM03XKl524Wpp5fuo41kqn0j6TelJQK/NVsXlh94jPdsv1QviX96u5ZAmOjz58I1zQsUtj8soiI0XsjYIXKKSCMKYtqzW/j4DXsv/o81RvbV7ne/0QYpZU4p/uCySV5TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2Bi2FTO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e19d8c41so897e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 10:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731089092; x=1731693892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY6MX6G2iuh1hwT0r0xv8GFRuWlJgXq9lNuDxr3taP8=;
        b=X2Bi2FTO3/Ehx/V1k1u4XuAmv69X33U2KgLRCX/ZtKzVitesJZDEgsGGQrj6QoXoau
         FXcPVfdCju+rReC0lEmVnQvx3s6d6U+jXbCiNUydvgdangjr+D6jj0/N6isg2eHEtYmV
         AcZGOZU1H0a61Sx8XPQW0axGviSZcfBrrui7oozxQnC89kJVLTIGTsP35vo8uByilvSW
         nF/Q17/DRvqgN8bBnrUepIznna75qbvIZQ0Hza/eJuZXup/cK+4MEvjckCVd2Q1DmHxY
         +tc5DY73ce58T30mAlR1amlIVmlxJt310XTlwinGIRQBxGUbqWaf9M4BNJgZqztTUhfG
         Nvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731089092; x=1731693892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY6MX6G2iuh1hwT0r0xv8GFRuWlJgXq9lNuDxr3taP8=;
        b=tWp1L9A0Y702GHFzjjpelM2SRL0dIfgxIKY+9kZjKUfJVgdkI93loToGPf9qQoRLPN
         nZJZhv9dRyEwuCACTvuYoGqc9mSvcLjQxqUG5ZBF7QZv2np5C/6UeMyBtxcz116KepCF
         wNAidOO62Wq6ZNHChevJGQcEAyDeKjZS8y2vzGuo/TN7PvvcvMjSEFJgCuNnouZ3EkaY
         eEhWHkkpgyoo1JXiR+5KyDiJ/Uk3fGRSctO2jhaglUEl/xtomzX02oyQlnlNB28An4zK
         hSVi76Fq6YlFY4GVvHE/bymkN8hhODgBWvs4KjPU9fByAgYBEJAJ52O83lwlp8UPG3nO
         pq8A==
X-Forwarded-Encrypted: i=1; AJvYcCUpctRDYElCHySysEbgw5EJ20Ab/h8G6Mmd6NBHxq6DCSzQbFQ+957Y2MVBOsC2uV0fot/FD29AS0n9DrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQA2VMzDhDmxu77CFj1D4ErpPPDshcgm6NTtakY0Mn/HILJrC
	SR4zpL88B4IXfgksxxeubdCIp5IUAgnhjT1NWRjbC6e1yGAcQKVToI02DEFEUOWKALmG9gRkN8K
	HGYzK0cH2Q9o1DaNPSrDYgumfBOuGtSCK8zMe
X-Gm-Gg: ASbGnctH6Yp0UaUIaIag9vtkq0MlBZlGvyU1C5QKTV+8ozmjr4Tq5HSyv7LDF5fBheJ
	CpfrCAyqMn+D9v9LJPRgCi32BjWRbfThqNuEIvmIuHWJBl2H97bWkpDcbiHs=
X-Google-Smtp-Source: AGHT+IGj2IqDXz+/Aet3CYfAPxn/D2mSXM68OjaFUwS87DjQkIufp1pkYuA8Lybz4NCssvKIyXdVwN+eL7wErfuawL8=
X-Received: by 2002:ac2:4d9a:0:b0:53c:75e8:a5c9 with SMTP id
 2adb3069b0e04-53d8122b836mr892006e87.4.1731089091827; Fri, 08 Nov 2024
 10:04:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <c0199a7d7097521bbc183739b1fa6793081d726b.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez0bv_y1k3cqMCsj0sJGPR4iK9zmHTa6124+N6i+s4+bTA@mail.gmail.com> <5d371247-853d-49ca-a28c-689a709905d4@bytedance.com>
In-Reply-To: <5d371247-853d-49ca-a28c-689a709905d4@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Nov 2024 19:04:15 +0100
Message-ID: <CAG48ez3sG_=G6gttsEZnvUE4J-yHEUqyaNQfsdXR-LT-EqY2Yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] mm: pgtable: try to reclaim empty PTE page in madvise(MADV_DONTNEED)
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 8:13=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
> On 2024/11/8 07:35, Jann Horn wrote:
> > On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedanc=
e.com> wrote:
> >> As a first step, this commit aims to synchronously free the empty PTE
> >> pages in madvise(MADV_DONTNEED) case. We will detect and free empty PT=
E
> >> pages in zap_pte_range(), and will add zap_details.reclaim_pt to exclu=
de
> >> cases other than madvise(MADV_DONTNEED).
> >>
> >> Once an empty PTE is detected, we first try to hold the pmd lock withi=
n
> >> the pte lock. If successful, we clear the pmd entry directly (fast pat=
h).
> >> Otherwise, we wait until the pte lock is released, then re-hold the pm=
d
> >> and pte locks and loop PTRS_PER_PTE times to check pte_none() to re-de=
tect
> >> whether the PTE page is empty and free it (slow path).
> >
> > How does this interact with move_pages_pte()? I am looking at your
> > series applied on top of next-20241106, and it looks to me like
> > move_pages_pte() uses pte_offset_map_rw_nolock() and assumes that the
> > PMD entry can't change. You can clearly see this assumption at the
> > WARN_ON_ONCE(pmd_none(*dst_pmd)). And if we race the wrong way, I
>
> In move_pages_pte(), the following conditions may indeed be triggered:
>
>         /* Sanity checks before the operation */
>         if (WARN_ON_ONCE(pmd_none(*dst_pmd)) || WARN_ON_ONCE(pmd_none(*sr=
c_pmd)) ||
>             WARN_ON_ONCE(pmd_trans_huge(*dst_pmd)) ||
> WARN_ON_ONCE(pmd_trans_huge(*src_pmd))) {
>                 err =3D -EINVAL;
>                 goto out;
>         }
>
> But maybe we can just remove the WARN_ON_ONCE(), because...
>
> > think for example move_present_pte() can end up moving a present PTE
> > into a page table that has already been scheduled for RCU freeing.
>
> ...this situation is impossible to happen. Before performing move
> operation, the pte_same() check will be performed after holding the
> pte lock, which can ensure that the PTE page is stable:
>
> CPU 0                    CPU 1
>
> zap_pte_range
>
>                         orig_src_pte =3D ptep_get(src_pte);
>
> pmd_lock
> pte_lock
> check if all PTEs are pte_none()
> --> clear pmd entry
> unlock pte
> unlock pmd
>
>                         src_pte_lock
>                         pte_same(orig_src_pte, ptep_get(src_pte))
>                         --> return false and will skip the move op

Yes, that works for the source PTE. But what about the destination?

Operations on the destination PTE in move_pages_pte() are, when moving
a normal present source PTE pointing to an order-0 page, and assuming
that the optimistic folio_trylock(src_folio) and
anon_vma_trylock_write(src_anon_vma) succeed:

dst_pte =3D pte_offset_map_rw_nolock(mm, dst_pmd, dst_addr,
&dummy_pmdval, &dst_ptl)
[check that dst_pte is non-NULL]
some racy WARN_ON_ONCE() checks
spin_lock(dst_ptl);
orig_dst_pte =3D ptep_get(dst_pte);
spin_unlock(dst_ptl);
[bail if orig_dst_pte isn't none]
double_pt_lock(dst_ptl, src_ptl)
[check pte_same(ptep_get(dst_pte), orig_dst_pte)]

and then we're past the point of no return. Note that there is a
pte_same() check against orig_dst_pte, but pte_none(orig_dst_pte) is
intentionally pte_none(), so the pte_same() check does not guarantee
that the destination page table is still linked in.

> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 002aa4f454fa0..c4a8c18fbcfd7 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -1436,7 +1436,7 @@ copy_page_range(struct vm_area_struct *dst_vma, =
struct vm_area_struct *src_vma)
> >>   static inline bool should_zap_cows(struct zap_details *details)
> >>   {
> >>          /* By default, zap all pages */
> >> -       if (!details)
> >> +       if (!details || details->reclaim_pt)
> >>                  return true;
> >>
> >>          /* Or, we zap COWed pages only if the caller wants to */
> >
> > This looks hacky - when we have a "details" object, its ->even_cows
> > member is supposed to indicate whether COW pages should be zapped. So
> > please instead set .even_cows=3Dtrue in madvise_dontneed_single_vma().
>
> But the details->reclaim_pt should continue to be set, right? Because
> we need to use .reclaim_pt to indicate whether the empty PTE page
> should be reclaimed.

Yeah, you should set both.

