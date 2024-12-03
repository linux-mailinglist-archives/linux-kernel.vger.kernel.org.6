Return-Path: <linux-kernel+bounces-428846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEB49E142A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C496B165E43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70261B1D61;
	Tue,  3 Dec 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b3WbDip/"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A018B484
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210623; cv=none; b=qNQCoJ4HQ+LI3Ohe7h6SRbtBnaZrcjFGglA6FyA+LaHdemVg/OoRgdQ0fp9nnuU5GuakBdEa2jEDp2TSGnD3IUxwsyZ4CUuKrrjLvYoPoHA3fAJXofDEdOjz7HVM+J35OIa55V7SUuv4hdONXXCsTxTHy1VEagjv8E5V8jmdQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210623; c=relaxed/simple;
	bh=sfsrLHQenVwdb3gi3yEoCkvl6ivRHHYrDS51eqUQFvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGPfXGMVJVbVZ2xdwUhJcl+DXFgvtUrMg9spasdLtbfuYP7pV0tZv6ID3/8mHIE0aZTkxTNo4Aji6JV8PvUs4kYMje0irTEIqdEbc/uf3odnWFtdZd71D62qCkNPXXAaEA+Rp1aZcTBOHAN/x+1g/6lpSDGQsPlGxqxhaHlQ+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b3WbDip/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434975a1fb1so4635845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733210619; x=1733815419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/91xuqITk+GltGA0sI0HtdBhv+y0RGaZqN6WSvqLMfg=;
        b=b3WbDip/Y+u9FiiRSUCJO6KCKPpCNtRnsdZgrZaUtwThSj6jSVXjRDQmEe/mfhOzu9
         YR3M2vNvldWo57UoDHtGeGIa7BKK0vQaUX7Xf/rDcSMiQkt9FiggGqznNrlLVnOTfRWl
         gSvcZebKiJj36VL18PKuv1V3PekiQfZEm7alFWGURFRbOCFZfl9z7Xx9mS4GE98TJRi/
         aLXnpLiFOAga9vjeJppYEWQIhqs+TKoqOWGAj0Dafk1jOhuQfxnpVbI7ymcFPAPuY5gk
         mRfLjGcIcmF9Y2MTmWawoC0IaMA8DfNJMwJdl8IL+D8cgtCywrPrU0IOvxtGmqDC4kAA
         XKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733210619; x=1733815419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/91xuqITk+GltGA0sI0HtdBhv+y0RGaZqN6WSvqLMfg=;
        b=Wf0POLfuHDLMP7zDAnnNTgoxzn0OPq7hP0pqSPcXmqGK714M6IVODiOfBoR4Y84Vwj
         uCuEZ347cQHsNAl3ivJc+Yj7jr5mfSoqUfBoE3gtw3bzUOQlzvYbYQWTgcqIvr7sVOk3
         aWvQI3juKrbuPU+sv84L3J/XpItdMuwlFU25p2hiTIkwiCLs51h8/RLMjHwuVGLCGT6Y
         aI7nY4pfGQMbW3mpspDvPIeFRPQngxpvIvbn6OZiFu/1MBZUPcT/iLGZezf7Zz/Ih+Ju
         /qXVSXkvUovQV+13/Y0xoWGYBYrQV2/96u3LvmouIPp1Ju/FJUDw+QA/MEErmlkT6S+m
         ncDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvQ6U6f9bxiJfEZO45Tpi1QpQx7cGfOPJ4yHuOY0PuwUQOnQRqQB24lvSlJ1OWAjpBPXeJ4KEwm2oR/uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr/dpTO20qjBhykM/r63jdeNJd4BSYF/Us9xNmfirp8Nmg6j8y
	20F54cqOgcVQHX0bxp4QHxZIiTFoOGa7a8F+kU7ubkDqiX6EUvqeNMuq/yfH3rI=
X-Gm-Gg: ASbGncueuZdnbCjEPyYmXZx12N0grFFdPGau8v0+oL3tQswwKwoMM7wkeozAJMZErQ2
	8JxgE7o0san99nESUch+JqJdl9xYsuq96COs2L5SCatU1vPqd2r/tfKmsTg8XgNCnfe3v+L6bTZ
	ZHJQn3RHsekoWhFnHjDb3Uup06c6enxRvO+JWuTuOhdjEu1Lrv2kn2eKRsdLr2uxMGY2xSq2Y5Q
	UnlkSXP9ehHdaGB3u8KcV+uBl4znWTE9/JxuOHtJNMz61m9etgk1nAh4oZzU9XoCbHj
X-Google-Smtp-Source: AGHT+IGEf4xa3iUiO68cVMCRutIBsMDpZkfAInNM5pRE6IApqH/YMYOCMXQv0XInIkRbVlFj4ThwWA==
X-Received: by 2002:a05:600c:511b:b0:432:7c08:d0fb with SMTP id 5b1f17b1804b1-434d28e4323mr451805e9.3.1733210618676;
        Mon, 02 Dec 2024 23:23:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc11sm183154845e9.4.2024.12.02.23.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 23:23:37 -0800 (PST)
Message-ID: <e5960ea6-c3f3-4cb4-a93d-adff20a665e2@linaro.org>
Date: Tue, 3 Dec 2024 08:23:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: pressure: bmp085: Add SPI
 interface
To: Vasileios Amoiridis <vassilisamir@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: ak@it-klinger.de, jic23@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
 krzk+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 devicetree@vger.kernel.org, ajarizzo@gmail.com
References: <20241202181907.21471-1-vassilisamir@gmail.com>
 <20241202181907.21471-2-vassilisamir@gmail.com>
 <173317237354.3142409.6212368803030680874.robh@kernel.org>
 <Z04u8eAvytu-y8LH@vamoirid-laptop>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Z04u8eAvytu-y8LH@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 23:04, Vasileios Amoiridis wrote:
> On Mon, Dec 02, 2024 at 02:46:13PM -0600, Rob Herring (Arm) wrote:
>>
>> On Mon, 02 Dec 2024 19:19:05 +0100, Vasileios Amoiridis wrote:
>>> The BMP{2,3,5}80 and BME280 devices have an SPI interface, so include it
>>> in the device-tree.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
>>> ---
>>>  .../bindings/iio/pressure/bmp085.yaml         | 32 +++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/pressure/bmp085.example.dtb: pressure@0: interrupts: False schema does not allow [[25, 1]]
> 
> Hi Rob, Krzysztof,
> 
> The error is in the example, I put the tree from the I2C example to SPI
> but I used bmp280 which is not supporting interrupts. Will be fixed.


So you sent a patch with a known bug or just did not test?

Best regards,
Krzysztof

