Return-Path: <linux-kernel+bounces-200563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B83E8FB1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54F01F25ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ED0145B1F;
	Tue,  4 Jun 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFpEbdUe"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D4145B06
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502689; cv=none; b=lxsVpM1Jby7cJf4WUwDZBCbLtiNen+U4B7KeDEisELUxyfi+dUJXXLm+rhmE+LN0qi567niJJKRVNjn6lYtlYaT66r5a6vRBDpd2jbXXFEIVv0usyMXZfIg/G4JF42BAbWwZWjV8e6EIsy3zbN/pOO0hDeGbSikWbgvvs7uofKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502689; c=relaxed/simple;
	bh=1WuOXyN04TmrM9nXNwktOy5RmEz+O/pTCDm+1/r+JDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IQdqeX7rlPbaOWLM/Vd12qV616yJgfj8oMibuVXnkPhxApveXo29FVgDasHWWCVUQGbEfpcm312eStzsy/8F+qju3wFsv7z0sSinLf6y9qBLQLtuPDvOZBahvbd0xxoNr8Ovm6gjWl1hufLF4No32pVWCX9e2FuzPzNvN3VnmaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFpEbdUe; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso2590880e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717502686; x=1718107486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CyJclPiQLaozaD/+DIwrfcdPK1SOrSCe1W6tT7ctbPg=;
        b=zFpEbdUeasyUVQe9XVE2/x3uBvybSGHu0cHDB6n+yPeTuAGWLG7akhDhHh7d8gSrU4
         kXuurVsls4OfmNeILAIMeu+O6xsliIduSpYWvbNxASHSXMWmQKFUczMpxNS15Kx9CwRq
         32IRPy3lURAX8nAnxXb5Lg+b/cGASYq30IIA0VhnlOCxqFBv5bPwcSiKugrvAnNmIs+s
         e29NTx0RlFvaB7KWnr3uEgjE6BR4hSn9V4Rc5c04BrjCkK3yvv9jfr+cNcX8ge92EtcM
         iU8uhQKHsz6a/sguTZIOs6NfWVnlxmAC1V1klR+p1vbA7PO9BG64GhB2UpCbIGxk6d8w
         D3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502686; x=1718107486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyJclPiQLaozaD/+DIwrfcdPK1SOrSCe1W6tT7ctbPg=;
        b=ftdLCN2rGZLlonudgx7RQdf1QZzgpMMWSfOXPs+yYvMhBsCsUc64gnAqMMW88J7+b6
         c5k6G4bZpkmh2py7A8guiMgIUxn9DbagQjAgOMljszF2gFCHxYIwR2/pRO0OBgePlN82
         F6+FnCQFZAKa5PoasM8tKYeIgSU6XtjJdqg8Pe8p4Jt/rq3KaCWre1ztzRSa7b3dszka
         WFytVIoQRFF6JakM0szHVmtxJiOvc69UOIIeZTxSVI8dJUgmJJg/u+ms6RCUAUWlpTHl
         7aOqzScrIQmwN+RvlkJfGj2Nb2SY9ozdzPY2RHRzNvNPUTz53dtPJwbcRhtUTeDa4GCR
         thRg==
X-Forwarded-Encrypted: i=1; AJvYcCVrfLsQf+8pjt6NtBXoGa7H239e/byA53KB5IBDbQTwwup1R4HL1N1FsYbZTzNZLai6QiSUp9MYDKwyvMpQqpANyFfwr98GAAIKz3TZ
X-Gm-Message-State: AOJu0Yy22bS1x5fDnLaj2Fs40Qd3ugPVcWcD3BncTzYt4VFbpnW+5EbM
	YJwU/xQlFmYxrKZxDiCOa3kDk3j27qm5BY9zOFBaeGlDuFFAM3BUUHaRzMJC3Iw=
X-Google-Smtp-Source: AGHT+IHRrHR81EbSwVu82msyFqCaDZc5ExfKcdZ51K44mip9EtBf+A2UiJq9mUoQdSdaLWzzLrIlVA==
X-Received: by 2002:a05:6512:7b:b0:51d:a1ca:5f26 with SMTP id 2adb3069b0e04-52b89573c20mr7977735e87.20.1717502686433;
        Tue, 04 Jun 2024 05:04:46 -0700 (PDT)
Received: from ?IPV6:2a00:f41:909a:a11e:a035:2af2:8d85:1f72? ([2a00:f41:909a:a11e:a035:2af2:8d85:1f72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a7debbeacsm1553479a12.64.2024.06.04.05.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 05:04:46 -0700 (PDT)
Message-ID: <68b61899-3d60-4fb1-8170-4d59d6edf56f@linaro.org>
Date: Tue, 4 Jun 2024 14:04:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: add USB DisplayPort audio
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240604094947.98191-1-krzysztof.kozlowski@linaro.org>
 <c3a922e4-0b34-4b53-bdbd-a62817a68db2@linaro.org>
 <a0051325-02ef-48e6-ac7e-57c18c8abead@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <a0051325-02ef-48e6-ac7e-57c18c8abead@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/4/24 13:59, Krzysztof Kozlowski wrote:
> On 04/06/2024 13:56, Konrad Dybcio wrote:
>>
>>
>> On 6/4/24 11:49, Krzysztof Kozlowski wrote:
>>> Add support for playing audio over USB DisplayPort (the two left USB-C
>>> ports on the CRD device).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> Looks sane. Are any UCM changes necessary?
> 
> Yes. I already sent topology pull request. For UCM I will send something
> soon.

Great, thanks

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

