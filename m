Return-Path: <linux-kernel+bounces-406528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 446459C6075
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98F21F21C23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D421745E;
	Tue, 12 Nov 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duHGIUFj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B62076A9;
	Tue, 12 Nov 2024 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436365; cv=none; b=WjVRawzQWVbX6llHUHKN6RpoxJkquhnFpAHXokOnwQ+nzuHO/Q5PQ2Q5bZZanVO7rPMyQnMGRSM1uDGqp+oO902X9AeW0A7B6k2dxCslqB2Bp8B7ghudi74EOOCi8xubKqoMKC313VPXcq4ijetzrbct6Ukn5sfDJmb3FPJjB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436365; c=relaxed/simple;
	bh=s2p2h673P/HuOEM0rvDmBFYu3dbwEgTGxw49Vax+SkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTQmFzN7PGiuKdbl9hy3TDSOGHoIRorKocjbHj9CWWg/mvW5FnpWSYwKjb0hwOP9x5KQzsObN82smFUEJcAX6v6L1n6KW32BJyinxiJ4sYB36mmBSIxyqUxB7YgFk7CEAOkOPk4PLOpnA/kiI04kUJaoeRz+HyiGspz4FgXnYDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duHGIUFj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99e3b3a411so6866966b.0;
        Tue, 12 Nov 2024 10:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731436361; x=1732041161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5UCG7gigTfhNtGBIssbVQwzzj1879iTBqBc1MZAvgpY=;
        b=duHGIUFj81PXHLxIk9qlDI9AMC6bL22dmoajxQ9rojKw8oVhRwaPc5PgtLijHbW6Fw
         H8Oc+8NO7M2QEBiZkxGv2W6PmdsfBUqgijIXluUVy8qQJ+Kzocw9DNP3XvpXREMGpwi7
         2wxFKEeu5uVbxPalNS+oh56rmBH3cQFQBNNctGgfJ2iIMfrmUMPA9qwC6psG551PEkol
         pOpnlDRe68TidaVcT8Pxhv57u9ioHKeDgGelPbDJpsbepkuGcppWkf45u9Tvw6FLJLW+
         HGC2HC+exyLgZ1O5DtVQTqyeGqY0ukgYKxmmuS4VponuX9Z68sxAT0JcDw3q1F7hkh1y
         z+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436361; x=1732041161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UCG7gigTfhNtGBIssbVQwzzj1879iTBqBc1MZAvgpY=;
        b=T/3bR7e8o11L0fDPn7NIuMh3MwRIVBfpJRvV6gDd92rE7PRZOHRutpkUneZlF8tfK2
         YT5zpwzI+CPDjFx6rYVL5+CBhY/MlH2xrFlJHaD2RTlX895aTZ7+Vyf6DWgEXuDMdIRg
         XoVz6clCjiFZHme5Wm1kW2XU1N1Fi65VMxzfVm3JNn++yKLsYJq66IHQq27yf31AeqFO
         fRIFLWhBvHkCspw0xtwn1kNaGYKlLqMMJIs3rr4RJrwHH0bc6sFu3ADR552sOtHxs74z
         jbOMme28ixVXUKo1jlRW7OZwsxIUhQck19o4/6Zrqaw0XLxArXZAn3r1RfBTmQm2aAoK
         YRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCwds7G4toXEsoxalm1r/zi1+qJPdNPNaPwo2vgQrGGIlXWUtaSf/AWRtpEj/alGx+CXpwIpQPQ6yQ8Ups@vger.kernel.org, AJvYcCVeWM02E+ha1emsEJUCD1T7Oro66+w706/dhokrdf1yd4V4wyo+Gatoh+hQQHPK9g+U8giYV59UBzgB@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkwPwp7wqn1Z5Fk1hch6WEu3PqhOEy228d8QGR4SkizKVAF/G
	deGjbCZtAph9jOb2xlC55zoohT1Ng7oCmBEz0DeLmD/Fqpx6tKNK
X-Google-Smtp-Source: AGHT+IGXSfMvakz9L3gitYC5+mW1zh2dbK079TjOQ1eKDugvPwqCfLBETDQCnHWuMi8hQPA7aslrkQ==
X-Received: by 2002:a17:907:9455:b0:a9a:b818:521d with SMTP id a640c23a62f3a-a9eec9cf03dmr1908255366b.18.1731436361259;
        Tue, 12 Nov 2024 10:32:41 -0800 (PST)
Received: from ?IPV6:2a00:f41:cf4:1aa4:180f:4639:612e:9702? ([2a00:f41:cf4:1aa4:180f:4639:612e:9702])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abea92sm746032966b.85.2024.11.12.10.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 10:32:40 -0800 (PST)
Message-ID: <ce1d2196-cf09-4d27-8b41-372948a59e89@gmail.com>
Date: Tue, 12 Nov 2024 19:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Allow specifying an S2RAM sleep on pre-SYSTEM_SUSPEND
 PSCI impls
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sudeep Holla <sudeep.holla@arm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241112180118.pcn7sf6r3mswwwxf@thinkpad>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@gmail.com>
Autocrypt: addr=konradybcio@gmail.com; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20241112180118.pcn7sf6r3mswwwxf@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/24 19:01, Manivannan Sadhasivam wrote:
> On Mon, Oct 28, 2024 at 03:22:56PM +0100, Konrad Dybcio wrote:
>> Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
>> CPU_SUSPEND instead. Inform Linux about that.
>> Please see the commit messages for a more detailed explanation.
>>
> 
> It is still not PSCI_SYSTEM_SUSPEND though...

It *literally* does the same thing on devices where it's exposed.

> 
>> This is effectively a more educated follow-up to [1].
>>
>> The ultimate goal is to stop making Linux think that certain states
>> only concern cores/clusters, and consequently setting
>> pm_set_suspend/resume_via_firmware(), so that client drivers (such as
>> NVMe, see related discussion over at [2]) can make informed decisions
>> about assuming the power state of the device they govern.
>>
>> If this series gets green light, I'll push a follow-up one that wires
>> up said sleep state on Qualcomm SoCs across the board.
>>
> 
> Sorry. I don't think PSCI is the right place for this. Qcom SoCs have a common
> firmware across all segments (mostly), 

This ^

> so there is no S2R involved and only S2Idle.

is not at all related to this ^, the "so" makes no sense.

(also you're wrong, this *is* S2RAM)

> If you use PSCI to implement suspend_via_firmware(), then all the SoCs
> making use of the PSCI implementation will have the same behavior. I don't think
> we would want that.

This is an issue with the NVMe framework that is totally unrelated to this
change, see below. Also, the code only sets that on targets where such state
exists and is described.

> For instance, if a Qcom SoC is used in an android tablet with the same firmware,
> then this would allow the NVMe device to be turned off during system suspend all
> the time when user presses the lock button. And this will cause NVMe device to
> wear out faster. The said approach will work fine for non-android usecases
> though.

The NVMe framework doesn't make a distinction between "phone screen off" and
"laptop lid closed & thrown in a bag" on *any* platform. The usecase you're
describing is not supported as of today since nobody *actually* has NVMe on a
phone that also happens to run upstream Linux.
I'm not going to solve imaginary problems.

Besides, userspace already has sysfs to tune device power state knobs. Which
Android uses very extensively on market devices.

Konrad

