Return-Path: <linux-kernel+bounces-569822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7440A6A819
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A01B62870
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE81E2222B5;
	Thu, 20 Mar 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVy4NEZ9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBCC1DF26A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479446; cv=none; b=YcAK6sYOddEZLEs6AZFsP6P06ynIZQo8fOCEpMDNVKLuZ+nv8U3guF0GdH1m+mPww+wQg+84PTBaJR6/VwSfNGVzPlTJw1GHbaeO+6YhJXulUbpGjn6vxTRKcLjeZb6eW1OD48AIbKdCnOd2hVvNh26KOOML5br8lqZc2VBkKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479446; c=relaxed/simple;
	bh=58JkKNNJ4DFi2Sc9wU2rMgtgN5ne21L0pN3nrl/8cW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX1N6qih6q0GHBbB07Sgox5AyBtxdv8d+kaidCDhJt64yWErSM2+1+xQCU3W9EIs0+GIXEzwa/1+LB92guV8sZYaXm3LKJlN0iLOyrfVgPVgibuSeBqDUSlSd6sIFgNrxDkY0jjVY3gkw2LvZY204vxudMX8pZ3HxbFoKinPXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVy4NEZ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE2kta023829
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aZG69Gb8Rg4wqYE5Zlnz4YPU
	9LD6EgYlhsjK/lMjlgo=; b=SVy4NEZ9sglsWOcMgSjQOoDZr1kZCTmEYcdSMVgl
	PSB+nu41uaoDbBenDYAAkjg0oImG36nv24uaZkWiE0oytIgh1hmqSmgzfUA5218Y
	MUQ+CLkd628ynOqoj42fH6uagIizLUl3qKlHvSMqXizlRaI66h/ikZsM10SJLEhU
	lnLM8azmFFlH4vQ/HJTVP2RtPtOUTd5yo6hb1vNEpL6LF9ItzjWJZr1G0DYXRv5Y
	ROVJeoeiVI4BvwhEpzaeSvwi8YSc/+JP6fbBTDQbc014GrJJ06t+s1T7/y2ufq9Z
	cA7abPgq2USRDPAHSVGuDmgzlaz1wdsDgHJMJr9CrEn+wQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwxmg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:04:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5ac559cbaso161603885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479442; x=1743084242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZG69Gb8Rg4wqYE5Zlnz4YPU9LD6EgYlhsjK/lMjlgo=;
        b=mR7oR4tNeDrGHaGybDvtnqKNp8M1/UqHh9GOcm/YyNZulKKRdmgw7atAGd/i1PFUtm
         G8TVzsb26AkydFxRFbYOYDCZwdZyFrURJPjEdakem7KmDNnXQZvzGm1bCduASDSgPDpj
         JbFy0N32U5COyLxzIZK4rq+kn4VPhX2U1rfSC148c8gUaTFv3xu+Tg3D+zJmVKyagsNo
         QJw67iCz/F0+pmOx/XyaGglWY8mpK4XNZA6s88ZiBv6CpUzxXq4DK7oUH2Iz3/49VTau
         TdCFysxgKUX1aP2+yX5AkjS+8HcDy4GUklG4WlNDjXMcmKUQkDav3PBKiwsI0g223wU1
         T1FA==
X-Forwarded-Encrypted: i=1; AJvYcCV4Rx8vFOp7yetZwMdwsLGFPuWxZAb1RGo4A8k2eCkw3E9JJNbCtMmUW5HfBkSM8Ky7IjfqtZuTaToCx7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWemc1uAxcbY6qSovQhuUdYcvwMtK/KvnIpUaNpyQCHpmoEja+
	1yF830t3tlL9W2VpNLox/OY5fBajdJViPB1L56VoWnKoSvo3LdFGteQ5NzGlRkoCUKsN0yhtR5+
	7E/X4cZyildsaWEvMfmKJ0R2UsdsUzsNbwIUqU7m4kuirIHo2jQtDucZRw7NrJXY=
X-Gm-Gg: ASbGncsQWRKNISuLyqIrr81REDAKnZzWo19g8z9InuOysqrnp91RBaBTE5DvS7OM7Kh
	G5diV8Zk6+5UP7ksEMgEXrVKqa8JlVH65qxARo3VqRe2HpBQpsTYcj72hgl/kmIshOuIQXvELo+
	XKhNR1zw7/T3Px5iaXkOVmeYn7B5uWLVPEgUX+97gKBOKZ6GSmqOcxJWnv7L4A3DGitMLZfR7uU
	VXRzrBxjc69xJD7BOzdNlfxrO1Z85blxdF9blOOoDl6XeXPX9tTAzOY00yEik1Q4Ga+3+9EIgic
	JcrqvzotaCUc6Yz1pNNVusIi5PWZsJWbigLwMJ61I3YBVyLH/+aT4FU9Cbn5oZjs+JrEqWSAHmu
	Q0Ek=
X-Received: by 2002:a05:620a:40d2:b0:7c5:79c6:645d with SMTP id af79cd13be357-7c5a8397faemr886719485a.11.1742479442410;
        Thu, 20 Mar 2025 07:04:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxrSjeqF6bvbl3He9tiF4dKDPJLyxqjGi9lLtRwtFa5vJGHE/F4XSyDTZNU+YV9hEc4s90iw==
X-Received: by 2002:a05:620a:40d2:b0:7c5:79c6:645d with SMTP id af79cd13be357-7c5a8397faemr886713285a.11.1742479441855;
        Thu, 20 Mar 2025 07:04:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8853bbsm2208705e87.204.2025.03.20.07.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:04:01 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:03:57 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
        krzk+dt@kernel.org, ivprusov@salutedevices.com,
        luca.ceresoli@bootlin.com, zhoubinbin@loongson.cn,
        paulha@opensource.cirrus.com, lgirdwood@gmail.com, robh@kernel.org,
        conor+dt@kernel.org, konradybcio@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 4/5] ASoC: codecs: wcd938x: add mux control support
 for hp audio mux
Message-ID: <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-5-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320115633.4248-5-srinivas.kandagatla@linaro.org>
X-Proofpoint-ORIG-GUID: 8ZJjuSc9juIXNbg4T9n5dssBUzrNeQTG
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dc2053 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=O8kJzBLDCMT3sX5uReoA:9 a=CjuIK1q_8ugA:10 a=Toojp5lMUUUTO6xlXwhV:22
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8ZJjuSc9juIXNbg4T9n5dssBUzrNeQTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200087

On Thu, Mar 20, 2025 at 11:56:32AM +0000, srinivas.kandagatla@linaro.org wrote:
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
> ---
>  sound/soc/codecs/Kconfig   |  2 ++
>  sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index ee35f3aa5521..b04076282c8b 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2226,6 +2226,8 @@ config SND_SOC_WCD938X
>  	tristate
>  	depends on SOUNDWIRE || !SOUNDWIRE
>  	select SND_SOC_WCD_CLASSH
> +	select MULTIPLEXER
> +	imply MUX_GPIO

Why? This is true for a particular platform, isn't it?

>  
>  config SND_SOC_WCD938X_SDW
>  	tristate "WCD9380/WCD9385 Codec - SDW"
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index f2a4f3262bdb..b7a235eef6ba 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -19,6 +19,7 @@
>  #include <linux/regmap.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
> +#include <linux/mux/consumer.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "wcd-clsh-v2.h"
> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>  	int variant;
>  	int reset_gpio;
>  	struct gpio_desc *us_euro_gpio;
> +	struct mux_control *us_euro_mux;
> +	u32 mux_state;
>  	u32 micb1_mv;
>  	u32 micb2_mv;
>  	u32 micb3_mv;
> @@ -3243,9 +3246,16 @@ static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component, bool activ
>  
>  	wcd938x = snd_soc_component_get_drvdata(component);
>  
> -	value = gpiod_get_value(wcd938x->us_euro_gpio);
> +	if (!wcd938x->us_euro_mux) {
> +		value = gpiod_get_value(wcd938x->us_euro_gpio);
>  
> -	gpiod_set_value(wcd938x->us_euro_gpio, !value);
> +		gpiod_set_value(wcd938x->us_euro_gpio, !value);

This looks like a separate topic, but why is 'active' being ignored?

> +	} else {
> +		mux_control_deselect(wcd938x->us_euro_mux);
> +		wcd938x->mux_state = !wcd938x->mux_state;
> +		if (mux_control_select(wcd938x->us_euro_mux, wcd938x->mux_state))

Can't it just be 'mux_control_select(wcd938x->us_euro_mux, active)' ?

> +			dev_err(component->dev, "Unable to select us/euro mux state\n");
> +	}
>  
>  	return true;
>  }

-- 
With best wishes
Dmitry

