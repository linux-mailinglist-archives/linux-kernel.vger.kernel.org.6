Return-Path: <linux-kernel+bounces-413689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA39D1D30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3BAE1F20DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6146712EBE9;
	Tue, 19 Nov 2024 01:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QE1kVaBD"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7A74204E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979227; cv=none; b=Brwt2S7UmhrT3ITB3UYyCbIP6U0xnk5GDFrcuvYEuKsSZSVMHQocwTzcanKA5Z9c3T1NuFD6AdYU7tzLIOhlOmJlg16tNFD+QCXYf5iLScsCbRV5GhwyuGGur+6hfb/pcCQiYr+lPYM+uAS48Jz51Q1kIYoVG9/7jpdfbt3tbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979227; c=relaxed/simple;
	bh=L7Ty+dUSZG+QKpEkKHyhq9B8dVcfB7ORg9Mo0MvQYws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOt5cFIG+cpDqGF83KAajo+n0zP0+5Ebt/k9taw1nMvNk8rub3o9yA3seib08TlLn5t1PQjH56X28aSlO47tIxItPRDAZ4JSw+Uf6t8PwR4jdh2nEPwZh8xJjIg1xQgSUCf7+VObsFiZng/zyF2A738nc3wXKGVPVix8IcBFChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QE1kVaBD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a+BahHik9NpbpYAAI6AoJl01hyCSTOcLSE9tikfcZeA=; b=QE1kVaBD5nkzYhlezfdk8SFMOt
	c1WP611bid/kMOtuBXJpnpet0Y0LvP9EBHlJ8/PuhJ7nfp25NOKLDfXTyImr8Xit8ODanMZGXO9cF
	vsyr1Z8zAxjQf9GXYUZ1E6xYURL4iRLzoJq6dqNeMbYrJxONsKTL4wcItSpRrU+QEtVEdUABNPHRX
	8ZJBf1M7dedpLWRL3top3QgZMT82EsbfGdbPJR8CD4A3Uwci/gX/N64XRnzWwdbQcenZ4gvh9fvT4
	Pz+OHp+yGLJYY3VRm3V5opSqag9Lt2dXazMdEr+LzNFGHRHKv1EESkjbM5/6lA/WYIEpVf3lj1k7S
	DSRAPstA==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tDCuF-008mP6-DY; Tue, 19 Nov 2024 02:19:51 +0100
Message-ID: <9a2bfe0d-3a1d-4917-bf10-33259c79a3bb@igalia.com>
Date: Tue, 19 Nov 2024 10:19:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Changwoo Min <changwoo@igalia.com>
References: <20241116160126.29454-1-changwoo@igalia.com>
 <20241116160126.29454-3-changwoo@igalia.com>
 <20241116193235.GQ22801@noisy.programming.kicks-ass.net>
 <494b8851-ba5b-4205-bea0-dc504c2ffa33@igalia.com>
 <20241118094100.GG39245@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241118094100.GG39245@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Thank you for the prompt feedback. I hope the following answers
can clarify most of your doubts.

On 24. 11. 18. 18:41, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 12:46:32AM +0900, Changwoo Min wrote:
> 
>> The main reason to keep the second copy (rq->scx.clock) is that
>> a BPF scheduler can call scx_bpf_clock_get_ns() at almost any
>> time in any context, including any of sched_ext operations, BPF
>> timer callbacks, BPF syscalls, kprobes, and so on.
> 
> If it's going to be a BPF wide thing, why is it presented as part of
> sched_ext ? That makes no sense.

There is a confusion here. scx_bpf_clock_get_ns() is for BPF
schedulers, not for random BPF programs. In almost all cases, it
will be used in the shced_ext operations, such as ops.running()
and ops.stopping(), to implement scheduling policies. However, if
BPF schedulers use other BPF features, such as BPF timer,
scx_bpf_clock_get_ns() also can be used. For example, scx_lavd uses
a BPF timer for periodic background processing; scx_lavd and
scx_flash use kprobe to trace futex system calls. Also, since
scx_bpf_clock_get_ns() relies on rq lock, it is not meaningful
outside of the BPF schedulers. Hence, it should be a part of
sched_ext.

>> Another approach would be to extend struct sched_clock_data (in
>> kernel/sched/clock.c) to store the update flag
>> (SCX_RQ_CLK_UPDATED). This would be the best regarding the number
>> of cache line accesses. However, that would be an overkill since
>> now sched_clock_data stores the sched_ext-specific data.
>> I thought it would be better to keep sched_ext specific data in
>> one place, struct scx_rq, for managibility.
> 
> What's the purpose of that flag? Why can't BPF use sched_clock_local()
> and call it a day?

Let's suppose the following timeline:

   T1. rq_lock(rq)
   T2. update_rq_clock(rq)
   T3. a sched_ext BPF operation
   T4. rq_unlock(rq)
   T5. a sched_ext BPF operation
   T6. rq_lock(rq)
   T7. update_rq_clock(rq)

For [T2, T4), we consider that rq clock is valid
(SCX_RQ_CLK_UPDATED is set), so scx_bpf_clock_get_ns calls during
[T2, T4) (including T3) will return the rq clock updated at T2.
Let's think about what we should do for the duration [T4, T7)
when a BPF scheduler can still call scx_bpf_clock_get_ns (T5).
During that duration, we consider the rq clock is invalid
(SCX_RQ_CLK_UPDATED is unset). So when calling
scx_bpf_clock_get_ns at T5, we call sched_clock() to get the
fresh clock.

I think the term `UPDATED` was misleading. I will change it to
`VALID` in the next version.

> Growing sched_clock_data shouldn't be a problem, it's only 24 bytes, so
> we have plenty free bytes there.

Alright. I will change the current implementation and extend
`struct sched_clock_data` to store the `VALID` flag in the next
version.

