Return-Path: <linux-kernel+bounces-358181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD7997B20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A8A8B22761
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8CD18CBE5;
	Thu, 10 Oct 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qCLl8TLK"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089718A922
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529943; cv=none; b=u0beWQwr1IoVXVF//B1xLnidbeTzTlWhnq2G7gMUXGF8Ts2nMeiwBtNd1QQT6tdTRQugaJlJr6LDNbgpf27+/W3cS3tg84UYlwqnN3aYRtG5U1K7oGj7rVtgDZQM//pmHvh6rWDlNSUNLNtMgOj1IpgZC+cpmRx0HXaxeCyavJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529943; c=relaxed/simple;
	bh=lAbqfCPQQfFeQuynoLVMF5O4JD6JWC7CqCKpjDnsmY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAQhWflfIdOiDeP2Iqku1Pf4HRbItOfBoIcmpp+ORLGSrHj8WI//iNSmeOegsxXCiEzz9QOa9S4WKESoj3KH0Wy4Ow2A1EDEOICj7tN5XwCNa/As9GCcRwfjUfOX/dUFswfX3cH3Q37Jn24lbF9XwZbeDJvNirAZCRGZTJpDTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qCLl8TLK; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728529932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jb7bt9OZa7KGHA5GLLFq9v1jebn/ZclID9+1AL5mJ88=;
	b=qCLl8TLKMw7bhNm8kQRuQvHXM4LVzoiAcPULhGoOYpFO5kVg2CTvDnmWvhBZ5BzlRTnQJCbInIbGVpNt7gF0lXFcHOORb8WE3I6zNDhWu32rSADVKb4bgCqPde8cmVhm7tATiKawWRojS8J+2LaQN8YaafkY22CuPy0UBkjvZuo=
Received: from 30.74.129.219(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WGksEzf_1728529929)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 11:12:10 +0800
Message-ID: <02bfe2cc-ee08-4c81-951f-9b7ab9de2b24@linux.alibaba.com>
Date: Thu, 10 Oct 2024 11:12:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ankur Arora <ankur.a.arora@oracle.com>, mingo@kernel.org,
 linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, efault@gmx.de,
 Thomas Gleixner <tglx@linutronix.de>
References: <20241007074609.447006177@infradead.org>
 <20241008153232.YwZfzF0r@linutronix.de> <87wmihdh3u.fsf@oracle.com>
 <20241009062019.1FJYnQL1@linutronix.de>
 <20241009080202.GJ17263@noisy.programming.kicks-ass.net>
 <20241009100133.2569e2a7@gandalf.local.home> <87h69lqbk0.ffs@tglx>
 <20241009164355.1ca1d3d3@gandalf.local.home>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20241009164355.1ca1d3d3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/10 04:43, Steven Rostedt wrote:

[...]

> Hmm, but then again...
> 
> Perhaps these cond_resched() is proper? That is, the need_resched() /
> cond_resched() is not something that is being done for PREEMPT_NONE, but
> for preempt/voluntary kernels too. Maybe these cond_resched() should stay?
> If we spin in the loop for one more tick, that is actually changing the
> behavior of PREEMPT_NONE and PREEMPT_VOLUNTARY, as the need_resched()/cond_resched()
> helps with latency. If we just wait for the next tick, these loops (and
> there's a lot of them) will all now run for one tick longer than if
> PREEMPT_NONE or PREEMPT_VOLUNTARY were set today.
> 

Agree.

And for PREEMPT_LAZIEST, this becomes worse. The fair_class tasks will be 
delayed more than 1 tick. They may be starved until a non-fair class task comes 
to "save" them.

cond_resched() is designed for NONE/VOLUNTARY to avoid spinning in kernel and 
prevent softlockup. However, it is a nop in PREEMPT_LAZIEST, and things may be 
broken...

