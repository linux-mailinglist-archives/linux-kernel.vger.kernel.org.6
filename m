Return-Path: <linux-kernel+bounces-259993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E627D93A0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ABE283A76
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B46152DE3;
	Tue, 23 Jul 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8IW5X14"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DD015278A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740432; cv=none; b=YFiq6eFVVPmscLGtHbb7j+CsGCLwUsokvBBR2VkES0Pco6BBekA1CdBI0p2W0kR7YhOZS6UTUaTMYKerj44wWks7NkJDlOO1DbjiU6hj9jTcIqRjSod1IIs2MVwH3QFtQbONFzNY1jTapc1R+aLNHgVklBkPIiInqD8ZKbZ6Up4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740432; c=relaxed/simple;
	bh=lF/+vMggfKWSaMHJBxjbtLZcub1D1azM/I2LflyHQfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=knjc2M/HuH6mMIQ4wxpyNgdANAFJUxXQCDDR3p+OPwC0TSBd/CbuinFwQMBqaA3lCXicwnU0lRVRTQr1YPg/auDX0jZ1LEnt1RSso5mOTTKhRZutlCTfcI84C2sFFztVeD23M9oUxpDY0Ls6H/V+jB+oJqKXkrFrLIaDXrFbPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8IW5X14; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a94478a4eso135381166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721740428; x=1722345228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy22u7vGVtLIGD6YtQXWtgjKoWx/6Sjj+HMA0+ZCpdI=;
        b=J8IW5X14TDvaRVPrKOWFujGoCqlsj5PMCSz2NFIaF/jz7DFy42+zxYUy4CfgGuFFoX
         82lfPwcqkREeYGScrnB2PErtlphmEXsfUMZus+y0Z7GEkA7byJnhuzRi1QxWm3suetuV
         qoEE4CvClb4ZRI+BADzokGUzAb3tEe/DveUkbbP7WBwxaDKtmq/vkrSDz26SXgsxSSsj
         RvLZ7hbddtfI/zp1vl12c9UUxm08R/MgnGM/LBKetV1CNcyZ6hqqJZk0wtqVbU6HMtea
         o54o/1PXdlvzPt/FAdjlTewLy4oxwjelGdCL6phhP8uiSjOWeEkW+21fwbOJ36XrVbd9
         bUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721740428; x=1722345228;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy22u7vGVtLIGD6YtQXWtgjKoWx/6Sjj+HMA0+ZCpdI=;
        b=eH3FzX8aOOmSIDBhK/5gYfAEiwrl23J6NOAT/BH7vAQLkOsFX9sUUhzpa/1IbAGZZ1
         CNlsVwG+ptimMQkeyWihcAJvMLJOK7Qlo+9AK2d6UaoXPevb79Kx3x0SWbW+r1t6sPLL
         NLPtXFuqr8i30HTu4VaWGXSqHl8IP8+LV/5ibLjHDReIbU0ay87dzeFGafE7D0kNTaxq
         oeU1tft0zSqV3MS18IBwZHNlwwtpVNSbH7jLZm3mngQBMaB2hsQ3jGrBa8MqC5ILnrWk
         70yiELZrmKDjY7Rp5biVPTyIUKTIWI05sPtDm9TVXiEDX+IH5CNx/Ur8WKoWTJaj6RVB
         qioA==
X-Forwarded-Encrypted: i=1; AJvYcCUUqN9NVIeglMjjHPAmeUdn5gQY09n/w/FO8px2EEVg9HQ94WqfOq9jVX3ydnDpsjwfB2lyqWAgyhwmFVS00ujkS/NNmrDnzIyc82yY
X-Gm-Message-State: AOJu0YyifEDhV7zfW7WHCtxkFvrsHwlPGYklYHsb46S7uZ3lGvjAnsSh
	siKjdi/y1F3q1MM+cNamu3wVNwgqxMQXK2OuVYuSea2GCpNjtg1o2+XJdi0KyJs=
X-Google-Smtp-Source: AGHT+IGMVmebSDjbhsd4fq3wWXlBTcxDtP/5+pnCBYfWlf12h7jzobyJBZjtKLj3P8foLWmyHg7HaQ==
X-Received: by 2002:a17:907:3f0a:b0:a6f:4287:f196 with SMTP id a640c23a62f3a-a7a93f37bf9mr238943866b.2.1721740427941;
        Tue, 23 Jul 2024 06:13:47 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c95111fsm538556066b.216.2024.07.23.06.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 06:13:47 -0700 (PDT)
Message-ID: <c5f8cd32-d5c5-4c29-be8b-571804a4b088@linaro.org>
Date: Tue, 23 Jul 2024 15:13:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-samsung-fortuna: Enable the
 touchkeys
To: Raymond Hackley <raymondhackley@protonmail.com>,
 linux-kernel@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
 Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20240723131142.1703-1-raymondhackley@protonmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240723131142.1703-1-raymondhackley@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.07.2024 3:12 PM, Raymond Hackley wrote:
> The phone needs the touchkeys to be enabled so the sense lines of the
> touch controller are mapped properly. Otherwise the touchscreen is not
> mapped to the display properly.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---

Fixes?

Konrad

