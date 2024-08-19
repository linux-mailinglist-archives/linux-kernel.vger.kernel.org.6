Return-Path: <linux-kernel+bounces-291630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7F9564F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF9A281FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E11158540;
	Mon, 19 Aug 2024 07:48:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63812158216
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053716; cv=none; b=dHQB32G41fmvyc/+4ZDGuwCT3XPEHRM2tbwiTZ+9rsDAm83VR+i+WSvslsRnI6ZXC/LI44iZvs84aadPzLwp3zuVZR4//gcL8Ecbh+0nhNzQ1dy9379EEQHJxy6FG3P0jjMCaamOx9OtxxDjSRqSp1u58y/On2AvJ9LIQ6C3Gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053716; c=relaxed/simple;
	bh=chrAnjXK1MAEwPjPnR6NWD/IudaGmXI1IW0IFD/LbsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUuDLxUiNsh05qtoaSw+DEC/HOhGh36spw/A4ChPV39zpeog8RA4jdGWY0+rvyb+yxRamz1QCWWSz6YNR0WOjg+1lvBpzQCzEBjD+U1vYv4ogj3hEy64o7TdPaVoM1Ld/h3fKiP7Sbg7mGH8uMssxi9jbA6QGQW8oIMX76bMdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8711063;
	Mon, 19 Aug 2024 00:48:54 -0700 (PDT)
Received: from [10.57.85.21] (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941733F73B;
	Mon, 19 Aug 2024 00:48:26 -0700 (PDT)
Message-ID: <0f089616-2d63-4ac7-a3ba-b6909f9d9ade@arm.com>
Date: Mon, 19 Aug 2024 08:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] drm/panthor: introduce job cycle and timestamp
 accounting
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
 <20240716201302.2939894-2-adrian.larumbe@collabora.com>
 <e46310c7-27b8-4548-93db-56b780873c12@arm.com>
 <5u7pv27ifao57iagnasycxg4oe5hqq42kajbf4xnllxefg7oet@c362omtcizaj>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <5u7pv27ifao57iagnasycxg4oe5hqq42kajbf4xnllxefg7oet@c362omtcizaj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Adrián,

On 31/07/2024 13:41, Adrián Larumbe wrote:
> Hi Steven, thanks for the remarks.
> 
> On 19.07.2024 15:14, Steven Price wrote:
>> On 16/07/2024 21:11, Adrián Larumbe wrote:
>>> Enable calculations of job submission times in clock cycles and wall
>>> time. This is done by expanding the boilerplate command stream when running
>>> a job to include instructions that compute said times right before an after
>>> a user CS.
>>>
>>> Those numbers are stored in the queue's group's sync objects BO, right
>>> after them. Because the queues in a group might have a different number of
>>> slots, one must keep track of the overall slot tally when reckoning the
>>> offset of a queue's time sample structs, one for each slot.
>>>
>>> This commit is done in preparation for enabling DRM fdinfo support in the
>>> Panthor driver, which depends on the numbers calculated herein.
>>>
>>> A profile mode device flag has been added that will in a future commit
>>> allow UM to toggle time sampling behaviour, which is disabled by default to
>>> save power. It also enables marking jobs as being profiled and picks one of
>>> two call instruction arrays to insert into the ring buffer. One of them
>>> includes FW logic to sample the timestamp and cycle counter registers and
>>> write them into the job's syncobj, and the other does not.
>>>
>>> A profiled job's call sequence takes up two ring buffer slots, and this is
>>> reflected when initialising the DRM scheduler for each queue, with a
>>> profiled job contributing twice as many credits.
>>>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>
>> Thanks for the updates, this looks better. A few minor comments below.
>>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_device.h |   2 +
>>>  drivers/gpu/drm/panthor/panthor_sched.c  | 244 ++++++++++++++++++++---
>>>  2 files changed, 216 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
>>> index e388c0472ba7..3ede2f80df73 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_device.h
>>> +++ b/drivers/gpu/drm/panthor/panthor_device.h
>>> @@ -162,6 +162,8 @@ struct panthor_device {
>>>  		 */
>>>  		struct page *dummy_latest_flush;
>>>  	} pm;
>>> +
>>> +	bool profile_mode;
>>>  };
>>>  
>>>  /**
>>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>>> index 79ffcbc41d78..6438e5ea1f2b 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>>> @@ -93,6 +93,9 @@
>>>  #define MIN_CSGS				3
>>>  #define MAX_CSG_PRIO				0xf
>>>  
>>> +#define NUM_INSTRS_PER_SLOT			16
>>> +#define SLOTSIZE				(NUM_INSTRS_PER_SLOT * sizeof(u64))
>>> +
>>>  struct panthor_group;
>>>  
>>>  /**
>>> @@ -466,6 +469,9 @@ struct panthor_queue {
>>>  		 */
>>>  		struct list_head in_flight_jobs;
>>>  	} fence_ctx;
>>> +
>>> +	/** @time_offset: Offset of panthor_job_times structs in group's syncobj bo. */
>>> +	unsigned long time_offset;
>>
>> AFAICT this doesn't need to be stored. We could just pass this value
>> into group_create_queue() as an extra parameter where it's used.
> 
> I think we need to keep this offset value around, because queues within the same group
> could have a variable number of slots, so when fetching the sampled values from the
> syncobjs BO in update_fdinfo_stats, it would have to traverse the entire array of
> preceding queues and figure out their size in slots so as to jump over as many
> struct panthor_job_times after the preceding syncobj array.

Yes I think I was getting myself confused - for some reason I'd thought
the ring buffers in each queue were the same size. It makes sense to
keep this.

<snip>

>>> @@ -3384,9 +3565,12 @@ panthor_job_create(struct panthor_file *pfile,
>>>  		goto err_put_job;
>>>  	}
>>>  
>>> +	job->is_profiled = pfile->ptdev->profile_mode;
>>> +
>>>  	ret = drm_sched_job_init(&job->base,
>>>  				 &job->group->queues[job->queue_idx]->entity,
>>> -				 1, job->group);
>>> +				 job->is_profiled ? NUM_INSTRS_PER_SLOT * 2 :
>>> +				 NUM_INSTRS_PER_SLOT, job->group);
>>
>> Is there a good reason to make the credits the number of instructions,
>> rather than the number of slots? If we were going to count the actual
>> number of non-NOP instructions then there would be some logic (although
>> I'm not convinced that makes much sense), but considering we only allow
>> submission in "slot granules" we might as well use that as the unit of
>> "credit".
> 
> In my initial pre-ML version of the patch series I was passing the number of
> queue slots as the total credit count, but Boris was keener on setting it to
> the total number of instructions instead.
> 
> I agree with you that both are equivalent, one just being an integer multiple
> of the other, so I'm fine with either choice. Maybe Boris can pitch in, in
> case he has a strong opinion about this.

I wouldn't say I have a strong opinion, it just seems a little odd to be
multiplying the value by a constant everywhere. If you'd got some
changes planned where the instructions could vary more dynamically that
would be good to know about.

If Boris is "keener" on this approach then that's fine, we'll leave it
this way.

Steve

