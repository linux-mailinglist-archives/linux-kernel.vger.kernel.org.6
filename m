Return-Path: <linux-kernel+bounces-434655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B709E6970
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ECF164241
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DDF1E0DEA;
	Fri,  6 Dec 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnjSIEbZ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9519ABC6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475474; cv=none; b=hZVJ+FTRnl+75D2TybnrA4jPXcdG6MVDB1LaTGcqepL6hoGrZ8bV9NWwAINmMbetkhpvUiVyKqkD5vqLzAJR/CwTBH8SrnRSnioYm5h5O7/ml8agHzZxQlGtw9KRjA7lbHkFtfAhVlORpNkF9ZaP80TQ+9NCZIM3CJx3YnEOFn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475474; c=relaxed/simple;
	bh=ZIpcoXgYiFZrLmfPH61byHy08Oku3sMIo8NPS1/kJLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYSX3okFrKIJ2Vai1OmR3fhvTzJDSjD/EV+hOLNHWbKvtqy+sZkd6wNY28OJqUm39IaylftxOpWsfoZWNhRC17jX7jB/OnrmgHTLofgj8/h4aF7XWHL0y4HoeR+/D1BEZGS17uPSDZsfwCvQ3AilKwKymumz5r9HxYpjjTgSZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gnjSIEbZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so2262485e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733475471; x=1734080271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xNdgyJk7qHuufD5ApcrW4/6+Rt6fPwGmlDYXJpxBr8=;
        b=gnjSIEbZwQuJOXBwTywFJH37mlt/4AJ+DG4VeHOdj8rEodN5xlyw1P3DsAj+9WbzeU
         hUtkucBfq8pMhDdfmS+Kl0vUjNQ3WKiBzwcWGEToIraCNdKd0ry9f78RbUdDrl9U2YWP
         ZjTHfGF0xb5AmWfDdLo62qMiosbkLWivv5j9XP75QYA+bE1xmdrcmU5t11XDhDi9/0ua
         oocfYf2HVWmeao8A0YwhhFNv7Rit6lo1lhn2VfxWAG+PmuqfYF6ZTUY3yLwYQHXJgt8h
         QOx/GZdy6tkFcfETCiVLr41H6PpvxVkuk6OKAi+BkXK/5SsJk4Xdb03uy6mntMjYdK22
         2zHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475471; x=1734080271;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xNdgyJk7qHuufD5ApcrW4/6+Rt6fPwGmlDYXJpxBr8=;
        b=XSY+zP5vjwJu7KsuAzSaqqpYu36s682sfFUKT1xR74ZWSkSWsveCARWRsic6o4dCFA
         Bof4JcXSgNHFz7MUaYijiMXtjEuRbqQ4lS8b2GLw2NLx1nU+P3tehCe14ZviK5C/X2zq
         09PnqJzvZ8gEFnSc894zuRED94LOlntIVkz2O2dLrmnUTVSXI8vKCptP2c+FcCAQW+hs
         IKWJ25OtHA0vpeDyk0uafJyHPPaioxvwOttUWYRIHoMavgTsZ1LRmr9y5Uhk51+2xB7t
         3AJjpVb68rHUva8G2bPSzybrDXNEKxgD7D7oOAKUPxotK/IxVSS/sI3q1Y/pn2eNOz2T
         Pq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX9p3QCcSIl02bwOiP0PuSUPqIRS5CSXoe/Deug+zVdManCwP1T8ckgIQ5LLTkn3A2DwNd1kcnthtenEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OlidJSnsQ0bMlSmZc5rEcNSoYCc8xeTux9cW/p2ClofkwBwo
	4VmSAeqketChgf5w0cS5NaHHqBwr5ecFYjI4GJ+k+JRcu4wKcaFP1B6PzfDehRfOz/rf85TMMyt
	exGI=
X-Gm-Gg: ASbGncsxEEWTiznhtK8NxYB+W4XCuyaa9XArq8vKCCP+4xGAHLblEFGEqex608MnLE/
	ei1G8fwHgjgAJ481rdmMnfFpfw2thDuy6ew1H1uX9VKYKKuMIoU4bt+LdB66FEXy+VpkWqESbYR
	uiSVcA9mynaO9Yk0iSqVK+CckdzjjF9QONhZuUebld3xiznrQp35MzC/YoP7IqrhXDnpvqjkcEI
	45RygK7UFBcXK03f/yIKRJchYXp68C4d69cway/nKx4NyUdXjZkAr6mdw8unxalFZPMSA==
X-Google-Smtp-Source: AGHT+IHtTJ1oKAYqMTh8v/+mBIB4cULWDpxzx6rnHxc3m1z7QURDzbRZoEzl6ZbqGZ60KJ5VjxOlxA==
X-Received: by 2002:a05:6000:491d:b0:385:f479:ef46 with SMTP id ffacd0b85a97d-3862b3db7dcmr640438f8f.13.1733475471360;
        Fri, 06 Dec 2024 00:57:51 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386220b071dsm3997765f8f.101.2024.12.06.00.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 00:57:50 -0800 (PST)
Message-ID: <889da3dc-e1be-4d01-83b2-f29d09bf521c@linaro.org>
Date: Fri, 6 Dec 2024 09:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8750-qrd: Enable CDSP and mention
 MPSS
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
 <20241122-b4-sm8750-cdsp-v1-4-9a69a889d1b7@linaro.org>
 <b4173f94-1cec-49b6-a882-d07b10ebbddc@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b4173f94-1cec-49b6-a882-d07b10ebbddc@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 18:35, Konrad Dybcio wrote:
> On 22.11.2024 4:26 PM, Krzysztof Kozlowski wrote:
>> Enable the CDSP and MPSS (modem) on QRD8750 board.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Not tested on QRD hardware.
> 
> Not great given the status = "fail" on MTP..

Well, someone will try it. Either it crashes or not. If it crashes, then
person will send report or patch to change it. If it does not, then it
will mean it is tested.

This is a shiny new platform, so no one expects this platform to work
flawlessly and no users are impacted by such untested code. Merging this
has only benefits: more test coverage by early adopters.

Best regards,
Krzysztof

