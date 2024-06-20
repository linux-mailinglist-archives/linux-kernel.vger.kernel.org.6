Return-Path: <linux-kernel+bounces-222264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE6490FEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230291C209C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1E1A3BD3;
	Thu, 20 Jun 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XExCbvbF"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A1EDB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872420; cv=none; b=Fd03zvZrpR/VVN60MHdT9BIITZQmT+RySCAfhGg4R5RyFoI4ZblwuxK1OKRgTO6bRrj6EdxTTGBZVW3C08wTXyFBnEWZ3SUyajcWRSYMiOYSOTksltyiJ1mTIGWGii6A9C+cB4ceA/Hp4wO1x6Xp3WCEELHawcKEDoRCbG3MBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872420; c=relaxed/simple;
	bh=mKIH8VnmavGZbtbsQSzKmnqw6Vs6IGl4hPjAk1+cbR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfSbKtivAujd1WWNmX1BcwKk43BX+7pLaNBoJ9+VBrZ3OcD6770AQ6O7UwFkI3ecwKzQ58wsQtBCdwU1C9ethX2RX/e1HNp4AkXxct7FcY9DXGylI85snc5lqwDQXu6S/aAbx9HPOOpVquli7Qaum9MC0//c8ofbEOtciWV5GJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XExCbvbF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b06b78e716so4010006d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718872418; x=1719477218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZbdM0CxTH317iSXQAcaPR6qww8Y1BrNhZlyqW4F0P8=;
        b=XExCbvbFPRdz3pP810TG6wI7yMsiippB0Vk+j0KuGz2Mx1dw21Un/YN1wIQKMF2xcf
         UXpH/6wDJ5aKn7cxc7b8sAovjWgPO5isrnhlGOB6OKDJ9+gfKACXvWcUTdbhl6nIhO8U
         bXT5/eF5zRnEGCS4DpIl2Wy2ZYpuIkBTYgTcu6wtdWviENBjmJJCx9v8ez8ISB6jdFHJ
         6DgWLl4Ve2sZgCMH/QW1ILf8rHLPj2+c0Vd9ERczJzodMSuAopUNKWqmxS+kqN5tS/1R
         pde976PtNgWeZ+uzfCE2SLiEFgcx8IDQZK2afBtB+KH/yifoCoHeNOMxl1OE+KRu+TuU
         hDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872418; x=1719477218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZbdM0CxTH317iSXQAcaPR6qww8Y1BrNhZlyqW4F0P8=;
        b=htv0GRIPi6UezWt4xjsQGWZ5iqOIdMLDHiJ4QhsvfeAethTQyUSjsNvPU7eak56M4K
         2HPilUGG1F1vai3knzVDKotWlBhLiaNSpZEJgCHjZjLHskh5d+P0Ww70AHn1m11odhvR
         n7r9m5IfF8x6aavgup2hzayQO76Ln6m5vLQX8CwFfk+c8uTB6t2gNHzGb27zADVMweU2
         w/Nnl6Ty9w15XUycpTzGTRvKSXFvCkyx6LwVaOMSExmMgG/7rIWJoyaNOdyWaIMlsMaU
         Ftk/rAMLXEeHscGjq8/WdqzXdixIFHwR93ZPNsPrYUPWikHZe32S8x4XO3NpM/QH1wk4
         shtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlLYZSXd34H5jAeHaKuC2WRMxiaFN9HRsJftVL+EmTFojGBArtSESi4yOgBN9eRrB9pwo4Jglhgq0TbcV+QZoPEVBe3NKBHdquNym1
X-Gm-Message-State: AOJu0YzbxEDIooyYhqWQH5a5fJ4xgHaeOHyscZrPP36dM1Lc+qYsQpK3
	n2HzLlZC4Slm+40JkK2SjQtpa9sk1x2uqr1phkJKLEM2PtchU7G/iCvKlNp7xoTW76CjgpBGuHf
	sKBa2p3T+AetZ5LhhXouGhrMqekk=
X-Google-Smtp-Source: AGHT+IHMXqSWRTBO6gCHHzNgpymBs/tO7JwH3tmswJuxf6bXw5SnGPcIDCXJ3dQmz1AYgwfT2a6e8Gu7aVFe4Vtri6M=
X-Received: by 2002:ad4:58b0:0:b0:6b0:7fc4:7744 with SMTP id
 6a1803df08f44-6b501e48e81mr44918136d6.29.1718872418029; Thu, 20 Jun 2024
 01:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617231137.80726-1-21cnbao@gmail.com> <20240617231137.80726-3-21cnbao@gmail.com>
 <f9cb01c2-967f-406c-9304-5e31a82b6b0f@redhat.com>
In-Reply-To: <f9cb01c2-967f-406c-9304-5e31a82b6b0f@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 20:33:26 +1200
Message-ID: <CAGsJ_4yuBJW578sL5dsKvWP2A=x54zV5b+qbwfy9vj8rFiQM1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==false
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Shuai Yuan <yuanshuai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:46=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 18.06.24 01:11, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > For the !folio_test_anon(folio) case, we can now invoke folio_add_new_a=
non_rmap()
> > with the rmap flags set to either EXCLUSIVE or non-EXCLUSIVE. This acti=
on will
> > suppress the VM_WARN_ON_FOLIO check within __folio_add_anon_rmap() whil=
e initiating
> > the process of bringing up mTHP swapin.
> >
> >   static __always_inline void __folio_add_anon_rmap(struct folio *folio=
,
> >                   struct page *page, int nr_pages, struct vm_area_struc=
t *vma,
> >                   unsigned long address, rmap_t flags, enum rmap_level =
level)
> >   {
> >           ...
> >           if (unlikely(!folio_test_anon(folio))) {
> >                   VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >                                    level !=3D RMAP_LEVEL_PMD, folio);
> >           }
> >           ...
> >   }
> >
> > It also improves the code=E2=80=99s readability. Currently, all new ano=
nymous
> > folios calling folio_add_anon_rmap_ptes() are order-0. This ensures
> > that new folios cannot be partially exclusive; they are either entirely
> > exclusive or entirely shared.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Tested-by: Shuai Yuan <yuanshuai@oppo.com>
> > ---
> >   mm/memory.c   |  8 ++++++++
> >   mm/swapfile.c | 13 +++++++++++--
> >   2 files changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 1f24ecdafe05..620654c13b2f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4339,6 +4339,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (unlikely(folio !=3D swapcache && swapcache)) {
> >               folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSI=
VE);
> >               folio_add_lru_vma(folio, vma);
> > +     } else if (!folio_test_anon(folio)) {
> > +             /*
> > +              * We currently only expect small !anon folios, for which=
 we now
> > +              * that they are either fully exclusive or fully shared. =
If we
> > +              * ever get large folios here, we have to be careful.
> > +              */
> > +             VM_WARN_ON_ONCE(folio_test_large(folio));
> > +             folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
> >       } else {
> >               folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addr=
ess,
> >                                       rmap_flags);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index ae1d2700f6a3..69efa1a57087 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1908,8 +1908,17 @@ static int unuse_pte(struct vm_area_struct *vma,=
 pmd_t *pmd,
> >               VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> >               if (pte_swp_exclusive(old_pte))
> >                       rmap_flags |=3D RMAP_EXCLUSIVE;
> > -
> > -             folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flag=
s);
> > +             /*
> > +              * We currently only expect small !anon folios, for which=
 we now that
> > +              * they are either fully exclusive or fully shared. If we=
 ever get
> > +              * large folios here, we have to be careful.
> > +              */
> > +             if (!folio_test_anon(folio)) {
> > +                     VM_WARN_ON_ONCE(folio_test_large(folio));
>
> (comment applies to both cases)
>
> Thinking about Hugh's comment, we should likely add here:
>
> VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>
> [the check we are removing from __folio_add_anon_rmap()]
>
> and document for folio_add_new_anon_rmap() in patch #1, that when
> dealing with folios that might be mapped concurrently by others, the
> folio lock must be held.

I assume you mean something like the following for patch#1?

diff --git a/mm/rmap.c b/mm/rmap.c
index df1a43295c85..20986b25f1b2 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1394,7 +1394,8 @@ void folio_add_anon_rmap_pmd(struct folio
*folio, struct page *page,
  *
  * Like folio_add_anon_rmap_*() but must only be called on *new* folios.
  * This means the inc-and-test can be bypassed.
- * The folio does not have to be locked.
+ * The folio doesn't necessarily need to be locked while it's
exclusive unless two threads
+ * map it concurrently. However, the folio must be locked if it's shared.
  *
  * If the folio is pmd-mappable, it is accounted as a THP.
  */
@@ -1406,6 +1407,7 @@ void folio_add_new_anon_rmap(struct folio
*folio, struct vm_area_struct *vma,
        int nr_pmdmapped =3D 0;

        VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+       VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);
        VM_BUG_ON_VMA(address < vma->vm_start ||
                        address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
        __folio_set_swapbacked(folio);


>
> > +                     folio_add_new_anon_rmap(folio, vma, addr, rmap_fl=
ags);
> > +             } else {
> > +                     folio_add_anon_rmap_pte(folio, page, vma, addr, r=
map_flags);
> > +             }
> >       } else { /* ksm created a completely new copy */
> >               folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE)=
;
> >               folio_add_lru_vma(folio, vma);
>
> --
> Cheers,
>
> David / dhildenb
>

