Return-Path: <linux-kernel+bounces-571321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD05A6BBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF19189283D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCE222B584;
	Fri, 21 Mar 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biNfksZS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56822A7F4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742563610; cv=none; b=MXdz+T3t03vTjP3Bxh/nEwXi7efnkaO4kJrZOSPX0qiA0IqdkPVU4XabEp3g+kchHUsPwrFu0vweldp9k2WA+FoMT1W/zj5nW4dKsGlDN1fx4V59TnEPWEMBOtfj05w18uOtqtJ+q5bCAti1PqTiO23G6Yj1FyaZQUbSmsZpJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742563610; c=relaxed/simple;
	bh=xMeqGv/jZySimNc6vELEg0wI4OT6OHTVxuOS/HRWpzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYal6y7vw6yIceIc39+wxuCCBXRwPxo38cEC59/ttK0M4ETuLEL3DLqsipDozT41YKmxVHxYmyp+B5BqgI6qRew8EwTBVRs0LPMGlLp7mH9/cRc2W4GFLQqTR5EtzttdiFvNvYf2qvgy6h/dtHV/c0NQqHVD8YE05YUOpnJ4y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=biNfksZS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1182212f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742563606; x=1743168406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+nfdqXMXDIXPRHZvpsBbeClbsVJF3/i4egLlwdwO+s=;
        b=biNfksZSvhyJhkN3QGe/C7UTbAt09uwc8cwvp2Y6ZEhKEC8sIJjyhkaZublPCme9cc
         4VkG+kD3NjeqI1WeYcYx7iK03nFz96JmEe/l0FFtl3WqhUraZ2HhyF5tHJ/PcLEkgNOZ
         Lrm1SbYlkdeJJHzn1EuU6yx7IlObdv/x7p7XfyJXafSAMbaECbp2R1SPtmdjC6xFwdmF
         IFzt2uEzaOUFyH2gh+kWeP981x8KvfdVyZ9/NwNLaKEON9J0L0RuLe7Cevka1JmRkBgy
         TzRHdUEzGByVmtEnwzc3LoYJJaFrS09R3mHWkpZIsKD5ep/T4S1dnn8k8KWTCrsnfUOo
         mM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742563606; x=1743168406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+nfdqXMXDIXPRHZvpsBbeClbsVJF3/i4egLlwdwO+s=;
        b=YuntFcIiIOkVw74yjZNxdTwJcIhfpWo92bgQpUBPNzweGAdJG41tH/rYpUsByGEYgH
         vV+0GE/cAg7yvBLN2R2BPpQh4eYMLGWHFQkTWkVIDXINW8TGRzCoC/zADFiV/4HI8LUn
         fHb44iaxUL1dcRFJ16L/o5D78aOoVDGYhgts6pJWZXb5/srZL7QbiZyfeBQfTZFu5awX
         8sMH1B+TYPXXN6+khj74v7vt9X0h/rjqUOhOkwKfk4OMTPKBryVyzXAzzMWcF3M4+ws8
         V4QZ2DG0I8i70aQx8Z6SRY/n5RCeVutmOPI1ofVd4CW1z9e48J5LMoa79wwLTISUBqLn
         XWag==
X-Forwarded-Encrypted: i=1; AJvYcCUZH4iJ8Y9xOjJZOIcuJPZBCAoTl3JXP5xUDQYO821ST849jnfFPqPe21enHJzCQTgzHmzzqAq0NQq7lKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgbWbq7OifOabzGFTHz4lNNyiywVnMBJxO3TuLq6BHhuAVIgK
	eMOV76DPHoKABzoR2ucYCynrTk6DFveXfdqDgE/C70jlqX+jTBxurvAgdsorBo4=
X-Gm-Gg: ASbGncvFwZpBFtcJzdr3+kwhv0x2yGr4NP3bnEGqabTiu6iM/p5+w/fZ0SoNwZ+uwcr
	7MR7ZP6e97dXdsaNy2eMbQF/XslLTUo40evW5vfK8zQVOx1QAEBLeWcbORzqT5DjYswp4LGXGnn
	yuIBOma2uxbpu1hUJHhTqa4Nt7LDHDF5C7gqyuh5+0VRjzHJE6rT+rzeroBYWfPYrx2Vq2uc+G1
	qtyhk7bl3kQAJspSsI9MkKkJnNS9uP3p8RdRgjhcDYnAQAuuM+r+IruNED6eWhRQm2tuH9Chvl+
	zSYxSYvoracb1+WIfF/hAFmsTiwF6HQ9lznYCVru/nob9tgSGL50+x4V/73O5Z4Sx6swJRdcBQ=
	=
X-Google-Smtp-Source: AGHT+IFItBfdiuwTpyaV5kuTi/ldTSC9Nx5SxBw7qLGhnUVc61bpqSJwTkGLSn5VdoJA25gliLrfGQ==
X-Received: by 2002:a5d:588e:0:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3997f90e00cmr2957330f8f.29.1742563606193;
        Fri, 21 Mar 2025 06:26:46 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm2419531f8f.35.2025.03.21.06.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 06:26:45 -0700 (PDT)
Message-ID: <1d93f731-66c1-47b2-a249-9bdb25205525@linaro.org>
Date: Fri, 21 Mar 2025 13:26:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ASoC: codecs: wcd938x: add mux control support for
 hp audio mux
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: peda@axentia.se, broonie@kernel.org, andersson@kernel.org,
 krzk+dt@kernel.org, ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, johan+linaro@kernel.org
References: <20250320115633.4248-1-srinivas.kandagatla@linaro.org>
 <20250320115633.4248-5-srinivas.kandagatla@linaro.org>
 <rdvsnxuc6by6sci56sh7thzpxo5cqi7q24fnmc7hi5yrfszwrg@kqjpiilko3xo>
 <b1aed195-b2e6-4f48-ba10-3049d74085a9@linaro.org>
 <CAO9ioeWLRfzUOwjnFsi_yztdJo2Q25bhvjddh6D3naV_K5eShA@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAO9ioeWLRfzUOwjnFsi_yztdJo2Q25bhvjddh6D3naV_K5eShA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/03/2025 13:16, Dmitry Baryshkov wrote:
> On Fri, 21 Mar 2025 at 14:35, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 20/03/2025 14:03, Dmitry Baryshkov wrote:
>>> On Thu, Mar 20, 2025 at 11:56:32AM +0000, srinivas.kandagatla@linaro.org wrote:
>>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>>
>>>> On some platforms to minimise pop and click during switching between
>>>> CTIA and OMTP headset an additional HiFi mux is used. Most common
>>>> case is that this switch is switched on by default, but on some
>>>> platforms this needs a regulator enable.
>>>>
>>>> move to using mux control to enable both regulator and handle gpios,
>>>> deprecate the usage of gpio.
>>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    sound/soc/codecs/Kconfig   |  2 ++
>>>>    sound/soc/codecs/wcd938x.c | 38 ++++++++++++++++++++++++++++++--------
>>>>    2 files changed, 32 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>>> index ee35f3aa5521..b04076282c8b 100644
>>>> --- a/sound/soc/codecs/Kconfig
>>>> +++ b/sound/soc/codecs/Kconfig
>>>> @@ -2226,6 +2226,8 @@ config SND_SOC_WCD938X
>>>>       tristate
>>>>       depends on SOUNDWIRE || !SOUNDWIRE
>>>>       select SND_SOC_WCD_CLASSH
>>>> +    select MULTIPLEXER
>>>> +    imply MUX_GPIO
>>>
>>> Why? This is true for a particular platform, isn't it?
>>
>> We want to move the codec to use gpio mux instead of using gpios directly
>>
>> So this become codec specific, rather than platform.
> 
> Not quite. "select MULTIPLEXER" is correct and is not questionable.
> I'm asking about the MUX_GPIO. The codec itself has nothing to do with
> the board using _GPIO_ to switch 4-pin modes. It is a board-level
> decision. A board can use an I2C-controlled MUX instead. I'd say, that
> at least you should describe rationale for this `imply` clause in the
> commit message.

I agree to you point, but historically in this case us/euro selection is 
only driven by gpio. But I see no harm in moving the MUX_GPIO dependency 
to machine driver KConfigs.

Will fix this in v3.

thanks,
Srini
> 

