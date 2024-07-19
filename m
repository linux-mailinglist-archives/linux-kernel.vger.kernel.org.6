Return-Path: <linux-kernel+bounces-257603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E1937C84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB711C211C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42C146A99;
	Fri, 19 Jul 2024 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMeknnjZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E4146A63
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721414130; cv=none; b=q87GG+WSaW1LBW1nodzJ3+Nskw5CZi0r95ft+kxaS6obR4ai97FxtmoYUGcC7EgDKDyLwlo7fxT4WMkyS1Y2FxzbTrPGE3WGLqbhflD+j7oSpZJ8kbuRjIyti2F4c0Zlwzk91cpmT3Kif8FuNwRuIi/Niu/Kxt+4Tf92iRW1bFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721414130; c=relaxed/simple;
	bh=6KTefgm0JLeF4oJxrRG3MJp5sPnCZdxjfFv+OvybW+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpFE7fdW3Phs8FvOYm4MwcW/hLGdK4KDHaVcUSsIFELRoQeucUx+sQQA/0aLLoIipm6zfcfeLrfX2Nm3XcPsgtPGqGw5cUhLnYbazRQu+mbgBZL5ZAQ01Xz7xth35O7uMhP50SHN6ENpo5TmaBCb0bp4c7UpLlCTe0oHev9UQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMeknnjZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34677so1165917a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721414127; x=1722018927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CmjTlivlrfoumhEf9bC+FgTSqnyxdol//vqbb1jUYQQ=;
        b=mMeknnjZLzvVyRdn2bHgvrJj/reEvIVXEu411x6bdsnNoK/4bWYLlwOPzPUmAfvWj0
         T3nY/k/xrvrT2muUv9reJkVNZjrU9ljShw7OeV/7/Ea86Uaeyw4SlpP9qhXYGwoN+MBH
         uMviOnF/qgBrbKNWR0/yQJP6YuLCpdWIZmPdKz3FLUyoyD3W6rR6DRkBWEYsuyrDnxJ4
         ge7NSWinVnAAICR3MOWM9BFTNcRgqlic0Avqgpb9sEBFvcmf63ShN+QG67QoGOJ07ZPm
         amWRkdxEoTpArb8eVJymPyHA22Zdvz9rwmOi6Cx87bZo0YoXT7vYhrKHKyMTj0oIccad
         S0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721414127; x=1722018927;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmjTlivlrfoumhEf9bC+FgTSqnyxdol//vqbb1jUYQQ=;
        b=mFGdfuEzaTE5aZbCM2xfMS+0IGbhAmmq2JH8qYE5e1Mz+qaz6Lq0gDSNaGjZnlbIIv
         D7vz6RgsNVxeMA1Mt3ZpGU/2t5bAp5oY9hshV32xUmmJOdfVO9YcU29b+NO0bZF4n+eH
         C0YKBhCVL/G3sMRQ6lQPYVZlQT6b2g/1Wb1g/PdovQjzVilqKHXx2FNqUV9vOOlcekWy
         86wFpVFrEtPWxHoRHS31x57NlJMj1sD4kE5BdMjc2ofj+FFPqZdNUiIKime39k4AJkgk
         fgh4OEMEYcKY9lT3+fFkK1RyCmgcqtAQnCU0WJ/ngkZAwK8CyaubwH7aMv0ZkCTpsB9v
         yJUg==
X-Forwarded-Encrypted: i=1; AJvYcCVVSJIfcpcqK6/LLmU0D1WDsF20Zaswyfu8dESRETOqndPPbDHBjVa7fJ9FMyn4+cDZNImU4E3n0q2eAN/9sy+0R/KtS2iPcf2kNjD5
X-Gm-Message-State: AOJu0YwKmOMrcEpNFmxyy66ymTjRrdzznYSDRU0y+Ir6oxn9+HqhsVOR
	T025kavz43JzUXobiRA26mqhFTW6V98t8eO5U5soOmCrh+pDF2IKU4SGNdjs98E=
X-Google-Smtp-Source: AGHT+IGZUSM1D78wEzYhd12ENLvCwz1CrBWhJrDqZYbrchMM/XZRXtncl1e9wcR3stjmlLe1xaM4Iw==
X-Received: by 2002:a50:d6c7:0:b0:59f:a278:8641 with SMTP id 4fb4d7f45d1cf-5a05b416acdmr5787394a12.3.1721414127410;
        Fri, 19 Jul 2024 11:35:27 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30a4d75acsm1545409a12.11.2024.07.19.11.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 11:35:27 -0700 (PDT)
Message-ID: <6526997f-593d-4041-b3a7-a7631b4b882d@linaro.org>
Date: Fri, 19 Jul 2024 20:35:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl
 node
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240719131722.8343-1-johan+linaro@kernel.org>
 <20240719131722.8343-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240719131722.8343-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.07.2024 3:17 PM, Johan Hovold wrote:
> The PCIe6a pinctrl node appears to have been copied from the sc8280xp
> CRD dts, which has the NVMe on pcie2a and uses some funny indentation.
> 
> Fix up the node name to match the x1e80100 use and label and use only
> tabs for indentation.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

