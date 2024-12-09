Return-Path: <linux-kernel+bounces-437765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16EC9E985F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB44283DF5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983A1B0432;
	Mon,  9 Dec 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuYQSyf5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877863596F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753224; cv=none; b=EPQdxaO3JY4ClbBacgW1GfU3tTPVJf46Oh+zGCvfWLSP261Wze3tl87siEhL7YZ8aLkxlOMBUY9d+ea7AXq4F+9ftDvdngNz/2XRbdhWho0utk5cmHYLnD+OQ7/1TMjRJt3+SYOwbyFlUebj3LcNbiKIYSm63yyDdzFb0qNIS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753224; c=relaxed/simple;
	bh=51L9mnqIr29+7FShCAtxvhKSMRLPZlq2oBjN+kgy8PE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G32HdQwVBV1qqdzb8GQ8fwf4STjHkBbRJGw6JJUMP62ROF7L8jcUXxQHwPuT/yOgJct0WJ+IuFNal7F/uBgWYLmL90f3E4E0bDtTNmMS7sM8rrsG84BZ6/cp1AhKN334EuSE8ztUuy/It9x5Xe1J2bA8zOC2/fd15+K0hytvZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zuYQSyf5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385deda28b3so3437587f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733753221; x=1734358021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TL2MbMVS0LA1fcrVHWeYCb3ppOpM6kJxBQgdxTKNEc=;
        b=zuYQSyf5mv6IhLob/w+0qLuOE82F0C2H9ro7QNHd11R4/1aWNhjOAHi6AwMpAtQuy5
         JxJKHT2LnSSTwzpX4upjdny00bABRln6h+0BL43f7Wkc6S9B5A2hODsZ1/Lx8E10B1tn
         XOJeFNteZImM3vjp2Lp3L7/UnWArtR+uszdY/KlgdNvkcu5u9DE0N288YQqSpBpqVG4C
         8/r4eQJCJNM0TepDsBdctQOw9pBqhUXvEhzVoaK81xwUppuTTbLm4Mg6Xd56hEhp6mym
         3+BHVHRcowITtqCJrOaiKRNcnbfrSRMrLlZJxFHwFb1mw4FcKDPiVZI6twKH2E6xv3RY
         LH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753221; x=1734358021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8TL2MbMVS0LA1fcrVHWeYCb3ppOpM6kJxBQgdxTKNEc=;
        b=KGnURiWo2mGumJENujiWXPj5Hhk6sDKcfmR2vaub1kneZikWdLcgZ0Uuq4hud56kxD
         niLaYCCNK4kfU/8EgpgGh27ykWMANZB2NSjwLp3P1MHCeHMe2LowzW+ALWEx3U8rbbtk
         KMzQDRfH2qVjBnwp1yQu5d9BI2aYUEtWKtBdb3/2Ok8r87vGXRczV2QaCz97/ceZzNz/
         hsCBE/4IGpG5omKUXVzNYCYJ5qhRdYe6LbF3OJZE1lX9nwwIT6852clP9tCPl3iNYb6N
         8mgjtn7uFVs149hFrM6Xa8n5BHdy22QAgj4cc81anvBmtJN57LQWiburoocRPK+bftRJ
         SetQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMna3EJuHrom9lCH9iIT/lv9zkwxGMDnDQZRKSZXOPPr/p68g3xdunO3Lz6jvfITOHtwlGOgQ8e4Uxks0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAVpnB3XgJexZdcgChcnSbfrlIIUPmChQn/+u78aXuaCm3QDV
	GR3NRHk4F/+aKdTPlneqM6w3N93ZnMJs828FlaCqVGDP90xgUeQ4BcmJKvpjNSQ=
X-Gm-Gg: ASbGnctG8zTRu64Gae0GYu8Ri+SoQTOI9R5jPyYy2Q5I5O2L6YKLr5mHYwWysRtsqlp
	wbg0RbUtaKN2Zm/yyxtBeYSrsbLhNvIK6SM+iyWJszwV9lwlfLAGf9E4iG3DdBIolADnjO7yobN
	wm76ZwZDwsUAwPpY0YOannQGtDrr+TMXg0TtJPTU44QeblbsEeaDrkb0cG+b6bhc9jNCZ4cA5ht
	Y41je1/2rqRkoHhHk9RC1vfk4leTx7mAnSkXbW04REYQjN5QRzziX2gFtUG7KztaxQf2P288hXf
	w+5WBlR5KFsZ1d12CgS9WKmmsuk=
X-Google-Smtp-Source: AGHT+IGucCc+D0VX2jp79Smo7afxqpLhOYHKy/vpIQDIDF/vHEETnS6x9UlrTj3Drk16mX0zQ4F1EQ==
X-Received: by 2002:a05:6000:400c:b0:386:3560:477f with SMTP id ffacd0b85a97d-386356049e3mr6090376f8f.23.1733753220814;
        Mon, 09 Dec 2024 06:07:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7546:6147:f006:709b? ([2a01:e0a:982:cbb0:7546:6147:f006:709b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eb775350sm85048115e9.5.2024.12.09.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:07:00 -0800 (PST)
Message-ID: <c1eacaa5-f51f-4e6b-8848-3fdb065aab19@linaro.org>
Date: Mon, 9 Dec 2024 15:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 3/7] drm/msm: adreno: dynamically generate GMU bw table
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, Rob Clark
 <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
 <20241205-topic-sm8x50-gpu-bw-vote-v4-3-9650d15dd435@linaro.org>
 <93ed4511-55b5-42a9-a3fe-32f29bd01bab@quicinc.com>
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
In-Reply-To: <93ed4511-55b5-42a9-a3fe-32f29bd01bab@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/12/2024 13:11, Akhil P Oommen wrote:
> On 12/5/2024 8:31 PM, Neil Armstrong wrote:
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
>>
>> Those entries will then be used by the GMU when passing the
>> appropriate bandwidth level while voting for a gpu frequency.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 41 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> index cb8844ed46b29c4569d05eb7a24f7b27e173190f..fc4bfad51de9a3b6617fbbd03471a5851d43ce88 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
>> @@ -5,7 +5,10 @@
>>   #include <linux/circ_buf.h>
>>   #include <linux/list.h>
>>   
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>> +
>>   #include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/tcs.h>
>>   
>>   #include "a6xx_gmu.h"
>>   #include "a6xx_gmu.xml.h"
>> @@ -259,6 +262,39 @@ static int a6xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
>>   		NULL, 0);
>>   }
>>   
>> +static void a6xx_generate_bw_table(const struct a6xx_info *info, struct a6xx_gmu *gmu,
>> +				   struct a6xx_hfi_msg_bw_table *msg)
>> +{
>> +	unsigned int i, j;
>> +
>> +	msg->ddr_wait_bitmask = QCOM_ICC_TAG_ALWAYS;
> 
> Why this is QCOM_ICC_TAG_ALWAYS?
> 
> IIRC, this bitmask informs RPMH whether it should wait for previous BCM
> vote to complete. Can we implement the same logic from kgsl to create
> this bitmask?

Ack, Let me check

> 
> 
>> +
>> +	for (i = 0; i < GMU_MAX_BCMS; i++) {
>> +		if (!info->bcms[i].name)
>> +			break;
>> +		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcms[i].name);
>> +	}
>> +	msg->ddr_cmds_num = i;
>> +
>> +	for (i = 0; i < gmu->nr_gpu_bws; ++i)
>> +		for (j = 0; j < msg->ddr_cmds_num; j++)
>> +			msg->ddr_cmds_data[i][j] = gmu->gpu_ib_votes[i][j];
>> +	msg->bw_level_num = gmu->nr_gpu_bws;
>> +
>> +	/*
>> +	 * These are the CX (CNOC) votes - these are used by the GMU
>> +	 * The 'CN0' BCM is used on all targets, and votes are basically
>> +	 * 'off' and 'on' states with first bit to enable the path.
>> +	 */
>> +
>> +	msg->cnoc_cmds_num = 1;
>> +	msg->cnoc_wait_bitmask = QCOM_ICC_TAG_AMC;
> 
> Same here.
> 
> Rest looks fine to me.

Thanks,
Neil

> 
> -Akhil
> 
>> +
>> +	msg->cnoc_cmds_addrs[0] = cmd_db_read_addr("CN0");
>> +	msg->cnoc_cmds_data[0][0] = BCM_TCS_CMD(true, false, 0, 0);
>> +	msg->cnoc_cmds_data[1][0] = BCM_TCS_CMD(true, true, 0, BIT(0));
>> +}
>> +
>>   static void a618_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
>>   {
>>   	/* Send a single "off" entry since the 618 GMU doesn't do bus scaling */
>> @@ -664,6 +700,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>>   	struct a6xx_hfi_msg_bw_table *msg;
>>   	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
>>   	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
>> +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
>>   
>>   	if (gmu->bw_table)
>>   		goto send;
>> @@ -672,7 +709,9 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
>>   	if (!msg)
>>   		return -ENOMEM;
>>   
>> -	if (adreno_is_a618(adreno_gpu))
>> +	if (info->bcms && gmu->nr_gpu_bws > 1)
>> +		a6xx_generate_bw_table(info, gmu, msg);
>> +	else if (adreno_is_a618(adreno_gpu))
>>   		a618_build_bw_table(msg);
>>   	else if (adreno_is_a619(adreno_gpu))
>>   		a619_build_bw_table(msg);
>>
> 


