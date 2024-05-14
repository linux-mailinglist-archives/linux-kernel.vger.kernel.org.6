Return-Path: <linux-kernel+bounces-178439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8518C4DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05011C212B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 08:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122B18E20;
	Tue, 14 May 2024 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8uaOrTz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0714267
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715675816; cv=none; b=PlmDOnLyolwKfrduJFWlbH2L1v8eXxTa2mulsykDOFdBpjqqcxCa2DAfuKA+2Ti7uVYThMkhP5h8xjUqknIR+0OTyzF9baSw5nQjWXsVuXH/xg0fRJ1Ndf8W4HPFW1WiN1zf8Zn0d2kuGFjtCvbKuFID61DgWk/qat4KlcXpD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715675816; c=relaxed/simple;
	bh=APHz6GqB7RdWzhkh2SQ81Fzt3zSZkB3wvP/t2YEGY1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1fMWZpnpdZVfcnsvtxkjOxUnTC6bWGvDvVUEFdoQLwhA2A96oK4rw9PB/P2vTXwpi67n5whaZ++CqAjF6vpPzRnQ86SG9+f4s3x4dY6yTNgTZ1SDqBYU9/pSBkppFE473+h3h5klT0Y3EaBWqrplzFjaEZVBZwRWs50yQR7UMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8uaOrTz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5731ffcc905so9828a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715675813; x=1716280613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ/eGTHdJFdkG3VlMLzx72gixE8FVhh6dK5QLaqRFCY=;
        b=N8uaOrTzrOtbOJOha+kYOelheCtv5X2j7QFBtpk17gZNzr317ITNBypQDGfYwvvLgK
         zbjYTCeJqlEJANNfsEtkbN7U7BIpeewgaSiSqW0xatS1y2R2VwEBPFDfriEFTA3ly/Yo
         XhcQeCFz6xOU1tCjuGyOE9kITXOg6PCxcWwdYX1td8PMStryFbA4GwqOUZs24nm+t0yH
         1wUdc6BhHA1QAWQJWdRZdUm0qT5ThdAuAQIqIWFz3ZlQj29vVv6EIiytLqDtxVdKsxwp
         HIMLN8hDBvXQgC2V7cLVkhs8PGUydgPR0W1k9iCdLUOtMwPm2jwV51rz2dp57oJcQX9Y
         W3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715675813; x=1716280613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJ/eGTHdJFdkG3VlMLzx72gixE8FVhh6dK5QLaqRFCY=;
        b=lNK8fzbQEVY3NcOnBW6H1TLeSt9LTjkRH5dUYNOIZ1uGIxTSZTi01TZfdi896H7l2H
         Es/R07TxmDtyuaUfTdRVRiMnszDR1wvO11oL2ijAWtWqA/2dbXTT2LXiBxW6OGL2srjD
         Ikf0ouIv/6+j3IOV2Knc1PhzCO1ZPvBg6aWRM9dkyW9+UdkqorSuzuXHRtAVPmdHYjui
         r9UX963IqfwsGvGBNJYo+16puFxKxjVrOKpqvpS50Ut1lZF1XtKW9fySpPGK7VNpvXmS
         C217ppY2l990hPbR3HyooJ7Qvnth6wZASdgXYIky0qGHiCFx+huO3vVIRwX0UYOaymky
         3Mbg==
X-Forwarded-Encrypted: i=1; AJvYcCWVSugqdMaJEHpIPD3iDROogUngo7/XAkDKjFY0lOEhMFoT80wCN2MJZZ1UCSpOuxvm7PUmM+u6IgPpbVsW4ykBOgHfvy88Ce1K7DEB
X-Gm-Message-State: AOJu0YxmWePHcY4OJLhCPlc/2YKxt3ZaGsmKswAokJIFjP0+umHFrzOg
	+W1dmPM0rAMABrbF7VRvz4g1CHangq65SypElwskjfV0BLfWJl8ofD52dIOycQTqEfL17s2lxLV
	pIZytz/98c1DAjqBQttP1F/u1I4U=
X-Google-Smtp-Source: AGHT+IFL6LmTzPmyUZ4HKJocx8V2LR8Ri2r66jvZdMmjAdm1Xlmf5hGSCM7pHC7zxxtjb5RDklqNdjEGNv/V8HFG9FM=
X-Received: by 2002:a50:8adb:0:b0:572:a22b:12db with SMTP id
 4fb4d7f45d1cf-5734d67f00fmr8930278a12.28.1715675813507; Tue, 14 May 2024
 01:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513074712.7608-1-ioworker0@gmail.com> <20240513074712.7608-5-ioworker0@gmail.com>
 <c8f52a60-94a4-48cc-be0c-824b26956934@linux.alibaba.com>
In-Reply-To: <c8f52a60-94a4-48cc-be0c-824b26956934@linux.alibaba.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 14 May 2024 16:36:42 +0800
Message-ID: <CAK1f24nUvOui=-v8VBZz8B_8HqXF0Yoo-JibvSXu_ab+rsW=ow@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 4/4] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com, david@redhat.com, 
	21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, libang.li@antgroup.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baolin,

Thanks for taking time to review!


On Tue, May 14, 2024 at 3:09=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/5/13 15:47, Lance Yang wrote:
> > When the user no longer requires the pages, they would use
> > madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
> > typically would not re-write to that memory again.
> >
> > During memory reclaim, if we detect that the large folio and its PMD ar=
e
> > both still marked as clean and there are no unexpected references
> > (such as GUP), so we can just discard the memory lazily, improving the
> > efficiency of memory reclamation in this case.
> >
> > On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Suggested-by: Zi Yan <ziy@nvidia.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/huge_mm.h |  9 +++++
> >   mm/huge_memory.c        | 75 ++++++++++++++++++++++++++++++++++++++++=
+
> >   mm/rmap.c               | 31 ++++++++++-------
> >   3 files changed, 103 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
> >
> >   void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long =
address,
> >                          pmd_t *pmd, bool freeze, struct folio *folio);
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio);
> >
> >   #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm=
_area_struct *vma,
> >                                        unsigned long address, pmd_t *pm=
d,
> >                                        bool freeze, struct folio *folio=
) {}
> >
> > +static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
> > +                                      unsigned long addr, pmd_t *pmdp,
> > +                                      struct folio *folio)
> > +{
> > +     return false;
> > +}
> > +
> >   #define split_huge_pud(__vma, __pmd, __address)     \
> >       do { } while (0)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 425272c6c50b..3ceeeb2f42d4 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2687,6 +2687,81 @@ static void unmap_folio(struct folio *folio)
> >       try_to_unmap_flush();
> >   }
> >
> > +static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
> > +                                    unsigned long addr, pmd_t *pmdp,
> > +                                    struct folio *folio)
> > +{
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     int ref_count, map_count;
> > +     pmd_t orig_pmd =3D *pmdp;
> > +     struct mmu_gather tlb;
> > +     struct page *page;
> > +
> > +     if (pmd_dirty(orig_pmd) || folio_test_dirty(folio))
> > +             return false;
> > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> > +             return false;
> > +
> > +     page =3D pmd_page(orig_pmd);
> > +     if (unlikely(page_folio(page) !=3D folio))
> > +             return false;
>
> The function is called under the ptl lock, so I have no idea why the pmd
> value can be changed, seems above validation is useless.

Yep. For the page reclaim path, page_vma_mapped_walk() will require
the PTL, and make sure the PMD mapping is unchanged via check_pmd().

But, IMO, we cannot assume that all callers always do the PMD mapping
check. I suggest keeping it to prepare for corner cases :)

>
> > +
> > +     tlb_gather_mmu(&tlb, mm);
>
> You missed tlb_finish_mmu() to do tlb flushing, and ...

Good spot!

>
> > +     orig_pmd =3D pmdp_huge_get_and_clear(mm, addr, pmdp);
> > +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, addr);
>
> I don't think tlb gather is helpful here, since you just flush one PMD
> entry. Just using pmdp_huge_clear_flush() seems enough.

Nice, thanks for the suggestion!

I completely agree that using pmdp_huge_clear_flush() is sufficient here :)

>
> > +
> > +     /*
> > +      * Syncing against concurrent GUP-fast:
> > +      * - clear PMD; barrier; read refcount
> > +      * - inc refcount; barrier; read PMD
> > +      */
> > +     smp_mb();
> > +
> > +     ref_count =3D folio_ref_count(folio);
> > +     map_count =3D folio_mapcount(folio);
> > +
> > +     /*
> > +      * Order reads for folio refcount and dirty flag
> > +      * (see comments in __remove_mapping()).
> > +      */
> > +     smp_rmb();
> > +
> > +     /*
> > +      * If the PMD or folio is redirtied at this point, or if there ar=
e
> > +      * unexpected references, we will give up to discard this folio
> > +      * and remap it.
> > +      *
> > +      * The only folio refs must be one from isolation plus the rmap(s=
).
> > +      */
> > +     if (ref_count !=3D map_count + 1 || folio_test_dirty(folio) ||
> > +         pmd_dirty(orig_pmd)) {
> > +             set_pmd_at(mm, addr, pmdp, orig_pmd);
>
> Should we also call 'folio_set_swapbacked()' if the folio was redirtied?

Yes. I forgot about that :)

Thanks again for the review!
Lance

>
> > +             return false;
> > +     }
> > +
> > +     folio_remove_rmap_pmd(folio, page, vma);
> > +     zap_deposited_table(mm, pmdp);
> > +     add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
> > +     if (vma->vm_flags & VM_LOCKED)
> > +             mlock_drain_local();
> > +     folio_put(folio);
> > +
> > +     return true;
> > +}
> > +
> > +bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long a=
ddr,
> > +                        pmd_t *pmdp, struct folio *folio)
> > +{
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +     VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
> > +
> > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +             return __discard_trans_pmd_locked(vma, addr, pmdp, folio)=
;
> > +
> > +     return false;
> > +}
> > +
> >   static void remap_page(struct folio *folio, unsigned long nr)
> >   {
> >       int i =3D 0;
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 08a93347f283..e09f2141b8dc 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1677,18 +1677,25 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >                       goto walk_done_err;
> >               }
> >
> > -             if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
> > -                     /*
> > -                      * We temporarily have to drop the PTL and start =
once
> > -                      * again from that now-PTE-mapped page table.
> > -                      */
> > -                     split_huge_pmd_locked(vma, range.start, pvmw.pmd,=
 false,
> > -                                           folio);
> > -                     pvmw.pmd =3D NULL;
> > -                     spin_unlock(pvmw.ptl);
> > -                     pvmw.ptl =3D NULL;
> > -                     flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > -                     continue;
> > +             if (!pvmw.pte) {
> > +                     if (unmap_huge_pmd_locked(vma, range.start, pvmw.=
pmd,
> > +                                               folio))
> > +                             goto walk_done;
> > +
> > +                     if (flags & TTU_SPLIT_HUGE_PMD) {
> > +                             /*
> > +                              * We temporarily have to drop the PTL an=
d start
> > +                              * once again from that now-PTE-mapped pa=
ge
> > +                              * table.
> > +                              */
> > +                             split_huge_pmd_locked(vma, range.start,
> > +                                                   pvmw.pmd, false, fo=
lio);
> > +                             pvmw.pmd =3D NULL;
> > +                             spin_unlock(pvmw.ptl);
> > +                             pvmw.ptl =3D NULL;
> > +                             flags &=3D ~TTU_SPLIT_HUGE_PMD;
> > +                             continue;
> > +                     }
> >               }
> >
> >               /* Unexpected PMD-mapped THP? */

