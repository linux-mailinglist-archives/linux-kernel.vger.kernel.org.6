Return-Path: <linux-kernel+bounces-261929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8593BDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E47A1C21B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A2B1741EE;
	Thu, 25 Jul 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JP+QJyDi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918F1741D4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896008; cv=none; b=s9938uZKiA7XhAtp9VgvSI/mcXEFxgpBS6Je9+lOcZtro2sUhmFsIH98H4f03FKucxmrHAiKDoefLbVq6En50tnW6BNCGfvgmLMYnvAwovJqe+hFanFajs6jwMx9VQnokAdYfjC7ja78MraPXkEpzESTpJT5ARS13oVH1XK9Ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896008; c=relaxed/simple;
	bh=xp5v3xvteTsPPJ7bYkwMNXOoGC5QquTwxqSS2pRKDeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQitbbEZVM3u9LFNmokjvTewBDYrRwHzwcReXbTCEHwIuLtZiWcmL4EmNLxQzLTQBjI27FSCidyXgTs7GE/1+KzRlnq9JuiiA4IuBYRJnHq5IIytF75SAmffT+uW2lH57uy12jYProHNPIXa0TzNlY0ByjeOcAfWGq08joyPc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JP+QJyDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE219C116B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721896007;
	bh=xp5v3xvteTsPPJ7bYkwMNXOoGC5QquTwxqSS2pRKDeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JP+QJyDihQtezD6YQVtLhT+gMQ8fqgTZwWPxcoq7uHv8M+QobsC+arAK4WueNhXXk
	 sELr2oHgClMvby3iDtVXLSi/2QWmILCy9WHEJ30kMHKCOQ0zFbgSK5XABcDvck8A2g
	 TZaElrcMZJOAcPObIvYb8z4gGXlYnDDV3Bq8Dzd/5NGm6gr707B3jNAgce05z33oRG
	 7eqKnpmfqZixss9IMvD5lGrSa9AhafR81+P1MUxDe1aKIt9KT0AvX0I55LIBuIMoTq
	 Jb08hMUwKcpahpx8R9Xw0hiPK43/WjWjo9A8UCAj3u0g4FM+kq15dIRRCT8mXNLGjC
	 5uM2BBOtWHuQg==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66599ca3470so6778877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWWunXSXcuy+lvs6dh85v8yB75hJlCw1pByJmU0cIi8JbDpCVMSJ2EwpUes9UY32PFJF4HNZbJFYdrhvLiFprnuf5teEyq8C97GASx
X-Gm-Message-State: AOJu0YyJ1u2t1Qv7C5kByU0kYQkyBSfl251LvdyKN7mnw4sTdt/6mH3h
	5/TQsX008s0CS5832VhrS9jdpgOq6DuIF/qTJMfKAAAG9FBoC3SBAPAHUTMbngQbdUgzzpzEcP0
	TGSJx1mpoa4/I8Cq6JbA6a3sMQahNJ2ZRor2o9w==
X-Google-Smtp-Source: AGHT+IGsYa02oRka4AOXVuwAVZ2lR63njzFT8t6F0TK/+NeIbBi6vQNSRURxfGWtLGHjUbTARFFSrawU0eqBbYGYaFU=
X-Received: by 2002:a0d:cdc4:0:b0:650:9799:41d2 with SMTP id
 00721157ae682-675b9b600c9mr11879527b3.30.1721896007042; Thu, 25 Jul 2024
 01:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org> <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
 <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
 <b4b31314-1125-40ee-b784-20abc78bd468@arm.com> <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
 <874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com> <a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
 <87o76qjhqs.fsf@yhuang6-desk2.ccr.corp.intel.com> <43f73463-af42-4a00-8996-5f63bdf264a3@arm.com>
 <87jzhdkdzv.fsf@yhuang6-desk2.ccr.corp.intel.com> <f6fa3965-38db-4bdc-b6fd-6cd472169322@arm.com>
 <87sew0ei84.fsf@yhuang6-desk2.ccr.corp.intel.com> <4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
 <87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87le1q6jyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 25 Jul 2024 01:26:36 -0700
X-Gmail-Original-Message-ID: <CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
Message-ID: <CACePvbXu268d2cBmm0a2Azr3=Aum19cSgY+7YijESrBCVK3a9w@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:57=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Ryan Roberts <ryan.roberts@arm.com> writes:
>
> > On 23/07/2024 07:27, Huang, Ying wrote:
> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>
> >>> On 22/07/2024 09:49, Huang, Ying wrote:
> >>>> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>>>
> >>>>> On 22/07/2024 03:14, Huang, Ying wrote:
> >>>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>>>>>
> >>>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
> >>>>>>>> Chris Li <chrisl@kernel.org> writes:
> >>>>>>>>
> >>>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.robe=
rts@arm.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
> >>>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.ro=
berts@arm.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
> >>>>>>
> >>>>>> [snip]
> >>>>>>
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >>>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters=
[ci->order]);
> >>>>>>>>>>>>
> >>>>>>>>>>>> I find the transitions when you add and remove a cluster fro=
m the
> >>>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood corr=
ectly): It is added
> >>>>>>>>>>>> to the list whenever there is at least one free swap entry i=
f not already on the
> >>>>>>>>>>>> list. But you take it off the list when assigning it as the =
current cluster for
> >>>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
> >>>>>>>>>>>>
> >>>>>>>>>>>> So you could have this situation:
> >>>>>>>>>>>>
> >>>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cp=
u)
> >>>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
> >>>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
> >>>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
> >>>>>>>>>>>>
> >>>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as t=
heir current
> >>>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_clus=
ters list at
> >>>>>>>>>>>> allocation time (when removed from free_list) and only remov=
e it from the
> >>>>>>>>>>>
> >>>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free =
list and
> >>>>>>>>>>> moving it into nonfull.
> >>>>>>>>>>
> >>>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation fr=
om
> >>>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring o=
f the code to
> >>>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to =
see the
> >>>>>>>>>> refactoring separated from behavioural changes.
> >>>>>>>>>
> >>>>>>>>> It is not a refactoring. It is a big rewrite of the swap alloca=
tor
> >>>>>>>>> using the cluster. Behavior change is expected. The goal is com=
pletely
> >>>>>>>>> removing the brute force scanning of swap_map[] array for clust=
er swap
> >>>>>>>>> allocation.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Since the patch was titled RFC and I thought it was just refac=
toring, I was
> >>>>>>>>>> deferring review. But sounds like it is actually required to r=
ealize the test
> >>>>>>>>>> results quoted on the cover letter?
> >>>>>>>>>
> >>>>>>>>> Yes, required because it handles the previous fall out case try=
_ssd()
> >>>>>>>>> failed. This big rewrite has gone through a lot of testing and =
bug
> >>>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC =
is
> >>>>>>>>> because it is not feature complete. Currently it does not do sw=
ap
> >>>>>>>>> cache reclaim. The next version will have swap cache reclaim an=
d
> >>>>>>>>> remove the RFC.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> I am only making the minimal change in this step so the big r=
ewrite can land.
> >>>>>>>>>>>
> >>>>>>>>>>>> nonfull_clusters list when it is completely full (or at leas=
t definitely doesn't
> >>>>>>>>>>>> have room for an `order` allocation)? Then you allow "steali=
ng" always instead
> >>>>>>>>>>>> of just sometimes. You would likely want to move the cluster=
 to the end of the
> >>>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_clus=
ter() to reduce the
> >>>>>>>>>>>> chances of multiple CPUs using the same cluster.
> >>>>>>>>>>>
> >>>>>>>>>>> For nonfull clusters it is less important to avoid multiple C=
PU
> >>>>>>>>>>> sharing the cluster. Because the cluster already has previous=
 swap
> >>>>>>>>>>> entries allocated from the previous CPU.
> >>>>>>>>>>
> >>>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogica=
l case where cpuA
> >>>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the=
 free pages and
> >>>>>>>>>
> >>>>>>>>> That happens to exist per cpu next pointer already. When the ot=
her CPU
> >>>>>>>>> advances to the next cluster pointer, it can cross with the oth=
er
> >>>>>>>>> CPU's next cluster pointer.
> >>>>>>>>
> >>>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per c=
pu
> >>>>>>>> cluster only.  If it doesn't do that, we should fix it.
> >>>>>>>>
> >>>>>>>> I agree with Ryan that we should make per cpu cluster correct.  =
A
> >>>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  Wh=
en we
> >>>>>>>> scan to the end of a per cpu cluster, we can put the cluster in =
nonfull
> >>>>>>>> list if necessary.  And, we should make it correct in this patch=
 instead
> >>>>>>>> of later in series.  I understand that you want to make the patc=
h itself
> >>>>>>>> simple, but it's important to make code simple to be understood =
too.
> >>>>>>>> Consistent design choice will do that.
> >>>>>>>
> >>>>>>> I think I'm actually arguing for the opposite of what you suggest=
 here.
> >>>>>>
> >>>>>> Sorry, I misunderstood your words.
> >>>>>>
> >>>>>>> As I see it, there are 2 possible approaches; either a cluster is=
 always
> >>>>>>> considered exclusive to a single cpu when its set as a per-cpu cl=
uster, so it
> >>>>>>> does not appear on the nonfull list. Or a cluster is considered s=
harable in this
> >>>>>>> case, in which case it should be added to the nonfull list.
> >>>>>>>
> >>>>>>> The code at the moment sort of does both; when a cpu decides to u=
se a cluster in
> >>>>>>> the nonfull list, it removes it from that list to make it exclusi=
ve. But as soon
> >>>>>>> as a single swap entry is freed from that cluster it is put back =
on the list.
> >>>>>>> This neither-one-policy-nor-the-other seems odd to me.
> >>>>>>>
> >>>>>>> I think Huang, Ying is arguing to keep it always exclusive while =
installed as a
> >>>>>>> per-cpu cluster.
> >>>>>>
> >>>>>> Yes.
> >>>>>>
> >>>>>>> I was arguing to make it always shared. Perhaps the best
> >>>>>>> approach is to implement the exclusive policy in this patch (you'=
d need a flag
> >>>>>>> to note if any pages were freed while in exclusive use, then when=
 exclusive use
> >>>>>>> completes, put it back on the nonfull list if the flag was set). =
Then migrate to
> >>>>>>> the shared approach as part of the "big rewrite"?
> >>>>>>>>
> >>>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I =
think do want to
> >>>>>>>>>> share the cluster when you really need to, but try to avoid it=
 if there are
> >>>>>>>>>> other options, and I think moving the cluster to the end of th=
e list might be a
> >>>>>>>>>> way to help that?
> >>>>>>>>>
> >>>>>>>>> Simply moving to the end of the list can create a possible dead=
loop
> >>>>>>>>> when all clusters have been scanned and not available swap rang=
e
> >>>>>>>>> found.
> >>>>>>
> >>>>>> I also think that the shared approach has dead loop issue.
> >>>>>
> >>>>> What exactly do you mean by dead loop issue? Perhaps you are sugges=
ting the code
> >>>>> won't know when to stop dequeing/requeuing clusters on the nonfull =
list and will
> >>>>> go forever? That's surely just an implementation issue to solve? It=
's not a
> >>>>> reason to avoid the design principle; if we agree that maintaining =
sharability
> >>>>> of the cluster is preferred then the code must be written to guard =
against the
> >>>>> dead loop problem. It could be done by remembering the first cluste=
r you
> >>>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when =
you get back
> >>>>> to it. (I think holding the si lock will protect against concurrent=
ly freeing
> >>>>> the cluster so it should definitely remain in the list?).
> >>>>
> >>>> I believe that you can find some way to avoid the dead loop issue,
> >>>> although your suggestion may kill the performance via looping a long=
 list
> >>>> of nonfull clusters.
> >>>
> >>> I don't agree; If the clusters are considered exclusive (i.e. removed=
 from the
> >>> list when made current for a cpu), that only reduces the size of the =
list by a
> >>> maximum of the number of CPUs in the system, which I suspect is prett=
y small
> >>> compared to the number of nonfull clusters.
> >>
> >> Anyway, this depends on details.  If we cannot allocate a order-N swap
> >> entry from the cluster, we should remove it from the nonfull list for
> >> order-N (This is the behavior of this patch too).
> >
> > Yes that's a good point, and I conceed it is more difficult to detect t=
hat
> > condition if the cluster is shared. I suspect that with a bit of thinki=
ng, we
> > could find a way though.
> >
> >> Your original
> >> suggestion appears like that you want to keep all cluster with order-N
> >> on the nonfull list for order-N always unless the number of free swap
> >> entry is less than 1<<N.
> >
> > Well I think that's certainly one of the conditions for removing it. Bu=
t agree
> > that if a full scan of the cluster has been performed and no swap entri=
es have
> > been freed since the scan started then it should also be removed from t=
he list.
> >
> >>
> >>>> And, I understand that in some situations it may
> >>>> be better to share clusters among CPUs.  So my suggestion is,
> >>>>
> >>>> - Make swap_cluster_info->order more accurate, don't pretend that we
> >>>>   have free swap entries with that order even after we are sure that=
 we
> >>>>   haven't.
> >>>
> >>> Is this patch pretending that today? I don't think so?
> >>
> >> IIUC, in this patch swap_cluster_info->order is still "N" even if we a=
re
> >> sure that there are no order-N free swap entry in the cluster.
> >
> > Oh I see what you mean. I think you and Chris already discussed this? I=
IRC
> > Chris's point was that if you move that cluster to N-1, eventually all =
clusters
> > are for order-0 and you have no means of allocating high orders until a=
 whole
> > cluster becomes free. That logic certainly makes sense to me, so think =
its
> > better for swap_cluster_info->order to remain static while the cluster =
is
> > allocated. (I only skimmed that conversation so appologies if I got the
> > conclusion wrong!).
> >
> >>
> >>> But I agree that a
> >>> cluster should only be on the per-order nonfull list if we know there=
 are at
> >>> least enough free swap entries in that cluster to cover the order. Of=
 course
> >>> that doesn't tell us for sure because they may not be contiguous.
> >>
> >> We can check that when free swap entry via checking adjacent swap
> >> entries.  IMHO, the performance should be acceptable.
> >
> > Would you then use the result of that scanning to "promote" a cluster's=
 order?
> > e.g. swap_cluster_info->order =3D N+1? That would be neat. But this all=
 feels like
> > a separate change on top of what Chris is doing here. For high orders t=
here
> > could be quite a bit of scanning required in the worst case for every p=
age that
> > gets freed.
>
> We can try to optimize it to control overhead if necessary.
>
> >>
> >>>>
> >>>> My question is whether it's so important to share the per-cpu cluste=
r
> >>>> among CPUs?
> >>>
> >>> My rationale for sharing is that the preference previously has been t=
o favour
> >>> efficient use of swap space; we don't want to fail a request for allo=
cation of a
> >>> given order if there are actually slots available just because they h=
ave been
> >>> reserved by another CPU. And I'm still asserting that it should be ~z=
ero cost to
> >>> do this. If I'm wrong about the zero cost, or in practice the sharing=
 doesn't
> >>> actually help improve allocation success, then I'm happy to take the =
exclusive
> >>> approach.
> >>>
> >>>> I suggest to start with simple design, that is, per-CPU
> >>>> cluster will not be shared among CPUs in most cases.
> >>>
> >>> I'm all for starting simple; I think that's what I already proposed (=
exclusive
> >>> in this patch, then shared in the "big rewrite"). I'm just objecting =
to the
> >>> current half-and-half policy in this patch.
> >>
> >> Sounds good to me.  We can start with exclusive solution and evaluate
> >> whether shared solution is good.
> >
> > Yep. And also evaluate the dynamic order inc/dec idea too...
>
> Dynamic order inc/dec tries solving a more fundamental problem.  For
> example,
>
> - Initially, almost only order-0 pages are swapped out, most non-full
>   clusters are order-0.
>
> - Later, quite some order-0 swap entries are freed so that there are
>   quite some order-4 swap entries available.

If the freeing of swap entry is random distribution. You need 16
continuous swap entries free at the same time at aligned 16 base
locations. The total number of order 4 free swap space add up together
is much lower than the order 0 allocatable swap space.
If having one entry free is 50% probability(swapfile half full), then
having 16 swap entries is continually free is (0.5) EXP 16 =3D 1.5 E-5.
If the swapfile is 80% full, that number drops to 6.5 E -12.

> - Order-4 pages need to be swapped out, but no enough order-4 non-full
>   clusters available.

Exactly.

>
> So, we need a way to migrate non-full clusters among orders to adjust to
> the various situations automatically.

There is no easy way to migrate swap entries to different locations.
That is why I like to have discontiguous swap entries allocation for
mTHP.

>
> But yes, data is needed for any performance related change.

Chris

