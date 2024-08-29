Return-Path: <linux-kernel+bounces-307042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267C96472A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8192C1C22D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34E81AED32;
	Thu, 29 Aug 2024 13:48:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62E1AED25
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939307; cv=none; b=fjPWR8oeULdQzrE+nbRaEdYpRHjMdcnAtZj6o+2QbFwy1h2CXgovyIdq3GRC/VThvAleq9tdUx7HNIl/l90bMVd1nfd3X7zPjrNzRTgyLEglg8ZU+Mo2K/JoMjiD7Mr140tSCNszk60IJNJaDd4/dhYKfIAZMRUO2eUemw+n9h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939307; c=relaxed/simple;
	bh=RTjtilmC9BrQ0pDldzaCKZkzvsNEsKc5LbHwe5tnfgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWNxWUJVkXSJLpFuzDlmyLmP9/SjRRFwfV9Ut1z6HMpNmBrrY3zUGb7hNqgNgvQJ6k7Fw/SZnkNB2KAnjXFSsaYkLMHqDPX5ZQYSFJCabYj1UmcipLFbGxUelfD7I0SWZjEsiNto/OZIpvWDBjp8QgLvuicE0Oztz4KRZLznxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48E1FDA7;
	Thu, 29 Aug 2024 06:48:50 -0700 (PDT)
Received: from [10.57.80.208] (unknown [10.57.80.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E343F3F762;
	Thu, 29 Aug 2024 06:48:20 -0700 (PDT)
Message-ID: <c194101d-95fe-428b-b47d-64f473c6c52e@arm.com>
Date: Thu, 29 Aug 2024 15:48:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] drm/panthor: Add user submission
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, Akash Goel <akash.goel@arm.com>
References: <20240828172605.19176-1-mihail.atanassov@arm.com>
 <c64be651-2f40-4535-a537-b8304e6556ce@amd.com>
Content-Language: en-US
From: Ketil Johnsen <ketil.johnsen@arm.com>
In-Reply-To: <c64be651-2f40-4535-a537-b8304e6556ce@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/08/2024 11:40, Christian König wrote:
> Am 28.08.24 um 19:25 schrieb Mihail Atanassov:
>> Hello all,
>>
>> This series implements a mechanism to expose Mali CSF GPUs' queue
>> ringbuffers directly to userspace, along with paraphernalia to allow
>> userspace to control job synchronisation between the CPU and GPU.
>>
>> The goal of these changes is to allow userspace to control work
>> submission to the FW/HW directly without kernel intervention in the
>> common case, thereby reducing context switching overhead. It also allows
>> for greater flexibility in the way work is enqueued in the ringbufs.
>> For example, the current kernel submit path only supports indirect
>> calls, which is inefficient for small command buffers. Userspace can
>> also skip unnecessary sync operations.
> 
> Question is how do you guarantee forward progress for fence signaling?
> 
> E.g. when are fences created and published? How do they signal?

Current XGS queue is built upon an instance of the DRM scheduler, and 
XGS jobs which can not complete immediately are assigned a fence (as one 
would expect). This proposal rely on the DRM scheduler timeout to ensure 
forward progress if user space have encoded a "bad" stream of commands.

PS: We have tried to consider error propagation in case of timeouts, but 
the implementation in this area is most likely somewhat missing ATM (not 
tested).

> How are dependencies handled? How can the kernel suspend an userspace 
> queue?

Mali FW will send IDLE interrupts when a group has become idle. This is 
already (mostly) handled in Panthor today.
There is of course the race to handle then, between GPU IDLE and user 
space submitting new work.

I'm actually working on this part right now. As this patchset stands, it 
doesn't check in the RTPM suspend callback if user space have managed to 
submit more work in the timeframe between "IDLE" and RTPM suspend 
callback. I just need to correctly "unbind" the group/queues, unmap the 
IO pages used, and abort the RTPM suspend if I detect that user space 
have managed to submit more work.

> How does memory management work in this case?

Not sure exactly what you refer to here. There has basically been no 
change to how we handle memory.

If you think of how GPU jobs and VM_BIND interacts, then the change here 
is that it is now the XGS job and VM_BIND which interact. XGS takes on 
the same duties as the GPU jobs with kernel submission (in this regard).

Actually, if you see the submission flow for GPU jobs and XGS jobs, you 
will find that they are virtually identical when it comes to setting up 
fences and dependencies. Same goes for VM_BIND jobs.

--
Regards,
Ketil

> Regards,
> Christian.
> 
>>
>> This is still a work-in-progress, there's an outstanding issue with
>> multiple processes using different submission flows triggering
>> scheduling bugs (e.g. the same group getting scheduled twice), but we'd
>> love to gather some feedback on the suitability of the approach in
>> general and see if there's a clear path to merging something like this
>> eventually.
>>
>> I've also CCd AMD maintainers because they have in the past done
>> something similar[1], in case they want to chime in.
>>
>> There are two uses of this new uAPI in Mesa, one in gallium/panfrost
>> (link TBD), and one in panvk [2].
>>
>> The Gallium implementation is a naïve change just to switch the
>> submission model and exercise the new kernel code, and we don't plan
>> on pursuing this at this time.
>>
>> The panvk driver changes are, however, a better representation of the
>> intent behind this new uAPI, so please consider that as the reference
>> userspace. It is still very much also a work in progress.
>>
>>   * patch 1 adds all the uAPI changes;
>>   * patch 2 implements the GROUP_CREATE ioctl changes necessary to expose
>>     the required objects to userspace;
>>   * patch 3 maps the doorbell pages, similarly to how the user I/O 
>> page is
>>     mapped;
>>   * patch 4 implements GROUP_KICK, which lets userspace request an
>>     inactive group to be scheduled on the GPU;
>>   * patches 5 & 6 implement XGS queues, a way for userspace to
>>     synchronise GPU queue progress with DRM syncobjs;
>>   * patches 7 & 8 add notification mechanisms for user & kernel to signal
>>     changes to native GPU syncobjs.
>>
>> [1] 
>> https://lore.kernel.org/amd-gfx/CADnq5_N61q_o+5WYUZsZ=qu7VmeXTFHQSxLwTco05gLzHaiswA@mail.gmail.com/t/#m116a36a598d8fad1329e053974ad37a4dc0f28ed
>> [2] 
>> https://gitlab.freedesktop.org/larsivsi/mesa/-/commits/panvk-v10-usersubmit?ref_type=heads
>>
>> Ketil Johnsen (7):
>>    drm/panthor: Add uAPI to submit from user space
>>    drm/panthor: Extend GROUP_CREATE for user submission
>>    drm/panthor: Map doorbell pages
>>    drm/panthor: Add GROUP_KICK ioctl
>>    drm/panthor: Factor out syncobj handling
>>    drm/panthor: Implement XGS queues
>>    drm/panthor: Add SYNC_UPDATE ioctl
>>
>> Mihail Atanassov (1):
>>    drm/panthor: Add sync_update eventfd handling
>>
>>   drivers/gpu/drm/panthor/Makefile          |   4 +-
>>   drivers/gpu/drm/panthor/panthor_device.c  |  66 ++-
>>   drivers/gpu/drm/panthor/panthor_device.h  |  35 +-
>>   drivers/gpu/drm/panthor/panthor_drv.c     | 233 +++++++-
>>   drivers/gpu/drm/panthor/panthor_fw.c      |   2 +-
>>   drivers/gpu/drm/panthor/panthor_sched.c   | 408 +++++++++-----
>>   drivers/gpu/drm/panthor/panthor_sched.h   |   8 +-
>>   drivers/gpu/drm/panthor/panthor_syncobj.c | 167 ++++++
>>   drivers/gpu/drm/panthor/panthor_syncobj.h |  27 +
>>   drivers/gpu/drm/panthor/panthor_xgs.c     | 638 ++++++++++++++++++++++
>>   drivers/gpu/drm/panthor/panthor_xgs.h     |  42 ++
>>   include/uapi/drm/panthor_drm.h            | 243 +++++++-
>>   12 files changed, 1696 insertions(+), 177 deletions(-)
>>   create mode 100644 drivers/gpu/drm/panthor/panthor_syncobj.c
>>   create mode 100644 drivers/gpu/drm/panthor/panthor_syncobj.h
>>   create mode 100644 drivers/gpu/drm/panthor/panthor_xgs.c
>>   create mode 100644 drivers/gpu/drm/panthor/panthor_xgs.h
>>
> 


