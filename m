Return-Path: <linux-kernel+bounces-513143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970EA34220
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B0188D8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B89E13CA97;
	Thu, 13 Feb 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mP48NQyN"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC223A9BF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456926; cv=none; b=LJ6e51SQM77w0o9qRIMACwf6JOfJ7J2H8IcZWUnVhfqwLbpD/2zNrkyPSm1p9DCqQNTj09nVRyas+gswPyfKrM6Ak1rPfOHiD+q7IHZokaNtCfZ7OGwLVEClwb7rLZF92rtmfISPM9D+6qh7CCqUoWLlLFs0wLz+ErxDzwxZCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456926; c=relaxed/simple;
	bh=olY4mBN5+LgaqDjLR1wm1qyN18oxeG0QjyL+rpLXqik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NofDok2AP+mP2a6nVVYLaDmeOnbIEGwZvvOIfUdeAurjTXmSCOUk/1ZcLhH+yMo2Y9pmJl+WI655M5gyXfGL76YHnKIYJgteczy8zk/MC6wyAxkuv3uTwuAHQKdNkdjKv+GhC/5Qo0bb8F1XVLXrVx9cLegIqbfGtWG1sDojsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mP48NQyN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f754678c29so9400717b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739456923; x=1740061723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfYpXrDl+rUlmnTpgbRJTwg81BgmauUKiaO1pjrmwJQ=;
        b=mP48NQyNb2e3n5ftJWucGRlWUywwdWC4PS+Fu1FcXOFNcpCeKdORe2JX4W8XCyAjZx
         pvV4V0klfTHQ3MyXoryQr1yrLnMOyraior907lZpnrqbhgPtPKf/ibldc7k/H/tSAq7/
         zNLTXIa0jOk64EAQJYjWRA9aap1nLAKue2MTZvPPCh3NQcS4t0EC7uuIyRoOdW88nMka
         U4YxCATNzccvqzO/faI9slOiG5bj5owUPJOnwGuZ4rn81v+noHNp4Omh1ubhQVcTWJJI
         eQGFlC+1SRsXnrwN/oUER0vM0x5LYEBUcMjC7u2DWsV//iWPf0Yguhjxywx4hsSVKx8Y
         PL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456923; x=1740061723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfYpXrDl+rUlmnTpgbRJTwg81BgmauUKiaO1pjrmwJQ=;
        b=TLxx6BrJZIyveK+Lv/iaaMo3GKJj7K1pgD6UpJHrqG4+ElcqJgmpDhpYfFGBlgKlW4
         0alG1HO+19aMxPgwdjPo5KkiDgGimjzsSpUrTUGvmiXNEZjBFRGZ5UJIireFEZHWmleL
         BjpBhxFaOslXGqIDEOE+Q9ZdUltclk7xSntG0mHlx9OVmx4qZ+8cE3282OiJu1h1I0Mc
         A4d/TF4164n37OqfPDDa6ifUkJ7p+oJOzIRMcFfFkfJvz84mrOhX2YGIQYMFzrjNYhCQ
         Y0Nc/JRdIxDwJT8BnSJbnl9k6exVS4suEiNW2quLhUv8+b8lGOznINJoonI4Y/WIOiSg
         PxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT5f1K1/J6atjzWzhR2JMa6w7xlCf8Re0VA82IJPO7cyLoy3DIvtSexsKTS5lesE55AcFw08peDYVUjpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJuGR6qXn+pAqixmjycqaLfaeb5oNcYLiJ9Uhy5ESpXbVOqf8
	GJsmYTgAyOct/inr8XKUZVte3FYHQOp49cKVtVknC0ygUBqJ9kPsXUtJN3AGfa2ivTdgVm5qYdP
	SWV4xM6Sawp0ov0vXyYM8SS4d5uoGehq51LkAiFCXwsSNOx0psynnsA==
X-Gm-Gg: ASbGnctQqi0ILb0iHXxI9FWh/HZNQN/OqzZXP8W+MBxq+reppP3fLUZd6ONiRGyBuxh
	EN6+r5R8n4pjsFIgKWoLuI0+bINlg/KLoeRVlzilCFU/Rq0aAZQlMPvtwlOiGH1UUtFAXaOWEaA
	3ClPc1J6KQBBIVTqvJMVkrhnElyECf
X-Google-Smtp-Source: AGHT+IEeJa44o+XSvJZx8Jdms+oYMNreohnRoUx+hnesCryJtVqnxtGNEIN81nIsmMg4dnxmRUZEPcuZvqeWVs6CE+Y=
X-Received: by 2002:a05:690c:6488:b0:6f9:a6bd:2053 with SMTP id
 00721157ae682-6fb32d6daa3mr33461967b3.34.1739456923002; Thu, 13 Feb 2025
 06:28:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-lpass_qcm6490_resets-v3-0-0b1cfb35b38e@quicinc.com>
 <20250212-lpass_qcm6490_resets-v3-2-0b1cfb35b38e@quicinc.com>
 <exyxni7td5vow2n6jarav5euje6dnbue5f5yxzu6az554dthfe@zn5yd2byvkoj>
 <ccc87c55-d157-4ffc-8081-1a5900752931@quicinc.com> <CAA8EJpp7e5q36jGmB-TZX5A=XVGKsDtmBF8kJmxoga8NqGZP1A@mail.gmail.com>
 <c820c697-c3ec-4ae3-9720-fb80cb3a0450@quicinc.com>
In-Reply-To: <c820c697-c3ec-4ae3-9720-fb80cb3a0450@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 13 Feb 2025 16:28:32 +0200
X-Gm-Features: AWEUYZnOrZ0wV8U14CBBJrqDdK_JlTRGkwtYPMzrOyTphzKXgQHiPDt9IEDIQeA
Message-ID: <CAA8EJpon5+R5s0HXUmoikjtuyEf3sQUqBVYvWrxuh14h2DvjQg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: qcom: lpassaudiocc-sc7280: Add support for
 LPASS resets for QCM6490
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 08:52, Taniya Das <quic_tdas@quicinc.com> wrote:
>
>
>
> On 2/13/2025 1:30 AM, Dmitry Baryshkov wrote:
> > On Wed, 12 Feb 2025 at 19:15, Taniya Das <quic_tdas@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/12/2025 4:39 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Feb 12, 2025 at 01:52:20PM +0530, Taniya Das wrote:
> >>>> On the QCM6490 boards the LPASS firmware controls the complete clock
> >>>> controller functionalities. But the LPASS resets are required to be
> >>>> controlled from the high level OS. The Audio SW driver should be able to
> >>>> assert/deassert the audio resets as required. Thus in clock driver add
> >>>> support for the resets.
> >>>>
> >>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> >>>> ---
> >>>>  drivers/clk/qcom/lpassaudiocc-sc7280.c | 23 +++++++++++++++++++----
> >>>>  1 file changed, 19 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> >>>> index 45e7264770866f929a3f4663c477330f0bf7aa84..b6439308926371891cc5f9a5e0d4e8393641560d 100644
> >>>> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
> >>>> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
> >>>> @@ -1,6 +1,7 @@
> >>>>  // SPDX-License-Identifier: GPL-2.0-only
> >>>>  /*
> >>>>   * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>   */
> >>>>
> >>>>  #include <linux/clk-provider.h>
> >>>> @@ -713,14 +714,24 @@ static const struct qcom_reset_map lpass_audio_cc_sc7280_resets[] = {
> >>>>      [LPASS_AUDIO_SWR_WSA_CGCR] = { 0xb0, 1 },
> >>>>  };
> >>>>
> >>>> +static const struct regmap_config lpass_audio_cc_sc7280_reset_regmap_config = {
> >>>> +    .name = "lpassaudio_cc_reset",
> >>>> +    .reg_bits = 32,
> >>>> +    .reg_stride = 4,
> >>>> +    .val_bits = 32,
> >>>> +    .fast_io = true,
> >>>> +    .max_register = 0xc8,
> >>>> +};
> >>>> +
> >>>>  static const struct qcom_cc_desc lpass_audio_cc_reset_sc7280_desc = {
> >>>> -    .config = &lpass_audio_cc_sc7280_regmap_config,
> >>>> +    .config = &lpass_audio_cc_sc7280_reset_regmap_config,
> >>>>      .resets = lpass_audio_cc_sc7280_resets,
> >>>>      .num_resets = ARRAY_SIZE(lpass_audio_cc_sc7280_resets),
> >>>>  };
> >>>>
> >>>>  static const struct of_device_id lpass_audio_cc_sc7280_match_table[] = {
> >>>> -    { .compatible = "qcom,sc7280-lpassaudiocc" },
> >>>> +    { .compatible = "qcom,qcm6490-lpassaudiocc", .data = &lpass_audio_cc_reset_sc7280_desc },
> >>>> +    { .compatible = "qcom,sc7280-lpassaudiocc", .data = &lpass_audio_cc_sc7280_desc },
> >>>>      { }
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(of, lpass_audio_cc_sc7280_match_table);
> >>>> @@ -752,13 +763,17 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
> >>>>      struct regmap *regmap;
> >>>>      int ret;
> >>>>
> >>>> +    desc = device_get_match_data(&pdev->dev);
> >>>> +
> >>>> +    if (desc->num_resets)
> >>>> +            return qcom_cc_probe_by_index(pdev, 1, desc);
> >>>
> >>> Won't this break SC7280 support by causing an early return?
> >>>
> >>
> >> The resets are not defined for SC7280.
> >> static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
> >>         .config = &lpass_audio_cc_sc7280_regmap_config,
> >>         .clks = lpass_audio_cc_sc7280_clocks,
> >>         .num_clks = ARRAY_SIZE(lpass_audio_cc_sc7280_clocks),
> >> };
> >>
> >> The reset get registered for SC7280 after the clocks are registered.
> >> qcom_cc_probe_by_index(pdev, 1,  &lpass_audio_cc_reset_sc7280_desc);
> >
> > Could you please make this condition more obvious and error-prone
> > rather than checking one particular non-obvious property?
> >
>
> Dmitry, we had earlier tried [1], but seems like we could not align on
> this patchset.
>
> If you are aligned, please let me know I can fall back on the approach.

You have been using of_device_is_compatible(). Krzysztof suggested
using mach data. Both approaches are fine with me (I'm sorry,
Krzysztof, this is a clock driver for a single platform, it doesn't
need to scale).

You've settled on the second one. So far so good.

But! The problem is in readability. Checking for desc->num_resets is a
_hidden_ or cryptic way of checking whether to register only a first
controller or both.

BTW: the commit message also tells nothing about the dropped power
domain and skipped PM code. Is it not required anymore? Is it handled
automatically by the firmware? But I see that audio codecs still use
that power domain.

>
> [1]:
> https://lore.kernel.org/all/20240318053555.20405-3-quic_tdas@quicinc.com/
>
> Do you have any suggestions that we could consider?
>
> >>
> >>>> +
> >>>>      ret = lpass_audio_setup_runtime_pm(pdev);
> >>>>      if (ret)
> >>>>              return ret;
> >>>>
> >>>>      lpass_audio_cc_sc7280_regmap_config.name = "lpassaudio_cc";
> >>>>      lpass_audio_cc_sc7280_regmap_config.max_register = 0x2f000;
> >>>> -    desc = &lpass_audio_cc_sc7280_desc;
> >>>>
> >>>>      regmap = qcom_cc_map(pdev, desc);
> >>>>      if (IS_ERR(regmap)) {
> >>>> @@ -772,7 +787,7 @@ static int lpass_audio_cc_sc7280_probe(struct platform_device *pdev)
> >>>>      regmap_write(regmap, 0x4, 0x3b);
> >>>>      regmap_write(regmap, 0x8, 0xff05);
> >>>>
> >>>> -    ret = qcom_cc_really_probe(&pdev->dev, &lpass_audio_cc_sc7280_desc, regmap);
> >>>> +    ret = qcom_cc_really_probe(&pdev->dev, desc, regmap);
> >>>>      if (ret) {
> >>>>              dev_err(&pdev->dev, "Failed to register LPASS AUDIO CC clocks\n");
> >>>>              goto exit;
> >>>>
> >>>> --
> >>>> 2.45.2
> >>>>
> >>>
> >>
> >
> >
>


-- 
With best wishes
Dmitry

