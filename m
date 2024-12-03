Return-Path: <linux-kernel+bounces-429270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDAA9E1999
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65906282EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D38C1E47B3;
	Tue,  3 Dec 2024 10:41:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A61E47AE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222514; cv=none; b=VZGYJNU9lAJAhM1+EAi+95SGqb3rqZYM3dBL609i9UsZXNUkxI9fQZ5RQK2Z5micjUg90JCVJy3S2rw2uBXVomVCTNWLOVhCOKJASVjt3gvvnStSpmBq6ayHbhkVIg6hQYfUZEg8IKRh9o0Tsb7GGcAwI+u/ONZhcGQERKduCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222514; c=relaxed/simple;
	bh=BV4ihEZeoGoPr/jg+0qyPa2e/I26bj5M3So69x7y7QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xoz8PbbXHJAZnL3KaXoCeCQ7frbVYf/4H5oVddzWapKXUYtIa+OtEFf8d7y36jcAXzChGy1+6/0C/yWAEAElgpC2mUHBce+nwjHMl0i+Fbh5LyF48JfvQj4WuRTPUWKyGBDu9zaMrR9VIMAzNgvdCXxsB0UFx7jdH06a15gOTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9878FEC;
	Tue,  3 Dec 2024 02:42:18 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D8A3F71E;
	Tue,  3 Dec 2024 02:41:48 -0800 (PST)
Message-ID: <95b655c2-dd60-488e-ab07-c7b958da1457@arm.com>
Date: Tue, 3 Dec 2024 11:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/11 v3] sched/fair: Fix statistics with delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
 luis.machado@arm.com, tj@kernel.org, void@manifault.com
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 18:45, Vincent Guittot wrote:
> Delayed dequeued feature keeps a sleeping sched_entitiy enqueued until its
> lag has elapsed. As a result, it stays also visible in the statistics that
> are used to balance the system and in particular the field h_nr_running.
> 
> This serie fixes those metrics by creating a new h_nr_runnable that tracks
> only tasks that want to run. It renames h_nr_running into h_nr_runnable.
> 
> h_nr_runnable is used in several places to make decision on load balance:
>   - PELT runnable_avg
>   - deciding if a group is overloaded or has spare capacity
>   - numa stats
>   - reduced capacity management
>   - load balance between groups
> 
> While fixing h_nr_running, some fields have been renamed to follow the
> same pattern. We now have:
>   - cfs.h_nr_runnable : running tasks in the hierarchy
>   - cfs.h_nr_queued : enqueued tasks in the hierarchy either running or
>       delayed dequeue
>   - cfs.h_nr_idle : enqueued sched idle tasks in the hierarchy
> 
> cfs.nr_running has been rename cfs.nr_queued because it includes the
> delayed dequeued entities
> 
> The unused cfs.idle_nr_running has been removed
> 
> Load balance compares the number of running tasks when selecting the
> busiest group or runqueue and tries to migrate a runnable task and not a
> sleeping delayed dequeue one. delayed dequeue tasks are considered only
> when migrating load as they continue to impact it.
> 
> It should be noticed that this serie doesn't fix the problem of delayed
> dequeued tasks that can't migrate at wakeup.
> 
> Some additional cleanups have been added:
>   - move variable declaration at the beginning of pick_next_entity()
>     and dequeue_entity() 
>   - sched_can_stop_tick() should use cfs.h_nr_queued instead of
>     cfs.nr_queued (previously cfs.nr_running) to know how many tasks
>     are running in the whole hierarchy instead of how many entities at
>     root level
> 
> Changes since v2:
> - Fix h_nr_runnable after removing h_nr_delayed (reported by Mike and Prateek)
> - Move "sched/fair: Fix sched_can_stop_tick() for fair tasks" at the
>   beginning of the series so it can be easily backported (asked by Prateek)
> - Split "sched/fair: Add new cfs_rq.h_nr_runnable" in 2 patches. One
>   for the creation of h_nr_runnable and one for its use (asked by Peter)
> - Fix more variable declarations (reported Prateek)

with the following nits:

(1) 01/11

    Proposed 'Fixes:' missing:
    https://lkml.kernel.org/r/c82ed217-cfe4-41a4-b39a-e7356231835f@amd.com

(2) 08/11

    Would be helpful to point out that we lost the only use case for 
    'cfs_rq->idle_nr_running' with the advent of EEVDF with:

    5e963f2bd465 - sched/fair: Commit to EEVDF

(3) Using nr_running on rq/rt_rq/dl_rq and nr_queued 
    for cfs_rq might look strange to the untrained eye.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]

