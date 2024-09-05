Return-Path: <linux-kernel+bounces-317318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B3F96DC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A325F1C2101E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8959C4369A;
	Thu,  5 Sep 2024 14:50:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373DE17BC9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547836; cv=none; b=Jrg5t34GEoStuQBOpMJjc+8/z6b4d6ydISlPG477bWwS/QWzhBFnJfHs+gNpuZ+6WhyV56rXsbfVClX68f0yAz1b149uM04QrFwhhtnaScbDJp7d09/SSYVJPS+Q32JgIKdhW5fE5HLfO0cDAIpNZeVOvXJYpBMV3fSrOdhOXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547836; c=relaxed/simple;
	bh=YgUJeXnUmRDPSbwcUCUUeEFiixY+9pNWKxQhgjsUQ2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjPizg3lJN6DzkIX7wXwF6ikt15N8FDHETMrhTdnc18VZIXF7ulLOs7qCvbBtvAAXmF+jK6h8SiDclt84IL866C3Avku1egGUHBz+Vb+kDGDFD+PaosJkEkIBqagOPN5t+994w4/6m+WQig8dnf61tOhI1gIn8mshg5V4eCICN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6BD1FEC;
	Thu,  5 Sep 2024 07:50:57 -0700 (PDT)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59E703F73B;
	Thu,  5 Sep 2024 07:50:28 -0700 (PDT)
Message-ID: <614a9238-0aaa-464d-a78b-b0b4f646a30b@arm.com>
Date: Thu, 5 Sep 2024 16:50:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Luis Machado <luis.machado@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
 <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
 <CAKfTPtCa3CAc+v55HdgTSAFTXF446KOCY6UsUyUes2ZVZqw1sg@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtCa3CAc+v55HdgTSAFTXF446KOCY6UsUyUes2ZVZqw1sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 16:29, Vincent Guittot wrote:
> On Thu, 5 Sept 2024 at 16:07, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 05/09/2024 15:33, Vincent Guittot wrote:
>>> On Thu, 5 Sept 2024 at 15:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 29/08/2024 17:42, Hongyan Xia wrote:
>>>>> On 22/08/2024 15:58, Vincent Guittot wrote:
>>>>>> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
>>>>>> <vincent.guittot@linaro.org> wrote:
>>>>>>>
>>>>>>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>>>>>>>>
>>>>>>>> Vincent,
>>>>>>>>
>>>>>>>> On 8/22/24 11:28, Luis Machado wrote:
>>>>>>>>> On 8/22/24 10:53, Vincent Guittot wrote:
>>>>>>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
>>>>>>>>>> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>

[...]

>> My hope was we can fix util_est independently since it drives CPU
>> frequency. Whereas PELT load_avg and runnable_avg are "only" used for
>> load balancing. But I agree, it has to be fixed as well.
> 
> runnable_avg is also used for frequency selection

Ah, yes. So we would need proper cfs_rq->h_nr_running accounting as well.



