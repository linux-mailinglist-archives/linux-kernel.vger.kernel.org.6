Return-Path: <linux-kernel+bounces-277670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335B94A491
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A9C1C20E92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B41D0DD8;
	Wed,  7 Aug 2024 09:39:56 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D801CB32D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023596; cv=none; b=tlrC4QJN+bFbKKqBcn4dHGRyH3C6P9xx1/DlmOkk35K+8ZOw9JGpryWB4deSLCY8wPZbgc1/JkO2zdaI9epoV9Yz9nyZAuleY6LKEK3KJoD2NY9DwuD4v1dGrzTTjrm5wJ/4qj8O+r8f0iAR8/ekY+v5AqF7foQvXWYwkwQQs20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023596; c=relaxed/simple;
	bh=Se8ZNwRAjR9otbT64/9951NejPTVeEk4ZzicIlEtSaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oAxzGwXBRqpk8jI1Zs4u5PnlnUS1GKl3QJ5FuP+E8ge3V4Kt6K7JSq4zvcbeGc1awVCI4IhApA25hORIcxRnjk7rZGfW9viqJfvQtMvSoX4z7pElGH5wdrwt35UuDwjKQX031FQmj60+AOIJcR39ZKPjxHPOIw+15BHuwTj2ghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wf4lw4gQ0z20l7l;
	Wed,  7 Aug 2024 17:35:24 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id D65501A016C;
	Wed,  7 Aug 2024 17:39:50 +0800 (CST)
Received: from [10.45.183.231] (10.45.183.231) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 17:39:49 +0800
Message-ID: <7ae6fa16-80d3-4478-baae-b5bc06531e0c@huawei.com>
Date: Wed, 7 Aug 2024 17:39:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/deadline: Fix imbalanced task reference
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Wander Costa
	<wcosta@redhat.com>
References: <20240807083015.1385303-1-zhangqiao22@huawei.com>
 <ZrM3rZFGg_nPEjjV@jlelli-thinkpadt14gen4.remote.csb>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <ZrM3rZFGg_nPEjjV@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200007.china.huawei.com (7.202.181.34)



Hi,
在 2024/8/7 17:00, Juri Lelli 写道:
> Hi,
> 
> On 07/08/24 16:30, Zhang Qiao wrote:
>> When starting a deadline inactive_timer, the task_struct refs will
>> be incremented only if dl_server is not set. But when canceling the
>> inactive_timer, the task refs will be decremented whether dl_server is
>> set or not, leading to a task reference imbalance issue.
>>
>> This patch fixes the imbalanced reference by adding a '!dl_server()'
>> checker before calling put_task_struct().
>>
>> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> 
> Isn't this equivalent to Wander's patch below?
> 

Yeah, i didn't notice it.

> https://lore.kernel.org/lkml/20240724142253.27145-3-wander@redhat.com/
> 



Thanks,
Zhang Qiao.
> Thanks,
> Juri
> 
> 
> 

