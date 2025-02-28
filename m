Return-Path: <linux-kernel+bounces-539514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30530A4A560
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883813B6BC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8F1DE2A7;
	Fri, 28 Feb 2025 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="H9mIWyL3"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3E1DE2A6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779411; cv=none; b=KgX8bg8vWDfE9L7AVHWpwRs8OuIWrcJPEPwhRYZ+4Cq2PHcZ2p5T2pCeiyjqwCRSphl3po9dJLyI2vKW/iZI7MephN2/hiT3kbIzUC0tHvne9q0CHkMmxyu1wt4y4NXBRyBMPnuj7gIgSxDrIUPc4hWnZhyg46Ut6BJN/UnwYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779411; c=relaxed/simple;
	bh=vPrLb7ByBN5CnRsJVpjPUL4dfZtqSm5TSlqF0/YVaxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gS9NtidYQzPi3IxVNcbtTAtai6kJ6LI6zXZQebcLbaVDb1w2cOMABw3anBcdQBpkU9ty7Kzbvr+tb70R2BcY2pKDILKqaCwA8DvyCrbz/NuvX92CvrNjehX/QGEd0qPykOCVmGJKAA6xPqbZ2e9PES9WQp0ydGKXv66BHmJgFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=H9mIWyL3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oCDXtCW5o4O6IdQSa491PzOZb8jjQJcoikIvha8SEEw=; b=H9mIWyL31odPjG/yzhOB80yR/c
	tUYrQwkvz7Sd6QrKAYFJguI/OzL6+F2j7CPH1D5hx5SNNq+WZYiwoWOwdHQe+NY1CiOVaQXyC6Sm4
	GrqddEJAK9/qUG9zLIWj6iGKbTHhG+16PQ96/x5MaKQFKKkynDbXPjwP8bcoBTxRlLuw8H18D/m4i
	SdSurqIfKz6Zb9DwEuiR8pOg0IPVrIopPR2LrvHcyZSUdaaZ0LCoRuLNgjni9rTLYLHAoVCy0BbN2
	1c/1efvGy1j7Tj06PrferLx7/83hcm8sMCWbuPT4EOcpFa7Ef24qiMFivnrx7bsRfv9KtUzZVzCqT
	EF9HcNaQ==;
Received: from [179.106.178.202] (helo=[192.168.5.235])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1to8Ev-002H2Z-Ju; Fri, 28 Feb 2025 22:49:55 +0100
Message-ID: <38b9cc8b-2a55-4815-a19f-f5bdf0f7687c@igalia.com>
Date: Fri, 28 Feb 2025 18:49:43 -0300
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
 rodrigo.vivi@intel.com, jani.nikula@linux.intel.com
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-3-andrealmeid@igalia.com>
 <Z8HO-s_otb2u44V7@black.fi.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <Z8HO-s_otb2u44V7@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Raag,

On 2/28/25 11:58, Raag Jadav wrote:
> On Fri, Feb 28, 2025 at 09:13:53AM -0300, André Almeida wrote:
>> To notify userspace about which app (if any) made the device get in a
>> wedge state, make use of drm_wedge_app_info parameter, filling it with
>> the app PID and name.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
>>   2 files changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 00b9b87dafd8..e06adf6f34fd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   
>>   	atomic_set(&adev->reset_domain->reset_res, r);
>>   
>> -	if (!r)
>> -		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>> +	if (!r) {
>> +		struct drm_wedge_app_info aux, *info = NULL;
>> +
>> +		if (job) {
>> +			struct amdgpu_task_info *ti;
>> +
>> +			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
>> +			if (ti) {
>> +				aux.pid = ti->pid;
>> +				aux.comm = ti->process_name;
>> +				info = &aux;
>> +				amdgpu_vm_put_task_info(ti);
>> +			}
>> +		}
> Is this guaranteed to be guilty app and not some scheduled worker?

This is how amdgpu decides which app is the guilty one earlier in the 
code as in the print:

     ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);

     "Process information: process %s pid %d thread %s pid %d\n"

So I think it's consistent with what the driver thinks it's the guilty 
process.

> Raag
>

