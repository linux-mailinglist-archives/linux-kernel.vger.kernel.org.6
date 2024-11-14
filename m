Return-Path: <linux-kernel+bounces-408838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E005D9C8424
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FB91F2120D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317141EBFF9;
	Thu, 14 Nov 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o87d1ict"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3033CA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570436; cv=none; b=TMrItVobS/qSGftghP7F3Y35oiDueaLrp4z+uLQJYPUz2Ltt937yA4NouFgpGKFi+Ubxydm7VOQ4STffwr8rHpguOWvD51tNwg+PFJOeNQUu3zvffDt5Bcrvt05MWaCcAIF/zDCW35mG3oAfIeP7rdThcw6ds/qFZYYCzgVH6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570436; c=relaxed/simple;
	bh=RtCLtwC7P03ol1dmUwrxf+F2OSpDZAAvIDxTgX9ICdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpuKRSvfgfN8U+67JId8QLNBAKmhINeqGoR+eH4FIqONEZ6FNRbNioG48BO/f3+eTeF7grUQAx/ZevIgBiztR/8ac6EseRIW+lQE9p/oLoXiNw67jcR+O9J2A/Z8rOIBPhzUJie8hajT232zow4SDWKvcaY182pH6m01lma6rK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o87d1ict; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731570431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rv+9oFq6sE3dFxVOCJUt/7Fkb0yiXB0UVjn4Zmv5PR0=;
	b=o87d1ictL2f0xQQDC7jywsHvXO7/qfY5DC71THFmiGEbt3hQbV/Z1N9L8pWx74LyHdIZH3+WfvafhvglTEtgg4zQR8lpEgD1YQT8GfpaZjpfXOd+DTZt9yYqrFMTJ+DlPStD9q8zofz2ZvRqlT+oWz/0uRW9xGaw3QPuHIbTZGE=
Received: from 30.74.129.177(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WJNns1t_1731570429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 15:47:10 +0800
Message-ID: <1d2ad284-c887-4377-9512-a74dc418efa1@linux.alibaba.com>
Date: Thu, 14 Nov 2024 15:47:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq
 when a task changing slice
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
 <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
 <ME0P300MB04142599FB1D9BBF8AFECE7F8E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <a903d0dc-1d88-4ae7-ac81-3eed0445654d@linux.alibaba.com>
 <ME0P300MB041447EBB0A17918745695898E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ME0P300MB041447EBB0A17918745695898E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/14 15:33, 解 咏梅 wrote:
> delayed dequeue is nessary for eevdf to maintain lag. Paw’s relative vruntime is 
> not necessary any more in migration path.
> 
> 
> it is not a tuning option.
> 
> regards,
> Yongmei

I don't know why you so focus on DELAY_DEQUEUE, it is not related to the case I 
explained.

The case is about cgroup hierarchy. And the task_A in my case is already blocked 
and *out of rq*

I'm talking about its enqueue path when woken up.

