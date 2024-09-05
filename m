Return-Path: <linux-kernel+bounces-317454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627196DE92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25706B233F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DA219DF61;
	Thu,  5 Sep 2024 15:41:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE42110E9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550897; cv=none; b=q25lItUoydEIejj/gkHHu5Yvn1zHBoezSmziTGW1zyYTNwNTC0auWGpeNyxYcOgKOR+yjs1Wen/hiJ3YDXdqgLTZqPdtIUjMmkv1D2+1DsZI7BHIGLIFk8E7mp+Q3rcL9Der5qilRmIMT8xB7MA/RNGYbxGID0RoXgN0XIugAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550897; c=relaxed/simple;
	bh=P8bMYvM6fVItm4QudOKWfWW3EfgN6MewtAcVJuNHuCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUewDs2QoNa9jZmVwLadZl50dZTuGevzDbUj42uVkrA+0SVWEg9qxKCN3QuJ37p6xcDsazgT0qZrbz9eSZ5i2xZ6vtq4n5XUkL5iOKLK/B33svgQzUQA4aU11FZ2asD+WQzaCnsNALaSILXhe6JLQcLsw0RHqMznWfq9Xi61KRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98A71FEC;
	Thu,  5 Sep 2024 08:42:01 -0700 (PDT)
Received: from [10.1.29.28] (e122027.cambridge.arm.com [10.1.29.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0B7D3F73B;
	Thu,  5 Sep 2024 08:41:32 -0700 (PDT)
Message-ID: <d24272d4-e21a-4f62-8797-ce29dd6d2147@arm.com>
Date: Thu, 5 Sep 2024 16:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME
 group priority
To: Mihail Atanassov <mihail.atanassov@arm.com>,
 Mary Guillemard <mary.guillemard@collabora.com>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 nd <nd@arm.com>
References: <20240905111338.95714-1-mary.guillemard@collabora.com>
 <20240905111338.95714-2-mary.guillemard@collabora.com>
 <2b2d13a9-9e84-406a-a803-5366036fa761@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <2b2d13a9-9e84-406a-a803-5366036fa761@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mihail,

On 05/09/2024 14:54, Mihail Atanassov wrote:
> Hi Mary,
> 
> On 05/09/2024 12:13, Mary Guillemard wrote:
>> This adds a new value to drm_panthor_group_priority exposing the
>> realtime priority to userspace.
>>
>> This is required to implement NV_context_priority_realtime in Mesa.
>>
>> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
>> ---
>>   drivers/gpu/drm/panthor/panthor_drv.c   | 2 +-
>>   drivers/gpu/drm/panthor/panthor_sched.c | 2 --
>>   include/uapi/drm/panthor_drm.h          | 7 +++++++
>>   3 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c
>> b/drivers/gpu/drm/panthor/panthor_drv.c
>> index 0caf9e9a8c45..7b1db2adcb4c 100644
>> --- a/drivers/gpu/drm/panthor/panthor_drv.c
>> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
>> @@ -1041,7 +1041,7 @@ static int group_priority_permit(struct drm_file
>> *file,
>>                    u8 priority)
>>   {
>>       /* Ensure that priority is valid */
>> -    if (priority > PANTHOR_GROUP_PRIORITY_HIGH)
>> +    if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
>>           return -EINVAL;
>>         /* Medium priority and below are always allowed */
>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c
>> b/drivers/gpu/drm/panthor/panthor_sched.c
>> index 91a31b70c037..86908ada7335 100644
>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>> @@ -137,8 +137,6 @@ enum panthor_csg_priority {
>>        * non-real-time groups. When such a group becomes executable,
>>        * it will evict the group with the lowest non-rt priority if
>>        * there's no free group slot available.
>> -     *
>> -     * Currently not exposed to userspace.
>>        */
>>       PANTHOR_CSG_PRIORITY_RT,
>>   diff --git a/include/uapi/drm/panthor_drm.h
>> b/include/uapi/drm/panthor_drm.h
>> index 1fd8473548ac..011a555e4674 100644
>> --- a/include/uapi/drm/panthor_drm.h
>> +++ b/include/uapi/drm/panthor_drm.h
>> @@ -720,6 +720,13 @@ enum drm_panthor_group_priority {
>>        * Requires CAP_SYS_NICE or DRM_MASTER.
>>        */
>>       PANTHOR_GROUP_PRIORITY_HIGH,
>> +
>> +    /**
>> +     * @PANTHOR_GROUP_PRIORITY_REALTIME: Realtime priority group.
>> +     *
>> +     * Requires CAP_SYS_NICE or DRM_MASTER.
>> +     */
>> +    PANTHOR_GROUP_PRIORITY_REALTIME,
> 
> This is a uapi change, but doesn't have a corresponding driver version
> bump in the same patch. You also document the addition of this enum
> value in the next patch, which also is a tad wonky. If you reversed the
> order of the patches, they'd make more sense IMO.

You can't reverse the order because then the version bump would be
before all the features were present. Generally we put the version bump
at the end of a patch series because it's indicating to user space that
the new features can be used. This way round if a bisect lands in the
middle of the series then the new priority is there but won't be used
because user space won't know about it (which is fine).

Steve

>>   };
>>     /**
> 


