Return-Path: <linux-kernel+bounces-253502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439693222B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC5F1F22F4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C7519538D;
	Tue, 16 Jul 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocDw7hfw"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5817B031
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119556; cv=none; b=m7sCKzZt4WYXJS/BaMDMEuCBCsAixRaAozBTdMTFlJkylb+P+SUdb031RCVGum/JTARlqXOZ66dlMRpy73wt4hfkkZ6a+JhII/G1ly9xIYEOgV1GXCTtN/qoMmzpMDvdW/s/uItRxp/id/+H/7WjZo9hbmYVStdJ9qyUhf8aL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119556; c=relaxed/simple;
	bh=X5aozxsgQPt0Z9u6SRxwxtxCCCmMBtxOA/XYiClzMnI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KSCa8BJ2hhV7MN7SA3nEVxw4HrYEzbp34qcneenfBdtHIV7azKdJ6C+OW55yGsed6HOZA5zrPNBcyStSVTnO5opc9o1UyPgM/y8xGbjoUdmrUX+4y75jWcwnig4bVfyZMMj+MFMr3F38c7ilEM7iBtux9WSXfxjWnJGwIIx1jGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ocDw7hfw; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367a464e200so3198534f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721119553; x=1721724353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Od8eoem5ZvtrMl3ot96NWevDW1Y3aItVShfEvpSJQ0U=;
        b=ocDw7hfwP+jpyZneVq8XHnJDcm4RvYuB6oLgGDDVRUONS/RRogTHRBO36cyTinj8hX
         MTh89aHnFelkmoE+veGASzVV8wX0Uo9efz6/0pzGO3QjY8P3KjPDJuQRu3lvxWtoBbvg
         xWv5Viya0ST78yYDltaWS6Z3ik1zwx4j8J6m3DXw+sRc3rsH/oxmTDm3qp7zWDOHCLz2
         mbCvtQfcc/l56bMM/Gfu8wNnwM+A71eN6P4cuQgYavyXO5+3AWjbA+0mgd+Aq8SYCADD
         kNT7iReBV8Zq8sFWpY3TGDKq2eE+g/Fy+fom+vsxBbdVEnHIXIKYVF1ViH2RTrCh7QsV
         Rbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721119553; x=1721724353;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Od8eoem5ZvtrMl3ot96NWevDW1Y3aItVShfEvpSJQ0U=;
        b=Df66vTqZed8Klk1yhqHtqi8m3C4MibUhPMeSWdjtmhC5dOTWEOXdVr1liiNyYhMxNN
         oy2Fbiec1ptYwF1wcNgI1RQJlqZ/tn/eCMs4aHLGy2EKSD9UA4Nsg6fpiyjM32+lJr5L
         j2zEgZQpTARcrNapiSbppyDJvCEPn0b49PeXYHYiwdbtJu8Mcvua2BVlTq1xDAmpTvIH
         4JS9xlybPjoVfs6TbeeBosRMV6NwLv59qetfio7OGPr9Wa9fuXr9pIqRgiUo3t81BwNG
         1/5YaQJYYC2Cs/QQnAmHG2P8INW7+pVxvqPbRZFp8q9U0Hzk0ky0GGb5Tg0HO9XAcWGQ
         Bdiw==
X-Forwarded-Encrypted: i=1; AJvYcCXqmmg489Ibyp34BVaN6PeO9zN7qsshm89whk+KX2uYUik5KRl7V/Od3EWSSPlY/lwJg0jUfeLhten7avtXiCHnKHEmHMifc0wg6+9i
X-Gm-Message-State: AOJu0Yx3BBVlXITZoI1qZQt33irk1PVzBai5pm+DrZ80UnxDEZxeVEN9
	VcOLnhcoTtlkuJ2SMxFK2Y/x1k1iKCft2irYi94UNgmjFMcTyUCFa+Vg0fLdve4=
X-Google-Smtp-Source: AGHT+IEoLoBkY3NE+Yk4hRQ8Tyy/whLpLhzHEnpcyct1yrPP88x3jqK2vAE1K9KvDTgA+saot+i+CQ==
X-Received: by 2002:a5d:4a46:0:b0:367:9625:bd05 with SMTP id ffacd0b85a97d-368261051cemr867962f8f.15.1721119553131;
        Tue, 16 Jul 2024 01:45:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197? ([2a01:e0a:982:cbb0:f5ba:a94c:e43a:d197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e77493sm116329675e9.7.2024.07.16.01.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 01:45:52 -0700 (PDT)
Message-ID: <ed8e519d-2b02-47a4-ac2b-9ae341b2ef88@linaro.org>
Date: Tue, 16 Jul 2024 10:45:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/3] clk: qcom: dispcc-sm8650: Park RCG's clk source at
 XO during disable
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-topic-sm8650-upstream-fix-dispcc-v2-0-ddaa13f3b207@linaro.org>
 <20240624-topic-sm8650-upstream-fix-dispcc-v2-1-ddaa13f3b207@linaro.org>
 <4skm6zab2xf2e4qgh4l45xzhuncmls7yfw4y77yufb7pvs2zew@rmzcgb6ozamf>
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
In-Reply-To: <4skm6zab2xf2e4qgh4l45xzhuncmls7yfw4y77yufb7pvs2zew@rmzcgb6ozamf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2024 11:25, Dmitry Baryshkov wrote:
> On Mon, Jun 24, 2024 at 10:05:50AM GMT, Neil Armstrong wrote:
>> The RCG's clk src has to be parked at XO while disabling as per the
>> HW recommendation, hence use clk_rcg2_shared_ops to achieve the same.
>>
>> It also changes dptx1_aux_clk_src to use the correct ops instead of
>> clk_dp_ops.
>>
>> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/clk/qcom/dispcc-sm8650.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/dispcc-sm8650.c b/drivers/clk/qcom/dispcc-sm8650.c
>> index c9d2751f5cb8..360b80377ed6 100644
>> --- a/drivers/clk/qcom/dispcc-sm8650.c
>> +++ b/drivers/clk/qcom/dispcc-sm8650.c
>> @@ -339,7 +339,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
>>   		.parent_data = disp_cc_parent_data_0,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>> @@ -398,7 +398,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_aux_clk_src = {
>>   		.parent_data = disp_cc_parent_data_0,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_dp_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>> @@ -457,7 +457,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_aux_clk_src = {
>>   		.parent_data = disp_cc_parent_data_0,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>> @@ -516,7 +516,7 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_aux_clk_src = {
>>   		.parent_data = disp_cc_parent_data_0,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
> 
> The only parent for these three clocks is the DT_BI_TCXO. Is this really
> going to work as expected? Also what's the point of parking the
> TCXO-sourced clocks?
> 

Indeed will drop

Thanks,
Neil

>>   
>> @@ -560,7 +560,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
>>   		.parent_data = disp_cc_parent_data_5,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>> @@ -575,7 +575,7 @@ static struct clk_rcg2 disp_cc_mdss_esc1_clk_src = {
>>   		.parent_data = disp_cc_parent_data_5,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>> @@ -647,7 +647,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
>>   		.parent_data = disp_cc_parent_data_0,
>>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
>>   		.flags = CLK_SET_RATE_PARENT,
>> -		.ops = &clk_rcg2_ops,
>> +		.ops = &clk_rcg2_shared_ops,
>>   	},
>>   };
>>   
>>
>> -- 
>> 2.34.1
>>
> 


