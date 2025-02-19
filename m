Return-Path: <linux-kernel+bounces-521245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8AA3BA10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC103BB0FD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D031EFF8F;
	Wed, 19 Feb 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6fp/oif"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393B1DED66
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957233; cv=none; b=rt71rEBdGunZAr5PIypnrnVyrvpjRGCO/kcQAODeaSUQys1xZHH+SIYhODbZfDrc8Sp/NAjiFSDEWXv6LXRA5zy+Y393zzZZXlZPlSkfbHUfEJ/L5OGYK/Xne62TRipU/spJ70q0ZLhZwplLFk01i1CHKkN8gw7RZ9YOjIPVGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957233; c=relaxed/simple;
	bh=ibGK0B/VwiFEaUagDEK/6uOENi08zoPdM0mnICCGBKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAQCkEs/UTJMHE/KmUOqe/Fi9VueeKRIiBpPjFhpWl9jKHPRKJmY6Fi9jq1aWru3BQ/zr5RS7mYSmhI0Vs+SXCLKAj2DgByEpxkHsl9lr0rKsZkbVWrfHtgmWXBx3+S6jtZR92Q1uvi7UngJ7pdnx+Dcnrqu+NolTJnnxmhsKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6fp/oif; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739957229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndnLFTfO36QdDrY2GKsCimhP7BsNniHfdFDqWlGMKsI=;
	b=S6fp/oifiHTYZHerrFb8Eh1MLUc7b4M/N/9BiXFgXlrWFQNFkIm6s0y19Ct8wCZPW6g0rD
	ONfUGDjY3OShMzbI8ICp3PwdL4CNi0B9VV1f+OwP8Qo/FAcJxEGYjs5wYVlDPn3PZtKHFX
	pKOYb1wuBDldDdgMJRQGK4ouaS/R9Is=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-E15bHH2QOPWMUuQ8IXuv7g-1; Wed,
 19 Feb 2025 04:27:04 -0500
X-MC-Unique: E15bHH2QOPWMUuQ8IXuv7g-1
X-Mimecast-MFC-AGG-ID: E15bHH2QOPWMUuQ8IXuv7g_1739957222
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A5D0180087F;
	Wed, 19 Feb 2025 09:27:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.127])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 606751800940;
	Wed, 19 Feb 2025 09:26:59 +0000 (UTC)
Date: Wed, 19 Feb 2025 17:26:55 +0800
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
Message-ID: <Z7Wj3/YjcF5xzbHm@MiWiFi-R3L-srv>
References: <20250214175709.76029-1-ryncsn@gmail.com>
 <20250214175709.76029-6-ryncsn@gmail.com>
 <Z7WOCvQq3xi9wxnt@MiWiFi-R3L-srv>
 <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7C0Yg164SHJcP6wDC0od-xRuBMxLsJJwB0oWavpgsr8tg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 02/19/25 at 04:34pm, Kairui Song wrote:
> On Wed, Feb 19, 2025 at 3:54 PM Baoquan He <bhe@redhat.com> wrote:
> 
> Hi Baoquan,
> 
> Thanks for the review!
> 
> >
> > On 02/15/25 at 01:57am, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Current allocation workflow first traverses the plist with a global lock
> > > held, after choosing a device, it uses the percpu cluster on that swap
> > > device. This commit moves the percpu cluster variable out of being tied
> > > to individual swap devices, making it a global percpu variable, and will
> > > be used directly for allocation as a fast path.
> > >
> > > The global percpu cluster variable will never point to a HDD device, and
> > > allocation on HDD devices is still globally serialized.
> > >
> > > This improves the allocator performance and prepares for removal of the
> > > slot cache in later commits. There shouldn't be much observable behavior
> > > change, except one thing: this changes how swap device allocation
> > > rotation works.
> > >
> > > Currently, each allocation will rotate the plist, and because of the
> > > existence of slot cache (64 entries), swap devices of the same priority
> > > are rotated for every 64 entries consumed. And, high order allocations
> > > are different, they will bypass the slot cache, and so swap device is
> > > rotated for every 16K, 32K, or up to 2M allocation.
> > >
> > > The rotation rule was never clearly defined or documented, it was changed
> > > several times without mentioning too.
> > >
> > > After this commit, once slot cache is gone in later commits, swap device
> > > rotation will happen for every consumed cluster. Ideally non-HDD devices
> > > will be rotated if 2M space has been consumed for each order, this seems
> >
> > This breaks the rule where the high priority swap device is always taken
> > to allocate as long as there's free space in the device. After this patch,
> > it will try the percpu cluster firstly which is lower priority even though
> > the higher priority device has free space. However, this only happens when
> > the higher priority device is exhausted, not a generic case. If this is
> > expected, it may need be mentioned in log or doc somewhere at least.
> 
> Hmm, actually this rule was already broken if you are very strict
> about it. The current percpu slot cache does a pre-allocation, so the
> high priority device will be removed from the plist while some CPU's
> slot cache holding usable entries.

Ah, right, I didn't think about this point.

> 
> If the high priority device is exhausted, some CPU's percpu cluster
> will point to a low priority device indeed, and keep using it until
> the percpu cluster is drained. I think this should be
> OK. The high priority device is already full, so the amount of
> swapouts falls back to low priority device is only a performance
> issue, I think it's a tiny change for a rare case.

Agree, thanks for explanation.

> 
> >
> > > reasonable. HDD devices is rotated for every allocation regardless of the
> > > allocation order, which should be OK and trivial.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  include/linux/swap.h |  11 ++--
> > >  mm/swapfile.c        | 120 +++++++++++++++++++++++++++----------------
> > >  2 files changed, 79 insertions(+), 52 deletions(-)
> > ......
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index ae3bd0a862fc..791cd7ed5bdf 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -116,6 +116,18 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
> > >
> > ......snip....
> > >  int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
> > >  {
> > >       int order = swap_entry_order(entry_order);
> > > @@ -1211,19 +1251,28 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
> > >       int n_ret = 0;
> > >       int node;
> > >
> > > +     /* Fast path using percpu cluster */
> > > +     local_lock(&percpu_swap_cluster.lock);
> > > +     n_ret = swap_alloc_fast(swp_entries,
> > > +                             SWAP_HAS_CACHE,
> > > +                             order, n_goal);
> > > +     if (n_ret == n_goal)
> > > +             goto out;
> > > +
> > > +     n_goal = min_t(int, n_goal - n_ret, SWAP_BATCH);
> >
> > Here, the behaviour is changed too. In old allocation, partial
> > allocation will jump out to return. In this patch, you try the percpu
> > cluster firstly, then call scan_swap_map_slots() to try best and will
> > jump out even though partial allocation succeed. But the allocation from
> > scan_swap_map_slots() could happen on different si device, this looks
> > bizarre. Do you think we need reconsider the design?
> 
> Right, that's a behavior change, but only temporarily affects slot cache.
> get_swap_pages will only be called with size > 1 when order == 0, and
> only by slot cache. (Large order allocation always use size == 1,
> other users only uses order == 0 && size == 1). So I didn't' notice
> it, as this series is removing slot cache.

Right, I am reviewing patch 6, noticed this is temporary.

> 
> The partial side effect would be "returned slots will be from
> different devices" and "slot_cache may get drained faster as
> get_swap_pages may return less slots when percpu cluster is drained".
> Might be a performance issue but seems slight and trivial, slot cache
> can still work. And the next commit will just remove the slot cache,
> and the problem will be gone. I think I can add a comment about it
> here?

Sounds good. Adding comment can avoid other people being confused when
checking patch 5. Thanks.


