Return-Path: <linux-kernel+bounces-244909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB292AB4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D37283579
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EAE14B959;
	Mon,  8 Jul 2024 21:34:58 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA2149C6A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474497; cv=none; b=Ybq5Vi89cFfaSHaloaTy9b3hjkLpuMj2Erwfl69/vGFYBKm8k6BRUj/lVMS6egTD4hGjERrCUm+qIkm6g3840PSTLc2Vjzn6Y30Ry7TsGqqGTufVLleaXEpjk92eIh9TaOOUD+vITtrfH3pHFCutks9RRfa8Zza27hN3ZCn2hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474497; c=relaxed/simple;
	bh=dxEY6Jcg3xyKHW2Maw/UPdGRJI3In1Fv/yamlS9g/tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3Rriqm2aR4OYnHXMqOEEPoDlPyxncHh1IhbcQyg4IHZQGd/o/fzxJGJGa0ummFMNtqlcCV5l9DoaXD2/lXb0yECe9RANmeMpuppajfjLEAvOZf8j3TRSqb0fJqUDqIbZuquyZTQDSutWnEVG0pFIBlR8g9MwXI/dBF4tCfkBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48fe9381454so2374625137.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 14:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474494; x=1721079294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFhnV5KJxxo4N1WnwlDGnMUQsfNE/JI9ypR7AtiPbkU=;
        b=RjdfFNwXa4ZPW1Uk7MhSiNRGKxB7qCWKOUPKwU5kYZpf49/XP5BU5jvKA/XzLN+IcP
         znm+0Od5g6dJIRACB9HGQhWcgtI49XofsmsFiXV1ojK2mC8DofOU2H9WRhGZybowXceG
         ixlCvlPtcSLY/JW4rOSc6O+hKr7IfBaI5cfBGxuU+1GO+vL1fhABc6WqbNrTzjzRZ9Ml
         yyO/h5p2S+9PizjYhINiwdS4+cVZ3QhWwlqrwffcYiLS1VeuDT+VUMABGgT8bW0sx0UU
         dG8zWS2a4g1yvLIj1peQgeU54kEIwR9APDvk13owTe+GMfVtu3FpCBXHyvTGQ7S/PNN+
         eKVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/2DSJHPyC8uaK3QzRzSDlXdJAQFzuu6RV/AmpCPKIcQPFfd2rLzzYQpKfJSeGkIk2TaBDGQ/cPEVdIVDwuSwPkFZGiDL471WGYFQ6
X-Gm-Message-State: AOJu0Yw8DaWIdgCEHaNK+YJZHVz8SsXBE199b3OaLjxkL0iLoOy2cpWG
	1/A3EetvCwxJ3j52QEoVfp8u8D2W7ZxfkQ8aIXFkWnL1I3ZfFNSWNvX//76GFhHSpj8rnVYm7uK
	wSlWPasDMxufXNHF6UnlLKhQ9Ip4=
X-Google-Smtp-Source: AGHT+IEpXynBb6aFguiwD0qTNstWNUzPyQU1RvKkv9S1j86ZSg61lCV0xMV3MiqmtkAzC6wdK+YdLTD3e2hWx1PrQkU=
X-Received: by 2002:a05:6102:4b83:b0:48f:b5c1:7269 with SMTP id
 ada2fe7eead31-49032ff4e42mr358919137.0.1720474494331; Mon, 08 Jul 2024
 14:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090413.888-1-justinjiang@vivo.com> <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
 <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com> <4ca9836c-4f03-4792-9be8-f7db71a2b162@vivo.com>
 <CAGsJ_4xMrzTfAC8wicK1-CLftXY-Bm+mZ8BnD=ZvtmB_NKzbKA@mail.gmail.com> <cf6c6d1f-3719-4744-b943-5c572d0d5fb4@vivo.com>
In-Reply-To: <cf6c6d1f-3719-4744-b943-5c572d0d5fb4@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 9 Jul 2024 09:34:43 +1200
Message-ID: <CAGsJ_4wE9pZoGoWoJD6R09uAppNqeycUdFUy0E8ZSUi4VcwaMQ@mail.gmail.com>
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:11=E2=80=AFAM zhiguojiang <justinjiang@vivo.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/7/8 20:41, Barry Song =E5=86=99=E9=81=93:
> >
> >
> > zhiguojiang <justinjiang@vivo.com> =E4=BA=8E 2024=E5=B9=B47=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=8C 00:25=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> >     =E5=9C=A8 2024/7/8 20:17, zhiguojiang =E5=86=99=E9=81=93:
> >     >
> >     >
> >     > =E5=9C=A8 2024/7/8 19:02, Barry Song =E5=86=99=E9=81=93:
> >     >> On Mon, Jul 8, 2024 at 9:04=E2=80=AFPM Zhiguo Jiang <justinjiang=
@vivo.com>
> >     >> wrote:
> >     >>> The releasing process of the non-shared anonymous folio mapped
> >     >>> solely by
> >     >>> an exiting process may go through two flows: 1) the anonymous
> >     folio is
> >     >>> firstly is swaped-out into swapspace and transformed into a
> >     swp_entry
> >     >>> in shrink_folio_list; 2) then the swp_entry is released in the
> >     process
> >     >>> exiting flow. This will increase the cpu load of releasing a
> >     non-shared
> >     >>> anonymous folio mapped solely by an exiting process, because
> >     the folio
> >     >>> go through swap-out and the releasing the swapspace and swp_ent=
ry.
> >     >>>
> >     >>> When system is low memory, it is more likely to occur, because
> >     more
> >     >>> backend applidatuions will be killed.
> >     >>>
> >     >>> The modification is that shrink skips the non-shared anonymous
> >     folio
> >     >>> solely mapped by an exting process and the folio is only releas=
ed
> >     >>> directly in the process exiting flow, which will save swap-out
> >     time
> >     >>> and alleviate the load of the process exiting.
> >     >>>
> >     >>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> >     >>> ---
> >     >>>
> >     >>> Change log:
> >     >>> v4->v5:
> >     >>> 1.Modify to skip non-shared anonymous folio only.
> >     >>> 2.Update comments for pra->referenced =3D -1.
> >     >>> v3->v4:
> >     >>> 1.Modify that the unshared folios mapped only in exiting task
> >     are skip.
> >     >>> v2->v3:
> >     >>> Nothing.
> >     >>> v1->v2:
> >     >>> 1.The VM_EXITING added in v1 patch is removed, because it will
> >     fail
> >     >>> to compile in 32-bit system.
> >     >>>
> >     >>>   mm/rmap.c   | 13 +++++++++++++
> >     >>>   mm/vmscan.c |  7 ++++++-
> >     >>>   2 files changed, 19 insertions(+), 1 deletion(-)
> >     >>>
> >     >>> diff --git a/mm/rmap.c b/mm/rmap.c
> >     >>> index 26806b49a86f..5b5281d71dbb
> >     >>> --- a/mm/rmap.c
> >     >>> +++ b/mm/rmap.c
> >     >>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct
> >     folio
> >     >>> *folio,
> >     >>>          int referenced =3D 0;
> >     >>>          unsigned long start =3D address, ptes =3D 0;
> >     >>>
> >     >>> +       /*
> >     >>> +        * Skip the non-shared anonymous folio mapped solely by
> >     >>> +        * the single exiting process, and release it directly
> >     >>> +        * in the process exiting.
> >     >>> +        */
> >     >>> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
> >     >>> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> >     >>> +               folio_test_anon(folio) &&
> >     >>> folio_test_swapbacked(folio) &&
> >     >>> + !folio_likely_mapped_shared(folio)) {
> >     >>> +               pra->referenced =3D -1;
> >     >>> +               return false;
> >     >>> +       }
> >     >>> +
> >     >>>          while (page_vma_mapped_walk(&pvmw)) {
> >     >>>                  address =3D pvmw.address;
> >     > Sure, I agree with your modification suggestions. This way,
> >     using PTL
> >     > indeed sure
> >     > that the folio is mapped by this process.
> >     > Thanks
> >     >> As David suggested, what about the below?
> >     >>
> >     >> @@ -883,6 +870,21 @@ static bool folio_referenced_one(struct fol=
io
> >     >> *folio,
> >     >>                          continue;
> >     >>                  }
> >     >>
> >     >> +               /*
> >     >> +                * Skip the non-shared anonymous folio mapped
> >     solely by
> >     >> +                * the single exiting process, and release it
> >     directly
> >     >> +                * in the process exiting.
> >     >> +                */
> >     >> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
> >     >> + test_bit(MMF_OOM_SKIP,
> >     >> &vma->vm_mm->flags)) &&
> >     >> + folio_test_anon(folio) &&
> >     >> folio_test_swapbacked(folio) &&
> >     >> + !folio_likely_mapped_shared(folio)) {
> >     >> +                       pra->referenced =3D -1;
> >     >> + page_vma_mapped_walk_done(&pvmw);
> >     >> +                       return false;
> >     >> +               }
> >     >> +
> >     >>                  if (pvmw.pte) {
> >     >>                          if (lru_gen_enabled() &&
> >     >> pte_young(ptep_get(pvmw.pte))) {
> >     >>
> >     >>
> >     >> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
> >     >> &vma->vm_mm->flags) is
> >     >> correct (I think it is wrong).   For example, global_init can
> >     >> directly have it:
> >     >>                  if (is_global_init(p)) {
> >     >>                          can_oom_reap =3D false;
> >     >>                          set_bit(MMF_OOM_SKIP, &mm->flags);
> >     >>                          pr_info("oom killer %d (%s) has mm
> >     pinned by
> >     >> %d (%s)\n",
> >     >> task_pid_nr(victim),
> >     >> victim->comm,
> >     >> task_pid_nr(p), p->comm);
> >     >>                          continue;
> >     >>                  }
> >     >>
> >     >> And exit_mmap() automatically has MMF_OOM_SKIP.
> >     >>
> >     >> What is the purpose of this check? Is there a better way to
> >     determine
> >     >> if a process is an
> >     >> OOM target? What about check_stable_address_space() ?
> >     > 1.Sorry, I overlook the situation with if (is_global_init(p)),
> >     > MMF_OOM_SKIP is indeed not suitable.
> >     >
> >     > 2.check_stable_address_space() can indicate oom_reaper, but it
> >     seems
> >     > unable to identify the situation where the process exits normally=
.
> >     > What about task_is_dying()? static inline bool
> >     task_is_dying(void) {
> >     > return tsk_is_oom_victim(current) ||
> >     fatal_signal_pending(current) ||
> >     > (current->flags & PF_EXITING); } Thanks
> >     We can migrate task_is_dying() from mm/memcontrol.c to
> >     include/linux/oom.h
> >     > static inline bool task_is_dying(void)
> >     > {
> >     >     return tsk_is_oom_victim(current) ||
> >     fatal_signal_pending(current) ||
> >     >         (current->flags & PF_EXITING);
> >     > }
> >
> >
> > no. current is kswapd.
> Hi Barry,
>
> It seems feasible for check_stable_address_space() replacing MMF_OOM_SKIP=
.
> check_stable_address_space() can indicate oom kill, and
> !atomic_read(&vma->vm_mm->mm_users)
> can indicate the normal process exiting.
>
>          /*
>           * Skip the non-shared anonymous folio mapped solely by
>           * the single exiting process, and release it directly
>           * in the process exiting.
>           */
>          if ((!atomic_read(&vma->vm_mm->mm_users) ||
>              check_stable_address_space(vma->vm_mm)) &&
>              folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>              !folio_likely_mapped_shared(folio)) {
>              pra->referenced =3D -1;
>              page_vma_mapped_walk_done(&pvmw);
>              return false;
>          }
>

Yes, + David, Willy (when you send a new version, please CC people who have
participated and describe how you have addressed comments from those
people.)

I also think we actually can remove "folio_test_anon(folio)".

So It could be,

@@ -883,6 +871,21 @@ static bool folio_referenced_one(struct folio *folio,
                        continue;
                }

+               /*
+                * Skip the non-shared swapbacked folio mapped solely by
+                * the exiting or OOM-reaped process. This avoids redundant
+                * swap-out followed by an immediate unmap.
+                */
+               if ((!atomic_read(&vma->vm_mm->mm_users) ||
+                    check_stable_address_space(vma->vm_mm)) &&
+                    folio_test_swapbacked(folio) &&
+                    !folio_likely_mapped_shared(folio)) {
+                       pra->referenced =3D -1;
+                       page_vma_mapped_walk_done(&pvmw);
+                       return false;
+               }
+
                if (pvmw.pte) {
                        if (lru_gen_enabled() &&
                            pte_young(ptep_get(pvmw.pte))) {

> Thanks
> Zhiguo
> >
> >
> >     >>
> >     >>
> >     >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >     >>> index 0761f91b407f..bae7a8bf6b3d
> >     >>> --- a/mm/vmscan.c
> >     >>> +++ b/mm/vmscan.c
> >     >>> @@ -863,7 +863,12 @@ static enum folio_references
> >     >>> folio_check_references(struct folio *folio,
> >     >>>          if (vm_flags & VM_LOCKED)
> >     >>>                  return FOLIOREF_ACTIVATE;
> >     >>>
> >     >>> -       /* rmap lock contention: rotate */
> >     >>> +       /*
> >     >>> +        * There are two cases to consider.
> >     >>> +        * 1) Rmap lock contention: rotate.
> >     >>> +        * 2) Skip the non-shared anonymous folio mapped solely=
 by
> >     >>> +        *    the single exiting process.
> >     >>> +        */
> >     >>>          if (referenced_ptes =3D=3D -1)
> >     >>>                  return FOLIOREF_KEEP;
> >     >>>
> >     >>> --
> >     >>> 2.39.0
> >     >>>
> >     >> Thanks
> >     >> Barry
> >     >
> >
>

Thanks
Barry

