Return-Path: <linux-kernel+bounces-567679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77262A688DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15A697A63BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA072207A03;
	Wed, 19 Mar 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdFreMkE"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CE25334D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742378127; cv=none; b=ECdAMwUWDTC9kp0O7eRZDKXQPw+jAxRsseqNlGPYJOw5DFHI4YUKM+Yx+XgYxWm1SqdQKW5WEo02ArpWm6ymOx52dPo44qCqtmlM6Fx4O0iPe13l6AtwhpLDDKazbqftHM9oYPD+fLVwpmT4YmSiUC6l2TLdvuWQn6AY+9x3TkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742378127; c=relaxed/simple;
	bh=6FZbkPbJ4ePzVYffL8C72QoqEF4QNnnpsp/H5EN0vjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBTTbZRojdV+N8j7bBj3LozCvx/Ps/0iGzMsDZWpAPw0GTYGM1pr6hH/VsnuaVkhNay5TyS1m7IFTn24GmjSo/V13IeuU+JVT/u4sZyvWHVmY9Yeg+imhLkeVPHB8SBCyWCKNPJit5793Obeq0Z4BAqz1MAVcvb8bGc2oaBygyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VdFreMkE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5c9662131so9449248a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742378124; x=1742982924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SS9bYsCvPnvNzgl6SjoiJJxp+SurwbptoCTQawAakoE=;
        b=VdFreMkEomE2uLx1rBY0W1HLVcs7fMeDtuRkEBp/oByPieYwCsj2k8yIAfYL2goj5t
         XsNC6LnyqCEfDbTx5ShYd3gsoM24QipYrucmb4t4XkNcgnDvLbQEQDnZk7c8og9S+8Ti
         kInaf6pbpCLaUvn1fOi3kCrIiBRXk8y8IvzUoX32XH0cS8ejDWA3826RIPU8Bj4YpNSa
         uU7XtSYXDxB8YjBKFm6m1Vzs78MZPsupMRUzq1krGU6Dw1KOTE5YCAlaKIAeNrOqXjBX
         17beeLGniLszv0t1c4Xu9tkWCtAn2E9b69tUUuUckzMvIWnBXLG+TmGsQi+KsqQa+nMy
         +zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742378124; x=1742982924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SS9bYsCvPnvNzgl6SjoiJJxp+SurwbptoCTQawAakoE=;
        b=ru2NooODT1cGQM6zmG+ioIFml4YPBvrnnuTCIRKWBKRVbpSCPKfPUGLn4BqStWrIhu
         MAYHj4hDJMHyCtPP9v+Vq+0vhMlR4CeM3mhNcAowR/DFMPXC7FsXABLAlcAxiyxjWZNE
         C8KLssspIc5kzfwPUvmk0+5iqpspB3GU3t4OQJyw8MNkyeiQRr46mBqCPWpE235tzPR0
         Rn+xu/G/APC/T8BAEn9JC4d9hUp9bifCF5/RpZqpkScccE5Rwpt50DTIp88z48HZYH/D
         Lw3TBm0clAlKqIbYSfaQ6097GkZlnBITSEXpcNn6pkKr+Z7H/bARaaYK8oKEqqXRurzt
         ivFA==
X-Forwarded-Encrypted: i=1; AJvYcCVNmQ8YhO4ynvTV3FbIQrzOut4ubhoXl2IvcbCAVnGe3+tJL1Y+N3y/KQoHq3mPZ3v4KKcpuOQZ9R/nWWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmpIUf7Anqb1gfaYZvDbdcaFERytFJ1HnvfdQSil7zrVnNmG1
	/7jT+3FWGjXJsu0RkJhfdGfyDj5s4gsI62AjiQ+5wUGxVnYC+AWCC7mRjM94pJb2VHppNdGTOaB
	Re+GTz2nLaC5U2gnckNiseWSDHeugu5VEEIRbxw==
X-Gm-Gg: ASbGncugSpkXV3BNLw1K2JQdSW4gevH04xIi3rCbpTo/5dY+DsPUMHLjltjwoDfAVPO
	EUgzBUQGk76Tnp7rOML+2/prnu2XoTH04d141xwlqlikaqfT6R+exYQJXBgmtEtCN3czOyfLw30
	i0RQLuAE7MTwCXWu+x7JkwI/Ex
X-Google-Smtp-Source: AGHT+IGlnykGkaL97Fkuc2owu+Xvv7k6zuf6QSwsyZERy1qKSF8MYKIwfu/SZaumarcGkF54V9w78hOfZaOCvN2G41E=
X-Received: by 2002:a05:6402:5112:b0:5e5:e78a:c501 with SMTP id
 4fb4d7f45d1cf-5eb80cddfedmr1968036a12.13.1742378123691; Wed, 19 Mar 2025
 02:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318022358.195154-1-wujianyong@hygon.cn> <CAKfTPtA+41UxOi6C2fcgZ1mjaL19rBYi5Kidc6TSYLhNt3u1mw@mail.gmail.com>
 <a056a0ec6a4646fbb4a6e1a30bc2fcab@hygon.cn> <CAKfTPtAZ_unLKjg5rxDOonrRdz3-4fqV6uEyd3eGLT5SFEjdOA@mail.gmail.com>
 <31ff4ffeb1f9448d8044f707f856c046@hygon.cn>
In-Reply-To: <31ff4ffeb1f9448d8044f707f856c046@hygon.cn>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 19 Mar 2025 10:55:10 +0100
X-Gm-Features: AQ5f1JpKi8ah0mNnY8rTyumCE03bmHuKDRz4EtEx17RJlgl9BjFZG6rCNSyYC44
Message-ID: <CAKfTPtAfoMzVSoSRApKsQcKr+QXjwU868ghZ69gimQ2SBr5Bzg@mail.gmail.com>
Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
To: Jianyong Wu <wujianyong@hygon.cn>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"jianyong.wu@outlook.com" <jianyong.wu@outlook.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 10:42, Jianyong Wu <wujianyong@hygon.cn> wrote:
>
>
>
> > -----Original Message-----
> > From: Vincent Guittot <vincent.guittot@linaro.org>
> > Sent: Wednesday, March 19, 2025 5:26 PM
> > To: Jianyong Wu <wujianyong@hygon.cn>
> > Cc: mingo@redhat.com; peterz@infradead.org; jianyong.wu@outlook.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
> >
> > On Wed, 19 Mar 2025 at 10:03, Jianyong Wu <wujianyong@hygon.cn> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Vincent Guittot <vincent.guittot@linaro.org>
> > > > Sent: Wednesday, March 19, 2025 4:46 PM
> > > > To: Jianyong Wu <wujianyong@hygon.cn>
> > > > Cc: mingo@redhat.com; peterz@infradead.org; jianyong.wu@outlook.com;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] SCHED: scatter nohz idle balance target cpus
> > > >
> > > > On Tue, 18 Mar 2025 at 03:27, Jianyong Wu <wujianyong@hygon.cn> wrote:
> > > > >
> > > > > Currently, cpu selection logic for nohz idle balance lacks history
> > > > > info that leads to cpu0 is always chosen if it's in nohz cpu mask.
> > > > > It's not fair fot the tasks reside in numa node0. It's worse in
> > > > > the machine with large cpu number, nohz idle balance may be very heavy.
> > > >
> > > > Could you provide more details about why it's not fair for tasks
> > > > that reside on numa node 0 ? cpu0 is idle so ilb doesn't steal time to other
> > tasks.
> > > >
> > > > Do you have figures or use cases to highlight this unfairness ?
> > > >
> > > [Jianyong Wu]
> > > Yeah, here is a test case.
> > > In a system with a large number of CPUs (in my scenario, there are 256 CPUs),
> > when the entire system is under a low load, if you try to bind two or more CPU -
> > bound jobs to a single CPU other than CPU0, you'll notice that the softirq
> > utilization for CPU0 can reach approximately 10%, while it remains negligible for
> > other CPUs. By checking the /proc/softirqs file, it becomes evident that a
> > significant number of SCHED softirqs are only executed on CPU0.
> >
> > yes, but this 10% of softirq time would have been idle time otherwise so why
> > should we care ?
> >
> [Jianyong Wu]
> However, this value is proportional to the number of CPUs. In the event that tasks are scheduled to CPU0, delays will occur.

ILB aborts when a task is enqueued on the CPU so the 10% softirq does
not reflect the delay of an enqueued task.  It would be good to get
figures about the problem you are trying to solve

>
> > At the opposite, if all your cpus are busy, then cpu0 will do the busy load balance
> > of parents sched domain level whereas other cpus will not and this time is stolen
> > to the task running on CPU0 which could be unfair compared to task running on
> > other CPUS
> >
> [Jianyong Wu]
> Yeah. Do you think this patch can mitigate this?
> >
> > > > >
> > > > > To address this issue, adding a member to "nohz" to indicate who
> > > > > is chosen last time and choose next for this round of nohz idle balance.
> > > > >
> > > > > Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
> > > > > ---
> > > > >  kernel/sched/fair.c | 9 ++++++---
> > > > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > > > c798d2795243..ba6930c79e25 100644
> > > > > --- a/kernel/sched/fair.c
> > > > > +++ b/kernel/sched/fair.c
> > > > > @@ -7197,6 +7197,7 @@ static struct {
> > > > >         atomic_t nr_cpus;
> > > > >         int has_blocked;                /* Idle CPUS has blocked
> > load
> > > > */
> > > > >         int needs_update;               /* Newly idle CPUs need
> > their
> > > > next_balance collated */
> > > > > +       int last_cpu;                   /* Last cpu chosen to do
> > nohz
> > > > idle balance */
> > > > >         unsigned long next_balance;     /* in jiffy units */
> > > > >         unsigned long next_blocked;     /* Next update of blocked
> > load in
> > > > jiffies */
> > > > >  } nohz ____cacheline_aligned;
> > > > > @@ -12266,13 +12267,15 @@ static inline int find_new_ilb(void)
> > > > >
> > > > >         hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
> > > > >
> > > > > -       for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
> > > > > +       for_each_cpu_wrap(ilb_cpu, nohz.idle_cpus_mask,
> > > > > + nohz.last_cpu
> > > > > + + 1) {
> > > > >
> > > > > -               if (ilb_cpu == smp_processor_id())
> > > > > +               if (ilb_cpu == smp_processor_id() ||
> > > > > + !cpumask_test_cpu(ilb_cpu, hk_mask))
> > > > >                         continue;
> > > > >
> > > > > -               if (idle_cpu(ilb_cpu))
> > > > > +               if (idle_cpu(ilb_cpu)) {
> > > > > +                       nohz.last_cpu = ilb_cpu;
> > > > >                         return ilb_cpu;
> > > > > +               }
> > > > >         }
> > > > >
> > > > >         return -1;
> > > > > --
> > > > > 2.43.0
> > > > >

