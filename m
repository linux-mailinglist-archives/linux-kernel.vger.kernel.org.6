Return-Path: <linux-kernel+bounces-558512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32FA5E6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FE189D700
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D97E1EFFBA;
	Wed, 12 Mar 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="itoovOte"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36841F3B91
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741816794; cv=none; b=naZMb0D3QDOdiOMlYV5ILml3QbTpT0YTk3VgwYeLh7TTcSdDvvLsIQZ+fnWC5SJG8Jh9K54MYLoM876aqzEwuVdRI7VguaJd2bOeQM9hrO60F5Ya7Fv86zrsqJ8xWSQet6nKb/1nI2IFolLed8V5VNCbm5tKJdK59oHxDd1uzg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741816794; c=relaxed/simple;
	bh=Re51Zub5DYgDWHe3GpQbk6np5q8h+H3qz0VifwAi/nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpNqrYk1Y3/i4a1vKzcIVxGdBgIQFTFhKQYaCLcMjTomZSUQTO65ZhZJ0DR494fNJ9sS3gZXlesAD4dlsFSTX53vzKBEazowWJSVkgLbaY5XrwJkx2essuoLRTFASGxkpfiPhQYjW6kZ3vxbpC7fw3mm+UA8CoQugwfFVw2dX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=itoovOte; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A4+dae+3XRFxt7BM6x0GYCiu6QUc2mn4pIrP/UI5HVM=; b=itoovOtej8S0qr3N3mADZ9xGap
	KbZrqsyHO0qQUGDS3jPjMyxlFSfnmgXAsBLMMaS9nvIVfRTYba3Y/7SV0plu0sp1hemmFQGoLdi5t
	hsSbeU9f2xMaF7VSEupjRjdHwyCxTL0kpTXl3kUrfJMRl6nDmKVJTCgtQdv/X4vjOfbSd8zROvHYw
	81dCvdv0iIMSuy9i1R8GfiZggj+4wZ8E3LfAbJ1P7mMh51hixTm0fNGp2Kx3BZtROP8lcC9YgqbqW
	lOWlgdtMmILD2KSFTdvFBYT+TAyeTH9IeoQsjWO+naUTO86kUiZVkOEgirRUY0iNQ1Xr6qGZLnHB/
	OxhgTgYw==;
Received: from [179.98.221.3] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tsU6v-007o7i-7Q; Wed, 12 Mar 2025 22:59:39 +0100
Message-ID: <ef926ea5-ac0e-4f95-b260-84c4102c93ad@igalia.com>
Date: Wed, 12 Mar 2025 18:59:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm: Create an app info option for wedge events
To: Raag Jadav <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
 rodrigo.vivi@intel.com, jani.nikula@linux.intel.com,
 lucas.demarchi@intel.com, Xaver Hugl <xaver.hugl@kde.org>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-2-andrealmeid@igalia.com>
 <Z8HGFRGOYvyCCWWu@black.fi.intel.com>
 <58763d8e-46a1-4753-9401-987fb3dac50b@igalia.com>
 <Z8KgwswQQyGxhsR1@black.fi.intel.com>
 <db27ee44-f480-475b-be7e-710bd30eb7a5@igalia.com>
 <Z9BuU3RzMkEE_FL1@black.fi.intel.com> <Z9FcmDzSmBbVAsqD@black.fi.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <Z9FcmDzSmBbVAsqD@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 12/03/2025 07:06, Raag Jadav escreveu:
> On Tue, Mar 11, 2025 at 07:09:45PM +0200, Raag Jadav wrote:
>> On Mon, Mar 10, 2025 at 06:27:53PM -0300, André Almeida wrote:
>>> Em 01/03/2025 02:53, Raag Jadav escreveu:
>>>> On Fri, Feb 28, 2025 at 06:54:12PM -0300, André Almeida wrote:
>>>>> Hi Raag,
>>>>>
>>>>> On 2/28/25 11:20, Raag Jadav wrote:
>>>>>> Cc: Lucas
>>>>>>
>>>>>> On Fri, Feb 28, 2025 at 09:13:52AM -0300, André Almeida wrote:
>>>>>>> When a device get wedged, it might be caused by a guilty application.
>>>>>>> For userspace, knowing which app was the cause can be useful for some
>>>>>>> situations, like for implementing a policy, logs or for giving a chance
>>>>>>> for the compositor to let the user know what app caused the problem.
>>>>>>> This is an optional argument, when `PID=-1` there's no information about
>>>>>>> the app caused the problem, or if any app was involved during the hang.
>>>>>>>
>>>>>>> Sometimes just the PID isn't enough giving that the app might be already
>>>>>>> dead by the time userspace will try to check what was this PID's name,
>>>>>>> so to make the life easier also notify what's the app's name in the user
>>>>>>> event.
>>>>>>>
>>>>>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>>
>>> [...]
>>>
>>>>>>>     	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
>>>>>>> @@ -562,6 +564,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
>>>>>>>     	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
>>>>>>>     		 "but recovered through reset" : "needs recovery");
>>>>>>> +	if (info) {
>>>>>>> +		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
>>>>>>> +		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
>>>>>>> +	} else {
>>>>>>> +		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
>>>>>>> +		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
>>>>>>> +	}
>>>>>> This is not much use for wedge cases that needs recovery, since at that point
>>>>>> the userspace will need to clean house anyway.
>>>>>>
>>>>>> Which leaves us with only 'none' case and perhaps the need for standardization
>>>>>> of "optional telemetry collection".
>>>>>>
>>>>>> Thoughts?
>>>>>
>>>>> I had the feeling that 'none' was already meant to be used for that. Do you
>>>>> think we should move to another naming? Given that we didn't reach the merge
>>>>> window yet we could potentially change that name without much damage.
>>>>
>>>> No, I meant thoughts on possible telemetry data that the drivers might
>>>> think is useful for userspace (along with PID) and can be presented in
>>>> a vendor agnostic manner (just like wedged event).
>>>
>>> I'm not if I agree that this will only be used for telemetry and for the
>>> `none` use case. As stated by Xaver, there's use case to know which app
>>> caused the device to get wedged (like switching to software rendering) and
>>> to display something for the user after the recovery is done (e.g. "The game
>>> <app name> stopped working and Plasma has reset").
>>
>> Sure, but since this information is already available in coredump, I was
>> hoping to have something like a standardized DRM level coredump with both
>> vendor specific and agnostic sections, which the drivers can (and hopefully
>> transition to) use in conjunction with wedged event to provide wider
>> telemetry and is useful for all wedge cases.
> 
> This is more useful because,
> 
> 1. It gives drivers an opportunity to present the telemetry that they are
>     interested in without needing to add a new event string (like PID or APP)
>     for their case.
> 
> 2. When we consider wedging as a usecase, there's a lot more that goes
>     into it than an application that might be behaving strangely. So a wider
>     telemetry is what I would hope to look at in such a scenario.
> 

I agree that coredump is the way to go for telemetry, we already have 
the name and PID of the guilty app there, along with more information 
about the GPU state. But I don't think it should be consumed like an 
uAPI. Even if we wire up some common DRM code for that, I don't think we 
can guarantee the stability of it as we can do for an uevent. coredump 
can be disabled and by default is only accessible by root.

So I think that coredump is really good after the fact and if the user 
is willing to go ahead and report a bug somewhere. But for the goal of 
notifying the compositor, the same uevent that the compositor is already 
listening to will have everything they need to deal with this reset.

