Return-Path: <linux-kernel+bounces-237049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917491EA4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A613B1C2129E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E4171E58;
	Mon,  1 Jul 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdaH5i1n"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C6171677
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869106; cv=none; b=nyMUsDUcmr9WJOGKHFsmloaZohRmrX8VhCrgdRIDvjkznYTBs96wJz1G6FibdlDCLZZ/bcER4T8EZd/dpZZouBsVzYjY7oqUSl1ej21MgdgRr7nKEIm0OOXKLwBVA18MZDO1+PBkoLKZ3c0K4ee+NukeZFQynSMXiiagK48hRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869106; c=relaxed/simple;
	bh=E+YOvaKlzqdaFLgIijZX77V+i9HowcxIorc6P65Of4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdgDLGTPvIIwIDYUlg24TEZFYtY2vJJ4uiyY+JTfvU9dKNzIlEBvPLOpx3h/kXKHRZOCiUiwJAAXXJejFHEtzDQhsY/n62K7jYYqfgWCVnMEeceN8UdteEujraA3wz7mgc4lEgzeFhNfu/7q/pUh+hn1Q/m9w0d/xFt8x8aowSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdaH5i1n; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so36090851fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719869103; x=1720473903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1a8uL60fLg0Pow8Jq9FnHXjlODT5DmB/QbQpLLAEWCQ=;
        b=wdaH5i1nZ1LB1A+4TPgXYGtVTACT8bIcAyz0gIISW+pKRqNl2fNHrmv2PufjpODpRn
         wrybCwL0BULCjLYZ4tzZgaDonIyehKERpr9nHjydb5FSWL0LfO0A0CBHF9YD+jDCuIom
         NywS4krV32ity88twVYoC0LKE8OK9JrwIDQWvl8zj+2rFrYKwnLVNxHK6YiJlDqsUL2c
         huWIn3orRAYWOFqZhkbbPgrWxgG8KZSftwlZ5VyAWBBszivQLsLfxABGHbnTHurVfy8w
         976EaZvq/6ETMjhoPkOaYfLWbmt4M/Pvat1FiIKXlGu7sLTHJ4bA09+CCQ907lf13ZOn
         4YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869103; x=1720473903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a8uL60fLg0Pow8Jq9FnHXjlODT5DmB/QbQpLLAEWCQ=;
        b=bL0GwQDdcHibfWj0uaO9alO6lRElSaUGZGeLsDRoSJ+vLzYjCvZSR9t6WbS6b3P8mR
         VW0LKqmQDEWJCyL6IDAlueZg0FXkp0dkQ+MuQnxM5vdoDYLeesGECavBMN1P4mdWKbK9
         Byafy0o8pER0cAHn7EFV/6KXEBqn4shvLaWRcUgb4HztHTCTHWrvv5x7RbHoM8LCr1y4
         OuzOUSNqsikSioVXljlOMTAzqBx8Cktt2MoXmFtd3ybsuYw0DgceTRrCas88JxqGeT6Q
         yM3uc6r1cgSuOq15hwJRHSAWL7YVzEpU9BqhWSyboN+Y0OSvb9IT9gr5mv03t3+bCJHf
         4D6w==
X-Forwarded-Encrypted: i=1; AJvYcCUKavM4TEz+Iwon0CjT4RxC3roX5AVK7RS2W2XMndC0Zxm82ImmYH1hXGzHj9r/iJDDUAIVgZp57Wt6hrg/0MLkVty+2DlThI5x9yuw
X-Gm-Message-State: AOJu0YwllylxRwYtIPVjDoBQfTPKqeeCZj7brI+ktOHbq7sKkfs+s23T
	HjId/J5U5hM5a4w+JVQ7aUQIn2jN+YAqOgMpwcaxyqY7SmyPVagBkqmRCJzbMQI=
X-Google-Smtp-Source: AGHT+IFVaSaBaiSYMfUIbk09sMC02hZroX1HE7a+9WIekEEhfFhrDc+eu7Swl1YpMravg/m5HgRh5w==
X-Received: by 2002:a2e:bc84:0:b0:2ee:5b97:ebcb with SMTP id 38308e7fff4ca-2ee5e38005fmr53861971fa.22.1719869103018;
        Mon, 01 Jul 2024 14:25:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e072sm14798011fa.21.2024.07.01.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:25:02 -0700 (PDT)
Date: Tue, 2 Jul 2024 00:25:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dang Huynh <danct12@riseup.net>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qrb4210-rb2: Correct PMI632 VBUS
 ampere
Message-ID: <ivuhtt6krunnsimh5yqlxk6sn2doqg7oka2dcxbblwpe54vqxb@dgybzzixtf2i>
References: <20240701-qrd4210rb2-vbus-volt-v2-1-b7bcd2a78c8b@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-qrd4210rb2-vbus-volt-v2-1-b7bcd2a78c8b@riseup.net>

On Mon, Jul 01, 2024 at 05:24:39PM GMT, Dang Huynh wrote:
> According to downstream sources, PMI632 maximum VBUS ampere is

s/ampere/current/

Also in the subject, please.

> 1A.
> 
> Taken from msm-4.19 (631561973a034e46ccacd0e53ef65d13a40d87a4)
> Line 685-687 in drivers/power/supply/qcom/qpnp-smb5.c
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
> In previous patch series, there's a suggestion to correct
> PMI632's VBUS ampere.
> 
> Unfortunately it didn't make it and probably forgotten.
> 
> ----
> Changes in v2:
> - Fixed typo (voltage -> ampere)
> - Link to v1: https://lore.kernel.org/r/20240701-qrd4210rb2-vbus-volt-v1-1-5c06f8358436@riseup.net
> ---
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> index 1c7de7f2db79..1888d99d398b 100644
> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> @@ -305,7 +305,7 @@ pmi632_ss_in: endpoint {
>  
>  &pmi632_vbus {
>  	regulator-min-microamp = <500000>;
> -	regulator-max-microamp = <3000000>;
> +	regulator-max-microamp = <1000000>;
>  	status = "okay";
>  };
>  
> 
> ---
> base-commit: 642a16ca7994a50d7de85715996a8ce171a5bdfb
> change-id: 20240701-qrd4210rb2-vbus-volt-822764c7cfca
> 
> Best regards,
> -- 
> Dang Huynh <danct12@riseup.net>
> 

-- 
With best wishes
Dmitry

