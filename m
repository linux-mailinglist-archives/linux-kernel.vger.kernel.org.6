Return-Path: <linux-kernel+bounces-378999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032209AD879
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C48B21D76
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567B1FDFB6;
	Wed, 23 Oct 2024 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5kUs34/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128A19AA46;
	Wed, 23 Oct 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729726565; cv=none; b=rmzJPl22yvKlqJicSpLpmeVOI3SujCXHyZu3wdOtf3eYDcDzdjJVUBtkqhYmR1mplqbaC9S8WBTfx3FV03vcEKmlfSDG+unLV+Buzl+Abd3YhgaybQF1eHfqVerJZP44BId+nv4mbO9TE5j3MQ4FNPYzPl/pGLroYsR4ZfMNxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729726565; c=relaxed/simple;
	bh=9hrNOPgct4qBf+g9KbY+2dbnxgDlOeGhYewcrlWWH28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzztWwF6zD9nnLNEGcML9pVbv2XJZKnTzh0lffiNbXrHfmJNAoRRkUGsI02n7ep+m69Qf5nvb2Frcl8KNuoazhsLz+X844zp0FpBC+lg59hGzJVxpQvjtSMcKQC4kzuXgAa6O0dEpGA+YY5HnmSyvjJh/JDXWHQWg84uHyqYF+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5kUs34/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7163489149eso210925a12.1;
        Wed, 23 Oct 2024 16:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729726562; x=1730331362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auq6NrV3v+InNziabZyjFj0YOrFI/wETtxHg8D9gjLk=;
        b=K5kUs34/R2K2qUSvbgEURxm6yT5dR+AraGnC0HwGgOYNQb0jTBTHGzjgeaPqa0vi8Y
         sNWe3EZKK3yzlCv77yjGsQY1kKTrkZiVQHPEZI75R2Wld2C6nJ4Sz0L3JVlzuU9rlWvh
         jeFKveDfBp0nSlPVWEDbb5o2HlY7oeEoiqCgkaUGf0ghSWAtMQqWxE4rWu56lTbIq+jC
         JDdL79fMEXcZcUXRF1TQmEIepcBjUgs304wxa53RIBLmstbAtQINNYX8ylAu6PXdZgWK
         j/wCstG7KBrcxF5FMyIR7XaTgVG+08pm6Zaz86yKF1bxnSH4QSeei3p4Vc3Vu8aMRu1H
         hndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729726562; x=1730331362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auq6NrV3v+InNziabZyjFj0YOrFI/wETtxHg8D9gjLk=;
        b=EDJxfap4bfpMzXMO7ff+tXgzO1fTMnnhrVAmrTB0GkYDRdDb4ovNnUD23dN1Tr9tt0
         9cWoYZPc6m1Uz9gvRyah6xt6EcFdZSNiJ2AcPm6RMK1py0+0fJSreXcHh8Hf5JRNF8nJ
         El3i51duDwEOkW+MM/oHarFBeurR6N3APaE7auMw5Pvy2uAm7XRKZZY2oDioixNJHO8I
         lkDjaCQLNLPX4dHkV9i0rzeFZtAO1u3hBAThuu5MJ494H6WVCExVne2IguCkmIYQANVx
         DJhfPWMOJ2ZEwx2aj9BsgVlgv8WDHKp8xqzL90idKb5RkGKwaPYsPWfYcvpPKyvfopaa
         RMmA==
X-Forwarded-Encrypted: i=1; AJvYcCWhzN5sfMNuOczGn/d7w/HKM25LgMwqe7hQux1oAXhbZljWE3vUYeDG5PBzaCmyBT1Crm/wVoTtQIs=@vger.kernel.org, AJvYcCWpFYIdFq7ThDMuEvz/DMvitQN3x4zQNOSK8EIrATU84gVo0XkZ5ErAF6x4xTVkPQUGfW/pF7aH5Ge74TsT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx02mTPjkMxA7+pGYFUdX8Xb4zp+aIpxlYZ27b+OsCnrNbMrd66
	fa/vk0la1DEBTn/3+nXkClTT3HWP4IGCbTJsJYUZYEZ3gpymo7B10AQ0ghsA
X-Google-Smtp-Source: AGHT+IG2NysavPnCtCNUZPmECOIxySmlIQ34K4HjPj0hJ7205hPvwp7XWPyS0Rg8QcNB/V8/KZgvDA==
X-Received: by 2002:a05:6a20:d50a:b0:1d9:4837:ad84 with SMTP id adf61e73a8af0-1d978b33ecamr5521145637.25.1729726561490;
        Wed, 23 Oct 2024 16:36:01 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:3020:9cde:9371:3772])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1e5cdsm7415559a12.21.2024.10.23.16.35.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Oct 2024 16:36:00 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: usamaarif642@gmail.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	chengming.zhou@linux.dev,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	kanchana.p.sridhar@intel.com,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	nphamcs@gmail.com,
	riel@surriel.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
Date: Thu, 24 Oct 2024 12:35:48 +1300
Message-Id: <20241023233548.23348-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
References: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Oct 24, 2024 at 9:36 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Thu, Oct 24, 2024 at 8:47 AM Usama Arif <usamaarif642@gmail.com> wrote:
> >
> >
> >
> > On 23/10/2024 19:52, Barry Song wrote:
> > > On Thu, Oct 24, 2024 at 7:31 AM Usama Arif <usamaarif642@gmail.com> wrote:
> > >>
> > >>
> > >>
> > >> On 23/10/2024 19:02, Yosry Ahmed wrote:
> > >>> [..]
> > >>>>>> I suspect the regression occurs because you're running an edge case
> > >>>>>> where the memory cgroup stays nearly full most of the time (this isn't
> > >>>>>> an inherent issue with large folio swap-in). As a result, swapping in
> > >>>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
> > >>>>>> next swap-in then recreates the overflow, leading to a repeating
> > >>>>>> cycle.
> > >>>>>>
> > >>>>>
> > >>>>> Yes, agreed! Looking at the swap counters, I think this is what is going
> > >>>>> on as well.
> > >>>>>
> > >>>>>> We need a way to stop the cup from repeatedly filling to the brim and
> > >>>>>> overflowing. While not a definitive fix, the following change might help
> > >>>>>> improve the situation:
> > >>>>>>
> > >>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >>>>>>
> > >>>>>> index 17af08367c68..f2fa0eeb2d9a 100644
> > >>>>>> --- a/mm/memcontrol.c
> > >>>>>> +++ b/mm/memcontrol.c
> > >>>>>>
> > >>>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
> > >>>>>> *folio, struct mm_struct *mm,
> > >>>>>>                 memcg = get_mem_cgroup_from_mm(mm);
> > >>>>>>         rcu_read_unlock();
> > >>>>>>
> > >>>>>> -       ret = charge_memcg(folio, memcg, gfp);
> > >>>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
> > >>>>>> MEMCG_CHARGE_BATCH)
> > >>>>>> +               ret = -ENOMEM;
> > >>>>>> +       else
> > >>>>>> +               ret = charge_memcg(folio, memcg, gfp);
> > >>>>>>
> > >>>>>>         css_put(&memcg->css);
> > >>>>>>         return ret;
> > >>>>>> }
> > >>>>>>
> > >>>>>
> > >>>>> The diff makes sense to me. Let me test later today and get back to you.
> > >>>>>
> > >>>>> Thanks!
> > >>>>>
> > >>>>>> Please confirm if it makes the kernel build with memcg limitation
> > >>>>>> faster. If so, let's
> > >>>>>> work together to figure out an official patch :-) The above code hasn't consider
> > >>>>>> the parent memcg's overflow, so not an ideal fix.
> > >>>>>>
> > >>>>
> > >>>> Thanks Barry, I think this fixes the regression, and even gives an improvement!
> > >>>> I think the below might be better to do:
> > >>>>
> > >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >>>> index c098fd7f5c5e..0a1ec55cc079 100644
> > >>>> --- a/mm/memcontrol.c
> > >>>> +++ b/mm/memcontrol.c
> > >>>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> > >>>>                 memcg = get_mem_cgroup_from_mm(mm);
> > >>>>         rcu_read_unlock();
> > >>>>
> > >>>> -       ret = charge_memcg(folio, memcg, gfp);
> > >>>> +       if (folio_test_large(folio) &&
> > >>>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
> > >>>> +               ret = -ENOMEM;
> > >>>> +       else
> > >>>> +               ret = charge_memcg(folio, memcg, gfp);
> > >>>>
> > >>>>         css_put(&memcg->css);
> > >>>>         return ret;
> > >>>>
> > >>>>
> > >>>> AMD 16K+32K THP=always
> > >>>> metric         mm-unstable      mm-unstable + large folio zswapin series    mm-unstable + large folio zswapin + no swap thrashing fix
> > >>>> real           1m23.038s        1m23.050s                                   1m22.704s
> > >>>> user           53m57.210s       53m53.437s                                  53m52.577s
> > >>>> sys            7m24.592s        7m48.843s                                   7m22.519s
> > >>>> zswpin         612070           999244                                      815934
> > >>>> zswpout        2226403          2347979                                     2054980
> > >>>> pgfault        20667366         20481728                                    20478690
> > >>>> pgmajfault     385887           269117                                      309702
> > >>>>
> > >>>> AMD 16K+32K+64K THP=always
> > >>>> metric         mm-unstable      mm-unstable + large folio zswapin series   mm-unstable + large folio zswapin + no swap thrashing fix
> > >>>> real           1m22.975s        1m23.266s                                  1m22.549s
> > >>>> user           53m51.302s       53m51.069s                                 53m46.471s
> > >>>> sys            7m40.168s        7m57.104s                                  7m25.012s
> > >>>> zswpin         676492           1258573                                    1225703
> > >>>> zswpout        2449839          2714767                                    2899178
> > >>>> pgfault        17540746         17296555                                   17234663
> > >>>> pgmajfault     429629           307495                                     287859
> > >>>>
> > >>>
> > >>> Thanks Usama and Barry for looking into this. It seems like this would
> > >>> fix a regression with large folio swapin regardless of zswap. Can the
> > >>> same result be reproduced on zram without this series?
> > >>
> > >>
> > >> Yes, its a regression in large folio swapin support regardless of zswap/zram.
> > >>
> > >> Need to do 3 tests, one with probably the below diff to remove large folio support,
> > >> one with current upstream and one with upstream + swap thrashing fix.
> > >>
> > >> We only use zswap and dont have a zram setup (and I am a bit lazy to create one :)).
> > >> Any zram volunteers to try this?
> > >
> > > Hi Usama,
> > >
> > > I tried a quick experiment:
> > >
> > > echo 1 > /sys/module/zswap/parameters/enabled
> > > echo 0 > /sys/module/zswap/parameters/enabled
> > >
> > > This was to test the zRAM scenario. Enabling zswap even
> > > once disables mTHP swap-in. :)
> > >
> > > I noticed a similar regression with zRAM alone, but the change resolved
> > > the issue and even sped up the kernel build compared to the setup without
> > > mTHP swap-in.
> >
> > Thanks for trying, this is amazing!
> > >
> > > However, I’m still working on a proper patch to address this. The current
> > > approach:
> > >
> > > mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio))
> > >
> > > isn’t sufficient, as it doesn’t cover cases where group A contains group B, and
> > > we’re operating within group B. The problem occurs not at the boundary of
> > > group B but at the boundary of group A.
> >
> > I am not sure I completely followed this. As MEMCG_CHARGE_BATCH=64, if we are
> > trying to swapin a 16kB page, we basically check if atleast 64/4 = 16 folios can be
> > charged to cgroup, which is reasonable. If we try to swapin a 1M folio, we just
> > check if we can charge atleast 1 folio. Are you saying that checking just 1 folio
> > is not enough in this case and can still cause thrashing, i.e we should check more?
>
> My understanding is that cgroups are hierarchical. Even if we don’t
> hit the memory
>  limit of the folio’s direct memcg, we could still reach the limit of
> one of its parent
> memcgs. Imagine a structure like:
>
> /sys/fs/cgroup/a/b/c/d
>
> If we’re compiling the kernel in d, there’s a chance that while d
> isn’t at its limit, its
> parents (c, b, or a) could be. Currently, the check only applies to d.

To clarify, I mean something like this:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17af08367c68..cc6d21848ee8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4530,6 +4530,29 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }

+/*
+ * When the memory cgroup is nearly full, swapping in large folios can
+ * easily lead to swap thrashing, as the memcg operates on the edge of
+ * being full. We maintain a margin to allow for quick fallback to
+ * smaller folios during the swap-in process.
+ */
+static inline bool mem_cgroup_swapin_margin_protected(struct mem_cgroup *memcg,
+		struct folio *folio)
+{
+	unsigned int nr;
+
+	if (!folio_test_large(folio))
+		return false;
+
+	nr = max_t(unsigned int, folio_nr_pages(folio), MEMCG_CHARGE_BATCH);
+	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+		if (mem_cgroup_margin(memcg) < nr)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
  * @folio: folio to charge.
@@ -4547,7 +4570,8 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 {
 	struct mem_cgroup *memcg;
 	unsigned short id;
-	int ret;
+	int ret = -ENOMEM;
+	bool margin_prot;

 	if (mem_cgroup_disabled())
 		return 0;
@@ -4557,9 +4581,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 	memcg = mem_cgroup_from_id(id);
 	if (!memcg || !css_tryget_online(&memcg->css))
 		memcg = get_mem_cgroup_from_mm(mm);
+	margin_prot = mem_cgroup_swapin_margin_protected(memcg, folio);
 	rcu_read_unlock();

-	ret = charge_memcg(folio, memcg, gfp);
+	if (!margin_prot)
+		ret = charge_memcg(folio, memcg, gfp);

 	css_put(&memcg->css);
 	return ret;

>
> >
> > If we want to maintain consitency for all folios another option is
> > mem_cgroup_margin(memcg) < MEMCG_CHARGE_BATCH * folio_nr_pages(folio)
> > but I think this is too extreme, we would be checking if 64M can be charged to
> > cgroup just to swapin 1M.
> >
> > >
> > > I believe there’s still room for improvement. For example, if a 64KB charge
> > > attempt fails, there’s no need to waste time trying 32KB or 16KB. We can
> > > directly fall back to 4KB, as 32KB and 16KB will also fail based on our
> > > margin detection logic.
> > >
> >
> > Yes that makes sense. Would something like below work to fix that:
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c098fd7f5c5e..0a1ec55cc079 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> >                 memcg = get_mem_cgroup_from_mm(mm);
> >         rcu_read_unlock();
> >
> > -       ret = charge_memcg(folio, memcg, gfp);
> > +       if (folio_test_large(folio) &&
> > +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio)))
> > +               ret = -ENOMEM;
> > +       else
> > +               ret = charge_memcg(folio, memcg, gfp);
> >
> >         css_put(&memcg->css);
> >         return ret;
> > diff --git a/mm/memory.c b/mm/memory.c
> > index fecdd044bc0b..b6ce6605dc63 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4123,6 +4123,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >         pte_t *pte;
> >         gfp_t gfp;
> >         int order;
> > +       int ret;
> >
> >         /*
> >          * If uffd is active for the vma we need per-page fault fidelity to
> > @@ -4170,9 +4171,13 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> >                 addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> >                 folio = vma_alloc_folio(gfp, order, vma, addr, true);
> >                 if (folio) {
> > -                       if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> > -                                                           gfp, entry))
> > +                       ret = mem_cgroup_swapin_charge_folio(folio, vma->vm_mm, gfp, entry);
> > +                       if (!ret) {
> >                                 return folio;
> > +                       } else if (ret == -ENOMEM) {
> > +                               folio_put(folio);
> > +                               goto fallback;
> > +                       }
> >                         folio_put(folio);
> >                 }
> >                 order = next_order(&orders, order);
> >
>
> Yes, does it make your kernel build even faster?

Thanks
Barry

