Return-Path: <linux-kernel+bounces-441566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F89ED038
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A8E16A69E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082741DACBA;
	Wed, 11 Dec 2024 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZ6aMIe7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C141D31A9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931896; cv=none; b=eRvXNIE1k08QWs/EqaPcclLv3YGm8KZf1vjpLkzqcp/WA+HwGrYaC4HjxgP8wDwaZMNZfyhdhUClUz0GcrtTCkk6SmCIRoKOKLnsKR+xorSfiEpVNHSDWWG1jgGH01jLXpedA5+IxH1PN0Oa3Z6OZj6NB0+ICMG8yK0KOXIrlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931896; c=relaxed/simple;
	bh=Y7RUfnCiAOKkUerIqaBCl0TUIFGov53LacoipgJNjPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPx0KwAWFE5asXXWJkeuPcdFKCWWOQJ7Sm3lKe8DjkfkFK/DsbFXE/rmK3CJp771aTt/nklg7H2PTUSayI6Nok4bAq7yzzqJqZ3rXBY+KjePKokOEXptgzSxpbMhXaWNWo6hUPyDi22uIq/boy/voU48aZt6CJEbZ+vWmaKKUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZ6aMIe7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a2033562so59309055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733931891; x=1734536691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBmna7+6RMIWIREX03MVhyyHeHj5nS5NLCMMk7SB1Kc=;
        b=pZ6aMIe7eYcI80OMcQgywNLBmxx+zZtOtQGjflMD+DILV6NKFxFSZ3YeCAtMHwHKUP
         KVXf7D6VFsfTJBLLuLsBxsO8HicK8Ub5tYFLBnzqmw+mj4K0fuf4YOG/j/u6ZuD5G9k6
         1oh82fOxNMPA9K4tEhZswbcvbpbP88hOu0GoSnRhwALU2myveTI5T2pQPL8U4s6mcBBc
         n4Ma7WUZugsr2qzYh7uhDMQIzEGzz/SRaMvJg69hGqZ5qJ0OSqls+XfSC+TXN0o1Dkee
         gkjyxPeYmGDU209HDTBKACWSdO73TVktB7TRbIJ/jUHvdvUhUjSCdmQPoZfRvjT3bh+O
         6Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931891; x=1734536691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBmna7+6RMIWIREX03MVhyyHeHj5nS5NLCMMk7SB1Kc=;
        b=BhON1Akk8G8aZkCFaeFrXax9yWjG1POOL5EteFSQ65hvgOqaay7zLGYH5bPo5pqUz4
         7lLB2zCsQ7ST1mOIjedUMJfQ/v5vFZ++NHVIawqfnHa0pjNvP3BQAjhrQUuybYpCm/jh
         wI09n+sJ+bHk47raeljrW9HwYeoFkfx3ET+pgJofN0Nja0dI+wqqSzvDY8XCOtRiLWgs
         JQXuXzFSGp3CP5QvW94TOiyb1CcdvFMdxbOvEFeTjCCBZX2/siB7gt6QllHJJIHZzhVD
         77oZf1qYoH1rgxMEkjTTCGepd7pPZ6vs1s8/utg8WkmukuETAhiL3JZLmKdnshvZ9H03
         TTwA==
X-Forwarded-Encrypted: i=1; AJvYcCUPkel8TBVSWx6CeCyt2vexj1PuL9qYIZqME8aRlSAcvqVoZzB6r4uGLYWPv2c/D2gRtHSooMcmFjco9U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQSDdWLBCTxrsRaiEorI51Rpl73aetW2xX+u5+9qXvEv0JRno4
	l3V+YwlmLUoZOrM43KMuabPAYvfk6Of9LOu4+c5XMU0TD+0yXqtodyY6bdmHcdg=
X-Gm-Gg: ASbGnct3J0KJFY25koWa6zYyO2HrTPAsJ/7ADvdVwbIAD31g6bfQTjsUgHHpi0NQ0XE
	SL/jgoAOQvNPsJnEhDrXwsAjOxXMITfC/hZqPE399lQ1pHUisyuQvpgyeDFYRpeYiLSP/As6inb
	dmG3TrQtwAFEve8Gk+B4HSrjao7b6gGpfKWx7kXjnTKUz1WbUZWc56J4mKx0FuFrVz4pcCTRzky
	d5ddxbbw6ZADVZQpV7Fy7StVEb0oLKw06q6xTst1HdtNDQvV6yTMT2WEycRaf7Z+a0=
X-Google-Smtp-Source: AGHT+IEWZzmBMWvFGvTooD56kxpnFOuI8vUWhZdHT9OAfinfrH9O5pPMEGROg6P7/K5rwwn2X/PyIA==
X-Received: by 2002:a05:6000:4807:b0:385:f092:e16 with SMTP id ffacd0b85a97d-387876c41ecmr45709f8f.55.1733931891604;
        Wed, 11 Dec 2024 07:44:51 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514da2sm1521777f8f.66.2024.12.11.07.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 07:44:51 -0800 (PST)
Message-ID: <12dabbc6-5813-4369-b882-2fc72333746c@linaro.org>
Date: Wed, 11 Dec 2024 15:44:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] media: qcom: camss: csid: Add v4l2 ctrl if TPG mode
 isn't disabled
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-12-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-12-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> There is no CSID TPG in some modern HW, so the v4l2 ctrl in CSID driver

"some modern HW" => "on some SoCs"

> shouldn't be registered. Checking the supported TPG modes to indicate
> if the TPG HW is existing or not, and only register v4l2 ctrl for CSID

"TP HW is existing or not, and only register" => "TPG hardware exists or 
not and oly registering"

No need to abbreviate hardware to HW.

>   only when TPG HW is existing.

"when the TPG hardware exists" you could also say "is present" instead 
of "exists".

You have additional whitespace in your log before " only"

> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
> ---
>   .../media/platform/qcom/camss/camss-csid.c    | 60 +++++++++++--------
>   1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
> index 6cf8e434dc05..e26a69a454a7 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid.c
> @@ -760,11 +760,13 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
>   	int ret;
>   
>   	if (enable) {
> -		ret = v4l2_ctrl_handler_setup(&csid->ctrls);
> -		if (ret < 0) {
> -			dev_err(csid->camss->dev,
> -				"could not sync v4l2 controls: %d\n", ret);
> -			return ret;
> +		if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED) {
> +			ret = v4l2_ctrl_handler_setup(&csid->ctrls);
> +			if (ret < 0) {
> +				dev_err(csid->camss->dev,
> +					"could not sync v4l2 controls: %d\n", ret);
> +				return ret;
> +			}
>   		}
>   
>   		if (!csid->testgen.enabled &&
> @@ -838,7 +840,8 @@ static void csid_try_format(struct csid_device *csid,
>   		break;
>   
>   	case MSM_CSID_PAD_SRC:
> -		if (csid->testgen_mode->cur.val == 0) {
> +		if (csid->testgen.nmodes == CSID_PAYLOAD_MODE_DISABLED ||

if (csid->ctrls ||

feels like a more natural test. Less cumbersome and also less typing.

I think that change should be feasible, could you please update your 
logic from if (csid->testgen.nmodes == CSID_PAYLOAD_MODE_DISABLED) to if 
(csid->ctrls)

Otherwise looks good but, I'll wait to see your next version before 
giving an RB.

---
bod

