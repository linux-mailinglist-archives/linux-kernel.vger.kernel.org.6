Return-Path: <linux-kernel+bounces-553841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF79A58FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DB2188FE11
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E3522333B;
	Mon, 10 Mar 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hsE34/rl"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDB1EAC7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599051; cv=none; b=Bd5j6ivC3oSRBahiexhgqDZc/BwueUmI8b+fw8pUR1AUebZFbhwSOaNOUg+ehLsrYO1k+9odOL6+QtsmKPHtJU20WFNNlMY7wHoxkTRYDovikEb1dLJRhd9T7BGjiBW6wr6EP4vMxxlZ2fZ8NZ1aDuc0/pox9nzDeoY3bSFSyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599051; c=relaxed/simple;
	bh=X1IYh4vqAt8RNWleVHEMAr7wuafvnu7ZW2h+GqgoOnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CAdDC0oqFGwKfc1QtZrgUBtqv5tR36dUV8VhMOGe6aiHR1WcQ/47hier5bDKqEAR2WZoM2zfwruyXUFTIOmk+qCEWUwR9dLEDCpYf2xoDidClExw12YBWuKVt1jOGJZT34LSN5c/LBB1l8WhosgNOj8FFxZ3qUZkWYypC6SR31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hsE34/rl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nNE4q856lrPWDsmUBJ+5VDcgzzJsZjy5E0OK8MgEIVY=; b=hsE34/rlRUAKTi/Laulsztr531
	62roU7G8H4G9mW+KlVqpLCSKH7kaxgbpeungtBW9vOMgMFAsm3bAZAFWsixmP4ChHNwSf3DaHSW/5
	7pAf+SIhz9zPscLhSjPn5Y2LpTGOaISDT2b+xcTZKlnxSvunVoS1cfGbcq4jecg73AmwJTodi5aD3
	hz3OwMy95pjdA6PS+kldwPWyOujC5ML8+WhQ9A7mvEbscqeK5zmag/eXQgH0Lmh4XgFgysPrLZ4Qv
	aVLjsenJFooy1ktGkcvU09D2obff2ijh5FCD9mx2Xz08YlCDYKXzU4jQhhw0wuiBqSLXesfWeOh5s
	Q51BIhvw==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1trZSr-006Pph-9r; Mon, 10 Mar 2025 10:30:31 +0100
Message-ID: <37a58172-c2fa-4942-bafa-d96be85cd26f@igalia.com>
Date: Mon, 10 Mar 2025 09:30:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: revert "drm_sched_job_cleanup(): correct false
 doc"
To: phasta@kernel.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250310074414.2129157-1-christian.koenig@amd.com>
 <cb3745c15e5e2c3a2b03e47a56d2e4db555664b5.camel@mailbox.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <cb3745c15e5e2c3a2b03e47a56d2e4db555664b5.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/03/2025 08:41, Philipp Stanner wrote:
> On Mon, 2025-03-10 at 08:44 +0100, Christian König wrote:
>> This reverts commit 44d2f310f008613c1dbe5e234c2cf2be90cbbfab.
>>
>> Sorry for the delayed response, I only stumbled over this now while
>> going
>> over old mails and then re-thinking my reviewed by for this change.
>>
>> The function drm_sched_job_arm() is indeed the point of no return.
> 
> So would you say that the comment in the function's body,
> "drm_sched_job_arm() has been called" actually means / should mean "job
> had been submitted with drm_sched_entity_push_job()"?
> 
>> The
>> background is that it is nearly impossible for the driver to
>> correctly
>> retract the fence and signal it in the order enforced by the
>> dma_fence
>> framework.
>>
>> The code in drm_sched_job_cleanup() is for the purpose to cleanup
>> after
>> the job was armed through drm_sched_job_arm() *and* processed by the
>> scheduler.
>>
>> The correct approach for error handling in this situation is to set
>> the
>> error on the fences and then push to the entity anyway.
> 
> You expect the driver to set an error on scheduled and finished fence?
> I think this would be very likely to explode. AFAICS the scheduler code
> has no awareness for anyone else having touched those fences.
> 
> If at all, if this is really a problem, we should tell the driver that
> it must enforce that there will be no failure between
> drm_sched_job_arm() and drm_sched_job_entity_push_job(). That's how
> Nouveau does it.

On top of Philipp's questions - I just want to raise that 
amdgpu_cs_submit then also needs explaining. I always take amdgpu as 
kind of almost reference, since that is where scheduler originated from. 
And in there there is definitely the path of drm_sched_job_cleanup() 
called after drm_sched_job_arm() when adding gang dependencies fails.

Regards,

Tvrtko

> 
> Let's set our understanding straight before reverting. What
> drm_sched_job_arm() does is:
> 
>     1. Pick scheduler, rq and priority for the job
>     2. Atomically increment the job_id_count and assign to job
>     3. Call drm_sched_fence_init() and therefore:
>     4. Set the fence's scheduler
>     5. Set the fences seq nr atomically
>     6. Initialize scheduled and finished fence
> 
> What of the above precisely is the problem?
> 
> You say the driver cannot "correctly retract the fence and signal it in
> the order enforced by the dma_fence framework". You mean that the
> finished_fences have to be signalled in an order only the scheduler
> knows? I assume you're referring to set dependencies?
> 
> P.
> 
>> We can certainly
>> improve the documentation, but removing the warning is clearly not a
>> good
>> idea.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index 53e6aec37b46..4d4219fbe49d 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -1015,13 +1015,11 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
>>    * Cleans up the resources allocated with drm_sched_job_init().
>>    *
>>    * Drivers should call this from their error unwind code if @job is
>> aborted
>> - * before it was submitted to an entity with
>> drm_sched_entity_push_job().
>> + * before drm_sched_job_arm() is called.
>>    *
>> - * Since calling drm_sched_job_arm() causes the job's fences to be
>> initialized,
>> - * it is up to the driver to ensure that fences that were exposed to
>> external
>> - * parties get signaled. drm_sched_job_cleanup() does not ensure
>> this.
>> - *
>> - * This function must also be called in &struct
>> drm_sched_backend_ops.free_job
>> + * After that point of no return @job is committed to be executed by
>> the
>> + * scheduler, and this function should be called from the
>> + * &drm_sched_backend_ops.free_job callback.
>>    */
>>   void drm_sched_job_cleanup(struct drm_sched_job *job)
>>   {
>> @@ -1032,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job
>> *job)
>>    /* drm_sched_job_arm() has been called */
>>    dma_fence_put(&job->s_fence->finished);
>>    } else {
>> - /* aborted job before arming */
>> + /* aborted job before committing to run it */
>>    drm_sched_fence_free(job->s_fence);
>>    }
>>   
> 


