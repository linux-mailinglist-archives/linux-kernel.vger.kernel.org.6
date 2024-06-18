Return-Path: <linux-kernel+bounces-220065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071390DC48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA231F23609
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6AF15EFC3;
	Tue, 18 Jun 2024 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSNTP0rP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81C136675
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738166; cv=none; b=DYReRkmwceOXfnbpWsg8aKBBqWIlu1WVBuFczg4z3zNXNgA20oBIHjxfdN6tbqKOH34xmXfqFlmxqOQVtkI4rLas1oLWQWr3/c2Env7oFVpSPTLfNU3SR7ainUdhAjS4xxR4u0noDhqiyMsGPm4Oao7EE1lIMF7t/H6XHd4ESLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738166; c=relaxed/simple;
	bh=TACrqL2IKLNSUk/raSljLCO4G8W1ngIppSQslfB1Q1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t98L77tEFbeA4pBgcseqRYukLR8oys89jWPwIzrVSu+J1U/uMxsOuZxb/1aFERYU5MHmrlNO6KYz66V0EqmcPrDj1DIEOjBJZggxfHaD5KigMRBeg9/teaC3H0PcGp15DJkqamErfo/gbjBxrba250f1oMavtmces6g9J6yHRmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QSNTP0rP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52c525257feso7443806e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718738162; x=1719342962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECQOXrsJUqE9K11MCllBBxGvMWQM8nm0UCcxG5gDKg4=;
        b=QSNTP0rPtDArO09FrpvEKcXrm2yr3vYmVUYx8poIcN3wnOpFVpwr7EXdLG2Np0IIkM
         W7UfmIAXiq+pnWlT5wqBNxPKJQB1iqU1cYM0DzzF4/4zTrA3RAputLl4A692Jsuky8+L
         GgKP0DXXGaBaF13YNbWjg2dSIn37T8PcTtt7hq0Y91GETSipgNPwTz53OpDc/lqTnF5R
         vGNhFZhb++N+5jGRZTK2AyMJ+3YCjpNLVHJcwCTkR6GMmDXr1uqMNPrZZivAaQQcNczt
         lE5vJO3IJbfKfuqZVKbo5nrmpeLSuPWuMaHw13BpWazxiZRnJ6PU03usAzlJbMJt/BoL
         ysvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718738162; x=1719342962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECQOXrsJUqE9K11MCllBBxGvMWQM8nm0UCcxG5gDKg4=;
        b=Sr3YmK+feFfz1Pht3TxbQnFsXv/aTVsLPW310go2LBk+VAq0+lRo22Ep5lB3c0iod3
         Bqqkr7DboGnnRJlS4PgmAjkcfICtJ8gil4w6f4DXNZ+zU29o0KT2Y8gc85IB/3e4l1xB
         FapdHeQ8AXR5+i5nCXBzuqZgo7kc1LbH4IMM1SKEpDHqQSOH3XWAKhl76N/FnX0rrUmE
         g+o/JUOlqts5SP+7h0yCoKvCKe4NmWP3qj5Sw20i72Mt5BLmVwzXlBIdaNjdH29nau5q
         vUJhbql9PFyXdZ9R+h/Gw7mF7ZH69NpQTkL03gl6XQHpQuYRzbeiIyalzDez8IPO7dSZ
         ck0Q==
X-Gm-Message-State: AOJu0YxkXBKsHkEP3y/9vY2P5ENTiskTbwc97FQgIM46MSjI7JTMyZO+
	5rVhAImaClLgborutL0R+1Unfyq6yxb/5zKzLl2nWDpNZfgyu9OLnbKJlYL+awk=
X-Google-Smtp-Source: AGHT+IGlQshmVXLZ1sG8YQepgCvrhHbCGcquy4u7nKJHJooWSW0mg9mEt3h/BZrbEMTcbToiONJ3Tg==
X-Received: by 2002:a05:6512:3090:b0:52c:9d45:6b52 with SMTP id 2adb3069b0e04-52ccaa57a64mr406922e87.43.1718738161725;
        Tue, 18 Jun 2024 12:16:01 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:5d11:7fa7:8997:f811? ([2a00:f41:9028:9df3:5d11:7fa7:8997:f811])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e7060sm234778135e9.40.2024.06.18.12.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 12:16:01 -0700 (PDT)
Message-ID: <2fb391fe-84ab-4c15-9d8f-4119bff0572c@linaro.org>
Date: Tue, 18 Jun 2024 21:15:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] arm64: dts: qcom: x1e80100: Add fastrpc nodes
To: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
 krzk+dt@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
 srinivas.kandagatla@linaro.org
References: <20240618145601.239101-1-quic_sibis@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618145601.239101-1-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 16:56, Sibi Sankar wrote:
> Add fastrpc nodes for ADSP and CDSP on X1E80100 SoC.
> 
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---

[...]

> +
> +					compute-cb@1 {
> +						compatible = "qcom,fastrpc-compute-cb";
> +						reg = <1>;
> +						iommus = <&apps_smmu 0x0c01 0x20>,
> +							 <&apps_smmu 0x0c21 0x20>;

(0x0c01 & ~0x20) == (0x0c21 & ~0x20), is this repetition required by
the firmware, or would it work with the latter entry dropped? (and
all others in this cdsp fastrpc list)

Konrad

