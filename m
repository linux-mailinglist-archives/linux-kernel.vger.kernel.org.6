Return-Path: <linux-kernel+bounces-256394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4DD934DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D22284DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA061E86F;
	Thu, 18 Jul 2024 13:02:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912A44A15
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721307735; cv=none; b=mWXAfJX8PagRvL8hFMWOWWXqTU/8bDl6F40I6RjpmED01TtdlP7/REvc0eMl9t7JK1kN0TxikZa4CLaxSLTZQNjGqzKWuERk0i8TfPBn+L+OOeHicERJIJk5SMzlybKSCOGrWsJqzw3lmgc5In8hGBOsj/ZAPYyQ65CsTGh9TDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721307735; c=relaxed/simple;
	bh=KSBv8hpSDCYAQ6rdUHk/vHVU4a5pW9NqrYeDsnSMMW8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=Ir19AJ+PnNXQFvYDYwd5xWmk3qHi8gQELwDKK+Os2PHVqcBnp9skoO2He+yLYSoLYvOd/herTRVXZ5DINnOZuH/yCMnnY8Osa7RuOWWDnFykxrXo9GamI1gpNmN0/SqVp0JWLPwYu4oLN9/Ix9/aVyBzF02NcXvs+7CSAAXgfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WPtGx0jNYznbMv;
	Thu, 18 Jul 2024 21:01:29 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (unknown [7.185.36.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E3B221400DC;
	Thu, 18 Jul 2024 21:02:08 +0800 (CST)
Received: from [10.67.110.25] (10.67.110.25) by dggpemm500022.china.huawei.com
 (7.185.36.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 21:02:08 +0800
Message-ID: <aa5f702d-30e3-77e2-084b-3a618204e9e8@huawei.com>
Date: Thu, 18 Jul 2024 21:02:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
From: "zhaowenhui (A)" <zhaowenhui8@huawei.com>
Subject: [BUG REPORT] sched/rt: Inaccurate numerical calculation in
 rt_runtime_us constraints
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>, "open list:SCHEDULER"
	<linux-kernel@vger.kernel.org>
CC: <zhangqiao22@huawei.com>, <tanghui20@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500022.china.huawei.com (7.185.36.162)

Hello,
Recently, we find that the cgroup rt_runtime_us's constraints is not
precise enough in some cases. For example:

(1)
create a father cgroup and a child cgroup, and we exec:
   echo 1048577 > /sys/fs/cgroup/cpu/father/cpu.rt_period_us
   echo 1048577 > /sys/fs/cgroup/cpu/father/child/cpu.rt_period_us
   echo 0 > /sys/fs/cgroup/cpu/father/cpu.rt_runtime_us
   echo 1 > /sys/fs/cgroup/cpu/father/child/cpu.rt_runtime_us

(2)
create a father cgroup and two child cgroups, and we exec:
   echo 20000 > /sys/fs/cgroup/cpu/father/cpu.rt_runtime_us
   echo 10000 > /sys/fs/cgroup/cpu/father/child1/cpu.rt_runtime_us
   echo 10001 > /sys/fs/cgroup/cpu/father/child2/cpu.rt_runtime_us

Logically speaking, the sum of child cgroups' rt_runtime_us should be
less than the fater's rt_runtime_us, but actually both cases above would
work. Because in to_ratio(), "div64_u64(runtime << BW_SHIFT, period)"
ignores the remainders. So if the rt_period_us is big or many child
cgroups' remainders are ignored, it could happen.

But after all, it doesn't damage a lot, and seems not so easy to fix. So
I report this and see what can we do about it.

---
Regards
Zhao Wenhui

