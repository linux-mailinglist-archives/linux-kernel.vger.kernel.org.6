Return-Path: <linux-kernel+bounces-388955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9EF9B6691
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C5BB218AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6465B1F131C;
	Wed, 30 Oct 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="quxjfLcU"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94871E283B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300109; cv=none; b=ia1xBfwP3AofPI1Iz9O8ZMaVwBb/tBBkXWy7M0fzmtoL8ABMpgEGm8qNvptdboMDitdo4xFreLLjjCD2ju6nGQIuywrNVO6jLIdhxuIbktPc9jBRz+PCAGySMHUT1+WHfxO8R+QQN7yfjK8EJvZAdqnnH23lLzRD8C5GRlLuzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300109; c=relaxed/simple;
	bh=8GQmTy/FLXZndHo+neFresEZIwdNAaA7L9AJX3d10/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxXgEN31+ljZWNBmRsaK5Sm5WJiNY4kir3ToZ7LiZrYslzYcXBgYtchrzDG7LtXTtXpLQUr6MH1KGHh6Rf1Li2Z2gZTjXp/q3p2HK5TfFKesevM2K4HWhlKB9Yuw9Qxz6aiCgSf9xOoAd7N/XLe8BHV/+6EUE+VLVT3dYpk1RFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=quxjfLcU; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730300100; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vZvKfJLK1tRjd3BlOpPndLkFLgCGRbtfaNcdJ6top5w=;
	b=quxjfLcUvV4pvjl9zhPh9ol4JHWHBfQhN+l5O5Q5REorM/v1RB1jV+189XiY8nCUPj3b9x6wdt+wzqZV01ZXZ+VBWsPH5l9ZMN72PkveDuuKdXMtb8yK+EJRMmQbdU/u42ZHQSFluszDinSLTSpoz568d9b+kD+KefYORI/esCU=
Received: from 172.16.28.114(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WIFDO6V_1730300098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 22:55:00 +0800
Message-ID: <245c5d4d-408c-4910-b0e1-a694a6432d88@linux.alibaba.com>
Date: Wed, 30 Oct 2024 22:54:58 +0800
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
 <20241028063313.8039-3-dtcccc@linux.alibaba.com>
 <20241030110056.GL14555@noisy.programming.kicks-ass.net>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20241030110056.GL14555@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 19:00, Peter Zijlstra wrote:
> On Mon, Oct 28, 2024 at 02:33:13PM +0800, Tianchen Ding wrote:
>> Introduce "cpu.fair_slice" for cgroup v2 and "cpu.fair_slice_us" for v1
>> according to their name styles. The unit is always microseconds.
>>
>> A cgroup with shorter slice can preempt others more easily. This could be
>> useful in container scenarios.
>>
>> By default, cpu.fair_slice is 0, which means the slice of se is
>> calculated by min_slice from its cfs_rq. If cpu.fair_slice is set, it
>> will overwrite se->slice with the customized value.
> 
> So I'm not sure I like to expose this, like this.
> 
> The thing is, this is really specific to the way we schedule the cgroup
> mess, fully hierarchical. If you want to collapse all this, like one of
> those bpf schedulers does, then you cannot do this.

Yes, "slice" is an absolute value and may not fit the hierarchical cgroup...
There probably might not be a perfect solution :(

Anyway, I'll later send v2 for the 1st patch which fixes an existing issue.

Thanks.

