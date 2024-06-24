Return-Path: <linux-kernel+bounces-227332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3697914F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0404280C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C08142649;
	Mon, 24 Jun 2024 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gjTQCABB"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180713C90C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237996; cv=none; b=iLMYWWwneobA8Ido+2ImLPixEYuu3h0eEUglNt/Q4xEvs3W8MHJu532gDKjhx+zvNI/HlvQlZOVIws03bl8XxJDis8v62H/2j+5MbJ703kp9oerjP3iRe4nSz2JnGLWKYxmrSd/3haXW7NaKIiprIYn1UBiW9YqfFoXN2yLRTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237996; c=relaxed/simple;
	bh=7r0Fd+Gct293vxrUPs9IUd5DYVSIwzojAlXfyigd2yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i38ocrVEfR78bqTayv5UiH7rXYC+/xEDNHTOLOsPzWLWGn0X9Ep2hPWhqSh7kqqOimoVz06aRjlKzXgOcHmU1VIom8AlWO6Gq/3PuR07BAeTnhXbPI1pQXPXI7mTOjYxYWM2y18kI/KQZmwrrTPzmAWt4F+76ZnkXZpXZvC30gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gjTQCABB; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so51036671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719237992; x=1719842792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br/bfMy698eaHPBHFobm+lhTqSfDhm6FM3UGgSs9wVY=;
        b=gjTQCABBnSPLVgyRl6E+cZCI2xqOu0GwBQ9mKnoyiMVtAZvQNqjDXCojI+OX2G0bX6
         x8sgizpqZpQLdqjbSc0oy4znbl4SY/oWDIV+3ohvjzcIPiLG8KjVeZ0+sBUjFsBcxKVt
         9z7meBu7Mboxi9eJTC3S6q7k09is7WrxvJHpLUwcMrbUAI1YKvS0QolPWh7BKjSxEtR3
         5JoJFxMoYa7b226aQakO/hDwDBXadj9h+T6GeRiXKW4FI15CQ73AvMnAE1Y2qCWKqM+8
         Oew9cTX6c8HpR5lgY9UK8VwAmoAEGOApK3jfgHHC5BUvCNu/Dpzq43f0VjPdDVWzwSym
         RtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237992; x=1719842792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br/bfMy698eaHPBHFobm+lhTqSfDhm6FM3UGgSs9wVY=;
        b=vyS9UcegtUl67Eta4YFNcIKzkzhXShdK3WH3ecmWC/5BGIdZnYTcRiSKGWYo8JHjEK
         oDLTxWz1N7gKtbTaJt1uWkvhBKSOPmGOsiP/FBnUo1UxD3VnvsGZqKgxrVcPypT2hHwb
         uCuKKLuArH1zUaGWGrjOchLZCJlDfiOw68JeEaLFyBZb1Qz4GrB1xecbTppRN7MQFBvl
         k3WYDaRKN74hMHgjbuvJiRTHAbXt8kEj0E4EaL5ayR8pDuMZ3rv23MDVuHMz4X9FP21p
         ATqMo2A7kfbN/ldzTyvGYyJk3LCFdqwe6uUbLvbXoCJXHzYdnuuprJgdTxIPituswG9U
         tNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUkkjYceJjkDtOQl0JHRMToEhhfJXz7RKbbPdaDCDMv8f7lENGdKvVxxe+HiFVX+ssLC4bYL5+6k9yFAxIHfsw/t2dYRUQoQ/0Yl9bQ
X-Gm-Message-State: AOJu0YyOtCi7NjZb8C+Ir0DGZCQETgfRXK59bYc/Zy/9fbRsX80pPO5L
	HGBjx1vDT2bdCVsaB2AKc53fJs0lbUzwFpDuLTNVMbhXsrwN7QruFKV6F/aaRrg=
X-Google-Smtp-Source: AGHT+IGBSD0M3AUdujBciwVWcZpdKLsKzF8yl1H7y1uyhiRnYA+q9nUuFFyookmuvfhj2CLXjQg2pA==
X-Received: by 2002:a2e:a403:0:b0:2eb:e3a7:8b with SMTP id 38308e7fff4ca-2ec5932a10cmr41288651fa.26.1719237991629;
        Mon, 24 Jun 2024 07:06:31 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c03:9198:7df:6a16:3e8e:ed7b? ([2a00:f41:c03:9198:7df:6a16:3e8e:ed7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3058287fsm4727289a12.95.2024.06.24.07.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 07:06:31 -0700 (PDT)
Message-ID: <ffdfa775-b84f-4c20-9852-b210d42dc8d4@linaro.org>
Date: Mon, 24 Jun 2024 16:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/msm/adreno: allow headless setup on SM8150 MTP
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org
References: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/24 21:34, Krzysztof Kozlowski wrote:
> Commit f30ac26def18 ("arm64: dts: qcom: add sm8150 GPU nodes") re-used
> amd,imageon compatible for the SM8150 just to enable headless mode due
> to missing display controller nodes.  This work-around was later
> narrowed to the SM8150 MTP board in commit 1642ab96efa4 ("arm64: dts:
> qcom: sm8150: Don't start Adreno in headless mode").
> 
> This was not a correct solution, because the Qualcomm SM8150 SoC does
> not have an AMD GPU and the SM8150 MTP board does not have magically
> different GPU than SM8150 SoC.
> 
> Rely on board compatible to achieve the same in a Devicetree-correct
> way.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Let's just forget this exists, this was a hack from the start and not
a very necessary one given display bringup followed soon..

This should be handled by a module parameter if anything

Konrad

