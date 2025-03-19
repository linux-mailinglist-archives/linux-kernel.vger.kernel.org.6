Return-Path: <linux-kernel+bounces-567557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06417A687BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3F242077F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5A250BFB;
	Wed, 19 Mar 2025 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XdzmIHxC"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993C209F32
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375870; cv=none; b=LYQ/+4eOblxc7hjBXF6/Uj9SLNe9YO3Rg9D4gyOkQ01hnifEu0u4naQ8lX+GrmnbzuymBOawkcFwcdsGtXi2A8VQkEEhfJ6dEfePODXIemL6/wY9oBHI9Dz6vXF9l7HVJHi9h1WVo89FNUHzK3123uP+aIwD2orCV8QlF8zBNO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375870; c=relaxed/simple;
	bh=HrC8ju/VSr8hXeh7bw/tAfpc+VLowroiTe811siUkOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPWEILehEvjjE/K1uogF5H54yGociVh4v4qU1ngnHABLzKB1uZCIHfY+MsN5QAjcQ82LwJczdkaU8uM9LSxx0515iZxdlFbZzYs35wA41RnO4kHhwiE8yldosO+mHMAFXRyKeN3txlfSMoiETMUeIX3Tmx9OaBqvLlGG2oFRljs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XdzmIHxC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abec8b750ebso1169135566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742375866; x=1742980666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAilgT1KgQMYmhcNiJG3/TnV+1OOZFzLQklJJVL3nqI=;
        b=XdzmIHxC4FYl+4Fc784L3jt6scUNVusQ1rVHGW3qZPKc0WS3FE998y/ExaER8OId6L
         adbrBCwdLEdvGTKx2NGrthg91B/r/ZGTJ8dPkw6vfLv8ANaUvI9DYkvvFdi2zPrx8aI2
         thOXoDpLO2Towic7oi6aj30HrZXYMmUpr8hTvefWn0FrujQx5h3ZAUz9FDQ96qw24wGt
         4BPsyk9Koo0hXVeqiC7o00rV775lhnmPslxguugwV0LAmaJ+yEp1g0jWOaJfxnn2YY5Y
         jQavfwDnulnckMJ5ifIW6lOQVP7LAv3HWeDyA6F6QCgp5yH0n4vNuDTBShWl5GG4E1Ml
         0H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375866; x=1742980666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAilgT1KgQMYmhcNiJG3/TnV+1OOZFzLQklJJVL3nqI=;
        b=H++KgAzyuz74xHunwrRLmZC213p7rXDsKemoPb0hSt7LwrBz2TFG4SRNCE6/JiRxk5
         1Zh+e7admzytJW3Zym8UKE1pjhiJjKn5PTf0f723C6qxDBndAAencB8TrMfVTcOcHq5g
         UUS0fTYWsv8K45ixi4siYXiShNE0Cu5PpfpFfkLx/uNWHiCvm7TnJLdMNbMEnlaXPTdd
         V/bbAF2S6c6Hax9bvOM6IMcnX9CITPQSN/8OffAEny8M5bnwsabdHLuQ7baAcZzcb/q7
         3yzP9P/UOHoyPOGas7JxAIak7r/JaKPKHk3HQkkKxnQlQO1Pf+awDx8/vEIogUHVEDuF
         YFGg==
X-Forwarded-Encrypted: i=1; AJvYcCXdWuPa7Jr69cpsOOZdvF/U3iMgd04Xm7N/y+563p9Suj6tv5i+Pcbw5nBu3GkgIz4Fr6C2wj9PWeddsOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsCeg0rqAYk2CfehWsvcUEhZlPyW8ePofOkgYf9d0lM3hAn7p
	b//7hfgWVmi46R0DT5O6oydOpwiVGDNyojzEVJXVppRAf5hx2egEWYvsZ9nTaBwTjWrdv4+DdTO
	OG5DKYoH2aAaUHZz9ftxs1FGFWe7FSPu53evGSA==
X-Gm-Gg: ASbGncunBoSjDthUD1cs6ARtAiNVLLuvhODL5SCA12jYlOV3wyyfGsmfyFmFayUdiPF
	kMpAWp+D9MI0YGHU+Zydo8FacQ6gcOkocjsqMueFDAsC5RbPnk9isfCI3+jqqLyR/HL5l3UDzDc
	RWZoUPe2P6n42+5KOO4m+JvMgM
X-Google-Smtp-Source: AGHT+IFoMI511QjObNEJslP2mj2XeOTieGGozDekB+Ve7u+ChaLvdLTeMUPcksERvLHrGigZoOkDNhHXQP44X1D9wbg=
X-Received: by 2002:a17:906:6a0d:b0:ac3:aaa0:64 with SMTP id
 a640c23a62f3a-ac3b7dd60dbmr161204466b.26.1742375866381; Wed, 19 Mar 2025
 02:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-2-wuyun.abel@bytedance.com> <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
 <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com>
In-Reply-To: <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 10:17:34 +0100
X-Gm-Features: AQ5f1Jq9nt5BDv5HJiNfBpxPepJ-RSZVttoCJKK3Vtb-Sl5Bf0sYucqgmhv1MrM
Message-ID: <CAKfTPtAqBgCAoTaMv3_7Xguo+jtpBgg5EXOeUBWfMyPY8YDkJw@mail.gmail.com>
Subject: Re: Re: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU
 selection consistent throughout"
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, 
	Tianchen Ding <dtcccc@linux.alibaba.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 08:18, Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> Hi Vincent,
>
> On 3/12/25 12:58 AM, Vincent Guittot wrote:
> > On Mon, 10 Mar 2025 at 08:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
> >>
> >> This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.
> >>
> >> The above commit tried to unify selection policy between idle cpus
> >> and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
> >> by treating them equally (although the SCHED_IDLE cpus are turned
> >> to be given more preference in slowpath). The test results seemed
> >> solid, but the setup didn't take cgroup hierarchy into account,
> >> which actually made some of our important services get affected.
> >>
> >> The cgroup hierarchy in our production environment looks like below,
> >> which might be common in modern containerized setup:
> >>
> >>                            root
> >>                          /       \
> >>                  kubepods        system.slice
> >>                  /       \\              \
> >>          guaranteed      besteffort      containerd
> >>
> >>          (where 'X=A' means A is SCHED_IDLE cgroup)
> >>
> >> The cpu is treated as SCHED_IDLE if only besteffort is running, which
> >> is given at least equal preference as the idle cpus when deciding where
> >> to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
> >> mean they can be preempted soon enough to start serving the wakee, and
> >
> > Could you give us more details why the SCHED_IDLE cpu which runs only
> > besteffort can't be preempted soon enough ?
> >
> > because kubepods vs system.slice is not sched_idle when comparing the
>
> Yes, exactly. What's worse is that kubepods.weight is the sum of all its
> children and can easily reach ~3000, while system.weight is default to
> 100. The weight configuration can be optimized, but it's another topic.
>
> > entities ? some maybe the definition of sched_idle_cpu should be fixed
> > instead
>
> Yes, there are at least two ways to fix it:
>
>   1) Let sched_idle_cpu() depends on a specific task, just like Josh
>      mentioned in the reply of 2nd patch. So if sched_idle_cpu(cpu, p)
>      returns true, then
>
>         a) this rq only contains hierarchical idle tasks, and
>         b) p can preempt current immediately
>
>      Please see my reply to Josh to check the details.

yeah, that should be the solution which covers all cases but at the
cost of walking cgroup hierarchy which is far from being ideal

Could we change h_nr_idle to only track fully sched idle tasks; I mean
tasks with a full sched_idle cgroup hierarchy ? so we would be sure to
preempt those sched idle cpus

Then, for other case of sched idle task or sched idle group childs of
a non sched idle group then we don't consider those cpu as sched idle
cpu


>
>   2) Or get rid of sched_idle_cpu() entirely. This needs some careful
>      rework. Now the users of cfs_rq::h_nr_idle are two parts:
>
>         a) select_task_rq, including sched_balance_find_dst_group_cpu()
>            and select_idle_*(). The former is handled by this series by
>            simply ignoring sched_idle_cpus, which should be safe since
>            sched_idle_cpus do not always follow the goal of the slowpath
>            to find a least loaded cpu to help load balancing. While the
>            latter is roughly designed as following:
>
>            - Must search within target LLC domain, since L3$ miss is
>              much more costly than L1/L2$
>            - To use cache more wisely, start searching from the L1/L2$
>              cache hot cpus like prev/recent_used/..
>            - Cheers if found an idle cpu that can preempt immediately.
>              This helps maximize using cpu bandwidth, hence improving
>              total throughput
>            - (?)
>            - Return target anyway, at least it might be cache hot
>
>            It could be less optimal if simply remove sched_idle_cpu and
>            return @target if no idle cpu available, because @target can
>            be heavy loaded and the cache may not hot any longer when the
>            wakee finally hit cpu. So in order not to fight with the load
>            balancing, shall we tiebreak on cpu_load() for the non-idle
>            cpus?
>
>         b) load balance: sched_balance_domains() and dequeue_entities().
>            We could leave this as-is, but I would propose using h_idle
>            instead: if the on_cpu task is hierarchically idle when
>            triggering normal load balancing, then we guess it's a less
>            loaded cpu and can reduce balance interval. The rationale
>            behind is that the idle entities usually get very limited
>            bandwidth if any hierarchically non-idle tasks available.
>            The heuristics may have false positives which can generally
>            be divided into 3 cases:
>
>                 (The numbers represents hierarchical shares%)
>
>                                                    C
>                    A               B              / \
>                  /  \\           /  \\           80  20
>                 99    1         50   50         // \
>                                               100  (X)


How the sched_idle group in B can have the same share/weight as the
not sched idle one in case B ?


>
>            - Case A) The hierarchical share of h_idle tasks is indeed
>              small. So in this case they are just get scheduled to take
>              some breath, and the possibility of false positive is low
>              enough to be safely ignored.
>
>            - Case B) The h_idle & !h_idle tasks equally share bandwidth
>              which usually means the !h_idle part becomes less loaded
>              and pulling some load might be preferred.
>
>            - Case C) The hierarchical share of h_idle tasks dominates
>              which usually means their !h_idle parents are allowed to
>              use a big portion of bandwidth. In this case speedup the
>              balance is still fine because we could pull some !h_idle
>              tasks for the most 'important' cgroup.
>
>            So the heuristics of using rq->curr's h_idle to judge the need
>            of pulling (load balancing) seems fine.
>
>      And as a result cfs_rq::h_nr_idle can be removed and its maintenance
>      cost in hotpath can be saved.
>
> Which way do you prefer? It would be much appreciated if you can shed some
> light on this.
>
> >
> > a sched_idle_cpu should be preempted immediately otherwise it's not a
> > sched idle cpu and the definition is meaningless
>
> Agree.
>
> Thanks!
>         Abel
>

