Return-Path: <linux-kernel+bounces-573556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D3A6D90C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA41C16CF86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FAB1E0DB3;
	Mon, 24 Mar 2025 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8TzlJhp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5118DB02
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742815253; cv=none; b=Tb3emAnRbkDQSSX63MMPnwhyvrcsqN28YostTJxlPW/Da5xemyk6biU1GbBoffOqTjYEH4hVj8pmaozdkz59o0yuDg9nCkKuzKEeopTld4P3muSsmcxo6ZTbQKaOjUQkQhZSS7tWTBCxbYWYAJqcYLVGeydQ9zkQGUUhd3YDOR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742815253; c=relaxed/simple;
	bh=hyOqZJxorcLzIQqbVwfmpBHHqLRW4jToxdkY5UTNu34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEuQ7Ck5Bj56UB7gFa5oWA5iZ//FeSN70EmYIf/YPT00UJc3Ot99xeiFExrU989RxbwqYENCXdxSaY+uRLd9hXyy26zAvQqyvkAf3T7Xvp3V2Gl7gwWcb1RdeQ5GkbJYXIH4CK9rgwrMRrqHG1HYmV2UYRVOXHjD4YT/J42mr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8TzlJhp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PLvo004138
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Omyzt0+3s9T/Lcy+ZIwCMHKO6499mJSDlZjjA79KkE=; b=T8TzlJhpRfkH16Vz
	wrPOxndYKlsRmNku4cy1s7bcBH/L97bxfiHOXDYt7Dl+13qRv885jOdAXnZjrJja
	be4lomLSqKDbAz2klZTA7tFVfEydTcRTGGr8LjbNbeO00XiIiCOQlQ69+M31i67k
	Iigoey1sRbXI5vF4d1KlpihHygFGcB+hNNn7kHslc6j4KUZmQw9nKPKUgT2sFQy1
	GF93ThWCGGOWuSWMNgu8O2MByfILdcQeWK6qNrqom5zX3zOVJGQS8HyqI2Q22k1m
	TL7an/kp35Fp9x4skL/BOljxl3/AL54eVONabffSisdvFSLpl28PmhTIxRW2rAaq
	oXC6Dw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hnk8m5qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:20:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f99a9524so124051956d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742815250; x=1743420050;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Omyzt0+3s9T/Lcy+ZIwCMHKO6499mJSDlZjjA79KkE=;
        b=B7zi+m5RkFZDmIPtvoiaHaW7mEv3jY0h9MEh8tjQvhd193pF4hY5YxcHeNAetpv7fP
         i7P9z7ZBFpmN4W7JzxMUoH4lgdDeh4LZ2yCrJJ/z4v/SbxNtQBYxOLjU8DAa95NMGyp9
         GOjgk7IRRHBR4bgSMsaNZZ+adPUij9T9rY44JiXJG2dRh6bITxyS/qirQSUUia3/SCz+
         i0vHwAR/yBGtcr+qaPblUyOlX8n9xesYnAbaxGrs59dWHpMIhnaKzaDlzi6CJo6kPA3v
         TpyyHp+0kvOuL7uV0AM2YM0+CC0Qw63tCeU2jo6KoUJFKl5Y7aDkgzgTniVem6XIyx9j
         XYUA==
X-Forwarded-Encrypted: i=1; AJvYcCVe0CrIfrGfk9SAaVFksOgdh2fSz5xFF8T9qwQ4lMPZgfHEf+eFiTVvP/gTb1O/Z6QZf50C98k6h9IA9yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROadq5Abcoa4ITkgYBoKaIjJEtqnohhzSGyaaw22hdJhsvRz8
	i1XDUyrKfBjSaAthlPF2+NsZtg06EHhqa4NqqJB3lcELooT73HFnNdgt8AHQ1iADBASpGSPB/HR
	mYlmdpm9eHsoGDZCvWpHSMcT9kW7qdz2OQHz06rfGy1bcet4TbnTITuzKzlpj6Fo=
X-Gm-Gg: ASbGncuGgOVurf/X+8hsh4EpfzACEuWA5pNKwamo5proCCfJ0sBwFzT5vNVKWCdchch
	k/XssquoCD5WDV08EST1bWSeTHR/VMPg9lHaZxr0lohRa7TULf0Ln+6Smw6ol8yjqaRhkXm5hnr
	RDFi854mrzWCj2lCqokx4oxv7RUZZt8kEyvH2rPN5Ps5AzSf28UHI8vx8VSjgZ2VmPGGRAuzH92
	JrPz710IWfrD0ambiMvt3c0f2LVRB8BWvdgxxQBtvjsV+TVjaE0/zAlp700WjB78g4UDeXGY2c0
	GX6PV6AiOYxb6RYCjCihPHXzPq1HZd1a7FzNQstd7rLSCwCdxC7mkTgZ7+0zpXiUPm6tMKQDTrZ
	DhB8S/bOy6l+axcyxmenqT37G34LfMqqhZhsgBkeBZJZhjHo++T+u8FOEfUp0PAb26tSv
X-Received: by 2002:a05:6214:240a:b0:6e8:f470:2b0d with SMTP id 6a1803df08f44-6eb3f2ea042mr241595496d6.19.1742815249799;
        Mon, 24 Mar 2025 04:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYlu+ZxtD5PiAQVQVaDuGeEL8PIAH2N2h5B+UI11MbkEtNy7DmV9TNxhz1r4q9ByMX8PffOg==
X-Received: by 2002:a05:6214:240a:b0:6e8:f470:2b0d with SMTP id 6a1803df08f44-6eb3f2ea042mr241594736d6.19.1742815249260;
        Mon, 24 Mar 2025 04:20:49 -0700 (PDT)
Received: from ?IPV6:2001:14bb:11c:bb1f:bc99:5dd2:1e47:705? (2001-14bb-11c-bb1f-bc99-5dd2-1e47-705.rev.dnainternet.fi. [2001:14bb:11c:bb1f:bc99:5dd2:1e47:705])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad650b89bsm1101765e87.208.2025.03.24.04.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 04:20:47 -0700 (PDT)
Message-ID: <7fc622e8-6f9d-4a14-bf5f-3122e6f81808@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 13:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: srinivas.kandagatla@linaro.org, peda@axentia.se, broonie@kernel.org,
        andersson@kernel.org, krzk+dt@kernel.org
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
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20250324110606.32001-6-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: y_CAf0Q7Rx5TlZUhOJiW1DQfXnuf0B6P
X-Authority-Analysis: v=2.4 cv=KMlaDEFo c=1 sm=1 tr=0 ts=67e14012 cx=c_pps a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=O8kJzBLDCMT3sX5uReoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: y_CAf0Q7Rx5TlZUhOJiW1DQfXnuf0B6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240082

On 24/03/2025 13:06, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On some platforms to minimise pop and click during switching between
> CTIA and OMTP headset an additional HiFi mux is used. Most common
> case is that this switch is switched on by default, but on some
> platforms this needs a regulator enable.
> 
> move to using mux control to enable both regulator and handle gpios,
> deprecate the usage of gpio.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
> ---
>   sound/soc/codecs/Kconfig   |  1 +
>   sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>   2 files changed, 31 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index ee35f3aa5521..a2829d76e108 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>   	tristate
>   	depends on SOUNDWIRE || !SOUNDWIRE
>   	select SND_SOC_WCD_CLASSH
> +	select MULTIPLEXER
>   
>   config SND_SOC_WCD938X_SDW
>   	tristate "WCD9380/WCD9385 Codec - SDW"
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index dfaa3de31164..948b5f6cc45a 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -19,6 +19,7 @@
>   #include <linux/regmap.h>
>   #include <sound/soc.h>
>   #include <sound/soc-dapm.h>
> +#include <linux/mux/consumer.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include "wcd-clsh-v2.h"
> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>   	int variant;
>   	int reset_gpio;
>   	struct gpio_desc *us_euro_gpio;
> +	struct mux_control *us_euro_mux;
> +	u32 mux_state;
>   	u32 micb1_mv;
>   	u32 micb2_mv;
>   	u32 micb3_mv;
> @@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
>   
>   	wcd938x = snd_soc_component_get_drvdata(component);
>   
> -	value = gpiod_get_value(wcd938x->us_euro_gpio);
> +	if (!wcd938x->us_euro_mux) {
> +		value = gpiod_get_value(wcd938x->us_euro_gpio);
>   
> -	gpiod_set_value(wcd938x->us_euro_gpio, !value);
> +		gpiod_set_value(wcd938x->us_euro_gpio, !value);

Is it possible to use mux_state for both GPIO and MUX paths?

> +	} else {
> +		mux_control_deselect(wcd938x->us_euro_mux);
> +		wcd938x->mux_state = !wcd938x->mux_state;
> +		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))
> +			dev_err(component->dev, "Unable to select us/euro mux state\n");

This can lead to mux being deselected next time even if the 
mux_control_select returned an error. I think mux_control API needs a 
way to toggle the state without deselecting it first. Anyway, an error 
from mux_control_select() must prevent you from calling 
mux_control_deselect() next time.

> +	}
>   
>   	return true;
>   }


-- 
With best wishes
Dmitry

