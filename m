Return-Path: <linux-kernel+bounces-425506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A38E9DC2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A5428230F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583DC19AA72;
	Fri, 29 Nov 2024 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UT0n/lxz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96A17ADF7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732880499; cv=none; b=rAqcfuZWNyZS5NWfPEKuHQDV/IeQF3GbbhDHjEQRX4qqcUr9PDdp80/9jMZX2T3BqF45QrDgTpDL9Ob1mgnGq/Y+XKd+zH4Bc76wAGsUk6icR6wTQntod3ApMSyzNMFT+vKLswrTwl4rhagRqLecwZMkwhtkAHlw6wUAhS5xJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732880499; c=relaxed/simple;
	bh=QOYcGKD6GkoOWI2THd9QW/QAO9FbQ/mMjfRQ927Bf6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5LAeccjymmTp7N9aTKBdx+Edsn1TAyYwM+cgPfViXibMc/M1/iCi8eqnEB1+SpgzsCY2O9RpjdYbS7yquyDWz3ZQ9Cj5ReytJPCFeVIPFLz6EaSDOGjHWHtG9rIMA1KJ7Yc60FzF+qURpaIn37BYy6L+lWuFKrZy9jixVMBrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UT0n/lxz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so16099805e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732880496; x=1733485296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3sMy5emdErSKL+MyeTW7qsU/fxRK/CVygOjCkn7jTE=;
        b=UT0n/lxzLylHtKILENkkGWQQbVbpjsHeDav6FntpOUMYGwhmraqKHosRzXfprevPPU
         HHXLRWChR2zwCwFXZBnNrgSyeIMOA4eAmTPA3iNVThzpHHIqa5nmULD5f68Nwx9eZzgK
         HjKd/WoAELshJB+X3/LMdeNPceq7hoJXRM8uaTZHqBzlth3Tn+/9crdfTQ/Ja1POoapO
         EphCG5CaLoICHzBgjfRhGnuob+WTpJ+69K/N6atuuLvd+aRvZXZsHNjOFyzzOxNzBszj
         Nkkk7RlBk0yepxoG8DfGnGVT/VDn6jkS0lj1G0/3hSyyaKbBQ7hES7WkDZ3KDRTlcX+e
         oN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732880496; x=1733485296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3sMy5emdErSKL+MyeTW7qsU/fxRK/CVygOjCkn7jTE=;
        b=cCC8cpr2LkMOc257/IKrr9rLMwQgbM2l+C4W1hHEg5UmvOVxi//mOTY/YIlV/p6Lcy
         PSsrcL8si7ddEx3BZ14F1cGBSO+a0qYwxemXzT7BCbNbfZUOf27ohgzwPY5ma8Wx4YEF
         sXFpIXnpV9/zIvzZ51V06SX5/L158hfpsUlTUzx7vptcLICAl4Tol85XmJCiD9j+pMWW
         4RpJDfAKs4pdKuaXp33SfEZoLi0Be8vTmQAirNN8ChbKNyzwmAYFfBePk4SUUyp4EqRR
         MmrEnLzlegaFIRegXU4MQ0yAr8r7KesLb0KKWgznqwc+y3LJFDyqmYr3ill8qhFdl6Lq
         0Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCWIjcCkwhD/Ey1X3R+c+thPXUBTWc2pCGQa/0kMAsuaG7iV6+Hh3j27dvwiIQJOuF8DnaAx0g0ztgsP1EM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KBbIoGrMXlbH0LC4j8wSQsallNlU/DRD55vQIwldGRDhPC1P
	SQ97SyaUQFFHZnP6cW2faB5ChM7vzUY+p/mTMHVwagcIjuqMAkcloBMOR7GBuS4=
X-Gm-Gg: ASbGncvx5gTJz5MfGfXmjf9VYi2BDCsmc+IqJKSIS1/bGr2RefvrnesA67Vfp+T0Mgi
	+h8FPLCDBHEHtxy5mdJKZa4SaJcr677es0pYHPbct/OlzXK2uKoEswbzWjLhTdhJ1dCVhNBVGZQ
	9x5S7MTGZmmNT16a9CN+jmgJq7AL/xXoX1wG4g91I1rLA/taW828YSFE3gF41ogJGzm0B1O9Xu4
	WHLyTZ55Vugc420p7BDSV7BUJu50PDcCqA5OTrigNFRh0VJaw6FZFBCLRyjTP0=
X-Google-Smtp-Source: AGHT+IEbk/N6DuDN+SePwKbHpNWgQVLPGKHhlT6DQsr1Hm/lrxlr4iXWaEC1n8sXgOSEQjeYKa4T9A==
X-Received: by 2002:a05:600c:314a:b0:434:a902:415b with SMTP id 5b1f17b1804b1-434a9dc3c69mr122172135e9.10.1732880496450;
        Fri, 29 Nov 2024 03:41:36 -0800 (PST)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f05asm81159195e9.1.2024.11.29.03.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:41:36 -0800 (PST)
Message-ID: <4c5acbd2-efb1-4d7a-b948-91d800c1c113@linaro.org>
Date: Fri, 29 Nov 2024 11:41:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: venus: Add support for static video
 encoder/decoder declarations
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: quic_renjiang@quicinc.com, quic_vnagar@quicinc.com,
 quic_dikshita@quicinc.com, konradybcio@kernel.org,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, devicetree@vger.kernel.org
References: <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-0-99c16f266b46@linaro.org>
 <20241127-media-staging-24-11-25-rb3-hw-compat-string-v1-1-99c16f266b46@linaro.org>
 <7d344377-f1cf-400e-a9c4-442123dcf4ab@oss.qualcomm.com>
 <95ec73c9-da38-4888-9e00-4458b5a7661c@linaro.org>
 <f88dbe6d-ceac-4fb3-83ad-f202a4703003@linaro.org>
 <6d3ed1e8-7294-4927-9aac-daffe6ffef37@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <6d3ed1e8-7294-4927-9aac-daffe6ffef37@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 11:23, Konrad Dybcio wrote:
> We can just keep a small function to grab these and assign as if they
> were specified under the root node (check if video-encoder/video-decoder
> both exist, grab the clocks for respective cores and continue normally).

Can do .. IMO this solution is simpler, less code and less risk of 
introducing upstream bugs.

I'll leave it up to Vikash and Stan what solution they want.

---
bod

