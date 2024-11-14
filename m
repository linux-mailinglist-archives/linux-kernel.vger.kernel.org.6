Return-Path: <linux-kernel+bounces-408605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A79C80FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6CE2814B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED91E8835;
	Thu, 14 Nov 2024 02:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oBCZbsLw"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99036AAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552366; cv=none; b=DltLGFCFwtuqhh089ZG240ERk8zBjUcr8KZIpFeVeqZ/J+qTLB7/orwzPru0LuApeC5ESDabmQJgvUwVeA/kb1ijbxh1qVeO7vRsJ6Gx/uUoEK0N2lWpuiD93QdqJ6DG/NXdOF0KencU6+7P+YKv2YlFFt3H0mQZNnAHMTzndlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552366; c=relaxed/simple;
	bh=PqHSbXEoWIwxWSNpSWpG5My4KxqNioYkmdRctVUN2+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNbKbC7VKQYT0foQegqa+3xQDXkuvIdjJCYRl3NuJebLQQwYoluC0ct12kGftFBe5mbPSLJIG2cVwjuswbNOrfeYIiEkzrmC3y8VITT6ocy662O0T71+NHt2VdjNWVabBawhMWPZBklSGDSfbjvZG3RJM4Cf83K8IBV5cyotzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oBCZbsLw; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731552358; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oKOZoVEdbHWlDkJLCJ38R27KYg2euGLgWFp2f0IME28=;
	b=oBCZbsLw5TtOBmj0Zwo/bHdvOTDo/9esl8Z20YIVMe18G+2gu5/jkjDKSgJ/rYitJcyZEfDMCQqspA2YhCILaf9D/24MQs1qGCSgYvFA81MlR1ADYyGBsnG2dhx43ol3Z5G9XrkMTJQu1FoGi685Z02Fmv95qiHv79Xnm9B5K7Q=
Received: from 30.74.129.177(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WJMgS.m_1731552356 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 10:45:57 +0800
Message-ID: <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
Date: Thu, 14 Nov 2024 10:45:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBzY2hlZC9lZXZkZjogRm9yY2Ug?=
 =?UTF-8?Q?propagating_min=5Fslice_of_cfs=5Frq_when_a_task_changing_slice?=
To: =?UTF-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
 <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
 <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/13 19:50, 解 咏梅 wrote:
> Similar problem as commit d2929762 & 8dafa9d0, but this time heap integrity is corrupted by min_slice attr.
> commit eab03c23c fixed it by explicitly calling __dequeue_entity and __enqueue_entity in reweight_entity.
> 
> But, it's rare case, it only happens when adjust task's select by setting up scheduler attribute.
> 

It's not rare. Since it's in enqueue/dequeue common path, wakeup/sleep may also 
trigger this issue.

> 
> Regards,
> Yongmei.


