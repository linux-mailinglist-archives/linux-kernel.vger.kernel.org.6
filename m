Return-Path: <linux-kernel+bounces-561282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB5A60F97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465601B635BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9B1FAC59;
	Fri, 14 Mar 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/7LEbCD"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6931FCFC5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950444; cv=none; b=s+L+ALnUrMExTNi6clh1DjY9zdrp3hIYv1momu2mdKL70+rotcjr4Mq64iUiTMG3ifBZYM4O2X5MbyZBzzapls3f6RGbtp316BcxKCCspCdFmOJ8qqB91dSme89OXPcpPPMBYaa1ehSREbmsc6J99dMbb1I5iNJsMWnKBiSwqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950444; c=relaxed/simple;
	bh=RGeuciyPCOqXnqmW9vfSVTfcIOmCaRdu6j3O1HpEQi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHUATqTaRc54KbWi+o4Er8aSB685E8zvfUhQeW+R7xwYgP4yJ9w6y88cSnrISTdRg0EyvamUc/3GdpMxw+LMRk/tllwElBhm7bo+m23UZVU7KhL3EFxcCB/hcIrRaZcZQG/vi+3FYEf7h1zoyUDUKxwPrtJOZfZyHtSrQcsuS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q/7LEbCD; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a257205f-525f-48cf-b8d9-101ad8a95081@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741950438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NYjTbUrQ1ivB2JOofCxjfC09nCkE1h3GJAT87/k1R0=;
	b=Q/7LEbCDXcC1e9AWESRcsMbkmleLIDqpZfOa6Xw6/zIEBI+Z+aYHCnDbKJlA9ITmDXgtUL
	uEmhcFQ1NVlyh7CvAR/FV/64uRY2+0+mo0YMJaPxvGSLsA91fCh+hPpCBgod6+AT1mAtvB
	+XafOxJj28sC7mVvmadakgO6jExugPg=
Date: Fri, 14 Mar 2025 19:07:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
 <20250314094249.GC1633113@bytedance>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250314094249.GC1633113@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/14 17:42, Aaron Lu wrote:
> On Fri, Mar 14, 2025 at 04:39:41PM +0800, Chengming Zhou wrote:
>> On 2025/3/13 15:21, Aaron Lu wrote:
>>> From: Valentin Schneider <vschneid@redhat.com>
>>>
>>> Once a cfs_rq gets throttled, for all tasks belonging to this cfs_rq,
>>> add a task work to them so that when those tasks return to user, the
>>> actual throttle/dequeue can happen.
>>>
>>> Note that since the throttle/dequeue always happens on a task basis when
>>> it returns to user, it's no longer necessary for check_cfs_rq_runtime()
>>> to return a value and pick_task_fair() acts differently according to that
>>> return value, so check_cfs_rq_runtime() is changed to not return a
>>> value.
>>
>> Previously with the per-cfs_rq throttling, we use update_curr() -> put() path
>> to throttle the cfs_rq and dequeue it from the cfs_rq tree.
>>
>> Now with your per-task throttling, maybe things can become simpler. That we
>> can just throttle_cfs_rq() (cfs_rq subtree) when curr accouting to mark these
>> throttled.
> 
> Do I understand correctly that now in throttle_cfs_rq(), we just mark
> this hierarchy as throttled, but do not add any throttle work to these
> tasks in this hierarchy and leave the throttle work add job to pick
> time?

Right, we can move throttle_cfs_rq() forward to the curr accouting time, which
just mark these throttled.

And move setup_task_work() afterward to the pick task time, which make that task
dequeue when ret2user.

> 
>> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
>> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.
> 
> If we add a check point in pick time, maybe we can also avoid the check
> in enqueue time. One thing I'm thinking is, for a task, it may be picked
> multiple times with only a single enqueue so if we do the check in pick,
> the overhead can be larger?

As Prateek already mentioned, this check cost is negligeable.

> 
>> WDYT?
> 
> Thanks for your suggestion. I'll try this approach and see how it turned
> out.

