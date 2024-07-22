Return-Path: <linux-kernel+bounces-258643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01529938AFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12CE281E03
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08B8161313;
	Mon, 22 Jul 2024 08:16:54 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD24204F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721636214; cv=none; b=hM+H50cwI9SQvcjNsW9HVPRJTRtEgI8iPwgjRyqFx/8OfGdbsJeEcAKxZPLDgP5lBVI70e6DK3o2dz8RiUlxP5kVF/+Ctreenfm3QYiFm8oQWvBW1R0Pg9piBkslV6He1HidK+i//f2KSbxH8AhBKXeD2+++nhOlEi0Nyrk84AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721636214; c=relaxed/simple;
	bh=pKrmEjV/Grakvh/E7kFQ36OEqifgu+5D9lPZHO5IOM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F5RcYQADfyMoUsxEdhYSjTFaOcYtXsakhR5mgDlB+8bOkYtYd6uBONJfPQup0WRw9V9fsgDVsL5G78BOLs4nvP6VbRDeSyqGTlZJTrYhJDW37lQRdKB2hy0zbzgkr7ydgYWDHs81pmMSqPDa9H8lc+2kr2bfLgaBrJpiuYqpEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WSCgX1X6Wz2ClJq;
	Mon, 22 Jul 2024 16:12:24 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 3724F14037F;
	Mon, 22 Jul 2024 16:16:47 +0800 (CST)
Received: from [10.45.188.173] (10.45.188.173) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Jul 2024 16:16:45 +0800
Message-ID: <5607f1e2-b235-4eda-a9d9-2e9519db3f74@huawei.com>
Date: Mon, 22 Jul 2024 16:16:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
To: Chuyi Zhou <zhouchuyi@bytedance.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <chengming.zhou@linux.dev>, <linux-kernel@vger.kernel.org>,
	<joshdon@google.com>
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
 <20240721125208.5348-2-zhouchuyi@bytedance.com>
 <91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
 <d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
 <14c3db2b-5de2-4f1c-b4d4-6183568b8c24@huawei.com>
 <e4e3a63d-a5f2-4c1d-a9da-4ddbc3693450@bytedance.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <e4e3a63d-a5f2-4c1d-a9da-4ddbc3693450@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200007.china.huawei.com (7.202.181.34)



在 2024/7/22 15:46, Chuyi Zhou 写道:
>>>
>>> Thanks for your information.
>>>
>>> I think maybe cfs_bandwidth_usage_dec() should be moved to other more suitable places where could
>>> hold hotplug lock(e.g. cpu_cgroup_css_released()). I would do some test to verify it.
>>>
>>
>> The cpu_cgroup_css_released() also doesn't seem to be in the cpu hotplug lock-holding context.
>>
> 
> IIUC, cpus_read_lock/cpus_read_unlock can be called in cpu_cgroup_css_released() right? But cfs
> bandwidth destroy maybe run in a rcu callback since task group list is protected by RCU so we could not
> get the lock. Did I miss something important?


Okay, you're right. I ignored that we can't hold the hotplug lock in an rcu callback.

