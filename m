Return-Path: <linux-kernel+bounces-573613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F8A6D9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8DE18887B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3325E80B;
	Mon, 24 Mar 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kk5JJ1O/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54DA2C80
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818060; cv=none; b=XbeKEY5Mx/ENDFdaNjI/Hl3FSsJatwS0kZ87npRhhdi+mzW7/CuCIr6M/qb3KIx9ed8rZnOSqYha4QO9xgVTl0vOE1wRmbcXXdMGCx5smBFZQVFPsEGQygdZBBjNtTICrJby7GMY1W+imbO2+920TP6yn7/84nmg70LdYVD9PQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818060; c=relaxed/simple;
	bh=d+ERUfYUYXaHGdBYuF3rKlVUr8YO7jNuYOdQfOGGZAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh/T659fSfSkv04p0+fL3Ib4B/EUse/0mJn5IQC1Pe/p/Xskx/MCmtJYvdvHpvjF8h1YjNPWSf1DfLVb0ZIRDXXON/f8kZ/v09NwxoMtY3Lvhp2vRvEUOAYEy01N+RL90sn26CcO5srHYWiLJWqzYXbyy+5fXqa4wQPEeKpqEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kk5JJ1O/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PRV1018433
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KcNnIDZwpmq1ce+wE7q/iQpaLgG583laB+g/tlbWzZE=; b=kk5JJ1O/orPMLRGy
	1P4BQy7zZRscFTBJCX9rZSU3ka/ZudLWGUzBKWUTVYjZv6uWh4XNUCJm8VPz1Kl5
	HewZ5OCI3bDGKmtcXlAun3VgPEoXpXgLygFkjgt787KgWlSZnYkbH110gTY/EYvs
	tCNH5eH9T+CbLet29pEECdQQ3b1/xAUa/ypsop2QIX9mVLX8J/3ww6Gg2T4+B+Dd
	d60dUYor63YnlY95jZ7pj0iZeEzJzGKjwiPSplnhgGdGTH7ELAm8990q7uhpe4+C
	nr+knJqwfBZ9uOYINRNb7HylSSfRWsNmtHKkDfqL5do2PYTXcFPwxcIaXdUX7hSm
	Oj5PUA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hne5v9j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:07:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d608e6f5so97061185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818055; x=1743422855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcNnIDZwpmq1ce+wE7q/iQpaLgG583laB+g/tlbWzZE=;
        b=ukgp1RheIpkNZ+zUNrxl/N4PIX1+4QvlowvKwauqt03R7CIJzNAHa0LRezoRjo9A9P
         w6xgNk2KMolQul1MffmCtdplFrh1DuRO9ptKI13/qcpZJizXTKl0yQ4G0TvjdRhkm2I9
         2i4BS2kS77ZUYwB2dOvtxN4al+3RJMk33Bs1Tcp8ugqy21o+NNlwI7ReHqsS8YEcXvmF
         WDKOGZO8d897H5FvcqeuD8ynQiZZvyP3PzALNe8jU6LviAnRn3xU+o5D4lLt3TGnZuuF
         WX5nVautTjWFkK/T2X5X7c9GtM/i98336W9kjJG4sGHsN2GADed3hN4PZoGt37aJn7OZ
         QgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPbkHK51MoCRE+yYssrx7jRt6iziNRpXLy22csG5Dv4DfE0/ynGwyGJCsrhIb4eSKgrjye2yXWAS+CsOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0Kp1W2OseYGHqFHXqsKJ2JcEmHjujr53Rq1rA+Y+C3/FDeeS
	uBvf8W7wI9iVTXy4AX5FeOJvh4RrtRdGEPw+jw0S0SY+kZsMlnsGmrulRo6u0BVJZwTFvyo53sP
	2+uDJiLXCBmxGS477XXO7/9/jv+Tlsmeqj7BVgB/RK5pkztE2E+eM7qJE/Rvnc98=
X-Gm-Gg: ASbGnctGx0d6npUjEIeqQGVGN0gTxRkwFCx5rsNWY6tTOo5ulb78pZmff9vNUD9jp5I
	3O2GHBd408AUTFM91jcpddS6Z/I6lUd97Q7b7Q9Y5h5KPqGqaEHks5DoZEpfXy6JYCkGP0aIwFk
	QKHMpIF32Kv6nc1w7WRbRt7rFotclizQHDSg6TodfEySgTfrQS43RQG48guX28md0DpoQnKFeDu
	Viz6teaQv1FfInFnHd3eNkiMpWF/pO5Bl8iOBhO8gmS0Ct0Z+6t3v+XqaqhL9zgCoeCk6XIaVQN
	vpVirPHxHSW0Yb9BvLOtsmHnZgZz3Zul1O5/3xY1L33Qqe7U1n204ab9dduh4r9CZ2kSifD9IXi
	C1vDLWNuuK0MX+zzRV9YYI4Ifog8MUVS6aNiP69L4Dkug3kE/in576jsLdRNyfXl055Nn
X-Received: by 2002:a05:620a:2441:b0:7c5:4a3a:bc0c with SMTP id af79cd13be357-7c5ba15c1damr2165459585a.13.1742818055137;
        Mon, 24 Mar 2025 05:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFhIJWCTAFRmJHVjzOLt//XwWxwcokHLD+xNo6A/E+ghzq26u2WkWcaFs6XOnrgmBembXkaA==
X-Received: by 2002:a05:620a:2441:b0:7c5:4a3a:bc0c with SMTP id af79cd13be357-7c5ba15c1damr2165453485a.13.1742818054608;
        Mon, 24 Mar 2025 05:07:34 -0700 (PDT)
Received: from ?IPV6:2001:14bb:11c:bb1f:bc99:5dd2:1e47:705? (2001-14bb-11c-bb1f-bc99-5dd2-1e47-705.rev.dnainternet.fi. [2001:14bb:11c:bb1f:bc99:5dd2:1e47:705])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6480ed6sm1110751e87.103.2025.03.24.05.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:07:32 -0700 (PDT)
Message-ID: <fbc72787-6c98-48b4-a176-8d1b03815085@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 14:07:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, peda@axentia.se,
        broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
        zhoubinbin@loongson.cn, paulha@opensource.cirrus.com,
        lgirdwood@gmail.com, robh@kernel.org, conor+dt@kernel.org,
        konradybcio@kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org,
        Christopher Obbard <christopher.obbard@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
 <20250324110606.32001-6-srinivas.kandagatla@linaro.org>
 <7fc622e8-6f9d-4a14-bf5f-3122e6f81808@oss.qualcomm.com>
 <ac58b70a-b53a-4c91-8483-1b870623d5e9@linaro.org>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <ac58b70a-b53a-4c91-8483-1b870623d5e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mXG8fEEFTUlZuBreV3isCkgzZegMPpwV
X-Proofpoint-ORIG-GUID: mXG8fEEFTUlZuBreV3isCkgzZegMPpwV
X-Authority-Analysis: v=2.4 cv=JvPxrN4C c=1 sm=1 tr=0 ts=67e14b08 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=q6AXoensFbzIEcXt33sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=978
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240088

On 24/03/2025 14:04, Srinivas Kandagatla wrote:
> 
> 
> On 24/03/2025 11:20, Dmitry Baryshkov wrote:
>> On 24/03/2025 13:06, srinivas.kandagatla@linaro.org wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> On some platforms to minimise pop and click during switching between
>>> CTIA and OMTP headset an additional HiFi mux is used. Most common
>>> case is that this switch is switched on by default, but on some
>>> platforms this needs a regulator enable.
>>>
>>> move to using mux control to enable both regulator and handle gpios,
>>> deprecate the usage of gpio.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
>>> ---
>>>   sound/soc/codecs/Kconfig   |  1 +
>>>   sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>>>   2 files changed, 31 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>> index ee35f3aa5521..a2829d76e108 100644
>>> --- a/sound/soc/codecs/Kconfig
>>> +++ b/sound/soc/codecs/Kconfig
>>> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>>>       tristate
>>>       depends on SOUNDWIRE || !SOUNDWIRE
>>>       select SND_SOC_WCD_CLASSH
>>> +    select MULTIPLEXER
>>>   config SND_SOC_WCD938X_SDW
>>>       tristate "WCD9380/WCD9385 Codec - SDW"
>>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>>> index dfaa3de31164..948b5f6cc45a 100644
>>> --- a/sound/soc/codecs/wcd938x.c
>>> +++ b/sound/soc/codecs/wcd938x.c
>>> @@ -19,6 +19,7 @@
>>>   #include <linux/regmap.h>
>>>   #include <sound/soc.h>
>>>   #include <sound/soc-dapm.h>
>>> +#include <linux/mux/consumer.h>
>>>   #include <linux/regulator/consumer.h>
>>>   #include "wcd-clsh-v2.h"
>>> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>>>       int variant;
>>>       int reset_gpio;
>>>       struct gpio_desc *us_euro_gpio;
>>> +    struct mux_control *us_euro_mux;
>>> +    u32 mux_state;
>>>       u32 micb1_mv;
>>>       u32 micb2_mv;
>>>       u32 micb3_mv;
>>> @@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct 
>>> snd_soc_component *component)
>>>       wcd938x = snd_soc_component_get_drvdata(component);
>>> -    value = gpiod_get_value(wcd938x->us_euro_gpio);
>>> +    if (!wcd938x->us_euro_mux) {
>>> +        value = gpiod_get_value(wcd938x->us_euro_gpio);
>>> -    gpiod_set_value(wcd938x->us_euro_gpio, !value);
>>> +        gpiod_set_value(wcd938x->us_euro_gpio, !value);
>>
>> Is it possible to use mux_state for both GPIO and MUX paths?
> 
> Ideally I would like to do that the way that gpio is done, which is 
> clear reflection of hw state, however mux f/w is lacking such api.

Anyway, both paths should use the same flow.

> 
> 
>>
>>> +    } else {
>>> +        mux_control_deselect(wcd938x->us_euro_mux);
>>> +        wcd938x->mux_state = !wcd938x->mux_state;
>>> +        if (mux_control_select(wcd938x->us_euro_mux, wcd938x- 
>>> >mux_state))
>>> +            dev_err(component->dev, "Unable to select us/euro mux 
>>> state\n");
>>
>> This can lead to mux being deselected next time even if the 
>> mux_control_select returned an error. I think mux_control API needs a 
>> way to toggle the state without deselecting it first. Anyway, an error 
>> from mux_control_select() must prevent you from calling 
>> mux_control_deselect() next time.
> 
> We can rearrange deselect to be done only on successful select, that 
> should cleanup some of this.

Yes, please.

> 
> --srini
>>
>>> +    }
>>>       return true;
>>>   }
>>
>>


-- 
With best wishes
Dmitry

