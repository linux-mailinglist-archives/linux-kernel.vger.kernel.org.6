Return-Path: <linux-kernel+bounces-245846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D292BA68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C940284CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD80C158875;
	Tue,  9 Jul 2024 13:03:01 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147715699E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530181; cv=none; b=geeoC7ohuQlG5RaFDXCnkWYAS/N3vEz+OHTEg6bSyPZW7qx1oNfSuqrNdiD/fuP3tOrEh13SNcFXCpk63ZPIVDJnsl/w/d9x4BsxlKI6uggaDRXjmcbpDwQ/9EDUv3eawh1Vxu/tu/q+CwAcu7Y3uQeDMsVHT1nkXjN97EPYk0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530181; c=relaxed/simple;
	bh=n7j9ooaiLsbwoKvpFEKHF9cKgUwC9R3TbhHjZiZFYUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOgjMS/6V+TU/MnMshyVCiAYRnyYYORef6Yr7Qi8R+L9V7ZVNDQtH8nGEuUP47EZx6WBkItEVA+Pw4DjBDmM5tSDGwAg7o1B1hHsP/WmWWuVpgdDBVky2StZesB6r77R6jvMSyQ0d5NfED29UDXiTAhP3OnuWg0fnLyo2yImAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48fdf2d5309so1698722137.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530178; x=1721134978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMi7us1d4l4SwS+BzMlANRr5BsQBfw+Uxq4fBAlUSPM=;
        b=LSWd2ipvH4iDuBPIS7oH018uMrKLgkCbdq8gT3T5redHPBO9VnoceD5BEYplMFSiJX
         cPm5xjaKOhWGBirqXVQJKKzOfnlhU1etFW2Ke0qQqoedfRss0VdfjOMrgDH78xySJcPy
         6H+bqZhJcsFRueF87bGIFBm2lcnT+tQVBSAkoZz7YG9C35BFGDqToI8Alr9++x12vYAY
         2WotDZzPs0N4sd+BSs7/+nAueKIPl+/gx/XVDzF8MrI+0dfdIaY+/zBTI1kWSVSPdhQY
         6moBA4dlvpESg5JILTuonuLZgAOrP/bPnBAV60WYa4RG05uiTVvfPXa3R3fqCEF9bZsZ
         Gkaw==
X-Forwarded-Encrypted: i=1; AJvYcCWIjeksMpOfKNOwV7WYez4toW2aV0Cqi4c2KN/wlfLJzWOAU1dcO34CjXfyNWv/0BlgeKrLEXJY84v8VhbBbSVjXuSfB/N7sw6uNwYY
X-Gm-Message-State: AOJu0Yw22+VHo57rGFeYF4GZiM61CKAYNNusso3T7OltXpVmeCDc/jEf
	HCXZR9KUiBYQV0ALA7m6biO8VIr0O/psCPPfu75o1Cp1SsKyukJNiNTyKtFEgvICSzzkViA4XU7
	9J/GbQ1AvwUrIQuya9AmTPDIdM5w=
X-Google-Smtp-Source: AGHT+IH1DUYHkvESitkatNt9z8R+LNiPwJYkZABrwfIcxNbp5gyHkiGQMCZMExTRkccnJg7pFIdkBN6IrWrox6EkwPs=
X-Received: by 2002:a05:6102:fa9:b0:48f:1763:c389 with SMTP id
 ada2fe7eead31-4903222af4bmr2398604137.35.1720530178226; Tue, 09 Jul 2024
 06:02:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709123115.117-1-justinjiang@vivo.com>
In-Reply-To: <20240709123115.117-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 9 Jul 2024 21:02:45 +0800
Message-ID: <CAGsJ_4x1+T9+=WydkjsQmetGFOqzkOvhqQim5UOzytof5XHQ_g@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 8:31=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com> =
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

You should have collected tags such as reviewed-by, acked-by you got in v6
while sending v7.

Again,
Acked-by: Barry Song <baohua@kernel.org>

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

