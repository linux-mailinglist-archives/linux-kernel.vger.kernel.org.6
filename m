Return-Path: <linux-kernel+bounces-554566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D840AA599FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3FA1699D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE7522A4E3;
	Mon, 10 Mar 2025 15:29:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF222A4C3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620561; cv=none; b=r4QOm7bVQx7h4j85lJ3643Z9cn02tdT/l9erUjyb2hWAt+K6XgBSi2h9Tpbe81nnYDlF4kFOZrqkSL+ZQzACDcbq625gwJkM+YeE0SKz0oLL5GqX85vp3yEVWhLaGk7LgLNt8VXZbAVgRfWFZG0e/jNKDe25HCLwuHk3fVimNI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620561; c=relaxed/simple;
	bh=9jsHEIUilFU+hAzGMJpulbNlAJCkWu5A0q07RLupo0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9jIpN5qhZb79q9/9gWrJOuYcXc510GzGWl+mSEqvW+MpAd9EuX6cBxS2Nst08kkW8jsHR+QxljfGodri2SbwHRgOOoIboiAwq6VrdQ1JOrKmVD7m8icE7l38zLAE0HT4RyR3PjuNeKCpDY17Nr5i647ET+DHHbqRDpOlSSCMLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE07D1692;
	Mon, 10 Mar 2025 08:29:29 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCFAF3F5A1;
	Mon, 10 Mar 2025 08:29:16 -0700 (PDT)
Message-ID: <8ddd7bb2-3a18-48b5-85c6-23263134308a@arm.com>
Date: Mon, 10 Mar 2025 16:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /sched/core: Fix Unixbench spawn test regression
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>, Hagar Hemdan
 <hagarhem@amazon.com>, linux-kernel@vger.kernel.org, wuchi.zero@gmail.com
References: <20250306162635.2614376-1-dietmar.eggemann@arm.com>
 <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtCfd_=gm7rsT_qBL8pw5uybEvYH4N2tvxpKndxxi4L7oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 14:59, Vincent Guittot wrote:
> On Thu, 6 Mar 2025 at 17:26, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> Hagar reported a 30% drop in UnixBench spawn test with commit
>> eff6c8ce8d4d ("sched/core: Reduce cost of sched_move_task when config
>> autogroup") on a m6g.xlarge AWS EC2 instance with 4 vCPUs and 16 GiB RAM
>> (aarch64) (single level MC sched domain) [1].
>>
>> There is an early bail from sched_move_task() if p->sched_task_group is
>> equal to p's 'cpu cgroup' (sched_get_task_group()). E.g. both are
>> pointing to taskgroup '/user.slice/user-1000.slice/session-1.scope'
>> (Ubuntu '22.04.5 LTS').
> 
> Isn't this same use case that has been used by commit eff6c8ce8d4d to
> show the benefit of adding the test if ((group ==
> tsk->sched_task_group) ?
> Adding Wuchi who added the condition

IMHO, UnixBench spawn reports a performance number according to how many
tasks could be spawned whereas, IIUC, commit eff6c8ce8d4d was reporting
the time spend in sched_move_task().

[...]

