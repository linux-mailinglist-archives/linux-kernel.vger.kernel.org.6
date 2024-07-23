Return-Path: <linux-kernel+bounces-259866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF6D939E72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8204B1C20A25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79614D70C;
	Tue, 23 Jul 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d91vP7H8"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3203FBAD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721728867; cv=none; b=bf1KMB62cZG/YN51LZN3jort8u+v6bB23m2iVBNnll3+jNgjumbWGqosl+/bF4eCWHHkan9likOZj2SxJ/TIr8ZmIwqh5f+EXgTGUKZzBDkuVe8ZNyNl/kPDv9FX8aCLN2HWHAHC1O12jJ+VPLH8EiDJAt70jdlppASTMREIntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721728867; c=relaxed/simple;
	bh=vZZxV+o5uLF2qP1PaVWTk6ApupXzEVaSuioE5+fq2K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pfq+4pIjn8pDiTDZI8jxBCukrH97W5JBMv+VLzXBx9WRdITP6wwuoF+YLURRkoSfttMWB1sTgdD4lY4vGKhYB+ioZbY0YpuPxzizphy9ftVF0obfnmwsxwjJjO8sO0agxcqlOgIdRJ7vs0n0G8HROiWFViVl3UtPQDiXhB1oZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d91vP7H8; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1954649a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721728864; x=1722333664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JEzMe1jgFBvGgofA2N54tDKb0RkrlcfD1n3rhARXK/Y=;
        b=d91vP7H8I87u9SdApHz1N5C1cbvs3m/5KriSz9psSpmgHHKafQxjtMH9f7wGVOsFJ9
         4cBu/xxG3w67iIFBmymCaUCzeK3pNeU4egOvW/WNcnCfBJ8W7PDdVSetN/VtV4f0/jKF
         EHWKJEf9nS2hrexQoprSesH2k948w1aeul7PfzIW8sbhvFjMkLi+G8zn1hPvkcKndGnW
         oaLa/LOUSWoG1oYxdN+V2r0gI22d5nF0IfZImcgqQTklFxt/cUqG0VqJ6u9hVLzF7C06
         aEafqszeiXHtsOVR38SMklJ25fVU4w8BC8HODIGFX/PQXbivj7j8W+UV5Xl5dQyw/hqd
         4sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728864; x=1722333664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEzMe1jgFBvGgofA2N54tDKb0RkrlcfD1n3rhARXK/Y=;
        b=hoGDLpTZlD3gHy1uMP1OUvpPOLEPpLk7P7XCp0X7biOfWHpZD0Q6XVGe7QH/NhiKbi
         CeDbIcE/8g4sAAWMMf+f54eO4oIwKQPIoJDeTjcmHFkK9C8tjF1R5VUZ1P6i7dyw8aot
         WMJKS0CapdV2Cva7dpdALrmgwf5iQJtlAF/kZDWCwvB3STviV43j+ptaXjSXvcqH/c9l
         Nz/ALegkFDSfKqP0aCdVHR1bY4VrwnJrw06u9FTkb4wUXZLtIkpRj6s/pGBedSx6ClmB
         DUD9AeaZJIit/ZKlb++3qkPVp+9HcoUn84unCAXaOWOD7Rfv99t+sPM7jyhmKs4yla5k
         coKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+qSTfjiigC+kIdSwQvD8sjXZHIv9GzQo/oeH1xBNuIp80qN0+wcPbS5cEFdHIJFETjVvvvJerxaHBlY9/EnlS1oCK92dOcvyGe5Sn
X-Gm-Message-State: AOJu0Yw6SaRxDdcqUgnHSxoMvS4w1cOC0EJ4cx+gJwarQMc4xhtgH1xy
	yu9Ndyd2ncDQCjVProwJJmLkcQeNGAzTZB7zAH5P/OKW5a4o77A7hC+H+LMi2Fw=
X-Google-Smtp-Source: AGHT+IFS/1YgwAOld8lTPSrjJAre4y00U739hX/8hG/SGCzxgliAVIWdabGNx/FzTBA8ecUgvO06VQ==
X-Received: by 2002:a17:906:7315:b0:a6f:5f8f:6c43 with SMTP id a640c23a62f3a-a7a4c44631dmr811217966b.56.1721728864118;
        Tue, 23 Jul 2024 03:01:04 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c785d7fsm519732666b.29.2024.07.23.03.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:01:03 -0700 (PDT)
Message-ID: <2448216d-344d-4ffa-826f-d077ab9b1958@linaro.org>
Date: Tue, 23 Jul 2024 12:01:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm8998-lenovo-miix-630: enable
 touchscreen
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-miix630-support-v1-0-a6483cfe8674@linaro.org>
 <20240722-miix630-support-v1-1-a6483cfe8674@linaro.org>
 <cac3d7ba-2a62-479d-94c2-c6dc4d7a5ba2@linaro.org>
 <CAA8EJprROf-aJgJvUMb3D+dCzOUO-eRzM3khM6ZY8b+z+_gByA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJprROf-aJgJvUMb3D+dCzOUO-eRzM3khM6ZY8b+z+_gByA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.07.2024 3:09 AM, Dmitry Baryshkov wrote:
> On Tue, 23 Jul 2024 at 02:22, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 22.07.2024 1:57 PM, Dmitry Baryshkov wrote:
>>> There is no point in keeping touchscreen disabled, enable corresponding
>>> i2c-hid device.
>>>
>>> 04F3:2608 Touchscreen as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input1
>>> 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input2
>>> 04F3:2608 as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input3
>>> 04F3:2608 Stylus as /devices/platform/soc@0/c179000.i2c/i2c-0/0-0010/0018:04F3:2608.0001/input/input4
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  .../boot/dts/qcom/msm8998-lenovo-miix-630.dts      | 28 ++++++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
>>> index a105143bee4a..118c55f5bcfd 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
>>> +++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
>>> @@ -11,6 +11,24 @@ / {
>>>       chassis-type = "convertible";
>>>  };
>>>
>>> +&blsp1_i2c5 {
>>> +     clock-frequency = <400000>;
>>> +     status = "okay";
>>> +
>>> +     tsc1: hid@10 {
>> weird (and unused label)
>>
>> very non-specific node name too
>>
>>> +             compatible = "hid-over-i2c";
>>> +             reg = <0x10>;
>>> +             hid-descr-addr = <0x1>;
>>> +
>>> +             interrupts-extended = <&tlmm 125 IRQ_TYPE_LEVEL_LOW>;
>>> +
>>> +             pinctrl-0 = <&i2c5_hid_active>;
>>> +             pinctrl-names = "default";
>>> +
>>> +             wakeup-source;
>>
>> double tap to wake? tap to wake?
>>
>>> +     };
>>> +};
>>> +
>>>  &blsp1_i2c6 {
>>>       status = "okay";
>>>
>>> @@ -35,3 +53,13 @@ &remoteproc_mss {
>>>  &sdhc2 {
>>>       cd-gpios = <&tlmm 95 GPIO_ACTIVE_HIGH>;
>>>  };
>>> +
>>> +&tlmm {
>>> +     i2c5_hid_active: i2c5-hid-active-state {
>>> +             pins = "gpio125";
>>> +             function = "gpio";
>>> +
>>> +             bias-pull-up;
>>> +             drive-strength = <2>;
>>
>> Since there are no other pin definitions, you can do better and not
>> copy the old rotten style ;)
> 
> Both node and pinctrl were c&p from c630. But was is rotten here?

yes, we stopped putting a random newline in there quite some years ago

Konrad

