Return-Path: <linux-kernel+bounces-261573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B993B92C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D771F23EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486D13CA93;
	Wed, 24 Jul 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnolvQn9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800D200B7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721860872; cv=none; b=GFbJvudG0W3Cf0piNkR5Odt/cVKxg9h3wgwyAUv6q+b0qgV3XvPQKa58LjbTS68mfX15d8Tl2eNxU+D7pilA8xOaP/szaxBzlZfcSEqHRW9ORrmBxjt+rHMF0Jl928Xh+BtuprNq8nvXmfWm2fO3EQDmis68FjHGwwc3MRyoTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721860872; c=relaxed/simple;
	bh=sUv+Id0eIoOTaJNj7dvLtPTXgAPMGzBVAsjRpXk9JOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMPgkm0PHnSpwGILyP3GJaEHXSGIaynZ6YJYGXB6b2lsTGWGiSXSOMj/kBVH92geeFVhYxHgm9v1VB8WNQ3jqCX39NYB8PeMbkiXkkqLcj7aXMJOpwhiWPM+tOk/b/NJdSHcKGpUxEXCrNoYTmKoC4OYKBJOe46rNV16NRUhlYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnolvQn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47273C32781
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 22:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721860872;
	bh=sUv+Id0eIoOTaJNj7dvLtPTXgAPMGzBVAsjRpXk9JOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EnolvQn9Kx4u1LXXSmdUL19ujEiictfetqD2WSLgypnLBXZnhssz+wFApF40WKsHM
	 z++eIabVTe37TgwX7P5MX/ZSOI6N0HfF7uo3Rv24paw7O2Lxjh7nRcqbtIJ1o2OUM4
	 eWMV+Vj2JNmDJ+ZNqnD8p3Ah5hIrAKPiu8Yon6IDuLaTr5f1wOgKci9tgq+cLUQQUY
	 u5ln3iNu+eG7D8B9Mo8ZQVbRBPMbxmFWul65htcTgE03W0jYLu9oKWp1L+/9rBfNcr
	 1T5q/mEDSmlRrYutoDVZnCx0SVcSPwxtuZOfJeda57NpARLQVKLJfcwRDoRx0bMt1A
	 xSpDeclxRUnjA==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-664ccd158b0so2660867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW38AlkTKGtwuv+/0nxKBma9/XfgdfNim1IFXi09N5aByU2d7kwTVVjceRBVtRdiPdQSgzk077TiCSMZYgTEwtBF1bXtkGo6K/hm5/g
X-Gm-Message-State: AOJu0YxcVsKsEumQJG/XQOGEViAy+2yZRIiaOnTf1FpQ3QwujSOwmHGT
	q6G6AjhKd+sgxt2bcXJ0lOgmFQmQb2rYoZ7CsMmkW0FJcvvkbKtU4PmbifkuG1Rrql079skTcmI
	7TRdrjTysHkOCgKC7wH6wW8dR6+hL8AlPzOm6cQ==
X-Google-Smtp-Source: AGHT+IH/L2agrkEU4Sg09H3WUUkn1utIOoNK1Fv0hDuYNFlhS7E70affDpbTNpWw9VNMgISKdRC/476yNEI1CTbEXiI=
X-Received: by 2002:a81:8741:0:b0:643:4879:3399 with SMTP id
 00721157ae682-67510dee987mr10312617b3.6.1721860871385; Wed, 24 Jul 2024
 15:41:11 -0700 (PDT)
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
In-Reply-To: <4ec149fc-7c13-4777-bc97-58ee455a3d7e@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 24 Jul 2024 15:41:00 -0700
X-Gmail-Original-Message-ID: <CACePvbV9cx6Le1cYgYo2D922E4Com45+XXquMZugog2+w5K_yg@mail.gmail.com>
Message-ID: <CACePvbV9cx6Le1cYgYo2D922E4Com45+XXquMZugog2+w5K_yg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull list
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan and Ying,

Sorry I was busy. I am catching up on the email now.

On Wed, Jul 24, 2024 at 1:33=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 23/07/2024 07:27, Huang, Ying wrote:
> > Ryan Roberts <ryan.roberts@arm.com> writes:
> >
> >> On 22/07/2024 09:49, Huang, Ying wrote:
> >>> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>>
> >>>> On 22/07/2024 03:14, Huang, Ying wrote:
> >>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>>>>
> >>>>>> On 18/07/2024 08:53, Huang, Ying wrote:
> >>>>>>> Chris Li <chrisl@kernel.org> writes:
> >>>>>>>
> >>>>>>>> On Wed, Jul 17, 2024 at 3:14=E2=80=AFAM Ryan Roberts <ryan.rober=
ts@arm.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On 16/07/2024 23:46, Chris Li wrote:
> >>>>>>>>>> On Mon, Jul 15, 2024 at 8:40=E2=80=AFAM Ryan Roberts <ryan.rob=
erts@arm.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On 11/07/2024 08:29, Chris Li wrote:
> >>>>>
> >>>>> [snip]
> >>>>>
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >>>>>>>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[=
ci->order]);
> >>>>>>>>>>>
> >>>>>>>>>>> I find the transitions when you add and remove a cluster from=
 the
> >>>>>>>>>>> nonfull_clusters list a bit strange (if I've understood corre=
ctly): It is added
> >>>>>>>>>>> to the list whenever there is at least one free swap entry if=
 not already on the
> >>>>>>>>>>> list. But you take it off the list when assigning it as the c=
urrent cluster for
> >>>>>>>>>>> a cpu in scan_swap_map_try_ssd_cluster().
> >>>>>>>>>>>
> >>>>>>>>>>> So you could have this situation:
> >>>>>>>>>>>
> >>>>>>>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu=
)
> >>>>>>>>>>>   - cpuA allocs 1 swap entry from current cluster
> >>>>>>>>>>>   - swap entry is freed; cluster added to nonfull_clusters
> >>>>>>>>>>>   - cpuB "allocs" cluster from nonfull_clusters
> >>>>>>>>>>>
> >>>>>>>>>>> At this point both cpuA and cpuB share the same cluster as th=
eir current
> >>>>>>>>>>> cluster. So why not just put the cluster on the nonfull_clust=
ers list at
> >>>>>>>>>>> allocation time (when removed from free_list) and only remove=
 it from the
> >>>>>>>>>>
> >>>>>>>>>> The big rewrite on patch 3 does that, taking it off the free l=
ist and
> >>>>>>>>>> moving it into nonfull.
> >>>>>>>>>
> >>>>>>>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation fro=
m
> >>>>>>>>> scan_swap_map_slots()" I assumed that was just a refactoring of=
 the code to
> >>>>>>>>> separate the SSD and HDD code paths. Personally I'd prefer to s=
ee the
> >>>>>>>>> refactoring separated from behavioural changes.
> >>>>>>>>
> >>>>>>>> It is not a refactoring. It is a big rewrite of the swap allocat=
or
> >>>>>>>> using the cluster. Behavior change is expected. The goal is comp=
letely
> >>>>>>>> removing the brute force scanning of swap_map[] array for cluste=
r swap
> >>>>>>>> allocation.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Since the patch was titled RFC and I thought it was just refact=
oring, I was
> >>>>>>>>> deferring review. But sounds like it is actually required to re=
alize the test
> >>>>>>>>> results quoted on the cover letter?
> >>>>>>>>
> >>>>>>>> Yes, required because it handles the previous fall out case try_=
ssd()
> >>>>>>>> failed. This big rewrite has gone through a lot of testing and b=
ug
> >>>>>>>> fix. It is pretty stable now. The only reason I keep it as RFC i=
s
> >>>>>>>> because it is not feature complete. Currently it does not do swa=
p
> >>>>>>>> cache reclaim. The next version will have swap cache reclaim and
> >>>>>>>> remove the RFC.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> I am only making the minimal change in this step so the big re=
write can land.
> >>>>>>>>>>
> >>>>>>>>>>> nonfull_clusters list when it is completely full (or at least=
 definitely doesn't
> >>>>>>>>>>> have room for an `order` allocation)? Then you allow "stealin=
g" always instead
> >>>>>>>>>>> of just sometimes. You would likely want to move the cluster =
to the end of the
> >>>>>>>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_clust=
er() to reduce the
> >>>>>>>>>>> chances of multiple CPUs using the same cluster.
> >>>>>>>>>>
> >>>>>>>>>> For nonfull clusters it is less important to avoid multiple CP=
U
> >>>>>>>>>> sharing the cluster. Because the cluster already has previous =
swap
> >>>>>>>>>> entries allocated from the previous CPU.
> >>>>>>>>>
> >>>>>>>>> But if 2 CPUs have the same cluster, isn't there a pathalogical=
 case where cpuA
> >>>>>>>>> could be slightly ahead of cpuB so that cpuA allocates all the =
free pages and
> >>>>>>>>
> >>>>>>>> That happens to exist per cpu next pointer already. When the oth=
er CPU
> >>>>>>>> advances to the next cluster pointer, it can cross with the othe=
r
> >>>>>>>> CPU's next cluster pointer.
> >>>>>>>
> >>>>>>> No.  si->percpu_cluster[cpu].next will keep in the current per cp=
u
> >>>>>>> cluster only.  If it doesn't do that, we should fix it.
> >>>>>>>
> >>>>>>> I agree with Ryan that we should make per cpu cluster correct.  A
> >>>>>>> cluster in per cpu cluster shouldn't be put in nonfull list.  Whe=
n we
> >>>>>>> scan to the end of a per cpu cluster, we can put the cluster in n=
onfull
> >>>>>>> list if necessary.  And, we should make it correct in this patch =
instead
> >>>>>>> of later in series.  I understand that you want to make the patch=
 itself
> >>>>>>> simple, but it's important to make code simple to be understood t=
oo.
> >>>>>>> Consistent design choice will do that.
> >>>>>>
> >>>>>> I think I'm actually arguing for the opposite of what you suggest =
here.
> >>>>>
> >>>>> Sorry, I misunderstood your words.
> >>>>>
> >>>>>> As I see it, there are 2 possible approaches; either a cluster is =
always
> >>>>>> considered exclusive to a single cpu when its set as a per-cpu clu=
ster, so it
> >>>>>> does not appear on the nonfull list. Or a cluster is considered sh=
arable in this
> >>>>>> case, in which case it should be added to the nonfull list.
> >>>>>>
> >>>>>> The code at the moment sort of does both; when a cpu decides to us=
e a cluster in
> >>>>>> the nonfull list, it removes it from that list to make it exclusiv=
e. But as soon
> >>>>>> as a single swap entry is freed from that cluster it is put back o=
n the list.
> >>>>>> This neither-one-policy-nor-the-other seems odd to me.
> >>>>>>
> >>>>>> I think Huang, Ying is arguing to keep it always exclusive while i=
nstalled as a
> >>>>>> per-cpu cluster.
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>>> I was arguing to make it always shared. Perhaps the best
> >>>>>> approach is to implement the exclusive policy in this patch (you'd=
 need a flag
> >>>>>> to note if any pages were freed while in exclusive use, then when =
exclusive use
> >>>>>> completes, put it back on the nonfull list if the flag was set). T=
hen migrate to
> >>>>>> the shared approach as part of the "big rewrite"?
> >>>>>>>
> >>>>>>>>> cpuB just ends up scanning and finding nothing to allocate. I t=
hink do want to
> >>>>>>>>> share the cluster when you really need to, but try to avoid it =
if there are
> >>>>>>>>> other options, and I think moving the cluster to the end of the=
 list might be a
> >>>>>>>>> way to help that?
> >>>>>>>>
> >>>>>>>> Simply moving to the end of the list can create a possible deadl=
oop
> >>>>>>>> when all clusters have been scanned and not available swap range
> >>>>>>>> found.
> >>>>>
> >>>>> I also think that the shared approach has dead loop issue.
> >>>>
> >>>> What exactly do you mean by dead loop issue? Perhaps you are suggest=
ing the code
> >>>> won't know when to stop dequeing/requeuing clusters on the nonfull l=
ist and will
> >>>> go forever? That's surely just an implementation issue to solve? It'=
s not a
> >>>> reason to avoid the design principle; if we agree that maintaining s=
harability
> >>>> of the cluster is preferred then the code must be written to guard a=
gainst the
> >>>> dead loop problem. It could be done by remembering the first cluster=
 you
> >>>> dequeued/requeued in scan_swap_map_try_ssd_cluster() and stop when y=
ou get back
> >>>> to it. (I think holding the si lock will protect against concurrentl=
y freeing
> >>>> the cluster so it should definitely remain in the list?).
> >>>
> >>> I believe that you can find some way to avoid the dead loop issue,
> >>> although your suggestion may kill the performance via looping a long =
list
> >>> of nonfull clusters.
> >>
> >> I don't agree; If the clusters are considered exclusive (i.e. removed =
from the
> >> list when made current for a cpu), that only reduces the size of the l=
ist by a
> >> maximum of the number of CPUs in the system, which I suspect is pretty=
 small
> >> compared to the number of nonfull clusters.
> >
> > Anyway, this depends on details.  If we cannot allocate a order-N swap
> > entry from the cluster, we should remove it from the nonfull list for
> > order-N (This is the behavior of this patch too).

Yes, Kairui implements something like that in the reclaim part of the
patch series. It is after patch 3. We are heavily testing the
performance and the stability of the reclaim patches. May I post the
reclaim together with patch 3 for discussion. If you want we can
discuss the re-order the patch in a later iteration.

>
> Yes that's a good point, and I conceed it is more difficult to detect tha=
t
> condition if the cluster is shared. I suspect that with a bit of thinking=
, we
> could find a way though.

Kaiui has  the patch series show a good performance number that beats
the current swap cache reclaim.

I want to make a point regarding the patch ordering before vs after
patch 3 (aka the big rewrite).
Previously, the "san_swap_map_try_ssd_cluster" only did partial
allocation. It does not sucessfully allocate a swap entry 100% the
time.  The patch 3 makes the cluster allocation function return the
swap entry 100% of the time. There are no more fallback retry loops
outside of the cluster allocation function. Also the try_ssd function
does not do swap cache reclaims while the cluster allocation function
will need to. These two have very different constraints.

There for, adding different cluster header into
san_swap_map_try_ssd_cluste will be a lot of waste investment of
development time in the sense that, that function will need to be
rewrite any way, the end result is very different.

That is why I want to make this change patch after patch 3. There is
also the long test cycle after the modification to make sure the swap
code path is stable. I am not resisting a change of patch orders, it
is that patch can't directly be removed before patch 3 before the big
rewrite.


>
> > Your original
> > suggestion appears like that you want to keep all cluster with order-N
> > on the nonfull list for order-N always unless the number of free swap
> > entry is less than 1<<N.
>
> Well I think that's certainly one of the conditions for removing it. But =
agree
> that if a full scan of the cluster has been performed and no swap entries=
 have
> been freed since the scan started then it should also be removed from the=
 list.

Yes, in the later patch of patch, beyond patch 3, we have the almost
full cluster that for the cluster has been scan and not able to
allocate order N entry.

>
> >
> >>> And, I understand that in some situations it may
> >>> be better to share clusters among CPUs.  So my suggestion is,
> >>>
> >>> - Make swap_cluster_info->order more accurate, don't pretend that we
> >>>   have free swap entries with that order even after we are sure that =
we
> >>>   haven't.
> >>
> >> Is this patch pretending that today? I don't think so?
> >
> > IIUC, in this patch swap_cluster_info->order is still "N" even if we ar=
e
> > sure that there are no order-N free swap entry in the cluster.
>
> Oh I see what you mean. I think you and Chris already discussed this? IIR=
C
> Chris's point was that if you move that cluster to N-1, eventually all cl=
usters
> are for order-0 and you have no means of allocating high orders until a w=
hole
> cluster becomes free. That logic certainly makes sense to me, so think it=
s
> better for swap_cluster_info->order to remain static while the cluster is
> allocated. (I only skimmed that conversation so appologies if I got the
> conclusion wrong!).

Yes, that is the original intent, keep the cluster order as much as possibl=
e.

>
> >
> >> But I agree that a
> >> cluster should only be on the per-order nonfull list if we know there =
are at
> >> least enough free swap entries in that cluster to cover the order. Of =
course
> >> that doesn't tell us for sure because they may not be contiguous.
> >
> > We can check that when free swap entry via checking adjacent swap
> > entries.  IMHO, the performance should be acceptable.
>
> Would you then use the result of that scanning to "promote" a cluster's o=
rder?
> e.g. swap_cluster_info->order =3D N+1? That would be neat. But this all f=
eels like
> a separate change on top of what Chris is doing here. For high orders the=
re
> could be quite a bit of scanning required in the worst case for every pag=
e that
> gets freed.

Right, I feel that is a different set of patches. Even this series is
hard enough for review. Those order promotion and demotion is heading
towards a buddy system design. I want to point out that even the buddy
system is not able to handle the case that swapfile is almost full and
the recently freed swap entries are not contiguous.

We can invest in the buddy system, which doesn't handle all the
fragmentation issues. Or I prefer to go directly to the discontiguous
swap entry. We pay a price for the indirect mapping of swap entries.
But it will solve the fragmentation issue 100%.


>
> >
> >>>
> >>> My question is whether it's so important to share the per-cpu cluster
> >>> among CPUs?
> >>
> >> My rationale for sharing is that the preference previously has been to=
 favour
> >> efficient use of swap space; we don't want to fail a request for alloc=
ation of a
> >> given order if there are actually slots available just because they ha=
ve been
> >> reserved by another CPU. And I'm still asserting that it should be ~ze=
ro cost to
> >> do this. If I'm wrong about the zero cost, or in practice the sharing =
doesn't
> >> actually help improve allocation success, then I'm happy to take the e=
xclusive
> >> approach.
> >>
> >>> I suggest to start with simple design, that is, per-CPU
> >>> cluster will not be shared among CPUs in most cases.
> >>
> >> I'm all for starting simple; I think that's what I already proposed (e=
xclusive
> >> in this patch, then shared in the "big rewrite"). I'm just objecting t=
o the
> >> current half-and-half policy in this patch.
> >
> > Sounds good to me.  We can start with exclusive solution and evaluate
> > whether shared solution is good.
>
> Yep. And also evaluate the dynamic order inc/dec idea too...

It is not able to avoid fragementation 100% of the time. I prefer the
discontinued swap entry as the next step, which guarantees forward
progress, we will not be stuck in a situation where we are not able to
allocate swap entries due to fragmentation.

Chris

>
> >
> >>>
> >>> Another choice for sharing is when we run short of free swap space, w=
e
> >>> disable per-CPU cluster and allocate from the shared non-full cluster
> >>> list directly.
> >>>
> >>>> Which actually makes me wonder; what is the mechanism that prevents =
the current
> >>>> per-cpu cluster from being freed? Is that just handled by the confli=
ct detection
> >>>> thingy? Perhaps that would be better handled with a flag to mark it =
in use, or
> >>>> raise count when its current. (If Chris has implemented that in the =
"big
> >>>> rewrite" patch, sorry, I still haven't gotten around to looking at i=
t :-| )
> >>>
> >>> Yes.  We may need a flag for that.
> >>>
> >>>>>
> >>>>>>> This is another reason that we should put the cluster in
> >>>>>>> nonfull_clusters[order--] if there are no free swap entry with "o=
rder"
> >>>>>>> in the cluster.  It makes design complex to keep it in
> >>>>>>> nonfull_clusters[order].
> >>>>>>>
> >>>>>>>> We have tried many different approaches including moving to the =
end of
> >>>>>>>> the list. It can cause more fragmentation because each CPU alloc=
ates
> >>>>>>>> their swap slot cache (64 entries) from a different cluster.
> >>>>>>>>
> >>>>>>>>>> Those behaviors will be fine
> >>>>>>>>>> tuned after the patch 3 big rewrite. Try to make this patch si=
mple.
> >>>>>>>>
> >>>>>>>> Again, I want to keep it simple here so patch 3 can land.
> >>>>>>>>
> >>>>>>>>>>> Another potential optimization (which was in my hacked versio=
n IIRC) is to only
> >>>>>>>>>>> add/remove from nonfull list when `total - count` crosses the=
 (1 << order)
> >>>>>>>>>>> boundary rather than when becoming completely full. You defin=
itely won't be able
> >>>>>>>>>>> to allocate order-2 if there are only 3 pages available, for =
example.
> >>>>>>>>>>
> >>>>>>>>>> That is in patch 3 as well. This patch is just doing the bare =
minimum
> >>>>>>>>>> to introduce the nonfull list.
> >>>>>>>>>>
> >>>>>
> >>>>> [snip]
> >
> > --
> > Best Regards,
> > Huang, Ying
>

