Return-Path: <linux-kernel+bounces-246876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BDD92C852
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6424E282E28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7AB660;
	Wed, 10 Jul 2024 02:13:10 +0000 (UTC)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A1B647
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577590; cv=none; b=c5uQLIRG+xcR0QKmfwqAgp3FeiUvzYyiKSOW4NckT+NhyqffI7RH2AOjl4HSWeKW4VrM9q4/PxmtpUo8j4lfO7IGuUXk8QCBg5n9FfXyBkEizYRiEJ0lRuKGs5cq+WsJ9NR6EzsZGPccH3s9fTqulgVraZYZzdg3tZS7lxXs9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577590; c=relaxed/simple;
	bh=9AL8RAQ+HOvWA82eH+jIAK/iCkWlhaanrde398FkkHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0UjkXPEpPSJnZmmq/JEQR5wks0plPfTwTtXGuDNobPX3Mss8qBZ9uwzrHN/VabwYuPsGhz7jRfragsLDVr7NWPS2/WMAyH0/kco0VpDh7vbABFagxZsXHELAlzf6+0Ans4+/G7KLpcFqKLeGJs+U/FnXIGRGa7z/VD5KoHDkJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-81022501a12so207337241.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 19:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720577587; x=1721182387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap0RCxSh+qYkkw7U7sBwAd2BA+YT7I3M9TuJr/Weh2w=;
        b=ArNQhIBmCpCmnSPSwyYnRlChJoEYw0sqwGxkQ8tXjvPlAi7kaAT2hyTZoUV6kDbxhz
         N3QpjtfmYq6WVxzkvDESf9GxtXcn8Ra3azua8VKXIN30cZfz4R3MjAGO8XwPu2j/D+GW
         ct7fHnnp+bms1qQ8T1/NkARzNjsmsMzBzO0zi3P+Y7yc0Kw6hGB98roXe2ETZ/DZUTsS
         jrL8C6AmLwrpdEN9ZM3Eqt1NVCXRXStUYKMBxHuL/wxEkPMmak11oqHt1JiWxgcLu5w8
         JUKCgjHHdAOzmI8M4ZXGLV0unet8wZgwvt2J83LE5Uh5Z2ChxPKJqEKlD0DfKmVBSRt/
         iNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMWYNlkVWIuJRCJeEwO0KokHTwvColmawlxa6V0RuLrO3ZoEWVulBloNr1zbfaIpdGtc9nzHwJnTzSyEHzwUssy3sdVVyh8XvxqB6k
X-Gm-Message-State: AOJu0Yx017jI+ERkYhVsaO/a8hhxKfQ6PtTuweqWh7hsZpLTSCbXemUc
	wdWBMuMaOaiNRxX2RMU4w/ATGmuHmUHux21nJZz1ea+TMdAp+BKP5fJhcO/YDjCaGvSOmwJ1Bqa
	zjT0VB6tNeFHjoPhqolY/+7DAubQ=
X-Google-Smtp-Source: AGHT+IHLtnhQt3WqlPwpzlThyK97GqekTQutkX585akKzUYeNrFdik1HjEO/wMxioxITvRTH7JA5DTb1d8iskmjlWXE=
X-Received: by 2002:a05:6102:2acf:b0:48f:e9f5:2e37 with SMTP id
 ada2fe7eead31-490332b056fmr2827139137.6.1720577587111; Tue, 09 Jul 2024
 19:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709123115.117-1-justinjiang@vivo.com>
In-Reply-To: <20240709123115.117-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 10 Jul 2024 14:12:55 +1200
Message-ID: <CAGsJ_4zXUg30Pm-ixmGvnNEBB7AOBesSPBjqe3pU81FmnHAZqA@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 12:31=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.com=
> wrote:
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
> ---
>
> Change log:
> v6->v7:
> 1.Modify tab indentation to space indentation of the continuation
> lines of the condition.
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
> [v6->v7]:
> 1.Matthew Wilcox <willy@infradead.org>
> You told me you'd fix the indentation.  You cannot indent both the
> continuation lines of the condition and the body of the if by one tab
> each!
> -->
> Modify tab indentation to space indentation of the continuation
> lines of the condition.
>
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
> index 88156deb46a6..bb9954773cce 100644
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
> +                   check_stable_address_space(vma->vm_mm)) &&

You didn't even pass the compilation stage because you're missing 'linux/oo=
m.h'.
It's quite disappointing because I believe in your idea, but you
didn't even build it
before sending.

@@ -75,6 +75,7 @@
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/mm_inline.h>
+#include <linux/oom.h>

> +                   folio_test_swapbacked(folio) &&
> +                   !folio_likely_mapped_shared(folio)) {
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

