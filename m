Return-Path: <linux-kernel+bounces-386182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 605ED9B4020
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154391F232F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6424126C01;
	Tue, 29 Oct 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fKaeab0X"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11C88172A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167663; cv=none; b=AgpH2uUQe3juOHHFk/WZnB3viYephwJlBPdt9Y3LdVMjAOVTWAxZPJVKld1WQrs+U170u9thBAn50AD/asNvV5uS0YNJncwfwl1TRLf1tUtux/dOar9fMpBFttTh9+lXmceefVKId0Opkl1ebzx5npGWabf7Pkl3lxnBq/TXXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167663; c=relaxed/simple;
	bh=GnVdX3ggVppPQ/hS6fDtTKnVptOBOcq7buqXGEbzBNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1HoBJ9ZCx9XBq4w39xSzhGx2MYYnuNiw1p5GJywqedu1ffbAQcINaA/7BETeSvSGYxm/Vmh5La3q/9KAYT/oklBqbZt1TD3Tc75/LeQXbcGAG6Quz4xAj+62F2yD83cltF8ke+VP/BE5i9ythY4cktClLxA25KCTzrPYv6YUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fKaeab0X; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730167658; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fUmX3bcpVhhyrvx6Y/iR5Yx/MiSlGOQFocQBSo30Ze0=;
	b=fKaeab0X/pDtan+CdAJTf3nWD1481/16pGKyq6RghGXkXK9jsLy6OEDcyBQMDIMc389eOQF4EgBkvhbqGV2vLiBQDg8vgkB+MDZ4wcCy5BEsvMbcn2vcI/cNLyrB39PJDpeM2h4UhWwACCv8gnNvBJ0JWZijgfV/F9AaQ5nOkLo=
Received: from 30.166.34.203(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WI8Qelo_1730167656 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Oct 2024 10:07:37 +0800
Message-ID: <ddfca6ac-f7a6-4b51-80e8-2e422de7d597@linux.alibaba.com>
Date: Tue, 29 Oct 2024 10:07:36 +0800
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
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <Zx_LwYshJV5LERm9@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/29 01:37, Tejun Heo wrote:
> Hello,
> 
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
> Provided that this tunable is necessary, wouldn't it be more useful to
> figure out what per-task interface would look like first? Maybe there are
> cases where per-cgroup slice config makes sense but that sounds
> significantly less useful than being able to configure it per-task.
> 
> Thanks.
> 

For eevdf, per-task interface has been introduced in commit 857b158dc5e8 
("sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion")

So This patch is trying to introduce a cgroup level interface.

Thanks.

