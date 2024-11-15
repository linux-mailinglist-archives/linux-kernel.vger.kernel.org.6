Return-Path: <linux-kernel+bounces-410408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074129CDB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8876C1F213BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E018EFD4;
	Fri, 15 Nov 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFRMIw/e"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA016D9DF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661875; cv=none; b=gf805CuHZ2xth89agnwcjbMTAHnSBUXgwHxmOpw5ynMhkqafMX2V27wKCwNq3bcRgPF3RJWAP6EEivSBcmDr29+4jPKY87itl2DTOyB+zN1qgVRzFhPYrNBO4CUvqn1Aw5DpA1DWJssBkHd6EeQyCrrlPOTT6N8HzAOYNrqLpBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661875; c=relaxed/simple;
	bh=9XIU4TEpDEtWO3ZEkQkqbHdt8iXIY8tW7dTBpHJFCh4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eagswLaArQ6JLA6/bhzQUeHuxX7GDbY3o/XvQij5lahvJGiWYG806Ny/zWlaVFywQTgNo9s1jzGmeNGn57lpt8EXAV4BYT+w8wn5iBc0T9RGJJJI982I6yv534lx0QLEZLer40YQPrxkmFCBH7uQthpZHm4dRxahLM0Ml5CyTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFRMIw/e; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382171fe8b1so980181f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731661871; x=1732266671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vpXoiXhLMF3td8sRQvEmRzRVckuoAGxk/B3yXzMi9U=;
        b=xFRMIw/eKeNBm3vxPyvJe9cMmfGoMrsH98k+GArIjEFuJkg/P5Sp+3FM39yrXsjyjS
         xzPg2VTNiwbBSjTsBxtUBqppbbN44fifCNl29C1QLKdwidg811uPNa9yN09rOsM++VS6
         oHw7gJskQPDELOeZ2uyURZsSkkl1x7gLqSHLcp1a7GAdx+LBHJR7jXtFh8LtOVjFu8fH
         amWk+hFW5OiYXfgINohJVPvUBnMgOdXwJ3f3ltkhlqLOa0XHwnUgbPXl34x0MyRcZIgZ
         jb4v3rE+9cx9ysGzIbVcO3R7Tjo4BCeWpnD4lUvSyvKuIFIUD3iAc9y4P2ASS0WF+D7n
         MCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661871; x=1732266671;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9vpXoiXhLMF3td8sRQvEmRzRVckuoAGxk/B3yXzMi9U=;
        b=AagOuSh+T9cvQih0Vjrgtk3bhTQv+CqiVE9tz24Ggo8aq8+eh4Ug4tXdbw+hVe7gPK
         i5/8yAcsSdCV+FrlT2j9m59fI5QlZHtAi7KKoknsb6b1xpHvH6GFKKxIQHBtVSwCv4iK
         /tRQjlxHl8cl+BD2K6/JIW4iXTbc0tRubMHJPJWG83BgE9VZtJevx0ocz4Yx29mZOlGa
         UeSJ6I/fJad+A+PUDfPIO85puJUJRzBNixRJcixELvJg3cikEXoGe/0cv/N5uIXipPzy
         J73+GxlklvkLivzeWc7vJOBgdg+/c/sJLzDuz/P302a1Xvh89dSApYT+YQopFj4nVcuB
         8LdA==
X-Forwarded-Encrypted: i=1; AJvYcCUljiLO1ee/ZW//Mi1H6xIi0jiWycg6MZUVcp13xbDEnWjbYf305LfKI/dnW3JuHHz7JyxG1hI3OBv/tRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkZ8oZHSkbcX5PXBYhMyOkKnAe8OX8jBoK588fbOzEMpu1FZW
	hOLaGD9M3cx4ZebTqhmxGnMGn1DTmH9zDuj9m+TLX2nOEQW0dkEf0NOWGwmOofk=
X-Google-Smtp-Source: AGHT+IFieFfvih4A4DPrMQVGXmpc94cqEsfn4+XNZLdxbJDkvd6N1Dhs/fUVu8kYNuTyQ9Q9pX341A==
X-Received: by 2002:a05:6000:2cf:b0:37d:3780:31d2 with SMTP id ffacd0b85a97d-38214022129mr5684419f8f.15.1731661870728;
        Fri, 15 Nov 2024 01:11:10 -0800 (PST)
Received: from [192.168.7.189] ([212.114.21.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adadf8fsm3794456f8f.39.2024.11.15.01.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 01:11:10 -0800 (PST)
Message-ID: <17243670-7e91-46f8-812d-3f21cee5cd2c@linaro.org>
Date: Fri, 15 Nov 2024 10:11:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 4/8] drm/msm: adreno: dynamically generate GMU bw
 table
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-4-3b8d39737a9b@linaro.org>
 <rvfrkb4v7cilzu3prv5dr2dni7m3jv3crhmto3uume5v5wxr5m@apvyb4lc2rre>
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
In-Reply-To: <rvfrkb4v7cilzu3prv5dr2dni7m3jv3crhmto3uume5v5wxr5m@apvyb4lc2rre>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/11/2024 08:24, Dmitry Baryshkov wrote:
> On Wed, Nov 13, 2024 at 04:48:30PM +0100, Neil Armstrong wrote:
>> The Adreno GPU Management Unit (GMU) can also scale the ddr
>> bandwidth along the frequency and power domain level, but for
>> now we statically fill the bw_table with values from the
>> downstream driver.
>>
>> Only the first entry is used, which is a disable vote, so we
>> currently rely on scaling via the linux interconnect paths.
>>
>> Let's dynamically generate the bw_table with the vote values
>> previously calculated from the OPPs.
> 
> Nice to see this being worked upon. I hope the code can is generic
> enough so that we can use it from other adreno_foo_build_bw_table()
> functions.

I would hope so, but I don't have the HW to properly test it on those
platforms.

> 
>>
>> Those entried will then be used by the GMU when passing the
>> appropriate bandwidth level when voting for a gpu frequency.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 48 +++++++++++++++++++++++++++--------
>>   1 file changed, 37 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> index cb8844ed46b29c4569d05eb7a24f7b27e173190f..9a89ba95843e7805d78f0e5ddbe328677b6431dd 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> @@ -596,22 +596,48 @@ static void a730_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>>   	msg->cnoc_cmds_data[1][0] = 0x60000001;
>>   }
>>   
>> -static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>> +static void a740_generate_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
>> +				   struct a6xx_hfi_msg_bw_table *msg)
>>   {
>> -	msg->bw_level_num = 1;
>> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>> +	unsigned int i, j;
>>   
>> -	msg->ddr_cmds_num = 3;
>>   	msg->ddr_wait_bitmask = 0x7;
>>   
>> -	msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
>> -	msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
>> -	msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
>> +	for (i = 0; i < 3; i++) {
>> +		if (!info->bcm[i].name)
>> +			break;
>> +		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcm[i].name);
>> +	}
>> +	msg->ddr_cmds_num = i;
>>   
>> -	msg->ddr_cmds_data[0][0] = 0x40000000;
>> -	msg->ddr_cmds_data[0][1] = 0x40000000;
>> -	msg->ddr_cmds_data[0][2] = 0x40000000;
>> +	for (i = 0; i < gmu->nr_gpu_bws; ++i)
>> +		for (j = 0; j < msg->ddr_cmds_num; j++)
>> +			msg->ddr_cmds_data[i][j] = gmu->gpu_bw_votes[i][j];
>> +	msg->bw_level_num = gmu->nr_gpu_bws;
>> +}
>> +
>> +static void a740_build_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
>> +				struct a6xx_hfi_msg_bw_table *msg)
>> +{
>> +	if ((adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE) && gmu->nr_gpu_bws) {
>> +		a740_generate_bw_table(adreno_gpu, gmu, msg);
>> +	} else {
> 
> Why do we need a fallback code here?

Because at this particular commit, it would generate an invalid table, I should probably remove the fallback at the end

> 
>> +		msg->bw_level_num = 1;
>>   
>> -	/* TODO: add a proper dvfs table */
>> +		msg->ddr_cmds_num = 3;
>> +		msg->ddr_wait_bitmask = 0x7;
>> +
>> +		msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
>> +		msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
>> +		msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
>> +
>> +		msg->ddr_cmds_data[0][0] = 0x40000000;
>> +		msg->ddr_cmds_data[0][1] = 0x40000000;
>> +		msg->ddr_cmds_data[0][2] = 0x40000000;
>> +
>> +		/* TODO: add a proper dvfs table */
> 
> I think TODO is unapplicable anymore.
> 
>> +	}
>>   
>>   	msg->cnoc_cmds_num = 1;
>>   	msg->cnoc_wait_bitmask = 0x1;
>> @@ -691,7 +717,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>>   	else if (adreno_is_a730(adreno_gpu))
>>   		a730_build_bw_table(msg);
>>   	else if (adreno_is_a740_family(adreno_gpu))
>> -		a740_build_bw_table(msg);
>> +		a740_build_bw_table(adreno_gpu, gmu, msg);
>>   	else
>>   		a6xx_build_bw_table(msg);
>>   
>>
>> -- 
>> 2.34.1
>>
> 


