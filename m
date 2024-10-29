Return-Path: <linux-kernel+bounces-386372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFF99B4292
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F68528393E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4872010EE;
	Tue, 29 Oct 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l0hxPX1a"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BE28E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184605; cv=none; b=ZRXpMEZiSDmXhmyAlYOEujdPq6ido0tpeaUS4cJ9/OKHInq4XhxvvmsrCuSeX0zRAw3ItuL3oVTaWeL9DLahNUUSdnIE9CJTZRYJjqb4XlfdhIAgLFt8ognxgvVJt4ifB+b2qPYa3TUak3Xz0uHo8LGIHkU/2Pdf6dG5uWWr3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184605; c=relaxed/simple;
	bh=Md5wrEq8zr1HUKtoiDBfPFAyalhFSWzheIRV6LFSGrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukqzB5Ql1DQHgG2cb4B3hSkc4iHuBqwNI+Lj1coM+g53GyD+BmyxUUDNvO+ofj1auDAbvAjQNaPG6IeCdW9omSB7JNo2Fbhx/Ub++ObCiqxDIarl6PRI2XFaJfxD921PgiXZzyGgTacyho8cQXJnCdtHpzg+SGcA6uNMPV1Uqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l0hxPX1a; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730184594; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LABV/iRLAfi6mdfK0wCfARR4AZ5yav6vuJIneK8zV+w=;
	b=l0hxPX1a+6PU3CrYQ0OXZniFsphxaSBFwqqPw3Rnb14sJW6CayX6v98G6Dozz3qQ5PL/qpKdoXt828X0Qh/2pPx2IQZviHPl+dKVFdZHvk9Iy63ilprZOk2OuKkgn5ooX8VMB9xkHvfbLzAaW01CTZG4b9C7cNubaX2NbbCtAJU=
Received: from 30.166.34.203(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WI9HcYE_1730184591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 14:49:53 +0800
Message-ID: <cbc64062-f657-4163-9da2-6ed7414d20a7@linux.alibaba.com>
Date: Tue, 29 Oct 2024 14:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] sched/eevdf: Introduce a cgroup interface for
 slice
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
 <Zx_LwYshJV5LERm9@slm.duckdns.org>
 <ddfca6ac-f7a6-4b51-80e8-2e422de7d597@linux.alibaba.com>
 <ZyB-QdXryezwSswB@slm.duckdns.org>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ZyB-QdXryezwSswB@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 14:18, Tejun Heo wrote:
>> So This patch is trying to introduce a cgroup level interface.
> 
> If I'm reading the code correctly, the property can be set per task and is
> inherited when forking unless RESET_ON_FORK is set. I'm not sure the cgroup
> interface adds all that much:
> 
> - There's no inherent hierarchical or grouping behavior. I don't think it
>    makes sense for cgroup config to override per-thread configs.
> 
> - For cgroup-wide config, setting it in the seed process of the cgroup would
>    suffice in most cases. Changing it afterwards is more awkward but not
>    hugely so. If racing against forks is a concern, you can either use the
>    freezer or iterate until no new tasks are seen.
> 
> Thanks.
> 

However, we may want to set and keep different slice for processes inside the 
same cgroup.

For example in rich container scenario (as Yongmei mentioned), the administrator 
can decide the cpu resources of a container: its weight(cpu.weight), 
scope(cpuset.cpus), bandwidth(cpu.max), and also the **slice and preempt 
priority** (cpu.fair_slice in this patch).

At the same time, the user may want to decide his processes inside the 
container. He may want to set customized value (sched_attr::sched_runtime) for 
each process, and administrator should not overwrite the user's own config.

So cpu.fair_slice is for preempt competition across cgroups in the samle level, 
while sched_attr::sched_runtime can be used for processes inside the same 
cgroup. (a bit like cpu.weight vs task NICE)

Thanks.

