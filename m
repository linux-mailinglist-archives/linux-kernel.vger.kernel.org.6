Return-Path: <linux-kernel+bounces-398219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3979BEA46
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E107F284EBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E401E909B;
	Wed,  6 Nov 2024 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzxem+gA"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284941F80AD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896670; cv=none; b=hxGHsOtiUzdEnnO5QfYzKgRlBgFZtHwFlXsgnrcnQMz502oekqUiN24epWhNsUK/FTr966j2S/RcKv4P0aoguP6ulwurTWaAkstqcRa0PxjoKhfsEzDNLKL+Tg1am8b2NHk09yla95xlRzgkFM5fR+pq+UwbaJwLZ+exOYFClCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896670; c=relaxed/simple;
	bh=kwmHjPAVawyLF5ecNZoCszuUgpIE4aMH6tKO8F/bZGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltnty0Rll1PLOnQSGtvpSaceGiMdWP8MpPKJv0RRZQ0JTrrXxNvartndDVG0OI7I6LnuV7qXUrs+CcM9h7heZKPkihsfPEuuTuSurt72BYo9M90ntVwaTlfq+bJvESR9mQ6cTb4CONDLtfcNNoY+NuCfRjUoKt42mpgQV0W3SXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hzxem+gA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb59652cb9so59764311fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 04:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730896666; x=1731501466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ae1koq8dMp04bbFTqClDde3Vovpb14m9bsDzfQ/pDI4=;
        b=Hzxem+gAoURgOYJh0T1xX1cAXu1H4qy7in0buGgCL5M8/TLtaL3X+KoqqXapoxNrrq
         3GprIi/qxoM+JoR7hzMbfbzOLfSt72vBdRjiVeViESaMkdw6h1hFqga0pmsh7er9j57n
         XFyhhaI/73defe67u4vPqBoE80gdPOViGY7TnLox1Z/yXS6Bl7UFAM3URNflb6JE7aNH
         0ktnhNjFnNet/1TScRuMgdamRZUYR1eMvpsn4JJR+3M9qr9rKmxp2sVNwquH+U44xG9/
         QS1RYJYwp17IBMbLHUBpTJMaFKUa47/WHQdcpIWuCr7m0b3jXNu0dN6ttiaOzr76C0wo
         zUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730896666; x=1731501466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae1koq8dMp04bbFTqClDde3Vovpb14m9bsDzfQ/pDI4=;
        b=bWn0rC0Kmli2vCG3cxdvdJc59mj+/t9VenatbdbpmK1/DTwFiBUETt0J5QW0NPRacq
         p3TrCNyqBuj8YYYtEcnp8jiRe4cr/NPPXas8iAJ1sRe4MbhHIe6ayFv/xvSPfxkBdqpQ
         LVBBqWk3RQ/NjXMf3hyhaBumkQCak3pKuEnF1tM/+Cv6dIfoBF4xn8SDa92gr0n9cJIz
         +ujyzA23McrM3ZuRqy2tY+iWsm0gGEn+onTlYwXDVpKUX0JGSwI3o9wStL+BWyBCKwm6
         UuNyOdz0Wljj3SqgbMBtCiZIfgQ5tGKXHOaIylfiodWzVyY/Z5HjDeBUSKYAjd+XyaVO
         SzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5OCsHLRDrPj7xYDJaNsuIVYo/Eb5pN+S93eGmdfDzp/wx4WeDBQ4V/TOJ0+3cC1m/RleRp+ePR0UNrGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MRvwCwdOEwE46oToe4BW6sj8Ai2ot1T/UWYUzPGSXj+hNh1b
	DsgwoQ43npC9/KJS/U/okZ2VR92g3Jz1FfQ7lM4r5VpYM0oF2PAb2gQVbhLJoII=
X-Google-Smtp-Source: AGHT+IG18B8XOx5468uBh2oYr28fOGs05I2R99SXd0y1/W0ItCrjogqsU3jSoo/FQC1khD4aOuBaMQ==
X-Received: by 2002:a2e:bc18:0:b0:2ef:2490:46fb with SMTP id 38308e7fff4ca-2fdecc2f714mr118699741fa.37.1730896666319;
        Wed, 06 Nov 2024 04:37:46 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8c345asm24833201fa.105.2024.11.06.04.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:37:45 -0800 (PST)
Date: Wed, 6 Nov 2024 14:37:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: enable OTG on USB-C
 controllers
Message-ID: <hw2pdof4ajadjsjrb44f2q4cz4yh5qcqz5d3l7gjt2koycqs3k@xx5xvd26uyef>
References: <20241011231624.30628-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011231624.30628-1-jonathan@marek.ca>

On Fri, Oct 11, 2024 at 07:16:21PM -0400, Jonathan Marek wrote:
> These 3 controllers support OTG and the driver requires the usb-role-switch
> property to enable OTG. Add the property to enable OTG by default.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

For some reason commit f042bc234c2e ("arm64: dts: qcom: x1e80100: enable
OTG on USB-C controllers") seems to break UCSI on X1E80100 CRD:

[   34.479352] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: PPM init failed, stop trying

> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index 7778e17fb2610..fb16047d803c9 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4199,6 +4199,8 @@ usb_1_ss2_dwc3: usb@a000000 {
>  
>  				dma-coherent;
>  
> +				usb-role-switch;
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> @@ -4452,6 +4454,8 @@ usb_1_ss0_dwc3: usb@a600000 {
>  
>  				dma-coherent;
>  
> +				usb-role-switch;
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> @@ -4550,6 +4554,8 @@ usb_1_ss1_dwc3: usb@a800000 {
>  
>  				dma-coherent;
>  
> +				usb-role-switch;
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

