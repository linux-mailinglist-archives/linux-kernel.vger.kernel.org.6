Return-Path: <linux-kernel+bounces-522867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C1A3CF6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 03:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89CE07A8DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C51D63D9;
	Thu, 20 Feb 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjFDWIb1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35FDF58
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018946; cv=none; b=Nan2vftIGGH7J4OeAL6TjcRIM+5NxB/8JiVBLMQ2WoWRrCUPtBlEQAGJb5ZDOPyfmvxMPQFCRZki7SeG6vn2+pLagACU5yPReC9xjuBD2uweVKuLhHabEmo8JgRFSK8VxS0I5y8xC2YPC7T1Wi9Iibfd5rC7A8W4GuyCtqy9ICM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018946; c=relaxed/simple;
	bh=vcPpeVHP6n4EXASkdVc+Fa0vqVRkbtm3jERyNmChSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPpZzkrzYsUI/1AebIHuC18KzzgiJJIxkARjeuxWtqljbuJHUEap+BsOqoVI6/+2gVEkWlRelYEMXD1ZbxI8wygnS0O4rcDjxBcjfcfwL9X6LzVmyUXKmUUDswwf+iGln2SGaxAy3H29TVEEbuPsszYr2Hoo5h5NMS5ofmDMaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjFDWIb1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740018943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gpiugipe2lgzrq6vUBl+mCOTtBccv54DqPwRv7KROEw=;
	b=CjFDWIb19y2hCbe2H5hIKMo4FT24Olju8v0ScbebOcrQk+uIKHWjOYcvYCBKD/JgRh2IGI
	RxzXU4M8TIdDfJHmcKRVgOAAHtnfEcIWh0OrA3EW3uPXmkFxe+P+aERZ8ZKsGeSFocXJmH
	P3cNE1+MGelb6u2qPMkKnX9JP8paTqs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-avJlzw19OVubyt6HIQrtkA-1; Wed,
 19 Feb 2025 21:35:36 -0500
X-MC-Unique: avJlzw19OVubyt6HIQrtkA-1
X-Mimecast-MFC-AGG-ID: avJlzw19OVubyt6HIQrtkA_1740018934
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B7CF18EB2C3;
	Thu, 20 Feb 2025 02:35:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 789171800352;
	Thu, 20 Feb 2025 02:35:32 +0000 (UTC)
Date: Thu, 20 Feb 2025 10:35:27 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm, swap: use percpu cluster as allocation fast path
Message-ID: <Z7aU7wEx9jKo3TaT@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
 <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
 <Z7W4p0p/Qkke2LTp@MiWiFi-R3L-srv>
 <CAMgjq7AixL=Jn_c5jQFWWJt5+gPz0O+1rxtTWhzOmo2ef3dWhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7AixL=Jn_c5jQFWWJt5+gPz0O+1rxtTWhzOmo2ef3dWhQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/19/25 at 07:12pm, Kairui Song wrote:
> On Wed, Feb 19, 2025 at 6:55 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 02/19/25 at 04:34pm, Kairui Song wrote:
> > > On Wed, Feb 19, 2025 at 3:54 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Hi Baoquan,
> > >
> > > Thanks for the review!
> > >
> > > >
> > > > On 02/15/25 at 01:57am, Kairui Song wrote:
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > Current allocation workflow first traverses the plist with a global lock
> > > > > held, after choosing a device, it uses the percpu cluster on that swap
> > > > > device. This commit moves the percpu cluster variable out of being tied
> > > > > to individual swap devices, making it a global percpu variable, and will
> > > > > be used directly for allocation as a fast path.
> > > > >
> > > > > The global percpu cluster variable will never point to a HDD device, and
> > > > > allocation on HDD devices is still globally serialized.
> > > > >
> > > > > This improves the allocator performance and prepares for removal of the
> > > > > slot cache in later commits. There shouldn't be much observable behavior
> > > > > change, except one thing: this changes how swap device allocation
> > > > > rotation works.
> > > > >
> > > > > Currently, each allocation will rotate the plist, and because of the
> > > > > existence of slot cache (64 entries), swap devices of the same priority
> > > > > are rotated for every 64 entries consumed. And, high order allocations
> > > > > are different, they will bypass the slot cache, and so swap device is
> > > > > rotated for every 16K, 32K, or up to 2M allocation.
> > > > >
> > > > > The rotation rule was never clearly defined or documented, it was changed
> > > > > several times without mentioning too.
> > > > >
> > > > > After this commit, once slot cache is gone in later commits, swap device
> > > > > rotation will happen for every consumed cluster. Ideally non-HDD devices
> > > > > will be rotated if 2M space has been consumed for each order, this seems
> > > >
> > > > This breaks the rule where the high priority swap device is always taken
> > > > to allocate as long as there's free space in the device. After this patch,
> > > > it will try the percpu cluster firstly which is lower priority even though
> > > > the higher priority device has free space. However, this only happens when
> > > > the higher priority device is exhausted, not a generic case. If this is
> > > > expected, it may need be mentioned in log or doc somewhere at least.
> > >
> > > Hmm, actually this rule was already broken if you are very strict
> > > about it. The current percpu slot cache does a pre-allocation, so the
> > > high priority device will be removed from the plist while some CPU's
> > > slot cache holding usable entries.
> > >
> > > If the high priority device is exhausted, some CPU's percpu cluster
> > > will point to a low priority device indeed, and keep using it until
> > > the percpu cluster is drained. I think this should be
> > > OK. The high priority device is already full, so the amount of
> > > swapouts falls back to low priority device is only a performance
> > > issue, I think it's a tiny change for a rare case.
> > >
> > > >
> > > > > reasonable. HDD devices is rotated for every allocation regardless of the
> > > > > allocation order, which should be OK and trivial.
> > > > >
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > ---
> > > > >  include/linux/swap.h |  11 ++--
> > > > >  mm/swapfile.c        | 120 +++++++++++++++++++++++++++----------------
> > > > >  2 files changed, 79 insertions(+), 52 deletions(-)
> > > > ......
> > > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > > index ae3bd0a862fc..791cd7ed5bdf 100644
> > > > > --- a/mm/swapfile.c
> > > > > +++ b/mm/swapfile.c
> > > > > @@ -116,6 +116,18 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
> > > > >
> > > > ......snip....
> > > > >  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
> > > > >  {
> > > > >       int order = swap_entry_order(entry_order);
> > > > > @@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
> > > > >       int n_ret = 0;
> > > > >       int node;
> > > > >
> > > > > +     /* Fast path using percpu cluster */
> > > > > +     local_lock(&percpu_swap_cluster.lock);
> > > > > +     n_ret = swap_alloc_fast(swp_entries,
> > > > > +                             SWAP_HAS_CACHE,
> > > > > +                             order, n_goal);
> > > > > +     if (n_ret == n_goal)
> > > > > +             goto out;
> > > > > +
> > > > > +     n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
> > > >
> > > > Here, the behaviour is changed too. In old allocation, partial
> > > > allocation will jump out to return. In this patch, you try the percpu
> > > > cluster firstly, then call scan_swap_map_slots() to try best and will
> > > > jump out even though partial allocation succeed. But the allocation from
> > > > scan_swap_map_slots() could happen on different si device, this looks
> > > > bizarre. Do you think we need reconsider the design?
> > >
> > > Right, that's a behavior change, but only temporarily affects slot cache.
> > > get_swap_pages will only be called with size > 1 when order == 0, and
> > > only by slot cache. (Large order allocation always use size == 1,
> > > other users only uses order == 0 && size == 1). So I didn't' notice
> > > it, as this series is removing slot cache.
> > >
> > > The partial side effect would be "returned slots will be from
> > > different devices" and "slot_cache may get drained faster as
> > > get_swap_pages may return less slots when percpu cluster is drained".
> > > Might be a performance issue but seems slight and trivial, slot cache
> > > can still work. And the next commit will just remove the slot cache,
> > > and the problem will be gone. I think I can add a comment about it
> > > here?
> >
> > By the way, another thing I suddenly think of is the percpu cluster
> > becoming glober over all devices. If one order on the stored si of
> > percpu cluster is used up, then the whole percpu cluster is drained and
> > rewritten. Won't this impact performance compared with the old embedding
> > percpu cluster in each si? In log you said "Ideally non-HDD devices
> > will be rotated if 2M space has been consumed for each order, this seems
> > reasonable.", while in reality it may be very difficult to achieve the
> > 'each 2M space has been consumed for each order', but more often happen
> > when very few of order's space has been consumed, then rewrite percpu.
> > Wonder what I have missed about this point.
> 
> Hi Baoquan,
> 
> > then the whole percpu cluster is drained and rewritten
> 
> Not sure what you mean, SWAP IO doesn't happen in units of clusters,
> cluster is only a management unit for slots, so only allocated / freed
> slot will be written. Discard is a different thing, and this should
> have very little effect on that.
> 
> Or you mean the percpu struct array getting updated? It should be even
> faster than before, updating a global percpu variable is easier to
> calculate the offset at runtime, using GS.

Yes, I mean the global percpu array updating.

> 
> > n reality it may be very difficult to achieve the 'each 2M space has been consumed for each order',
> 
> Very true, but notice for order >= 1, slot cache never worked before.
> And for order == 0, it's very likely that a cluster will have more
> than 64 slots usable. The test result I posted should be a good
> example, and device is very full during the test, and performance is
> basically identical to before. My only concern was about the device

My worry is the global percpu cluster may impact performance among
multiple swap devices. Before, per si percpu cluster will cache the
valid offset in one cluster for each order. For multiple swap devices,
this consumes a little bit more percpu memory. While the new global
percpu cluster could be updated to a different swap device easily only
of one order is available, then the whole array is invalid. That looks a
little drastic cmpared with before.

Yeah, the example you shown looks good. Wonder how many swap devices are
simulated in your example.

> rotating, as slot cache never worked for order >= 1, so the device
> rotates was very frequently. But still seems no one really cared about
> it, mthp swapout is a new thing and the previous rotation rule seems
> even more confusing than this new idea.

I never contact a real product environment with multiple tier and
many swap devices. In reality, with my shallow knowledge, usually only
one swap device is deployed. If that's true in most of time, the old
code or new code is fine, otherwise, seems we may need consider the
impact.


