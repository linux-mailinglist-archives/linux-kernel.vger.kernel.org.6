Return-Path: <linux-kernel+bounces-170865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D69E8BDD17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB781F2385B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA29513C913;
	Tue,  7 May 2024 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imlWuaVE"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC113C8FE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715070300; cv=none; b=P6rqmZKGptfFnFzprAHPhCHDpq5OZUzObwLF/WFZhiwLFuWW5joFHqrjPf4UfuVsf7PmXwo0J4jvDhARMSDngtZuKlmLDUjrk/gH7LuWHw/avi6bs0Bo26OTufWRSC9LnPmmYEgRt3LLr7tvySJz56UGtEtDi0WNeHFf18pm/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715070300; c=relaxed/simple;
	bh=Qp3gxVZLz5SUODG4qCaDsUfnVYZxHfGd5mDAVT6ShUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtERjjDrmNjlmA9FEVe3rkKf7NG3fEsc7pX2uEnKJ1FqoiB3w0R7jjyScL3JkcbzB9N3LBNnPvBzVhqzpgDJekReyocsP/Qe7FXlgT1qbidbKv1Krd4gDnRsdo+DUoDAWoQ/l4FrRPxmCvBrHizrfYjYOB8DguS97Y4dfjhyBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imlWuaVE; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so701555e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715070298; x=1715675098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAQWDGtCFXbapm8xatzzeQK02lgJWFufMkgQUQ06QiU=;
        b=imlWuaVEIlGrr2Hv6knYpqWA3cVM00cmAxHw3L/CQri0k2F0tIaISemgwa9WzU1ITg
         t0C1MW3eGAvBqjOcRXmvXOICLKsnXg435pQxOaGoooWr4vv3tyT+45x+h6Ae1rCivozo
         HsmyeUajFBipfRhnkWzYjWSvoAB9y97sSqI20lKodprJwcb5qgMU5vUmvnGgoh8BnuUf
         JQvbdVzyg0fFAzhwQwYDdkD3qLcHKBq3oqWnLANWB0otzwmDVk5zEgST/hjOqs0JqSug
         KeCFoph1IawtAe+IExo3E+WdS6yeProvLE8Z4VildSN895YKzrcZe4gd+GQNeh1DqipH
         P70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715070298; x=1715675098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAQWDGtCFXbapm8xatzzeQK02lgJWFufMkgQUQ06QiU=;
        b=mx0RxR48nOhd7C5HlykEcEoP7sMtG8Tk5lh5d/w3ZR1k4EJfeHm/8X9ftx/+FBuEBD
         urS7ra4gwE7/w0jqyPggzpAZwFdVRncUV208goQW7Ey3j0yo9JHcuPQQy2g+l6s/0SLL
         eoR/1E4wgLKXpPHNYcWmVulBFSScXog5wYz5XIv+TrOcI9vDhG2NBQy8Fvk8olOykHlw
         Y0dYbeyjg+cTjN8p3MIWohHNKrKlua+lesEbE/M19basaLnUYQlL3eD95DPgRketR6pJ
         wUtNnXjmV3gkFzpfZcjP0RTEpWDQQU6U7G/B4v3VCjOnS/ArTsAKjkviyPfznkcz7iTE
         Lmsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3sCCyoSWV0Ci7HNsg+mu/SBJVoA3lwjeUM/ZQds9XGr7N6rS8T9XvKQCscKModba9H5oLJ/I2Q0Y4JQQSL+J4KU0YbIFKmjjxR94+
X-Gm-Message-State: AOJu0Yyd3kFePKrbHAymhIBtey+rfmJBKt3gH5ZwtI05rWkYHT29Q4mi
	tRK4RpZk2oNPu6MGZZxpGrsZv90WZU+8W0VCi0pa8XksoEpIKY4mKdaGCz4xLJamDQMtunroCuK
	ychhX9uOtrdPMgNfhzBrdMA0+djs=
X-Google-Smtp-Source: AGHT+IErHD8Er/A/4xDDoTqdiYe1heOjgHIMxZJg7YG+6B+DcxurdVS9JMU0c4k0TkKwnqTa59iWL/SoC1hliuPW/nk=
X-Received: by 2002:a05:6122:2017:b0:4d8:37eb:9562 with SMTP id
 l23-20020a056122201700b004d837eb9562mr11949380vkd.0.1715070298004; Tue, 07
 May 2024 01:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-4-21cnbao@gmail.com>
 <7548e30c-d56a-4a57-ab87-86c9c8e523b1@arm.com> <CAGsJ_4wx60GoB1erTQ7v3GTXLb_140bOJ_+z=kqY39eOd3P23g@mail.gmail.com>
 <0d20d8af-e480-4eb8-8606-1e486b13fd7e@redhat.com> <CAGsJ_4wP75tFWDcKJZfw7Pk9AdigVCv0niGUeTY6RTZwk1UnjQ@mail.gmail.com>
 <ab283f1f-93bd-4f5e-8172-02109e02e8c4@redhat.com> <0bca057d-7344-40a6-a981-9a7a9347a19f@arm.com>
In-Reply-To: <0bca057d-7344-40a6-a981-9a7a9347a19f@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 20:24:46 +1200
Message-ID: <CAGsJ_4zA64NDdnqupOf6uUprpEiAbEwdaBzn3uck7ycj4gersQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which
 can move offset bidirectionally
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:14=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 06/05/2024 09:31, David Hildenbrand wrote:
> > On 06.05.24 10:20, Barry Song wrote:
> >> On Mon, May 6, 2024 at 8:06=E2=80=AFPM David Hildenbrand <david@redhat=
com> wrote:
> >>>
> >>> On 04.05.24 01:40, Barry Song wrote:
> >>>> On Fri, May 3, 2024 at 5:41=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>>
> >>>>> On 03/05/2024 01:50, Barry Song wrote:
> >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>
> >>>>>> There could arise a necessity to obtain the first pte_t from a swa=
p
> >>>>>> pte_t located in the middle. For instance, this may occur within t=
he
> >>>>>> context of do_swap_page(), where a page fault can potentially occu=
r in
> >>>>>> any PTE of a large folio. To address this, the following patch int=
roduces
> >>>>>> pte_move_swp_offset(), a function capable of bidirectional movemen=
t by
> >>>>>> a specified delta argument. Consequently, pte_increment_swp_offset=
()
> >>>>>
> >>>>> You mean pte_next_swp_offset()?
> >>>>
> >>>> yes.
> >>>>
> >>>>>
> >>>>>> will directly invoke it with delta =3D 1.
> >>>>>>
> >>>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> >>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>>> ---
> >>>>>>    mm/internal.h | 25 +++++++++++++++++++++----
> >>>>>>    1 file changed, 21 insertions(+), 4 deletions(-)
> >>>>>>
> >>>>>> diff --git a/mm/internal.h b/mm/internal.h
> >>>>>> index c5552d35d995..cfe4aed66a5c 100644
> >>>>>> --- a/mm/internal.h
> >>>>>> +++ b/mm/internal.h
> >>>>>> @@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct fol=
io
> >>>>>> *folio, unsigned long addr,
> >>>>>>    }
> >>>>>>
> >>>>>>    /**
> >>>>>> - * pte_next_swp_offset - Increment the swap entry offset field of=
 a swap
> >>>>>> pte.
> >>>>>> + * pte_move_swp_offset - Move the swap entry offset field of a sw=
ap pte
> >>>>>> + *    forward or backward by delta
> >>>>>>     * @pte: The initial pte state; is_swap_pte(pte) must be true a=
nd
> >>>>>>     *    non_swap_entry() must be false.
> >>>>>> + * @delta: The direction and the offset we are moving; forward if=
 delta
> >>>>>> + *    is positive; backward if delta is negative
> >>>>>>     *
> >>>>>> - * Increments the swap offset, while maintaining all other fields=
, including
> >>>>>> + * Moves the swap offset, while maintaining all other fields, inc=
luding
> >>>>>>     * swap type, and any swp pte bits. The resulting pte is return=
ed.
> >>>>>>     */
> >>>>>> -static inline pte_t pte_next_swp_offset(pte_t pte)
> >>>>>> +static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
> >>>>>
> >>>>> We have equivalent functions for pfn:
> >>>>>
> >>>>>     pte_next_pfn()
> >>>>>     pte_advance_pfn()
> >>>>>
> >>>>> Although the latter takes an unsigned long and only moves forward c=
urrently. I
> >>>>> wonder if it makes sense to have their naming and semantics match? =
i.e. change
> >>>>> pte_advance_pfn() to pte_move_pfn() and let it move backwards too.
> >>>>>
> >>>>> I guess we don't have a need for that and it adds more churn.
> >>>>
> >>>> we might have a need in the below case.
> >>>> A forks B, then A and B share large folios. B unmap/exit, then large
> >>>> folios of process
> >>>> A become single-mapped.
> >>>> Right now, while writing A's folios, we are CoWing A's large folios
> >>>> into many small
> >>>> folios. I believe we can reuse the entire large folios instead of do=
ing
> >>>> nr_pages
> >>>> CoW and page faults.
> >>>> In this case, we might want to get the first PTE from vmf->pte.
> >>>
> >>> Once we have COW reuse for large folios in place (I think you know th=
at
> >>> I am working on that), it might make sense to "COW-reuse around",
> >>
> >> TBH, I don't know if you are working on that. please Cc me next time :=
-)
> >
> > I could have sworn I mentioned it to you already :)
> >
> > See
> >
> > https://lore.kernel.org/linux-mm/a9922f58-8129-4f15-b160-e0ace581bcbe@r=
edhat.com/T/
> >
> > I'll follow-up on that soonish (now that batching is upstream and the l=
arge
> > mapcount is on its way upstream).
> >
> >>
> >>> meaning we look if some neighboring PTEs map the same large folio and
> >>> map them writable as well. But if it's really worth it, increasing pa=
ge
> >>> fault latency, is to be decided separately.
> >>
> >> On the other hand, we eliminate latency for the remaining nr_pages - 1=
 PTEs.
> >> Perhaps we can discover a more cost-effective method to signify that a=
 large
> >> folio is probably singly mapped?
> >
> > Yes, precisely what I am up to!
> >
> >> and only call "multi-PTEs" reuse while that
> >> condition is true in PF and avoid increasing latency always?
> >
> > I'm thinking along those lines:
> >
> > If we detect that it's exclusive, we can certainly mapped the current P=
TE
> > writable. Then, we can decide how much (and if) we want to fault-around=
 writable
> > as an optimization.
> >
> > For smallish large folios, it might make sense to try faulting around m=
ost of
> > the folio.
> >
> > For large large folios (e.g., PTE-mapped 2MiB THP and bigger), we might=
 not want
> > to fault around the whole thing -- especially if there is little benefi=
t to be
> > had from contig-pte bits.
> >
> >>
> >>>
> >>>
> >>>>
> >>>> Another case, might be
> >>>> A forks B, and we write either A or B, we might CoW an entire large
> >>>> folios instead
> >>>> CoWing nr_pages small folios.
> >>>>
> >>>> case 1 seems more useful, I might have a go after some days. then we=
 might
> >>>> see pte_move_pfn().
> >>> pte_move_pfn() does sound odd to me.
>
> Yes, I agree the name is odd. pte_move_swp_offset() sounds similarly odd =
tbh.
> Perhaps just pte_advance_swp_offset() with a negative value is clearer ab=
out
> what its doing?
>

I am not a native speaker. but dictionary says

advance:
move forward in a purposeful way.
a forward movement.

Now we are moving backward or forward :-)

> >>> It might not be required to
> >>> implement the optimization described above. (it's easier to simply re=
ad
> >>> another PTE, check if it maps the same large folio, and to batch from=
 there)
>
> Yes agreed.
>
> >>>
> >>
> >> It appears that your proposal suggests potential reusability as follow=
s: if we
> >> have a large folio containing 16 PTEs, you might consider reusing only=
 4 by
> >> examining PTEs "around" but not necessarily all 16 PTEs. please correc=
t me
> >> if my understanding is wrong.
> >>
> >> Initially, my idea was to obtain the first PTE using pte_move_pfn() an=
d then
> >> utilize folio_pte_batch() with the first PTE as arguments to ensure co=
nsistency
> >> in nr_pages, thus enabling complete reuse of the whole folio.
> >
> > Simply doing an vm_normal_folio(pte - X) =3D=3D folio and then trying t=
o batch from
> > there might be easier and cleaner.
> >
>

