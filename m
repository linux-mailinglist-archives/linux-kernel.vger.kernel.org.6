Return-Path: <linux-kernel+bounces-420563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 998559D7CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C51B2164D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8348188737;
	Mon, 25 Nov 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioSqhbED"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D1684AE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522336; cv=none; b=QIxjw48SKPwHKBsC5vlgApzlyWYC7Y9iG57MUp8IFZTKo1TPMqvjj+NJwqt8orHt3SqF0WHJi4cotUZa2CSgN1EQiEXnkM5oe5Dlb1mCR9Z/vOx0+Ms1WTYqAfXjm56ZiIBYI92vL306GRE2tdozf+7Y+v4t8rzoq/16nFBF16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522336; c=relaxed/simple;
	bh=xmbGQConrg23/A5OABwqkG91r28g3vR0y5R19MeSlwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VDpyhQLAo4n9UI5UzOgIOBpa1ReXMDrv1Wstfa1K1ESbchKjTuxznQ+HmG51bQQJ4AXBr2hzj9Clpy9Ip4qMja9yMwxtYQMgQ8TPCYFVbMwHHJJTm3tMR3kc/lMbQdp7EZn8X+f+6Fuk6ZMEHDeCr1J8AYisRYz+tOD0sDuy9/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ioSqhbED; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43497839b80so10664535e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732522332; x=1733127132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+EMYzDLOFn6YSQFRv7FLdrpiinjBK91M2YSn49vs1w=;
        b=ioSqhbEDQs0t3MPdBA3IiBoFHRSzpeblq1PAWmyb7Xu7gJfJOZlEC8JUsjmSl+akOO
         C0Zd6iZnn+D1LdOhbssn/85S9s9iz0HoijyNjEmjwoSY1O4l4SLlKllJ0seY4vG9zGMD
         /FI2VQyTWMQXE/Uiez9P0YL6Yk9axPZN2mbWSCPW8dPzMJ535AgCgPQAGUVDFBX58mbM
         2Ym8uZ0lVpmjIQIBNKqB9SGnQZ9VpEstnDMaHDgMD7qz2PHLGHeOC40cKvTihMdgBqjI
         THZHnV4JKLPz3b9APQWHjHqv0gO3xMPVLJvUAhukzWdK/6kOilNfKiESFv45UK0y2p9M
         QuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732522332; x=1733127132;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y+EMYzDLOFn6YSQFRv7FLdrpiinjBK91M2YSn49vs1w=;
        b=bLJTLguaxuDf9sqYvRKvMC7fsW3JqLxzk+UQuS4zdzFdhCX9vYIOCxH//aEMU/s7hN
         ozj0Zvz3Gx+3qRaYMDmTcvzvChPaHpzbgbO5AOw87JlysT/s5B/IaD4oaeKTlpMhb+gr
         y1AsQpDxfUlR3s2+5BqjBZAwlZyx3m4b8G8v30Y6vH6VYQ+u+HYloidI+Aq7KO8ub2jD
         x+7YT6bMfRBjjxw+d4ChFkFQ2nENkfh7ve4qLWgAnI7pjDodw/c4je2knr3rSeGAsJ+d
         XX3G6M1qi5Pzfrf5ISA6RHwSDwABBG0mZh38Zzr3bhRDIx3bQLculJ7T380MTHGNxBae
         9SNg==
X-Forwarded-Encrypted: i=1; AJvYcCUadFPsKbvSVczE2JAPs/pYLq0cyMnbNeN3WngFgb/kwwWTOiOZmQ8LsV7IMpIzJ9rZ7xNXVT/fPB6uSmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqvcqE+12JZUU71mBkI4sKlm54xHV6R8TZQLln2cEzKhDlZxXj
	BzWVOwwL4XAlFS8SfJG8StyhcR2ol8XgsHk32jJYjXAvMkqBTJOpAc3e3gQch6o=
X-Gm-Gg: ASbGncvbyLUPyDP9BBfpkXOYrnN8Yo+kMAnWT/eESuuCNHdJw6Vn5bXZZTOMF1rFBt+
	95ESyeq0tPWhKeqPgh44flNIefubgFHqgMdKMCt7i6TVUaaLOpBI1nu779nheaT6T6unXFkIRhW
	2jiHid7+jOqOK3Hktiam61eslO0fP09oEXsg8GPz1CXWbWTuHowYl6mfKTl6BGdSdKiSgbpvbEj
	ofGxzwUBGfFkgRVnow4lDSx59ODiIQ3ZxKgCdy6DdOwZzR1KBe6quA9YFykiqZP8b8LvaX6YxdY
	Zhx9uYEhhXi9HAzzcaYC/CDHU7o=
X-Google-Smtp-Source: AGHT+IEEfQwUbGWFzyi/7xzYmiylvTyBhu/wOkXIvzLocKkiY+mgWC7Vs62u7VkpYExUugoX+26ZmQ==
X-Received: by 2002:a5d:5f8c:0:b0:382:39a7:3995 with SMTP id ffacd0b85a97d-38260b5b5a5mr9607030f8f.17.1732522331632;
        Mon, 25 Nov 2024 00:12:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b? ([2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc4173sm9948051f8f.72.2024.11.25.00.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:12:11 -0800 (PST)
Message-ID: <1f322b31-a516-4ff8-84b1-5000cdfc1c4a@linaro.org>
Date: Mon, 25 Nov 2024 09:12:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 05/11] drm/msm: adreno: add plumbing to generate
 bandwidth vote table for GMU
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
 <20241119-topic-sm8x50-gpu-bw-vote-v2-5-4deb87be2498@linaro.org>
 <20241123212246.46hdznrgusr2pj4v@hu-akhilpo-hyd.qualcomm.com>
 <20241123224648.kgc6hxdsgz4shhw4@hu-akhilpo-hyd.qualcomm.com>
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
In-Reply-To: <20241123224648.kgc6hxdsgz4shhw4@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/11/2024 23:46, Akhil P Oommen wrote:
> On Sun, Nov 24, 2024 at 02:52:46AM +0530, Akhil P Oommen wrote:
>> On Tue, Nov 19, 2024 at 06:56:40PM +0100, Neil Armstrong wrote:
>>> The Adreno GMU Management Unit (GMU) can also scale DDR Bandwidth along
>>> the Frequency and Power Domain level, but by default we leave the
>>> OPP core scale the interconnect ddr path.
>>>
>>> In order to calculate vote values used by the GPU Management
>>> Unit (GMU), we need to parse all the possible OPP Bandwidths and
>>
>> GMU expects a table of votes for each DDR frequency corners. Can we
>> please try to figure out a way to do that? Generally, we should ensure the
>> data that is send to GMU firmware match downstream exactly. Because,
>> when something breaks in firmware or worst, at SoC level, it will be pretty
>> hard to narrow down the issue. So, I prefer to be very conservative about
>> this.
>>
>> KGSL keeps the ddr frequency table in the devicetree. That helps to keep
>> the driver lean, but I am not sure if that is viable upstream.

No it's not, opp table is here for that, and we can reproduce the same
bahaviour by parsing all the bandwidths in the opp table.

>>
>> -Akhil.
>>
>>> create a vote value to be sent to the appropriate Bus Control
>>> Modules (BCMs) declared in the GPU info struct.
>>>
>>> The vote array will then be used to dynamically generate the GMU
>>> bw_table sent during the GMU power-up.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 153 ++++++++++++++++++++++++++++++++++
>>>   drivers/gpu/drm/msm/adreno/a6xx_gmu.h |  14 ++++
>>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.h |   1 +
>>>   3 files changed, 168 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index 14db7376c712d19446b38152e480bd5a1e0a5198..f6814d92a4edb29ba8a34a34aabb8b2324e9c6a4 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -9,6 +9,7 @@
>>>   #include <linux/pm_domain.h>
>>>   #include <linux/pm_opp.h>
>>>   #include <soc/qcom/cmd-db.h>
>>> +#include <soc/qcom/tcs.h>
>>>   #include <drm/drm_gem.h>
>>>   
>>>   #include "a6xx_gpu.h"
>>> @@ -1287,6 +1288,109 @@ static int a6xx_gmu_memory_probe(struct a6xx_gmu *gmu)
>>>   	return 0;
>>>   }
>>>   
>>> +/**
>>> + * struct bcm_db - Auxiliary data pertaining to each Bus Clock Manager (BCM)
>>> + * @unit: divisor used to convert bytes/sec bw value to an RPMh msg
>>> + * @width: multiplier used to convert bytes/sec bw value to an RPMh msg
>>> + * @vcd: virtual clock domain that this bcm belongs to
>>> + * @reserved: reserved field
>>> + */
>>> +struct bcm_db {
>>> +	__le32 unit;
>>> +	__le16 width;
>>> +	u8 vcd;
>>> +	u8 reserved;
>>> +};
> 
> Shouldn't this be a packed struct? It is naturally aligned, but still!

It's used as-is in the interconnecty driver, so I assume it's fine.

> 
>>> +
>>> +static u64 bcm_div(u64 num, u32 base)
>>> +{
>>> +	/* Ensure that small votes aren't lost. */
>>> +	if (num && num < base)
>>> +		return 1;
>>> +
>>> +	do_div(num, base);
>>> +
>>> +	return num;
>>> +}
>>> +
>>> +static int a6xx_gmu_rpmh_bw_votes_init(const struct a6xx_info *info,
>>> +				       struct a6xx_gmu *gmu)
>>> +{
>>> +	const struct bcm_db *bcm_data[GMU_MAX_BCMS] = { 0 };
>>> +	unsigned int bcm_index, bw_index;
>>> +
>>> +	/* Retrieve BCM data from cmd-db */
>>> +	for (bcm_index = 0; bcm_index < GMU_MAX_BCMS; bcm_index++) {
>>> +		size_t count;
>>> +
>>> +		/* Skip unconfigured BCM */
>>> +		if (!info->bcm[bcm_index].name)
>>> +			continue;
>>> +
>>> +		bcm_data[bcm_index] = cmd_db_read_aux_data(
>>> +						info->bcm[bcm_index].name,
>>> +						&count);
>>> +		if (IS_ERR(bcm_data[bcm_index]))
>>> +			return PTR_ERR(bcm_data[bcm_index]);
>>> +
>>> +		if (!count)
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	/* Generate BCM votes values for each bandwidth & BCM */
>>> +	for (bw_index = 0; bw_index < gmu->nr_gpu_bws; bw_index++) {
>>> +		u32 *data = gmu->gpu_bw_votes[bw_index];
>>> +		u32 bw = gmu->gpu_bw_table[bw_index];
>>> +
>>> +		/* Calculations loosely copied from bcm_aggregate() & tcs_cmd_gen() */
>>> +		for (bcm_index = 0; bcm_index < GMU_MAX_BCMS; bcm_index++) {
>>> +			bool commit = false;
>>> +			u64 peak, vote;
>>> +			u16 width;
>>> +			u32 unit;
>>> +
>>> +			/* Skip unconfigured BCM */
>>> +			if (!info->bcm[bcm_index].name || !bcm_data[bcm_index])
>>> +				continue;
>>> +
>>> +			if (bcm_index == GMU_MAX_BCMS - 1 ||
>>> +			    (bcm_data[bcm_index + 1] &&
>>> +			     bcm_data[bcm_index]->vcd != bcm_data[bcm_index + 1]->vcd))
>>> +				commit = true;
>>> +
>>> +			if (!bw) {
>>> +				data[bcm_index] = BCM_TCS_CMD(commit, false, 0, 0);
>>> +				continue;
>>> +			}
>>> +
>>> +			if (info->bcm[bcm_index].fixed) {
>>> +				u32 perfmode = 0;
>>> +
>>> +				if (bw >= info->bcm[bcm_index].perfmode_bw)
>>> +					perfmode = info->bcm[bcm_index].perfmode;
>>> +
>>> +				data[bcm_index] = BCM_TCS_CMD(commit, true, 0, perfmode);
>>> +				continue;
>>> +			}
>>> +
>>> +			/* Multiply the bandwidth by the width of the connection */
>>> +			width = le16_to_cpu(bcm_data[bcm_index]->width);
>>> +			peak = bcm_div((u64)bw * width, info->bcm[bcm_index].buswidth);
>>> +
>>> +			/* Input bandwidth value is in KBps, scale the value to BCM unit */
>>> +			unit = le32_to_cpu(bcm_data[bcm_index]->unit);
>>> +			vote = bcm_div(peak * 1000ULL, unit);
>>> +
>>> +			if (vote > BCM_TCS_CMD_VOTE_MASK)
>>> +				vote = BCM_TCS_CMD_VOTE_MASK;
>>> +
>>> +			data[bcm_index] = BCM_TCS_CMD(commit, true, vote, vote);
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /* Return the 'arc-level' for the given frequency */
>>>   static unsigned int a6xx_gmu_get_arc_level(struct device *dev,
>>>   					   unsigned long freq)
>>> @@ -1390,12 +1494,15 @@ static int a6xx_gmu_rpmh_arc_votes_init(struct device *dev, u32 *votes,
>>>    * The GMU votes with the RPMh for itself and on behalf of the GPU but we need
>>>    * to construct the list of votes on the CPU and send it over. Query the RPMh
>>>    * voltage levels and build the votes
>>> + * The GMU can also vote for DDR interconnects, use the OPP bandwidth entries
>>> + * and BCM parameters to build the votes.
>>>    */
>>>   
>>>   static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
>>>   {
>>>   	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>>   	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>>> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>>>   	struct msm_gpu *gpu = &adreno_gpu->base;
>>>   	int ret;
>>>   
>>> @@ -1407,6 +1514,10 @@ static int a6xx_gmu_rpmh_votes_init(struct a6xx_gmu *gmu)
>>>   	ret |= a6xx_gmu_rpmh_arc_votes_init(gmu->dev, gmu->cx_arc_votes,
>>>   		gmu->gmu_freqs, gmu->nr_gmu_freqs, "cx.lvl");
>>>   
>>> +	/* Build the interconnect votes */
>>> +	if (adreno_gpu->info->features & ADRENO_FEAT_GMU_BW_VOTE)
>>> +		ret |= a6xx_gmu_rpmh_bw_votes_init(info, gmu);
>>> +
>>>   	return ret;
>>>   }
>>>   
>>> @@ -1442,6 +1553,38 @@ static int a6xx_gmu_build_freq_table(struct device *dev, unsigned long *freqs,
>>>   	return index;
>>>   }
>>>   
>>> +static int a6xx_gmu_build_bw_table(struct device *dev, unsigned long *bandwidths,
>>> +		u32 size)
>>> +{
>>> +	int count = dev_pm_opp_get_opp_count(dev);
> 
> I suppose this doesn't count the opps which are not supported by the
> SKU. If we can go through *all* OPPs in the opp table irrespective of
> the SKU, we will get something close to a full DDR bw table I mentioned
> in the prevous mail.

It parses _all_ bandwitdh declared in the opp table, without any discard,
so yes we're close to a full DDR table. It only lacks a few low bandwidths.

> 
>>> +	struct dev_pm_opp *opp;
>>> +	int i, index = 0;
>>> +	unsigned int bandwidth = 1;
>>> +
>>> +	/*
>>> +	 * The OPP table doesn't contain the "off" bandwidth level so we need to
>>> +	 * add 1 to the table size to account for it
>>> +	 */
>>> +
>>> +	if (WARN(count + 1 > size,
>>> +		"The GMU bandwidth table is being truncated\n"))
>>> +		count = size - 1;
>>> +
>>> +	/* Set the "off" bandwidth */
>>> +	bandwidths[index++] = 0;
>>> +
>>> +	for (i = 0; i < count; i++) {
>>> +		opp = dev_pm_opp_find_bw_ceil(dev, &bandwidth, 0);
>>> +		if (IS_ERR(opp))
>>> +			break;
>>> +
>>> +		dev_pm_opp_put(opp);
>>> +		bandwidths[index++] = bandwidth++;
>>> +	}
>>> +
>>> +	return index;
>>> +}
>>> +
>>>   static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
>>>   {
>>>   	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>> @@ -1472,6 +1615,16 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
>>>   
>>>   	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
>>>   
>>> +	/*
>>> +	 * The GMU also handles GPU Interconnect Votes so build a list
>>> +	 * of DDR bandwidths from the GPU OPP table
>>> +	 */
>>> +	if (adreno_gpu->info->features & ADRENO_FEAT_GMU_BW_VOTE)
>>> +		gmu->nr_gpu_bws = a6xx_gmu_build_bw_table(&gpu->pdev->dev,
>>> +			gmu->gpu_bw_table, ARRAY_SIZE(gmu->gpu_bw_table));
>>> +
>>> +	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
> 
> duplicate line.
> 
>>> +
>>>   	/* Build the list of RPMh votes that we'll send to the GMU */
>>>   	return a6xx_gmu_rpmh_votes_init(gmu);
>>>   }
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> index b4a79f88ccf45cfe651c86d2a9da39541c5772b3..03603eadc0f9ed866899c95e99f333a511ebc3c1 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
>>> @@ -19,6 +19,16 @@ struct a6xx_gmu_bo {
>>>   	u64 iova;
>>>   };
>>>   
>>> +#define GMU_MAX_BCMS	3
>>> +
>>> +struct a6xx_bcm {
>>> +	char *name;
>>> +	unsigned int buswidth;
>>> +	bool fixed;
>>> +	unsigned int perfmode;
>>> +	unsigned int perfmode_bw;
>>> +};
>>> +
>>>   /*
>>>    * These define the different GMU wake up options - these define how both the
>>>    * CPU and the GMU bring up the hardware
>>> @@ -82,6 +92,10 @@ struct a6xx_gmu {
>>>   	unsigned long gpu_freqs[16];
>>>   	u32 gx_arc_votes[16];
>>>   
>>> +	int nr_gpu_bws;
>>> +	unsigned long gpu_bw_table[16];
>>> +	u32 gpu_bw_votes[16][GMU_MAX_BCMS];
>>> +
>>>   	int nr_gmu_freqs;
>>>   	unsigned long gmu_freqs[4];
>>>   	u32 cx_arc_votes[4];
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>>> index 4aceffb6aae89c781facc2a6e4a82b20b341b6cb..5b80919e595fa1ba0a3afcca55feb89e60870cb1 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
>>> @@ -44,6 +44,7 @@ struct a6xx_info {
>>>   	u32 gmu_chipid;
>>>   	u32 gmu_cgc_mode;
>>>   	u32 prim_fifo_threshold;
>>> +	const struct a6xx_bcm bcm[GMU_MAX_BCMS];
> 
> This table is duplicated a lot. Lets keep a pointer instead. We can probably use
> this pointer as a flag to check for GMU_IB_VOTE support too.

It's partially duplicated, basically only the permode bits and level is different.

We can move it out when we support more GPUs with this feature.

Neil

> 
> -Akhil
> 
>>>   };
>>>   
>>>   struct a6xx_gpu {
>>>
>>> -- 
>>> 2.34.1
>>>


