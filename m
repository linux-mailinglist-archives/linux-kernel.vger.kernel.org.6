Return-Path: <linux-kernel+bounces-435682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E29E7AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7975528119F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405CA22C6EC;
	Fri,  6 Dec 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0Xsj1vj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65B22C6F9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520362; cv=none; b=ZvODLNTMhfgffTCzsuYn2FzdiLeklIg3b564s167fCgWEuMwB/pALwqW4zDsznNmn0i69CC13zcga5CSiVTEINgYIJ1Gnnf9ikax+ftEr9n7ADXG0eznniF4NUog+9e3KqDeNnC6rfz9j5oKy8MC/Sdmo6cR5tACPCMPDrYQNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520362; c=relaxed/simple;
	bh=XozRvPqqiHeG9PpK+KAt8BvlC4+3PPnRXff6x442qkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKX1gdAbr6rsljSGOonBcKN94q9KBO+ceWRnj3NXbqLLX/+aIHyCAuO8P/72F9oOpcJyahPBcBXXWScPcbTJ2YyOj1dCPvex2Qs6EIRjL6URni7TcILt89bhab3HBtf20igoXkA1IedJqjVhvQK6xknfARQqy1JsP2/sNPjXmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0Xsj1vj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43497839b80so16707205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733520358; x=1734125158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fY5PGKfinw0bTTrofkyjWmSLNTzsh9f6hZ66ZvW8/Rw=;
        b=R0Xsj1vjQDh/J7ZFE9ReRAD6mPkf/aMC5AhbaxH1E1V7cKw+9guxvFdTcUhuqFUsvY
         vJZ3J14zYxJtnyizJQ8ce0rXJM3CBE5UlIMFFtKfKgc4jCIhufYWO/UiifsvyG0OQUBb
         21VkqvkrPKzttYEqZyUdwShnPyxHuPh6SPZz32k3pA0A+A0n5ZYZ1ETbwgz8NxqiGcHF
         8QAeTlILznQyBTAkN/5ToizB4q4eIDE+t9q0bxcsBo/Z43ypeF1mqc8zI5xTcskZ8h4L
         Cn/7G+Ee6z6F4mDkzcVtQPpq03wxaTOKh81Wrhnh0LnCHHny7GrsJmPrCz/pZvOKk4Qu
         NpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733520358; x=1734125158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fY5PGKfinw0bTTrofkyjWmSLNTzsh9f6hZ66ZvW8/Rw=;
        b=rPDgTfMo+/Z/FYet4Cgw6ePNJCYujm+gxeMbbGu/2WuCoFvlGryuSvZWnCR7erVoUp
         /66acSeaNP1bVVEoq57KOolHUlDvSIPlzvUOoKWNvbsKZBPiQRIt4Gid3y+V2hWWNJIJ
         JOO5f1CBVdiNuabQPJ4iqgxzUYg1cQz8PwPeBOWk14fXZa+jFk/dw2f1nwT3+J7obePh
         YRgDUy1q2QVaGT88kh14vcBs7cmbO611VGSYBMfMKZTkpPL3GLNtzjZmtBdfn3rtAqOK
         GJR5oshKzHS++QpaIy+usmNYXdlIuKa29YIu2CO9zmrGerTx3Dqs7WvuqdG1mgGvfdWu
         5EoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaBFpqCA44wYLBxyhuAXrH+EC79YtRfa+FCrvpSVkW07CdimnYlhJdDGI8GtqGbVxw6yjuAlQO/1n6y8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9DqN+8Er4YH0vxnVsMKw2wIF8NpMzAVWnsqCbWLhL+t3bykq
	mNrHY/VTC5MI5C6AJSVsOVKgStAdvD1QUfyj35jORaWPwDeIHLX4fS/KQOrtpTA=
X-Gm-Gg: ASbGncvZ0ZPlZ0/s/FyYgPdne7/BsYNHn13VR7TIPOzZzsqmtyObi2U8mCzLYAWJNnZ
	++HgLsnpYmIuQSsjMMwWAcLAORnYk2OPriYuNq8oYRroDhCfUh83cCuuK6k6F1thEi+Ra1gbA2a
	ZpqA9ZQZ7+jDWtMDUfn1fQ2BqLo4r8TjpEaoeL/6f4g1xD7lxnkx+buOEv7ORQp2KvTB4Jgsqv9
	Dv9YC8/bznYuwXnDvsG2tttLCpGF2oJ5nd46jOFKNR8MTONRsu9msDeaZ9BeAE=
X-Google-Smtp-Source: AGHT+IFCuNytTJqW2Q/06hLBEwztlzuz4/nMye2kjnSGSBSbzlnpZShoPe5MRNOfbMcnO8GBE+1lBA==
X-Received: by 2002:a05:6000:1ac8:b0:385:fc32:1ec3 with SMTP id ffacd0b85a97d-3862b36b015mr3629269f8f.20.1733520358248;
        Fri, 06 Dec 2024 13:25:58 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fc51451sm5521521f8f.47.2024.12.06.13.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 13:25:57 -0800 (PST)
Message-ID: <e9812ebc-c96b-44ba-8fad-e64eab19ccb6@linaro.org>
Date: Fri, 6 Dec 2024 21:25:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: dt-bindings: qcom-venus: Deprecate
 video-decoder and video-encoder where applicable
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 konradybcio@kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-0-fd062b399374@linaro.org>
 <20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-3-fd062b399374@linaro.org>
 <a2285d28-0f57-d165-a22e-2aa57b3cff65@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <a2285d28-0f57-d165-a22e-2aa57b3cff65@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/12/2024 10:03, Dikshita Agarwal wrote:
> On 11/28/2024 9:51 PM, Bryan O'Donoghue wrote:
>> For the list of yaml files here the video-decoder and video-encoder nodes
>> provide nothing more than configuration input for the driver. These entries
>> do not in fact impart hardware specific data and should be deprecated.
>>
>> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Bryan O'Donoghue<bryan.odonoghue@linaro.org>
>> ---
>>   .../devicetree/bindings/media/qcom,msm8916-venus.yaml        | 12 ++----------
>>   .../devicetree/bindings/media/qcom,sc7180-venus.yaml         | 12 ++----------
>>   .../devicetree/bindings/media/qcom,sc7280-venus.yaml         | 12 ++----------
>>   .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml      | 12 ++----------
>>   .../devicetree/bindings/media/qcom,sm8250-venus.yaml         | 12 ++----------
>>   5 files changed, 10 insertions(+), 50 deletions(-)
>>
> A general query, this change is not done for 8996-venus, sdm660-venus and
> sdm845-venus, was that intentional? may be because these are not active
> SOCs in upstream?

No per the cover letter, those SoCs have power-domains and clocks inside 
of them, so the dtsi entries actually does relate to a hardware 
description in that case.

---
bod



