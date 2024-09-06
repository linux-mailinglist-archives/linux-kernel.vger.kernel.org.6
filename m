Return-Path: <linux-kernel+bounces-318204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEE96E9E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806042889DF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74914AD03;
	Fri,  6 Sep 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ydobo6Ok"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019975FB9C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603310; cv=none; b=FXw4XfgjBCOWjtkTDGgPxms1bFelYSs4GnlGxrpqrflQOjLOFCfaP+fk6KQSNIRVMDpP/PaxcvAV77EngpWbDK6I2NaV3Vm+1pnCxNb2WNdnzwchYysMPael01RddyywmS2LwhbvxFIlbGAY/q2C3sf1+biqzRCfErXctDr3lkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603310; c=relaxed/simple;
	bh=UsY5YZyAdfY0ovbFPJEfb8fMtt8qRHs7CgaYuwcKlyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKEh4jpCHX0fu9f8rCOlMF0MOSQrSBl+TWnRgZUpgX2/AXssjRJk1L8UrPKGvw3Fsz79RWkCFIXpD2ngElzu1ulyb6xNuvdeQ4vMv6Ntm2vu4NLwEtuyNxKKR/ZaVqtJCmqZdlsOqB1gVtOUHzXpWw6JIGiNUf0MnryucYjcEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ydobo6Ok; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717934728adso1111952b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725603308; x=1726208108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sBPqkgSKc9VH/hsssUJza8AJvu8vn2foFCqgrstmn6Y=;
        b=Ydobo6OkGaOacd/9FkagsQiP0vrjdKICg3MsMteW1K06POgqwcL35FVk63aMa9FViA
         Q0oaMAQBOJAy/RFTQ/VVrIPoQNbYuu55RleEH7ovV2hc4FKJHK3IwcC8l9R2aQomAvIG
         iWkgY184cV371HOG6KB/fU4b3964Kmi/+O614aOzkHaXK6c09Agp04noHPSLUH+zY1nF
         VPCKsB3DR/8rh+94JQa7OCx9JVwAmthlSAPnILE8WP4gQkRzTMRCUIFQQoxbCzsl2L8h
         CGZ3eThbVjUIc2aKcbB1rJEyZIAzJ8Ik6ObHZaB0FyKGVcWGJWR27WHj8dn4uf2Vmhy/
         F6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725603308; x=1726208108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sBPqkgSKc9VH/hsssUJza8AJvu8vn2foFCqgrstmn6Y=;
        b=Zb2CKCVCSjMnoyMJ05YOhJZ9Dr8c2QWNmk4JesQr14f3OvKEQh0wlQwfjQfrMHagzo
         cDINBXNPfEasDknnzcnzqFXb79cMOhR8NpNvIYWW/4ZSaO6NmO1iJydpRuKy++4BjaBE
         x78fSWHWeCiOcsxypDY4X4y7SwQnOB22uCn8aZnAsEFdLyaEKroXuRqH5aQ00KjVCVer
         397QWgZEzSKzaitYLS6BrZOHqDcpP+cztEB/BlxG+lbRVUjk33yQ0GBeQIibb1dwPRQK
         9Qvi0O81xwcye+AELrPPRDBQMrGwihHlRunn7BcBidHdyfZvaIqnc3/7K7RFW1Ab0KEY
         lMWw==
X-Forwarded-Encrypted: i=1; AJvYcCUxa5zsM0DtZ+BuSkYj1k2/quUx3a6KM/SmEag67ckdcYceCcYobGBHxbCBCsiOvlu8AiL3trVC9FVh3Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xy9sBSCt6JTXmpv2k3Spn3PthkCNPRZU3Csem9T24cOgN3kP
	SGegjDT1MqkHUFA5oEe+/fcp+HdUE7S+Ubkz0QUfILgZX6lSbwjNRlBcp3YeWhMEIzxvW3hnXit
	qhq2G0gwqglg8/MRxqFYYhTb1TUY3Depso+yXHA==
X-Google-Smtp-Source: AGHT+IGoesCHGmV5zTLXOrB0kIAo/FbQ8Yb/4dlIYy8FhCe6R5Olv3BKPDgOJLex4egSJr6tdEZd0gUxg7XBDEaQgCg=
X-Received: by 2002:a05:6a20:2d0c:b0:1cf:1f5d:15f1 with SMTP id
 adf61e73a8af0-1cf1f5d168amr758483637.25.1725603308001; Thu, 05 Sep 2024
 23:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com> <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com> <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com> <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com> <20240905145354.GP4723@noisy.programming.kicks-ass.net>
In-Reply-To: <20240905145354.GP4723@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 6 Sep 2024 08:14:56 +0200
Message-ID: <CAKfTPtBE39E91t2CATTzyGxHCyqU+8iWq5fdMbvDu42e+ZKg6w@mail.gmail.com>
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	Luis Machado <luis.machado@arm.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, 
	wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de, 
	efault@gmx.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Sept 2024 at 16:54, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 05, 2024 at 04:07:01PM +0200, Dietmar Eggemann wrote:
>
> > > Unfortunately, this is not only about util_est
> > >
> > > cfs_rq's runnable_avg is also wrong  because we normally have :
> > > cfs_rq's runnable_avg == /Sum se's runnable_avg
> > > but cfs_rq's runnable_avg uses cfs_rq's h_nr_running but delayed
> > > entities are still accounted in h_nr_running
> >
> > Yes, I agree.
> >
> > se's runnable_avg should be fine already since:
> >
> > se_runnable()
> >
> >   if (se->sched_delayed)
> >     return false
> >
> > But then, like you said, __update_load_avg_cfs_rq() needs correct
> > cfs_rq->h_nr_running.
>
> Uff. So yes __update_load_avg_cfs_rq() needs a different number, but
> I'll contest that h_nr_running is in fact correct, albeit no longer
> suitable for this purpose.

AFAICT, delayed dequeue tasks are there only to consume their negative
lag but don't want to run in any case.  So I keep thinking that they
should not be counted in h_nr_running nor in runnable or load. They
only want to be kept in the rb tree of the cfs to consume this
negative lag and they want to keep their weight in the
cfs_rq->avg_load, which has nothing to do with the pelt load, to keep
a fair slope for the vruntime.

>
> We can track h_nr_delayed I suppose, and subtract that.
>
> > And I guess we need something like:
> >
> > se_on_rq()
> >
> >   if (se->sched_delayed)
> >     return false
> >
> > for
> >
> > __update_load_avg_se()
> >
> > - if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
> > + if (___update_load_sum(now, &se->avg, se_on_rq(se), se_runnable(se),
> >
> >
> > My hope was we can fix util_est independently since it drives CPU
> > frequency. Whereas PELT load_avg and runnable_avg are "only" used for
> > load balancing. But I agree, it has to be fixed as well.
> >
> > > That also means that cfs_rq's h_nr_running is not accurate anymore
> > > because it includes delayed dequeue
> >
> > +1
> >
> > > and cfs_rq load_avg is kept artificially high which biases
> > > load_balance and cgroup's shares
> >
> > +1
>
> Again, fundamentally the delayed tasks are delayed because they need to
> remain part of the competition in order to 'earn' time. It really is
> fully on_rq, and should be for the purpose of load and load-balancing.

They don't compete with other they wait for their lag to become
positive which is completely different and biases all the system

>
> It is only special in that it will never run again (until it gets
> woken).
>
> Consider (2 CPUs, 4 tasks):
>
>   CPU1          CPU2
>    A             D
>    B (delayed)
>    C
>
> Then migrating any one of the tasks on CPU1 to CPU2 will make them all
> earn time at 1/2 instead of 1/3 vs 1/1. More fair etc.

But the one that is "enqueued" with the delayed queue will have twice
more time and balancing the delayed task will doesn't help to balance
the system because it doesn't run

Also the delayed task can make a cpu overloaded where it is not. All
this is unfair

>
> Yes, I realize this might seem weird, but we're going to be getting a
> ton more of this weirdness once proxy execution lands, then we'll be
> having the entire block chain still on the runqueue (and actually
> consuming time).

