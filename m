Return-Path: <linux-kernel+bounces-536647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1490A48284
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CCA188A059
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B723816C;
	Thu, 27 Feb 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aMSXQCEc"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AA266190
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668598; cv=none; b=Br1CmIa1Ok3us6Zt4xlfBK96PAJHOTStx/ppuVp6dd24agrCv1nGbc4QDR+VS6YUsjRjnKM4LPQIQdaFv1bYj4nsRseEoYq+rxVSeol9QOQPscMyybw5YoeEAIKZ7xtBVovSTmzD9LWxxUB7wMdFwOYD3shU93atQmLMZlwP5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668598; c=relaxed/simple;
	bh=Tl40Fm+loygXp9JTJZ0Z7May9tG5QQ1he6NwlUmTUjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbwamZjxrhv4RmvDvnC4BnIku9+LDlTRrYYLrwt/W+XeJGBAyX3i50r/DDCyhwO2sUXpx8AaQgqs6JL+EhbCqeoJgXR4cWbPMS4ypPMOB8/dER1VfNNvMxHUKxsL7TOdubhWMSknDii5llU1fq6CaAzSVwVs9iDjYaOG6LLppv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aMSXQCEc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30761be8fa8so12494081fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668595; x=1741273395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jct5/sWNcnHp4YAXGTjpriX8VME8tdrztTmpTBFh3WQ=;
        b=aMSXQCEcg8RqG+qJqVpEHWj9PPcUP9pfHJoA95HV4UjkVPTIxTlO9xGCMCDfaGEDLs
         xL9NW4Hq/fGFgr4+sBdXSI7G9YcS4jViE6+/ufbI73tEC/jME4UsEzngv8WqVKOKpD73
         IEKXy2jBQa9JNpoSdEe08jKb2NJyhQy1jjqaEHwS4WjTxDoMh4qP2lPSeAnS5raSjrTc
         F3eastvt5F5PRTi7rzlBzAYEnb0BQYll7AE8s0eHCgSQOR0hVBWW8yEEBo2LlAM1Qdgn
         odFjAf1lOCJixT3O40yz+ktjBwyPSs5QMQOCxFPKeacDK17EdFNw9UeQLKdSy/wIlI4T
         I5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668595; x=1741273395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jct5/sWNcnHp4YAXGTjpriX8VME8tdrztTmpTBFh3WQ=;
        b=t2ciTc5x5CVtarjQw18huPpq2zJyIHMpSdp9d64xv2lEsSY+K1qyqIRY6gQ3rtcWad
         PcWdVlcMN+8cmdN8st8EQCzifmhRBAoFopTbXOlWMcSY2nGp0KkfVfoREpFWTj3zmU7y
         qKv9/7sSl8SdKGS4KbRT0CVHj+H5gISbsZZUelTHdlrN/XOXjXfz1/HMvYAdqrVoQ+gt
         ZLUiZPCcegEJyp547uwnw1pHfQ7oE38QXOrveFKzE8T6IM7i5ElUm/iypgUuyU7B/Xze
         iUqtcBIWcdwCn8HkbXSvMeCNNS1928TqvSw2+gLG6Nn9G7GH5pugK3fWBmFJwCIW1pqx
         BQoA==
X-Forwarded-Encrypted: i=1; AJvYcCVWWD0oVyQaGtKp37539bdIoqL6k+JykV7EoJRksm2An/bTb4yLjIqAPKyffXrERNumNbwE9GcU554dyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcucTwBAy/4HLFsSIfGX0+XDjwFXECjIsPihMh5SXwFlVO9Ky7
	6+N2v4zRRKfakjZH9WoS5KgvXdirgfE25sOJJHomIrRllpA/XXj6ZYY5p+8rZQcv24GK2/Qhe0u
	9Ars=
X-Gm-Gg: ASbGnct98AS6mdYyXSpEEPwDVFnrugcIAr2N9Z9CCse4zU9ZbvJT8zOJbxHQuDPW5l8
	ges5gM4OoSyf/xRE5qO4DGnNMyjD3xdf7PAPC2baq62a7gC1hGURbGVNzZ3H1QySpdudkYz96Zs
	Dps2sgOpWgwTG+nRC1R9c+wjPD5jYUhRwlUG/KMKjSHbWs5/AryrUrvVcTaumHuTNfhdlsreKaQ
	634yPZ+7WxvC84ILlTn/D8lb7pU1EKnzNAYrngHcPyhsqx+0HpbxMhQNUchX28U4BIVqVWXi0kf
	WByoe33/7zAIlXw2poQnugJNsOWKgXceSB7kSynOhdJoeV0TPOoLxqWESNCuT0FGCzSEraIK0of
	mcQ3nCQ==
X-Google-Smtp-Source: AGHT+IGu6e9SzMnhpr5EnGH9g23xD2bFOtEakcdfl/ZUCRRGs5xA3LtI3CvuzfMuKxAB74Z8ujrfbg==
X-Received: by 2002:a05:6512:3d16:b0:545:62c:4b29 with SMTP id 2adb3069b0e04-548510d2891mr6258092e87.22.1740668594423;
        Thu, 27 Feb 2025 07:03:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443b11f0sm180701e87.114.2025.02.27.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:03:13 -0800 (PST)
Date: Thu, 27 Feb 2025 17:03:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: Enable MMC
Message-ID: <ryfawl6uykry5ds5kovujvepkwffdwitbqltx75wnnrqrbl4b2@i2pjwegs3u4n>
References: <20250227094226.2380930-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227094226.2380930-1-quic_varada@quicinc.com>

On Thu, Feb 27, 2025 at 03:12:26PM +0530, Varadarajan Narayanan wrote:
> Enable MMC and relevant pinctrl entries.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index b6e4bb3328b3..252687be9dc3 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -69,6 +69,14 @@ &qusb_phy_1 {
>  	status = "okay";
>  };
>  
> +&sdhc {
> +	pinctrl-0 = <&sdc_default_state>;

Where is it defined?

> +	pinctrl-names = "default";
> +	supports-cqe;

This property should be a part of the SoC dtsi.

> +
> +	status = "okay";
> +};
> +
>  &sleep_clk {
>  	clock-frequency = <32000>;
>  };
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

