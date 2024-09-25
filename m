Return-Path: <linux-kernel+bounces-338234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAC98552B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4F31F244D2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE149158DC5;
	Wed, 25 Sep 2024 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQJGgLRW"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2515854A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251812; cv=none; b=Ty2RIqk564LFmRRE62x9JUfZyD1iBZ+Z7Nk9P9vXJ+xkGf+VVZXQwDKD278UQuxj8q8ysCAr+rpa0SYvU0Q9PoSfUYPKdjDtlMMiLeSFJR4Etigzx6VIeXKztPZroPecsCX6kKpDNhLo34cjRKANijFbJ7qH9E9RI8JT8M99nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251812; c=relaxed/simple;
	bh=sZB9n34CcLPl0nWGOJgnnEBbCgjDELU7h6pclwNEQL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+87RhMWLuf2UDsfuREajLhamtb5ksRY/4dlgNBvVBwzPDHMNOXaSlqtGSn/UgJW83qa23AuorJCbdnt1dBONmSo4AzCkDWtrcjwUJx5OSAKzR6qnq4P3/kPcwh9GBo5uPjpUcOk21HBuH7fgpm+EbqNaGTAEj8O4ojvP6oSi/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQJGgLRW; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so7062380e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251808; x=1727856608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfkhxXida/JtPWb46vC3Gc6jJkDn6NGPvPLqIzfsxSo=;
        b=fQJGgLRW4OoeWs1wt21MRFoIzMm+Ka4FkmGwPMsaU3It8rS9NELj/RIej2YUEsaBAP
         zyQDfd8k1mBsAYzoonCVbhZidRYOPW1C1Md0axEb7EGu5BEzue/RVxvsLPPhqZDuw768
         SN0awIXGaOWQw6HekxYxa9rb8rUBY1MSqonike1DS//VDKuV9JNwmMBtXOsZb44RVl6C
         12x00ECkki2wmwp1PZ5siyk77FoBCAikGF64u9JFc31KtAfaO3ukGaDJSrmYlFKguFW9
         buJJ9iPmbLa9JTQS0mN8MMedDXK/AMx+zp1aPrWkgVKQstXTgiLTqdKM7IoBmCIe5enW
         nVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251808; x=1727856608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfkhxXida/JtPWb46vC3Gc6jJkDn6NGPvPLqIzfsxSo=;
        b=wAZUIqlBfKHZhccnkojMA4OUb0lWOHyVu+dzlbER8ewzls6MzveW5e0bitD9Skn8E3
         kj5x8+kfu/ISxsDN74ybG3Ov8yF4k26TnY5pHVfi5P4WbgGpfV/L1KFnu3fmWto4Tgd8
         6BeaQA5Py2EbnSLLzYeyriJj0HwWx+/Ukmv4LUpgUDzYjp18RFOmAfwTj8XcvKzAFQ9E
         zdIzmXW2Ls7U31sz4Fh88qK7L1pmkawZjBpvxgiIR2LrV1AIw2r9XY+BpyZiVFJhav5Y
         mJinMTXLf3quGEBMFTY9FM/gY5gw7/D9OYpLsWTbtaW0Kt9qn3klx5a1pyl6/pHw59/m
         3wfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrRv7gnG3fOtv4pbKEqqcxoArdVZm1/USmvdSUyLyPeJd8yeFEbXasXWlSSCrSXXO/QVI87vpLu5bounA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZk6shq4p8neo9CCM6qepBNyW/vxvhCoXvTulGGtcakZjoAxbN
	TpmI6HIqu6qeKhCFYhLVROKStr5/UHh8Ee8LRMuPEOmcdsGJEf64xqJ52iq6SM0=
X-Google-Smtp-Source: AGHT+IEkIryks9bO0m+SnMav0JRLez4R3+X6hqtElvaJDmvGZVyqLI3EEhEEL/QFVZHuL0IwsrfB6A==
X-Received: by 2002:a05:6512:1043:b0:533:46cc:a736 with SMTP id 2adb3069b0e04-5387755b712mr1033267e87.37.1727251807861;
        Wed, 25 Sep 2024 01:10:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85ee58fsm451808e87.70.2024.09.25.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 01:10:06 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:10:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document QCS8300
 bwmon compatibles
Message-ID: <7ld327om75xpz53fb7itxp2i7gjqvhavywzuhmf52myynawwvo@rmb7yimjxxmy>
References: <20240925-qcs8300_bwmon_binding-v1-1-a7bfd94b2854@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-qcs8300_bwmon_binding-v1-1-a7bfd94b2854@quicinc.com>

On Wed, Sep 25, 2024 at 03:45:06PM GMT, Jingyi Wang wrote:
> Document QCS8300 BWMONs, which has two BWMONv4 instances for the CPU->LLCC
> path and one BWMONv5 instance for LLCC->DDR path.
> 
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 189f5900ee50..251410aabf38 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,qcm2290-cpu-bwmon
> +              - qcom,qcs8300-cpu-bwmon

In most other cases qcs8300 is being declared with the compat fallback
to sa8775p compat string. Is there any reason why bwmon is different?

>                - qcom,sa8775p-cpu-bwmon
>                - qcom,sc7180-cpu-bwmon
>                - qcom,sc7280-cpu-bwmon
> @@ -40,6 +41,7 @@ properties:
>            - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
>        - items:
>            - enum:
> +              - qcom,qcs8300-llcc-bwmon
>                - qcom,sa8775p-llcc-bwmon
>                - qcom,sc7180-llcc-bwmon
>                - qcom,sc8280xp-llcc-bwmon
> 
> ---
> base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
> change-id: 20240925-qcs8300_bwmon_binding-641d8e4bf376
> 
> Best regards,
> -- 
> Jingyi Wang <quic_jingyw@quicinc.com>
> 

-- 
With best wishes
Dmitry

