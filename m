Return-Path: <linux-kernel+bounces-296986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E206595B187
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD831F22330
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924F417C213;
	Thu, 22 Aug 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg12kPRF"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020822B9AF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318480; cv=none; b=q/ZpC9l/HVpChWm8Gb7iN6hqEdjfG/7jj7tevpENpJjmB+Xcyiz4ny4nyx0LqwhT+NX/ecnxXMTs8erMeq8zjkzITDJin+q4iebvYWgPwzM/ytQDLWQlDS3u2PPE4vCvCXXvNonyHtPEqeqxAADL/W0cI5E6T8FxBT9UxiTDkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318480; c=relaxed/simple;
	bh=z4/UYnXXIFfRCucClWkwsSj5hzthUd2D1lNu5YMn7wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1frqgGZ5GbPY4nKeSebkbqnwLs9U08VqPNn5xRAItNe5rhazFkNXzmrM5eAThheqYnMXg/YU9AjJXSr4TAgkOxphkEqM879CKPxBmtLnoEpCRHIFCI7yfCZ0TU1j0wVT2nA/OUbt7QOVq2hl+4AU5E7Nn5ZRy91frHkrQxfiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cg12kPRF; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-498cd1112c3so161717137.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724318478; x=1724923278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5OPoCeLJftITQysp2N+imC7KIo1hVOMatkO69d2rR8=;
        b=Cg12kPRFqTicinxoyP7+UyUAiPMNVJoZsjCaRODWKDmvgWNdjSqv160MZrBwTcJ1D2
         TykBytZreHUNeHfQiZgATsySDaLg8v5Wiy9Ol7PcxNPSd+QzLJuO0e8nrgEECdrj32/2
         jRyz+hEt5VKL3uKbTFAFWlbFDzYR4zlf7clClGZ3ZfGHn638hPnHBuoPkFra45xvESUJ
         w0iqSYF0ga4Ehdql8cb3Gjh/vK0PsIOlZfM3xVBUK59FNfuwiDYw3tH17LOcegxO+WJn
         tt3nyUwtoccaqig8/RO42IMN+7frWw8zC2c4VUc9xyQ0ikiIkN+6X7z+dXIqZ3FqCRuA
         H3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318478; x=1724923278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5OPoCeLJftITQysp2N+imC7KIo1hVOMatkO69d2rR8=;
        b=kFFCiI7DAvKudOHAhl2NzT+Xj0LGIdlkVN7XDERQZVkS4e6gPaNlUkiwjPKCH2aki9
         shbAX0XRHMspSpNjUrvnIQjaZ9foHHkAr+YKOyS9bqa88LpOM8zADU02W8fv3eWuWVXr
         ROCh0YjiU4vLE9IOshIkuvdBvDuP15jefK+hx28aVQgpGof3hy5R8zEo2gxt2zfDV/uu
         U4/UxSD2cDAq7uPjaCgUwsvNaW9DdgkDFaq5sA8cGhKGJ59cNwfPPwD0SLHNNMhJUyPU
         gMlLmj1qkjTRana3zsjMM05lRiNqwmzRfOMKcqZGaFzkNt9AbCQO0L87CgBW02VvQeVJ
         CLAg==
X-Forwarded-Encrypted: i=1; AJvYcCUU6YhvNmOXfdu/UCDbBdMje/q1vttN8cUw8lwhbuESLurpAYOE28EB2jlES+2dpMOQhyATtT29twxYmrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8DFJZFa3YU9k4fclfMozVf/6PUf47DTYT+f3cs4KRk97j72o
	4nUS2ayVhFrl+x4HLEbGbxlQRK8TWRY+7iEhQ36gBYNSRHNUE2qC/Z3aXjtM74RCIOloeR4Uzio
	ZoevQZ7QOnpSGkkfBWmFHjnRD0nk=
X-Google-Smtp-Source: AGHT+IEu2zKxX/CRwD27r8BAS3GwSTQPt7JCdGXQbl9OP8kPF8iRMqNufKsIEYinyNIOEzsbuXQzLl4agCs9noXilR0=
X-Received: by 2002:a05:6102:3383:b0:498:cf81:3a40 with SMTP id
 ada2fe7eead31-498e6eccd8amr1082182137.17.1724318477822; Thu, 22 Aug 2024
 02:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811224940.39876-1-21cnbao@gmail.com> <20240811224940.39876-2-21cnbao@gmail.com>
 <3572ae2e-2141-4a70-99da-850b2e7ade41@redhat.com> <CAGsJ_4w9gg=z6KgAZ4Tur+t-ZhpXdvmq4A5tOQiUZLeuPFSupg@mail.gmail.com>
 <CAGsJ_4yqf4KNvsg1P47cAz+bniZFVcUWPkdjYTqji91CgnrrfQ@mail.gmail.com> <954f80c8-5bc3-44f5-a361-32073cbbd764@redhat.com>
In-Reply-To: <954f80c8-5bc3-44f5-a361-32073cbbd764@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 22 Aug 2024 21:21:06 +1200
Message-ID: <CAGsJ_4wyj7U2z_XnbgEsavEkpkNO8=kVfMesxhtNbcQ=H3dzXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com, yuanshuai@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.08.24 10:44, Barry Song wrote:
> > On Thu, Aug 22, 2024 at 12:52=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>
> >> On Thu, Aug 22, 2024 at 5:34=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 12.08.24 00:49, Barry Song wrote:
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> Anon large folios come from three places:
> >>>> 1. new allocated large folios in PF, they will call folio_add_new_an=
on_rmap()
> >>>> for rmap;
> >>>> 2. a large folio is split into multiple lower-order large folios;
> >>>> 3. a large folio is migrated to a new large folio.
> >>>>
> >>>> In all above three counts, we increase nr_anon by 1;
> >>>>
> >>>> Anon large folios might go either because of be split or be put
> >>>> to free, in these cases, we reduce the count by 1.
> >>>>
> >>>> Folios that have been added to the swap cache but have not yet recei=
ved
> >>>> an anon mapping won't be counted. This is consistent with the AnonPa=
ges
> >>>> statistics in /proc/meminfo.
> >>>
> >>> Thinking out loud, I wonder if we want to have something like that fo=
r
> >>> any anon folios (including small ones).
> >>>
> >>> Assume we longterm-pinned an anon folio and unmapped/zapped it. It wo=
uld
> >>> be quite interesting to see that these are actually anon pages still
> >>> consuming memory. Same with memory leaks, when an anon folio doesn't =
get
> >>> freed for some reason.
> >>>
> >>> The whole "AnonPages" counter thingy is just confusing, it only count=
s
> >>> what's currently mapped ... so we'd want something different.
> >>>
> >>> But it's okay to start with large folios only, there we have a new
> >>> interface without that legacy stuff :)
> >>
> >> We have two options to do this:
> >> 1. add a new separate nr_anon_unmapped interface which
> >> counts unmapped anon memory only
> >> 2. let the nr_anon count both mapped and unmapped anon
> >> folios.
> >>
> >> I would assume 1 is clearer as right now AnonPages have been
> >> there for years. and counting all mapped and unmapped together,
> >> we are still lacking an approach to find out anon memory leak
> >> problem you mentioned.
> >>
> >> We are right now comparing nr_anon(including mapped folios only)
> >> with AnonPages to get the distribution of different folio sizes in
> >> performance profiling.
> >>
> >> unmapped_nr_anon should be normally always quite small. otherwise,
> >> something must be wrong.
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>> ---
> >>>>    Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> >>>>    include/linux/huge_mm.h                    | 15 +++++++++++++--
> >>>>    mm/huge_memory.c                           | 13 ++++++++++---
> >>>>    mm/migrate.c                               |  4 ++++
> >>>>    mm/page_alloc.c                            |  5 ++++-
> >>>>    mm/rmap.c                                  |  1 +
> >>>>    6 files changed, 37 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 058485daf186..9fdfb46e4560 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -527,6 +527,11 @@ split_deferred
> >>>>            it would free up some memory. Pages on split queue are go=
ing to
> >>>>            be split under memory pressure, if splitting is possible.
> >>>>
> >>>> +nr_anon
> >>>> +       the number of anon huge pages we have in the whole system.
> >>>
> >>> "transparent ..." otherwise people might confuse it with anon hugetlb
> >>> "huge pages" ... :)
> >>>
> >>> I briefly tried coming up with a better name than "nr_anon" but faile=
d.
> >>>
> >>>
> >>
> >> if we might have unmapped_anon counter later, maybe rename it to
> >> nr_anon_mapped? and the new interface we will have in the future
> >> might be nr_anon_unmapped?
>
> We really shouldn't be using the mapped/unmapped terminology here ... we
> allocated pages and turned them into anonymous folios. At some point we
> free them. That's the lifecycle.
>
> >
> > On second thought, this might be incorrect as well. Concepts like 'anon=
',
> > 'shmem', and 'file' refer to states after mapping. If an 'anon' has bee=
n
> > unmapped but is still pinned and not yet freed, it isn't technically an
> > 'anon' anymore?
>
> It's just not mapped, and cannot get mapped, anymore. In the memdesc
> world, we'd be freeing the "struct anon" or "struct folio" once the last
> refcount goes to 0, not once (e.g., temporarily during a failed
> migration?) unmapped.
>
> The important part to me would be: this is memory that was allocated for
> anonymous memory, and it's still around for some reason and not getting
> freed. Usually, we would expect anon memory to get freed fairly quickly
> once unmapped. Except when there are long-term pinnings or other types
> of memory leaks.
>
> You could happily continue using these anon pages via vmsplice() or
> similar, even thought he original page table mapping was torn down.
>
> >
> > On the other hand, implementing nr_anon_unmapped could be extremely
> > tricky. I have no idea how to implement it as we are losing those mappi=
ng
> > flags.
>
> folio_mapcount() can tell you efficiently whether a folio is mapped or
> not -- and that information will stay for all eternity as long as we
> have any mapcounts :) . It cannot tell "how many" pages of a large folio
> are mapped, but at least "is any page of this large folio mapped".

Exactly. AnonPages decreases by -1 when removed from the rmap,
whereas nr_anon decreases by -1 when an anon folio is freed. So,
I would assume nr_anon includes those pinned and unmapped anon
folios but AnonPages doesn't.

If there's a significant amount of 'leaked' anon, we should consider
having a separate counter for them. For instance, if nr_anon is
100,000 and pinned/unmapped pages account for 50%, then nr_anon
alone doesn=E2=80=99t effectively reflect the system's state.

to implement that, it seems we do need to detect the moment mapcount=3D=3D0
and the moment of freeing anon?

when mapcount=3D=3D0 in rmap
      unmapped_pinned_anon++;

when free
      unmapped_pinned_anon--;

Anyway, it seems this is a separate job.

>
> >
> > However, a page that is read-ahead but not yet mapped can still become
> > an anon, which seems slightly less tricky to count though seems still
> > difficult - except anon pages, shmem can be also swapped-backed?
>
> Yes. I'm sure there would be ways to achieve it, but I am not sure if
> it's worth the churn. These pages can be reclaimed easily (I would
> assume? They are not even mapped and were never accessible via GUP), and
> can certainly not have any longterm pinnings or similar. There are more
> like "cached things that could become an anon folio".

Exactly. If no one maps the pages for an extended period, I assume
the LRU will reclaim them as well.

>
> --
> Cheers,
>
> David / dhildenb

Thanks
Barry

