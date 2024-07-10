Return-Path: <linux-kernel+bounces-246869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065692C830
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F251F244E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC8B8F62;
	Wed, 10 Jul 2024 02:01:00 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090E320C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720576860; cv=none; b=UNrttvAiGW7Fqg34tMzT2y35s+8BvdCEzuxq6rT7UdaPEGcyi+LdaEHpRtbw9OxFCWDcRKkNweEU6eCjKAzZHzjuIP8bdcmEbYbmQanycsHWxQ+eM0dzuVa0igI0D5o0Grm+NZyPoeL71PUvTqO96mCoPgM8iDyu/OBZUswW1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720576860; c=relaxed/simple;
	bh=6B3KTRIM2aBMgOAAfiG4WZi6QDMQuDP6trhF3VLLvCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA5uZLt50qV+aLI7gGTdB/VaF5dyUUuQzZH6bMKsCxBWPCOwpfnSRE80QKLUFlSOhtzwIk5ApjTn/qQo2qi+sc2dxBP2RalDPFNExu8uHSsTJtqxGPfKAktK8f9XyD2KVge5v5vK0KcyI9zYUf+KU1WKULGOUa3Z72q2ACpsBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48febcc8819so2012281137.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 19:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720576857; x=1721181657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwplGrTzrWU0Nuw4LQrAWRSRooLeWGZ6YTTKuTBHp38=;
        b=hvZZEXcwTe7TrpHO0msYW9QixQi93Z/Jl+9fvv8OiMQDjVVxIznJASlgwdnbLxJseL
         5Rz6T2ZFZlwDiaSzb1Ye0Ef+dFqw6tWhMTS/XSaagBoewF8X/CVJdBnkbYFI33M+DjqG
         eHwdccfY0Ty7uFbSRD8hGzkqE2v+A9sSC90HHaDoyLYlAYKEhEiXyFwlK8A/PpDxDztY
         AzSnqJk8zjacUYkizWB6KnFJ6+3TOMHwCbN8OkyaIpkjGFsXuLzylWMFdgdAKpvQmZo0
         K74GKT6kbX2qzRcKur1BihZGfZcJgInX/n/iZvOWK/qXKnn2rChu2iOxENYx1mSJwHpz
         8Yag==
X-Forwarded-Encrypted: i=1; AJvYcCWJgKkyUEJmG/CsQRIHEm3KhjnOBBYQMVWM3rFTFFtliRWqMpnGtVNEmvnbw2lFLXZzr8jWNHm6pHSnCDxaUfDXud4dVBgZ2T6vCWp8
X-Gm-Message-State: AOJu0YyGyhl5Wo9sx9mgVBAYUS4oSNAfurLHuJMDAWke5rQRw2LZPqJC
	wlWTp8g7PPlouQA9sbx1yWXIAK994TOPzotdB2kKsiLKK6MYplROJ9OLwD47S5BRc7J3uIUXsfU
	Vnh4sDt5hRPPw9O8U+b/aVBIzECM=
X-Google-Smtp-Source: AGHT+IGXdtBbOUBpbSCBUSMjGTEyH1Zi7P4SMCiESwkf4nzGvqgd0C1vf6X+rJCb7UrH8/PGrOZsnaV0NuXrKjqu9Y8=
X-Received: by 2002:a05:6102:c91:b0:48f:a83f:7d10 with SMTP id
 ada2fe7eead31-4903212d717mr5480306137.10.1720576857191; Tue, 09 Jul 2024
 19:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709123115.117-1-justinjiang@vivo.com> <CAGsJ_4x1+T9+=WydkjsQmetGFOqzkOvhqQim5UOzytof5XHQ_g@mail.gmail.com>
 <863b2400-5def-4bd2-8195-d71ce91f1c99@vivo.com>
In-Reply-To: <863b2400-5def-4bd2-8195-d71ce91f1c99@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 10 Jul 2024 14:00:45 +1200
Message-ID: <CAGsJ_4ygMms0ur0+gsaQ_SMKOEeKQCP1+UYOk+jXPbXF=ctgVQ@mail.gmail.com>
Subject: Re: [PATCH v7] mm: shrink skip folio mapped by an exiting process
To: zhiguojiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:46=E2=80=AFPM zhiguojiang <justinjiang@vivo.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/7/9 21:02, Barry Song =E5=86=99=E9=81=93:
> > On Tue, Jul 9, 2024 at 8:31=E2=80=AFPM Zhiguo Jiang <justinjiang@vivo.c=
om> wrote:
> >> The releasing process of the non-shared anonymous folio mapped solely =
by
> >> an exiting process may go through two flows: 1) the anonymous folio is
> >> firstly is swaped-out into swapspace and transformed into a swp_entry
> >> in shrink_folio_list; 2) then the swp_entry is released in the process
> >> exiting flow. This will result in the high cpu load of releasing a
> >> non-shared anonymous folio mapped solely by an exiting process.
> >>
> >> When the low system memory and the exiting process exist at the same
> >> time, it will be likely to happen, because the non-shared anonymous
> >> folio mapped solely by an exiting process may be reclaimed by
> >> shrink_folio_list.
> >>
> >> This patch is that shrink skips the non-shared anonymous folio solely
> >> mapped by an exting process and this folio is only released directly i=
n
> >> the process exiting flow, which will save swap-out time and alleviate
> >> the load of the process exiting.
> >>
> >> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> > You should have collected tags such as reviewed-by, acked-by you got in=
 v6
> > while sending v7.
> >
> > Again,
> > Acked-by: Barry Song <baohua@kernel.org>
> Yes, it is alreadly included in patch v7.

obviously no. please take a look how people collect tags while sending a
new version:

https://lore.kernel.org/linux-mm/20240704012905.42971-2-ioworker0@gmail.com=
/


>
> Thanks
> Zhiguo
> >
> >> ---
> >>
> >> Change log:
> >> v6->v7:
> >> 1.Modify tab indentation to space indentation of the continuation
> >> lines of the condition.
> >> v5->v6:
> >> 1.Move folio_likely_mapped_shared() under the PTL.
> >> 2.Add check_stable_address_space() to replace MMF_OOM_SKIP.
> >> 3.Remove folio_test_anon(folio).
> >> v4->v5:
> >> 1.Further modify to skip non-shared anonymous folio only.
> >> 2.Update comments for pra->referenced =3D -1.
> >> v3->v4:
> >> 1.Modify to skip only the non-shared anonymous folio mapped solely
> >> by an exiting process.
> >> v2->v3:
> >> Nothing.
> >> v1->v2:
> >> 1.The VM_EXITING added in v1 patch is removed, because it will fail
> >> to compile in 32-bit system.
> >>
> >>
> >> Comments from participants and my responses:
> >> [v6->v7]:
> >> 1.Matthew Wilcox <willy@infradead.org>
> >> You told me you'd fix the indentation.  You cannot indent both the
> >> continuation lines of the condition and the body of the if by one tab
> >> each!
> >> -->
> >> Modify tab indentation to space indentation of the continuation
> >> lines of the condition.
> >>
> >> [v5->v6]:
> >> 1.David Hildenbrand <david@redhat.com>
> >> I'm currently working on moving all folio_likely_mapped_shared() under
> >> the PTL, where we are then sure that the folio is actually mapped by
> >> this process (e.g., no concurrent unmapping poisslbe). Can we do the
> >> same here directly?
> >> -->
> >> You are right. we might use page_vma_mapped_walk_done() to bail out.
> >> (Barry Song)
> >>
> >> 2.Barry Song <baohua@kernel.org>
> >> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
> >> &vma->vm_mm->flags) is correct (I think it is wrong). And exit_mmap()
> >> automatically has MMF_OOM_SKIP. What is the purpose of this check?
> >> Is there a better way to determine if a process is an OOM target?
> >> What about check_stable_address_space() ?
> >> -->
> >> Sorry, I overlook the situation with if (is_global_init(p)),
> >> MMF_OOM_SKIP is indeed not suitable. It seems feasible for
> >> check_stable_address_space() replacing MMF_OOM_SKIP.
> >> check_stable_address_space() can indicate oom kill, and
> >> !atomic_read(&vma->vm_mm->mm_users) can indicate the normal
> >> process exiting.
> >>
> >> I also think we actually can remove "folio_test_anon(folio)".
> >> -->
> >> Yes, update in patch v6.
> >>
> >> [v4->v5]:
> >> 1.Barry Song <baohua@kernel.org>
> >> I don't think this is correct. folio_likely_mapped_shared() is almost
> >> "correct" but not always.
> >> Please explain why you set  pra->referenced =3D  -1. Please address al=
l
> >> comments before you send a new version.
> >> -->
> >> Update in patch v5.
> >>
> >> 2.Matthew Wilcox <willy@infradead.org>
> >> How is the file folio similar?  File folios are never written to swap,
> >> and they'll be written back from the page cache whenever the filesyste=
m
> >> decides it's a good time to do so.
> >> -->
> >> What do you mean is that the file folio will not have any relevant
> >> identifier left in memory after it is reclamed in the shrink flow,
> >> and it will not be released again during an exiting process? If that's
> >> the case, I think we only need the anon folio is skipped here.
> >>
> >> [v3->v4]:
> >> 1.Barry Song <baohua@kernel.org>
> >> This is clearly version 3, as you previously sent version 2, correct?
> >> -->
> >> Yes.
> >>
> >> Could you please describe the specific impact on users, including user
> >> experience and power consumption? How serious is this problem?
> >> -->
> >> At present, I do not have a suitable method to accurately measure the
> >> optimization benefit datas of this modifications, but I believe it
> >> theoretically has some benefits.
> >> Launching large memory app (for example, starting the camera) in multi=
ple
> >> backend scenes may result in the high cpu load of the exiting processe=
s.
> >>
> >> Applications?
> >> -->
> >> Yes, when system is low memory, it more likely to occur.
> >>
> >> I'm not completely convinced this patch is correct, but it appears to =
be
> >> heading in the right direction. Therefore, I expect to see new version=
s
> >> rather than it being dead.
> >> You changed the file mode to 755, which is incorrect.
> >> -->
> >> Solved.
> >>
> >> Why use -1? Is this meant to simulate lock contention to keep the foli=
o
> >> without activating it? Please do have some comments to explain why.
> >> I'm not convinced this change is appropriate for shared folios. It see=
ms
> >> more suitable for exclusive folios used solely by the exiting process.
> >> -->
> >> The skiped folios are FOLIOREF_KEEP and added into inactive lru, beaca=
se
> >> the folios will be freed soon in the exiting process flow.
> >> Yes, the shared folios can not be simply skipped. I have made relevant
> >> modifications in patch v4 and please help to further review.
> >> https://lore.kernel.org/linux-mm/20240708031517.856-1-justinjiang@vivo=
.com/
> >>
> >> 2.David Hildenbrand <david@redhat.com>
> >> but what if it is shared among multiple processes and only one of them
> >> is exiting?
> >> -->
> >> Modify to skip only the non-shared anonymous folio mapped solely
> >> by an exiting process in next version v4.
> >>
> >> [v2->v3:]
> >> Nothing.
> >>
> >> [v1->v2]:
> >> 1.Matthew Wilcox <willy@infradead.org>
> >> What testing have you done of this patch?  How often does it happen?
> >> Are there particular workloads that benefit from this?  (I'm not sure
> >> what "mutil backed-applications" are?)
> >> And I do mean specifically of this patch, because to my eyes it
> >> shouldn't even compile. Except on 32-bit where it'll say "warning:
> >> integer constant out of range".
> >> -->
> >> Yes, I have tested. When the low system memory and the exiting process
> >> exist at the same time, it will happen. This modification can alleviat=
e
> >> the load of the exiting process.
> >> "mutil backed-applications" means that there are a large number of
> >> the backend applications in the system.
> >> The VM_EXITING added in v1 patch is removed, because it will fail
> >> to compile in 32-bit system.
> >>
> >>   mm/rmap.c   | 14 ++++++++++++++
> >>   mm/vmscan.c |  7 ++++++-
> >>   2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index 88156deb46a6..bb9954773cce 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -877,6 +877,20 @@ static bool folio_referenced_one(struct folio *fo=
lio,
> >>                          continue;
> >>                  }
> >>
> >> +               /*
> >> +                * Skip the non-shared swapbacked folio mapped solely =
by
> >> +                * the exiting or OOM-reaped process. This avoids redu=
ndant
> >> +                * swap-out followed by an immediate unmap.
> >> +                */
> >> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
> >> +                   check_stable_address_space(vma->vm_mm)) &&
> >> +                   folio_test_swapbacked(folio) &&
> >> +                   !folio_likely_mapped_shared(folio)) {
> >> +                       pra->referenced =3D -1;
> >> +                       page_vma_mapped_walk_done(&pvmw);
> >> +                       return false;
> >> +               }
> >> +
> >>                  if (pvmw.pte) {
> >>                          if (lru_gen_enabled() &&
> >>                              pte_young(ptep_get(pvmw.pte))) {
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 80f9a486cf27..1d5f78a3dbeb 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -863,7 +863,12 @@ static enum folio_references folio_check_referenc=
es(struct folio *folio,
> >>          if (vm_flags & VM_LOCKED)
> >>                  return FOLIOREF_ACTIVATE;
> >>
> >> -       /* rmap lock contention: rotate */
> >> +       /*
> >> +        * There are two cases to consider.
> >> +        * 1) Rmap lock contention: rotate.
> >> +        * 2) Skip the non-shared swapbacked folio mapped solely by
> >> +        *    the exiting or OOM-reaped process.
> >> +        */
> >>          if (referenced_ptes =3D=3D -1)
> >>                  return FOLIOREF_KEEP;
> >>
> >> --
> >> 2.39.0
> >>
>

