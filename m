Return-Path: <linux-kernel+bounces-259932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B593A00D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE403B21777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986831509BA;
	Tue, 23 Jul 2024 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPzeiLoo"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DA1509AF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734757; cv=none; b=fwpHG+6S+ptQcWPKo8PccGLw/7bQNs9TlpMiqSCx/v3k90oi56dj9ZmhOg4TiA0BDqbuZMV7mEiNkQLaT2oeTmTRJuogwg+5gGD0Qt69AgIspPcIHRteakIKq98G66vwx2csLR1swexmkVIJRU3AHSMgRdaH7QzaSO1vkW2AUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734757; c=relaxed/simple;
	bh=acW5W+OygGwF9SS7kS1AMBkddSkj0uZgXOs19B5T1Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoQDN6OpoyK67SrtBtpYHSUEKb2UjN7l0TDMI/ql8VKFE7oKrmnbgILd5F7E8b2r3ESkz46rTJGe48c+bleatUnd7V++6SDznk/AM6rK88YJfxdYd0HYGHpCM9iI3k2/xtdhAqVKtLUDqCF4j8y6IUPbsNpi+SXYEIv5jE5I8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPzeiLoo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9a369055so50172566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721734754; x=1722339554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6/Uxh/6nNW5ReiyhQSLZggnAlfvN5TnKG6ZCX3EasrE=;
        b=GPzeiLooJheeZXZJiO+UuZVEibzbe6SkMoVe7NJsUM44wz6jjCDT4xMlw4oKDHqM7Q
         naM4kwEt01b93xebGzNBNYjpGfn72l6o1PNSMaoBrwhkZFuQPQMETRpaigw/WqgNCKHp
         4YVgowmMLgBXSnVI77qLKsuaoWyuYkQbjtjZ25OIWg02tHDD3rdJ2LpTAu+XisixdxM0
         OT4oNnTglXx1+I51bRtKbvtEzHlNaDdOHfmsQdXHlPXt3ycl9B3o/3QXpva1I4j7sqXm
         ijMUwM37MgsJRWjwDWsgXRgR1cB+aVFfVHVEGY5MA+8YjiJ/6pOgHxJV0tswlcYKUaaQ
         xwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734754; x=1722339554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/Uxh/6nNW5ReiyhQSLZggnAlfvN5TnKG6ZCX3EasrE=;
        b=BNJagHuxkrXwp5+JbHlhemJC6dXrhhQzBvyCehsBSLD/lzuSXaDyxM2gcKa09ZR9L5
         fzYDzK5gQHmzj3RiorKYfvGvR9dE0XKuGvM+hg48g43q768B78ZEYXxGsT3EU/ONz5cD
         xgpLQapo1k61NKhpNJjavJmEafSF3gJPl4mEf/e07f7LkFfIr/CDLKSXY8Q89MWai2fX
         C2w6Iu6iyJroCpsfj8Bgj5fFEh6SWT7R9FY9oNWqfpDWhl0N7/8TfQBBLqiPnpbzcGbo
         EbXxddPzJ+QEPL/xsZZM9pQ0h3BzYVcfJKi/ykrmBZVsT2MQAz4ET1JM0C86DN1+ohrj
         JPJw==
X-Forwarded-Encrypted: i=1; AJvYcCWcfBW/HHbwQfW1o8PpTYMS7qMTyRHznB4bJAvC6rUGnDvOOmSh8njDkKnxmHry2yeiPkBAdeqJ2SLrO0S5/7Jh8LzUkhSW6Ih/nhbG
X-Gm-Message-State: AOJu0Yy4Q4iRn6s9+PyvoAbNEx7Dl/RK7jtEtsJQPR4l9DsWcc8e+IHj
	Jm9NUsU2xkg9oKdjtcg52In+RECGaY5EjyzuCJHzvY9Nvzo07LPz3N1fY9nBlSUew5AmypMJbtR
	4
X-Google-Smtp-Source: AGHT+IFiBVpdEBWMYTik693R523F53am4Iv+TapZOZmU0S/S0/2HglKeeLr75FQq8beSUDksdymt+A==
X-Received: by 2002:a17:907:7f0f:b0:a7a:a6e1:2c60 with SMTP id a640c23a62f3a-a7aa6e158c1mr2039566b.61.1721734754205;
        Tue, 23 Jul 2024 04:39:14 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8cf9f4ccsm88771066b.87.2024.07.23.04.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 04:39:13 -0700 (PDT)
Message-ID: <df3bb042-1fb6-46ef-ad6f-1cbe0a380dd0@linaro.org>
Date: Tue, 23 Jul 2024 13:39:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: pma8084: add pon node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rayyan Ansari <rayyan.ansari@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240722-pmic-bindings-v1-0-555942b3c4e1@linaro.org>
 <20240722-pmic-bindings-v1-3-555942b3c4e1@linaro.org>
 <umsttn5qdjzg4cmgwya53la2sd57z3kxv5wo2b4nwme3jlthis@4vn3vwnlldkp>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <umsttn5qdjzg4cmgwya53la2sd57z3kxv5wo2b4nwme3jlthis@4vn3vwnlldkp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.07.2024 1:35 PM, Dmitry Baryshkov wrote:
> On Mon, Jul 22, 2024 at 12:47:57PM GMT, Rayyan Ansari wrote:
>> Wrap existing pwrkey node inside a pon node, to conform to dt schema.
>>
>> Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom/pma8084.dtsi | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
>> index 2985f4805b93..dbf7afcbfd8b 100644
>> --- a/arch/arm/boot/dts/qcom/pma8084.dtsi
>> +++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
>> @@ -19,12 +19,16 @@ rtc@6000 {
>>  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
>>  		};
>>  
>> -		pwrkey@800 {
>> -			compatible = "qcom,pm8941-pwrkey";
>> +		pon@800 {
>> +			compatible = "qcom,pm8941-pon";
>>  			reg = <0x800>;
>> -			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>> -			debounce = <15625>;
>> -			bias-pull-up;
>> +
>> +			pwrkey {
>> +				compatible = "qcom,pm8941-pwrkey";
>> +				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
>> +				debounce = <15625>;
>> +				bias-pull-up;
>> +			};
> 
> It might be worth adding the resin node too, see pm8941.dtsi

This is a cleanup series, adding features is another thing and it
would be nice if somebody could test it

Konrad

