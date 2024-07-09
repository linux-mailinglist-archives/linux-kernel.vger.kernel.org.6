Return-Path: <linux-kernel+bounces-245159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3D92AF17
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA97D1C21B30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C064D8286A;
	Tue,  9 Jul 2024 04:35:01 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64879374CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 04:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720499701; cv=none; b=Zz9aegAX2F0t64Sha1dl4NYct+zIgGusR5L4+Ju8kHQmh0gdkwvTFUgncw2hQYYI0J7gybi7vCObBvKKNqULcgip0VPcwhOR4w77Z4ccPaKyn7VAFsyc7grJ11FVeoNHZ7jJT6g8+EpQrHzqDHWP/SvDfzyENiK5n32kyEs5Gx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720499701; c=relaxed/simple;
	bh=6KMc4L2Jb340nsr2fxBwiWhxwgx3wkExkREWO74fMsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASJVqa5c8dLOm++nr4zqqxr41Kksmj/irna4f0tjXzbn54KDYL7pwSMRNJ1IM+dzdnbdchq6Ct1BLJM+UFpxKO44ZkNuPJSHtmShhmYX9DfFtKjOBi/ZpiLIxUggpirR7uWGSb4xY5XuSstPQbN4KVllzkVbxJI/gcMmgIyOIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-81013580bd5so1161809241.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 21:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720499698; x=1721104498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9pKSLhwlTEm+8wiCWId5W4uZXshj+1+rGTAOZQjYl0=;
        b=KWCrm3UzNUEMUtK1KDBGeEX6ug3G3JwwLt8Aq59anq1/ZsbCPHfsMJmSrXGFaXdwyM
         57oqsf+zP1uXJiF2uB3KV2xUrbBH9Yb3BpbLQ7xpK2KEBiWtmEEDBYD3iFvsbiN2Ykj9
         TyHSfjDeT2ZBo5QU3gPRtN2YG0fh7zGEJI+KSCYsec+l0ma0jdghjZj+lQG0TKxU+UV/
         ao3jGvLbIWcQ9zFMnhKnjhS1glqBWubLEOGgu7MuLP9nyJfX3w00+UAIqQzsSgxl8cVd
         Tm30k3cVc5lhMfgztjS76HfBLpIdgfzB2kEAwLegTWMHAXLOqI9uBkqiRTsZs6TsDwHq
         +0tA==
X-Forwarded-Encrypted: i=1; AJvYcCUwnIfexsmDIOGL/WqbotkZuY7TIFIE8m70vWKojVaynGgMmOaUc/pnOWQaPe3/E/eakOnaHdXcTCB5ZnHPALOs7MVqsf73EHhNsXCd
X-Gm-Message-State: AOJu0YyPypJccGfDfhb3zi/ZtRiVypaHLhB8/QhGz0kiKWCeVU3RrCNK
	o4iDQbELfRflA6kh8kj+QbzqavETN9HxmQBfhRxImPw4g2/3YRTQoKWVywouyy8ur4/hoEfUTwT
	smS/4JvQufeosp/S/qrXS1EhXiSS+/g==
X-Google-Smtp-Source: AGHT+IEGtuOs0WLNLxu0K/QwvOYqRoh8N0xrp3vaAAukrFFlb0qHmxF8wtp61DH/zYlXayLImn3mR4XCZg1LzJ+Nf3I=
X-Received: by 2002:a05:6102:f88:b0:48f:e7f7:6fe2 with SMTP id
 ada2fe7eead31-490321d32bfmr1258001137.35.1720499698102; Mon, 08 Jul 2024
 21:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709042122.631-1-justinjiang@vivo.com>
In-Reply-To: <20240709042122.631-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 9 Jul 2024 16:34:46 +1200
Message-ID: <CAGsJ_4xOpdruUK5EGLM31nCfgnvb5CLEiDqVYoJ2nN48mMwDAg@mail.gmail.com>
Subject: Re: [PATCH v6] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 4:21=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com> =
wrote:
>
> The releasing process of the non-shared anonymous folio mapped solely by
> an exiting process may go through two flows: 1) the anonymous folio is
> firstly is swaped-out into swapspace and transformed into a swp_entry
> in shrink_folio_list; 2) then the swp_entry is released in the process
> exiting flow. This will result in the high cpu load of releasing a
> non-shared anonymous folio mapped solely by an exiting process.
>
> When the low system memory and the exiting process exist at the same
> time, it will be likely to happen, because the non-shared anonymous
> folio mapped solely by an exiting process may be reclaimed by
> shrink_folio_list.
>
> This patch is that shrink skips the non-shared anonymous folio solely
> mapped by an exting process and this folio is only released directly in
> the process exiting flow, which will save swap-out time and alleviate
> the load of the process exiting.
>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>

LGTM,

Acked-by: Barry Song <baohua@kernel.org>

> ---
>
> Change log:
> v5->v6:
> 1.Move folio_likely_mapped_shared() under the PTL.
> 2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
> 3.Remove folio_test_anon(folio).
> v4->v5:
> 1.Further modify to skip non-shared anonymous folio only.
> 2.Update comments for pra->referenced =3D -1.
> v3->v4:
> 1.Modify to skip only the non-shared anonymous folio mapped solely
> by an exiting process.
> v2->v3:
> Nothing.
> v1->v2:
> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> to compile in 32-bit system.
>
>
> Comments from participants and my responses:
> [v5->v6]:
> 1.David Hildenbrand <david@redhat.com>
> I'm currently working on moving all folio_likely_mapped_shared() under
> the PTL, where we are then sure that the folio is actually mapped by
> this process (e.g., no concurrent unmapping poisslbe). Can we do the
> same here directly?
> -->
> You are right. we might use page_vma_mapped_walk_done() to bail out.
> (Barry Song)
>
> 2.Barry Song <baohua@kernel.org>
> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
> &vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
> automatically has MMF_OOM_SKIP. What is the purpose of this check?
> Is there a better way to determine if a process is an OOM target?
> What about check_stable_address_space() ?
> -->
> Sorry, I overlook the situation with if (is_global_init(p)),
> MMF_OOM_SKIP is indeed not suitable. It seems feasible for
> check_stable_address_space() replacing MMF_OOM_SKIP.
> check_stable_address_space() can indicate oom kill, and
> !atomic_read(&vma->vm_mm->mm_users) can indicate the normal
> process exiting.
>
> I also think we actually can remove "folio_test_anon(folio)".
> -->
> Yes, update in patch v6.
>
> [v4->v5]:
> 1.Barry Song <baohua@kernel.org>
> I don't think this is correct. folio_likely_mapped_shared() is almost
> "correct" but not always.
> Please explain why you set  pra->referenced =3D  -1. Please address all
> comments before you send a new version.
> -->
> Update in patch v5.
>
> 2.Matthew Wilcox <willy@infradead.org>
> How is the file folio similar?  File folios are never written to swap,
> and they'll be written back from the page cache whenever the filesystem
> decides it's a good time to do so.
> -->
> What do you mean is that the file folio will not have any relevant
> identifier left in memory after it is reclamed in the shrink flow,
> and it will not be released again during an exiting process? If that's
> the case, I think we only need the anon folio is skipped here.
>
> [v3->v4]:
> 1.Barry Song <baohua@kernel.org>
> This is clearly version 3, as you previously sent version 2, correct?
> -->
> Yes.
>
> Could you please describe the specific impact on users, including user
> experience and power consumption? How serious is this problem?
> -->
> At present, I do not have a suitable method to accurately measure the
> optimization benefit datas of this modifications, but I believe it
> theoretically has some benefits.
> Launching large memory app (for example, starting the camera) in multiple
> backend scenes may result in the high cpu load of the exiting processes.
>
> Applications?
> -->
> Yes, when system is low memory, it more likely to occur.
>
> I'm not completely convinced this patch is correct, but it appears to be
> heading in the right direction. Therefore, I expect to see new versions
> rather than it being dead.
> You changed the file mode to 755, which is incorrect.
> -->
> Solved.
>
> Why use -1? Is this meant to simulate lock contention to keep the folio
> without activating it? Please do have some comments to explain why.
> I'm not convinced this change is appropriate for shared folios. It seems
> more suitable for exclusive folios used solely by the exiting process.
> -->
> The skiped folios are FOLIOREF_KEEP and added into inactive lru, beacase
> the folios will be freed soon in the exiting process flow.
> Yes, the shared folios can not be simply skipped. I have made relevant
> modifications in patch v4 and please help to further review.
> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo.co=
m/
>
> 2.David Hildenbrand <david@redhat.com>
> but what if it is shared among multiple processes and only one of them
> is exiting?
> -->
> Modify to skip only the non-shared anonymous folio mapped solely
> by an exiting process in next version v4.
>
> [v2->v3:]
> Nothing.
>
> [v1->v2]:
> 1.Matthew Wilcox <willy@infradead.org>
> What testing have you done of this patch?  How often does it happen?
> Are there particular workloads that benefit from this?  (I'm not sure
> what "mutil backed-applications" are?)
> And I do mean specifically of this patch, because to my eyes it
> shouldn't even compile. Except on 32-bit where it'll say "warning:
> integer constant out of range".
> -->
> Yes, I have tested. When the low system memory and the exiting process
> exist at the same time, it will happen. This modification can alleviate
> the load of the exiting process.
> "mutil backed-applications" means that there are a large number of
> the backend applications in the system.
> The VM_EXITING added in v1 patch is removed, because it will fail
> to compile in 32-bit system.
>
>  mm/rmap.c   | 14 ++++++++++++++
>  mm/vmscan.c |  7 ++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 88156deb46a6..d8ecb918e59e 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *folio=
,
>                         continue;
>                 }
>
> +               /*
> +                * Skip the non-shared swapbacked folio mapped solely by
> +                * the exiting or OOM-reaped process. This avoids redunda=
nt
> +                * swap-out followed by an immediate unmap.
> +                */
> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +                       check_stable_address_space(vma->vm_mm)) &&
> +                       folio_test_swapbacked(folio) &&
> +                       !folio_likely_mapped_shared(folio)) {
> +                       pra->referenced =3D -1;
> +                       page_vma_mapped_walk_done(&pvmw);
> +                       return false;
> +               }
> +
>                 if (pvmw.pte) {
>                         if (lru_gen_enabled() &&
>                             pte_young(ptep_get(pvmw.pte))) {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 80f9a486cf27..1d5f78a3dbeb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -863,7 +863,12 @@ static enum folio_references folio_check_references(=
struct folio *folio,
>         if (vm_flags & VM_LOCKED)
>                 return FOLIOREF_ACTIVATE;
>
> -       /* rmap lock contention: rotate */
> +       /*
> +        * There are two cases to consider.
> +        * 1) Rmap lock contention: rotate.
> +        * 2) Skip the non-shared swapbacked folio mapped solely by
> +        *    the exiting or OOM-reaped process.
> +        */
>         if (referenced_ptes =3D=3D -1)
>                 return FOLIOREF_KEEP;
>
> --
> 2.39.0
>

