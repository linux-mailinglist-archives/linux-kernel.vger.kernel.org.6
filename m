Return-Path: <linux-kernel+bounces-356377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB79996032
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2FC286B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 06:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51F178CCA;
	Wed,  9 Oct 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eRhoejCl"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196FB176AB5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456957; cv=none; b=lp3bieeq2VH9D2+Xb+OKongH4Z4ZTByhnOCkvnVEuhpnh79OCsIWDIVQznuDmTc18g23oRGrIcpXVvT9g4vhzvEy43weIokjga1BDbl97tjAs+URgM1YKBpDkuOh2qgck2DGVr0ikp60JbmnlkxscrIZHsKAGx5MAYxYx1BNvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456957; c=relaxed/simple;
	bh=pt1PQMbPj+Pd9Up2rbNY0I505K8DYi/p9+LsajfTys0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7QQgkuejetFey/EIatfrRvuJ5gVct18umx8w8b9ToytKN5wc98VZI0GNewpXk+FigGwUQC5j5ag54lEz0dkL+MfIUZRhsX7wicso5I/haOSr+n814/48l49yA5Gly3zQckxm/IePXZquU9KOMT6C9IOPBbR290zYh2t3q2ps1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eRhoejCl; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43111bdd54cso456435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728456954; x=1729061754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EgjmkgIrV/gtaFSxU9cvRbCwWx3x0uHJ/WhOdWwQDMo=;
        b=eRhoejClgBbZSL1XRpV86w3A3/v8QuTft6YbJllHRNvKF2u7rEtt5dz1IAIPR2hoxz
         9pR3MlAbqVGA2SWwaZEQbkbaD4eHfuKxXJbHRDEkiTKuKC+AJHAQ9tHIdnjCTv7DmT/S
         RLpCir2hSvKzvsom+qbD8X/ddj90xBaY6KD1iR4IU146EDIEhWZFGuv+JCnSP09Y4VW3
         g1u300gIBFlechuf/TY+KYvJf7xLvDrFyvonV2BzOE7bH/dNivbkp3sri7nS9XefOZwI
         gZenrVpADtFGwALprOpPYr5/u59Evk6Ry8cVCgZ3Wsg6SJVrsDmpbm646/Fc1/8exgbh
         QIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728456954; x=1729061754;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgjmkgIrV/gtaFSxU9cvRbCwWx3x0uHJ/WhOdWwQDMo=;
        b=FZHp8FPJUuCp4pXvxrGNXfyNhyKG95WpQ9gAzqQBzU5RQ0HnBcExOqETriPsbcg+dH
         PzdDLzsmjCSuA9+bHbQTNz6lCGdYVfez25oXJbMEPKMWpYjjbgctmKR9ljWZbOWdkKZK
         AGNsjSPYvohypFKoxOeltqHVqTkxeO/47AN+SI0wiBu2A2r6dTySYrmtGg6CWElKsCL1
         enIIxc2caayrdBJ+jWYtIteAKt2eLon+YacKKDV5PGjvNhfxa+mN6pPy1Anq4ttoAxkW
         H5pMn40z+sFhU7CNPN10AsBwAZl0affPZyD1w3f+V+nXJiQbBuybXvX9LLLwVMFdbzUR
         Qtwg==
X-Forwarded-Encrypted: i=1; AJvYcCX3RdDGFdICBkwSsuiJkKa0+VQQztgTE2fU1NLwyz4Dr/kBHJtT5T3q/4IlRJTcFdG0IcDsc/+k76DNzcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0wbhpyuFwEw2x+FbQ6OyzEqTJ8ZBZOY6N/e2olHm1B66a9kcc
	dpP39dXfMD1zWCxldHNJ3q7GVDfESHL2SjQ+kF4xLGnBZirMBzF1M7ZGOPYxhBY=
X-Google-Smtp-Source: AGHT+IFPtrLdjE7iFQ7Rdhn33t+yPBCIM1Ua2NqrbPmh37NA/2qsCvom+ESFAdsBNjaAPHLU2Tjr/Q==
X-Received: by 2002:a5d:5989:0:b0:37c:d226:b8dc with SMTP id ffacd0b85a97d-37d3aab17afmr382171f8f.10.1728456954378;
        Tue, 08 Oct 2024 23:55:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f25asm9578692f8f.11.2024.10.08.23.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 23:55:53 -0700 (PDT)
Message-ID: <7cfa0ccd-2fb3-41ed-ac4f-8ca9bf29514b@linaro.org>
Date: Wed, 9 Oct 2024 08:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: arm: qcom: Add Dell XPS 13 9345
To: Stefan Schmidt <stefan.schmidt@linaro.org>,
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, robdclark@gmail.com,
 peterdekraker@umito.nl, Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com
References: <20241003211139.9296-1-alex.vinarskis@gmail.com>
 <20241003211139.9296-2-alex.vinarskis@gmail.com>
 <CAEvtbut-boW2nrbUTXFkvZ8N7qA_OtNz0dMPzRq0OYu4oF+jmg@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAEvtbut-boW2nrbUTXFkvZ8N7qA_OtNz0dMPzRq0OYu4oF+jmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2024 23:07, Stefan Schmidt wrote:
> Hello Aleksandrs,
> 
> [Again in plain text]
> 
> On Thu, 3 Oct 2024 at 23:12, Aleksandrs Vinarskis
> <alex.vinarskis@gmail.com> wrote:
>>
>> Document the X1E80100-based Dell XPS 13 9345 laptop, platform
>> codenamed 'Tributo'/'Tributo R'.
>>
>> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 5cb54d69af0b..7c01fe30dabc 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -1058,6 +1058,7 @@ properties:
>>        - items:
>>            - enum:
>>                - asus,vivobook-s15
>> +              - dell,xps13-9345
>>                - lenovo,yoga-slim7x
>>                - microsoft,romulus13
>>                - microsoft,romulus15
>> --
>> 2.43.0
> 
> Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>

How do you test bindings? Running static checks in kernel tree is the
same as compiling software and adding tested-by.

Best regards,
Krzysztof


