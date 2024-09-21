Return-Path: <linux-kernel+bounces-334889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CCF97DDEE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED7CB21483
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1912B175D4C;
	Sat, 21 Sep 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmvQkQz7"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C661514C9
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726937144; cv=none; b=ELrqh0qhRnRz/17oJI3zu45JT8RXdL3LDKcSpEGf8x7PYMPt5c2tEIomOnLjKIAeAV+T+maPoJvDC4fdMFRpNZ6c1W0ci6e1urHL/QuKi3FT9jKS6+M2hiFcu0rxrLBAjqg2p+EA004A3h+K6SdprA6C6sosy8d4qMO5YLuba58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726937144; c=relaxed/simple;
	bh=oLLDjpM/8aA+Mikd7HVUUzW/DmPjCx2KJeRPL/RYebY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/wvAEngjHxDFPIdfDTUEKeKigMYX4NlOqIoD7dEMmO6vqOjJApcVsEcThM/7j1JgyA/3+VLHuouvMutLlHM+dL3mvHL5knziPLNLPtArQXTB6SVUhvoKG3cQky6HSXQ1UNudFyTF+ekTiAz0h/A1hVS0PdneLeNUoP6S4oSjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmvQkQz7; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37a413085cbso1298149f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726937140; x=1727541940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11BcDD5IihY8sHkWDN4bZKYEHZDz5Md3HLgNTNoCcv8=;
        b=vmvQkQz72MPVdBlwdv0SyO9V/nPM1S1tBQno0dRhQTjyZbQtxgcAnfc51R504mNeZ+
         SA+6j93+f+NDiN/ULZ9pu1L0DYjcu+orgrhXblt1o06fVheGPcA9cIVbPIIWEuH5AP4P
         6QvAZ1Lh7PlazRrPj2JZq3zggolcRRP3Fqqn32JwBPjuVH+HLD2f78BcoDHhgeJ1ol2x
         MFspv+4evj/6R+bpMDasETJw3LDqurevE0kQ3/9U8LSaaKeIW9s4K0/JkEQfungcO0EL
         43wL70CEjUOGEvxAa8oSUQj1OrKySrN/X81CT4plEk7SVKfLF8mpiVLReX5pU6Vc6Qw9
         elaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726937140; x=1727541940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11BcDD5IihY8sHkWDN4bZKYEHZDz5Md3HLgNTNoCcv8=;
        b=O5/8rNkxg2RyBEFwG1d7aGFi/xrJ5/rH6CHwQKCmvTVGn7GVCVpcmKSM9/A6Az2TYL
         1yetZsC+DLgLUFH5r97jWs7uWRoktPLCbAbllX7AVrteMCgsiTCP7S7Hr5XGljwJhL97
         4pQhkBMqixFO1vXaxoLd3qe+0GakOXI3dfEAICac5i8xfJUZRisVk+eqgudYlICZlZ8e
         df1dEUBuGlL07fqQALP97UVZHHvVOHm/3GvQSoF2CigqjNugW3lHPakTr92rHrVjlelV
         msDATSoWJN7l4f27c2XDgSQLdfgYgHJyQKQzKudg0CBnl1I42qerb0j1wFgsOGyG9PwF
         S7qw==
X-Forwarded-Encrypted: i=1; AJvYcCWeaXbKUytbU/K4PP02ijUm/XdGhjWUyNEqv175X1Vt4qaEyoDNJHSvr0Ww77xgOyI6fx+73Yo6tEz2WMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eDLHz2tU8E+cpK+9RXaLikLfXHpraBVx++WRPUOXQLFONXtZ
	CS3OEB9XCOXvBgjUi6EHiBZ5bRMPFiIsbK1aP7wrDeLLwzqZJ3d3Kosgw3XN+Uk=
X-Google-Smtp-Source: AGHT+IGJxFMVH30eOyDamIi8EJSOxXEIYis2TfZ8Ked9m32LuYuazdpkQsz44vOA8nV3YSdj2nd1Vw==
X-Received: by 2002:adf:f6cd:0:b0:374:d2a3:d213 with SMTP id ffacd0b85a97d-37a414f4b94mr3768151f8f.18.1726937140340;
        Sat, 21 Sep 2024 09:45:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7001:d575:d71f:f3b? ([2a01:e0a:982:cbb0:7001:d575:d71f:f3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37a47b58bfdsm3004926f8f.14.2024.09.21.09.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 09:45:39 -0700 (PDT)
Message-ID: <11cdd74f-683c-458e-bb18-8a0d8f8904e8@linaro.org>
Date: Sat, 21 Sep 2024 18:45:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] Preemption support for A7XX
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Antonino Maniscalco <antomani103@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>
References: <20240917-preemption-a750-t-v4-0-95d48012e0ac@gmail.com>
 <c70392bb-bda1-48c7-824e-23d6f92f54ef@linaro.org>
 <20240920170949.vp3642gghhey3pjb@hu-akhilpo-hyd.qualcomm.com>
Content-Language: en-GB
From: Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20240920170949.vp3642gghhey3pjb@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/09/2024 à 19:09, Akhil P Oommen a écrit :
> On Wed, Sep 18, 2024 at 09:46:33AM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 17/09/2024 13:14, Antonino Maniscalco wrote:
>>> This series implements preemption for A7XX targets, which allows the GPU to
>>> switch to an higher priority ring when work is pushed to it, reducing latency
>>> for high priority submissions.
>>>
>>> This series enables L1 preemption with skip_save_restore which requires
>>> the following userspace patches to function:
>>>
>>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30544
>>>
>>> A flag is added to `msm_submitqueue_create` to only allow submissions
>>> from compatible userspace to be preempted, therefore maintaining
>>> compatibility.
>>>
>>> Preemption is currently only enabled by default on A750, it can be
>>> enabled on other targets through the `enable_preemption` module
>>> parameter. This is because more testing is required on other targets.
>>>
>>> For testing on other HW it is sufficient to set that parameter to a
>>> value of 1, then using the branch of mesa linked above, `TU_DEBUG=hiprio`
>>> allows to run any application as high priority therefore preempting
>>> submissions from other applications.
>>>
>>> The `msm_gpu_preemption_trigger` and `msm_gpu_preemption_irq` traces
>>> added in this series can be used to observe preemption's behavior as
>>> well as measuring preemption latency.
>>>
>>> Some commits from this series are based on a previous series to enable
>>> preemption on A6XX targets:
>>>
>>> https://lkml.kernel.org/1520489185-21828-1-git-send-email-smasetty@codeaurora.org
>>>
>>> Signed-off-by: Antonino Maniscalco <antomani103@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Added missing register in pwrup list
>>> - Removed and rearrange barriers
>>> - Renamed `skip_inline_wptr` to `restore_wptr`
>>> - Track ctx seqno per ring
>>> - Removed secure preempt context
>>> - NOP out postamble to disable it instantly
>>> - Only emit pwrup reglist once
>>> - Document bv_rptr_addr
>>> - Removed unused A6XX_PREEMPT_USER_RECORD_SIZE
>>> - Set name on preempt record buffer
>>> - Link to v3: https://lore.kernel.org/r/20240905-preemption-a750-t-v3-0-fd947699f7bc@gmail.com
>>>
>>> Changes in v3:
>>> - Added documentation about preemption
>>> - Use quirks to determine which target supports preemption
>>> - Add a module parameter to force disabling or enabling preemption
>>> - Clear postamble when profiling
>>> - Define A6XX_CP_CONTEXT_SWITCH_CNTL_LEVEL fields in a6xx.xml
>>> - Make preemption records MAP_PRIV
>>> - Removed user ctx record (NON_PRIV) and patch 2/9 as it's not needed
>>>     anymore
>>> - Link to v2: https://lore.kernel.org/r/20240830-preemption-a750-t-v2-0-86aeead2cd80@gmail.com
>>>
>>> Changes in v2:
>>> - Added preept_record_size for X185 in PATCH 3/7
>>> - Added patches to reset perf counters
>>> - Dropped unused defines
>>> - Dropped unused variable (fixes warning)
>>> - Only enable preemption on a750
>>> - Reject MSM_SUBMITQUEUE_ALLOW_PREEMPT for unsupported targets
>>> - Added Akhil's Reviewed-By tags to patches 1/9,2/9,3/9
>>> - Added Neil's Tested-By tags
>>> - Added explanation for UAPI changes in commit message
>>> - Link to v1: https://lore.kernel.org/r/20240815-preemption-a750-t-v1-0-7bda26c34037@gmail.com
>>>
>>> ---
>>> Antonino Maniscalco (11):
>>>         drm/msm: Fix bv_fence being used as bv_rptr
>>>         drm/msm/A6XX: Track current_ctx_seqno per ring
>>>         drm/msm: Add a `preempt_record_size` field
>>>         drm/msm: Add CONTEXT_SWITCH_CNTL bitfields
>>>         drm/msm/A6xx: Implement preemption for A7XX targets
>>>         drm/msm/A6xx: Sync relevant adreno_pm4.xml changes
>>>         drm/msm/A6xx: Use posamble to reset counters on preemption
>>>         drm/msm/A6xx: Add traces for preemption
>>>         drm/msm/A6XX: Add a flag to allow preemption to submitqueue_create
>>>         drm/msm/A6xx: Enable preemption for A750
>>>         Documentation: document adreno preemption
>>>
>>>    Documentation/gpu/msm-preemption.rst               |  98 +++++
>>>    drivers/gpu/drm/msm/Makefile                       |   1 +
>>>    drivers/gpu/drm/msm/adreno/a2xx_gpu.c              |   2 +-
>>>    drivers/gpu/drm/msm/adreno/a3xx_gpu.c              |   2 +-
>>>    drivers/gpu/drm/msm/adreno/a4xx_gpu.c              |   2 +-
>>>    drivers/gpu/drm/msm/adreno/a5xx_gpu.c              |   6 +-
>>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   7 +-
>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 325 ++++++++++++++-
>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.h              | 174 ++++++++
>>>    drivers/gpu/drm/msm/adreno/a6xx_preempt.c          | 440 +++++++++++++++++++++
>>>    drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   9 +-
>>>    drivers/gpu/drm/msm/msm_drv.c                      |   4 +
>>>    drivers/gpu/drm/msm/msm_gpu.c                      |   2 +-
>>>    drivers/gpu/drm/msm/msm_gpu.h                      |  11 -
>>>    drivers/gpu/drm/msm/msm_gpu_trace.h                |  28 ++
>>>    drivers/gpu/drm/msm/msm_ringbuffer.h               |  18 +
>>>    drivers/gpu/drm/msm/msm_submitqueue.c              |   3 +
>>>    drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   7 +-
>>>    .../gpu/drm/msm/registers/adreno/adreno_pm4.xml    |  39 +-
>>>    include/uapi/drm/msm_drm.h                         |   5 +-
>>>    20 files changed, 1117 insertions(+), 66 deletions(-)
>>> ---
>>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
>>> change-id: 20240815-preemption-a750-t-fcee9a844b39
>>>
>>> Best regards,
>>
>> I've been running vulkan-cts (1.3.7.3-0-gd71a36db16d98313c431829432a136dbda692a08 from Yocto)
>> on SM8650-QRD, SM8550-QRD & SM8450-HDK boards with enable_preemption in default value
>> and forced to 1, and I've seen no regression so far
>>
>> On SM8550, I've seen a few:
>> platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Message HFI_H2F_MSG_GX_BW_PERF_VOTE id 2743 timed out waiting for response
>> platform 3d6a000.gmu: [drm:a6xx_hfi_send_msg.constprop.0 [msm]] *ERROR* Unexpected message id 2743 on the response queue
>> but it's unrelated to preempt
>>
>> and on SM8450:
>> platform 3d6a000.gmu: [drm:a6xx_gmu_set_oob [msm]] *ERROR* Timeout waiting for GMU OOB set GPU_SET: 0x0
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 7.3.0.1: hangcheck detected gpu lockup rb 0!
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 7.3.0.1:     completed fence: 331235
>> msm_dpu ae01000.display-controller: [drm:hangcheck_handler [msm]] *ERROR* 7.3.0.1:     submitted fence: 331236
>> adreno 3d00000.gpu: [drm:a6xx_irq [msm]] *ERROR* gpu fault ring 0 fence 50de4 status 00800005 rb 0000/0699 ib1 0000000000000000/0000 ib2 0000000000000000/0000
>> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 7.3.0.1: hangcheck recover!
>> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 7.3.0.1: offending task: deqp-vk (/usr/lib/vulkan-cts/deqp-vk)
>> msm_dpu ae01000.display-controller: [drm:recover_worker [msm]] *ERROR* 7.3.0.1: hangcheck recover!
>> leading to a VK_ERROR_DEVICE_LOST, but again unrelated to preempt support.
>>
>> So you can also add:
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
>> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8450-HDK
>>
> 
> Niel,
> 
> On my x1e device, all submissions were somehow going into only a single
> ring, even the compositor's. Not sure why. So effectively preemption was
> not really exercised. I had to force one of the two benchmark I ran
> using the "highprio" mesa debug flag force submittions to ring 0.
> 
> If possible it is a good idea to check the new preemption traces to
> ensure preemption kicks in.

Sure I'll run the test again on a750 and check if preemption kicks in.

Neil

> 
> -Akhil
> 
>> Thanks,
>> Neil


