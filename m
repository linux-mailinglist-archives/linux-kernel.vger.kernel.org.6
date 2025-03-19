Return-Path: <linux-kernel+bounces-567533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E15A68770
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0ED2421942
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE82517A7;
	Wed, 19 Mar 2025 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ncTWP35f"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7BC2517A5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375159; cv=none; b=W03xxGyo714kM9Xt1Ua/EitY5WE2oaQy+lAT+gYmi/94zwWc4GFdAaMcpZC6C+sAte4DMQCyh4QicK7W25L6hdHFDuj4CQmATBfGM4PmMVutphXcQJage3vwGGlmd0GdzQX5dPJ5xeAW/5TLT7emW+YKGUo+b+2b9FqZAbqsOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375159; c=relaxed/simple;
	bh=/YvpO/gUa8O5r7tGUhEHMPZP5YiPaZenpX6fglj43+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpGrMphOexBQG2u+3McT+pO/8QCyHh+ekP6700NjSj3r6nVo8jKSszNAhX8BXgfIc9RC2fUeUUO/C19Bsdb+nweletZPiBC5thslj6hjv/0WaCjHxcgOQrnD9VECOWdi53UNpp3U5X54HT2ZLB2Fw+PPhXHmH7r7uVVkX/VZtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ncTWP35f; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742375147; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0gLKnsENSbzeURVtViRPq5JAdU35kqKK5FojElpOoJ8=;
	b=ncTWP35fEndgV8rH70FBthTTX4qWOOrFevFkLFFfp7MehfhxMqIl+/G+Dk5CqxvebbfiWh1NiVAXz/SMIe37Mbm3clkV5hV9tuXIofoCdbVK02P0FSqvmSr16zpa/2v8N2XKwJcE/EMC0HYNZgMQE79waJRD1n8Zx7sD18hIurE=
Received: from 30.74.128.142(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WS1mQV3_1742375144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 17:05:45 +0800
Message-ID: <aa2205ab-de8e-4ea0-b9fc-56208ccd30ba@linux.alibaba.com>
Date: Wed, 19 Mar 2025 17:05:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH V2 1/3] sched/fair:
 Fixup-wake_up_sync-vs-DELAYED_DEQUEUE
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: vincent.guittot@linaro.org, peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, ke.wang@unisoc.com, di.shen@unisoc.com,
 xuewen.yan94@gmail.com
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
 <20250303105241.17251-2-xuewen.yan@unisoc.com>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20250303105241.17251-2-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Xuewen,

On 3/3/25 6:52 PM, Xuewen Yan wrote:
> Delayed dequeued feature keeps a sleeping task enqueued until its
> lag has elapsed. As a result, it stays also visible in rq->nr_running.
> So when in wake_affine_idle(), we should use the real running-tasks
> in rq to check whether we should place the wake-up task to
> current cpu.
> On the other hand, add a helper function to return the nr-delayed.
> 
> Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

We noticed that your patch can fix a regression introduced by DELAY_DEQUEUE 
in lmbench lat_ctx.

Here's the performance data running
`./lat_ctx -P $(nproc) 96`
on an intel SPR server with 192 CPUs (smaller is better):

DELAY_DEQUEUE                 9.71
NO_DELAY_DEQUEUE              4.02
DELAY_DEQUEUE + this_patch    3.86

Also on an aarch64 server with 128 CPUs:

DELAY_DEQUEUE                 14.82
NO_DELAY_DEQUEUE               5.62
DELAY_DEQUEUE + this_patch     4.66


We found the lmbench lat_ctx regression when enabling DELAY_DEQUEUE, with 
cpu-migrations increasing more than 100 times, higher nr_wakeups_migrate, 
nr_wakeups_remote, nr_wakeups_affine, nr_wakeups_affine_attempts and lower 
nr_wakeups_local.

We think this benchmark prefers waker and wakee staying on the same cpu, 
but WA_IDLE failed to reach this due to sched_delay noise. So your patch 
does fix it.

Feel free to add
Reviewed-and-tested-by: Tianchen Ding <dtcccc@linux.alibaba.com>

Thanks.

