Return-Path: <linux-kernel+bounces-345631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8947798B860
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F4E1F2276A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2B19F413;
	Tue,  1 Oct 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nkvh1YCK"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F409982876
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775037; cv=none; b=a1+k1glZTUGGMIU8rZnTbVlPaDka2ukcBpm2yMAIpXMrT3iZK7aTacm7pYuFOTgmQH4BnxXbdJH2PO03wmQIWVLqQA4llJ4OOn4UeBJyrAriBE0jx28UgZ5ArLTRD1BPEka82RNcTwCbE9KITiV/f0hHS8AN28sLth+C71uLKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775037; c=relaxed/simple;
	bh=8utTuVvKi3Xf58YhMlDrfJrqonBjQ0pTKIx6LGEFxfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyIMo5TQRzBnu/QXMAMcHRz8aqFCYfUUdESCcfGkh6pYx+RbOqgDQasiprtwWDN0ou89GYTxxuIde3+B8rYKxWwOchEeJBW/9reEyiCBAozJYjwPAMY/e6kFj4LQI96yevhP+RGASx7rPiXVx4OLKLc9FvLRttaFUH33FEeFOnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nkvh1YCK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a910860e4dcso4566466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727775034; x=1728379834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RgNupkyjKM2ysAGbIsG0gGy1badDoqPKofkUhbyTKoM=;
        b=Nkvh1YCKRwtaWC3l/arENsaNN7IA22xABk4erWGwFpDLWqvXYhC2Qd6/Ie5pwMtTLq
         8+U+ZlBMhff26x2MojQEvn3vZUxWrp2IOvG9l6R9UK0kYXGNH2mmNe+thSFvO4o4g0KK
         mp6QpJpmXlI2IB34CbZJ4ltH+04XaVIFhz+0PAG1OpOrvcVuApHNrn8JLOdhHTHXVl7q
         mllomKbUqjHeCRi1ObHFyAYqh2pNYOX4E5p2rUBa88RW3wapVsbZgMUWcSgqUDhMQxb5
         2+E3E39aCgL7Gae28kklasLT7q6wsr7NnRI2r1YTru6j2nuwltBT3yQSIzt4S+7dtMmU
         qdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775034; x=1728379834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgNupkyjKM2ysAGbIsG0gGy1badDoqPKofkUhbyTKoM=;
        b=q12+E2eJXPT2RL9A4rfVOG2/ycl1MXkeoUkTdsX6Z56+FsDyjSZwe01zGagqrdMB0E
         GKgh1e+Nv8fi+AFZOfxlWdqLozE3klf73063K0fs7UFWkP4dMQXh8bnSXREHO6Gyhd5B
         NsrWe5/X52IdKIUGJwqAtcrwsFis/EI/jha3HTdVUgAoj/8YD5YskwT3TizaZgGgzz++
         5ejaJuV3uFPs6i4k+aAvFPp7gPKcen5s2ksSBvPcGitvsgvKEXg3ZF1LG+omfwY4+n4O
         5l9jGLBQ0vAzfdWs9KlTEiGpe1uNPLblE9ipizM1qFw9DfIYoUmCBRTswS7WlUxpzlGz
         MKhw==
X-Forwarded-Encrypted: i=1; AJvYcCWwfZTPZpnOjzbnYzPsNrzn+8CQlAT8XVT0+LwShDuh87u8IBYYlkAre+qK3Qjf9tKSwRyTbfUyMBiKcOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHT/OKHW70UwNTnxhDflEIpFd7M44HIGHi5MbBloNI1YAiYpr6
	+QbkL1Fk8CA+qhm4SiKmABFm2vkQq5CkjNbExgCAntTfHLabSUzieBPjYZcWqps=
X-Google-Smtp-Source: AGHT+IGB9dopkczYokJgV8nk4MY0kFdPv5z9uTEesO4k2VaH/NmikSHc794uEgWF3r+nTMZn2extfA==
X-Received: by 2002:a17:907:a0a:b0:a8d:14e4:f94a with SMTP id a640c23a62f3a-a93c492aafbmr1644389466b.38.1727775034202;
        Tue, 01 Oct 2024 02:30:34 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882493e54sm5913896a12.80.2024.10.01.02.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 02:30:33 -0700 (PDT)
Message-ID: <e7cc5f91-a0a8-48fc-9eb6-b9c46b22dfeb@linaro.org>
Date: Tue, 1 Oct 2024 10:30:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] (no cover subject)
To: Luca Weiss <luca.weiss@fairphone.com>,
 Vikram Sharma <quic_vikramsa@quicinc.com>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kapatrala Syed <akapatra@quicinc.com>,
 Hariram Purushothaman <hariramp@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 cros-qcom-dts-watchers@chromium.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Suresh Vankadara <quic_svankada@quicinc.com>,
 Trishansh Bhardwaj <quic_tbhardwa@quicinc.com>, stable@vger.kernel.org,
 Hariram Purushothaman <quic_hariramp@quicinc.com>
References: <20240904-camss_on_sc7280_rb3gen2_vision_v2_patches-v1-0-b18ddcd7d9df@quicinc.com>
 <D4JK8TRL7XBL.3TBA1FBF32RXL@fairphone.com>
 <fc0ce5cd-e42a-432b-ad74-01de67ec0d5c@linaro.org>
 <D4KBQ3ENKF5Y.3D2AK81PELAEZ@fairphone.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <D4KBQ3ENKF5Y.3D2AK81PELAEZ@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/10/2024 09:24, Luca Weiss wrote:
>> media-ctl --reset
>> yavta --no-query -w '0x009f0903 2' /dev/v4l-subdev5
>> yavta --list /dev/v4l-subdev5
>> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
>> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
>> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>> media-ctl -d /dev/media0 -p
> Hi Bryan!
> 
> These commands are to set up the pipeline, and what then to grab an
> image from it?
> 
> I tried this, but it also just hangs:
> 
> $ yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4056x3040 /dev/video0 --file=foo-#.bin
> Device /dev/video0 opened.
> Device `Qualcomm Camera Subsystem' on `platform:acb3000.camss' (driver 'qcom-camss') supports video, capture, with mplanes.
> Video format set: SRGGB10P (41415270) 4056x3040 field none, 1 planes:
>   * Stride 5072, buffer size 15418880
> Video format: SRGGB10P (41415270) 4056x3040 field none, 1 planes:
>   * Stride 5072, buffer size 15418880
> 3 buffers requested.
> length: 1 offset: 3326519176 timestamp type/source: mono/EoF
> Buffer 0/0 mapped at address 0xffffa0c00000.
> length: 1 offset: 3326519176 timestamp type/source: mono/EoF
> Buffer 1/0 mapped at address 0xffff9fc08000.
> length: 1 offset: 3326519176 timestamp type/source: mono/EoF
> Buffer 2/0 mapped at address 0xffff9ec10000.

No there's no CSIPHY in that case, it should be the TPG inside of CSID0 
@ /dev/v4l-subdev5 which generates the data.

Just for verification purposes do a  `media-ctl -d /dev/media0 -p` and 
confirm that /dev/v4l-subdev5 == csid0

Rewrite the above as

export csid0=v4l-subdevX

media-ctl --reset
yavta --no-query -w '0x009f0903 2' /dev/$csid0
yavta --list /dev/$csid0
media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
media-ctl -d /dev/media0 -p

basically you have to make sure you've set the TPG on the correct subdev..

Something like in media-ctl subdev4 in my case.

- entity 13: msm_csid0 (5 pads, 36 links, 0 routes)
              type V4L2 subdev subtype Unknown flags 0
              device node name /dev/v4l-subdev4

=>

export csid0=v4l-subdev4

media-ctl --reset
yavta --no-query -w '0x009f0903 2' /dev/$csid0
yavta --list /dev/$csid0
media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
media-ctl -d /dev/media0 -p


---
bod

