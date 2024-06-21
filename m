Return-Path: <linux-kernel+bounces-225319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B0B912F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B52B21E97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F76416D4DA;
	Fri, 21 Jun 2024 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHEBbUjv"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F531607B3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003601; cv=none; b=THKY6QGDa4kPG2QS1ogewTNdWdAuG/TQ2iz6oOzu3HNrCDKl7PwXVjP6B7DbX7+ZC1amu3pkwfFqvC9ydK4TW/B0rISi2D0HcF7np0mjclWcKg2xIdsiZbGjZ+ezvxkWl47AXfb2jFFRpdfhsLD1HS1Aue13GuZatakI607AzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003601; c=relaxed/simple;
	bh=lXlXwgvsH/u00Q7DipiqE8mQo6sxT2zO0sIkOyB4Djo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GU99HDjOGm6Ev/hhIZkKY2zqVmK1z+L0ugAOAxM2RJKuM2KCiPeBRKkh6ZGICGpxZzzBdsf9xvi0LUa5eKfUeDADMXTHE0EHjIFNszbRyz7O0mg2Ig1DijjEs8ibq1BFvzyooe0UOwL/XZ3x41kjQ80CHyEMkDJPLwS4B0dmkTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHEBbUjv; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so29615511fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719003598; x=1719608398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KJNHE2Yh9z9x99/UWafslJTfFiwh6HKHJ78d4n/rs=;
        b=kHEBbUjvx+NwYRlxq7Tm91+U0hgRBoGVU/tbZx38q5aZRNeCCKYPVVRllGbsURHUF7
         shQ7icrNt54n7+Yld/5uiqwJD8dNXWgNMqfuurle0NLMdxknNVS2eCP2f9LpBrFzFJfG
         7Zjr8kJKTAYM/KKRocgFAb8dmT9G2EdfbJoNE9ejvjKGqFTxOjmAifj8zCWIKvc3LpKz
         5gKcJkVWRqtTh3EZEStv8hpAu6Cb8E1yzrUe3k4/V9bXouoeY/LWx6yX+4KJb7fsroUR
         CiBTuA6MvSqev3fXF3neQq42aTYm9dpN6DdYyMuUwLRWPUr8P+CbrMcTz2hj8pERFkB3
         Gizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003598; x=1719608398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4KJNHE2Yh9z9x99/UWafslJTfFiwh6HKHJ78d4n/rs=;
        b=Amj4m36sqIEbTqZmazB+5JrtxOiH4qT0gji3LILHS4z2FPPaaND95RCmw2sXgf34vm
         dShG3RfBNG9R7OwzJmlh9y4dN0gpNhzEpeo9j/lTqttgX5N57BmBDdcScpw6POlc4vKF
         g0lO3QCxwrtH6Yvnia+WOa7fvBLxQMX3djAWjY+2u6ZG8FnopEIY/z8kO/Qz+bwgVbN1
         5AFeeM5EeSLkafxcMdDHe1wwOBilfRYbkt/YP0C0bG5fMiPdIUSyG3cEms5VTnFPlKSw
         z9PQWexhOg2zv8osHTLzqq+DMeEQATTcJe2x+rc0o68DGSWZWa2fS3lBGgifchXvlqJU
         +DoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFFyrDo8qlrsGXwOSpoDPXzhsPIjqMoh+dH9oaap2iB0I91wdDXur8F/W6cYBNAAoi9ZjMfMapY/+yX7tcgYbqZYh1CqI09a2I6+jb
X-Gm-Message-State: AOJu0YyGSpiuLSDeoq2rxjmTlGUUZ4txtupiNyGku3YFHJ8HgG/AJKgn
	SWTPWTT0Z3bbEsPbhiDKl3XK089BGRZv2fOXWrDHs85Tx7AubtHv9t5u1yJ5Qew=
X-Google-Smtp-Source: AGHT+IGJRl22wlXlPn/cFCkpDq2XYJl2oFfqoxtEkZM3SLUkDDFkcdb0oUqIl56HJ6bKv6/kJFCYnw==
X-Received: by 2002:a19:3816:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-52cd76f8001mr1810466e87.56.1719003598352;
        Fri, 21 Jun 2024 13:59:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63cd109sm309051e87.116.2024.06.21.13.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:59:58 -0700 (PDT)
Date: Fri, 21 Jun 2024 23:59:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Valeriy Klimin <vdos63@gmail.com>
Cc: ~postmarketos/upstreaming <~postmarketos/upstreaming@lists.sr.ht>, 
	phone-devel <phone-devel@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: msm8974-sony-shinano: increase load
 on l21 for sdhc2
Message-ID: <bfrnrornuitylcz3nui5adz4zvziorlxesxpuxn2ouziifazsv@uxm7sz7axtro>
References: <20240621-sony-aries-v1-0-bcf96876980e@gmail.com>
 <20240621-sony-aries-v1-3-bcf96876980e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-sony-aries-v1-3-bcf96876980e@gmail.com>

On Fri, Jun 21, 2024 at 11:14:48AM GMT, Valeriy Klimin wrote:
> SD cards would exhibit errors similar to ones described in commit
> 27fe0fc05f35 ("ARM: dts: msm8974-FP2: Increase load on l20 for sdhci")
> 
> This patch applies the same change to the regulator for sdhc2.
> 
> Signed-off-by: Valeriy Klimin <vdos63@gmail.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
> index e129bb1bd6ec..6af7c71c7158 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-common.dtsi
> @@ -380,6 +380,8 @@ pm8941_l20: l20 {
>  		pm8941_l21: l21 {
>  			regulator-min-microvolt = <2950000>;
>  			regulator-max-microvolt = <2950000>;
> +			regulator-system-load = <500000>;
> +			regulator-allow-set-load;
>  			regulator-boot-on;
>  		};
>  

Just out of pure interest, how the value was choosen? Do you have any
reference to the vendor kernel or DT?

-- 
With best wishes
Dmitry

