Return-Path: <linux-kernel+bounces-258667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFBB938B62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34671C20FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA081168483;
	Mon, 22 Jul 2024 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJOoAA9L"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E535280
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637593; cv=none; b=TxX//lkvZ6+5iLdz6pfh0mwZDfJA9L9g4pgU8pIxpwsw/Q5xq0yTRHTDVLmhbLq9aInf4f2YTpPgNQMnzrjCo1nWl7naQK5O6L4GOdr+bRfnKXD6RV98g6IJccVfQYVcpXzFwKlnUFSaGRHZRuYAuxHTkLetPBcoPkPj1S8LANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637593; c=relaxed/simple;
	bh=KABt9ELSq/5CKKYmrFwAdJpE842H6eiHLy47tQl0zSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MO0UlFsHVAZQ6iXF6qBJCo/Uc+wg/iKJmo29WnYjLbnozALFCvlFhgJ8/10hJGDZlEp9pD+IGH2vI41E95bK6BewMV3V3n5FjxWdkPzOipQQ3P3aeHQ/hhRIa1VGVqSXzws3Aizsfwd4DhyPloOEz07uE3Ci0y5816WCUyDC8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJOoAA9L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efbc57456so745268e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721637590; x=1722242390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YcwarQKRb2kM93YYtEVe+vAXImf0plWq02dRCjeSMXU=;
        b=MJOoAA9LEh5qBe/Yq7Vbs4VPBJYTjAN0dlicUdRCYLEruZre1ggXt+CZjkbG3wlbYM
         SoPSmPabYljWJGvNEgbgdkWovKzdfmgaJYobY96apVT7Ft3BEPDpiJhd1SomM4UulXbB
         kWQtPbkjviqcpm4iE2X1b068tUhRh9+GouDR+7CCqO/jgj/eGGZVftQITMzMLdtCLvSd
         1ZGmEzChyPp1zwTeT3Vpxv8MRZ58TiOLVRz/QlfRwnpgloTGZjWu2q5Rk6PAG+RYxdlk
         1x3rdDWBBVetAxTtJ9Rucl7YL45PMqvS7UxfX86NVjuohWi1lHr6VAmtexVDOdj7Gvg6
         e+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637590; x=1722242390;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcwarQKRb2kM93YYtEVe+vAXImf0plWq02dRCjeSMXU=;
        b=Bvp8FCAFW3ARBr9h43vnv/k3puDOS4w6DeEPTN1nVz0Yf/0KUDQFSLuQliwTZN3KWM
         T5borOYbcRbPNl+OxGAw0HrzkhAMgOG9LVSNncontTbcXYZ6P76E2QKUQVF2rATTXLjG
         jrAuTURRjp7L4jQItRYnsXZqZh2z9JGocZb+YQSOgzAwofAB2RI4G1Qxc9+UxYv/WQof
         fB8grIF8FQY/hMaRIWSBe4Zb6O8fKxY+ntGhjY97+WnqYcpORSrdJaaelyNDMe7EvVaj
         pfmkfLc84sMI+uDfLskojLUx1Ri8VvnkNLTj1U+3yUH/XfYUC0nk295PO6w8Oobg924h
         NBrw==
X-Forwarded-Encrypted: i=1; AJvYcCWGX+L00OfsQIwhyo8DbpDLBWUwKU38fA6pUXLORSJX8jKiSlDA4zsFUgTnJycyFdOv1XmXNjRS753fIRaqszfIxyA/O23NF7E7CFAE
X-Gm-Message-State: AOJu0Yz7+buopEX6LMPPAZ38Xn9zKADJKgsEdtYQ4z4MsJXk1wsfD9in
	ewA4GAGsvWogqdchQ+tyl+ATiGIO1whj0r7Ky0rgCV+67Wy/VtYSsqY2WLY7L58=
X-Google-Smtp-Source: AGHT+IFHAvQEuSq0mu3GgRocWd6BUwEU2Hdqi/IHLu0Y1KXCWA72zvcqzTlzOGHVYkEmw0TZ8VMMwA==
X-Received: by 2002:a05:6512:b07:b0:52c:def4:386b with SMTP id 2adb3069b0e04-52efb771d16mr3896655e87.35.1721637590249;
        Mon, 22 Jul 2024 01:39:50 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c94f842sm395921366b.201.2024.07.22.01.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:39:49 -0700 (PDT)
Message-ID: <b902989e-148a-430c-a013-172e49733769@linaro.org>
Date: Mon, 22 Jul 2024 10:39:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] arm64: dts: qcom: sm6115-pro1x: Enable MDSS and GPU
To: Dang Huynh <danct12@riseup.net>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240722-qx1050-feature-expansion-v1-0-c4d486435b96@riseup.net>
 <20240722-qx1050-feature-expansion-v1-6-c4d486435b96@riseup.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240722-qx1050-feature-expansion-v1-6-c4d486435b96@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.07.2024 9:10 AM, Dang Huynh wrote:
> Fxtec Pro1x uses the same display (BOE BF060Y8M-AJ0) as Pro1.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---

[...]


> +	panel: panel@0 {
> +		compatible = "boe,bf060y8m-aj0";
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
> +
> +		vddio-supply = <&pm6125_l9a>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mdss_dsi_n &panel_en_n>;

pinctrl-n
pinctrl-names


> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	data-lanes = <0 1 2 3>;
> +	remote-endpoint = <&panel_in>;
> +};
> +
> +&mdss_dsi0_phy {
> +	status = "okay";

No power supplies?

Konrad

