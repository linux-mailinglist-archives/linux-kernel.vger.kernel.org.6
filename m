Return-Path: <linux-kernel+bounces-543736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E211DA4D920
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F018518860BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735441FCFE5;
	Tue,  4 Mar 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcqVUBiS"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561A481C4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081670; cv=none; b=BRkL7ekiUxNTQfZa+uMC9NXpl3+RslHCpCJUSLcStrWMEBKkqIb19KdhoXCIj+aMrLgfhfK8bYBYpTZubVQEXQ534WpVSaHw9MKqjyalQ9UWUt8iG3WmWR3PuvxsmwYEzp326tZ3y24Ismw49QsrCk6ZWwkhsERQOf0H9TxRylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081670; c=relaxed/simple;
	bh=jM+khpR6kSrzXPpnRYBzaNBVw13oVxCaP+gD5x4MJis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsURHiIbL31qRuvbFqTKdTO/yV09tb7j+AaKq67AFAGGp7fSH8noPcNMI8dGdTKzk2oOJUphCT3uC1f5WvMLDPO6J6aA2IO4UlG+IgDaNpJXle9otDC1dm7qWLBLGdg7Yf6MvTrG9UDSFYT0p0AxbC7Y2hNWE5+s1oochrrWKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IcqVUBiS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso34664205e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741081667; x=1741686467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSm1lg2/FkL1yWeHeKV4bekvslQt2WvmtVqn6o+tUnQ=;
        b=IcqVUBiSEsldwLum6i7goXFnHY5PQQoIAs7IH1jZYokVylwIVObVHdSZgT8W/0CYle
         cFti+mk+DD5KnGfDUrhSBDRh0w6JCJ/VOlDvyr4wj51jSD+08/QC7mwpkYtEF9/amLd2
         1Z5eeFOpW2LzYRTGb6zIRCrCpRjzha/B9mG34c9ORjz0YkDnMTRXTwnZ4xzYDn5hy0kH
         EEkFp3gQrVi1x7jMHuAuzU+YHN3ibcQH5ChuH6hCQoyunsv8ilRWqJX4nbJ1GaRij/zg
         /nPhKxqnEbDvIMJPweVfiYSzECCzo08DijOGcQv3I0ePo1ZLqx4KcXF2Lkf4Zc3L/6G+
         V2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081667; x=1741686467;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSm1lg2/FkL1yWeHeKV4bekvslQt2WvmtVqn6o+tUnQ=;
        b=jgEPSgS83SdFsPhpp0c7bjRRjSryTR2jxIuMWApUiZvLa5kpGb5JuRVMEuPl0NbgHV
         Lg2K6TH9j7DnVcoArSXJrIeDVVi39xlFiaA+9pAsETB8xHOuPm6ufSEstjSBjzeJhnTY
         IPFFFFvCG6fMhrEWH8kzHH8vJ8/mu3k/zl1FvATuK4AbpBrBIiqdtShyN1pjRyuWPMjJ
         iIWlmjq5BTYYl176M7Spcl6cir2N2arD8iCvWko26zciLl/F4K0cRz3O3KrzhYOYcdPf
         KbkRRItQgFsCsg+mf4w4DdQVhMM/FJnE4CUfC+2RQxoCbG3vqNUOFhRa2rEj/wukx9Fu
         2hfA==
X-Forwarded-Encrypted: i=1; AJvYcCWBGW8TBD5D4PLGK6keHxakzTI4Yp1Eyoe402q0/7yCe/UPc1CLw8AWkbglrQFokcIPIgqLhRuQkboXNt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjtx9nbKLpwTDCEnjWPOStP0fwIWSWDn93qgi8ZQcX7M5j5mGX
	l6b/TBTTHWlMeG4HB3NWzNRdmDAJ9XSVflDks0Xa+HpIAV8CR5QxH5J6yp9mt5w=
X-Gm-Gg: ASbGncvu9Gv9WRL9useW46TWj90DTDVqo9t5FwR0FKYR9p4Ee52L63ciTq82wMVPyMG
	BDOjqhmPfe+EtH5qeM3WIA2yD8cpXtTL5OHwHqZO9/BqzTcv53Vzlak4W7UAr8PE8FEVMFztfBc
	3zsGCAO4UeVMC60t+07bUIIyd8I7Y2qOaV0jC+Zdbzr2ZQ7cfp2VRt+z8BojcWJ+ud7nVDSNQ7z
	U6urVTsXohrfIluqBCGmg+kd+PXNZgcI+XuDFEzsHCgTzCyJc/xgpvM4VwBLBO6GE93WCH9V6Vw
	kihp/M0l66nn6gP1lWYu1aWA5j5vj4u51PfhROknrYqvDGFNfXA2hok+Gih6WV9vvnwnF7QzAGO
	Ok8/Agkcttg==
X-Google-Smtp-Source: AGHT+IFDmnK5YYmULhWYfPkCzV4REgmiXkQRXkNfOTnHTpTo4USjUT1kKhF/sQF1HrBw+vy8AZd5Qw==
X-Received: by 2002:a05:600c:a03:b0:439:9b19:9e2d with SMTP id 5b1f17b1804b1-43ba6702becmr158936035e9.16.1741081667192;
        Tue, 04 Mar 2025 01:47:47 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e13fsm16964961f8f.100.2025.03.04.01.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:47:46 -0800 (PST)
Message-ID: <f5c2044e-e78e-4839-9c29-63610ff406e2@linaro.org>
Date: Tue, 4 Mar 2025 09:47:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/2] arm64: dts: qcom:
 qcs6490-rb3gen2-vision-mezzanine: Add vision mezzanine
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20250208225143.2868279-1-quic_vikramsa@quicinc.com>
 <20250208225143.2868279-3-quic_vikramsa@quicinc.com>
 <ca8e6569-b466-4f83-83af-38c51891d395@kernel.org> <Z8a7cMmxJuHIhgjo@trex>
 <baae2a56-5299-486f-acf1-14fe13fd2f81@kernel.org> <Z8a/Dk7zjZ7RQT2/@trex>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Z8a/Dk7zjZ7RQT2/@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 08:51, Jorge Ramirez wrote:
> On 04/03/25 09:40:21, Krzysztof Kozlowski wrote:
>> On 04/03/2025 09:36, Jorge Ramirez wrote:
>>> On 03/03/25 18:13:20, Krzysztof Kozlowski wrote:
>>>> On 08/02/2025 23:51, Vikram Sharma wrote:
>>>>> The Vision Mezzanine for the Qualcomm RB3 Gen 2 ships with an imx577
>>>>> camera sensor. Enable IMX577 on the vision mezzanine.
>>>>>
>>>>> An example media-ctl pipeline for the imx577 is:
>>>>>
>>>>> media-ctl --reset
>>>>> media-ctl -V '"imx577 '17-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
>>>>
>>>> AFAIU, camss does not support SRGGB10, but only SRGGB10P.
>>>>
>>>> Based on tests reported on IRC I think this might not have been tested
>>>> correctly.
>>>
>>> I acquired SRGGB10P (10 bit packed) frames from the camera despite the
>>> pipeline being set to SRGGB10 (16 bit) samples.
>>>
>>> so something does not add up.
>>
>> Then the commands are actually correct, just the camss or media behave
>> here a bit unexpected?
>>
> 
> setting the pipeline (CSI) as SRGGB10 (16 bit samples) as per below
> 
> media-ctl --reset
> media-ctl -v -V '"imx577 '19-001a'":0[fmt:SRGGB10/4056x3040 field:none]'
> media-ctl -V '"msm_csiphy3":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4056x3040]'
> media-ctl -l '"msm_csiphy3":1->"msm_csid0":0[1]'
> media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
> 
> allows to capture SRGGB10P samples (frames-xxxx.bin files contain 10 bit samples for the size)
> 
>   ==> yavta -B capture-mplane -c -I -n 5 -f SRGGB10P -s 4056x3040 -F /dev/video0
> 
> 
> shouldnt the CSI need to be set to SRGGB10P instead?
> 
> 
>> Best regards,
>> Krzysztof
> 

No an internal media bus format MEDIA_BUS_FMT_THING is used

See

87889f1b7ea40d2544b49c62092e6ef2792dced7
5480b0c67f120a6c293cc5eff72fa1d6a74de504
3c1dfb5a69cf836f513a2a49113ee946a4b9d95d

Yavta is specifying a v4l2 pixel format SRGGB10P which then gets 
translated into a media bus format MEDIA_BUS_FMT_SRGGB10_1X10.

I'm not sure what the historical reasons for that are, probably good ones.

---
bod

