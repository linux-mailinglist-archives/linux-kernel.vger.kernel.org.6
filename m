Return-Path: <linux-kernel+bounces-519110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DEA39823
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EC01883A86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B922E418;
	Tue, 18 Feb 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhMjSZ0R"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7322CBD8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873157; cv=none; b=exzac01np9XWZxvQrhHkUWdsEICs8vow+8vHwlruyL3H0qjrAqUUA7FMqW/SLqSrBKwAFQDAIClPOahwOTDdb67V+yILlv009YS8guvfGroJ6RsLX0XqbwGVocgcuaBKiMnupSSrRYIHd2W/zVmtavKMpZ5ydtXK3MtMDR1cf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873157; c=relaxed/simple;
	bh=5D0p078nhevpa+mC/hHlfPqIhvL1kYMkrzSPI2+eDxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjLKcEfhZ1tr72UxGYyPGRL8J0HnE0z7PXHfQc3YdXg1Mtu+whxj7n5dlBqYsi2ABOG40qs+zG8xKe/xiXgw1CLoH7yLrC7soBxUyF4XxUOStTxqyK5fp06zSAC53yclfnATUYtV25H6HMsFkThCQnw7oVsRa7FQ5mDaT5Pv1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhMjSZ0R; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso34019115e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739873154; x=1740477954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYzIjw5m52Pb+IT0lkVGBcTiFW2c9Bpd7NnljROy9VA=;
        b=ZhMjSZ0RFtpsjQaUTmUO6As6rO2fQkKQEVKls2sOQBWSiCp9evIRUYUFCQOjTi+EBB
         HhbATLDAyohbkYT+Z9BcRAFSivFZkOpqzEpXnfMH4G8jCYXDVigRgoQkFvxo/selPph7
         vQpYmFVsHsAzCG2NwiBq1mMrPeu/cB9CKyOUOEKoFxMnKmshjQOTTCSY4Rsp+TSQVhQZ
         xpYNkxgHHZZXaaU76+qeXBmlE8EzSG/XKk6eoEkITSgRPs0P6t9MIzDeAOvGXvH6q9mG
         T92jNh9yFJWGpGaGFqqZVbBg9f25zsNX4VMclGiCLSCMyJ2BXreur5AAvMj1bismgP0p
         6aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873154; x=1740477954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYzIjw5m52Pb+IT0lkVGBcTiFW2c9Bpd7NnljROy9VA=;
        b=eJISESKQE5p0qFUG79g2M+UOiLcyGmYJ/4InCdTFqbdLHukuF0qqmxt25nzIM00JbV
         EqIr2MffmeLuBXn+7fy+TldhFhHysDIK7uhB03lvbXmZTrKjU9ybG/qictHwDn6y/kmk
         +RbJvfE2csgj8iCSGW3HM4wrYgYOGw1eyTPdaRn8DnQPC8yhMjVRJQ40hqhF0f8/rQFW
         lq95i+lazzaNodyKqVvRqX0m8bde6VpQrEL7JIwnr8NOiO4BGXmWnoYll1/HVbk9qpc2
         UrCf3TSWoOyRAFjssXjtxnVgArjySu8gHHeMMGRi++PVJiPbU+cmBoDi5SdMAGH5+d8K
         Njww==
X-Forwarded-Encrypted: i=1; AJvYcCW9Gd7wxil8e57FhEkGGvxYL+DmNjNbSbEzR3sUFwVpoq9j9IEPdOl0apv0D1kkB+r+21GDCTcjlZce43U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1gRtsqtsEsKvqYMZ2bNF0D2dbX++7BvQnVnpe1PNVUUIvb9Y
	zN+wYx2u0RTtgGEPSTojAmu3clDg/Py4TbOKB+m99TFHz2weEdLzuOcp2TonWO0=
X-Gm-Gg: ASbGncsr+0EjlCKuaUCrx2Kv5I8qUnnfGdFMgwD/Jlu1+Hy7fbgiCZnXnawpKZJdN7P
	0oUQCnVGtdcKpn61GJOgmLDT0/KbCKgxtsY86hJoP7yG4vP8O2GDmwd5NtkIcRM8R6SKkh2Wga1
	NPIj+keb4ENKmCHBgIBpmCJWHppRtuNJ2MH5V/Gic1sFwSx8H6A8la4s4T0eACvnHqEQs+e7sQd
	c44nhnfnFJgHwFRzlB+dECmGbrLo1NjJWC8zG9ZFgCnSvXWYPQD5Bl3POdSExCdoEgB03s6D7m+
	1eKOtdAoiQeHJBjPFT4GKQNZXg==
X-Google-Smtp-Source: AGHT+IHgIFVIHEo609omEOPIL5QR94PggfZ8Q3TFUk8tAi1jFgvW0FkFC6iIanB2i61fvsZwwgB5Fw==
X-Received: by 2002:a5d:6d06:0:b0:38f:4cdc:5d36 with SMTP id ffacd0b85a97d-38f4cdc605bmr5085888f8f.43.1739873153792;
        Tue, 18 Feb 2025 02:05:53 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43992ad82cfsm18910875e9.37.2025.02.18.02.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 02:05:53 -0800 (PST)
Message-ID: <0f6369fd-3236-40eb-bf8f-3c3d675137c9@linaro.org>
Date: Tue, 18 Feb 2025 10:05:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/7] Coresight: Add Coresight TMC Control Unit driver
To: Jie Gan <quic_jiegan@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Jinlong Mao <quic_jinlmao@quicinc.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20250217093024.1133096-1-quic_jiegan@quicinc.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250217093024.1133096-1-quic_jiegan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/02/2025 9:30 am, Jie Gan wrote:
> From: Jie Gan <jie.gan@oss.qualcomm.com>
> 
> The Coresight TMC Control Unit(CTCU) device hosts miscellaneous configuration
> registers to control various features related to TMC ETR device.
> 
> The CTCU device works as a helper device physically connected to the TMC ETR device.
> ---------------------------------------------------------
>               |ETR0|             |ETR1|
>                . \                 / .
>                .  \               /  .
>                .   \             /   .
>                .    \           /    .
> ---------------------------------------------------
> ETR0ATID0-ETR0ATID3     CTCU    ETR1ATID0-ETR1ATID3
> ---------------------------------------------------
> Each ETR has four ATID registers with 128 bits long in total.
> e.g. ETR0ATID0-ETR0ATID3 registers are used by ETR0 device.
> 
> Based on the trace id which is programed in CTCU ATID register of
> specific ETR, trace data with that trace id can get into ETR's buffer
> while other trace data gets ignored. The number of CTCU ATID registers
> depends on the number of defined TMC ETR devices. For example, two TMC
> ETR devices need eight ATID registers. ETR0 with ETR0ATID0-ETR0ATID3
> and ETR1 with ETR1ATID0-ETRATID3.
> 
> The significant challenge in enabling the data filter function is how
> to collect the trace ID of the source device. The introduction of
> trace_id callback function addresses this challenge. The callback function
> collects trace ID of the device and return it back. The trace ID will be
> stored in the structure called coresight_path and transmitted to helper
> and sink devices.
> 
> The coresight_path structure is created to address how to transmit
> parameters needs by coresight_enable_path/coresight_disbale_path
> functions.
> 
> Here is the definition of the struct coresight_path:
> /**
>   * struct coresight_path - data needed by enable/disable path
>   * @path:               path from source to sink.
>   * @trace_id:           trace_id of the whole path.
>   */
> struct coresight_path {
>          struct list_head                *path;
>          u8                              trace_id;
> };
> 
> The atid_offset mentioned before is the offset to ATID register in CTCU
> device.
> 
> Enabling the source device will configure one bit in the ATID register based
> on its trace ID.
> Disabling the source devices will reset the bit in the AITD register
> based on its trace ID.
> 
> Useage:
> Enable:
> STM device with trace ID 5 and ETR0 is activated.
> Bitmap before the enablement:
> ETR0ATID0:
> 31..................543210
> ==========================
> 0000000000000000000000...0
> ==========================
> 
> Bitmap after the enablement:
> 31..................543210
> ==========================
> 0000000000000...0000100000
> ==========================
> 
> The bit 5 of the ETR0ATID0 register is configured to 1 when enabling the
> STM device.
> 
> Disable:
> STM device with trace ID 5 and ETR0 is activated.
> Bitmap before the disablement:
> ETR0ATID0:
> 31................6543210
> =========================
> 000000000010111...0100000
> =========================
> 
> Bitmap after the disablement
> ETR0ATID0:
> 31................6543210
> =========================
> 000000000010111...0000000
> =========================
> 
> The bit 5 of the ETR0ATID0 register is reset to 0 when disabling the STM
> device.
> 
> Sincere thanks to James Clark for providing an excellent idea to handle
> the trace_id of the path.
> 
> Changes in V12:
> 1. Update the method for allocating trace_id for perf mode.
> Link to V11 - https://lore.kernel.org/linux-arm-msm/20250214024021.249655-1-quic_jiegan@quicinc.com/
> 

I tested the latest change, looks good to me.


