Return-Path: <linux-kernel+bounces-555178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96702A5A67D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53601735D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC71E3790;
	Mon, 10 Mar 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BNt2026T"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC436B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643642; cv=none; b=pEzsz0IlT7vy5UcI+OH0RX4rgw0+1la61lSJ8xNhcG3TYAymKHmzmNCkTqWaX+uQr5WIMsC5Gnb5MbHKL5ZjZoEqrNcybf5eFjR5f52lA1gY6jcf/1S/C5rTOEsCrzPWBkZ5ZLml97P4leYZqnQ38R3o2mz0RNAnIZw1H+h4+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643642; c=relaxed/simple;
	bh=zEdWlGhf8988WbU+W2aCQUVE/hhuYc8Oh1engXSNdhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4vJBMSMu7BnjSsrtO4F9Iq925jvHRdqz+0Fin6FylijDd/AN7+ELPuhlc/If6XLyjoMg3YbP8rVXPnf2mNyaL2/2kv68xr98PI46Xi4UN0J8hVtCBWAlz/C/mP/3hjGa2HmjALSC2e9Yp/gjd18sGXveToaHXvl3avzzIbRBhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BNt2026T; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AJil93IzUDgCjnkwb1ftr6Wb6/uv7Kl9IDbIsPwiTyU=; b=BNt2026TUEPDGLMNJ0ytDE063W
	jUcm3LkUModbev+EpoXWlRy6WQA6CCzT80zjXe01ImWJMO49AaOoGNdjlH1JxbRGo4fBFzV6enNkP
	Wvd+wQbK0lllmR4M4D9mnyP1kN9HMVokIQ3w9ItKnfagr+e5ZbDWWmSMIR7S0nF2iF59mmPEroyzT
	IqKgkwtYgBwGV9l1poACmlYFDh1RaMFLJLe+FLbjgt1ZJ2unZ4kQqF4jqpjspYLzFDyBT84RlTSNT
	d9QL16BB2w2QWhSVJ9486VCBaQ9p4CHaUmB699JECD2CPV9/ARHHvkDtjYwh6rbDp+LPziVKQexoI
	iXBcdkxQ==;
Received: from [191.204.194.148] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1trl4F-006fjl-HO; Mon, 10 Mar 2025 22:53:53 +0100
Message-ID: <73602c9b-74f6-4b4a-82c6-918292b13cf7@igalia.com>
Date: Mon, 10 Mar 2025 18:53:48 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
To: Raag Jadav <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
 rodrigo.vivi@intel.com, jani.nikula@linux.intel.com,
 Xaver Hugl <xaver.hugl@kde.org>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-3-andrealmeid@igalia.com>
 <Z8HO-s_otb2u44V7@black.fi.intel.com>
 <38b9cc8b-2a55-4815-a19f-f5bdf0f7687c@igalia.com>
 <Z8KjZfLYjH6ehYwy@black.fi.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <Z8KjZfLYjH6ehYwy@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 01/03/2025 03:04, Raag Jadav escreveu:
> On Fri, Feb 28, 2025 at 06:49:43PM -0300, André Almeida wrote:
>> Hi Raag,
>>
>> On 2/28/25 11:58, Raag Jadav wrote:
>>> On Fri, Feb 28, 2025 at 09:13:53AM -0300, André Almeida wrote:
>>>> To notify userspace about which app (if any) made the device get in a
>>>> wedge state, make use of drm_wedge_app_info parameter, filling it with
>>>> the app PID and name.
>>>>
>>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++--
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
>>>>    2 files changed, 22 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 00b9b87dafd8..e06adf6f34fd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>>    	atomic_set(&adev->reset_domain->reset_res, r);
>>>> -	if (!r)
>>>> -		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>>>> +	if (!r) {
>>>> +		struct drm_wedge_app_info aux, *info = NULL;
>>>> +
>>>> +		if (job) {
>>>> +			struct amdgpu_task_info *ti;
>>>> +
>>>> +			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
>>>> +			if (ti) {
>>>> +				aux.pid = ti->pid;
>>>> +				aux.comm = ti->process_name;
>>>> +				info = &aux;
>>>> +				amdgpu_vm_put_task_info(ti);
>>>> +			}
>>>> +		}
>>> Is this guaranteed to be guilty app and not some scheduled worker?
>>
>> This is how amdgpu decides which app is the guilty one earlier in the code
>> as in the print:
>>
>>      ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>>
>>      "Process information: process %s pid %d thread %s pid %d\n"
>>
>> So I think it's consistent with what the driver thinks it's the guilty
>> process.
> 
> Sure, but with something like app_info we're kind of hinting to userspace
> that an application was _indeed_ involved with reset. Is that also guaranteed?
> 
> Is it possible that an application needlessly suffers from a false positive
> scenario (reset due to other factors)?
> 

I asked Alex Deucher in IRC about that and yes, there's a chance that 
this is a false positive. However, for the majority of cases this is the 
right app that caused the hang. This is what amdgpu is doing for GL 
robustness as well and devcoredump, so it's very consistent with how 
amdgpu deals with this scenario even if the mechanism is still not perfect.

