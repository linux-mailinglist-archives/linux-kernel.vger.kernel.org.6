Return-Path: <linux-kernel+bounces-424516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862AA9DB534
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33885165B97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C215D5B7;
	Thu, 28 Nov 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHhHdt8c"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AD15382E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732788238; cv=none; b=kBac8emYPg/xQ52Iq3wC69dAbM6kO56t796cXbXQ8XaHzgRd/Nv56F4M4yzy9d2ei9XqYAyeliKYvnsxVJLzkJEanFzO/Sb7q6C+PMkP59MBT+CmSNqFyVKh9AAq9/pPxilL++peSeoJVB8gQ0Pi4SCe+ZqMQ+XQHqVifHkNUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732788238; c=relaxed/simple;
	bh=PDA5R35s0zvV72Sy/eNUbvRlmVXzkHmSGuguoNbGg+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJVTG2dch1FWimaU4PeExtnVEgYYefyVj1MxWtPwbX80Awzs26+C6bDTdoKBBKDokEPSWrS9x16Ww6er5El7q+3F0r7K/sI/H62GBFSuDrzqC2Cnme4hg4VtYJceRBoS+hyQHxABTmC4BSStsp9w6gmHqubbM3n9QVnigb70Rjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHhHdt8c; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso308896a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732788236; x=1733393036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mht+KJSFu6XaPHWUj6vzB5N2enrC6dTa9TKsSc/XTM4=;
        b=FHhHdt8csQV+Vvj5OdqMZJBtvKIU+KMwb1TvboM91Kmcm4hDC8n4qYVCQCObvus6+p
         d6xa6GalSuVqqOM9BXQPCsizR/Fvycabm1iVg7CHrDOa5NrtZUL4lh5LCE1+dGtxjjq1
         xsWo9dFQnu9a1yes0NmSEpuCDO+TGqSUhoGfXPxnfxdBjOyA8VtCc/Qv7tOEh5KlIpfR
         muTFZz4NsQzseFnMkKcxN6C1G8KifkclVF6ApQAgNr+aLJQvN3j4ixO0Vog1SMHDSrMd
         ZJs1OrNfXMSLC7sOvX3HrD1CMhjHcAJ+BmjS26O8aB+TTtqALkgktfw8mbXgaE03Bqpk
         s83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732788236; x=1733393036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mht+KJSFu6XaPHWUj6vzB5N2enrC6dTa9TKsSc/XTM4=;
        b=PIZDgsJLP3Fl+1LdYyAcVpL1iAxXVSTmbDFM2wnHwbgaXMAcdcuKJKGss/HdY4jvES
         Wh1b/YqVxZOJownvtluufyIWaUFKvt/fCRbrnmVGul9aZZZ4HzM/qBeCmTt9HOdYEJKw
         sqGuhgNrOZoDJFiI14hH8HZ8KZZuUvyTLWSV/tT7VAYWUlMp7+tN29Z33G/HJ9lvfBph
         B7UMKKfcFr57ce/73yYAuDT7UV442YkBTCsT7+dLt7P1kSmeOoH16XOc6KK22E/pg5zu
         UsqeGUizW81PrXFQNJiKOhtCfjaKxhPoQctpCRngONUF97FDRk4EKiiAivIt3svTBYGM
         Wr1A==
X-Forwarded-Encrypted: i=1; AJvYcCUotcN9nWlnmKSPhC74L14e+NZ9zY8e1bD3P4xit2BSELwNsUsPTm642VBenl80aphNLWIK6rY8iLoKOT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdfePi9Qlhe0iNlEEnJ9OLF4Ib9BW1jBhLoxoX3p+5L76GSQiR
	96A0fX5qV48ktuEDI189jQjMbSNMKvQoul/ZCyVVYf2VeaokktG4uRx0CFnjM3dcR7mSuNupNOD
	3z8FxVeTmsXa9yumRcdZYBfto8MXf+cbo6GDS+g==
X-Gm-Gg: ASbGnctWH8/yN7B30dr8gwyeNFAw7VeOQ80jy+CbJ0kRsC5UmWP1FcUxMF3sli40DaF
	ysRQf8mvOljlu1IEt9ekTwFfRBe6bg66eVSKQh/xQ+xzrxUDA8rC1VBtPBKM=
X-Google-Smtp-Source: AGHT+IEBEgMf3qspbRnpm7FC0WtLKK2owMjwbBKo9/vFX6cqkpDQX/rBdo1PKWgY9kCHFce17MIlDNFhx3B3BOw5Y+Y=
X-Received: by 2002:a17:90b:4c8c:b0:2ea:6d7a:d6bc with SMTP id
 98e67ed59e1d1-2ee08fc9f1emr9205017a91.19.1732788235696; Thu, 28 Nov 2024
 02:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
 <20241128092750.2541735-8-vincent.guittot@linaro.org> <20241128094936.GA24400@noisy.programming.kicks-ass.net>
In-Reply-To: <20241128094936.GA24400@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Nov 2024 11:03:44 +0100
Message-ID: <CAKfTPtB5LaZf6joAEDePxudi8kU_4vxZ1Was9VZjF+t+btzaXg@mail.gmail.com>
Subject: Re: [PATCH 7/9] sched/fair: Do not try to migrate delayed dequeue task
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com, pauld@redhat.com, 
	efault@gmx.de, luis.machado@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 10:49, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 28, 2024 at 10:27:48AM +0100, Vincent Guittot wrote:
> > Migrating a delayed dequeued task doesn't help in balancing the number
> > of runnable tasks in the system.
>
> But it can help balance the weight; furthermore, by moving them to a
> lighter queue, they'll get picked sooner and disappear sooner.

When groups are not overloaded, we don't compare load but only running
tasks t balance them across cpus

It's only when both src and dst groups are overloaded that we look at
the load and the weight

>
> Perhaps make it: p->se.sched_delayed && !env->sd->nr_balance_failed ?

So we could take into account which type of migration with
env->migration_type == migrate_load

In this case, migrating a delayed dequeue task would help

>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/fair.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1b4f1b610543..9d80f3a61082 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9405,11 +9405,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >
> >       /*
> >        * We do not migrate tasks that are:
> > -      * 1) throttled_lb_pair, or
> > -      * 2) cannot be migrated to this CPU due to cpus_ptr, or
> > -      * 3) running (obviously), or
> > -      * 4) are cache-hot on their current CPU.
> > +      * 1) delayed dequeued, or
> > +      * 2) throttled_lb_pair, or
> > +      * 3) cannot be migrated to this CPU due to cpus_ptr, or
> > +      * 4) running (obviously), or
> > +      * 5) are cache-hot on their current CPU.
> >        */
> > +     if (p->se.sched_delayed)
> > +             return 0;
> > +
> >       if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
> >               return 0;
> >
> > --
> > 2.43.0
> >

