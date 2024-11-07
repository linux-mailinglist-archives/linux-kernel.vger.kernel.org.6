Return-Path: <linux-kernel+bounces-400425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E739C0D60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3538B22294
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095F216437;
	Thu,  7 Nov 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RebW+r9"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68596F31E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002276; cv=none; b=SOZMTkPP+Et91gt6yLW/ubKjvon0mtG4UYbygxw4PqFtkv8uHLFsDZP7+4yqpokBreLEJKTOeYQen8tn75zWY7aFDX/HFxVkZ/dyO6qgyooqVvHseKO+MnidyhvQO8q5zeDXSKI6reibnaA+8BpwJPSkPgSyFZNjjYrJfwIA9HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002276; c=relaxed/simple;
	bh=VoB9MfGuk6+qAT68f1maTKhpvuw2EgDtfRdK2uJxCHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ytc+LDoXkAy0tPc9Hw9sZE1J2EHPmsWLlmc386MI9lsyuQF3CHQ7dJnuSPG2dAzmxIYadKzHs+iqbb2LZ0f/sKccIhjZlOLocWctZjMC2pciv398PTgDzSqO3/Hm/Go841Z/H++YSg1do7XfS/FZCMZaxrDVd/8ieka0hBdlX24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RebW+r9; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so466a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731002273; x=1731607073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sYXU+J45JGzgakIJX/wtPY+rtwo4bAtMY/QuZ4Bgqw=;
        b=2RebW+r9ZQL8DUSnoP53qg59cwmAq35iJKW5yLkJP9JzXmjuZtXh7ty0+lzh8MQ3bd
         a1sHsEZZRXHCRJSz6wO2zP8Eb8VN+DSriBRM4ykAVGLjRrKXSjvLRuoQpONIa6y64RlY
         ce4b8R44mBzyUH9atOeaWtAQsAqshcb5LObhMDxTWsRpuO/r4d/Li7tAhuhnI/md/w32
         6kurk92tO9uTCoza4fyiRdvuNxwLcdQQ/O7+8YF8TrlqkKH96u6z1wqXOR3o80+bBSqG
         A7xf2hj5RTfnASWZ2zOaqzKseSFN5aQnOAIGN3Wt2QNKXzeUr/OZvbZM0FJZHF5sK7ew
         zBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002273; x=1731607073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sYXU+J45JGzgakIJX/wtPY+rtwo4bAtMY/QuZ4Bgqw=;
        b=Uu6R4OIAbhVP+eesNR3AYlhPkz0sDdeFMAhbjjLBLVyFBwOPoRSoeto5/CAjEX5l9d
         0Dry4s5dy7ItI1rsokprzg3JMqjyj5SoPP8iSjSzumJHN7a8E/d0YCtbLzs8gyyYq05C
         +idxlfDcmR6PW1LT3UDpUvgvB/eRo0VQCZ5Mj2eG0DmK7J5eVeYsBOeT+Ps0FJfRmcwq
         xmZ5tk10MeL1yciICMNuN0ynwjbtoXzZONoJRJPsRTl4IKfn62snkSw4i5Humrwq201R
         t2VjLuF4E1BApILkHIRWEk1v7pa0N10sprGF59jMQwz4a2IuC2sLw+bORRQ1zBgDwyzx
         u1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWoRyhAl0WHykcXGKyN9EI9ubgcKrxM1GXC7hGMXCtTl1oHtzbWCRrQ6muG333srrDzLIWL9PukLaUnoaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl3Dj9/PZ24XaAzS0J+x65RVS2swfSgQsxjvi/v+RMnb6ARvF0
	FqGB3Ttu7aS0PDtSmcd+WeomiLFOcyOs5a28Dv1J8kgS2UKWId3gBuz1+Dj3ElzfMyNz4UVkzQz
	OIUEQBvhaXVj/+wXEu4BV+URPPzdyxLC/wGWp
X-Gm-Gg: ASbGncvvAPwnHJYZnUQ/axMgpSwm+0C0IRJFScfGitopJiDorrsuv0njZm1dmRh0ups
	ZYXEXATieKsISzD19EpTqJIxum++kDavzI+dw/kAZGTr2XZnluTPdo8pQ84I=
X-Google-Smtp-Source: AGHT+IF4uMRfvJtFgKasRKvlG8BsbliKgjjtDjA52QF3a2NBjqsOaBKbvBrNSqoI/6Qa3egPGlHObZTcWDMjX7+5GGM=
X-Received: by 2002:a05:6402:1cb9:b0:5cb:6694:a4bd with SMTP id
 4fb4d7f45d1cf-5cefbc29fdamr691458a12.1.1731002272648; Thu, 07 Nov 2024
 09:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730360798.git.zhengqi.arch@bytedance.com>
 <4c3f4aa29f38c013c4529a43bce846a3edd31523.1730360798.git.zhengqi.arch@bytedance.com>
 <CAG48ez1S3nU0qzf6zZYAOTGO=RmK_2z+ZvHLzrpfamQ4uGK4hg@mail.gmail.com> <8c27c1f8-9573-4777-8397-929a15e67f60@bytedance.com>
In-Reply-To: <8c27c1f8-9573-4777-8397-929a15e67f60@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Nov 2024 18:57:16 +0100
Message-ID: <CAG48ez18QoQdJqBXo0FW9qw5CkTUFqKD8iZ195sFud0GPCRywQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mm: khugepaged: retract_page_tables() use pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: david@redhat.com, hughd@google.com, willy@infradead.org, mgorman@suse.de, 
	muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org, 
	zokeefe@google.com, rientjes@google.com, peterx@redhat.com, 
	catalin.marinas@arm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:54=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
> On 2024/11/7 05:48, Jann Horn wrote:
> > On Thu, Oct 31, 2024 at 9:14=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedanc=
e.com> wrote:
> >> In retract_page_tables(), we may modify the pmd entry after acquiring =
the
> >> pml and ptl, so we should also check whether the pmd entry is stable.
> >
> > Why does taking the PMD lock not guarantee that the PMD entry is stable=
?
>
> Because the pmd entry may have changed before taking the pmd lock, so we
> need to recheck it after taking the pmd or pte lock.

You mean it could have changed from the value we obtained from
find_pmd_or_thp_or_none(mm, addr, &pmd)? I don't think that matters
though.

> >> Using pte_offset_map_rw_nolock() + pmd_same() to do it, and then we ca=
n
> >> also remove the calling of the pte_lockptr().
> >>
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >> ---
> >>   mm/khugepaged.c | 17 ++++++++++++++++-
> >>   1 file changed, 16 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index 6f8d46d107b4b..6d76dde64f5fb 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -1721,6 +1721,7 @@ static void retract_page_tables(struct address_s=
pace *mapping, pgoff_t pgoff)
> >>                  spinlock_t *pml;
> >>                  spinlock_t *ptl;
> >>                  bool skipped_uffd =3D false;
> >> +               pte_t *pte;
> >>
> >>                  /*
> >>                   * Check vma->anon_vma to exclude MAP_PRIVATE mapping=
s that
> >> @@ -1756,11 +1757,25 @@ static void retract_page_tables(struct address=
_space *mapping, pgoff_t pgoff)
> >>                                          addr, addr + HPAGE_PMD_SIZE);
> >>                  mmu_notifier_invalidate_range_start(&range);
> >>
> >> +               pte =3D pte_offset_map_rw_nolock(mm, pmd, addr, &pgt_p=
md, &ptl);
> >> +               if (!pte) {
> >> +                       mmu_notifier_invalidate_range_end(&range);
> >> +                       continue;
> >> +               }
> >> +
> >>                  pml =3D pmd_lock(mm, pmd);
> >
> > I don't understand why you're mapping the page table before locking
> > the PMD. Doesn't that just mean we need more error checking
> > afterwards?
>
> The main purpose is to obtain the pmdval. If we don't use
> pte_offset_map_rw_nolock, we should pay attention to recheck pmd entry
> before pte_lockptr(), like this:
>
> pmdval =3D pmdp_get_lockless(pmd);
> pmd_lock
> recheck pmdval
> pte_lockptr(mm, pmd)
>
> Otherwise, it may cause the system to crash. Consider the following
> situation:
>
>      CPU 0              CPU 1
>
> zap_pte_range
> --> clear pmd entry
>      free pte page (by RCU)
>
>                        retract_page_tables
>                        --> pmd_lock
>                            pte_lockptr(mm, pmd)  <-- BOOM!!
>
> So maybe calling pte_offset_map_rw_nolock() is more convenient.

How about refactoring find_pmd_or_thp_or_none() like this, by moving
the checks of the PMD entry value into a separate helper:



-static int find_pmd_or_thp_or_none(struct mm_struct *mm,
-                                  unsigned long address,
-                                  pmd_t **pmd)
+static int check_pmd_state(pmd_t *pmd)
 {
-       pmd_t pmde;
+       pmd_t pmde =3D pmdp_get_lockless(*pmd);

-       *pmd =3D mm_find_pmd(mm, address);
-       if (!*pmd)
-               return SCAN_PMD_NULL;
-
-       pmde =3D pmdp_get_lockless(*pmd);
        if (pmd_none(pmde))
                return SCAN_PMD_NONE;
        if (!pmd_present(pmde))
                return SCAN_PMD_NULL;
        if (pmd_trans_huge(pmde))
                return SCAN_PMD_MAPPED;
        if (pmd_devmap(pmde))
                return SCAN_PMD_NULL;
        if (pmd_bad(pmde))
                return SCAN_PMD_NULL;
        return SCAN_SUCCEED;
 }

+static int find_pmd_or_thp_or_none(struct mm_struct *mm,
+                                  unsigned long address,
+                                  pmd_t **pmd)
+{
+
+       *pmd =3D mm_find_pmd(mm, address);
+       if (!*pmd)
+               return SCAN_PMD_NULL;
+       return check_pmd_state(*pmd);
+}
+


And simplifying retract_page_tables() a little bit like this:


        i_mmap_lock_read(mapping);
        vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
                struct mmu_notifier_range range;
                struct mm_struct *mm;
                unsigned long addr;
                pmd_t *pmd, pgt_pmd;
                spinlock_t *pml;
                spinlock_t *ptl;
-               bool skipped_uffd =3D false;
+               bool success =3D false;

                /*
                 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
                 * got written to. These VMAs are likely not worth removing
                 * page tables from, as PMD-mapping is likely to be split l=
ater.
                 */
                if (READ_ONCE(vma->anon_vma))
                        continue;

                addr =3D vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_S=
HIFT);
@@ -1763,34 +1767,34 @@ static void retract_page_tables(struct
address_space *mapping, pgoff_t pgoff)

                /*
                 * Huge page lock is still held, so normally the page table
                 * must remain empty; and we have already skipped anon_vma
                 * and userfaultfd_wp() vmas.  But since the mmap_lock is n=
ot
                 * held, it is still possible for a racing userfaultfd_ioct=
l()
                 * to have inserted ptes or markers.  Now that we hold ptlo=
ck,
                 * repeating the anon_vma check protects from one category,
                 * and repeating the userfaultfd_wp() check from another.
                 */
-               if (unlikely(vma->anon_vma || userfaultfd_wp(vma))) {
-                       skipped_uffd =3D true;
-               } else {
+               if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
                        pgt_pmd =3D pmdp_collapse_flush(vma, addr, pmd);
                        pmdp_get_lockless_sync();
+                       success =3D true;
                }

                if (ptl !=3D pml)
                        spin_unlock(ptl);
+drop_pml:
                spin_unlock(pml);

                mmu_notifier_invalidate_range_end(&range);

-               if (!skipped_uffd) {
+               if (success) {
                        mm_dec_nr_ptes(mm);
                        page_table_check_pte_clear_range(mm, addr, pgt_pmd)=
;
                        pte_free_defer(mm, pmd_pgtable(pgt_pmd));
                }
        }
        i_mmap_unlock_read(mapping);


And then instead of your patch, I think you can just do this?


@@ -1754,20 +1754,22 @@ static void retract_page_tables(struct
address_space *mapping, pgoff_t pgoff)
                 */
                if (userfaultfd_wp(vma))
                        continue;

                /* PTEs were notified when unmapped; but now for the PMD? *=
/
                mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
                                        addr, addr + HPAGE_PMD_SIZE);
                mmu_notifier_invalidate_range_start(&range);

                pml =3D pmd_lock(mm, pmd);
+               if (check_pmd_state(mm, addr, pmd) !=3D SCAN_SUCCEED)
+                       goto drop_pml;
                ptl =3D pte_lockptr(mm, pmd);
                if (ptl !=3D pml)
                        spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);

                /*
                 * Huge page lock is still held, so normally the page table
                 * must remain empty; and we have already skipped anon_vma
                 * and userfaultfd_wp() vmas.  But since the mmap_lock is n=
ot
                 * held, it is still possible for a racing userfaultfd_ioct=
l()
                 * to have inserted ptes or markers.  Now that we hold ptlo=
ck,

