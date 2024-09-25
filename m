Return-Path: <linux-kernel+bounces-338037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E8985290
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A7282F37
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517384A32;
	Wed, 25 Sep 2024 05:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BotfmFAG"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97B132103
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242757; cv=none; b=CIe03zAcYLU7Np4+5cNXO2cLnRsu1wtKxHdJ42Gif4htqmRdsBupBNiLgweQ78OQm5Df+O0BfU9joff/8X0w2Fps29QJ0AkLeq2bGs1fN8hgFHydMbfwLMRjc1oK0JwClxvwyrO/enZKGsDZkLTbMSR3ZxHIfZuF8GWL61bqjFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242757; c=relaxed/simple;
	bh=ioBjncIRbnomi2/T1x4IMAoeQBg0/qKRK6KzIkmrYpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBvhz74rxNqFtHwTYMNHCUf+x/ZKLtsQIxwHCkxQapmENsCmZJGMfVwXIMohGH55f2AvouIWdUPtHc/X+rjNKwIVTg/qlECWMTXT4nmoujfi54hIp2burkdWBdBALpkTZeGRstsLUzbnqI99g2/y8EIYpbouLkZwxqn0IoYik9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BotfmFAG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53652c3bffdso922705e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727242754; x=1727847554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NuoTbNYEXcRzlHV0UDmWGbYbWThePpqhU/Cw4g62gBU=;
        b=BotfmFAGLE45b8FzqN/kT+IcV5FsiX0+l40BrsV5Nagbg0bECCdLRMn40Z2D3ydtDP
         M1wb+g3wC/7qrRNpfaCQttbVXTCiiCgzxKJl8Q8mJKfmMLPMfg9UpkB3pQrchh7xppBh
         n2/V732CGqyI5FT4WZPZsA+s1QtIwwEPBCBbIRXVhm4eRQzxewSpzeI5hyKIuL0IrjCO
         YGgfQ0Q0jOtkSe3Ioovz0jwhuKU42MYGUSDbFwz6CAUmtISQtRXtskAVbvWjTfjJwWfj
         kcSNxaNPnmnSm624Gcrh5WKG2AbHByVPvg4NV88zW3E3DVwVW6Rn/Y5ocKLFjy5I1XfJ
         ACFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727242754; x=1727847554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuoTbNYEXcRzlHV0UDmWGbYbWThePpqhU/Cw4g62gBU=;
        b=c7YfxhakHJJD4leGKgl/T5U91zgliUz2g0aYt9ndR0cFBsiiYkTMrcjdPClh4EcM7P
         uoK2ki7JxJEF6XbkdbrSG/hfDM8B13BuZT4jOx4Mit/56CpCpCU4VPHryKQgoCrRbVSt
         Tbt7gHo8TAV9LU1Ec/YoVJfjc4vl3QAJygMmDg/RgggVpGvERvE5k/bqqvHkeRx2sAu3
         3csH/27Vdsfw5+9t8kDccYzxxOXPSSqkmQY7ZNQamtVMqY8TD1C6apRhkpsdLlwMT8+8
         G9mx2cfzJp3P6Oxn9rlR2XoAh3kYjAka3NQdHNz43mPx9tnFfsQQeiaTAw+r5iTw7h92
         IJOw==
X-Forwarded-Encrypted: i=1; AJvYcCVdjL4GdEKo3rs/ZKP+zKCLrywdlhH3ekg5ce4hqmO4ZktIT+xQi1HUTbwTI+CD4Abs1fKaRmKvtU4ts0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8IMbHHPReSdPjumYoW3X+YRXabvW9z/2+z/pTFK3JgrjGWoW
	Ef7S93y7xxkQHzrVMFiy9o+TuM3T5qMChrBBrzrhcDzy5hrUfCAJn1HLJbi0bHs=
X-Google-Smtp-Source: AGHT+IHF3QiJxER+VyGdO/3Hm3IdA+yzkNdykvDcKwwmnQf+UaG3+ePGNNZ29XjKb6oMtDXt0vv/KA==
X-Received: by 2002:a05:6512:3b98:b0:52f:c438:883c with SMTP id 2adb3069b0e04-53870487e54mr207685e87.1.1727242753829;
        Tue, 24 Sep 2024 22:39:13 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0b8dsm418150e87.61.2024.09.24.22.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 22:39:12 -0700 (PDT)
Message-ID: <4de5ead0-0d66-4e57-85bb-cd8a6ca29fcf@linaro.org>
Date: Wed, 25 Sep 2024 08:39:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] i2c: qcom-geni: add 32MHz I2C SE clock support for
 IPQ5424
Content-Language: en-US
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240924065020.2009975-1-quic_mmanikan@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240924065020.2009975-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Manikanta,

On 9/24/24 09:50, Manikanta Mylavarapu wrote:
> The IPQ5424 I2C SE clock operates at a frequency of 32MHz. Since the
> existing map table is based on 19.2MHz, this patch incorporate the
> clock map table to derive the SCL clock from the 32MHz SE clock.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   drivers/i2c/busses/i2c-qcom-geni.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 212336f724a6..bbd9ecf09f4b 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -71,6 +71,7 @@ enum geni_i2c_err_code {
>   
>   #define I2C_AUTO_SUSPEND_DELAY	250
>   #define KHZ(freq)		(1000 * freq)
> +#define MHZ(freq)		(1000000 * freq)

pleae drop this new macro, please use freq * HZ_PER_MHZ instead of MHZ(freq).

KHZ(freq) macro should be also replaced by HZ_PER_KHZ, but it's a separate change.

--
Best wishes,
Vladimir

