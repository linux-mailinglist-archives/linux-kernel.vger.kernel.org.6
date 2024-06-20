Return-Path: <linux-kernel+bounces-222746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D69106B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708C51C20C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279B1AD491;
	Thu, 20 Jun 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2mEuSe9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866C1AC782
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891370; cv=none; b=DfTjhGDkFb2jTv3VUo/ZQzO5byYXSTKpmE2drfvHdrZiG3YkBkOTihlzxqu6ZYIOMhvh+YvmbFEZi3nSPedpDO96IxAOMkTcRPIhUbPTESH0ZVn/BRLob4SKpS/KsoGUU3dmBG9r6wFVOr1GFoAgon4Mejz8HbinD6pMHIAwLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891370; c=relaxed/simple;
	bh=o32N+eytD2zL0y4gsfGboQLUMFeo8g9DH2cWeaKHgbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+sanvW0YNwwvyl28gj6qLBKkdoeppRCLX9g80F4ZKIaZK4YPRtFHcCwe6IlJ8ojQmG3Bywpp1RwH8f8V7YnKnlMm4Zu/k3j60sbBv54A081ynvPEas6p17mTaSW+bvncg35MNj3uTyX4eFCFJnVSsnsYU/17Pb18z26FNWIJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2mEuSe9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so337081666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718891366; x=1719496166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHokNqWDcZyjkEYXD8HUJkvq4qXFJ0UCeMUkTUv94RQ=;
        b=B2mEuSe9Lf4jSVCQp/PnlC0GjoBWk5Lu0UkYyApEG1cvKF1cw98gMKT2BHGRLesJVT
         WQaUBS/+dlM5Sj3bwFNPK+UozEKuAYUulUJmGdkYBPRthAmfz5kod+3e3XKiE3fsw0HF
         AVdm3Wv9nG5/F0Il14bsYVim4o0E62kUG54+5GupVc0NJ2Q3/Rc31gq5+4OFonsKqsPQ
         r735vbUkZS+1/Fu678VElFaz+ZDDwn55iYxOZkmEPaTGkfOHGBJQQQ/uvwpwu3GxdwdH
         Q6CbwpMO0aXch5rKy6++CsCAe1iwhaWH8noblPXqkTs3XyTF0h4d6oauiLjodYY+NZf3
         Qnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891366; x=1719496166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHokNqWDcZyjkEYXD8HUJkvq4qXFJ0UCeMUkTUv94RQ=;
        b=BhkUIZojeFUhzvdtKzGxPF9blFtOItXLJpVEVKaJGKlD3qakYXcWctThoaI9bJo28H
         TVCJQz17cnCEtUeDpmQCe8pDa5tKQg4T5B5fEmC3S7wt0/wtubJNXLAls/H5RRaqXRsi
         uvjs06Qm0exOi8rrf5P0N1eEMQcQb9IdLqCcIpo6JtNaj+WApiV6/C9ELiy9jFOGMDBS
         pbkukkmk4QNmSwbFhMa0TppJWq5nT+mnr951jS5fEoblhKq6Dyqks03tl8BiCu07EwSr
         6hUizKFOFsG59EQrq7VjN/hCusePki399ym1zs+ut1Gri1Lo6W4omZEIcT5KKZdmbMGL
         hPCw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1A6SpIpOC+rGpw98FpyQWoSSZf2d3lf3I/9aNxjnlLI0M3oyGx+ob03rJ/ORGP1S5lJzBydlZcWTZvRDCMoGKf6NiJG97Evnegrh
X-Gm-Message-State: AOJu0YwlVPNLqUA5Et5AqTZb8jPPRlexqh3WPU8HJz6IkZZSqnEzkXzi
	gbN53LO8qHENM1EE+UCliUhuKKS5+Az3Sq0RBSu4HV/iOlnP3maJm40QQb+Bk4g=
X-Google-Smtp-Source: AGHT+IEdOMuoR76TY+TyOaDptGKznyVC6XlczNzpcVSNxmOWU8x6zKnfPGcpPPOBGZl3Rc/ELq8SAw==
X-Received: by 2002:a17:907:8b98:b0:a6f:b6c3:fb2e with SMTP id a640c23a62f3a-a6fb6c41f0cmr275408166b.0.1718891365565;
        Thu, 20 Jun 2024 06:49:25 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::ebdd? ([2a02:8109:aa0d:be00::ebdd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f788f46c6sm523513766b.23.2024.06.20.06.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 06:49:25 -0700 (PDT)
Message-ID: <c71e1543-6957-4aa6-98fa-160b3bd29c78@linaro.org>
Date: Thu, 20 Jun 2024 15:49:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240618072202.2516025-1-quic_tengfan@quicinc.com>
 <20240618072202.2516025-3-quic_tengfan@quicinc.com>
 <44e24399-6efa-41ed-8871-12180dd03e10@linaro.org>
 <c265d22e-c246-4c9f-b6ff-7a350468e28c@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <c265d22e-c246-4c9f-b6ff-7a350468e28c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20/06/2024 15:40, Tengfei Fan wrote:
> 
> 
> On 6/18/2024 6:06 PM, Caleb Connolly wrote:
>> HI Tengfei,
>>
>> On 18/06/2024 09:22, Tengfei Fan wrote:
>>> QCS8550 is derived from SM8550. The difference between SM8550 and
>>> QCS8550 is QCS8550 doesn't have modem RF system. QCS8550 is mainly used
>>> in IoT products.
>>> QCS8550 firmware has different memory map compared to SM8550.
>>> The memory map will be runtime added through bootloader.
>>> There are 3 types of reserved memory regions here:
>>> 1. Firmware related regions which aren't shared with kernel.
>>>      The device tree source in kernel doesn't need to have node to 
>>> indicate
>>> the firmware related reserved information. Bootloader converys the
>>> information by updating devicetree at runtime.
>>>      This will be described as: UEFI saves the physical address of the
>>> UEFI System Table to dts file's chosen node. Kernel read this table and
>>> add reserved memory regions to efi config table. Current reserved memory
>>> region may have reserved region which was not yet used, release note of
>>> the firmware have such kind of information.
>>> 2. Firmware related memory regions which are shared with Kernel
>>>      The device tree source in the kernel needs to include nodes that
>>> indicate fimware-related shared information. A label name is suggested
>>> because this type of shared information needs to be referenced by
>>> specific drivers for handling purposes.
>>>      Unlike previous platforms, QCS8550 boots using EFI and describes
>>> most reserved regions in the ESRT memory map. As a result, reserved
>>> memory regions which aren't relevant to the kernel(like the hypervisor
>>> region) don't need to be described in DT.
>>> 3. Remoteproc regions.
>>>      Remoteproc regions will be reserved and then assigned to subsystem
>>> firmware later.
>>> Here is a reserved memory map for this platform:
>>>   0x80000000 +-------------------+
>>>              |                   |
>>>              | Firmware Related  |
>>>              |                   |
>>>   0x8a800000 +-------------------+
>>>              |                   |
>>>              | Remoteproc Region |
>>>              |                   |
>>>   0xa7000000 +-------------------+
>>>              |                   |
>>>              | Kernel Available  |
>>>              |                   |
>>>   0xd4d00000 +-------------------+
>>>              |                   |
>>>              | Firmware Related  |
>>>              |                   |
>>> 0x100000000 +-------------------+
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs8550.dtsi | 162 ++++++++++++++++++++++++++
>>>   1 file changed, 162 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi 
>>> b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>> new file mode 100644
>>> index 000000000000..07b314834d88
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
>>> @@ -0,0 +1,162 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All 
>>> rights reserved.
>>> + */
>>> +
>>> +#include "sm8550.dtsi"
>>> +
>>> +/delete-node/ &reserved_memory;
>>> +
>>> +/ {
>>> +    reserved_memory: reserved-memory {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges;
>>> +
>>> +
>>> +        /* These are 3 types of reserved memory regions here:
>>> +         * 1. Firmware related regions which aren't shared with kernel.
>>> +         *     The device tree source in kernel doesn't need to have 
>>> node to
>>> +         * indicate the firmware related reserved information. 
>>> Bootloader
>>> +         * conveys the information by updating devicetree at runtime.
>>> +         *     This will be described as: UEFI saves the physical 
>>> address of
>>> +         * the UEFI System Table to dts file's chosen node. Kernel 
>>> read this
>>> +         * table and add reserved memory regions to efi config 
>>> table. Current
>>> +         * reserved memory region may have reserved region which was 
>>> not yet
>>> +         * used, release note of the firmware have such kind of 
>>> information.
>>
>> This is a lot of implementation detail about UEFI, I'd imagine that 
>> anyone curious can go read the relevant docs instead. It's a lot of 
>> words just to say "Firmware regions which the kernel doesn't need to 
>> know about which are not included in the EFI provided memory map."
> 
> 
> The following update will be applied to this point:
> 
> 1. Firmware related regions which aren't shared with kernel.
>       Firmware regions which the kernel doesn't need to know about which 
> are not included in the EFI provided memory map.
> 
> 
>>> +         * 2. Firmware related memory regions which are shared with 
>>> Kernel
>>> +         *     The device tree source in the kernel needs to include 
>>> nodes
>>> +         * that indicate fimware-related shared information. A label 
>>> name
>>> +         * is suggested because this type of shared information 
>>> needs to
>>> +         * be referenced by specific drivers for handling purposes.
>>
>> "Firmware regions the kernel DOES need to know about, which are 
>> described in the reserved-memory node".
> 
> The following update will be applied to this point:
> 
> 2. Firmware related memory regions which are shared with Kernel
> 
> Firmware regions the kernel does need to know about, which are described 
> in the reserved-memory node.
> 
>>> +         *     Unlike previous platforms, QCS8550 boots using EFI 
>>> and describes
>>> +         * most reserved regions in the ESRT memory map. As a 
>>> result, reserved
>>> +         * memory regions which aren't relevant to the kernel(like 
>>> the hypervisor
>>> +         ( region) don't need to be described in DT.
>>
>> These would fall under (1) "firmware the kernel doesn't need to know 
>> about"
> 
> This will be removed from its current position.
> 
>>> +         * 3. Remoteproc regions.
>>> +         *     Remoteproc regions will be reserved and then assigned to
>>> +         * subsystem firmware later.
>>
>> How do these differ from those described in (2)?
> 
> This point will do the following update:
> 
> 3. Remoteproc regions
> 
>     Remoteproc regions will be reserved and then assigned to subsystem 
> firmware later.
> 
>     Remoteproc regions can be loaded either in a fixed form or in a 
> relocatable form, depending on the platform.
> 
>>
>> I think this comment is trying to describe too much at once. You're 
>> trying to describe what the different types of reserved memory are, 
>> how the kernel learns about them, and how this differs from previous 
>> platforms all at once. I think you should tackle these points separately:
>>
>> First describe the types of reserved memory and how the kernel learns 
>> about them (my suggestions above). Then describe the differences with 
>> previous platforms (like the hypervisor example)
>>
>> Thanks and regards,
> 
> Your previous suggestion will be incorporated here as follows:
> 
> Unlike previous platforms, QCS8550 boots using EFI and describes most 
> reserved regions in the ESRT memory map. As a result, reserved memory 
> regions which aren't relevant to the kernel(like the hypervisor region) 
> don't need to be described in DT.
> 
> Is it reasonable to place it here?

Thanks great, thanks a lot :)
> 
> Thanks!
> 
>>> +         * Here is a reserved memory map for this platform:
>>> +         *  0x80000000 +-------------------+
>>> +         *             |                   |
>>> +         *             | Firmware Related  |
>>> +         *             |                   |
>>> +         *  0x8a800000 +-------------------+
>>> +         *             |                   |
>>> +         *             | Remoteproc Region |
>>> +         *             |                   |
>>> +         *  0xa7000000 +-------------------+
>>> +         *             |                   |
>>> +         *             | Kernel Available  |
>>> +         *             |                   |
>>> +         *  0xd4d00000 +-------------------+
>>> +         *             |                   |
>>> +         *             | Firmware Related  |
>>> +         *             |                   |
>>> +         * 0x100000000 +-------------------+
>>> +         */
>>> +
>>> +        aop_image_mem: aop-image-region@81c00000 {
>>> +            reg = <0x0 0x81c00000 0x0 0x60000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
>>> +            compatible = "qcom,cmd-db";
>>> +            reg = <0x0 0x81c60000 0x0 0x20000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        aop_config_mem: aop-config-region@81c80000 {
>>> +            no-map;
>>> +            reg = <0x0 0x81c80000 0x0 0x20000>;
>>> +        };
>>> +
>>> +        smem_mem: smem-region@81d00000 {
>>> +            compatible = "qcom,smem";
>>> +            reg = <0x0 0x81d00000 0x0 0x200000>;
>>> +            hwlocks = <&tcsr_mutex 3>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        adsp_mhi_mem: adsp-mhi-region@81f00000 {
>>> +            reg = <0x0 0x81f00000 0x0 0x20000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        mpss_mem: mpss-region@8a800000 {
>>> +            reg = <0x0 0x8a800000 0x0 0x10800000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        q6_mpss_dtb_mem: q6-mpss-dtb-region@9b000000 {
>>> +            reg = <0x0 0x9b000000 0x0 0x80000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        ipa_fw_mem: ipa-fw-region@9b080000 {
>>> +            reg = <0x0 0x9b080000 0x0 0x10000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        ipa_gsi_mem: ipa-gsi-region@9b090000 {
>>> +            reg = <0x0 0x9b090000 0x0 0xa000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        gpu_micro_code_mem: gpu-micro-code-region@9b09a000 {
>>> +            reg = <0x0 0x9b09a000 0x0 0x2000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        spss_region_mem: spss-region@9b100000 {
>>> +            reg = <0x0 0x9b100000 0x0 0x180000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        spu_secure_shared_memory_mem: 
>>> spu-secure-shared-memory-region@9b280000 {
>>> +            reg = <0x0 0x9b280000 0x0 0x80000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        camera_mem: camera-region@9b300000 {
>>> +            reg = <0x0 0x9b300000 0x0 0x800000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        video_mem: video-region@9bb00000 {
>>> +            reg = <0x0 0x9bb00000 0x0 0x700000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        cvp_mem: cvp-region@9c200000 {
>>> +            reg = <0x0 0x9c200000 0x0 0x700000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        cdsp_mem: cdsp-region@9c900000 {
>>> +            reg = <0x0 0x9c900000 0x0 0x2000000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        q6_cdsp_dtb_mem: q6-cdsp-dtb-region@9e900000 {
>>> +            reg = <0x0 0x9e900000 0x0 0x80000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        q6_adsp_dtb_mem: q6-adsp-dtb-region@9e980000 {
>>> +            reg = <0x0 0x9e980000 0x0 0x80000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        adspslpi_mem: adspslpi-region@9ea00000 {
>>> +            reg = <0x0 0x9ea00000 0x0 0x4080000>;
>>> +            no-map;
>>> +        };
>>> +
>>> +        mpss_dsm_mem: mpss_dsm_region@d4d00000 {
>>> +            reg = <0x0 0xd4d00000 0x0 0x3300000>;
>>> +            no-map;
>>> +        };
>>> +    };
>>> +};
>>
> 

-- 
// Caleb (they/them)

