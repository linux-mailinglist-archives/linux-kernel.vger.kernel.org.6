Return-Path: <linux-kernel+bounces-239222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91364925822
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D061C21CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4015CD7A;
	Wed,  3 Jul 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em1HEjWf"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410D15CD55
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001660; cv=none; b=QQ9D0nWSHLVZ6s24wzpguFGYLawMhhYT5PZFm7wlIok91dtp5qS+WcHJzhh16mxY9UVEIZAXMmiB4owiYHqNbL435dGNUY0VkGGVlUF/B07bhL0Y6PtSA0h/04echwk5e0skfn2BkZ+U+nW0B2Zyd88eo96aF2PyhbdGM2wRZJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001660; c=relaxed/simple;
	bh=ADx1HAS6y74RN3UyCopkFwtjf4z/7PUQw7RSzAaLWSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtxwmI67hVkfHk9nU4vuj4VBClEZFvB1L8sMYGmIe+tWYiBvJa4FxlBE6y9cAfujsc4eXvgblh+lVNGXC7dZVgX9a/NYl84PkJ/YVh7m5y46/3BMBMdHBiZV6KXbUIk6UX19FtY4Uigi6w5SoYFsax+94BglU++rs3F9qqpIMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em1HEjWf; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52cdc4d221eso5779223e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720001657; x=1720606457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35ft6uX0wzoy3SKCI7eehotUWy3KQA7aKuUBsAEd3w0=;
        b=Em1HEjWfh149WDBk3CZqcv2ntr9XlgV6dlSGHDtHMrPXE4QElYlz3tJOoZ9GKqH1vo
         Scx4EOI2JIhUp4+hBUxc95GV0NtLf+3BIzVbdiGfr6TJhlCGPMB3J5d5f8En5GUtktgH
         aDWc5V8Q/Gk1O5+JCkt2jGk/LsFpiHPQU1CZNvxQr4oI4OVTFKC/Ka5WXrOM+V4R1nWH
         iC4etrreWDUfAHnpOjkmsqnh0PUvX838TV6BJKkmoOre/ylgNEGfZQ21CmaGOTAJe846
         hlpL+a20UeFIYvPsxBcjZan6tyaXSCnNk25f3WGjBhnFRJImex/jNYIAGTWQ6efuGwfb
         1hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720001657; x=1720606457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35ft6uX0wzoy3SKCI7eehotUWy3KQA7aKuUBsAEd3w0=;
        b=KGKxgPVXrPV8YRQAmNhqLCK86dnOw6OSwODXfu395+a4BFhlvORszhDqLQMc3xoYTi
         JHg3wHMfZq1IkDjT/ZDVv5qI6DD51D2lfWg7+fYUYNF2cZ1C5YpyvX5/lBbCMHQJ9T+2
         TzrT2L6g5lbqMsA12wEm6OUJoQTdByXCTmGNEjGYa5zkqwwK5cwG2peqXE5KJ6T8oG8I
         fndT99+nuqSzOY92VK7xXPFAsQSY3tLkAAGrj16DN2gCbNldArKz2sQP81bltDLBCCDJ
         krnhr6yAJjtN98mo5yRV/V7k9XwgOLEimdVPME6k9z+snvB7ss3KQl3nQBpIHj1W2hqT
         qxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH1mg3uP9BhkV7Arobp46TtRjUhJp3JbzZKBUsQ5Q0Ha/9paYMt9s8LlKtk4hRe7jesQ5dpaJSo7PPxNFPacwi1U5OJN0gxAawOEbT
X-Gm-Message-State: AOJu0YxxPsbBxATPZI56hwH1bYsE7nOpLl/BJAzmaouGN4v75rnlHBEw
	hD218l3R2Mj0kmHXsnCbaT7zGyJjp3I3YBICoJL1J3ybPGgAgmL2/0jzUDYVw+4=
X-Google-Smtp-Source: AGHT+IHM6seix3s7EN57/yRY5Hq6wvZsORJlQs2WavMTMhJlDE9cOI+tfgp2pF9fgXlOFZudF9NgcQ==
X-Received: by 2002:a05:6512:114b:b0:52c:e556:b7e4 with SMTP id 2adb3069b0e04-52e82664eddmr8875018e87.15.1720001656901;
        Wed, 03 Jul 2024 03:14:16 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2ebacsm2117098e87.210.2024.07.03.03.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:14:16 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:14:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: clock: qcom: Add SM8150 camera clock
 controller
Message-ID: <b6nci7iepcoxtdqnrkp3ti3xnm3fxr37q22kqy5wvwapssm3vo@twsyw3cjsruw>
References: <20240702-camcc-support-sm8150-v2-0-4baf54ec7333@quicinc.com>
 <20240702-camcc-support-sm8150-v2-4-4baf54ec7333@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-camcc-support-sm8150-v2-4-4baf54ec7333@quicinc.com>

On Tue, Jul 02, 2024 at 09:20:42PM GMT, Satya Priya Kakitapalli wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8150 platform.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/clock/qcom,sm8150-camcc.yaml          |  77 ++++++++++++
>  include/dt-bindings/clock/qcom,sm8150-camcc.h      | 135 +++++++++++++++++++++
>  2 files changed, 212 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
> new file mode 100644
> index 000000000000..8fc27ba4be4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8150-camcc.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8150-camcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Camera Clock & Reset Controller on SM8150
> +
> +maintainers:
> +  - Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> +
> +description: |
> +  Qualcomm camera clock control module provides the clocks, resets and
> +  power domains on SM8150.
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8150-camcc.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8150-camcc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Camera AHB clock from GCC

No sleep clock?

> +


-- 
With best wishes
Dmitry

