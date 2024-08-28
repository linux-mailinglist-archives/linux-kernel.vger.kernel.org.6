Return-Path: <linux-kernel+bounces-304938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5021D962712
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C881F241FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064B1176226;
	Wed, 28 Aug 2024 12:26:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AC016A95E;
	Wed, 28 Aug 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848014; cv=none; b=mcYSghbM6B0zl4UiLI7aSyA2xEYyarjLwuW6GlBwi01uL2tdDlQM5SCwWBhW56cQ+bHvOoX9EHgvLe//gIzzgr/g+2QQjGfMtd1p7jtNSMSW6Cium8HPc5EaRjJf8UpnFbvbBhfqCVg3+rttzQsJ8mUMQRKc07mExNDRzgcLxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848014; c=relaxed/simple;
	bh=ImIC3vyFzObBoriW48+BQvmzYEpG+mruKbJM4GXGUJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVrY3HHcFMnx/PPU9CMPMXl2YjTEnKMwDORjJgd/h5YBXR10szt4SD0RGUt7p6rWfLbYig3R+4YyUp2ZaRVlJOaI8L4vgZ0DI0mhIZEEf4JexbHOEo23PCi/IZOHo7BEzZVq8+9JOsWtMxpg9bLoradJ2zhc9Z06VXYzRKMuH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67739DA7;
	Wed, 28 Aug 2024 05:27:18 -0700 (PDT)
Received: from [10.1.35.53] (e127648.arm.com [10.1.35.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8636C3F762;
	Wed, 28 Aug 2024 05:26:49 -0700 (PDT)
Message-ID: <7661afec-168d-406e-903b-a2dc9adf6408@arm.com>
Date: Wed, 28 Aug 2024 13:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Allow complete locally if capacities are
 different
To: Bart Van Assche <bvanassche@acm.org>,
 Manish Pandey <quic_mapa@quicinc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
 quic_narepall@quicinc.com, quic_rampraka@quicinc.com, quic_cang@quicinc.com,
 quic_nguyenb@quicinc.com, Qais Yousef <qyousef@layalina.io>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240828114958.29422-1-quic_mapa@quicinc.com>
 <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/28/24 13:13, Bart Van Assche wrote:
> On 8/28/24 7:49 AM, Manish Pandey wrote:
>> 'Commit af550e4c9682 ("block/blk-mq: Don't complete locally if
>> capacities are different")' enforces to complete the request locally
>> only if the submission and completion CPUs have same capacity.
>>
>> To have optimal IO load balancing or to avoid contention b/w submission
>> path and completion path, user may need to complete IO request of large
>> capacity CPU(s) on Small Capacity CPU(s) or vice versa.
>>
>> Hence introduce a QUEUE_FLAG_ALLOW_DIFF_CAPACITY blk queue flag to let
>> user decide if it wants to complete the request locally or need an IPI
>> even if the capacity of the requesting and completion queue is different.
>> This gives flexibility to user to choose best CPU for their completion
>> to give best performance for their system.

Why have the flag be
QUEUE_FLAG_ALLOW_DIFF_CAPACITY
instead of just
QUEUE_FLAG_SAME_LLC
so it isn't as HMP specifically-worded?
(And of course then having QUEUE_FLAG_SAME_COMP be strictly
stronger than QUEUE_FLAG_SAME_LLC. On !HMP they are equal.)
That would also answer Bart's question below how this is
different to rq_affinity=0.

> 
> I think that the following is missing from the above description:
> - Mentioning that this is for an unusual interrupt routing technology
>   (SoC sends the interrupt to another CPU core than what has been
>    specified in the smp_affinity mask).

FWIW on !mcq that doesn't have to be the case.

> - An explanation why the desired effect cannot be achieved by changing
>   rq_affinity into 0.
> 
>>   block/blk-mq-debugfs.c |  1 +
>>   block/blk-mq.c         |  3 ++-
>>   block/blk-sysfs.c      | 12 ++++++++++--
>>   include/linux/blkdev.h |  1 +
>>   4 files changed, 14 insertions(+), 3 deletions(-)
> 
> Since the semantics of a sysfs attribute are modified,
> Documentation/ABI/stable/sysfs-block should be updated.
> 
> Thanks,
> 
> Bart.
> 


