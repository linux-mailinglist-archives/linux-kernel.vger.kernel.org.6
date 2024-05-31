Return-Path: <linux-kernel+bounces-196810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E26B8D6206
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFD71C247F4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6B158D6F;
	Fri, 31 May 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldGx+YGr"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F2E155A32
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159231; cv=none; b=UH4fnDN25Dxik2xJp9/lDLZCET9PuVYLLPRTNG1rTOB8EGzMR8r8fsZY7IWxwchlXtxmPGyASYrlBORLu0q06Q5H+XUpsc7POXwM+3q8QVuPGqioA2YUYVBqMAF78TccSBurcUpchVjTfkivZoakls1Ouya3xuo/FDM1J4oXq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159231; c=relaxed/simple;
	bh=op1s5LXJeDvIiFLVtFiSUNyEX/0wUdZkoRh3R8wmvrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l9JQhC7bzdYYeFSCtcGDXMKLutUxdcuq0OAPT0mHJD+abafdA5w/E26jhJv7Clsx89WTwWIVG9tS+jhHFpSAtwChq6ocLWkxuvAFh2WXBv9DLFJtYD/L0SXHVma2jxkfBbJWd6FIEGt17b9J474MZn4dpZT0cZ1W5h8sewE09EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldGx+YGr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a634e03339dso124170466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717159228; x=1717764028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr4ROrwcZrcWqPJ95GYGx0z7Cv4z3SOwstAiFPVmsvE=;
        b=ldGx+YGr5I2gyFGB/hW1lYOU/RzmbipqHz3s/pBE558sdnGisTYDVKC0LpmntZ9+fK
         etR1q+iWHn9/0fAZ6wIFYRaQUOXlM+ilt1goqL14E5HKi6xmh6wRoDEaLwlYvtemtyvN
         Kba0CDxSEmImIMPWGmwaOp8MrA+BIJcqYA+PTHgtSaPZaJaWQgYZQ/dSrm7FQZPVc24y
         uTvtF3hRZtSiOIjE8W2bAQ6gUSk6AY5H/fp8qxghJSGyeykBnjMoRwN4Z+YKUycKH66O
         CnbRcJA1gs+PZH3VeBbxIIVMTjTmVHCLYvMKXYFo3cgGQssSLMkdVUW9k+8F3aYgffwd
         3gpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717159228; x=1717764028;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr4ROrwcZrcWqPJ95GYGx0z7Cv4z3SOwstAiFPVmsvE=;
        b=hdk84rqhqU9+ecJvEYW8hVYYQvLYN6aQ3cZe1MlspEB0jnJREuzQEqaZKRAN44KYR+
         wUW+hdRKqYypZdIREGl2TpIRmInVyKVqUY16xjpg1pyyr9G0h9ryFKSGCFYiCS4oK1Wg
         Ef5T01FznOXFa4xPDhxMCeZNHEjS/H7wC1s/rYKO8MzQZALVVvDg5Z4S3fY7X8Y5gMra
         lxWVfBs36dPxWb9X+FVu7Zk/1c1KegScDKNMHL3qaNkusFdQic7A7woMcllrv9Me0yAU
         Hx6+HHk6fWBgihH/QaGUIjm8Ob8TilfpOiIVT69P7CmpbSgiSlyYVPJmsFtWEk34HSyw
         oPCA==
X-Forwarded-Encrypted: i=1; AJvYcCWjKbBmSVl7y/0/esUgqfXYqKikH+XHQjLFFcu8YUiw0kUmzESes/ONUI6sxhVPb7svFOj7AHMjcM2VkYPqM4/9jhDQ4uZ4zn8rR0h+
X-Gm-Message-State: AOJu0Yxq4tJ5R0+xXzKMO83LdE+8reCZez5EaMpHium384lhIB5QezJL
	efHlguRXSVGlNJMb7JBEywpNYlWE5VdgSGkixm1ML36cGFOgBktCOmeJgolaPUM=
X-Google-Smtp-Source: AGHT+IEsfT48tFHWLoL4tXmC/aQoVny3jpqEWLohZR2KED+a33g+XlLwB+vlllg6ZOS3lwfNrrYyug==
X-Received: by 2002:a17:906:c511:b0:a68:8853:36e3 with SMTP id a640c23a62f3a-a6888533738mr73438966b.21.1717159227971;
        Fri, 31 May 2024 05:40:27 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb6214efsm82677266b.220.2024.05.31.05.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 05:40:27 -0700 (PDT)
Message-ID: <ed5754fa-29c9-4a3e-b961-decadfcd7fc9@linaro.org>
Date: Fri, 31 May 2024 14:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/15] arm64: dts: qcom: sa8775p: add a dedicated
 memory carveout for TZ
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Elliot Berman <quic_eberman@quicinc.com>,
 Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
 <20240527-shm-bridge-v10-15-ce7afaa58d3a@linaro.org>
 <8f3f1e88-426d-4254-a31c-afcb88fc08f3@linaro.org>
 <CAMRc=MdxP5MWPhbq6u8WHRpm04F0iijeTpG0q3D9q52e7xfcsw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAMRc=MdxP5MWPhbq6u8WHRpm04F0iijeTpG0q3D9q52e7xfcsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.05.2024 4:39 PM, Bartosz Golaszewski wrote:
> On Wed, May 29, 2024 at 4:26 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> On 27.05.2024 2:55 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> Add a 20MB reserved memory region for use by SCM calls.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> index 31de73594839..c183527452d7 100644
>>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>>> @@ -208,6 +208,7 @@ core3 {
>>>       firmware {
>>>               scm {
>>>                       compatible = "qcom,scm-sa8775p", "qcom,scm";
>>> +                     memory-region = <&tz_ffi_mem>;
>>>               };
>>>       };
>>>
>>> @@ -418,6 +419,12 @@ cdt_data_backup_mem: cdt-data-backup@91ba0000 {
>>>                       no-map;
>>>               };
>>>
>>> +             tz_ffi_mem: tz-ffi@91c00000 {
>>> +                     compatible = "shared-dma-pool";
>>> +                     reg = <0x0 0x91c00000 0x0 0x1400000>;
>>
>> How does that size relate to
>>
>> +       pool_config.max_size = SZ_256K;
>>
>> in patch 3?
>>
>> Konrad
> 
> Short answer: it doesn't.
> 
> Slightly less short answer: this is the limit of *this* specific TZMem
> pool which in turn gets its memory from the shared DMA pool. We can
> have multiple TZMem pools and they all share this DMA pool.

OK makes sense, thanks

Konrad

