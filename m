Return-Path: <linux-kernel+bounces-247235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E786492CCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A393D282B22
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFE86AEE;
	Wed, 10 Jul 2024 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtD12Cod"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2086AE9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599897; cv=none; b=gEC0diLpXmRUUEeZcvuA1/SNbJvc6yp0Kl6ktDnPxdGfTO2pbh8XVh8OolpJ+ZlB4xhOzGfG3wxVYZiipR6MkbxEobbZdoQBJXlWQSYSYHhNoD0E0+orpE7KyM6qnNbT5WzshS2LDfrfLSN9RFnI5BZE5y5HGDkwklZ+AErUnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599897; c=relaxed/simple;
	bh=ft/s4RwAEz1aMjRIDnQSE8Wlp/rJ772WXIBjv7HkNYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi3ojMbn9xVZIXhYKA6ep4g80jGCmUblJYRXOgGf+Rc6v5yHGkZ/UKXF8G4dfZ684yS1rOlVi5y5IfVX8w2wPan3cVghF0mvSrRmLhdPNt0GTuur0n0GuM2vxvACru2czTrl2LoHVNmOUGuMBAlEBTH01CW62YzLygpZLUWj4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtD12Cod; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36786081ac8so3676372f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720599894; x=1721204694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NReyFCvn2oaxOnidTNB7zmzoIS8+qd2lpQglLccViLg=;
        b=YtD12Cod/E6AGAB0/YUokGRfzSqJJqHj7mGF7rxs8w5o7bOcAmmBXQ4lY+AJRbL+Gp
         qOq9fx3m6TYFr74q/JxuNW1oP8DBwCBoS3Af3tgPwddOHjqla4vOEIGB6WhvZOOLEH29
         pOhw0C00djbktY4XqHGkLlEs67bRdUXIHCiKzqDURYs9ZvZOp9N71brR21L1n89rTFGM
         GEZiDT4OwEBAPvy0fwoYJdN5RwuZ8pFTiCtlNmX1C3D7+xo16BqpjFSbEMtzoqu60xXB
         hJmkgLA4QKO6sV1Du6QLoaTeeGzJpFqJNMMIhgtLkJilY+QAd5zJKNjLmFjiGWXPO/Xe
         K1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599894; x=1721204694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NReyFCvn2oaxOnidTNB7zmzoIS8+qd2lpQglLccViLg=;
        b=mAw6f9PWX2uyAjBvf3OmvCGSPpeWHUJf4krV3O3p9u8O+hf75ozvwCYszkDeXc8BVK
         qrCCuLbt8+6YWEjA1YBvDW/iPcX9pYh81oF+NNhjZKvnpIWJASRS+JFS5bqXqlYRDni7
         EwsQuRy+zY0KCgGVdizwSPiJjlF9d0Uo+jImkFipohy20cEU4seHyLgkRolGehqzRgCx
         ToTnlf3OgMgoWtP34csYHknBhA7cwyny7jnCxS7+YXHxei7LRswuhnvLAbAf4vzQsfh6
         lIFVhdq0jgL/DjGDPuX0QlzkW3uyOWiYhTgbWBnrVnK37P2uQQyl8XrDdpSjhcq+Lb9+
         Pfnw==
X-Forwarded-Encrypted: i=1; AJvYcCV2+EyFG7YPt/UHBh73vlUhStWyiwpxMLMqfqf4K5fSvCaoXLG5ZzZztiY+kj+ZpPbLQ48vr6kiVlvJwZrMDdGNgEX1F+loQx183NJe
X-Gm-Message-State: AOJu0YzwdU9QDPJSrFNVXnZocOfVTgoQGtDfo9TLDgCaf0W9uX+boiwQ
	rvPIxe6JVXez8E+VwtcKdwgiuTVjZiskXMTRTSZILLO0oZQsjiyZkjvg6xslycg=
X-Google-Smtp-Source: AGHT+IFO4doGq7tbbvJ3n3o6M8I5TmepezvXY3YE2FzHbI7HvRCjR8noxf0ICBgS6iflv/V2BewI0g==
X-Received: by 2002:adf:a3d9:0:b0:367:958e:9832 with SMTP id ffacd0b85a97d-367cea46060mr3179736f8f.14.1720599894485;
        Wed, 10 Jul 2024 01:24:54 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa06ffsm4644046f8f.77.2024.07.10.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:24:54 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:24:52 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: Add LID switch
Message-ID: <Zo5FVP80hKGxEoa+@linaro.org>
References: <20240710-x1e80100-crd-lid-v1-1-0156e8a62af6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-x1e80100-crd-lid-v1-1-0156e8a62af6@linaro.org>

On 24-07-10 10:18:20, Stephan Gerhold wrote:
> Add gpio-keys for exposing the LID switch state, similar to
> sc8280xp-lenovo-thinkpad-x13s.dts. Only the GPIO number is different.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Tested-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 6152bcd0bc1f..889253ff5408 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -6,6 +6,8 @@
>  /dts-v1/;
>  
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "x1e80100.dtsi"
> @@ -49,6 +51,21 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		pinctrl-0 = <&hall_int_n_default>;
> +		pinctrl-names = "default";
> +
> +		switch-lid {
> +			gpios = <&tlmm 92 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_SW>;
> +			linux,code = <SW_LID>;
> +			wakeup-source;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +		};
> +	};
> +
>  	pmic-glink {
>  		compatible = "qcom,x1e80100-pmic-glink",
>  			     "qcom,sm8550-pmic-glink",
> @@ -918,6 +935,12 @@ edp_reg_en: edp-reg-en-state {
>  		bias-disable;
>  	};
>  
> +	hall_int_n_default: hall-int-n-state {
> +		pins = "gpio92";
> +		function = "gpio";
> +		bias-disable;
> +	};
> +
>  	kybd_default: kybd-default-state {
>  		pins = "gpio67";
>  		function = "gpio";
> 
> ---
> base-commit: 6fd4da15c334831a865d4700ceb3ff5a917163e3
> change-id: 20240710-x1e80100-crd-lid-4393fdebaf92
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 

