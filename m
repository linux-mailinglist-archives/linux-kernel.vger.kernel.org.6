Return-Path: <linux-kernel+bounces-343392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ABE989A72
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4291C20E47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4C14375C;
	Mon, 30 Sep 2024 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="j1CKs9pT"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC791F5EA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676730; cv=none; b=mKfTaAt5a/2PqC3l0HyM97lS/o1o2DdNFeR98fFZyJejJN8YVfrfixgNpwo9YCc+35QC1YC8V0p8cgIvnQMLG4t/l6t+kc3pbmrLUMTfSz3VT18FeQarafkN4KLFi5amhttCi/ieNtK1msq6Dud0ZqIUI/wQqGnEriQkf1mdz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676730; c=relaxed/simple;
	bh=rr2gBtdNUqppvpkdR5xh8zcOTUrtj7Kxh4MO/Iyi9eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFD31HDEmHjkhizmNqxddw50MpeNFf6Xcmr9hQrW/KJVp4074HSYiI5nDohh2QK0J4KetbK4j1Xm/y7ngKouQIttbPfvK1YVNi9BaOVolp7z/ZSZadYZee+/STtN66XpEJcoHFk5TrrGUN09HJVtT11T07+ntdNePv0AIJdKzro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=j1CKs9pT; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=axF8x16LoOAk98oDqIGr3ccSMnN5UdET526dcGxAu5A=;
	b=j1CKs9pTZ7gyJtzKUDXNa5fDhJnHLDhavZmxkWFe31CDw1d6bfF5tETzOMM2z1
	LeX9Y3i7/SNXhsDzsqgB69x9gXKQw/NsTeRdokrZh0BDfiOmrzi5OvFN6vkrWpBH
	E9xe+MgS1FX+Y9fxS0kS09NYnhdIBkCKyeLUw+f5cIGM4=
Received: from [172.24.140.9] (unknown [111.204.182.99])
	by gzsmtp2 (Coremail) with SMTP id pikvCgD3H+UMQfpmc5noAQ--.41019S2;
	Mon, 30 Sep 2024 14:11:25 +0800 (CST)
Message-ID: <7547b8e1-3bf6-4909-8f12-8817ce772ee7@126.com>
Date: Mon, 30 Sep 2024 14:11:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Fix wakeup-preempt by checking
 cfs_rq->nr_running
To: Chen Yu <yu.c.chen@intel.com>
Cc: Oliver Sang <oliver.sang@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, linux-kernel@vger.kernel.org,
 Chen Yu <yu.chen.surf@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>
References: <20240925085440.358138-1-yu.c.chen@intel.com>
 <fea9b64f-4ede-475d-8788-73bce88b2e3a@126.com>
 <ZvZXEqNLcJxq+8Aw@chenyu5-mobl2>
 <c15e2f07-5a0d-4e48-b7f4-83e4689f9299@126.com>
 <ZveiDh2/ztZTP/fH@chenyu5-mobl2> <ZvlbZYQE5Slf2YEb@xsang-OptiPlex-9020>
 <8282e4e8-6d71-4402-9eed-38865a3fc6f3@126.com>
 <ZvoLWQICLdTonRE/@chenyu5-mobl2>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <ZvoLWQICLdTonRE/@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pikvCgD3H+UMQfpmc5noAQ--.41019S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWxZF43Gw4kKr45Xw1kXwb_yoW5CrWUpr
	ZxKa4xKr4ktry8Awn2yw1fXr1YkrZrJr1UXry8Jr18J3Z09F1Utr45Kr18CryDCry8Ar1Y
	va1UtFW3Zr18A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UtpnQUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirwxqrWb6KhSvTAAAsl



On 2024/9/30 10:22, Chen Yu wrote:
> On 2024-09-30 at 10:04:13 +0800, Honglei Wang wrote:
>> Hi Oliver,
>>
>> On 2024/9/29 21:51, Oliver Sang wrote:
>>> hi, Chenyu and Honglei,
>>>
>>> On Sat, Sep 28, 2024 at 02:28:30PM +0800, Chen Yu wrote:
>>>> Hi Honglei,
>>>>
>>>> On 2024-09-27 at 21:38:53 +0800, Honglei Wang wrote:
>>>>> Hi Yu,
>>>>>
>>>>> Yep, I understand the preemption should happen in the same cfs level. Just
>>>>> not sure the purpose of the 'nr_running check' stuff. Perhaps its role is
>>>>> just to judge whether it’s necessary to do the preemption check. If there is
>>>>> at least one more ready (cfs) task in the rq and current is not eligible, we
>>>>> take care of the waiting tasks. Thoughts?
>>>>
>>>> I got your point and it makes sense. Whether the preemption check should be triggered
>>>> seems to be a heuristic trade-off to me. I'm ok with using more aggressive preemption
>>>> strategy as it depends on whether that workload prefers latency or throughput, and as
>>>> long as it did not introduce regression :-)
>>>>
>>>> Oliver, may I know if you happen to have time for a test if the following change
>>>> suggested by Honglei would make the regression go away? Thanks.
>>>
>>> I applied the patch directly upon 85e511df3cec, the test found it can reduce the
>>> regression but not totally reovered
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/ipc/iterations/kconfig/mode/nr_threads/rootfs/tbox_group/testcase:
>>>   gcc-12/performance/socket/4/x86_64-rhel-8.3/process/50%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/hackbench
>>>
>>> commit:
>>>   82e9d0456e06 ("sched/fair: Avoid re-setting virtual deadline on 'migrations'")
>>>   85e511df3cec ("sched/eevdf: Allow shorter slices to wakeup-preempt")
>>>   8079496d311b  <--- patch from Honglei
>>>
>>> 82e9d0456e06cebe 85e511df3cec46021024176672a 8079496d311b6b0d4dae973f4df
>>> ---------------- --------------------------- ---------------------------
>>>          %stddev     %change         %stddev     %change         %stddev
>>>              \          |                \          |                \
>>>     623219           -13.1%     541887            -3.2%     603080        hackbench.throughput
>>>
>>
>> Thanks a lot for running the test. The result is as expectation, as the
>> strategy of short slices tends to favor more frequent scheduling to help
>> delay-sensitive tasks acquire CPU as early as possible.
>>
>> I suspect that the current test environment does not have any special
>> configurations for slices. In this case, a 3.2% regression is still
>> somewhat significant. As Yu mentioned, this is a heuristic adjustment.
>> In this particular case, it seems that Yu's patch is more effective in
>> solving the problem. Let's delegate the preemption opportunity to the
>> higher-level update_curr() function.
>>
> 
> Thanks Oliver and Hongwei.
> 
> Hi Hongwei, do you mind if I added your Reviewed-by tag on this?
> 

OK. Feel free to include:

Reviewed-by: Honglei Wang <jameshongleiwang@126.com>

Thanks,
Honglei

> thanks,
> Chenyu 


