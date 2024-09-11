Return-Path: <linux-kernel+bounces-324803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C764975111
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC53B23FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2468186607;
	Wed, 11 Sep 2024 11:50:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E701537C9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055412; cv=none; b=mQHXkESBpvpcd8VNpulKH4AD996M6ZeYfmq9CkZATOrqulcvtOoMjHZ5Qi7n6kcV1DzcPYez7z60D1UwXjRx++nEK3XRCvO2a1MPfUNirlKGwUL3D9XUtVk6mGerqzC/+FaqUZf94lJEjoOb2tPs0SGiqNvnIKY5SGH0ZK7YdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055412; c=relaxed/simple;
	bh=edkIKEk/zcSVt0K3ytWmjSzmlNzdB5TadLx9PEuf6rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhuoYiOfkWEZDTEawvYJru6Lnenpd5EjMBSqlWMcrPohMgMuWd1Reg3kTy/0vVWEwoJK5v6TWdfRV5qHr0SP9hpvB+8cMMJol2t92G0vWeJN7IkDUkHhMiPOhlHRk9aipEKWvGV1YB9WrGg+SHSjAGbjOepcxtDbAS8KHgGrQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D82AADA7;
	Wed, 11 Sep 2024 04:50:38 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A67B3F66E;
	Wed, 11 Sep 2024 04:50:06 -0700 (PDT)
Message-ID: <4e2ad815-a8f8-4800-b389-6b8a79bcf04e@arm.com>
Date: Wed, 11 Sep 2024 13:49:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>
Cc: Luis Machado <luis.machado@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Hongyan Xia <hongyan.xia2@arm.com>, mingo@redhat.com, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <20240905145354.GP4723@noisy.programming.kicks-ass.net>
 <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <8d0d01b9-a430-49cc-93a5-67b4d68aa35c@arm.com>
 <20240910140524.GH4723@noisy.programming.kicks-ass.net>
 <52ca4cea-8f65-434e-af17-e4bf664d9488@arm.com>
 <20240911084528.GJ4723@noisy.programming.kicks-ass.net>
 <4fde8f26a9aeaeafda15b81bbb17b0ffc96941f0.camel@gmx.de>
 <20240911091328.GM4723@noisy.programming.kicks-ass.net>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240911091328.GM4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2024 11:13, Peter Zijlstra wrote:
> On Wed, Sep 11, 2024 at 11:10:26AM +0200, Mike Galbraith wrote:
>> On Wed, 2024-09-11 at 10:45 +0200, Peter Zijlstra wrote:
>>> On Wed, Sep 11, 2024 at 09:35:16AM +0100, Luis Machado wrote:

[...]

>>>> So probably an unexpected decrement or lack of an increment somewhere.
>>>
>>> Yeah, that's buggered. Ok, I'll go rebase sched/core and take this patch
>>> out. I'll see if I can reproduce that.
>>
>> Hm, would be interesting to know how the heck he's triggering that.
>>
>> My x86_64 box refuses to produce any such artifacts with anything I've
>> tossed at it, including full LTP with enterprise RT and !RT configs,
>> both in master and my local SLE15-SP7 branch.  Hohum.
> 
> Yeah, my hackbench runs also didn't show that. Perhaps something funny
> with cgroups. I didn't test cgroup bandwidth for exanple.

Don't see it either on my Arm64 Juno-r0 (6 CPUs) with:

cgexec -g cpu:/A/B/C hackbench -l 1000

We are checking the Pixel6 now.
















