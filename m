Return-Path: <linux-kernel+bounces-443984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DE9EFEA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAAF16CC39
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47951DB54B;
	Thu, 12 Dec 2024 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRcBeUIA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275F1DA60F
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039914; cv=none; b=AcXjelRc6VqzeTH2cOG+nIlqVnFlOns1oqAM0qCyMJIF/4I6J27rVEVXk5o2wy30vxeq46LLQW54I/TMpKOgF/HTzsOmh6ZpbECR0dp7cDWBFm+HiaauKaES6YXn21IL3QhSJ57A+hr2jSPtz7ZSO+pdpcnDVWYb1Y5aKA/LcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039914; c=relaxed/simple;
	bh=+pJC1tYp5SsRp+I/N+6d6y4+PFvu3012i6C7y4ybq4M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VJBePbpcC9sCW6fUzc4hl1yK1KHUQ43rR1WU+lMeq4ERFTEZXqNN7ktymJqYoSzXhpsFAMLmtEkju1OxVg9mMDRCAQAHmFfNzcPurApIvZQHqZdi6kAiXVHHZJOmTJxiTLtSLiRrcjzlJAx6D3rAY9bT/wk0VDptvBq3B4l/hSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qRcBeUIA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso11059525e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734039910; x=1734644710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EqGMbuCS/ZZIE29NMrOme5aBpr93tYRrvJdfmFw3cs=;
        b=qRcBeUIAZtlPvcol7fuAjVwTuY4WKP4f36A1B6OwRTzqVd8Sp7Z312ZEDfC7QLpzGa
         Q0+7v4BB0qix2fpUaq1Ch+HSJMHFwLpBr1WOWC7mFvJbc25uCbs3nwLRqQwvoAHjPuQR
         lIyv55Aw67VplWprRvAc7aKDoDzmZFcNO07mca63sg1mwmCL/Gl6WJJrPdcfBV+NmRnf
         vig1M6LN27b46GKfuZ1kLmPQz+m8AV5u8u0N7A165tG2aeXimjq16LOAJcZRahlid2/U
         oi/CN8HuYeovWh0QCdjgU1j1dwMhbrRs8EwUijuayQC1GHBHrQ5ZtzgfmlnoiNQLK7+5
         GV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039910; x=1734644710;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6EqGMbuCS/ZZIE29NMrOme5aBpr93tYRrvJdfmFw3cs=;
        b=v2z1GSLiUYr3hm7zLkuWq/V82/BCeAdw5xJTBeKYuBEFtqHe+eucFRANz7N0uaaFtm
         +V3S7TX0gxX21XZgeKwiuke4qkTfW+T0PpYfPg3n38e9dnmMiomf1w+uxBCBN07dDVLA
         DmfKvZCsJFpqcIvfbAFmLXTMCWLovOTrPlEHsb9WJgbm8GnEkJAzAmpiIenu/Fl9OJ6N
         KIvHht5TSyTB21iBm0p3NMkXT+ouUG0rUHQ8LiMiMRp70/jFKOVThgtwno6QgUnKR03n
         wT5kqJGERsILyLnPDpgRHc5U0KR50i9MjNqQNR3Aci/ME4YIdimpU81E8ZOmYRduHpTY
         HNGw==
X-Forwarded-Encrypted: i=1; AJvYcCVhAoISZuAjCZHsEjFxwsfhzfJ01rcfYAIjGiwoOckasvcoeRF3EC/LLkZ2vi0+23pQONSfpRdyFvH+ATA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAOgMg/HWeHBLnVy59mzj26/woAGsnGrm5awL1haKFoyta0b8
	ZVc7zmuhYjy59SIJsTkN5wk3RQiSd69tbnj++hUzs28UFKhZ0X1ReU7DVicDB9Q=
X-Gm-Gg: ASbGncsz6M6Jo5Rkz6TGYat95tcnrDa0qhiQrkcvtnSmRoPZflkLObZNUG40wDG6E36
	UT2kJpIEx2lWjpaBQXmbXLG+M3vfUOTVHz5i+djLIIJcYmoeM6czPfDLeKFpouRC+9ni3HFLQKA
	t6CtsqZHwMqGh65CakM/dzGpSoxnzUths3Pj3X2OIUVQqu2ddAQfgEV3a6JXr10D667Au4VLIT9
	y2DDYZUzR7L14Ye+TvI/TLdbYermENA0Rwv+Rzkv6bi/kdeTkhTy8wIb0KK+c8DOG7/Autdccca
	zMsR5J4Ocw0Mqc1tji2LQw2rfG7/7brSbg==
X-Google-Smtp-Source: AGHT+IF5/+Jrvgv4s3ueVCJoCsZwKVU/EjZP6+PRD2aegZfz2rCwFND7aIZnKE6iaKTEjWY1J9n7fg==
X-Received: by 2002:a05:600c:c11:b0:434:a684:9b1 with SMTP id 5b1f17b1804b1-4362aa1549bmr1300265e9.4.1734039910424;
        Thu, 12 Dec 2024 13:45:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a? ([2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255800f6sm27926505e9.18.2024.12.12.13.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 13:45:10 -0800 (PST)
Message-ID: <924bb119-178d-4778-800f-94e884acc5a3@linaro.org>
Date: Thu, 12 Dec 2024 22:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/7] drm/msm: adreno: add plumbing to generate
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
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-2-6112f9f785ec@linaro.org>
 <3aad9de3-76a5-4106-a513-4707b3e39e7a@oss.qualcomm.com>
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
In-Reply-To: <3aad9de3-76a5-4106-a513-4707b3e39e7a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 20:55, Konrad Dybcio wrote:
> On 11.12.2024 9:29 AM, Neil Armstrong wrote:
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
>> This vote value is called IB, while on the other side the GMU also
>> takes another vote called AB which is a 16bit quantized value
>> of the floor bandwidth against the maximum supported bandwidth.
>> The AB vote will be calculated later when setting the frequency.
>>
>> The vote array will then be used to dynamically generate the GMU
>> bw_table sent during the GMU power-up.
>>
>> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 144 ++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  13 +++
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
>>   3 files changed, 158 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>> index 14db7376c712d19446b38152e480bd5a1e0a5198..36696d372a42a27b26a018b19e73bc6d8a4a5235 100644
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
>> @@ -1287,6 +1288,101 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
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
> 
> No. This is a direct copypasta of drivers/interconnect/qcom/icc-rpmh.h
> You cannot just randomly duplicate things..
> 
> Move it out to a shared header in include/ (and remove the duplicate from
> clk-rpmh.c while at it)
> 

Not sure if this a good idea

> 
> I'd also really prefer if you took
> 
> drivers/interconnect/qcom/bcm-voter.c : tcs_list_gen()
> 
> and abstracted it to operate on struct bcm_db with any additional
> required parameters passed as arguments.. Still left some comments
> on this version if you decide to go with it

They are still very different, look closely, tcs_list_gen is designed to
operate on BW aggregations + scsaling, it would make no sense to unify them.

The calculation is simple enough, I made it explicitely easy to read and
maintain, but honestly there's nothing special.

> 
>> +
>> +static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info,
>> +				       struct a6xx_gmu *gmu)
>> +{
>> +	const struct bcm_db *bcm_data[GMU_MAX_BCMS] = { 0 };
>> +	unsigned int bcm_index, bw_index, bcm_count = 0;
>> +
>> +	if (!info->bcms)
>> +		return 0;
> 
> You already checked that from the caller

Good catch

> 
>> +
>> +	/* Retrieve BCM data from cmd-db */
>> +	for (bcm_index = 0; bcm_index < GMU_MAX_BCMS; bcm_index++) {
>> +		size_t count;
>> +
>> +		/* Stop at first unconfigured bcm */
>> +		if (!info->bcms[bcm_index].name)
>> +			break;
> 
> Unconfigured doesn't really fit here.. Maybe just mention the list is NULL
> -terminated

Ack

> 
>> +
>> +		bcm_data[bcm_index] = cmd_db_read_aux_data(
>> +						info->bcms[bcm_index].name,
>> +						&count);
>> +		if (IS_ERR(bcm_data[bcm_index]))
>> +			return PTR_ERR(bcm_data[bcm_index]);
>> +
>> +		if (!count)
>> +			return -EINVAL;
> 
> If this condition ever happens, it'll be impossible to track down,
> please add an err message

Hmm sure

> 
>> +
>> +		++bcm_count;
> 
> I've heard somewhere that prefixed increments are discouraged for
> "reasons" and my OCD would like to support that

Never got this memo...

> 
>> +	}
>> +
>> +	/* Generate BCM votes values for each bandwidth & BCM */
>> +	for (bw_index = 0; bw_index < gmu->nr_gpu_bws; bw_index++) {
>> +		u32 *data = gmu->gpu_ib_votes[bw_index];
>> +		u32 bw = gmu->gpu_bw_table[bw_index];
>> +
>> +		/* Calculations loosely copied from bcm_aggregate() & tcs_cmd_gen() */
>> +		for (bcm_index = 0; bcm_index < bcm_count; bcm_index++) {
>> +			bool commit = false;
>> +			u64 peak;
>> +			u32 vote;
>> +
>> +			/* Skip unconfigured BCM */
>> +			if (!bcm_data[bcm_index])
>> +				continue;
> 
> I don't see how this is useful here

It's a leftover, will drop

> 
>> +
>> +			if (bcm_index == bcm_count - 1 ||
>> +			    (bcm_data[bcm_index + 1] &&
>> +			     bcm_data[bcm_index]->vcd != bcm_data[bcm_index + 1]->vcd))
>> +				commit = true;
>> +
>> +			if (!bw) {
>> +				data[bcm_index] = BCM_TCS_CMD(commit, false, 0, 0);
>> +				continue;
>> +			}
>> +
>> +			if (info->bcms[bcm_index].fixed) {
> 
> You may want to take a pointer to info->bcms[bcm_index]

Sure, will help

> 
>> +				u32 perfmode = 0;
>> +
>> +				if (bw >= info->bcms[bcm_index].perfmode_bw)
>> +					perfmode = info->bcms[bcm_index].perfmode;
>> +
>> +				data[bcm_index] = BCM_TCS_CMD(commit, true, 0, perfmode);
>> +				continue;
>> +			}
>> +
>> +			/* Multiply the bandwidth by the width of the connection */
>> +			peak = (u64)bw * le16_to_cpu(bcm_data[bcm_index]->width);
>> +			do_div(peak, info->bcms[bcm_index].buswidth);
>> +
>> +			/* Input bandwidth value is in KBps, scale the value to BCM unit */
>> +			peak *= 1000ULL;
> 
> I don't think this needs to be ULL since the other argument is an u64
> 
>> +			do_div(peak, le32_to_cpu(bcm_data[bcm_index]->unit));
>> +
>> +			vote = clamp(peak, 1, BCM_TCS_CMD_VOTE_MASK);
>> +
>> +			data[bcm_index] = BCM_TCS_CMD(commit, true, vote, vote);
> 
> x is the avg vote, y is the peak vote

downstream sets both calculated from the exact same value and the same way...

> 
> Just noting down for my future self I guess, a6xx sets ab=0,
> a7xx sets ab=ib like you did here

Probably, I'll need to check on that, but it can be done in a second step when enabling it on a6xx

> 
> Konrad


