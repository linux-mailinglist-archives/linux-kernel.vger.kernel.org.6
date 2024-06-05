Return-Path: <linux-kernel+bounces-203086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E78FD63B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722981C21EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB213B792;
	Wed,  5 Jun 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKdDy452"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB813AD38
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614467; cv=none; b=qxi9ArgL5bSjjN3ILqm5U8GpKGqnxOiSRp8RLcLbltdGAUwf4iofExnrEOECRopCA20mkD1K/0kyHBXa2bPx+KDLmJHdz+aaRqh8poCclrhirZ62c4MnpmhOtWtzPMYazO8h/GSck6m12H4c8ybaMw2N+004q1XKpexZhxrvGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614467; c=relaxed/simple;
	bh=cdOYaJ07tJq85PvmM8XoPZBMscSvuRmlPOg751Y++Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mB3CYNaH07svcxj6xgTwE0CbK34fWC97Dzl0+Ld4IVhjiQV+k2i/DA0UGvUNvqDPkBxFWqLhtWEtmVPAb2fgXmT2/aVVn51aSVshek6Pv1sumfcTuHEcWeQC5kNO2UDyZgDi5wy3lwcd7fMpqH8dbipRIQBUkZjOjoXccfeVbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKdDy452; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6c399dbb38so21226966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717614464; x=1718219264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hPEClXGXe2Dj1qtdIRu798YmzXY+/HU7ZIgSfhJTo54=;
        b=DKdDy452XCaMHDwMBMEd6CNMLCJy1F9eC7CfgHLG75ZBE5CuHMvt0K8OiNM8kNMaKJ
         0gzlccOV9GQYC1BF7xAcInVVStcNTMb7LIH6P+wFNMIgL0O/aKhP8tpW7vSs4RxY4vuR
         bZlH8hYuI0TJy/VhpLgRcrnIoSYsJW75vCNUnxAdlMR4M2iOjz4H+wL9v7klhPOw1JMr
         +bzcEtwNZZ5rofIqYT/CNjSaxo8g8Nb8KF0KUa3+ohTLHBrFfS6nRE3qbjBKdxXiNZRk
         W3oJS1CjnlbmJKV7nV8KEd3bxgb1nwjfmowwengK4BMUOYpYu7Nvvt1oRBRdQ0RHbt1X
         0IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717614464; x=1718219264;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPEClXGXe2Dj1qtdIRu798YmzXY+/HU7ZIgSfhJTo54=;
        b=aDKHfwJSzByegyEa4b0bYCzjQBPR35yeiT1cG9DP/zB1mTFEd8TpTz58ShdRpfS/GY
         18berOFyhLw7Gp02vrl26/4e3sFU+PGVIrwVKLUWBM9mLypi+2lmIYPZ8W+43B2ZyeQq
         Wv0rx5pULarR5RhmIWd/ctBIm2Oixpu2hxV0hf3e86Y9GPX6lBeKoms4gWrsbFIW+bYt
         3ObmTW4p76a0uK1ACjJ2TEt4AMLyEq/BxPJSCJex/3tJIyxPKhnG5320sSzryq8DFzOP
         flQ0QhShDiT9y8HwGNrELZHvmLZEjFTRTqSUlJgfmTVsrL3aphlpr2ZAchOZ7aDDwS7a
         9zWw==
X-Forwarded-Encrypted: i=1; AJvYcCXvEnvnHcg75yo2BcRxCKZ9pOqYHuAPso3pGWuolbSn77+zI6De49QJcSnl/vc3AZjzPywDYfML7nsVaGfb/jpbLc18+yMiOaxCQckg
X-Gm-Message-State: AOJu0YzDUpKHoR9/30a58NsdICb406fNMtJXc4Lv5n3W/4WEpSOwKT9B
	zq+dwn3/Bh7Rp+6oaNUSPsG2S+ZMo9GiNMzxa6guAvoCG/V8PIZnJH5I1d+ZIPU=
X-Google-Smtp-Source: AGHT+IFGh2vtAmxaw64X6C18FcCCGny6E8kgDoJ4oamr/Pr2/7c6ckx4TbHoIQ/iHO9D5KkZ+TZlEQ==
X-Received: by 2002:a17:906:f802:b0:a62:2eca:4f13 with SMTP id a640c23a62f3a-a699fcdfb9fmr222676566b.59.1717614463806;
        Wed, 05 Jun 2024 12:07:43 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6b437b7cf3sm113900166b.136.2024.06.05.12.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:07:43 -0700 (PDT)
Message-ID: <2fb85bfa-bd48-496a-9e59-11b2af0b607d@linaro.org>
Date: Wed, 5 Jun 2024 21:07:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: use defines for interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240605154605.149051-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240605154605.149051-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5.06.2024 5:46 PM, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

