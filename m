Return-Path: <linux-kernel+bounces-246902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E39192C8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C940E1C21FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A917BDA;
	Wed, 10 Jul 2024 02:42:08 +0000 (UTC)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB42B9DD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720579327; cv=none; b=RfUlZOwSAtv6O8KVccpms4XObRUVvgZlVLAvFTHfgEpaZYpnDdQfJjdc4sSKqxIzXELrCQ3RALIhT9dVFyOLFPEnpMX0Y0wDD65oARyBz34onUzqXAV34YvQSsEOOEqF59JL9kxTx3HMvTW2DSUcYLbkzA+W5ciXaBy1FxIVuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720579327; c=relaxed/simple;
	bh=oENZ2ijCtfknGkqGLMkKWLDUU2OvQ4yjqpz1WmUBlGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRWnDCj8mSzuZfuWCCFuGMh0nPMLfomsHIG0eyTVFNyAnx1V1KDr0ANmXp1S2E57aSzRZ8aAd/ffSOFweq/38lSBRpYWMprIEMkW5eezBUoORbIWAhL3OUkxXkG/CXm8ilGPPGmsarV+XVYoqv78ME/kfwPMfKa3KEHE7APJpjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-48ffa17fa2fso1362355137.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 19:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720579324; x=1721184124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLQcepiuA2+08kDxrKNHP4HLyj6kWoZhkBHfDgRJmlk=;
        b=IQp2XisdG8Z5mq9yAGW0gNRP7lfLlonZHW8tldKeV6rN88Euu27UiNkv+0Tnfq9+1n
         cyrzX24v92EVex0nzf8Ad6BbOiPR8jwe2rhlF+whM4fSbbmgSihlLxL7Bsav1C2U3x23
         PvAivT7UFYGs2JUmHxpb0nU9eJ/UEUWn6rOOI1APMC2sTkmYzoMHvp+jvlPaD1tEj8AF
         LVMlN9W8sMRly7SfBsCir2qjyxEcuA45vmDF/Me5gKFxKG5LfAdFfLCV6zZwiEWvOy3C
         wdnjPCjOyXm01x4QGPQCkb2zDh8PvWkvQsgDdUm5jUc5w7jcYG/Cgc5i+ZDI2d611xi9
         QzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtquxMxLtFXcBT8hi5uHXe9Y5kLv/XsTET+Z7paz2kWwWO+3dA8P3EkHqg17IEXDfd4XYqbL5gW1be9KDaF5ynYkEZ4bn96X3GZiYR
X-Gm-Message-State: AOJu0YwTWe6M1y29V1bxhZDOHZLBIXRI0Q1kuMxrTu/chNoKMG9znAGm
	w5YLHCoRYU/28sgaqWUmTVgqRSEvV8BCnZ9Mp5KaIscMqmltgP5uPQ3lRX64e2SJS6NqRz/Q8gm
	7PQpV/F+0rGg4Y+V/UWH8rSPvdfM=
X-Google-Smtp-Source: AGHT+IHe87NT6SDA8L+fAdauoyqinBJbnOsL3YD7Zho+pUVlaGiRZV4Cnph5YnlZfbiFhG5ERnXCFjD2JUxJu6baM58=
X-Received: by 2002:a05:6102:508d:b0:48f:96a8:fa33 with SMTP id
 ada2fe7eead31-4903210cd2fmr4384623137.11.1720579324202; Tue, 09 Jul 2024
 19:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710023901.1624-1-justinjiang@vivo.com>
In-Reply-To: <20240710023901.1624-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 10 Jul 2024 14:41:53 +1200
Message-ID: <CAGsJ_4yX5K3ytepCAqRbHfiEUKGxApvSin0d2ohK3ohGu7CfTg@mail.gmail.com>
Subject: Re: [PATCH v8] mm: shrink skip folio mapped by an exiting process
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:39=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.com>=
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
> Reviewed-by: Matthew Wilcox <willy@infradead.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

No, this is a disaster. Please ask someone for help before you send it.
Neither Willy nor David has ever posted any Reviewed-by tags.
Please do get someone to help you. Stop posting like this!


> Acked-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>
> Change log:
> v7->v8:
> 1.Add tags of Reviewed-by and Acked-by.
> 2.Add #include <linux/oom.h> to solve compilation issue.
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
> Comments from participants and my responses:
> [v7->v8]:
> 1.Barry Song <baohua@kernel.org>
> You should have collected tags such as reviewed-by, acked-by you got in
> v6 while sending v7.
> -->
> Added in patch v8.
>
> You didn't even pass the compilation stage because you're missing
> 'linux/oom.h'. It's quite disappointing because I believe in your idea,
> but you didn't even build it before sending.
> -->
> Sorry, I overlooked the compilation of folio_likely_mapped_shared() added
> in patch v5. Compiled and Updated have been compeleted in patch v8.
>
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
>  mm/rmap.c   | 15 +++++++++++++++
>  mm/vmscan.c |  7 ++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 mm/rmap.c
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 26806b49a86f..5b92c3dadcc2 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -75,6 +75,7 @@
>  #include <linux/memremap.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/mm_inline.h>
> +#include <linux/oom.h>
>
>  #include <asm/tlbflush.h>
>
> @@ -870,6 +871,20 @@ static bool folio_referenced_one(struct folio *folio=
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

