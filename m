Return-Path: <linux-kernel+bounces-339117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CDB9860BC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B25CCB2E019
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1019AD8E;
	Wed, 25 Sep 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cvuu/UVn"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC41779BC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269680; cv=none; b=JBYq4w/2AqAVHEG1bchIY1PPzBQ3ViI347Cr/mKhP+ltnKthNL7pptJ7L1tnglZzPgGZ2QFIY35eJCPs/5eqi44GiPDJQ5AJIFDGaDw5RkyjtADHj0+aIl8SkhrQMKmr8og9dD5R8ybAFB1GJZvR1V+IilLi+RYCrC7BPiMXxU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269680; c=relaxed/simple;
	bh=WF4/MpU11kD15cU2i0hoOhStBywiu641ooEf+oH29jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dI7Tryl6S5X5PL2eTzWpE7j7PERM8VwKL+42YnDWv+iDOnFXMgp0sY+5tJHVx7pNvJOd+GagI4FyisYQu9uTlCWY2wNeZ2LlbUMGdjdN8OfZTjX27OJVBvy9vAFGuN3+UAUJ9wsdEF8TX8H3Up2zlBAw9UtQFbUt0ceatxzU3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cvuu/UVn; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2960725a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727269678; x=1727874478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMQjYjN7HAdSQNZWDM3WCmN32hY2AjYX/wlFF+U58Mg=;
        b=cvuu/UVn5BvEmE/JETWBxxcDMUBYy9V5qsSZiqywJdmVjGfL3fkuIC64bUkmda6T8Y
         1YZZNVbULkCi8kaxnfBudxUJ0ffhw5ic0vjlkGgDq/BTWmydxWjyGiyt3/bKGSpQqhdI
         g7Ir4B6eJQD4UliYnRZgu2llHlHMtuVAyrh9Y9eBNwjvOT0EG2KsfimyXTv3U+VNL0Nz
         O56xUvPUu644TCp/Mg7seO0Rt0UHn59VmbANUfX0r1xOgSuYxPFK5o2BaEjfzLQi0NiG
         Fl31H2e8nP7F7Cd/tWqQZvhX6XvKFeq3lEhCEJRWJi8GigA2bMuGG92fBC642dwcVf/M
         leTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269678; x=1727874478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMQjYjN7HAdSQNZWDM3WCmN32hY2AjYX/wlFF+U58Mg=;
        b=HKy7dHqqsAF5nSCzsmqXVDdp12XRzS5CAD4oKJsG+CNqPd4IWT8xAbDEjSS9Ydl+2r
         7hCfyxUYehRvg/vWhiqPjDaHsyrQ5QV1CGoxGgVDNkja4aUvXnyEhL+6g5kLESNbFbBb
         X7AN9e8hmtbVTV3YX/vVF9FBIuiulLXTko+wiYq/wnm9SAjVFwMefxD9TyxFsbBld8rM
         uesvdoJgOlgqOCCPfSXhgocW8jR9R7X6dESaOzwAtHC9XV/KARDDgJRFZmLKrjJE5cl1
         LVaehUyH6ESvs3cueAP8Y3s2Rd+2ZDNNWQmNBmc4EsuwIGkmPPReWiH39uRh1Qjmz4JN
         g3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXzk4A1cXbvKUlbLxcf6gpnEKRqDh8HSTzCkA22Xd8z283ZBVkYP3ZsW6721VdrwAL1qEBqpOXNzZe8jQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY38xR6xpM7uRE+aPwxme3NIfncRdOpmdBjJwNmZGu7zKB0fXB
	XpnM/CJsZKsXUkvSA7JIhHUqV/Wo+iTnsxy+KtTQzbGwUaXsMTSGahPDegjr5uapfHOGpFf8ML6
	BaJEckkeY4AJp584GDL4+VX/+7PcC7d+S5BkxEA==
X-Google-Smtp-Source: AGHT+IFHgHcN5pxFxoFwe7/iwYV3NKVvNHWwIwbvhJzV6XPUKUwgxZ7Dd/J0+ZA2VJRIodLbcqULhosFombZR/ibrJY=
X-Received: by 2002:a17:90a:cf91:b0:2d8:84df:fa0a with SMTP id
 98e67ed59e1d1-2e06afcd745mr3514814a91.32.1727269678505; Wed, 25 Sep 2024
 06:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org> <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
In-Reply-To: <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 25 Sep 2024 15:07:46 +0200
Message-ID: <CAKfTPtAAytu2iaGNp8N0uhXA=3zmSsuygtrH36RWBG2yryHWWw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Christian Loehle <christian.loehle@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, 
	hongyan.xia2@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 22:24, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/30/24 14:03, Vincent Guittot wrote:
> > Keep looking for an energy efficient CPU even when the system is
> > overutilized and use the CPU returned by feec() if it has been able to find
> > one. Otherwise fallback to the default performance and spread mode of the
> > scheduler.
> > A system can become overutilized for a short time when workers of a
> > workqueue wake up for a short background work like vmstat update.
> > Continuing to look for a energy efficient CPU will prevent to break the
> > power packing of tasks.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2273eecf6086..e46af2416159 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >                   cpumask_test_cpu(cpu, p->cpus_ptr))
> >                       return cpu;
> >
> > -             if (!is_rd_overutilized(this_rq()->rd)) {
> > +             if (sched_energy_enabled()) {
> >                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
> >                       if (new_cpu >= 0)
> >                               return new_cpu;
>
> Super quick testing on pixel6:
> for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | grep Time; sleep 60; done
> with patch 5/5 only:

Do you mean 4/5 ?

> Time: 19.433
> Time: 19.657
> Time: 19.851
> Time: 19.789
> Time: 19.857
> Time: 20.092
> Time: 19.973
>
> mainline:
> Time: 18.836
> Time: 18.718
> Time: 18.781
> Time: 19.015
> Time: 19.061
> Time: 18.950
> Time: 19.166
>

As mentioned in the cover letter,  patch 4/5  has an impact on performance.
Your 4.6% regression is in the range of what I have for these tests

>
> The reason we didn't always have this enabled is the belief that
> this costs us too much performance in scenarios we most need it
> while at best making subpar EAS decisions anyway (in an
> overutilized state).
> I'd be open for questioning that, but why the change of mind?

several reasons:
- the rework of eas patch 1,2,3 of this patchset adds some performance
hints into the selection of an energy efficient CPU
- Although some initial proposal of overutilized state was per sched
domain to prevent destroying whole placement if only a subpart of the
system was overutilized, the current implementation is binary: whole
system or nothing. As shown during [1], a short kworker wakeup can
destroy all task placement by putting the whole system overutilized.
But even  when overutilized, there are a lot of possibilities to do
correct feec() task placement. The overutilized state is too
aggressive.
- the feec() has been reworked since the original version to be less
complex as described by commit 5b77261c5510 ("sched/topology: Remove
the EM_MAX_COMPLEXITY limit")

[1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp

> And why is this necessary in your series if the EAS selection
> isn't 'final' (until the next sleep) anymore (Patch 5/5)?

To prevent destroying everything without good reason. feec() will try
select a CPU only if it can find one that fits for the task otherwise
we fallback to full performance one.

