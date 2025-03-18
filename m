Return-Path: <linux-kernel+bounces-566989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A7A67F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FE788537B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A820766F;
	Tue, 18 Mar 2025 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nuSnVjyS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FC2066EC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335911; cv=none; b=SAj0KlOfsSo5VBJlOmm5aBYjSa+pgJP/NtvgDDo6eb8jqO7sjcFZRveIR8PukBVhsamwfFUINnO9QQSCssDmEW4ZlQjta2zz+djzaYbV49El6juMthEZenmxsr1LxMVZzuTSKoXG3ImP0u5854XuhU5/u8cL0F/ug7dLYjeOBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335911; c=relaxed/simple;
	bh=9gh3xtWkal4psS5BuhqOt8wWpRdxFLmYUUTWbCZ71kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4TizI6hP4B2gerWeJ+NJWx5iMvHuV/lfGnctraRS0jUnhBlejHL2FKe2sF0pAOyItyIZ6mVaZerKTAC52iCXuZADZV9EoLSwKgIrTwrDjHCs5N8WLPoyfsqN8J7FyrwSOutUYIuCg4HNRLGCUsqYnPkkQeJsW5ReKlF6zotdho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nuSnVjyS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1173068266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742335908; x=1742940708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD9NpfmchfroViUWqm7KH0wfqC0Fje7BCCs4RB1DhO4=;
        b=nuSnVjySH4YigZml0f8ir9PDjzVDTmd4hJn+OoIoaVAEsevb4aXfyX6YZOBvCJJ3MV
         0Vb8PuTKi8gRlZ5+Ztx4QWzuRhxAp9tSZagQlCtauiXFaDn6/oNGNZOc2quErFrjMGmr
         Q0E6CCeRBTKpBEOPlOGew3hAHSq9KFZJrZ42aoqbN0Hp8JClYpDaAFZPZpMQV//fIxWT
         98d5xoUqWQeO9IcIGM/Gq7aXEF3EP7mTjZVXpkdFdAegTv/QUJyNQTGsP/omLtoG/I14
         KJ4GOiWDWCuI5RfWPjVSi2hP310YYqCVkbaizy9Q9nZthAyKRAYV0poY7HxpZ11612Sy
         x5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742335908; x=1742940708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD9NpfmchfroViUWqm7KH0wfqC0Fje7BCCs4RB1DhO4=;
        b=wM4aary4T/SdExv1319+NJ3hlvO00wcNqgBRP15TKXF6fjzmf9CUqaexpcdWgabPHH
         vMjSl5D2jB7YeWrTQJfM7x/MmVFmXqZKiOWMrs+aiqMisz+yzc/5i2uirjWC+X9xxZYx
         Hix0V+P0bR6dLqLy3OMUvWj/cW7kaLtCZbOcprohavIqMddPYUGg/Ek/DY3tc1jY+m5o
         C3IxZqVWq1GqyrMnx0+PYd4ChL15AZ51ECxpl8aaSwA6GcAw9Lhg6VuEwWr/hoNQNf0O
         ljgCqo6JPJLw4LVi4GNsxYoxIw3Ah1E1U5yAGhUMMZyBt7YwmV+X4K0aGSF1J45vsO9i
         a4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXKqN8OBxeXmz5jl33kD2XZtKCPNZ+TGF5N+77DrXbDrK573QyKq6WTxLNbQpE/oKf4Rc+beo2D8VHL64o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87Zt3s/lhqfR76Ay63xIq8Im1DJWb9h/EnVS9g+U1aCnaP3cJ
	zXTPZJqoXKuek0RtzmfEWdPG+bVci4Agn2ccPHVG2KOqll0S/QI4dJ/uHSZpLvo=
X-Gm-Gg: ASbGncsGnNBzfqExyDNX9xEUMenVJcLgBLuooaqj+SPNWogujz9xPcwkGhp8jc9/6AH
	S574wjyjnNaNg1MYBvvd9lT/a9v90K4SGzsX8kUFLWQLgyRsBvamJE8SucfrsuVVlO8sCPIl/k4
	UY/4YnasUlQcAqUkwlZBbm62HjjtCCk7/J82H9UV0p/9ib8PvhZMbQi/zwvyXVS4SQ4z4235++x
	rKUsr5s1gstVXuGR+ONw/8TU92fw+HD6QazlPuwr+QA4y9Ue3gxC11atxZV0Imq8Dq14Iw3z3HL
	tAIZZNWKC0Ho5LDf3CMFZKLkfu7R9pOhx5Wk7YKhfESmqfE/Gz+KZrAMyJmupb9z0KKAu4wc8a3
	cQmJb41gD+YDayc6/SkI7oXl74GmR9qMZ5NyKXvl5vbxw65HEVeNNUVG2niTJ3laRQtyd7hVX9X
	18ueB+Z04z+10knHzdy0LeI2/TYD3Lyes=
X-Google-Smtp-Source: AGHT+IEXE0inCD4aajK8MsM22xf4Qjmf2+sGSHBGZhUMUr3KQpAvROEQ6rhZOgUPF7EZOPYuIMSKxQ==
X-Received: by 2002:a17:907:d7c8:b0:ac3:3f84:4055 with SMTP id a640c23a62f3a-ac3b7a97443mr34239066b.4.1742335907931;
        Tue, 18 Mar 2025 15:11:47 -0700 (PDT)
Received: from ?IPV6:2001:1c06:2302:5600:7555:cca3:bbc4:648b? (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149ce9a9sm908266966b.110.2025.03.18.15.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:11:47 -0700 (PDT)
Message-ID: <cf244e11-96b3-49cd-8daa-df9c91435e6e@linaro.org>
Date: Tue, 18 Mar 2025 22:11:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for
 video GDSC's
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20250218-switch_gdsc_mode-v4-0-546f6c925ae0@quicinc.com>
 <20250218-switch_gdsc_mode-v4-2-546f6c925ae0@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250218-switch_gdsc_mode-v4-2-546f6c925ae0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2025 10:33, Renjiang Han wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> The video driver will be using the newly introduced
> dev_pm_genpd_set_hwmode() API to switch the video GDSC to HW and SW
> control modes at runtime.
> Hence use HW_CTRL_TRIGGER flag instead of HW_CTRL for video GDSC's for
> Qualcomm SoC SC7180, SDM845, SM7150, SM8150 and SM8450.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
>   drivers/clk/qcom/videocc-sc7180.c | 2 +-
>   drivers/clk/qcom/videocc-sdm845.c | 4 ++--
>   drivers/clk/qcom/videocc-sm7150.c | 4 ++--
>   drivers/clk/qcom/videocc-sm8150.c | 4 ++--
>   drivers/clk/qcom/videocc-sm8450.c | 4 ++--
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sc7180.c b/drivers/clk/qcom/videocc-sc7180.c
> index d7f84548039699ce6fdd7c0f6675c168d5eaf4c1..dd2441d6aa83bd7cff17deeb42f5d011c1e9b134 100644
> --- a/drivers/clk/qcom/videocc-sc7180.c
> +++ b/drivers/clk/qcom/videocc-sc7180.c
> @@ -166,7 +166,7 @@ static struct gdsc vcodec0_gdsc = {
>   	.pd = {
>   		.name = "vcodec0_gdsc",
>   	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> diff --git a/drivers/clk/qcom/videocc-sdm845.c b/drivers/clk/qcom/videocc-sdm845.c
> index f77a0777947773dc8902c92098acff71b9b8f10f..6dedc80a8b3e18eca82c08a5bcd7e1fdc374d4b5 100644
> --- a/drivers/clk/qcom/videocc-sdm845.c
> +++ b/drivers/clk/qcom/videocc-sdm845.c
> @@ -260,7 +260,7 @@ static struct gdsc vcodec0_gdsc = {
>   	},
>   	.cxcs = (unsigned int []){ 0x890, 0x930 },
>   	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> @@ -271,7 +271,7 @@ static struct gdsc vcodec1_gdsc = {
>   	},
>   	.cxcs = (unsigned int []){ 0x8d0, 0x950 },
>   	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> diff --git a/drivers/clk/qcom/videocc-sm7150.c b/drivers/clk/qcom/videocc-sm7150.c
> index 14ef7f5617537363673662adc3910ddba8ea6a4f..b6912560ef9b7a84e7fd1d9924f5aac6967da780 100644
> --- a/drivers/clk/qcom/videocc-sm7150.c
> +++ b/drivers/clk/qcom/videocc-sm7150.c
> @@ -271,7 +271,7 @@ static struct gdsc vcodec0_gdsc = {
>   	},
>   	.cxcs = (unsigned int []){ 0x890, 0x9ec },
>   	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> @@ -282,7 +282,7 @@ static struct gdsc vcodec1_gdsc = {
>   	},
>   	.cxcs = (unsigned int []){ 0x8d0, 0xa0c },
>   	.cxc_count = 2,
> -	.flags = HW_CTRL | POLL_CFG_GDSCR,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
> index daab3237eec19b727d34512d3a2ba1d7bd2743d6..3024f6fc89c8b374f2ef13debc283998cb136f6b 100644
> --- a/drivers/clk/qcom/videocc-sm8150.c
> +++ b/drivers/clk/qcom/videocc-sm8150.c
> @@ -179,7 +179,7 @@ static struct gdsc vcodec0_gdsc = {
>   	.pd = {
>   		.name = "vcodec0_gdsc",
>   	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> @@ -188,7 +188,7 @@ static struct gdsc vcodec1_gdsc = {
>   	.pd = {
>   		.name = "vcodec1_gdsc",
>   	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   static struct clk_regmap *video_cc_sm8150_clocks[] = {
> diff --git a/drivers/clk/qcom/videocc-sm8450.c b/drivers/clk/qcom/videocc-sm8450.c
> index f26c7eccb62e7eb8dbd022e2f01fa496eb570b3f..4cefcbbc020f201f19c75c20229415e0bdea2963 100644
> --- a/drivers/clk/qcom/videocc-sm8450.c
> +++ b/drivers/clk/qcom/videocc-sm8450.c
> @@ -347,7 +347,7 @@ static struct gdsc video_cc_mvs0_gdsc = {
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
>   	.parent = &video_cc_mvs0c_gdsc.pd,
> -	.flags = RETAIN_FF_ENABLE | HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>   };
>   
>   static struct gdsc video_cc_mvs1c_gdsc = {
> @@ -372,7 +372,7 @@ static struct gdsc video_cc_mvs1_gdsc = {
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
>   	.parent = &video_cc_mvs1c_gdsc.pd,
> -	.flags = RETAIN_FF_ENABLE | HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>   };
>   
>   static struct clk_regmap *video_cc_sm8450_clocks[] = {
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

