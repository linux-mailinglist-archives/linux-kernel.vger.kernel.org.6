Return-Path: <linux-kernel+bounces-313097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1A96A02A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5211F286B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876364F20E;
	Tue,  3 Sep 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/CA3hm7"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BB47A73
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373020; cv=none; b=i7sEKjSmc1/ZUDnneEyZp3jgAHcMoVfHG+qP3LU2f7tOo8drfBayi5+eyRbZ+luIhRfvXA9/Kp4yMli8voV/h60/xQDE+xnCYwjMU4eo6BQ43WTIEVUVSo040wdZr9ss20IkW55q55BH9kUiEXRAy02SfBtuUm0omhm0QnSA7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373020; c=relaxed/simple;
	bh=FWMUP2m74xm6bc1hvk2IvfKnjTaie0b6M5Gtja/k/po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUPuevsWVDnH5+W74vKSlBRxnUGHyChsS7ktZNwnNtksAm18EB6eeVElNk9NqW3AkNv8RiAtWaplHpO23gqEjBccfRYZWu/L+wANDHqmA3hqEammeetSyIhRH+3fOg61qKmlcdZGFeiySmQ3hQ7d8U6KUIoc3wbh/mjZOPpX3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/CA3hm7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f68dd44bso57167091fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725373016; x=1725977816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EL9ZXgA6LtBR16HzKqqfDvZ1a5cPUdZeJqNvfrQ2soA=;
        b=j/CA3hm76cIKJwv9nfmN/XgIUhEe6sGbPb/qYJJJvtWbR83wWVuEMo8RlGF83T7N9M
         tgoQ1YCAiyKirPEVJlHDzyNjbZRLhZxtI+ucWrAGWk9mhLjbH2dsR8sP+iHhgyYdSBJM
         4DnCqdsLYE/HkRbc7Z6409SYTIWMs0nm3CZ7ADorxvXD56Jd3fwmd3/WdcqVC4JwYptM
         He1B4QUok1XzbLmFaqMUhQVPpjU1GDInvprolMkxjhIAxsNc5SyAmfTJXoClpG/p2Ee7
         eyDbMCQ1cumhq5gxb5CYY+UAXWj8vcgRg7lKH4t+1qZ3nuXYOc3G3RwO/Sb3bE4eni/E
         BlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373016; x=1725977816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL9ZXgA6LtBR16HzKqqfDvZ1a5cPUdZeJqNvfrQ2soA=;
        b=AxF6uu1q9iT4zNKHGZqRcycJ7JSX8QvFq3yzfw6ni/4WgTXUELCiIBrxslfvu9tKhE
         aQMBjH/Vhn0rtG9WUct6izdOPpBVWi9uHrlvBXqoM8dfuxWPcWttLAdVK1JYL0IjzaAH
         zaBpAEvPMfzxI018oW7NIeyxTCzzjJIwcj+D4Fh+c4a8V+5MyMjSU1FHjbhhH3YCcSpS
         tp1PQIdSPQZUv1rmnQUtyj3vVWjHcCAOR4Zz1zlUhiR3NNP9SdsfEvY4fNwC1ijUKy4L
         SXD8AxJibpNB7LXc3Kzy7gbu7WvQfnrmcYvOeiRAOYoWd/wF9X0kz1004m/l0DLuN0zC
         ElIA==
X-Forwarded-Encrypted: i=1; AJvYcCWZce+LLjyAxQEjoUJCxVmnWZObYqwyrX+sFmOmBzGSgdt/PE3dZJ1bET8saYfj6PzlRyNn63H5dG9h9Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3TQ1tnIOQR8gr51azh0PFqmnqQ65FZcenQGkYwvLE2wcaBWr
	UuCzrdP5xtz+kem69Vl14JiDsChLegIvALknktXNy6fdWdVHNi2MuGigBH7JWRA=
X-Google-Smtp-Source: AGHT+IGHOzyEGoVumYP3kpXpooA/pzQcALYbbDevhxibgr+iN62bHnaA56pBIgLuBDcerJ31G7mLPw==
X-Received: by 2002:a05:651c:544:b0:2ef:2f37:345b with SMTP id 38308e7fff4ca-2f61e0a514emr96863661fa.30.1725373015795;
        Tue, 03 Sep 2024 07:16:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f614ed23ecsm22669941fa.13.2024.09.03.07.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:16:55 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:16:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc8280xp-crd: model the PMU of
 the on-board wcn6855
Message-ID: <sjb7rmha3qvcoofyhoemwwnhmls3wnm66rwufmdbahlz4smyqw@iq6vimeayuea>
References: <20240903093629.16242-1-brgl@bgdev.pl>
 <20240903093629.16242-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903093629.16242-2-brgl@bgdev.pl>

On Tue, Sep 03, 2024 at 11:36:26AM GMT, Bartosz Golaszewski wrote:
> From: Konrad Dybcio <konradybcio@kernel.org>
> 
> Add nodes for the WCN6855 PMU, the WLAN module and relevant regulators
> and pin functions to fully describe how the wifi is actually wired on
> this platform.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
> [Bartosz:
>   - write the commit message,
>   - rebase Konrad's commit,
>   - fix one of the supplies' name]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 109 ++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 6020582b0a59..ec6bed8395b1 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -260,6 +271,67 @@ usb1_sbu_mux: endpoint {
>  			};
>  		};
>  	};
> +
> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&wlan_en>;
> +		pinctrl-names = "default";
> +
> +		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;

Nit: bt-enable-gpios should probably go to the next patch too.

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +
> +		vddio-supply = <&vreg_s10b>;
> +		vddaon-supply = <&vreg_s12b>;
> +		vddpmu-supply = <&vreg_s12b>;
> +		vddrfa0p95-supply = <&vreg_s12b>;
> +		vddrfa1p3-supply = <&vreg_s11b>;
> +		vddrfa1p9-supply = <&vreg_s1c>;
> +		vddpcie1p3-supply = <&vreg_s11b>;
> +		vddpcie1p9-supply = <&vreg_s1c>;
> +

-- 
With best wishes
Dmitry

