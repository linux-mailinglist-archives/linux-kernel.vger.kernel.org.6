Return-Path: <linux-kernel+bounces-568529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE4A696DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5F880AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9E205E16;
	Wed, 19 Mar 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHqQqaqZ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926AC1E0E0B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406830; cv=none; b=h+23Bo+lkCRWODKB211UV55WYccZF2/j6ngWKo5jLMn4PLiqdMX2JnvXZ0aJIKE5t7rGA9C1dEKqd2Ht+T3hofYRGj+3xMV23Ammp2nyQif2RbvMDSNACghqkH62YpvD1jJ7eEylhLr3Vsi4Y/dXlITz+Ox44ANxLCmbRKqFeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406830; c=relaxed/simple;
	bh=O6WQxJkTo3sHK1wDiMapjXj0ErYXETE9KwHUQBK522I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdbKLHJy0Il2ZQrddED0n/0b6jEFakP4DS/N7FW4JZE5rAh+N4oivxQ3GN+sOYa81ZJFTpzzCwPz5Uu4rpj7qafX6/huOThnPLh+wGrpJ7pzaDAnFee885QjmTezuwVUW0qgwRQsp7mF0DpiU5lM1eOv9UZyXWSNkOys6Jm32ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHqQqaqZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 10:53:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742406826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ5p4xen5XoEcupk9X8i2DLIwO69+HUFs0k3yPGHoT0=;
	b=jHqQqaqZNCUSoEHu9Z7AqUQCqsmm4XhfUugFtX5AZN7bbJ1/sCFfozjb0hOlITcG/+csw0
	diFfqeGZXKIQImK3qzElA66izPU7jYrDtXLYTBKY637OuIH6oa0R2P8uOlpJA1kvTXfJEd
	oFJ6f6fM/oxXqgc+QkmxqoH8BaFQeR4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Eric Dumazet <edumzaet@google.com>, Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <54wer7lbgg4mgxv7ky5zzsgjv2vi4diu7clvcklxgmrp2u4gvn@tr2twe5xdtgt>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.

Which kernel was this observed on in production?

> 
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu.

Doing for each cpu might be too extreme. Have you tried with some
batching?

> This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
> 
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
> 

Though this benchmark seems too extreme but userspace holding off irqs
for that long time is bad. BTW are these memory hoggers, creating anon
memory or file memory? Is [z]swap enabled?

For the long term, I think we can use make this work without disabling
irqs, similar to how networking manages sock lock.

> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  => started at: _raw_spin_lock_irq
>   #  => ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=> CPU#
>   #                   / _-----=> irqs-off/BH-disabled
>   #                  | / _----=> need-resched
>   #                  || / _---=> hardirq/softirq
>   #                  ||| / _--=> preempt-depth
>   #                  |||| / _-=> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    => memcg1_stat_format
>    => memory_stat_format
>    => memory_stat_show
>    => seq_read_iter
>    => vfs_read
>    => ksys_read
>    => do_syscall_64
>    => entry_SYSCALL_64_after_hwframe
> 
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> 
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses => 12.7M accesses
> -    with memory hogs: 9.46M accesses => 11.1M accesses
> The throughput of memory.stat access improves.
> 
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec => 16 usec
> -    with memory hogs: 64 usec =>  8 usec
> The memory.stat latency improves.

So, things are improving even without batching. I wonder if there are
less readers then how will this look like. Can you try with single
reader as well?

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

