Return-Path: <linux-kernel+bounces-374938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B7F9A723D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE781F2630F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68C71F9AB1;
	Mon, 21 Oct 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0nZJKrTG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A21DACA1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535040; cv=none; b=YVkBDw08GxV4ho0xBrtzLtVbhlCgXriEFb9X5bR83SpiphdU5QBjs/aYmX4TNShBjkI3FstpvEijnNuAVddrSWgDwY54zGA2UX+e0fDqDQkKrsFSCJUEBnTCZq8F7qVGYjLrfLuY49OAqvFFlPMwwxoF3HKJAZIXdAs3AtDsBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535040; c=relaxed/simple;
	bh=8hO7WVmgs/54rE/Qnx5FskJRGtxef3jfJ04J3wZOwwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ELhuwROH7PMSAUtsmsczol1mgMgB8qW50fgJljEDBXeYCqDnlp/AJMjSr0OFkbIyKVANtR03gRsyjWlCBfGWZsygQQFx3qxgo4cC6nt3k8/GUE6uHeTvSGkSKfI05uMhqWBmkcgZ8kWMIz0OG2E3Y+Zbt5ye66pLWg7yJFj50wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0nZJKrTG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e32e8436adso66015177b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729535037; x=1730139837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=0nZJKrTGc9HNp3zRFdJo5A52JGLbGL6pZq6tMspjwb8a+iBPAGxsinXdwmMJxmUaVc
         e8Asp1Us6mDpmouteQD69ST4+vDaA4Mf3R62TUnr/WAmADWhlxPOxyfoXYvxJaCt0byA
         Qw1kfLR0PevYzRqkr8MLbajzducDCfQlPWUe/xv8tfuC363dGavLTzdZEJHodQwwuDtV
         2M/hKMKNK1gjwNoohM6gRGBwfB3kgl4PW2EYg5YCT2DVZAQW+2MR5ok6HwYcuT6VHbYC
         bx4899LgiNwPVk27kCTNwz/tGDCnerCy/U0YEWYXh/mApp0i2gFmlNUq3Rijf7tWropu
         DMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729535037; x=1730139837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCHyWAzgLFh6Pz5pJ9aASJ+gjKaVKunSmhhMck3hZyU=;
        b=U2C0nDl6431Qs1IuleX2JvZT2shPkRHjdQlKpdIIDP/lt0TYg2bJ6PMfPtJ/9qfiNM
         D+LsejqbISMpwey73LcpafjXfKD6MJCcA+ztKs4cR1v8iugowtqfK4odymabLY3ORxPe
         fBkqyN6mRuAvRA7c11dTeCBtIwuDFescTkiXs3+3h4fVfD6mxBU0ziA06/nfb28ZVApx
         XYkx6vewh7ToPFeqzhaVk8mz8otPK3SE0V/AIvlRohRc6gx3XU6GNCTWebiyZTcv6Txs
         QxAjAR5/RsFfOCz4/ZPK/3RwsIrinHJjIADwVpj6I51S/rOptuRwNq6p79vEthAfD+JU
         3mYA==
X-Forwarded-Encrypted: i=1; AJvYcCVfGsWWtaK6QmF4XSdHhfzN65er5DZd3lbHYB0WLUEsHKuf+ar5KZzAP3wwTlTfQuGdNTmHuMUOamBgd0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1sRuWXw53/VgSpF0z0mLEto8gj6afCi939vPhJ5CuA0OfYuAc
	Ye8j9GBKy3MTpYosri4ezy4kEALYzabczSPFedhh9GHlF9BI/L7fabp9FSorODoFlAVBAo20Mg=
	=
X-Google-Smtp-Source: AGHT+IGU9wQ/1p0Qc2O+WS90aQobDGhVJv5JsMEe6PkyP+aaKw6VNLs64wQj+yTMqXYj7j0ZxkJT/QBjqg==
X-Received: from jrife-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:63c1])
 (user=jrife job=sendgmr) by 2002:a25:dc8d:0:b0:e2b:d018:9690 with SMTP id
 3f1490d57ef6-e2bd0189713mr16383276.11.1729535037035; Mon, 21 Oct 2024
 11:23:57 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:23:47 +0000
In-Reply-To: <67121037.050a0220.10f4f4.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67121037.050a0220.10f4f4.000f.GAE@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241021182347.77750-1-jrife@google.com>
Subject: Re: [syzbot] [trace?] [bpf?] KASAN: slab-use-after-free Read in
 bpf_trace_run2 (2)
From: Jordan Rife <jrife@google.com>
To: syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"

I performed a bisection and this issue starts with commit a363d27cdbc2
("tracing: Allow system call tracepoints to handle page faults") which
introduces this change.

> + *
> + * With @syscall=0, the tracepoint callback array dereference is
> + * protected by disabling preemption.
> + * With @syscall=1, the tracepoint callback array dereference is
> + * protected by Tasks Trace RCU, which allows probes to handle page
> + * faults.
>   */
>  #define __DO_TRACE(name, args, cond, syscall)				\
>  	do {								\
> @@ -204,11 +212,17 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		preempt_disable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_lock_trace();				\
> +		else							\
> +			preempt_disable_notrace();			\
>  									\
>  		__DO_TRACE_CALL(name, TP_ARGS(args));			\
>  									\
> -		preempt_enable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)

Link: https://lore.kernel.org/bpf/20241009010718.2050182-6-mathieu.desnoyers@efficios.com/

I reproduced the bug locally by running syz-execprog inside a QEMU VM.

> ./syz-execprog -repeat=0 -procs=5 ./repro.syz.txt

I /think/ what is happening is that with this change preemption may now
occur leading to a scenario where the RCU grace period is insufficient
in a few places where call_rcu() is used. In other words, there are a
few scenarios where call_rcu_tasks_trace() should be used instead to
prevent a use-after-free bug when a preempted tracepoint call tries to
access a program, link, etc. that was freed. It seems the syzkaller
program induces page faults while attaching raw tracepoints to
sys_enter making preemption more likely to occur.

kernel/tracepoint.c
===================
> ...
> static inline void release_probes(struct tracepoint_func *old)
> {
> 	...
> 	call_rcu(&tp_probes->rcu, rcu_free_old_probes); <-- Here
> 	...
> }
> ...

kernel/bpf/syscall.c
====================
> static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
> {
> 	bpf_prog_kallsyms_del_all(prog);
> 	btf_put(prog->aux->btf);
> 	module_put(prog->aux->mod);
> 	kvfree(prog->aux->jited_linfo);
> 	kvfree(prog->aux->linfo);
> 	kfree(prog->aux->kfunc_tab);
> 	if (prog->aux->attach_btf)
> 		btf_put(prog->aux->attach_btf);
> 
> 	if (deferred) {
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&prog->aux->rcu, __bpf_prog_put_rcu);
> 		else
> 			call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
> 	} else {
> 		__bpf_prog_put_rcu(&prog->aux->rcu);
> 	}
> }
> 
> static void bpf_link_free(struct bpf_link *link)
> {
> 	const struct bpf_link_ops *ops = link->ops;
> 	bool sleepable = false;
> 
> 	bpf_link_free_id(link->id);
> 	if (link->prog) {
> 		sleepable = link->prog->sleepable;
> 		/* detach BPF program, clean up used resources */
> 		ops->release(link);
> 		bpf_prog_put(link->prog);
> 	}
> 	if (ops->dealloc_deferred) {
> 		/* schedule BPF link deallocation; if underlying BPF program
> 		 * is sleepable, we need to first wait for RCU tasks trace
> 		 * sync, then go through "classic" RCU grace period
> 		 */
> 		if (prog->sleepable) <------ HERE: New condition needed?
> 			call_rcu_tasks_trace(&link->rcu, bpf_link_defer_dealloc_mult_rcu_gp);
> 		else
> 			call_rcu(&link->rcu, bpf_link_defer_dealloc_rcu_gp);
> 	} else if (ops->dealloc)
> 		ops->dealloc(link);
> }

After patching things locally to ensure that call_rcu_tasks_trace() is
always used in these three places I was unable to induce a KASAN bug
to occur whereas before it happened pretty much every time I ran 
./sys-execprog within a minute or so.

I'm a bit unsure about the actual conditions under which
call_rcu_tasks_trace() should be used here though. Should there perhaps
be another condition such as `preemptable` which is used to determine
if call_rcu_tasks_trace() or call_rcu() should be used to free
links/programs? Is there any harm in just using call_rcu_tasks_trace()
every time in combination with rcu_trace_implies_rcu_gp() like it is
in bpf_link_defer_dealloc_mult_rcu_gp()?

> static void bpf_link_defer_dealloc_mult_rcu_gp(struct rcu_head *rcu)?
> {
> 	if (rcu_trace_implies_rcu_gp())
> 		bpf_link_defer_dealloc_rcu_gp(rcu);
> 	else
> 		call_rcu(rcu, bpf_link_defer_dealloc_rcu_gp);
> }

- Jordan

