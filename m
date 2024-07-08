Return-Path: <linux-kernel+bounces-244197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D6B92A0A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D2A281B4C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5556F2FB;
	Mon,  8 Jul 2024 11:03:05 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD681CA96
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436585; cv=none; b=a7DpQyB3cE4KX+Hfd9YxlqViq4zl41qIH4qO8hOQ50cV0h9zTAvieKC+1XyxvtTWOuMc/ochk1DIf6dqqrjkxUrrFMkNzSITqd3sxdWKcLKcMEQPiNHMsuI3mjXwRf8jUky1bAAUAjvEoZ7W+rwyI6+3DirHgJWsv6TVQ3+Xd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436585; c=relaxed/simple;
	bh=E41GT/AIzux5EUgqybGExy6hG+Bm9icf04Z6u5l3e3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOEu78vXBUWNeuA5APyG67dsofCum/m9FsJeXn8cmEVcJI1CeZr1FDc7iignR9m3KkufnbBamaUWtIfkt4OtFT71zY9e21z7qH0ytJK/doU+KpP7ReqHawtGD42QgKW2MBV3NElJdGXSb4LpPq7k2FyxUGoNPOifPB+T4jbQdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3cabac56b38so2501221b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720436583; x=1721041383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo4b9I6ylPe18YYNtc6T8gfq4Lk6GA+7kAUDRH8ZCsQ=;
        b=CCetITW9pyrNckPDMkITBq47cpqIUWNXA9GOFzrb4+HqDmm53qnHBIDBK8ZaoRHW5R
         5YDLz3VZjzWLCvXAeBn8s+2Upy+FhFteAsSQTG9XOr3UwQSyVqM1hvB/rbpq0p48nXhP
         Q3wG6pcv2a7kdfN6sdbOVwoCbIcwPV6ckXkucYrtzNjmnyOkyGzTM1tuqt4dXXjth48G
         ctpNY2Cj9gZoFO9t7Fs/gIfal/xZTpz9QJJh8dbmAtJxnVoQTID8PkNYHPV9utnZA1Ra
         wk6WvLhtRgASu37YLvaNxter6XLN1V3yS8836+77m7lMz6Li1zab/iPuTYRiCxYA8dZj
         hmTg==
X-Forwarded-Encrypted: i=1; AJvYcCV1XdEKqOnuGvSuCd7pW+LdvDyOpPR8ica+eu4+KQ0x6nnSefaWt3XiTnvp3Y8ZgM3Id6lHXlKIYaiS7XQwhfo5hjQc7uGwWBBAfi5A
X-Gm-Message-State: AOJu0Yy1dcw9MaIwjGunBudNgGau7CHlqmrue5vFQMRkp7lVADxztmaP
	bQOCC6Sv4x8Ldjqy5bbS4sjPia6hWVwJioKYw3NNuWbCUS3wD1N17McSvClq5Advce/wWAjNh/X
	fa7hSt/9TGKUo2N8Pq/5jGVYG1Zj6r8d1
X-Google-Smtp-Source: AGHT+IEcGrboi/x6BChRZ2eScFilwlGVYUMOXXFawTk+0g+q64HkG66lldwJx0EkghEqJmRQGNvgBIDXvf0GmkcMrDE=
X-Received: by 2002:a05:6808:f8f:b0:3d9:2dbe:e086 with SMTP id
 5614622812f47-3d92dbee509mr5212597b6e.19.1720436582556; Mon, 08 Jul 2024
 04:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090413.888-1-justinjiang@vivo.com>
In-Reply-To: <20240708090413.888-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 8 Jul 2024 23:02:51 +1200
Message-ID: <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:04=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com> =
wrote:
>
> The releasing process of the non-shared anonymous folio mapped solely by
> an exiting process may go through two flows: 1) the anonymous folio is
> firstly is swaped-out into swapspace and transformed into a swp_entry
> in shrink_folio_list; 2) then the swp_entry is released in the process
> exiting flow. This will increase the cpu load of releasing a non-shared
> anonymous folio mapped solely by an exiting process, because the folio
> go through swap-out and the releasing the swapspace and swp_entry.
>
> When system is low memory, it is more likely to occur, because more
> backend applidatuions will be killed.
>
> The modification is that shrink skips the non-shared anonymous folio
> solely mapped by an exting process and the folio is only released
> directly in the process exiting flow, which will save swap-out time
> and alleviate the load of the process exiting.
>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>
> Change log:
> v4->v5:
> 1.Modify to skip non-shared anonymous folio only.
> 2.Update comments for pra->referenced =3D -1.
> v3->v4:
> 1.Modify that the unshared folios mapped only in exiting task are skip.
> v2->v3:
> Nothing.
> v1->v2:
> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> to compile in 32-bit system.
>
>  mm/rmap.c   | 13 +++++++++++++
>  mm/vmscan.c |  7 ++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 26806b49a86f..5b5281d71dbb
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *folio=
,
>         int referenced =3D 0;
>         unsigned long start =3D address, ptes =3D 0;
>
> +       /*
> +        * Skip the non-shared anonymous folio mapped solely by
> +        * the single exiting process, and release it directly
> +        * in the process exiting.
> +        */
> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
> +               folio_test_anon(folio) && folio_test_swapbacked(folio) &&
> +               !folio_likely_mapped_shared(folio)) {
> +               pra->referenced =3D -1;
> +               return false;
> +       }
> +
>         while (page_vma_mapped_walk(&pvmw)) {
>                 address =3D pvmw.address;

As David suggested, what about the below?

@@ -883,6 +870,21 @@ static bool folio_referenced_one(struct folio *folio,
                        continue;
                }

+               /*
+                * Skip the non-shared anonymous folio mapped solely by
+                * the single exiting process, and release it directly
+                * in the process exiting.
+                */
+               if ((!atomic_read(&vma->vm_mm->mm_users) ||
+                                       test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags)) &&
+                               folio_test_anon(folio) &&
folio_test_swapbacked(folio) &&
+                               !folio_likely_mapped_shared(folio)) {
+                       pra->referenced =3D -1;
+                       page_vma_mapped_walk_done(&pvmw);
+                       return false;
+               }
+
                if (pvmw.pte) {
                        if (lru_gen_enabled() &&
                            pte_young(ptep_get(pvmw.pte))) {


By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
&vma->vm_mm->flags) is
correct (I think it is wrong).   For example, global_init can directly have=
 it:
                if (is_global_init(p)) {
                        can_oom_reap =3D false;
                        set_bit(MMF_OOM_SKIP, &mm->flags);
                        pr_info("oom killer %d (%s) has mm pinned by %d (%s=
)\n",
                                        task_pid_nr(victim), victim->comm,
                                        task_pid_nr(p), p->comm);
                        continue;
                }

And exit_mmap() automatically has MMF_OOM_SKIP.

What is the purpose of this check? Is there a better way to determine
if a process is an
OOM target? What about check_stable_address_space() ?


>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0761f91b407f..bae7a8bf6b3d
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
> +        * 2) Skip the non-shared anonymous folio mapped solely by
> +        *    the single exiting process.
> +        */
>         if (referenced_ptes =3D=3D -1)
>                 return FOLIOREF_KEEP;
>
> --
> 2.39.0
>

Thanks
Barry

