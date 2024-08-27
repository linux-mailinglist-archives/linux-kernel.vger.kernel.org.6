Return-Path: <linux-kernel+bounces-304081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63689619D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB891C23426
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF20194A6C;
	Tue, 27 Aug 2024 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0Noisy2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0C76056
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796282; cv=none; b=o9FGfEnoivGe1zn8QzAvfl9qXVnPf+oSXiJdXzZkS8bX95LZ07Xt3a/WziRK1Qh8YVWow+y1C6TBkanknBvT7UCba71p0RVUdR+KbVgyLahyAs/MoP9VtEA67WGsWsBDaUf4y445R9VcHhM3q7kChe6OZyLSuP8Am2KE3len5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796282; c=relaxed/simple;
	bh=TYVYuVfjj962y34SkzDzX+M1XeyFcgoX9wq3H/LLV3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWknuWmUtBjU4AMMUaS9glt1Rliu1/EgHtgxG0HZTafadMhMFMOx9jxkaEJKzG1O1fwFzdGBJE6qPokFXX97hWoc3P1cgnJX1OjHMJyNJwFb4whKLU6RqIUDitTB+FxJKltUQwz7IkTHJlkLde4rYjOOkLmV1RN+Ev0+tDa0Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0Noisy2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724796279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYVYuVfjj962y34SkzDzX+M1XeyFcgoX9wq3H/LLV3s=;
	b=O0Noisy238CUncqzi7KOMu02KpptV+jeRxv6HpeftQ1HY6X2fD0GnYKGw/0grWK3gzb1i5
	liy4I4qFUsw20Sndp0De8VqbqsgHtcBGfQSvYjQi8FofBkp5t+LboJWbWjoEClYLZ0GVn+
	s//UkBdNZH0/Z24X9wjuqXeP+blCTjk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-yKcMtjfoNYyr-fPbLsuyiA-1; Tue, 27 Aug 2024 18:04:37 -0400
X-MC-Unique: yKcMtjfoNYyr-fPbLsuyiA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ad660add0fso194777b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724796277; x=1725401077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYVYuVfjj962y34SkzDzX+M1XeyFcgoX9wq3H/LLV3s=;
        b=UziPe8YK3GtalasMVlBe4HsniCrS2p/w2b6GG+t55lXoECBNPemBjHPolxnpnS2Crq
         E/Oy+Fzt0QXUz8FkIIvoVPMS7ZoH2wxOoxEi9RXOfcF4AR603R739p+85pmwoKr5MEiQ
         WTdm6a74cikSVu2vFMOlkN4zM2Tn94JQa0qg5Th5gb/YD76D5DEJW6hZNC/maEuoKgdg
         YtkkAgycJoBPsikuuOH3NzSQ7TLbYtLosRbjbFJaRH1MtuCJajFcs+wfQrFouGX8srLW
         /0H66WV1F660Y+WHMgagphv0NCez0t9qy295/RvE6P5eNG2gm2RfQrfD2Dx/AF/ppCJj
         axYg==
X-Forwarded-Encrypted: i=1; AJvYcCX8GTvneehl1jBKlfqejwHPykMl5j3D4+++puggCOevAhsorS885vPOP0KqZkx8PvJ/YmT9JJMZBnxeHKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybDrMVHJqaonwyF5QSxFoSRVWz0WYthh4qvGlm07sThAzClFXy
	IDqF/ld0GjtASph9Gj7eTbg71kFzpS5t07FZj1VWWmhjBpY49tk5YQHD6YxLj/hyBpTRWUIaiWZ
	0Y2b76Aiv3ahgZzfzxlQ3WKa7ad6gfMjmveKQwwptv3oY+UH6Irfv+aR/A08hDu3nHqzzm3nSdy
	tH4iu5N8thscRkdfZ9LhUldifBT5/3kDf/WbIe
X-Received: by 2002:a05:690c:6d10:b0:6bf:1ca2:f6ce with SMTP id 00721157ae682-6d1527402f8mr2073657b3.11.1724796277065;
        Tue, 27 Aug 2024 15:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXBYyPy457E+8/kJj7r+nklgbvzduvQWHWpVPjZxmJNMeHMVOQ6x9b13jzENeT8Q3/xJEoVEf/Td0KOdDD3UI=
X-Received: by 2002:a05:690c:6d10:b0:6bf:1ca2:f6ce with SMTP id
 00721157ae682-6d1527402f8mr2073107b3.11.1724796276588; Tue, 27 Aug 2024
 15:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729222727.64319-1-npache@redhat.com> <72320F9D-9B6A-4ABA-9B18-E59B8382A262@nvidia.com>
 <CAA1CXcCD798gkLoZuz3Cd5-Wf2MRfnAG_EB0U3nbScZeFv09dw@mail.gmail.com>
 <CAA1CXcCCOS8-aqcm+w8Aoqe2P5q005wMrgmtx=xjzJgjKFb7mg@mail.gmail.com>
 <61411216-d196-42de-aa64-12bd28aef44f@gmail.com> <CAA1CXcCe8QDir2KiWg=GmN4BErfXSDs_9kmnYfyK=X8H8U8QwA@mail.gmail.com>
 <698ea52e-db99-4d21-9984-ad07038d4068@gmail.com> <20240827110959.GA438928@cmpxchg.org>
 <b73961a2-87ec-45a5-b6fb-83d3505a0f39@redhat.com> <20240827130544.GA460210@cmpxchg.org>
 <693a2bf0-7c18-489b-a1b4-518cf35c5aa3@redhat.com> <88b379f1-ad09-4fe5-b7a4-81fbf9d934b1@gmail.com>
In-Reply-To: <88b379f1-ad09-4fe5-b7a4-81fbf9d934b1@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 27 Aug 2024 16:04:10 -0600
Message-ID: <CAA1CXcCyRd+qfszM4GGvKqW=95AV9v8LG5oihByEBGLtW4tD4g@mail.gmail.com>
Subject: Re: [RFC 0/2] mm: introduce THP deferred setting
To: Usama Arif <usamaarif642@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Barry Song <baohua@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lance Yang <ioworker0@gmail.com>, Peter Xu <peterx@redhat.com>, 
	Rafael Aquini <aquini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:57=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 27/08/2024 09:22, David Hildenbrand wrote:
> > On 27.08.24 15:05, Johannes Weiner wrote:
> >> On Tue, Aug 27, 2024 at 01:46:26PM +0200, David Hildenbrand wrote:
> >>> On 27.08.24 13:09, Johannes Weiner wrote:
> >>>> On Tue, Aug 27, 2024 at 11:37:14AM +0100, Usama Arif wrote:
> >>>>>
> >>>>>
> >>>>> On 26/08/2024 17:14, Nico Pache wrote:
> >>>>>> On Mon, Aug 26, 2024 at 10:47=E2=80=AFAM Usama Arif <usamaarif642@=
gmail.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 26/08/2024 11:40, Nico Pache wrote:
> >>>>>>>> On Tue, Jul 30, 2024 at 4:37=E2=80=AFPM Nico Pache <npache@redha=
t.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Zi Yan,
> >>>>>>>>> On Mon, Jul 29, 2024 at 7:26=E2=80=AFPM Zi Yan <ziy@nvidia.com>=
 wrote:
> >>>>>>>>>>
> >>>>>>>>>> +Kirill
> >>>>>>>>>>
> >>>>>>>>>> On 29 Jul 2024, at 18:27, Nico Pache wrote:
> >>>>>>>>>>
> >>>>>>>>>>> We've seen cases were customers switching from RHEL7 to RHEL8=
 see a
> >>>>>>>>>>> significant increase in the memory footprint for the same wor=
kloads.
> >>>>>>>>>>>
> >>>>>>>>>>> Through our investigations we found that a large contributing=
 factor to
> >>>>>>>>>>> the increase in RSS was an increase in THP usage.
> >>>>>>>>>>
> >>>>>>>>>> Any knob is changed from RHEL7 to RHEL8 to cause more THP usag=
e?
> >>>>>>>>> IIRC, most of the systems tuning is the same. We attributed the
> >>>>>>>>> increase in THP usage to a combination of improvements in the k=
ernel,
> >>>>>>>>> and improvements in the libraries (better alignments). That all=
owed
> >>>>>>>>> THP allocations to succeed at a higher rate. I can go back and =
confirm
> >>>>>>>>> this tomorrow though.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> For workloads like MySQL, or when using allocators like jemal=
loc, it is
> >>>>>>>>>>> often recommended to set /transparent_hugepages/enabled=3Dnev=
er. This is
> >>>>>>>>>>> in part due to performance degradations and increased memory =
waste.
> >>>>>>>>>>>
> >>>>>>>>>>> This series introduces enabled=3Ddefer, this setting acts as =
a middle
> >>>>>>>>>>> ground between always and madvise. If the mapping is MADV_HUG=
EPAGE, the
> >>>>>>>>>>> page fault handler will act normally, making a hugepage if po=
ssible. If
> >>>>>>>>>>> the allocation is not MADV_HUGEPAGE, then the page fault hand=
ler will
> >>>>>>>>>>> default to the base size allocation. The caveat is that khuge=
paged can
> >>>>>>>>>>> still operate on pages thats not MADV_HUGEPAGE.
> >>>>>>>>>>
> >>>>>>>>>> Why? If user does not explicitly want huge page, why bother pr=
oviding huge
> >>>>>>>>>> pages? Wouldn't it increase memory footprint?
> >>>>>>>>>
> >>>>>>>>> So we have "always", which will always try to allocate a THP wh=
en it
> >>>>>>>>> can. This setting gives good performance in a lot of conditions=
, but
> >>>>>>>>> tends to waste memory. Additionally applications DON'T need to =
be
> >>>>>>>>> modified to take advantage of THPs.
> >>>>>>>>>
> >>>>>>>>> We have "madvise" which will only satisfy allocations that are
> >>>>>>>>> MADV_HUGEPAGE, this gives you granular control, and a lot of ti=
mes
> >>>>>>>>> these madvises come from libraries. Unlike "always" you DO need=
 to
> >>>>>>>>> modify your application if you want to use THPs.
> >>>>>>>>>
> >>>>>>>>> Then we have "never", which of course, never allocates THPs.
> >>>>>>>>>
> >>>>>>>>> Ok. back to your question, like "madvise", "defer" gives you th=
e
> >>>>>>>>> benefits of THPs when you specifically know you want them
> >>>>>>>>> (madv_hugepage), but also benefits applications that dont speci=
fically
> >>>>>>>>> ask for them (or cant be modified to ask for them), like "alway=
s"
> >>>>>>>>> does. The applications that dont ask for THPs must wait for khu=
gepaged
> >>>>>>>>> to get them (avoid insertions at PF time)-- this curbs a lot of=
 memory
> >>>>>>>>> waste, and gives an increased tunability over "always". Another=
 added
> >>>>>>>>> benefit is that khugepaged will most likely not operate on shor=
t lived
> >>>>>>>>> allocations, meaning that only longstanding memory will be coll=
apsed
> >>>>>>>>> to THPs.
> >>>>>>>>>
> >>>>>>>>> The memory waste can be tuned with max_ptes_none... lets say yo=
u want
> >>>>>>>>> ~90% of your PMD to be full before collapsing into a huge page.=
 simply
> >>>>>>>>> set max_ptes_none=3D64. or no waste, set max_ptes_none=3D0, req=
uiring the
> >>>>>>>>> 512 pages to be present before being collapsed.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> This allows for two things... one, applications specifically =
designed to
> >>>>>>>>>>> use hugepages will get them, and two, applications that don't=
 use
> >>>>>>>>>>> hugepages can still benefit from them without aggressively in=
serting
> >>>>>>>>>>> THPs at every possible chance. This curbs the memory waste, a=
nd defers
> >>>>>>>>>>> the use of hugepages to khugepaged. Khugepaged can then scan =
the memory
> >>>>>>>>>>> for eligible collapsing.
> >>>>>>>>>>
> >>>>>>>>>> khugepaged would replace application memory with huge pages wi=
thout specific
> >>>>>>>>>> goal. Why not use a user space agent with process_madvise() to=
 collapse
> >>>>>>>>>> huge pages? Admin might have more knobs to tweak than khugepag=
ed.
> >>>>>>>>>
> >>>>>>>>> The benefits of "always" are that no userspace agent is needed,=
 and
> >>>>>>>>> applications dont have to be modified to use madvise(MADV_HUGEP=
AGE) to
> >>>>>>>>> benefit from THPs. This setting hopes to gain some of the same
> >>>>>>>>> benefits without the significant waste of memory and an increas=
ed
> >>>>>>>>> tunability.
> >>>>>>>>>
> >>>>>>>>> future changes I have in the works are to make khugepaged more
> >>>>>>>>> "smart". Moving it away from the round robin fashion it current=
ly
> >>>>>>>>> operates in, to instead make smart and informed decisions of wh=
at
> >>>>>>>>> memory to collapse (and potentially split).
> >>>>>>>>>
> >>>>>>>>> Hopefully that helped explain the motivation for this new setti=
ng!
> >>>>>>>>
> >>>>>>>> Any last comments before I resend this?
> >>>>>>>>
> >>>>>>>> Ive been made aware of
> >>>>>>>> https://lore.kernel.org/all/20240730125346.1580150-1-usamaarif64=
2@gmail.com/T/#u
> >>>>>>>> which introduces THP splitting. These are both trying to achieve=
 the
> >>>>>>>> same thing through different means. Our approach leverages khuge=
paged
> >>>>>>>> to promote pages, while Usama's uses the reclaim path to demote
> >>>>>>>> hugepages and shrink the underlying memory.
> >>>>>>>>
> >>>>>>>> I will leave it up to reviewers to determine which is better; Ho=
wever,
> >>>>>>>> we can't have both, as we'd be introducing trashing conditions.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Just inserting this here from my cover letter:
> >>>>>>>
> >>>>>>> Waiting for khugepaged to scan memory and
> >>>>>>> collapse pages into THP can be slow and unpredictable in terms of=
 performance
> >>>>>> Obviously not part of my patchset here, but I have been testing so=
me
> >>>>>> changes to khugepaged to make it more aware of what processes are =
hot.
> >>>>>> Ideally then it can make better choices of what to operate on.
> >>>>>>> (i.e. you dont know when the collapse will happen), while product=
ion
> >>>>>>> environments require predictable performance. If there is enough =
memory
> >>>>>>> available, its better for both performance and predictability to =
have
> >>>>>>> a THP from fault time, i.e. THP=3Dalways rather than wait for khu=
gepaged
> >>>>>>> to collapse it, and deal with sparsely populated THPs when the sy=
stem is
> >>>>>>> running out of memory.
> >>>>>>>
> >>>>>>> I just went through your patches, and am not sure why we can't ha=
ve both?
> >>>>>> Fair point, we can. I've been playing around with splitting hugepa=
ges
> >>>>>> and via khugepaged and was thinking of the trashing conditions the=
re--
> >>>>>> but your implementation takes a different approach.
> >>>>>> I've been working on performance testing my "defer" changes, once =
I
> >>>>>> find the appropriate workloads I'll try adding your changes to the
> >>>>>> mix. I have a feeling my approach is better for latency sensitive
> >>>>>> workloads, while yours is better for throughput, but let me find a=
 way
> >>>>>> to confirm that.
> >>>>>>
> >>>>>>
> >>>>> Hmm, I am not sure if its latency vs throughput.
> >>>>>
> >>>>> There are 2 things we probably want to consider, short lived and lo=
ng lived mappings, and
> >>>>> in each of these situations, having enough memory and running out o=
f memory.
> >>>>>
> >>>>> For short lived mappings, I believe reducing page faults is a bigge=
r factor in
> >>>>> improving performance. In that case, khugepaged won't have enough t=
ime to work,
> >>>>> so THP=3Dalways will perform better than THP=3Ddefer. THP=3Ddefer i=
n this case will perform
> >>>>> the same as THP=3Dmadvise?
> >>>>> If there is enough memory, then the changes I introduced in the shr=
inker won't cost anything
> >>>>> as the shrinker won't run, and the system performance will be the s=
ame as THP=3Dalways.
> >>>>> If there is low memory and the shrinker runs, it will only split TH=
Ps that have zero-filled
> >>>>> pages more than max_ptes_none, and map the zero-filled pages to sha=
red zero-pages saving memory.
> >>>>> There is ofcourse a cost to splitting and running the shrinker, but=
 hopefully it only splits
> >>>>> underused THPs.
> >>>>>
> >>>>> For long lived mappings, reduced TLB misses would be the bigger fac=
tor in improving performance.
> >>>>> For the initial run of the application THP=3Dalways will perform be=
tter wrt TLB misses as
> >>>>> page fault handler will give THPs from start.
> >>>>> Later on in the run, the memory might look similar between THP=3Dal=
ways with shrinker and
> >>>>> max_ptes_none < HPAGE_PMD_NR vs THP=3Ddefer and max_ptes_none < HPA=
GE_PMD_NR?
> >>>>> This is because khugepaged will have collapsed pages that might hav=
e initially been faulted in.
> >>>>> And collapsing has a cost, which would not have been incurred if th=
e THPs were present from fault.
> >>>>> If there is low memory, then shrinker would split memory (which has=
 a cost as well) and the system
> >>>>> memory would look similar or better than THP=3Ddefer, as the shrink=
er would split THPs that initially
> >>>>> might not have been underused, but are underused at time of memory =
pressure.
> >>>>>
> >>>>> With THP=3Dalways + underused shrinker, the cost (splitting) is inc=
urred only if needed and when its needed.
> >>>>> While with THP=3Ddefer the cost (higher page faults, higher TLB mis=
ses + khugepaged collapse) is incurred all the time,
> >>>>> even if the system might have plenty of memory available and there =
is no need to take a performance hit.
> >>>>
> >>>> I agree with this. The defer mode is an improvement over the upstrea=
m
> >>>> status quo, no doubt. However, both defer mode and the shrinker solv=
e
> >>>> the issue of memory waste under pressure, while the shrinker permits
> >>>> more desirable behavior when memory is abundant.
> >>>>
> >>>> So my take is that the shrinker is the way to go, and I don't see a
> >>>> bonafide usecase for defer mode that the shrinker couldn't cover.
> >>>
> >>> Page fault latency? IOW, zeroing a complete THP, which might be up to
> >>> 512 MiB on arm64. This is one of the things people bring up, where
> >>> FreeBSD is different because it will zero fragments on-demand (but al=
so
> >>> result in more pagefaults).
> >>
> >> Good point, I suppose this could matter to some workloads. Would be
> >> interesting to get real world data on that if that's the argument.
> >
> > IIRC, there is mentioning about some of these workloads in THP optimiza=
tion papers, where even the cost of defragmenation+reclaim+zeroing of 2MiB =
apparently affects some latency-sensitive workloads.
> >
> > But the challenge that THP-deferred and the shrinker is trying to solve=
 right now is more towards memory over-allocation, and for the the shrinker=
 should *mostly* be able to do what the deferred option would achieve.
> >
>
> I would say underused shrinker is trying to solve memory over-allocation =
due to THP=3Dalways *while* trying to preserve the performance benefits of =
THP=3Dalways,
> which THP=3Ddefer might not achieve with the same performance due to more=
 running costs?
>
> > There are these corner cases where a workload accesses some pages and t=
hen long-term pins them (e.g., iouring fixed buffers), where the over-allco=
ation cannot be reclaimed until the longterm pin is gone.
> >
> > But it's not been raised to be a real problem in practice, so I'm just =
mentioning it as a key difference: the shrinker runs after memory over-allo=
cation with the cost of memory scanning and temporary memory overallcoation=
+zeroing. "deferred" avoids memory over-allocation, with the cost of more p=
age faults + relying on khugepaged making progress.
> >
> and the deferred option also has the cost of higher TLB misses (which can=
 be quite significant) when the pages haven't collapsed yet,
> and all of these are costs that shouldn't even be incurred if the system =
has plenty of memory.
>
> If there aren't many underused pages, then for long-term mappings, the me=
mory would look similar in both cases after sometime?
> as khugepaged would just collapse pages that would just have been there f=
rom page fault in THP=3Dalways (especially if khugepaged
> is made more affective). In that case, the shrinker solution would have h=
ad no cost for that time (or maybe just page fault
> latency?), while THP=3Ddefer would incur all the 3 costs?
>
> Both solutions do have their pros and cons and I am not against having TH=
P=3Ddefer. But I do feel the shrinker is a better solution
> with the experiments in Meta production [1] and only having to incur a co=
st if and when needed. I could be biased as well :)

I agree, they both do have pros and cons, and I think the shrinker
solution is the better solution for the "always" approach. It's
important to remember that "defer" isn't necessarily trying to beat
"always". It's closer in behavior to "madvise", but with the added
benefit that applications that need to be "transparent" (no madv
calls) can still leverage THPs.

I will try to find some latency benchmarks to show that "always" can
negatively impact latency in some cases, and "madvise" (or "defer")
would be the better solution for that workload. In these cases the
defer solution would be allowing applications to transparently benefit
from THPs and reduce their TLB pressure over time, without incurring
the latency penalty associated with requesting a THP at fault.

>
> [1] https://lore.kernel.org/all/20240819023145.2415299-1-usamaarif642@gma=
il.com/#t
>
> >>
> >> Btw, I'm curious if anybody actually uses or tried to use 512MB
> >> THPs. I understand it's technically possible, and there are usecases
> >> for 1G pages through static hugetlb management, but 512M seems wild
> >> for a "real" page size - real as in: allocated on-demand and actually
> >> paged to/from storage.
> >
> > I think it's less a matter of "using" or trying", but more THPs being d=
efault enabled in many setups nowadays, and if you have sufficient memory i=
n the system, even these weird 512MiB THPs will up in your address space if=
 a (sparse) VMA is large enough :)
> >
>
> The page fault latency is a good point for ARM servers. I would imagine m=
ore ARM servers run with 64K page size compared to 4K, and if the default c=
onfig option for THP is not changed, then we could run into 512M THPs!
>
>


