Return-Path: <linux-kernel+bounces-521469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B694A3BDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7063A60CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BE1DED6C;
	Wed, 19 Feb 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GVOkFPPm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2791DF75C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966840; cv=none; b=psCglHSuIwwsdAOs+UqN0beqcz2J8ThtC/wx2Xd2w5UNTQES/LvO6LI0X2+9W4Or07Fz35Nfcbp0NqLCFWFBYqnYuIxpQg36qlcc09pmUhVsA9AoK0rx8yT1KYhm6rz5b6cnsQT64+C8dw2/j/8aMdnpdfeGDbyGVN4Hg0jKTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966840; c=relaxed/simple;
	bh=4OjYJGHLbHcSgiHKjS0IIUhuCTr3EgjGNYeyisUEQZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejpEMrezaICfYEe08IH46iWASjgU4Ozpn8MTHYo36Y88/bQwEBCuyd4uKPmPgIxQhkN/CpuF6RuF/E69Gn5t7tkB4c+FwVLBt7jBnyREECi93KViVuMzcpduBzwP5Cvk4OsVQFsN6HXqPnm6rI3tBoAgItMKd5QRZgZCEXb00mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GVOkFPPm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4397dff185fso33265515e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739966836; x=1740571636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Kmiv++4vNW0rEfTtHkFe1jOyHczktuNnrPo1TO1Qs0=;
        b=GVOkFPPmQdtqr571kNUbLgld2FKyTxKsirRDIm8gSP3ZnvCrnlDmPSEBkB10ThU1lN
         F2D2npTpW2M/za5qzOuUfxn8EKUe5hCj1uwNX/e9yfotOasYC4xh3DeH2fiOJHa2L2nZ
         DKqm/MlOCs1wzwXBPKlE03tfkh+ubwaJM16gIo1lJySa9GOmaQ1mpBOp0LJUcXL5iqBj
         wzDG8bgL9r9jsMCnX2FwSin7ZG8zYXX7Cafi6LkXCYL+HOLvETQoDoUJIhVPhis3nRQH
         iuEzMvIwVfLuESsWCPnUg6GvoZNdAhE5L7yCuqrJmKOuQzcuSRHUwkeiUDqxXgxtfeVi
         G3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739966836; x=1740571636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Kmiv++4vNW0rEfTtHkFe1jOyHczktuNnrPo1TO1Qs0=;
        b=omc3svopjlqPuxaRxGBYmgLfq3Jp0kK9n6jf8dx2vjsowE3fixDGYM8MwIgaEcPuKX
         ZhMIbtsyb4gvbD5duvLlYScJ6zebKYezQQuZGwKVHJFpxF45WZhgRqkj9k9d3Hh4XAfC
         8FXjljcM6ABXDUZyu7XywqyJ/XJtq+YLSAEoWs/5nmy+GPwoUCCa9KjFF0cipBKmAr6e
         N32s/XtW3riaftkZy80mWSpBOtYZCS2Or5gJqvujaTJOv8UrEV/tSVa6CJyr4Dko6+g8
         1/iQndqxhX003cvSIpHM1CZJyKFc2wFSNIhizu41ocYaerXWPu/hvXRQu3yxey9p9JYH
         AaUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX91WIEFm+3Ka7izRHxVIXavW1vDBWvhdqMPG+tKpMxmquOkfGQpj6H6oM1CKU9+hZUjGJbNlfBjyjnKaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqVk0VQyJhoTMsjKrdyRNfu/MWGRg17MEnUFYkzj0TXtNGB4b
	HuIAIhkPMbBlT2v8GbICabbQO31GoD0d+vYKyKc+aN7B6Vt68Mhrvy2mQ0CTlOw=
X-Gm-Gg: ASbGncuwxe/MmUCIHlLHPntUTdkPQgQ98XQzKvEUE++4trU6wu6QWAl1GLLDq58BZA+
	qyPPvwjFIPQoq0GMnihDfn6AwjZKXem3kjzTe4mB5SqyU5POSvgH9EoTfnVE7C37Lb3J3KaQAX1
	rgLBe1yGJ3xjVE+ifS1gyEg/mxIc1Vn9ue+XT4ASJXZC6DehXCNy3H/durggWsUm6qvioPLUD00
	xCK/cPQidRdqgJBrf4aiqXw0P4uRC85m70sPg0o95te+M2JhiuuEourLdK+AKDSzIZqmEliqmGs
	ukXXNssApk+UIquF+ywqEO8xjfII8oWlY6f38VVzdienQPxNOXDAshOE
X-Google-Smtp-Source: AGHT+IHRib6UMMCKzb01An9fHSVtMmS4WBnrNIwVhvfDFSkboHIWb6WUN+wEq1fa+HU5RjFLzoLsKw==
X-Received: by 2002:a05:6000:188d:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-38f587e16dbmr3408791f8f.43.1739966836406;
        Wed, 19 Feb 2025 04:07:16 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d9be9sm17948979f8f.79.2025.02.19.04.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:07:15 -0800 (PST)
Message-ID: <fcc31cc7-67bd-4102-a53f-ebe66b4fd1a7@linaro.org>
Date: Wed, 19 Feb 2025 12:07:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
 <huluiiaqmunvmffoqadrhssd3kl2toutqtcw7rzamv3sqdglsf@7lz66x4sj3gv>
 <d4c4ecf0-9094-4341-8711-78a48e5d1344@linaro.org>
 <d444f1fb-42a0-48ef-83bc-d5aab9282b22@quicinc.com>
 <gzjyyl2kzv52zsewn5zf6ei65fymyi4pspvsmsjaqj5sklfxvc@bkg46saulni5>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <gzjyyl2kzv52zsewn5zf6ei65fymyi4pspvsmsjaqj5sklfxvc@bkg46saulni5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2025 11:59, Dmitry Baryshkov wrote:
> On Wed, Feb 19, 2025 at 05:11:03PM +0530, Jagadeesh Kona wrote:
>>
>>
>> On 2/19/2025 6:51 AM, Bryan O'Donoghue wrote:
>>> On 18/02/2025 17:19, Dmitry Baryshkov wrote:
>>>> On Tue, Feb 18, 2025 at 03:46:15PM +0000, Bryan O'Donoghue wrote:
>>>>> On 18/02/2025 14:26, Jagadeesh Kona wrote:
>>>>>> During boot-up, the PLL configuration might be missed even after
>>>>>> calling pll_configure() from the clock controller probe. This can
>>>>>> happen because the PLL is connected to one or more rails that are
>>>>>> turned off, and the current clock controller code cannot enable
>>>>>> multiple rails during probe. Consequently, the PLL may be activated
>>>>>> with suboptimal settings, causing functional issues.
>>>>>>
>>>>>> To properly configure the video PLLs in the probe on SM8450, SM8475,
>>>>>> SM8550, and SM8650 platforms, the MXC rail must be ON along with MMCX.
>>>>>> Therefore, add support to attach multiple power domains to videocc on
>>>>>> these platforms.
>>>>>>
>>>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>>>> ---
>>>>>>     drivers/clk/qcom/videocc-sm8450.c | 4 ++++
>>>>>>     drivers/clk/qcom/videocc-sm8550.c | 4 ++++
>>>>>>     2 files changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
>>>>>> index f26c7eccb62e7eb8dbd022e2f01fa496eb570b3f..b50a14547336580de88a741f1d33b126e9daa848 100644
>>>>>> --- a/drivers/clk/qcom/videocc-sm8450.c
>>>>>> +++ b/drivers/clk/qcom/videocc-sm8450.c
>>>>>> @@ -437,6 +437,10 @@ static int video_cc_sm8450_probe(struct platform_device *pdev)
>>>>>>         struct regmap *regmap;
>>>>>>         int ret;
>>>>>> +    ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8450_desc);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         ret = devm_pm_runtime_enable(&pdev->dev);
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>> diff --git a/drivers/clk/qcom/videocc-sm8550.c b/drivers/clk/qcom/videocc-sm8550.c
>>>>>> index 7c25a50cfa970dff55d701cb24bc3aa5924ca12d..d4b223d1392f0721afd1b582ed35d5061294079e 100644
>>>>>> --- a/drivers/clk/qcom/videocc-sm8550.c
>>>>>> +++ b/drivers/clk/qcom/videocc-sm8550.c
>>>>>> @@ -542,6 +542,10 @@ static int video_cc_sm8550_probe(struct platform_device *pdev)
>>>>>>         int ret;
>>>>>>         u32 sleep_clk_offset = 0x8140;
>>>>>> +    ret = qcom_cc_attach_pds(&pdev->dev, &video_cc_sm8550_desc);
>>>>>> +    if (ret)
>>>>>> +        return ret;
>>>>>> +
>>>>>>         ret = devm_pm_runtime_enable(&pdev->dev);
>>>>>>         if (ret)
>>>>>>             return ret;
>>>>>>
>>>>>
>>>>> What's the difference between doing the attach here or doing it in
>>>>> really_probe() ?
>>>>
>>>> I'd second this. If the domains are to be attached before calling any
>>>> other functions, move the call to the qcom_cc_map(), so that all drivers
>>>> get all domains attached before configuring PLLs instead of manually
>>>> calling the function.
>>>>
>>>>> There doesn't seem to be any difference except that we will have an
>>>>> additional delay introduced.
>>>>>
>>>>> Are you describing a race condition ?
>>>>>
>>>>> I don't see _logic_ here to moving the call into the controller's higher
>>>>> level probe.
>>>>>
>>>>> Can you describe some more ?
>>>>>
>>>>> ---
>>>>> bod
>>>>
>>>
>>> Here's one way this could work
>>>
>>> Author: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Date:   Tue Feb 18 19:46:55 2025 +0000
>>>
>>>      clk: qcom: common: Add configure_plls callback prototype
>>>
>>>      Add a configure_plls() callback so that we can stage qcom_cc_attach_pds()
>>>      before configuring PLLs and ensure that the power-domain rail list is
>>>      switched on prior to configuring PLLs.
>>>
>>>      Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>
>>> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
>>> index 9e3380fd71819..1924130814600 100644
>>> --- a/drivers/clk/qcom/common.c
>>> +++ b/drivers/clk/qcom/common.c
>>> @@ -304,6 +304,9 @@ int qcom_cc_really_probe(struct device *dev,
>>>          if (ret < 0 && ret != -EEXIST)
>>>                  return ret;
>>>
>>> +       if (desc->configure_plls)
>>> +               desc->configure_plls(regmap);
>>> +
>>>          reset = &cc->reset;
>>>          reset->rcdev.of_node = dev->of_node;
>>>          reset->rcdev.ops = &qcom_reset_ops;
>>> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
>>> index 7ace5d7f5836a..4955085ff8669 100644
>>> --- a/drivers/clk/qcom/common.h
>>> +++ b/drivers/clk/qcom/common.h
>>> @@ -38,6 +38,7 @@ struct qcom_cc_desc {
>>>          const struct qcom_icc_hws_data *icc_hws;
>>>          size_t num_icc_hws;
>>>          unsigned int icc_first_node_id;
>>> +       void (*configure_plls)(struct regmap *regmap);
>>>   };
>>>
>>> and
>>>
>>> % git diff drivers/clk/qcom/camcc-x1e80100.c
>>> diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
>>> index b73524ae64b1b..c9748d1f8a15b 100644
>>> --- a/drivers/clk/qcom/camcc-x1e80100.c
>>> +++ b/drivers/clk/qcom/camcc-x1e80100.c
>>> @@ -2426,6 +2426,21 @@ static const struct regmap_config cam_cc_x1e80100_regmap_config = {
>>>          .fast_io = true,
>>>   };
>>>
>>> +static void cam_cc_x1e80100_configure_plls(struct regmap *regmap)
>>> +{
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
>>> +       clk_rivian_evo_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
>>> +       clk_lucid_ole_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
>>> +
>>> +       /* Keep clocks always enabled */
>>> +       qcom_branch_set_clk_en(regmap, 0x13a9c); /* CAM_CC_GDSC_CLK */
>>> +       qcom_branch_set_clk_en(regmap, 0x13ab8); /* CAM_CC_SLEEP_CLK */
>>> +}
>>> +
>>>   static const struct qcom_cc_desc cam_cc_x1e80100_desc = {
>>>          .config = &cam_cc_x1e80100_regmap_config,
>>>          .clks = cam_cc_x1e80100_clocks,
>>> @@ -2434,6 +2449,7 @@ static const struct qcom_cc_desc cam_cc_x1e80100_desc = {
>>>          .num_resets = ARRAY_SIZE(cam_cc_x1e80100_resets),
>>>          .gdscs = cam_cc_x1e80100_gdscs,
>>>          .num_gdscs = ARRAY_SIZE(cam_cc_x1e80100_gdscs),
>>> +       .configure_plls = cam_cc_x1e80100_configure_plls,
>>>   };
>>>
>>>   static const struct of_device_id cam_cc_x1e80100_match_table[] = {
>>> @@ -2461,18 +2477,6 @@ static int cam_cc_x1e80100_probe(struct platform_device *pdev)
>>>                  return PTR_ERR(regmap);
>>>          }
>>>
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll0, regmap, &cam_cc_pll0_config);
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll1, regmap, &cam_cc_pll1_config);
>>> -       clk_rivian_evo_pll_configure(&cam_cc_pll2, regmap, &cam_cc_pll2_config);
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll3, regmap, &cam_cc_pll3_config);
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll4, regmap, &cam_cc_pll4_config);
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll6, regmap, &cam_cc_pll6_config);
>>> -       clk_lucid_ole_pll_configure(&cam_cc_pll8, regmap, &cam_cc_pll8_config);
>>> -
>>> -       /* Keep clocks always enabled */
>>> -       qcom_branch_set_clk_en(regmap, 0x13a9c); /* CAM_CC_GDSC_CLK */
>>> -       qcom_branch_set_clk_en(regmap, 0x13ab8); /* CAM_CC_SLEEP_CLK */
>>> -
>>>          ret = qcom_cc_really_probe(&pdev->dev, &cam_cc_x1e80100_desc, regmap);
>>>
>>>          pm_runtime_put(&pdev->dev);
>>>
>>> Or a least it works for me.
>>>
>>
>> This patch will not work in all cases, maybe in your case required power domains might be ON
>> from bootloaders so it might be working.
> 
> But with his patch domains are attached before configuring the PLLs, are
> they not?

Yes, its logically the same just done in core code.

>>
>>> New clock controllers would then use this callback mechanism and potentially all of the controllers to have uniformity.
>>>
>>
>> No, above approach also requires changes in each individual clock driver to define the callback. So I don't see any advantage
>> with this than the current approach.
> 
> Bryan's proposal moves us towards having a common code, so it's better.
> 

I can take the time to do the whole sweep and publish a RFC.

---
bod

