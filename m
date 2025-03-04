Return-Path: <linux-kernel+bounces-545022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6738CA4E94F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495848C4F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6224EAB6;
	Tue,  4 Mar 2025 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJW3R7PI"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F24EAA2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106911; cv=none; b=ECgqq4kGuiLP5J/mzWOlg8CSgPX4E+A1FUvQLt542vkUbm6qEiDtX+4pRjn5hiDaL8MYiELLcVYf/vMZD5my8Ya1EZ5UZBwlhl3kWV/C27JT7pUXWt+XbNHHvRcsvIvNr1qupYrMEPASSS0cWpMY/8C3KSWIGk3wSbst6usKopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106911; c=relaxed/simple;
	bh=VEd/Qg03kECFeS4hFXnZqJyn3+4HfSz1x69E5nv1DKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWX0hnywr2bKHXR9z/nkAbFttiiBpja4uoE2edr34LhGdjbNwwZCp8HoJFBA6vjya3a/cVYIxxJEDCkBP81+YYbJTN+fDe3JiAJphRCi2DSuwvJj1i6AXHyxPKqC7XGEPZ8UdPOTOk5e6KkerdEoMY9++Vea85vGix6xOexJEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJW3R7PI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so3029178f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741106908; x=1741711708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knwLaqR4E/krVUJDxD7fdWOUGWk2k+uH2ku8XnnCDG8=;
        b=lJW3R7PI75dtuLA56i6G1Zg8jO6gja2k2fT03iiWeuy+4qBuKtTy/DvmXRJ+1ntDfX
         4rQ82N8YYLfn24seGOcG7mXbSn5kxrtsvFBjKOhiy+SJyDawiuOBmuMCkMdm9bxe3O2V
         K4WhnrUK45BLMUOcbfkrWB/kxsrN27PmeIw5oeT/UGjs/pNEXrLPvN0QpD71Zp2JfQAN
         EI720YPLt1XhhrpYbpq8DRZh+8WxexeTNeViQstA5c7JBD4OEqavvTGxrN6aY1CCha3N
         WdoxHSIhAXjxRkEj96fDX2Kt7GPytikub2c32Pm5JeWewPolJJoQeWIPcU/eGFLL6HIV
         E5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106908; x=1741711708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knwLaqR4E/krVUJDxD7fdWOUGWk2k+uH2ku8XnnCDG8=;
        b=RtXhqK0EssOdER9yVkMp/AXcB5BfZUxbv7KWmYFaJJR/8yq+IqTU17cPV3P6ZdMG+A
         x97O4+0G3GPsL9bwyUBzvK+JgRCAnu3WB5APC+pKKdOZwgiJI2qWBmFuMtDCmvXx3Y91
         BCTWqALdXZvp9DRP6WiRQCQmxLu4KiYY71ItbKyfkEG1X1sP2KRxolwAx5ygOGe+0ZQK
         oDRtJq2OZHy2vPiY3J8yX4tOqP+pgW/Lh1IPM7+0OBAYuobIdq9wsGR9nU8r7XYr7PRe
         ZOitUT+kwx1qv5GmpfCQwTDkIx5Yob0v+7jP/xu2qEPrm0xam8+bdTwsstyW99lHOs6Q
         1cMw==
X-Forwarded-Encrypted: i=1; AJvYcCVp+DbVEHnodcGnHnG4/c/loz1ove01f92rQehi6S4LaHbFrZGO/m7a+vz9JS3nFTuaC/cwBHjymmyH1QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsaJE1zKc1Dr8GR8cj0G/mpaMMh5OIAFvY6EOI+jgSOrwlZy0
	ozbZY5IQIta8qSWxe4eFxJLwAdm0McF39kZMSWCs9Jlyx+zx2gxveQe3GFCnDDQ=
X-Gm-Gg: ASbGnctbZv1C7ZWLRRv3n+2vCGh0/+HxlEpgLo5OnwH9qoa6bXzA1Dkny4Jm6PNWFIs
	2yt+dXfs8Q0l6VIoL+v9l3jliPBtqXmwFtajLcke5dP34e4k2DkslMt9I63+SjYuvhoCgBbwW3m
	gDMnrzo2X064/OwjrZ1v4IH4hT3j/T253RBWkVON3bkPfgPMRlsy5+gfowts0MTR8EmeAVOjEo1
	WU7myvRnZbv5l5JdvrXp/KXfV/StN9F2/VN+Mv9CfXYfW4U7GJNUQ7gnqWdrn6n1yU4R/+Qioon
	ReXhSn+fB6xtg3bUYB89WVUcdDD2sijQx/g2frFZsJbw8rUmWc77R7iIE19seIn6TJFIh4MCTGS
	z/D8hveygzw==
X-Google-Smtp-Source: AGHT+IFY41tyGQRHzMHyy9KgcsRF5vwNocdWNy72eFAv2Q9wjjxRggFSPsKEudgOviU58D9n9GBy1Q==
X-Received: by 2002:a05:6000:400a:b0:390:f6be:9a3d with SMTP id ffacd0b85a97d-390f6be9a90mr14711089f8f.35.1741106908171;
        Tue, 04 Mar 2025 08:48:28 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm18452789f8f.32.2025.03.04.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:48:27 -0800 (PST)
Message-ID: <438498a4-10c9-451e-94e5-c8dea899beff@linaro.org>
Date: Tue, 4 Mar 2025 16:48:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] media: dt-bindings: Document SC8280XP/SM8350 Venus
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
 <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-1-279c7ea55493@linaro.org>
 <6f7fea59-310d-4a7e-94f7-2483363012ba@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6f7fea59-310d-4a7e-94f7-2483363012ba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/03/2025 14:00, Krzysztof Kozlowski wrote:
>> +
>> +        operating-points-v2 = <&venus_opp_table>;
>> +        iommus = <&apps_smmu 0x2100 0x400>;
>> +        memory-region = <&pil_video_mem>;
>> +
>> +        status = "disabled";
> So it is the same...
> 
> Same comments apply, same review.

Ah my mistake I didn't dive deep into much more than the 
video-encoder/video-decoder feedback.

I'll see if I can fix the rest up.

---
bod

