Return-Path: <linux-kernel+bounces-258570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C4C9389E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3647E1C20C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6FD1BDC8;
	Mon, 22 Jul 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc4IYgAs"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E317C77
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721632529; cv=none; b=cBksnRFzn3GiGqinSTX1avLoae8whtDQQDDn8+MFhAvU8KAboR1XvtbLrqwTBLDYCeqoOJEl9xZ3rj9i+ptRNh3by/kbe2IlkgbvZlrDRk2ecOeIBUkW/Me/mEjgDqctUJxh2iF8bSUybJMpxPHwTvKnZwAFG8s7xunVWkWsI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721632529; c=relaxed/simple;
	bh=JunXkzrzfc4l5XOzx3vNO/SZqFOdGk51V4HbEy6B8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duHikJDNZcviA4eHKNrFIdzE29JjnG/c89O7BMHddCXnwKxfz9wn/jqkXIiQ5lfNRSClfNoobdwwpXXnZMi/MWmM2tB/Bad19EhVUk6l7fmLlsnPquzCCIN5YSd4Y/R61wGl8dBXZr8mE7czqmZJm9VBAloJFc1miWE8BwMkk/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hc4IYgAs; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eee083c044so45068901fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721632526; x=1722237326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6DeasHBm5l7r94AIOITFewYly2vv/ZgayXIERa9+VDo=;
        b=Hc4IYgAsW9bEsG7RJ/N1u06r6NYLAg0TQYD0ua4xZkak2dd+U/h8mwLVCabecRhJG5
         W5HWiccsWTZT/3GnGbc7xBi/G1v3iOguze7JFh5wZ50n2St/qnjTqozVYiF8F595dzKm
         OzTBRZ5XpLivy+LuBNjlCGDcX2E9IRn14awKKMVNB13xylEVXf3xASVzCygzBpib/0Uu
         G8sehE80A7OZMKYew5rROrVtPw0hD6snw1DFdo1DmSt/shudVvZHaErE+H4ZLcyYq7ci
         Whjye7idlbM8TcAxhgSRcxR0V74LwKH39RmFVfMqNMoXZNeicQwtMDe5d4yq21/rRoJC
         5WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721632526; x=1722237326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DeasHBm5l7r94AIOITFewYly2vv/ZgayXIERa9+VDo=;
        b=rlQUKRXq8fmizKC2gLB5zVc4dkLsS5Jg9WJ0cpYBHwMs0Po/8pOhVy/+oa8p+FHH5R
         UOHGT2VJvrI95x5oEer8mRHEPWol65GiU33JpZNN0aqYfiApWITgPMA2uerjjQ6noDgy
         kXwkjd5M6ijrG9UDTkyvIG1GVMCvYJjuLOt8GX4DzgUZRDHML8Qm5AyaCMircdoCJNzg
         HB2XzLyXEFK1oTcI/MwMZJlMOwvshg34rozJ+JSA29/RoEqb2KeB3TFxC5R2lBCMp2qg
         EimoEpIQE3ig/hfSsswznCezMv9nsDQgmS31i5sjWDl+GM9m5qH6xv+b8jHIILpBABZZ
         97pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZUCDqDpTgVwfDQOnr0atsUEoTczX3jx0efM0FlYQEUee2UjMk6I+BaXILVeH2/HvEWL2il2p+O+RqN9/usMFyZx3qaFfnzpquGScU
X-Gm-Message-State: AOJu0YwJWY0FBMePPdXTvw/6ZjGq2GR20kLXshXByQsN54iWRl3eZJcr
	2wjXdF6MwVqNyfQDxGrJTU9TsNfK/D+X5tXJqummV2/y1JrgcsTj+Gb7v9R+KpY=
X-Google-Smtp-Source: AGHT+IEIgyoC5LrmEEQGwXIALUB1F/rCy3akHI/QLl6buZz04VT6lhQn1evWrQ18wpihikm/W+7ieQ==
X-Received: by 2002:a05:651c:1a0c:b0:2ef:2dbe:7454 with SMTP id 38308e7fff4ca-2ef2dbe7664mr23641521fa.43.1721632525909;
        Mon, 22 Jul 2024 00:15:25 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:702:9410:ae6e:5c88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af839a3sm5736923a12.46.2024.07.22.00.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 00:15:25 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:15:20 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: x1e80100-yoga: Update panel
 bindings
Message-ID: <Zp4HCPYId4sjd32Q@linaro.org>
References: <20240719185250.4877-1-robdclark@gmail.com>
 <20240719185250.4877-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719185250.4877-2-robdclark@gmail.com>

On Fri, Jul 19, 2024 at 11:52:50AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index f569f0fbd1fc..28a6ea5a24fd 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -592,9 +592,13 @@ &mdss_dp3 {
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
> @@ -663,6 +667,13 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +	};

Did you omit the "power-source" here on purpose? It works without
because the firmware already configures this pin, but ideally we should
provide the full configuration.

In /sys/kernel/debug/gpio you can check how the firmware has configured
the pin. It is probably exactly the same as for the CRD.

Thanks,
Stephan

