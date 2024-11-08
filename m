Return-Path: <linux-kernel+bounces-402454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB99C27BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF887284772
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1981E22FF;
	Fri,  8 Nov 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zOqq15lj"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E34194C83
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731106007; cv=none; b=eMSC11aKYvP2xwiWEwv4Bv/INaKTONanCYX6BjdcXOeLKK0Xju4ZwjdwZnfJZWwNhjDejcIFLl5SgS5ch36NRDYFHnsY4nRIgHS/WIw4bGFY9KIBqA+jVsfpKOH8E9wfO1h4WpGyhnL1kF8cmI04naFROo6BMa0So5eVieQpNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731106007; c=relaxed/simple;
	bh=wvl9mX+vmFBiDsDTbhPdsBiRGfr24yDQVr9pWlCBKUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKUiEjDbWZLZ869Ni9H1uKfGdhRzUS2F7hPwrEsxsllLKHst3dhlQi0Km7HDKaEN55azTH68DRkYffgmU0LhbPfIfCWk1XlAAHsDkEs39tUfH/6gzL0vsxH/WnkNkw6ms8t5Hd8ME4EvFEdPJ7MXKo4JZaWjbWecHFx8Rh2XTSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zOqq15lj; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e38ebcc0abso29625047b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731106004; x=1731710804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gybKJd4yozMQySGQeVUjW1u2bPYPo6uGaXdbypWFLRU=;
        b=zOqq15ljPL+OGVuMUlwb/5i3osnzQ70mfR+Ln6Q3+zruKPDxo9w9CGCp8xxw/Vrg57
         6S2ULhotW/wiamPV2kmoLPxL5otHB3xd30SFuFASViDIeOmwVRYGNarLw0kefEZbL6+W
         TQXjVkM+4UXuqe2PM3UZq46o6N8+i5xoNTejir9U+1sGFHdBdXxBemsKac+/9mdnjPmx
         EXHmuz+qzR1KlADzX+SLupWW47DiOlXvAbrkFqybFA5QoNNQIry7znEzGODbcYgNlyYn
         kBjAZIgpFL90tJ4sSPQfiXy9hcGFiVty28XDPVB9rzKHzyXkFogllKotJO8aa1xeDYZP
         sPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731106004; x=1731710804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gybKJd4yozMQySGQeVUjW1u2bPYPo6uGaXdbypWFLRU=;
        b=QNAGJOhkjfjK7OgGXdhzR883O7m97+WS38BWiPog2YEAil60zDtS/kOw21hYE6w51i
         RFV7e9OlozZs8L3U1eJrwQCT82XFO1C8SAYzyAzJQgmMr9lvHRvmctSKHCM1QhnKgno9
         +ddYyaS7UntnkXe72yWDMrqR2a9XMRpcZ+SF5SPw2jc2Xxx2IxE65J6ASrxmGXPukjFk
         K2XY+9bjZdsWMKkjcqxKs12kpo3U1P0syHnGoYwl8z9j4wX6uIcwa7e1c8ZA7EQA4At7
         dcGCngh/4FHcYqhnW+6KTkZZ6GYpZb4/TXZV/cQk0EgfEz0mJzBb0r9O6ymGeK0ZoFeI
         /lVA==
X-Forwarded-Encrypted: i=1; AJvYcCXDfGoO5v9MJ34liWzS9F6zS7EGkuEXtgFfMifK95b7U0Sr7Mj5cREbzi4BP25ud3jIZJrcFoR2E5WkUIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6A1lOOF3GlQuWVUZ5dqiMX2Eyu/y1WIUQMrfQNvCwVeLBgqe
	Bvx1YAN49aB7J8tu5S3pvygbhzMdUcQygKLhY0bBkE9gCVJIqTx5Xz7S++xyIQWsXp5H0PFzyXt
	otUxzAa7K8AVkp9deNFYLSMpuNdp8csq7g6/ZOg==
X-Google-Smtp-Source: AGHT+IHPhG7djd76JAwReRTfdeI25+6PxdLvdUpDYWuoC4NJOs1pAxhj475UGUW/fpUc670SsOvrbgumdzIEALNiykI=
X-Received: by 2002:a05:690c:338a:b0:6ea:4d3f:dfa6 with SMTP id
 00721157ae682-6eaddc1e128mr58708387b3.0.1731106003938; Fri, 08 Nov 2024
 14:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109-x1e80100-fix-address-size-cells-missing-warnings-v1-0-c1e173369657@linaro.org>
 <20241109-x1e80100-fix-address-size-cells-missing-warnings-v1-3-c1e173369657@linaro.org>
In-Reply-To: <20241109-x1e80100-fix-address-size-cells-missing-warnings-v1-3-c1e173369657@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Nov 2024 00:46:33 +0200
Message-ID: <CAA8EJpoj1wF5rGa70y2mUgwKQT7B6CE5Wgm+wX1Tcn2+hdiuOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-pmics: Add missing
 #address-cells/#size-cells to pmk8550_pon
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Nov 2024 at 00:05, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The commit 4b28a0dec185 ("of: WARN on deprecated #address-cells/#size-cells
> handling") now forces the parent nodes to specify #adddress-cells
> and #size-cells, otherwise it will throw a warning.
>
> So add the #address-cells and #size-cells properties to the pmk8550_pon node
> to get rid of those warnings.
>
> Cc: <stable+noautosel@kernel.org> # Depends on commit 4b28a0dec185
> Fixes: 2559e61e7ef4 ("arm64: dts: qcom: x1e80100-pmics: Add the missing PMICs")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> index 5b54ee79f048e3208cbcd6f91e0cec073420fe63..5b9d67c340dc7a4550c9c7f16269542e400e4ee4 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> @@ -205,6 +205,9 @@ pmk8550_pon: pon@1300 {
>                         reg = <0x1300>, <0x800>;
>                         reg-names = "hlos", "pbs";
>
> +                       #address-cells = <1>;

This is incorrect, nodes under pon don't have reg and don't use addressing.

> +                       #size-cells = <0>;
> +
>                         pon_pwrkey: pwrkey {
>                                 compatible = "qcom,pmk8350-pwrkey";
>                                 interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

