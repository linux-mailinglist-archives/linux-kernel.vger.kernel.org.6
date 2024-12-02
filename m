Return-Path: <linux-kernel+bounces-427081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601DB9DFC27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C1162CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9741F9F54;
	Mon,  2 Dec 2024 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI5H+XDl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6991F9F44
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128870; cv=none; b=IIJ4LcfLUJsiEC4hRmuuOIm+vQ+Yyy4R76KGfhoTo+UR90reeLQIQIdCRVNu9gTabRDiP6HWsx6vQ86HNuLw1BftrDoXYfNCp7Q0Cvw5Mw4DHpVTXX0jsDynBPlysTo/7+cPXMc34cZQjNWICNoh2BzarOTnSTtB2Gik7rpdLtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128870; c=relaxed/simple;
	bh=p3zC5o7pBR0XDVFCEkcLCIknMXu5G7LJ9I/dDqAiqV8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tmH+TECBY1MXSxfHHMYbByO1mDw5nq6nowcXmLgVg8oQ6oBMctkOlXTe+QoQAQm82dcviLyyO0r3fmsPTlqRg1mtCVX52gzBIITJfXrGLhLX2LdtCuste70u0g2Wp6T8OzW7FEZHmxEI2/4VI7vf/DNh0Ym/dxmUWDkmkvNQH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cI5H+XDl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434ab114753so32591605e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733128867; x=1733733667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqpmQF7Mu1sFApiVUnKDgvrMQ7SbFxr3tSiVMK2XyKY=;
        b=cI5H+XDlwP73N92O64bOMLbi0mMxmKnfGexI62gHpmCarqAHzH/VrroxyXj5coaWId
         FPCnZx4GSgK5IpCyBzfbs25cbjLIIKnmLLiIfj1KJJCjWIcSBHmY2kR87NO4fqzi9GQq
         fd1OgkX4e7f4g3MzjZgte4mzU0RX0sij/rVbsteep+ib2xA9Ji/ihESKbj9Cj4quWMd/
         3WMLj3oSc9s5bChpjenSVmPZruTQ+VP6hdv6v98zch0uSq/ZyycEqaUc2bC6GmBLprZC
         X0pFjxh9eYVxIfGWeoliSjuAXvKMYT92zbV5SFZ5PW4CP57pZhIv59kjGz34/SZmNecO
         BBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128867; x=1733733667;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqpmQF7Mu1sFApiVUnKDgvrMQ7SbFxr3tSiVMK2XyKY=;
        b=dCbS8ZHAfa0XEUwyP0UGETO/HNpjdIpRoDJQAm7EOMEBkEiHibB+/bufGtYxIJcxyN
         C2kgANHpSNkHJskavUEIWY5fw4+jmVkllZs+6iLAFFGw562MPD4jn482nV1UKYInfaQm
         BPTCEOq7d0T7+o9vNG6mF1btqVFaXzJKd76WXue99YAScbqw9uFb2Qrenim5PPqDeXzr
         2C7eYH2us4pnsc1haH3NJ5Rpz+ZDOzoN4f7Ll/JTsXoA7eDXHw3LjiELAN3+DA5jJ+Bk
         wDGbbRIhUfP4QGPpeSF89N/XF0DG199QzLqwrrak6aIVxL2Y4jX3BcHH1cUJcqInwEzm
         rIsg==
X-Forwarded-Encrypted: i=1; AJvYcCVDPurDRLsTeYXBqexgmURb5afHerT6fK3jub+E2yBjY99zlEPHtkRkcPsmsbRmeHlSxl6+8gQ0Fhb7nrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNB1g5WNWraVeYObbkaLLtKmeH4RhGE/9v9CidRggSGlV6RXk
	/BxcpjRkc7iL9ZGGkLjdl8JnMv4hDqi0cPOHg56mmCCAMz5sfLd+hehNxQk/avo=
X-Gm-Gg: ASbGnctM4yc9p/bPXWFZy1if7F8g/EmPAbJ0+iY38pZAhDaPYxv9iOtlJMwD928vLU3
	q+HYG/45gEUicnIGr6xe9fvPKBMog7UZInSD+ufqcpPNBnMVZsl2HpBlJdftDj/Dtho0bf77e5Y
	48BwRKJi1yNJrbuVMXG5k6n+qZEXOKY6E04RCQTD8fbi7IBUoHOLoMJeSqgslWAdj2tJxC4OZX/
	HrMAjTaHc9vCpBe4kRnbFJ7snD8YHj4NKGh+XN37j/+Q1GgDBFRyJIjM56AgzEJdYwBL31G7VmG
	NJXQ6uhjF30H3SVNWtA44Tug5OQ=
X-Google-Smtp-Source: AGHT+IFEL+HfCS2wYrTtRN2IwTFSNWvHZLm7chYo/5muEQ4EUnv4OdtF1ywo/+D7RbALsxW6tnZX+A==
X-Received: by 2002:a05:600c:4e92:b0:434:9ef2:f6dc with SMTP id 5b1f17b1804b1-434a9dc5352mr200017895e9.13.1733128867200;
        Mon, 02 Dec 2024 00:41:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1485:2a78:787c:c669? ([2a01:e0a:982:cbb0:1485:2a78:787c:c669])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2db16sm11800899f8f.21.2024.12.02.00.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:41:06 -0800 (PST)
Message-ID: <df17e3c8-7096-4b22-b85e-bff4bbdee3b2@linaro.org>
Date: Mon, 2 Dec 2024 09:41:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 2/7] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241128-topic-sm8x50-gpu-bw-vote-v3-0-81d60c10fb73@linaro.org>
 <20241128-topic-sm8x50-gpu-bw-vote-v3-2-81d60c10fb73@linaro.org>
 <0dabac7a-bc7e-4075-86ed-3d4c25908ffb@oss.qualcomm.com>
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
In-Reply-To: <0dabac7a-bc7e-4075-86ed-3d4c25908ffb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 16:21, Konrad Dybcio wrote:
> On 28.11.2024 11:25 AM, Neil Armstrong wrote:
>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
>> the Frequency and Power Domain level, but by default we leave the
>> OPP core scale the interconnect ddr path.
>>
>> While scaling via the interconnect path was sufficient, newer GPUs
>> like the A750 requires specific vote paremeters and bandwidth to
>> achieve full functionality.
>>
>> In order to calculate vote values used by the GPU Management
>> Unit (GMU), we need to parse all the possible OPP Bandwidths and
>> create a vote value to be sent to the appropriate Bus Control
>> Modules (BCMs) declared in the GPU info struct.
>>
>> This vote value is called IB, while on the othe side the GMU also
>> takes another vote called AB which is a 16bit quantized value
>> of the bandwidth against the maximum supported bandwidth.
>>
>> The vote array will then be used to dynamically generate the GMU
>> bw_table sent during the GMU power-up.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 174 ++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  14 +++
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.h |   5 +
>>   4 files changed, 194 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 14db7376c712d19446b38152e480bd5a1e0a5198..ee2010a01186721dd377f1655fcf05ddaff77131 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/pm_domain.h>
>>   #include <linux/pm_opp.h>
>>   #include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/tcs.h>
>>   #include <drm/drm_gem.h>
>>   
>>   #include "a6xx_gpu.h"
>> @@ -1287,6 +1288,131 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
>> + * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
>> + * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
>> + * @vcd: virtual clock domain that this bcm belongs to
>> + * @reserved: reserved field
>> + */
>> +struct bcm_db {
>> +	__le32 unit;
>> +	__le16 width;
>> +	u8 vcd;
>> +	u8 reserved;
>> +};
>> +
>> +static u64 bcm_div(u64 num, u32 base)
>> +{
>> +	/* Ensure that small votes aren't lost. */
>> +	if (num && num < base)
>> +		return 1;
>> +
>> +	do_div(num, base);
>> +
>> +	return num;
>> +}
> 
> This should live in include/soc/qcom/bcm.h, similarly to tcs.h in
> that directory

Honestly, I don't think so, there's no bcm specific logic here, we
simply avoid returning 0 after a division

> 
>> +static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info,
>> +				       struct a6xx_gmu *gmu)
>> +{
>> +	const struct bcm_db *bcm_data[GMU_MAX_BCMS] = { 0 };
>> +	unsigned int bcm_index, bw_index, bcm_count = 0;
>> +
>> +	if (!info->bcms)
>> +		return 0;
>> +
>> +	/* Retrieve BCM data from cmd-db */
>> +	for (bcm_index = 0; bcm_index < GMU_MAX_BCMS; bcm_index++) {
>> +		size_t count;
>> +
>> +		/* Stop at first unconfigured bcm */
>> +		if (!info->bcms[bcm_index].name)
>> +			break;
>> +
>> +		bcm_data[bcm_index] = cmd_db_read_aux_data(
>> +						info->bcms[bcm_index].name,
>> +						&count);
>> +		if (IS_ERR(bcm_data[bcm_index]))
>> +			return PTR_ERR(bcm_data[bcm_index]);
>> +
>> +		if (!count)
>> +			return -EINVAL;
>> +
>> +		++bcm_count;
>> +	}
>> +
>> +	/* Generate BCM votes values for each bandwidth & BCM */
>> +	for (bw_index = 0; bw_index < gmu->nr_gpu_bws; bw_index++) {
>> +		u32 *data = gmu->gpu_ib_votes[bw_index];
>> +		u32 bw = gmu->gpu_bw_table[bw_index];
>> +
>> +		/* Calculations loosely copied from bcm_aggregate() & tcs_cmd_gen() */
> 
> Ditto, perhaps this should be exported from icc

I think it's a bad idea to share code because the overall structures and purposes
are completely different, and it will make the gpu maintenance a nightmare.

> 
> [...]
> 
> Konrad

Thanks,
Neil


