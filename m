Return-Path: <linux-kernel+bounces-224235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A29911F39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFDFB21412
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777A16D4F4;
	Fri, 21 Jun 2024 08:48:22 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE785283
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959701; cv=none; b=fVHfX6gpurHcA14ERTU+CFiX4zouMUe4Eiq2pKF5vb4Kfl/1IZA8/nINf3i27u0Ly1jUgQYIpdlOGTTlavTdFQ5YeCMnrZ7XqkOfS/hSGgu2g22cO4K0c4I+zQP5M4VvkCNnRAiyxXQsgtoFYLxWWKblAElnMOeSXYn9EeXeAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959701; c=relaxed/simple;
	bh=+yLHlXmJW7jZFy94fl6VyZ/7/XzXLMosWioYmRLyFKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVeOLxh8MMz8FmbE63VqJplgwE0Tt9X3Nm6a2qNMopEmmoZohSyNk6LTslbKcnuZm2wpjWhgepGsDF/0USp5PkA/fSFRedjmtKacOQaIj3sLY/g5hw8MFYxPHxtS34GVU8wmeGh8iWwUkhMiDQECM5n9Tih+BfstJz9rCbxEFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48c39fe4ee3so461207137.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959699; x=1719564499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja4lyIFZFRcSIQN5xjT6xHwvTVomO3KRoG0Nx+9MBcg=;
        b=Yxd/AQVFqYh8jhkVhYiBX7sMl0Z7DSA2oyXKRlRjiLHR5Pn7yYsYuzEk3JoS0lmk9j
         wF03nIstBz6qSNx3gIJQJggAetu8+0Z9chtmtiSaH/gZeZzt2Vs6JcrRDxOVu8E+AxO0
         CQj6thgYcPXXP1X6j/rjXqgdVd+JmwmEksQDGKpeFD9Xv6FToE8ZKGMZHrdbNXiC7+mO
         H6km7ATcEFk7HmG0YwtnjCnpko2lKd3Rqcykx1CulNWFXJQD3JCpQrifcGNZSeRaoLLt
         a4ULu29CRji/bSz6Q9NzJXUG5ab+ZURGGJR1rxm66EHO2AdNbveM08ez/dV4xv3jm7vp
         jt7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1W75Ws2XpA2kG+lqOnXkZZ1FXjGhMeO9Bchn83rvBZdHIDp/Mjr/pkguO7qYqr7Gizh2b2TIpgGXRJzfaoAmbEtqTt892LbADK3Ti
X-Gm-Message-State: AOJu0YxZynHGZ/OtRg+dHrsnQyJVLTfyoa/eBU/UF+orFfcJj/5GpxfN
	mIxmHkHD2jtHr5bL9JKEXFwKtL248Oqds2v3dNYEaaf6ksmQKFaKYcaS6XQiv2FmIL69USQDxSM
	uO6FbRBO0Jj0oLkwFf8rthFpgB4I=
X-Google-Smtp-Source: AGHT+IF153qYDBPMeB8NRQG3ram+D+e0BH1Qw+ET5oq5kbceE2mUS0IGcM646+di2IZTQWD+CnJMy5wCf1Ggbh83YO8=
X-Received: by 2002:a67:fe91:0:b0:48d:b59a:689c with SMTP id
 ada2fe7eead31-48f1303bee1mr8341178137.15.1718959699015; Fri, 21 Jun 2024
 01:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
 <CAGsJ_4wx2WD+Msjhqqy7CK1gNGAQ2LGjuM5x_bNdXUOeGsz3xw@mail.gmail.com> <48859779-45ba-445d-8ce0-486575a3fd7b@arm.com>
In-Reply-To: <48859779-45ba-445d-8ce0-486575a3fd7b@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 21 Jun 2024 20:48:07 +1200
Message-ID: <CAGsJ_4zkgm5rqUU6VP3T7iH1=3Dak=h_fr5uy+=OsmdsFzFGwg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Shuai Yuan <yuanshuai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:18=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 19/06/2024 10:11, Barry Song wrote:
> > On Wed, Jun 19, 2024 at 11:27=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>
> >> Hi All,
> >>
> >> Chris has been doing great work at [1] to clean up my mess in the mTHP=
 swap
> >> entry allocator. But Barry posted a test program and results at [2] sh=
owing that
> >> even with Chris's changes, there are still some fallbacks (around 5% -=
 25% in
> >> some cases). I was interested in why that might be and ended up puttin=
g this PoC
> >> patch set together to try to get a better understanding. This series e=
nds up
> >> achieving 0% fallback, even with small folios ("-s") enabled. I haven'=
t done
> >> much testing beyond that (yet) but thought it was worth posting on the=
 strength
> >> of that result alone.
> >>
> >> At a high level this works in a similar way to Chris's series; it mark=
s a
> >> cluster as being for a particular order and if a new cluster cannot be=
 allocated
> >> then it scans through the existing non-full clusters. But it does it b=
y scanning
> >> through the clusters rather than assembling them into a list. Cluster =
flags are
> >> used to mark clusters that have been scanned and are known not to have=
 enough
> >> contiguous space, so the efficiency should be similar in practice.
> >>
> >> Because its not based around a linked list, there is less churn and I'=
m
> >> wondering if this is perhaps easier to review and potentially even get=
 into
> >> v6.10-rcX to fix up what's already there, rather than having to wait u=
ntil v6.11
> >> for Chris's series? I know Chris has a larger roadmap of improvements,=
 so at
> >> best I see this as a tactical fix that will ultimately be superseeded =
by Chris's
> >> work.
> >>
> >> There are a few differences to note vs Chris's series:
> >>
> >> - order-0 fallback scanning is still allowed in any cluster; the argum=
ent in the
> >>   past was that swap should always use all the swap space, so I've lef=
t this
> >>   mechanism in. It is only a fallback though; first the the new per-or=
der
> >>   scanner is invoked, even for order-0, so if there are free slots in =
clusters
> >>   already assigned for order-0, then the allocation will go there.
> >>
> >> - CPUs can steal slots from other CPU's current clusters; those cluste=
rs remain
> >>   scannable while they are current for a CPU and are only made unscann=
able when
> >>   no more CPUs are scanning that particular cluster.
> >>
> >> - I'm preferring to allocate a free cluster ahead of per-order scannin=
g, since,
> >>   as I understand it, the original intent of a per-cpu current cluster=
 was to
> >>   get pages for an application adjacent in the swap to speed up IO.
> >>
> >> I'd be keen to hear if you think we could get something like this into=
 v6.10 to
> >> fix the mess - I'm willing to work quickly to address comments and do =
more
> >> testing. If not, then this is probably just a distraction and we shoul=
d
> >> concentrate on Chris's series.
> >
> > Ryan, thank you very much for accomplishing this.
> >
> > I am getting Shuai Yuan's (CC'd) help to collect the latency histogram =
of
> > add_to_swap() for both your approach and Chris's. I will update you wit=
h
> > the results ASAP.
>
> Ahh great - look forward to the results!

Essentially, we are measuring two types of latency:
* Small folio swap allocation
 * Large folio swap allocation

The concept code is like

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 994723cef821..a608b916ed2f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -185,10 +185,18 @@ bool add_to_swap(struct folio *folio)
        VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
        VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);

+       start_time =3D ktime_get();
+
        entry =3D folio_alloc_swap(folio);
        if (!entry.val)
                return false;

+       end_time =3D ktime_get();
+       if (folio_test_large(folio))
+               trace_large_swap_allocation_latency(ktime_sub(end_time
- start_time));
+       else
+               trace_small_swap_allocation_latency(ktime_sub(end_time
- start_time));
+
        /*
         * XArray node allocations from PF_MEMALLOC contexts could
         * completely exhaust the page allocator. __GFP_NOMEMALLOC


Then, we'll generate histograms for both large and small allocation
latency. We're currently
encountering some setup issues. Once we have the data, I'll provide
updates to you and Chris.
Additionally, I noticed some comments suggesting that Chris's patch
might negatively impact
the swap allocation latency of small folios. Perhaps the data can help
clarify this.

>
> >
> > I am also anticipating Chris's V3, as V1 seems quite stable, but V2 has
> > caused a couple of crashes.
> >
> >>
> >> This applies on top of v6.10-rc4.
> >>
> >> [1] https://lore.kernel.org/linux-mm/20240614-swap-allocator-v2-0-2a51=
3b4a7f2f@kernel.org/
> >> [2] https://lore.kernel.org/linux-mm/20240615084714.37499-1-21cnbao@gm=
ail.com/
> >>
> >> Thanks,
> >> Ryan
> >>
> >> Ryan Roberts (5):
> >>   mm: swap: Simplify end-of-cluster calculation
> >>   mm: swap: Change SWAP_NEXT_INVALID to highest value
> >>   mm: swap: Track allocation order for clusters
> >>   mm: swap: Scan for free swap entries in allocated clusters
> >>   mm: swap: Optimize per-order cluster scanning
> >>
> >>  include/linux/swap.h |  18 +++--
> >>  mm/swapfile.c        | 164 ++++++++++++++++++++++++++++++++++++++----=
-
> >>  2 files changed, 157 insertions(+), 25 deletions(-)
> >>
> >> --
> >> 2.43.0
> >>
>

Thanks
Barry

