Return-Path: <linux-kernel+bounces-209807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F330E903B22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E0FB260F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11D17F4E6;
	Tue, 11 Jun 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZWat7ZHm"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501017C7CA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106402; cv=none; b=YLeJlRm5W82oKBrX5PnW2irI4auzfzbPXRbICJ3G92+fFgYOAxpjtSi5onWK4EaLQC0XOCpBVb2bi43Nn0OjFDlNr0SulVGWpHiMz/FwgRFnoHj5EhRWIuYiNvmJzjnZ3WOOkR88GlyKiK8wftvY0FOyypeM3fEqBTAvnxkpRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106402; c=relaxed/simple;
	bh=4Iw4fKsDc/U0YUlAj9b61PaJoo45yzZofCFRy/INvHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7gXTncgY54x16wzWWZrkBqKNApOxaxYYdDsMZVfxd6wUVVpeSdAUGIxDLpv6KXLksdcR00VEcSqfwyaWx6sxPO+gPJ6PEdGREAfND1y3YvwMyfDwnWwsQTq6CCB8Szm0gWd45hn7n0BNy2ofiKb1FtJl54DHL18gescz7GXZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZWat7ZHm; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=/RlQz+7UKTdFqSfL5oJg7kZuSi4+tMMNoJuBh5KXON8=;
	b=ZWat7ZHmIlqfR/pMSbiA+WcrAPKPN8Ctg2T10SwHLin8Y644FdQnzS+nF8QDPG
	APbmkd/18wVax0hlyq0vhlWffbXD6NXyZbeOt8RmfqoSNYrDH14zzCf2XyQlr1zv
	JuD6tRbae7p18Sm8LykON8RAXRwoSs1NjTsVoc6617irM=
Received: from [172.24.140.37] (unknown [111.204.182.99])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnj_Z+N2hmp0mlDQ--.43517S2;
	Tue, 11 Jun 2024 19:39:45 +0800 (CST)
Message-ID: <b596cb41-9c62-4134-a76d-6139ae859b07@126.com>
Date: Tue, 11 Jun 2024 19:39:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
 yangchen11@lixiang.com, Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <572bef0a-727c-4922-93e9-ad29c385120e@126.com>
 <6AF97701-B8F4-46C6-851E-A8BACE97E8C0@gmail.com>
 <bb43844e-0ef2-44d6-9d98-496865d942b9@126.com>
 <DD2A2CD1-E7F9-4519-82F5-22E769364C55@gmail.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <DD2A2CD1-E7F9-4519-82F5-22E769364C55@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnj_Z+N2hmp0mlDQ--.43517S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww45ZrW8WFyrWr1rWr13XFb_yoW8AF47pr
	ZxX3WFyw1DC3Z7Ja1Iq3y2qryIyF4fAFZrJryvkry7KanxC3W0gFyfCF43CF9F9F4F9wn0
	v3s8Aw17AryDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC_M-UUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJAb6rWW-Py04fQAAs4



On 2024/6/6 20:39, Chunxin Zang wrote:

> 
> Hi honglei
> 
> Recently, I conducted testing of multiple cgroups using version 2. Version 2 ensures the
> RUN_TO_PARITY feature, so the test results are somewhat better under the
> NO_RUN_TO_PARITY feature.
> https://lore.kernel.org/lkml/20240529141806.16029-1-spring.cxz@gmail.com/T/
> 
> The testing environment I used still employed 4 cores,  4 groups of hackbench (160 processes)
> and 1 cyclictest. If too many cgroups or processes are created on the 4 cores, the test
> results will fluctuate severely, making it difficult to discern any differences.
> 
> The organization of cgroups was in two forms:
> 1. Within the same level cgroup, 10 sub-cgroups were created, with each cgroup having
>    an average of 16 processes.
> 
>                                    EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
> 
>     LNICE(-19)    # Avg Latencies: 00572      00347      00502      00218
> 
>     LNICE(0)      # Avg Latencies: 02262      02225      02442      02321
> 
>     LNICE(19)     # Avg Latencies: 03132      03422      03333      03489
> 
> 2. In the form of a binary tree, 8 leaf cgroups were established, with a depth of 4.
>    On average, each cgroup had 20 processes
> 
>                                    EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
> 
>     LNICE(-19)    # Avg Latencies: 00601      00592      00510      00400
> 
>     LNICE(0)      # Avg Latencies: 02703      02170      02381      02126
> 
>     LNICE(19)     # Avg Latencies: 04773      03387      04478      03611
> 
> Based on the test results, there is a noticeable improvement in scheduling latency after
> applying the patch in scenarios involving multiple cgroups.
> 
> 
> thanks
> Chunxin
> 
Hi Chunxin,

Thanks for sharing the test result. It looks helpful at least in this 
cgroups scenario. I'm still curious which point of the two changes helps 
more in your test, just as mentioned at the very first mail of this thread.

Thanks,
Honglei


