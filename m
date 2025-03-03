Return-Path: <linux-kernel+bounces-542397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8AA4C906
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD797A8C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1232356AC;
	Mon,  3 Mar 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="indBYQiQ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C47215186
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021185; cv=none; b=dWETNWp+qALs6hQOd2a2yRHyqmRFgz4vQkZ+DEywZZmGCVzFO5obyjKZ6iWcqP19LxNbIfsdaESBFYm/wPf8AUelw2PVtR9t6z6IGTwtwOBa/kzVkMC1QWSblt/+lwO0JBsISZ4wnYMZ1TCRfijWeXEkkiWvOfkSxbkJslEUz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021185; c=relaxed/simple;
	bh=oH978JFzs5QlFfeiXA41hwt/41QiwNuuxnrXBUVHP/E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rIg57kEWOh0NmHreq2jE+EmEWVubglZH5KTD108lzI3COQqnuWEZnI1HQ3Xd2c+Hha+4PO/fP3w/wofhGs5ea7WDSgAtWJhAvBvJyPCC7QEGXzBWybUOT/rZPOVUwkTts4PHDfaI4k788QDmYa62BP9L7F2625F24YFTV6RB+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=indBYQiQ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so7403405e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741021180; x=1741625980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqEytWC5Mz9hcceZZmQuQUkkVtwWYuhWvrPiRd/Fx4k=;
        b=indBYQiQscVvGgwbf2QX7V2S7+pzkSj/JD3P2TGZSscZbFbS52f61gSmv1m9h4m1qo
         spkd3w+ikeeFZx2TD1qYh3+8QM9e4NkUfYDqDWeXQTHUp3vyW+9rdiEE2ETCbdeHgegz
         sFlS4Bjo7mQZa4zR2FoY6pAazFayZDsagyOSwZSsyqtzhWKLBRHM8ThdVLygytbDpb1L
         sIZsGUXjH/hXsYOABN1oKcvooDY0R5WRnyzB6YNYye5HEbklH7ar99AVvJUKCKMN2Y93
         UsvBCisqKC8g+Rqxm7lDNMdF5EAwI6xsLo9ebgQdk+iCO+5eD3JeOSapsztDuSMlhUCa
         HedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741021180; x=1741625980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rqEytWC5Mz9hcceZZmQuQUkkVtwWYuhWvrPiRd/Fx4k=;
        b=IfZD1Dc5KOrfTGLnmU4Y+1r/KuFWxdlySE37Jd+y+rBFA7XPZQWJRBz8Qk+2dp9q/n
         lI+qFQTA6T8EkAahOmgZ5HBQwC5nrTTKQMmY5cIkmyC1fjKN3Ek2p/MhP/pdBKJuVafa
         9DF9OiEoQpDcVh6Ff4HBJxsIeWaIflpnDUJFe/6P8z2rMuwPHr9raPg0wQVjdyjRjpPD
         i9w2Pvv/yTmd5yClosClB1YHz4EPMsnc9kLjdtFlIhJAjICugGYgZrAJK20oAPMxHT74
         6Ya/KVKJAZB4l4d/XuVfwdqWenK2r0lFWrmzQJ0J8hAxVmpv42yyjU7HeU58vZe7LFsU
         GiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPge0MDhf7c41jdNUvaTIvXV8asbPqVX5ZF0rstZNu2yV0BfbyM7nW/FpR8tjeep9JLN4y3fj5dEyanoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywV59PNH3ojDy1qQNLdpaScnji3tbrvLetO8LQgmI8URLJckEE
	9MkHtIifSJHLCvmbGJ5qlVVQqa1Ekd3+brtm5TAjjHmqN4FN5VgXRaOpXNoUN04=
X-Gm-Gg: ASbGncuyVYEN3m/u0xZwvNmm80HEIlfrpx/ZXLFrP/+FDwQ8BtNMl8g3DgHoeWHfOJn
	NU1v3sMOqG6IOgNzztXAljhgCTDrvI/nu6nNnnJkHLFydW6Kei+xo6rI0477wW30nwAJ4KhCa3o
	zD6ruPpzfWIEi+WX+UdsH9Nu/HBNW6fSyOzBktEWVRPWM453WAoph4RA7nu1s7I1I9LfCb1DTTv
	crl1kKEyis4ngG1SzMtluTTVpcQHJ1Gx2Lv7NfYJoZGS3RyxZo5xID65FhIy+vAEmCleqS2eonh
	62LEabrYO+BTlZnCIo3s1+gcc52VhmhI+b6S8Bo95cqegAL6Bms5yIEJgc+PVC4sN+fLXq3UHwq
	R/F+FbM57Wy+hy2nSLKPJCA==
X-Google-Smtp-Source: AGHT+IHB5e8qHoNaz92JEh8SpwvriHPYxgjOv/OhwXAPTDqbY6gedugAXYtghujiNdzQrADoIS9mEg==
X-Received: by 2002:a05:600c:3b24:b0:439:9496:17df with SMTP id 5b1f17b1804b1-43ba66fee15mr121905145e9.13.1741021180506;
        Mon, 03 Mar 2025 08:59:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1c49:dea2:d749:5015? ([2a01:e0a:982:cbb0:1c49:dea2:d749:5015])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b694524c6sm171865805e9.0.2025.03.03.08.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:59:40 -0800 (PST)
Message-ID: <71c8e765-7eb8-4572-8461-30e4761be836@linaro.org>
Date: Mon, 3 Mar 2025 17:59:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/4] media: platform: qcom/iris: add support for vpu33
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org>
 <20250225-topic-sm8x50-iris-v10-v1-3-128ef05d9665@linaro.org>
 <1fcf08fe37a8e14c4acae445d65bd1503b13b6d2.camel@pengutronix.de>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <1fcf08fe37a8e14c4acae445d65bd1503b13b6d2.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2025 17:38, Philipp Zabel wrote:
> On Di, 2025-02-25 at 10:05 +0100, Neil Armstrong wrote:
>> The IRIS acceleration found in the SM8650 platforms uses the vpu33
>> hardware version, and requires a slighly different reset and power off
>> sequences in order to properly get out of runtime suspend.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/media/platform/qcom/iris/Makefile          |   1 +
>>   drivers/media/platform/qcom/iris/iris_vpu33.c      | 315 +++++++++++++++++++++
>>   drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
>>   3 files changed, 317 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
>> index 35390534534e93f4617c1036a05ca0921567ba1d..6b64c9988505afd9707c704449d60bb53209229f 100644
>> --- a/drivers/media/platform/qcom/iris/Makefile
>> +++ b/drivers/media/platform/qcom/iris/Makefile
>> @@ -21,6 +21,7 @@ qcom-iris-objs += \
>>                iris_vdec.o \
>>                iris_vpu2.o \
>>                iris_vpu3.o \
>> +             iris_vpu33.o \
>>                iris_vpu_buffer.o \
>>                iris_vpu_common.o \
>>   
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu33.c b/drivers/media/platform/qcom/iris/iris_vpu33.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..128a050f206f99ec0d43b97ff995fa50d5684150
>> --- /dev/null
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu33.c
>> @@ -0,0 +1,315 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/iopoll.h>
>> +#include <linux/reset.h>
>> +
>> +#include "iris_instance.h"
>> +#include "iris_vpu_common.h"
>> +#include "iris_vpu_register_defines.h"
>> +
>> +#define WRAPPER_TZ_BASE_OFFS			0x000C0000
>> +#define AON_BASE_OFFS				0x000E0000
>> +#define AON_MVP_NOC_RESET			0x0001F000
>> +
>> +#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
>> +#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
>> +#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
>> +#define REQ_POWER_DOWN_PREP			BIT(0)
>> +#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
>> +#define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
>> +#define CORE_CLK_RUN				0x0
>> +
>> +#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
>> +#define CTL_AXI_CLK_HALT			BIT(0)
>> +#define CTL_CLK_HALT				BIT(1)
>> +
>> +#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
>> +#define RESET_HIGH				BIT(0)
>> +
>> +#define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
>> +#define CORE_BRIDGE_SW_RESET			BIT(0)
>> +#define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
>> +
>> +#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
>> +#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
>> +#define MSK_CORE_POWER_ON			BIT(1)
>> +
>> +#define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
>> +#define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
>> +
>> +#define AON_WRAPPER_MVP_NOC_RESET_ACK		(AON_MVP_NOC_RESET + 0x004)
>> +
>> +#define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
>> +
>> +#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
>> +#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
>> +
>> +#define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
>> +#define SW_RESET				BIT(0)
>> +#define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
>> +#define NOC_HALT				BIT(0)
>> +#define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
>> +
>> +#define VCODEC_DMA_SPARE_3 0x87B8
>> +
>> +static int reset_control_bulk_assert_id(int num_rstcs,
>> +					struct reset_control_bulk_data *rstcs,
>> +					char *id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < num_rstcs; ++i) {
>> +		if (!strcmp(rstcs[i].id, id))
>> +			return reset_control_assert(rstcs[i].rstc);
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static int reset_control_bulk_deassert_id(int num_rstcs,
>> +					  struct reset_control_bulk_data *rstcs,
>> +					  char *id)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < num_rstcs; ++i) {
>> +		if (!strcmp(rstcs[i].id, id))
>> +			return reset_control_deassert(rstcs[i].rstc);
>> +	}
>> +
>> +	return -ENODEV;
>> +}
> 
> Please adapt the abstractions instead of working around them. If the
> driver isn't suited for a single reset_control_bulk_data in iris_core,
> split it into multiple groups, or store the resets individually.
> 
> At the very least, this could use constant indices instead of linear
> search with string compares.

It was a first try, I'll think about something better for v2.

Neil

> 
> regards
> Philipp


