Return-Path: <linux-kernel+bounces-277906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E194A7F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D961F26AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330801DD3AF;
	Wed,  7 Aug 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7VSnXZL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD021E674A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034560; cv=none; b=h8AWhFdQ2k0EkVO9rBsNZu76NpoCbwXAAiGQxeM43DFkawaycFf3k+hAYKaMv0BCJNufuLI8gy8flcY8bDn6av5VbkC9jkZQuNsxCrXK+h2Ev6f3n1iEyLCvsuGBlLecw4tBTGxNDnBd4yM/Pu0op0lQDn32TmVu72WVes7KybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034560; c=relaxed/simple;
	bh=9Y9fTcOhiBPuA873ux/LX6B5gN+erlEY8ha9Ck3axBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tcy3AWoyg8y/7aabyhGc2M/oy8cIwVddTWYU00yUq/fiEQB7sXgGMEN4AQYr3CpzRm6yK0MUJOPEn3kfCvr1XWPefJolPCmC4kow5e5gDU/hmvWJiRLzeRCu8t2fOTh1sTEdKdYZAp8+D9TTztBfqIgty8E8pw5csJiel6gJY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C7VSnXZL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so232811966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723034557; x=1723639357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0KduDAjvBohMYXY4M8kHhofc2W7E+OIMPoPcc+Z3/tI=;
        b=C7VSnXZLbDFH5/Rg5Z2EFXsmohkNxewbw7tPJuNo51LLW5dvUZ0NyPJObFKypCKz3b
         zsnsiWfNvmDZ0KFLaXje+g81RrewzcLazHNiwYR8tMQMzEnpGRa7Q7BB2/vcz8XZemJR
         HdFkNH66FPpPgyNS5xMkW0HvpLfP4uKXzQQXqJBuc1UPMmPwvbnyDdXGlSGodM833MO4
         8TrR5ucC3CYBJfnKW/HmtvHaEXsqW1Vt682owUvGssqhRlYEmcmeeewlzmI7inKttE9i
         db9fM7PW3MKT82kUu9eWVbu7/t1ZvDH/5THZZJKpXLtgVWCMAh6a4QsbcUK/MEJRXdKb
         KIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723034557; x=1723639357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KduDAjvBohMYXY4M8kHhofc2W7E+OIMPoPcc+Z3/tI=;
        b=aozDV4f/FQJj0WhhRLympYszOUYD5LaK3MaOK073m8nWp9wKbLJYUHiq6SBMsOKQ0r
         ek6Y3PpSQSWIodbrLcP3pZLjvuKjRbW6ljgOlMxqAX/IgZfdCJ2EZjAi7OMKRTekw/0p
         Omov8YHcZt/78fVAENBvBsFC7sAoI+AryfIXiwvvpHyTQ14F4SIMZAysFQoa/wwuiXOr
         y7W0mF/6aL97BvgOQ1RHMrHo+hgwdTVOblgCV/uyZ1mSDGwYgWVL0Ev7nS9KyRiZQfQK
         6FkPBm0tnEq/Ix+kOhUGcVapEa0x8QmylV44npjNQb314FntF1wQBWW88E4qzjc7xsjZ
         Q6qw==
X-Forwarded-Encrypted: i=1; AJvYcCVvXjH96+BXPSJBJ20o7BzOuiug8l9siIODVV9gTeWOBY19djYix4gdATCgrYEILSusZBrDBmmcY4/qATs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpVI1egXpAOvL6AfnNepbYVmZWPjVaGYvoBSvlTDp9y1TYzfp
	FCmHeoBtffqBtvlxJdw7yCmjHyhpseittKwGDxHvEeS2yUN3oAGMwMZatGheYa8=
X-Google-Smtp-Source: AGHT+IEqud0+ETf/nPRDTg2cemFiL5vHCF/0w2D2H92no4nW2InXkuGAQgnIeQpmeY4yEKkzHqEbSw==
X-Received: by 2002:a17:906:7303:b0:a7a:b4bd:d0eb with SMTP id a640c23a62f3a-a7dc4e8764cmr1345394066b.24.1723034556901;
        Wed, 07 Aug 2024 05:42:36 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:dc22:8b8c:c079:b18e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e841a7sm641107566b.179.2024.08.07.05.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 05:42:36 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:42:31 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] arm64: dts: qcom: x1e80100-yoga: Update panel bindings
Message-ID: <ZrNrtx1qvPYatpsw@linaro.org>
References: <20240806202218.9060-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806202218.9060-1-robdclark@gmail.com>

On Tue, Aug 06, 2024 at 01:22:17PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks for the update!

> ---
> Corresponding schema update is in drm-misc-fixes
> 
> [1/2] dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45DC02
>       commit: 1c4a057d01f4432704c4dc8842b6e888a91d95df
> 
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index 70977e9fa266..3c13331a9ef4 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -190,7 +190,6 @@ vreg_edp_3p3: regulator-edp-3p3 {
>  		pinctrl-0 = <&edp_reg_en>;
>  		pinctrl-names = "default";
>  
> -		regulator-always-on;
>  		regulator-boot-on;
>  	};
>  
> @@ -592,9 +591,13 @@ &mdss_dp3 {
>  
>  	aux-bus {
>  		panel {
> -			compatible = "edp-panel";
> +			compatible = "samsung,atna45dc02", "samsung,atna33xc20";
> +			enable-gpios = <&pmc8380_3_gpios 4 GPIO_ACTIVE_HIGH>;
>  			power-supply = <&vreg_edp_3p3>;
>  
> +			pinctrl-0 = <&edp_bl_en>;
> +			pinctrl-names = "default";
> +
>  			port {
>  				edp_panel_in: endpoint {
>  					remote-endpoint = <&mdss_dp3_out>;
> @@ -669,6 +672,16 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		power-source = <0>;
> +		input-disable;
> +		output-enable;
> +	};
> +};
> +
>  &qupv3_0 {
>  	status = "okay";
>  };
> -- 
> 2.45.2
> 

