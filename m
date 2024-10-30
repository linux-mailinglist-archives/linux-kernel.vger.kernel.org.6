Return-Path: <linux-kernel+bounces-388542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056769B610A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3795E1C20D96
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A01E7C0B;
	Wed, 30 Oct 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFNKpYhv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1281DDA31
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286206; cv=none; b=F9ZHqReSuvVqizK1wrgHbz97YHsIcXiHwnbPc+k6V568Ooi/ZP++AjQ2fToylTaXhVkKMq3TobHE489bvoMMjj56Ls/drlo3Dzvm5kuG+gSvXy77fQws3RpfOxLJxPoR5B0j+eEh3u5C0K+YnVmpmPWll5ETkwmi0Bl3kogi22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286206; c=relaxed/simple;
	bh=i/sTm2W58aqNc0bvwKrCduULaEOcP81xZKszHJgcu5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gh6EGW7pRDYw3VriDUn6yqAPx4GDgwGnD04KKE9lfAUH9zQ2/5AIbGHKtH1cc7FRzc7n+JbqBUgXzu4tpLaEcTR7lnNa0eKcuEH0y4UpLK/0IHYTztWhFEa44+MudZ8nJqyMwAXCS44eUoIhAmIANxizCMPjkqggrUk8SqsX2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rFNKpYhv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53b15bc0731so858082e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730286201; x=1730891001; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dyDd73LhSa+Aowk0j+nzrmpWsgvv8frt2OywSF7Wle8=;
        b=rFNKpYhvKs8wsIjVxz4uk/o/WdX67f8OTLp38bpJaYEEUt7nPB5M57lNPTEThZUWc+
         EgVGUP2sCJ9ktPD+XKW/CmHueooons9gmMELbSdvhc9N9Z1h2k8H3r5nnDCzQsK3gJUe
         6zE2TgNRplJzSRW9OgSCk19CArglkmrQ0/v8e+b8yxrv3nWPQ6iw43CjiU4L9TEwnz9/
         jmmx0Rw4Fbo5tiFwVL/EWYG6Hr48qXye9XC3Dy9V7J/wX/5YSe+qQA/mBH1w6RN+gmZF
         WtoLP6yFZBKm+YWIQd4uTPUpF/0JlqPlPy3vUsUxrF9KNsZwQMOchUQ+h6IPIpJsKvJM
         W/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730286201; x=1730891001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyDd73LhSa+Aowk0j+nzrmpWsgvv8frt2OywSF7Wle8=;
        b=KoOKAZuSmWass49IEsghMvHMDbuutUgTnh3NYK9vJr3BlATBDS0l+qzB+bGr7xCvl0
         1hVlocECbHslHJx3kXOUJpnOft2tKQ4KapQHxfPFmXTmTjrebweIaxYl5PCBeM54+hKQ
         HKqBSbD3H7dMVbmoo3UhErFZaL5fcRm4EyLIgKck2/+K/JnB3pHauzVxNrkw1MrhHKRi
         0Ezz8LWuvHkr1vsHooCqjvv5NV6cwhBXc1gUnRt95MFxwpjdh7BJxEhzmtxNIIBYk9Y4
         STGtzy49eawrI0pV+uIY8WqyOfA2uzhhZMkBj05V0d8ogEG47tFSmeFwFMEjtYUwwuJ6
         brbA==
X-Forwarded-Encrypted: i=1; AJvYcCVka0r9qwB+f+6XT3Sxz7uZqUtANQAVhA97svY7+vtSujAdYwd1KCuJlxBExNVL1y48qk3GbDfDW97hO90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpbIvNrn6gI9wLmQhRiFxthDP9Jbs4g27wkN9A5Ee2pGSVjJL
	1hUIWl6oWqUObZluWiW1UUwZQFMkXQF3crQLQlhF2YkrhERrNcSXyvPyfW7wUGM=
X-Google-Smtp-Source: AGHT+IFhZJoljikBYl7EYG3OcLL8xTDXcY1FxwXB5w8ypUTn/Fu7ouw0JZgiUeSHRe8KwIvx45FKJg==
X-Received: by 2002:a05:6512:350c:b0:53c:761c:2a07 with SMTP id 2adb3069b0e04-53c761c2d71mr163553e87.6.1730286200692;
        Wed, 30 Oct 2024 04:03:20 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d52d87sm218049e87.164.2024.10.30.04.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 04:03:19 -0700 (PDT)
Message-ID: <dfb7e2ad-5262-4e4a-a49a-584012ef0e57@linaro.org>
Date: Wed, 30 Oct 2024 13:03:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] dt-bindings: clock: qcom: Add CAMCC clocks for
 QCS8300
Content-Language: en-US
To: Imran Shaik <quic_imrashai@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das
 <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241024-qcs8300-mm-patches-v2-0-76c905060d0a@quicinc.com>
 <20241024-qcs8300-mm-patches-v2-3-76c905060d0a@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20241024-qcs8300-mm-patches-v2-3-76c905060d0a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Imran, Krzysztof,

On 10/24/24 16:31, Imran Shaik wrote:
> The QCS8300 camera clock controller is mostly identical to SA8775P, but
> QCS8300 has one additional clock and minor differences. Hence, reuse the
> SA8775P camera bindings and add additional clock required for QCS8300.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
>   Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml | 1 +
>   include/dt-bindings/clock/qcom,sa8775p-camcc.h                  | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> index 36a60d8f5ae3..18cbc23b9a07 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sa8775p-camcc.yaml
> @@ -18,6 +18,7 @@ description: |
>   properties:
>     compatible:
>       enum:
> +      - qcom,qcs8300-camcc
>         - qcom,sa8775p-camcc
>   
>     clocks:
> diff --git a/include/dt-bindings/clock/qcom,sa8775p-camcc.h b/include/dt-bindings/clock/qcom,sa8775p-camcc.h
> index 38531acd699f..36ac587a981a 100644
> --- a/include/dt-bindings/clock/qcom,sa8775p-camcc.h
> +++ b/include/dt-bindings/clock/qcom,sa8775p-camcc.h
> @@ -93,6 +93,7 @@
>   #define CAM_CC_SM_OBS_CLK					83
>   #define CAM_CC_XO_CLK_SRC					84
>   #define CAM_CC_QDSS_DEBUG_XO_CLK				85
> +#define CAM_CC_TITAN_TOP_ACCU_SHIFT_CLK				86
>   
>   /* CAM_CC power domains */
>   #define CAM_CC_TITAN_TOP_GDSC					0
> 

I greately dislike this change, and the reasons are the same as already
given by Krzysztof.

If you find it possible, please follow an approach by adding a new
header file and include a platform ancestor headder file from it, like
it's done in commit a6a61b9701d1.

--
Best wishes,
Vladimir

