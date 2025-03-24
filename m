Return-Path: <linux-kernel+bounces-573973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA759A6DF28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277A316FAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58687261581;
	Mon, 24 Mar 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfaiU0Zy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D126138C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742831918; cv=none; b=Ny+RBSY7FdEDFbZ/f44pzHU0RD/YyH9h504VepJWm9DZdood3eTFJkIUbD+V0GY3Sntp2YOtTDkYIdjKukBm1tgJaEn6As9u+l+viVB92CpTFLWacpNDR5brK9NrwuL9BYL5TWTLis/syMLKSyiay878nysd/sV+Jh4LCeFuE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742831918; c=relaxed/simple;
	bh=os2xPMPw2FE5HLzg124AsrhFc041B4Ai4hkDtRkLW3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMX9icoJimfPcQ3Y5ZSHCyaqFYWK1EDgEBHEFk+6WEUALVhqeAlKBunwWAmCpk7GEJzUA9d7nWt8FREEmDnhV+Bx5ggg5umSpl9vQ+jb733yjdV2UEmYdzwwey3ntFP1vMBM6Pz5wQYcVq9W8+HjSpf32RfpuhdRHHb1FaXZg80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfaiU0Zy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39127512371so2995099f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742831914; x=1743436714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJsdCBCc9QJULVIcLI1aa/eLBqCGZX2m5E+zwF9jXo=;
        b=WfaiU0ZyFUVImXqJ8WhFelmfrwH/2VvVjlqIduz5Awb2Y6EvvczLP/LetGUC7gj7an
         7R4a/xY3Pt6gH8WajceZsoTSw+bgT/9yrp7o3LFLKdUc6h4vLj+UIQtrK0euzL3b3Ba0
         Rbravy/vDlH2C/0qD8LPwKnpJ/cPBo21niom3o+2UNEcr21zN4bEArh5UU/4kSVc0zxr
         fGe0j+QmW3FrNxlhUN6PuivRxXnBmHY7Wtkj95l7Pdfri/EEK5/b+jsEscYyolEonvbT
         qyvtuCtpW9U2dlVXoYtiaiA/clM4ab5SU9WEeSZJCVs+w8BIZDBV949J5caI+d5pvk2v
         et5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742831914; x=1743436714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJsdCBCc9QJULVIcLI1aa/eLBqCGZX2m5E+zwF9jXo=;
        b=qm1ZqbSCHj/2uD0YQB/h/Ul2FOejov9uLkpX5aCJ4u0j24TDJ9V/n8QCqHdxErGi+E
         3Op3rsyUSfhsD+7FWgAwbBSga017OdbU69V4F27jfArWc461laoF2RWaHGA2JwyGtv/m
         4x3zzaKojeGFWmFVUy+sIeZRy0PcUSa7enHSKgTZHtbRAUhGlp+Mdn2m4raMFTd1kE1Z
         sOwxzJH/pf0kuwGysKhhW381xET+v510V/tYrBc1zybajkiyr2WwIoOqpQuvNhedHZWF
         vDM9Y2OfJIMrNBB6cJIFrNGYbOw4Q13+ZPhe4d2DYDBob8ebwT/VSDo9scnDFPFqlt96
         TS9w==
X-Forwarded-Encrypted: i=1; AJvYcCUcXBsaUxJHW7qBbaDe0ci1/PvRfE9iZj91YNXvt/u4EO1AKcFecDdtufPof725OI6tBM2Kv/yqVhWRjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ+9ljiSL1lu4WtYR1EiWcPNSJOR9/qlWSGlj7eUzXs705QhN
	PGShq9S7s89F6htphYPtXcmprRL79mvIXbDkTzV74qRlx4JoDNsjprmk/5QKvVo=
X-Gm-Gg: ASbGncsfxj4noezVSxN18PnyXrl+V6nRymywai9UTMAhqd0YL2f/OvEVzbOkG8tpqeN
	tP+YJXRuReT8Q8apzWo55qMfagZ0mPfq3FS9QEtrsJQpQ/a5Y637hV/9cq5QT3q+jXEAwCQqHtI
	0Mm6QSXpRVoCd4tXySCQT0riBnpLav4NBhUtSOJRyAdWNvQesyrnAJQvqEFOox7IZhCkHa/PHbG
	3dJgE87QSSAmBP60xB5M74MO2c6sK47+Ka4bGIZJmw2L5rgjLabuB8dWkIiCgj7SCtOmPUAKyLT
	vDWnAKkkzHPbNDT96QcWEhzuyG1NxEwkIReG5IzHo31G7CIrrAhJW7rJhAnSEBI=
X-Google-Smtp-Source: AGHT+IFT7R9bbT7QXeBpEm8UkutYKjMb0+xp+VX+EZxX9GZRAMNXL4kmMjzCG77aSP5SGON0VY88XQ==
X-Received: by 2002:a5d:584b:0:b0:391:48d4:bcf2 with SMTP id ffacd0b85a97d-3997f8fe836mr12892855f8f.12.1742831913590;
        Mon, 24 Mar 2025 08:58:33 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9efc9bsm11117333f8f.87.2025.03.24.08.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 08:58:33 -0700 (PDT)
Message-ID: <324d5789-6309-4a64-bbfa-3afa0632e7ff@linaro.org>
Date: Mon, 24 Mar 2025 15:58:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
 krzk+dt@kernel.org, ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
 Christopher Obbard <christopher.obbard@linaro.org>
References: <20250324130057.4855-1-srinivas.kandagatla@linaro.org>
 <20250324130057.4855-6-srinivas.kandagatla@linaro.org>
 <CAO9ioeX9RTBAeL3+9STn+=oEYR0wtaF6yoa=esNddEvqLQyO9Q@mail.gmail.com>
 <e4e94fbf-172f-4cfd-becc-cb2836ac1fb1@linaro.org>
 <ctcqkdbv6zh2rabkkr7tlhxlcfsn5nazjfbsnbbu4l4blyakft@pejdsvnazfh6>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ctcqkdbv6zh2rabkkr7tlhxlcfsn5nazjfbsnbbu4l4blyakft@pejdsvnazfh6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/03/2025 15:18, Dmitry Baryshkov wrote:
> On Mon, Mar 24, 2025 at 01:58:06PM +0000, Srinivas Kandagatla wrote:
>>
>>
>> On 24/03/2025 13:50, Dmitry Baryshkov wrote:
>>> On Mon, 24 Mar 2025 at 15:01, <srinivas.kandagatla@linaro.org> wrote:
>>>>
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> On some platforms to minimise pop and click during switching between
>>>> CTIA and OMTP headset an additional HiFi mux is used. Most common
>>>> case is that this switch is switched on by default, but on some
>>>> platforms this needs a regulator enable.
>>>>
>>>> move to using mux control to enable both regulator and handle gpios,
>>>> deprecate the usage of gpio.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
>>>> ---
>>>>    sound/soc/codecs/Kconfig   |  1 +
>>>>    sound/soc/codecs/wcd938x.c | 50 +++++++++++++++++++++++++++++---------
>>>>    2 files changed, 40 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>>> index ee35f3aa5521..a2829d76e108 100644
>>>> --- a/sound/soc/codecs/Kconfig
>>>> +++ b/sound/soc/codecs/Kconfig
>>>> @@ -2226,6 +2226,7 @@ config SND_SOC_WCD938X
>>>>           tristate
>>>>           depends on SOUNDWIRE || !SOUNDWIRE
>>>>           select SND_SOC_WCD_CLASSH
>>>> +       select MULTIPLEXER
>>>>
>>>>    config SND_SOC_WCD938X_SDW
>>>>           tristate "WCD9380/WCD9385 Codec - SDW"
>>>> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
>>>> index dfaa3de31164..88c758efe40d 100644
>>>> --- a/sound/soc/codecs/wcd938x.c
>>>> +++ b/sound/soc/codecs/wcd938x.c
>>>> @@ -19,6 +19,7 @@
>>>>    #include <linux/regmap.h>
>>>>    #include <sound/soc.h>
>>>>    #include <sound/soc-dapm.h>
>>>> +#include <linux/mux/consumer.h>
>>>>    #include <linux/regulator/consumer.h>
>>>>
>>>>    #include "wcd-clsh-v2.h"
>>>> @@ -178,6 +179,8 @@ struct wcd938x_priv {
>>>>           int variant;
>>>>           int reset_gpio;
>>>>           struct gpio_desc *us_euro_gpio;
>>>> +       struct mux_control *us_euro_mux;
>>>> +       u32 mux_state;
>>>>           u32 micb1_mv;
>>>>           u32 micb2_mv;
>>>>           u32 micb3_mv;
>>>> @@ -3235,17 +3238,31 @@ static void wcd938x_dt_parse_micbias_info(struct device *dev, struct wcd938x_pri
>>>>                   dev_info(dev, "%s: Micbias4 DT property not found\n", __func__);
>>>>    }
>>>>
>>>> -static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
>>>> +static int wcd938x_select_mux_state(struct device *dev, struct wcd938x_priv *wcd938x, int state)
>>>>    {
>>>> -       int value;
>>>> +       int ret = mux_control_try_select(wcd938x->us_euro_mux, state);
>>>
>>> Hmm. Does this really work? You have selected the mux in probe
>>> function, now you are trying to select it again. If I'm reading the
>>> code correctly, you will get -EBUSY here.
>>
>> On successful selection of mux state, the mux will be kept available
>> (mux_control_deselect) for any new callers.
>>
>> So we will not get EBUSY for the second caller.
> 
> No. wcd938x_populate_dt_data() selects the state by calling
> wcd938x_select_mux_state().

At this point we also released it (both in success and error case).

This will hold on to the previous state unless we have defined a 
fallback idle-state.


  Then you call mux_control_try_select() here.
> As far as I understand, it will return -EBUSY as the sempahore is > already taken. Moreover, this is not how the MUX API is supposed to be
> used. The driver is supposed to hold a state while it is still in use.
> 
>>
>> --srini
>>>
>>>>
>>>> -       struct wcd938x_priv *wcd938x;
>>>> +       if (ret) {
>>>> +               dev_err(dev, "Error (%d) Unable to select us/euro mux state\n", ret);
>>>> +               return ret;
>>>> +       }
>>>>
>>>> -       wcd938x = snd_soc_component_get_drvdata(component);
>>>> +       wcd938x->mux_state = state;
>>>> +       mux_control_deselect(wcd938x->us_euro_mux);
>>>> +
>>>> +       return 0;
>>>> +}
>>>>
>>>> -       value = gpiod_get_value(wcd938x->us_euro_gpio);
>>>> +static bool wcd938x_swap_gnd_mic(struct snd_soc_component *component)
>>>> +{
>>>> +       struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
>>>>
>>>> -       gpiod_set_value(wcd938x->us_euro_gpio, !value);
>>>> +       if (wcd938x->us_euro_mux) {
>>>> +               if (wcd938x_select_mux_state(component->dev, wcd938x, !wcd938x->mux_state))
>>>> +                       return false;
>>>> +       } else {
>>>> +               gpiod_set_value(wcd938x->us_euro_gpio, !wcd938x->mux_state);
>>>> +       }
>>>>
>>>>           return true;
>>>>    }
>>>> @@ -3261,11 +3278,22 @@ static int wcd938x_populate_dt_data(struct wcd938x_priv *wcd938x, struct device
>>>>                   return dev_err_probe(dev, wcd938x->reset_gpio,
>>>>                                        "Failed to get reset gpio\n");
>>>>
>>>> -       wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro",
>>>> -                                               GPIOD_OUT_LOW);
>>>> -       if (IS_ERR(wcd938x->us_euro_gpio))
>>>> -               return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
>>>> -                                    "us-euro swap Control GPIO not found\n");
>>>> +       wcd938x->us_euro_mux = devm_mux_control_get(dev, NULL);
>>>> +       if (IS_ERR(wcd938x->us_euro_mux)) {
>>>> +               if (PTR_ERR(wcd938x->us_euro_mux) == -EPROBE_DEFER)
>>>> +                       return -EPROBE_DEFER;
>>>> +
>>>> +               /* mux is optional and now fallback to using gpio */
>>>> +               wcd938x->us_euro_mux = NULL;
>>>> +               wcd938x->us_euro_gpio = devm_gpiod_get_optional(dev, "us-euro", GPIOD_OUT_LOW);
>>>> +               if (IS_ERR(wcd938x->us_euro_gpio))
>>>> +                       return dev_err_probe(dev, PTR_ERR(wcd938x->us_euro_gpio),
>>>> +                                            "us-euro swap Control GPIO not found\n");
>>>> +       } else {
>>>> +               ret = wcd938x_select_mux_state(dev, wcd938x, wcd938x->mux_state);
>>>> +               if (ret)
>>>> +                       return ret;
>>>> +       }
>>>>
>>>>           cfg->swap_gnd_mic = wcd938x_swap_gnd_mic;
>>>>
>>>> --
>>>> 2.39.5
>>>>
>>>
>>>
> 

