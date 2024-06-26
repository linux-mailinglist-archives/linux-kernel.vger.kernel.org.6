Return-Path: <linux-kernel+bounces-231054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725DD918589
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB1E2824E7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BA818A936;
	Wed, 26 Jun 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPph3B2X"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EDF185E5F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415081; cv=none; b=VTJ3XOnmJQggJ4ICPiWFPM0e8X8dCUEa3IsYAqetRPE/x7zP26mI8ZgtyavABWJ7SZJr4zj0SLMZuueT5ca/r1xdF93pXS7WiHJv+YgijYjF6g5DiZG/ssXpWZIzPyg63+/OLvEaxv8u7SHfwLcD3XsSYfQTRD0jV0aSIuzfcj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415081; c=relaxed/simple;
	bh=mETC2QwTgBAIVD59dMNSUiPt3XGvHztME62f8g/JgHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh3cGI8HK6RI8YWkvRrTcx554f1YSNMZvrDN6AWFxdJB1z7rr5UR/KAa/jGU3pAo4YQEiw00WObKCRPV9u/oNMfaLp33OV1ZGG3pgR9f8p+5kBoXpHHL7IVsIEkoR3fgxUPyWGWl0D9c0YEJrNC6OnAIGWb/22LuLll7QWcHg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPph3B2X; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-717f17d7c63so3819486a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719415079; x=1720019879; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AjqLJlRHQKv3f9/u1wU9P+seqBZ3syGljBoSL8S9FRw=;
        b=mPph3B2X/N4OJn8SqbkHHicy7Zp+uzpOyp5ehvbGIJH76ecHs7FmgzEIGWr3Xa2AVu
         lSqERmkJd9xlRfFxSRgrBE8UpeUXoz2tEi0UDYJj/xOmOWYaEgZzkrB0vAsoOZj3I9DH
         otuOR+r9AI+zRkBdyQd5+6HEVUVbYUvafWRUezddB2jHp0drUgvzwQf3jNDFiDdjqLcL
         2NZJmdG3ZI25+fF9l014AUuCkbirhobnhg2oeTob00XSJS7anOb3KU8EQNHK176Wr6Dt
         5pvVct+gnDxWZhLGKSf8er9kl4VBg+kaLobSrV+FCVfHeIjUD2PP7Ctx5vGpepiv0rRZ
         xTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415079; x=1720019879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjqLJlRHQKv3f9/u1wU9P+seqBZ3syGljBoSL8S9FRw=;
        b=bv3DAWyGALajToMWU1COZTq4fMQJC1euv8slTQSFTudGQSXBhmy/yMQEzplR2iQX0Z
         mfMEHCw3kAK7E1jZ8xvowQHXD7Ij6eWaeXLLJ0OBug7b34q+3verl0sYCBO0qxehskt4
         Y/Wc/4mL0cSHmNSOz00zkG9mMxuoRj9yc6YSyodQ5JDCjrqlK1zKi5WejZg55EvLCib+
         UCmi99E6VBG5RTW55P9NByFirqoEMU5XKQL324za3mKeouxU6G9yd8jzoUS36npDMczu
         diq3IVKr+4i3+hFkqnN+IbLmm6rymkUki5IamvOvxSWTVIFsJHArm6wzWVSXo30GeMr3
         64eg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Rrpg3C2pLGpbG/3d6n4WInqrrMURpA5nltpTuA0ASPArpFaCTA3CK2SV+L94IhHMx/A08cFRB9DdiUlap1ayRlWdbXT+YQzsoEXC
X-Gm-Message-State: AOJu0YwFCFOUtTE8Ty1NDnxthkxg6IMShDx1nMyrcCvVwow9naDswNWW
	2iwRfc6SRboEmWBxFXlaFKxeeGDoK13etWvivTq2QbTxqE/X/ZY1LWCeqpNjmauWtm0huybLt5N
	HJISyKHXT7F1Vqk35ec/bsvFqh/2d4ZIX2Dwp1g==
X-Google-Smtp-Source: AGHT+IFULizID3AH+Fd/rK2FH40/svMQeycstJ4ccFr8DTVhgGmN8qs9eh1Bfm4Gzdd1pBFICgIxXCN9+/f0prvUvNg=
X-Received: by 2002:a17:90b:3901:b0:2c2:d813:bffa with SMTP id
 98e67ed59e1d1-2c8614867dcmr8710812a91.43.1719415079480; Wed, 26 Jun 2024
 08:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr>
In-Reply-To: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 26 Jun 2024 17:17:48 +0200
Message-ID: <CAKfTPtBTc3Z_oK_Gg=79g4eUfA1iUat7gsZ2wqKkj=QXULYzng@mail.gmail.com>
Subject: Re: softirq
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 07:37, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> Hello,
>
> I'm not sure to understand how soft irqs work.  I see the code:
>
> open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
>
> Intuitively, I would expect that sched_balance_softirq would be run by
> ksoftirqd.  That is, I would expect ksoftirqd to be scheduled

By default, sched_softirq and others run in interrupt context.
ksoftirqd is woken up only in some cases like when we spent too much
time processing softirq in interrupt context or the softirq is raised
outside interrupt context

> (sched_switch event), then the various actions of sched_balance_softirq to
> be executed, and the ksoftirqd to be unscheduled (another ksoftirqd)
> event.
>
> But in practice, I see the code of sched_balance_softirq being executed
> by the idle task, before the ksoftirqd is scheduled (see core 40):

What wakes up ksoftirqd ? and which softirq finally runs in ksoftirqd ?

>
>           <idle>-0     [040]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting nohz
>           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting _nohz_idle_balance
>           bt.B.x-12022 [047]  3611.432554: softirq_entry:        vec=1 [action=TIMER]
>           <idle>-0     [040]  3611.432554: bputs:                _nohz_idle_balance.isra.0: searching for a cpu
>           bt.B.x-12033 [003]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: ending _nohz_idle_balance
>           bt.B.x-12052 [011]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
>           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: nohz returns true ending soft irq
>           <idle>-0     [040]  3611.432554: softirq_exit:         vec=7 [action=SCHED]
>
> For example, idle seems to be running the code in _nohz_idle_balance.
>
> I updated the code of _nohz_idle_balance as follows:
>
> trace_printk("searching for a cpu\n");
>         for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
>                 if (!idle_cpu(balance_cpu))
>                         continue;
> trace_printk("found an idle cpu\n");
>
> It prints searching for a cpu, but not found an idle cpu, because the
> ksoftirqd on the core's runqueue makes the core not idle.  This makes the
> whole softirq seem fairly useless when the only idle core is the one
> raising the soft irq.

The typical behavior is:

CPUA                                   CPUB
                                       do_idle
                                         while (!need_resched()) {
                                         ...

kick_ilb
  smp_call_function_single_async(CPUB)
    send_call_function_single_ipi
      raise_ipi  --------------------->    cpuidle exit event
                                           irq_handler_entry
                                             ipi_handler
                                               raise sched_softirq
                                           irq_handler_exit
                                           sorftirq_entry
                                             sched_balance_softirq
                                               __nohe_idle_balance
                                           softirq_exit
                                           cpuidle_enter event

softirq is done in the interrupt context after the irq handler and
CPUB never leaves the while (!need_resched())  loop

In your case, I suspect that you have a racing with the polling mode
and the fact that you leave the while (!need_resched()) loop and call
flush_smp_call_function_queue()

We don't use polling on arm64 so I can't even try to reproduce your case

>
> This is all for the same scenario that I have discussed previously, where
> there are two sockets and an overload of on thread on one and an underload
> of on thread on the other, and all the thread have been marked by numa
> balancing as preferring to be where they are.  Now I am trying Prateek's
> patch series.
>
> thanks,
> julia

