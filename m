Return-Path: <linux-kernel+bounces-573772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405DA6DC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC643B4090
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C1B25F798;
	Mon, 24 Mar 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A77I0csl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249F25EF8E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824237; cv=none; b=l5ynB7HP8d7pOrnf7K+WjPl7unCWsBkNuib2tM5hL76KGvhCDLFESsXH6rU4t/e2lr+P5AFCU3eqQ5rTJqbBIvOCBcoOZ5hzmRGCsDCwSf+HX6GYL2HIRv+32oPEY/u8SmAXOsahZ5I5oIVzrR2Irwt+VOFX+n7+nRpsrNZ7i2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824237; c=relaxed/simple;
	bh=KH2AbP8hEOSyv2dSdRRqSFbyC0F8lwz0bs994ri1ioI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8X8MkWdbrLEulzUJuPS6fc73MvD5AwXPZQczZCoenR2COmhR6N8zSTuRGrmMSy4BFPUv+FQw1l0gkOx3hL6RKorBtFdJ1YIyUmyY0xeEIGj6WZllqh+f4NDlM5iWhH7Am4ONHP8tim3WxYNTIAdFs8cu22raSrDtRypjWN3rKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A77I0csl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9PN16004809
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=95hHTOgsDguSuXKORfoFD7vr
	/pR9Ww99EDSaRcdphmo=; b=A77I0cslgUO6KN1avRSTcNvcEdxDhvbGDnAqsWYS
	1DiN3GG84OOsuDBjFqoch3J503z+vt58vf1Rc/tDcNA9XObdukHQnckRyuBcqpzH
	tgcM4NmzogXkGji8gdLnlZviqjw7uVtRXUuJevXmd0LZLAEnLqUEXsmKxwhvQhka
	lhnnlnSQFjC1MQzGeuod661zZAOxbxqds4j3GEkDmI4oVigs4DGXERU284JXsOFB
	ykEMTns9kINH7EmDXwAKgV8iAFeJCssaVwZmpbFO0xQru/sHuHcfvv+7QJDBJSlj
	LhB99VFEMtQcnDasXkeVRXP65bRkF1/kWRj5eXJlqsorCQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79mm9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:50:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so6668551a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824232; x=1743429032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95hHTOgsDguSuXKORfoFD7vr/pR9Ww99EDSaRcdphmo=;
        b=nLaVlI4QmFF2zkKYqY0LwmTbPBi2Wr2TVZotzEuA/nWj8UJOAxJsOsBTrV9ntOOr85
         8JZ82dDBesaQjZyExG9vZGUwCDQdlK1TJvOkWjfW8A7/uqMExmgxjOlCugEG2qogBMed
         LkBxsLSTx9eXvs6eyEgB1oV02pLVnicQR0anr4zxSJlFQ7HxP48Iwt+QDO80MUZSOzm8
         x09uiNx7PbS1R0ye40jfwcnzMvMFuAXn2amB+K7mhhuLnHm2nTTqApWMhA/eXxs76ums
         kDwZeUQiWP9VfZdkv4SqkoC0jbTlCsd8dh4C2jO4aNAcleyzOHPIBWCxnvL+3cm49bpN
         qtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKT+4nb7OYrnfwmiX69qo1+gxH1Kg251Y/nBIPXe+dO4cY9ui00czkKnGzyq8xWQP4mMnhdJYzDmBlOzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyqNksLhr61IXIfI1olahFEumGov+qP1BDxYnp8eyc1gQIlM/T
	Y8/8qMAtaIOnEStG9Oj2u7U1vx2VePfKXNVnTUi6wgEMG7y6hBunXLxbkm+TSB4m9KOuiy4kC3Q
	LoEiTCW/yBtdd4MmojR5k2hbir6eO1t2zDduYnCzowGCRAS1o5F6IkZK3j0gbjzPhu75SZpvaQJ
	mTLxmNw8MKxzX6JKKmdlVr+Yr+wvzTusLXBhVkNw==
X-Gm-Gg: ASbGncuoZA4NQt/HKopV6quxAzMCOFgmi5aMXgaLPNpa/VFkjR9KN69Bkzktj8Vrr+w
	0lWjF8UexBzYS5KCK4Jczctf2rCkbc5nsYfIQ9V8ZcdY6nXG2JMKTG/PdRD9lpH5oLyQCU8K4/Q
	6xrCR5Em9IEZqkWNTvpteOrOAHFh426A==
X-Received: by 2002:a17:90b:4c0f:b0:2fe:99cf:f579 with SMTP id 98e67ed59e1d1-3030fe5b15bmr20207268a91.4.1742824231629;
        Mon, 24 Mar 2025 06:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXMOsAoGpdtih1+0ssF5i40YdS6JFQsTc0IGSXQBUtJaK2Mm+GfER10JaDD1Nn24M59aGXBRi9MPLEp7Jiixs=
X-Received: by 2002:a17:90b:4c0f:b0:2fe:99cf:f579 with SMTP id
 98e67ed59e1d1-3030fe5b15bmr20207201a91.4.1742824231062; Mon, 24 Mar 2025
 06:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org> <20250324130057.4855-6-srinivas.kandagatla@linaro.org>
In-Reply-To: <20250324130057.4855-6-srinivas.kandagatla@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 24 Mar 2025 15:50:20 +0200
X-Gm-Features: AQ5f1JqiwDly8jNyPcDcoChNoCMpD8WkI2T1QYMZRnXTR-tMOVaIet3UtcOHoEE
Message-ID: <CAO9ioeX9RTBAeL3+9STn+=oEYR0wtaF6yoa=esNddEvqLQyO9Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: srinivas.kandagatla@linaro.org
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
        krzk+dt@kernel.org, ivprusov@salutedevices.com,
        luca.ceresoli@bootlin.com, zhoubinbin@loongson.cn,
        paulha@opensource.cirrus.com, lgirdwood@gmail.com, robh@kernel.org,
        conor+dt@kernel.org, konradybcio@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Christopher Obbard <christopher.obbard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: acjed2MrLSHdGYCUgf3bAMm7uWn0oGZp
X-Proofpoint-ORIG-GUID: acjed2MrLSHdGYCUgf3bAMm7uWn0oGZp
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e1632a cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=OAj1MUjZvtZXw01r514A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240100

On Mon, 24 Mar 2025 at 15:01, <srinivas.kandagatla@linaro.org> wrote:
>
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
>  sound/soc/codecs/Kconfig   |  1 +
>  sound/soc/codecs/wcd938x.c | 50 +++++++++++++++++++++++++++++---------
>  2 files changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index ee35f3aa5521..a2829d76e108 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>         tristate
>         depends on SOUNDWIRE || !SOUNDWIRE
>         select SND_SOC_WCD_CLASSH
> +       select MULTIPLEXER
>
>  config SND_SOC_WCD938X_SDW
>         tristate "WCD9380/WCD9385 Codec - SDW"
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index dfaa3de31164..88c758efe40d 100644
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
>         int variant;
>         int reset_gpio;
>         struct gpio_desc *us_euro_gpio;
> +       struct mux_control *us_euro_mux;
> +       u32 mux_state;
>         u32 micb1_mv;
>         u32 micb2_mv;
>         u32 micb3_mv;
> @@ -3235,17 +3238,31 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
>                 dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
>  }
>
> -static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
> +static int wcd938x_select_mux_state(struct device *dev, struct wcd938x_priv *wcd938x, int state)
>  {
> -       int value;
> +       int ret = mux_control_try_select(wcd938x->us_euro_mux, state);

Hmm. Does this really work? You have selected the mux in probe
function, now you are trying to select it again. If I'm reading the
code correctly, you will get -EBUSY here.

>
> -       struct wcd938x_priv *wcd938x;
> +       if (ret) {
> +               dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
> +               return ret;
> +       }
>
> -       wcd938x = snd_soc_component_get_drvdata(component);
> +       wcd938x->mux_state = state;
> +       mux_control_deselect(wcd938x->us_euro_mux);
> +
> +       return 0;
> +}
>
> -       value = gpiod_get_value(wcd938x->us_euro_gpio);
> +static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
> +{
> +       struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
>
> -       gpiod_set_value(wcd938x->us_euro_gpio, !value);
> +       if (wcd938x->us_euro_mux) {
> +               if (wcd938x_select_mux_state(component->dev, wcd938x, !wcd938x->mux_state))
> +                       return false;
> +       } else {
> +               gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
> +       }
>
>         return true;
>  }
> @@ -3261,11 +3278,22 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
>                 return dev_err_probe(dev, wcd938x->reset_gpio,
>                                      "Failed to get reset gpio\n");
>
> -       wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
> -                                               GPIOD_OUT_LOW);
> -       if (IS_ERR(wcd938x->us_euro_gpio))
> -               return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
> -                                    "us-euro swap Control GPIO not found\n");
> +       wcd938x->us_euro_mux = devm_mux_control_get(dev, NULL);
> +       if (IS_ERR(wcd938x->us_euro_mux)) {
> +               if (PTR_ERR(wcd938x->us_euro_mux) == -EPROBE_DEFER)
> +                       return -EPROBE_DEFER;
> +
> +               /* mux is optional and now fallback to using gpio */
> +               wcd938x->us_euro_mux = NULL;
> +               wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro", GPIOD_OUT_LOW);
> +               if (IS_ERR(wcd938x->us_euro_gpio))
> +                       return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
> +                                            "us-euro swap Control GPIO not found\n");
> +       } else {
> +               ret = wcd938x_select_mux_state(dev, wcd938x, wcd938x->mux_state);
> +               if (ret)
> +                       return ret;
> +       }
>
>         cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
>
> --
> 2.39.5
>


-- 
With best wishes
Dmitry

