Return-Path: <linux-kernel+bounces-414468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0E9D287B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BDE280169
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E731CEABA;
	Tue, 19 Nov 2024 14:46:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE5914658D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027590; cv=none; b=pzrvRI+qnHU4UmX1oBaPwe7sG65IQA0iB/P6AFBG3PH4W7W7bqZYfNQDDbf4eQi+sOuFaN4K27tnd86Y+vxLwqqpD0FhEEP4Z7HDPYyDbJmSW67EWmrLDOUMsgYye0Cqf7f655sppvDfdOB9/oeeTLyRABmpj0k19umt0zt07qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027590; c=relaxed/simple;
	bh=xAE7/XY5/Mc2mV8Ci+AYKf4AWqFroPjXWvrO7AzaTp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRmrl7SLRBW0/p2VDyANmAU3CL5beeTNjX+/hiLvZ+vgjlqdSvT/5A4d0VN84EJ6dsScn/K0vlM/RUo8DX8sa5hBbnGxoXC6SiQTrstP+qkm6FI2KW2wIrxsWqxWVdwUam4F9I8do1powCEOEwIhze/6JaHdiENmP3zNmAowER8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14446339;
	Tue, 19 Nov 2024 06:46:56 -0800 (PST)
Received: from [10.1.31.25] (e127648.arm.com [10.1.31.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E4FD3F5A1;
	Tue, 19 Nov 2024 06:46:22 -0800 (PST)
Message-ID: <62a15cd6-db6a-4010-94db-e78aad9fc7ac@arm.com>
Date: Tue, 19 Nov 2024 14:46:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Quentin Perret <qperret@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 07:27, Vincent Guittot wrote:
> On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
>>
>> On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
>>> With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
>>> utilization"), the util_est remains set the value before having to
>>> share the cpu with other tasks which means that the util_est remains
>>> correct even if its util_avg decrease because of sharing the cpu with
>>> other task. This has been done to cover the cases that you mention
>>> above whereboth util_avg and util_est where decreasing when tasks
>>> starts to  share  the CPU bandwidth with others
>>
>> I don't think I agree about the correctness of that util_est value at
>> all. The above patch only makes it arbitrarily out of date in the truly
>> overcommitted case. All the util-based heuristic we have in the
>> scheduler are based around the assumption that the close future will
>> look like the recent past, so using an arbitrarily old util-est is still
>> incorrect. I can understand how this may work OK in RT-app or other
> 
> This fixes a real use case on android device
> 
>> use-cases with perfectly periodic tasks for their entire lifetime and
>> such, but this doesn't work at all in the general case.
>>
>>> And feec() will return -1 for that case because util_est remains high
>>
>> And again, checking that a task fits is broken to start with if we don't
>> know how big the task is. When we have reasons to believe that the util
>> values are no longer correct (and the absence of idle time is a very
>> good reason for that) we just need to give up on them. The fact that we
>> have to resort to using out-of-date data to sort of make that work is
>> just another proof that this is not a good idea in the general case.
> 
> That's where I disagree, this is not an out-of-date value, this is the
> last correct one before sharing the cpu
Just adding on this since we are discussing the correctness of util_est
value on an OU CPU since
commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task utilization").
I agree that this commit fixed the immediate false util_est drop after
coscheduling two (or more) tasks, but that's a specific one.
If one of two coscheduled tasks starts growing their util_est can't reflect
that if their compute demand grows above CPU-capacity, that commit doesn't
change the fact. There is no generally sensible way of estimating such a
util_est anyway.
Even worse if both coscheduled tasks grow which isn't uncommon, considering
they might be related.

So
"this is the last correct one before sharing the cpu" is true,
"This is not an out-of-date value" isn't true in the general case.

I agree that the OU definition can evolve, basing that on idle time makes
sense, but given the common period of 16ms (frame rate) we might delay
setting OU by quite a lot for the cases it 'actually is true'.

Regards,
Christian

