Return-Path: <linux-kernel+bounces-427788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D5C9E05A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6669328DB19
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B62D205E0C;
	Mon,  2 Dec 2024 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="c1OLPR17"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123281FA15B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151081; cv=none; b=FQZ4yMAPwcYL3sX47g4r+qvEwS7R78tlBRXGSHhQdWXk4pkjd9MAClZSz+EMo7Gbb+Z8gNeFSVFOAKPuEt9ucAKwj7YvVNqXlzQF3BwaJDrBLwoL1z+AyLNY5Vpw4Cti7fjWmZqQub59Wl9rP4DzFT/YpjsxYU5TAlQTu6QbEzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151081; c=relaxed/simple;
	bh=0xCNWCz7YLg1GqxfHrrvoPZkYFFTrobY0Zep6qf3LXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5lRkK8t8Is0d4tflL50hbj/9GRXYt3NsiGUZ83/MlesCfKZE8wdJD2G8d7DfnUiHAw7Pcq+I/JV2ONEb8kl7q4sSsdHG6jYFXGIHCJWaRj4G1NJRlRlGpNuoVpB6xGpRsNHE4kIG7VbKeAqdQkHipQ+PPfkwDNL4fgTm+b8gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=c1OLPR17; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Gz6AcXAZa2rLVWcMxOUDJFVEMIYUf2TndHTnTlXHpBg=; b=c1OLPR17uWHgyPCFn/4/eFDrez
	HgjqoIxY8tij97eQlaw8d1ycy3/wruoiFHmhWDMV2JaNqRI+UzKesQ975mzUbR7MR+dwhrVTTIKsj
	je35AeF0KQqZJhuhojF6UQFk1SqTJEUkLLIae+S5RGdG8wzjA9NQi3y74bSPs2T+PZXC1YtJTBWRt
	aBkIYbR0KjIIrJnIvVjeDBBe8BJ1V4efEdF1OSYPgKudpwzsUfl/A+5COI3NlNFEsRY6AGjByLMAe
	Fw5YnKF+o1APq2RBJ0qx0QGA70WAiwc7GJC8j2cXewDc1w6NVmb1LIgO2bckpyWoUzi+9L6/jeqaN
	gNB7U9Zw==;
Received: from [58.29.143.236] (helo=[192.168.1.6])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tI7lA-00FMrH-A5; Mon, 02 Dec 2024 15:50:48 +0100
Message-ID: <55d10cfc-fed7-489f-94e8-50a7568f5341@igalia.com>
Date: Mon, 2 Dec 2024 23:50:40 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] sched_ext: Manage the validity of scx_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, void@manifault.com, mingo@redhat.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20241202043849.1465664-1-changwoo@igalia.com>
 <20241202043849.1465664-3-changwoo@igalia.com>
 <20241202095847.GK24400@noisy.programming.kicks-ass.net>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <20241202095847.GK24400@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Peter,

On 24. 12. 2. 18:58, Peter Zijlstra wrote:
> On Mon, Dec 02, 2024 at 01:38:46PM +0900, Changwoo Min wrote:
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 95e40895a519..ab8015c8cab4 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -789,6 +789,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>>   void update_rq_clock(struct rq *rq)
>>   {
>>   	s64 delta;
>> +	u64 clock;
>>   
>>   	lockdep_assert_rq_held(rq);
>>   
>> @@ -800,11 +801,14 @@ void update_rq_clock(struct rq *rq)
>>   		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
>>   	rq->clock_update_flags |= RQCF_UPDATED;
>>   #endif
>> +	clock = sched_clock_cpu(cpu_of(rq));
>> +	scx_rq_clock_update(rq, clock);
> 
> This adds a write to a second cacheline for *everyone* always.
> 
> Please don't do that.
> 

Thank you for the suggestion! I will update the flags only when
the scx is enabled by checking it inside the
scx_rq_clock_update() and scx_rq_clock_stale() functions.

Regards,
Changwoo Min

