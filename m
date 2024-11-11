Return-Path: <linux-kernel+bounces-403722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5A89C399E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70251C217A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFED15DBAE;
	Mon, 11 Nov 2024 08:25:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88E14F9F9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313534; cv=none; b=SCtgGjQwAK7FQaZsd8RcEYBu/536aLhRV5N6uiO6sXiR6EVXjodpOMqEXVFRn/2+3Sn6KjqtqL/PXTPNWJhpYiFIlaubZ1FyQOgJZkXFrZEQ8BujnTuIqx4C3AIMS5hJuSmqpzv5lM9ez7psReAgtYGA0W55pFel0jsbBwiyct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313534; c=relaxed/simple;
	bh=mdOmjwQRttA3OfEOxlXFP74Ez1riL/PdBjj+q5o+kQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lN99+CGWYjrRY2Egvt1uCno4RgrUbr6UsODhiCFaoBNHoyN0rhqQ17KR4nqFsuCSD0K6lFJdtPQiTHdwmigI3dd1zkrOiZnAKQc7uySGz+eC1CJGlOxRRR3gqIUJ5eG16ZgIOW729CAOD89vGtWHb8nsqw6xaIJsARu2rLe0KUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D61AA1D14;
	Mon, 11 Nov 2024 00:26:00 -0800 (PST)
Received: from [10.1.36.17] (e127648.arm.com [10.1.36.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 138993F6A8;
	Mon, 11 Nov 2024 00:25:26 -0800 (PST)
Message-ID: <6eb8c1ce-9823-4d6a-a04c-6a9dc1c346c8@arm.com>
Date: Mon, 11 Nov 2024 08:25:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Very high scheduling delay with plenty of idle CPUs
To: Saravana Kannan <saravanak@google.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, Thomas Gleixner <tglx@linutronix.de>,
 efault@gmx.de, John Stultz <jstultz@google.com>,
 Vincent Palomares <paillon@google.com>,
 Tobias Huschle <huschle@linux.ibm.com>
References: <CAGETcx830PZyr_oZAkghR=CLsThLUX1hZRxrNK_FNSLuF2TBAw@mail.gmail.com>
 <20241108083133.GD38786@noisy.programming.kicks-ass.net>
 <CAGETcx-CvWVc=TP5OmUL_iF7fSb1awJB1G8NghM1q_6dYKXkQQ@mail.gmail.com>
 <cc8831c7-8ea2-0ee7-061f-73352d7832ad@amd.com>
 <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAGETcx9qDK+QUiP8z1iNYXwjHz39oZzOZmhj4p=icU1BuVtcug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 06:15, Saravana Kannan wrote:
[...]
>>> Can we tell the scheduler to just spread out all the tasks during
>>> suspend/resume? Doesn't make a lot of sense to try and save power
>>> during a suspend/resume. It's almost always cheaper/better to do those
>>> quickly.
>>
>> That would increase the resume latency right since each runnable task
>> needs to go through a full idle CPU selection cycle? Isn't time a
>> consideration / concern in the resume path? Unless we go through the
>> slow path, it is very likely we'll end up making the same task
>> placement decisions again?
> 
> I actually quickly hacked up the cpu_overutilized() function to return
> true during suspend/resume and the threads are nicely spread out and
> running in parallel. That actually reduces the total of the
> dpm_resume*() phases from 90ms to 75ms on my Pixel 6.
> 
> Also, this whole email thread started because I'm optimizing the
> suspend/resume code to reduce a lot of sleeps/wakeups and the number
> of kworker threads. And with that + over utilization hack, resume time
> has dropped to 60ms.
> 
> Peter,
> 
> Would you be open to the scheduler being aware of
> dpm_suspend*()/dpm_resume*() phases and triggering the CPU
> overutilized behavior during these phases? I know it's a very use case
> specific behavior but how often do we NOT want to speed up
> suspend/resume? We can make this a CONFIG or a kernel command line
> option -- say, fast_suspend or something like that.
>

Just to confirm, you essentially want to disable EAS during
suspend/resume, or does sis also not give you an acceptable
placement?

Regards,
Christian

