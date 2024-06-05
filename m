Return-Path: <linux-kernel+bounces-202853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B28FD1F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BD5B222E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617B13AD29;
	Wed,  5 Jun 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNlOdUK/"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DE61FE7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602221; cv=none; b=G6cD4IfCuniRL/rUpHlk5wyaDpkqWH2XtfCXTNVvUyxHWNyAFJS9dZjNzVmouHjfRueVEGji1YHpMbQ/eMNC5/1wKTlqmzbS6NQJ9hYWBEzj8A54/iofddyNEYOr+gpsXNjdGK/C6NEjILAXSf/rDjBns5qoDAXCxZxkfnxcMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602221; c=relaxed/simple;
	bh=r7AF1H4t/e8Cb6bYImT0UIvbYyWSEBzlg3YT+4mzoMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4WKosFTUraVwWbjIKnuoIH+4o1occrgnDlHetWGdz9BW3gmw2/QyXlV46d+iLtfUSsi+8669pukzc7ZPBkRyt4WGIy/bX39hWYkNS/BvvdPY4sc3YTiyYc9o6kuUAWOexvQr2r5sArAtzh4plQCF3yLym0lN4YjgdbfHXDaCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNlOdUK/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4214aa43a66so20566985e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717602218; x=1718207018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0+jt+svp4dtTLfgw0jvtxY2NcaAKn29/05gU2X9cLq8=;
        b=SNlOdUK/2ZIRRVKWFSQOqWD1VFW9ElDg1Ud4XLxQPxVfhG6KZ4V8iaXEE4O/9jdXvq
         5azx6D56v5ZGdPHR1qhJcqInl7+rcT6G0OJUvn5BW9N3N8FCUKVDit/ueHQQFtx1oDIr
         apPOpY56u9XpvGJ1DhRMk6tdtKCwn8wMldx/vGRh0cYJFl5t3GA48x8yZbdY/y9iPgLp
         zX9oBJNXWz+udaFB+HbbIXUHZ0LlvP7YuqTbxvzynISxYkXJETpIeOCP4wbRIM+FXBiO
         Clyn64ttxqSuoHrviDQbFPVNBnp1MKU1zRRjvqvaep/BU7Vdfe/ADGCtkj4HVKTGsAYZ
         sNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717602218; x=1718207018;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+jt+svp4dtTLfgw0jvtxY2NcaAKn29/05gU2X9cLq8=;
        b=ZomgRBXEDkyK6PR73yEYDtjSmE7Fzh+29QcR5aDmonZf3J/1z9TH0yrXS8HWXJVJ0o
         Y3SIHS57fWRNislelS6ELp8n2TfvCKkeR9MM4m5s4NdokIHga/CVR3b+YMwQ2Ee6NK3q
         jCo39MP85luj3ouyIWB8IPYSQH5ESkd0y7BTxjgsKOFaQLyhxNqdW8wOqy6Pfuz6MOUs
         DG3xwiJbhvkidEYYGxYwywcN9Lnsj120lE0dT/+38KTB6EK3orlGaM0b9Mz5VUaok+HP
         jwhsE3NH3oJV7wsS+EqLJ/Igknj5cRNnysTyLalMdRBJFbq0FAFGBum+/VK81/129NeH
         Yckg==
X-Forwarded-Encrypted: i=1; AJvYcCVBJSZEr2cg32hZdDzcPE6hpInZdq5NVrYPIbixNWABy7BvsRYfbKyJjxlACLyqTg4lYEEwrHfYKKxehX980VrVoa7+cUgDQCkEjJXQ
X-Gm-Message-State: AOJu0Ywxb/L18kHNyLZqWov0QlNg5gk4ukD+yqT/eK6qrgQ95sJXqku6
	uQJoGh4UToEAcjtiaVWFpvOMcypEvZDxoJfOrMf2CKX/54W4a7P8FvcqZ9JrDlY=
X-Google-Smtp-Source: AGHT+IFrd6DkpsWvOk7GGwKHbPaKXbTtAd4DjdvLuuuA6VmG0ApKEj20EsVUCqXQDkPiWLs0J3zDuQ==
X-Received: by 2002:a05:600c:35d5:b0:41a:aa6:b68c with SMTP id 5b1f17b1804b1-421562c6d0dmr22362585e9.6.1717602218422;
        Wed, 05 Jun 2024 08:43:38 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158129434sm25610815e9.20.2024.06.05.08.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 08:43:37 -0700 (PDT)
Message-ID: <7ebe88d4-c44f-456b-9d26-77c45cc63010@linaro.org>
Date: Wed, 5 Jun 2024 17:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: qcom,sm8450-videocc:
 reference qcom,gcc.yaml
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240605-dt-bindings-qcom-gcc-v2-0-f947b24f1283@linaro.org>
 <20240605-dt-bindings-qcom-gcc-v2-1-f947b24f1283@linaro.org>
 <e989c960d72a3838178edbf43eedd02b.sboyd@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e989c960d72a3838178edbf43eedd02b.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 17:07, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2024-06-05 01:09:28)
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> index bad8f019a8d3..74034e3f79b7 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>> @@ -39,26 +36,17 @@ properties:
>>      description:
>>        A phandle to an OPP node describing required MMCX performance point.
>>  
>> -  '#clock-cells':
>> -    const: 1
>> -
>> -  '#reset-cells':
>> -    const: 1
>> -
>> -  '#power-domain-cells':
>> -    const: 1
>> -
>>  required:
>>    - compatible
>> -  - reg
>>    - clocks
>>    - power-domains
>>    - required-opps
>> -  - '#clock-cells'
>> -  - '#reset-cells'
>>    - '#power-domain-cells'
> 
> Missed removing this one?

No, as explained in cover letter this aligns code with Dmitry's
approach. power-domain-cells must stay.

> 
>>  
>> -additionalProperties: false
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
> 
> Why not have a one-cell-clock-reset-power-domain.yaml binding that
> combines all these things? It's quite common even outside of qcom.

We also have required-opps and power-domains... I am afraid that after
such simplification someone will come with some differences and not much
of code will be saved.

Best regards,
Krzysztof


