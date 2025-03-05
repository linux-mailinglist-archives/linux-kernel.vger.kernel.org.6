Return-Path: <linux-kernel+bounces-546773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D2A4FE97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBDD188BE19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84C245020;
	Wed,  5 Mar 2025 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJpM4fkH"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967B230BCC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177578; cv=none; b=SnWpUaDxHzeN4BdNxFajZGBfnUjQKxb0BcIC0Zr8zD2bn21FFe5iF55s2pvAie9kf3bcd0sT3U3B1hh631Rz37Yd/4i6nPl1MDnupRDOJKUBld100o1i83xqGTRlSVoqoyYBiEbixDoRdPhTS2n7Z1fYOfjoN/HRYxNKlTDR+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177578; c=relaxed/simple;
	bh=NLJh9QnkP2DtwoSmm+aiCcTaA3T/tGoQoU/ppMYWXus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nw5+NZRUl3lXWeL5d2NVDhcPkcewa2f+1UhqWsqE55CNFPJAR7YHgtH+XzhF9aG0Gi28t6sk4o/56E7De7esbNibmnH8VkE+0jECChDZ4jG5L+RKz2FLy122MC38YO+Ag8fQMO45OvEanwf15CzarxdgkdpqEhi/vQ7SbV/heVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WJpM4fkH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so36845085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741177573; x=1741782373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6Rt50X7SkRvElgQbm7PK5W+Oj4QTSo0gp6TU9EySbo=;
        b=WJpM4fkHwjiP9kfflF0ifTNAJ0N+TGaeKV75Slv4ZhO2Z9bWTVH284MAeWdTY+zpch
         kp2LCT6829SmryB9CTUI6jJqApNflfvjOKf9fol6EiHtIgQH7NHMSKLXJ9YrNC1m5efb
         7fVKhIPfHcWL6VBpRD3efouP2IqPIreCRoe1jEZYzN3Rf0HPxoz846RXFaMw+7jcfUh5
         pwgDti7SOBC1svoUdvgruRDA/J5H3ZfbAXO+13sC2kAW5maRCvqxooL3/lQrx+O/z3k9
         soJqEwm32VGlNzDO+bCiaaC6MzQooW8HOp0VCMzZDCXU8EFaqBNKh7lu3hH74krSoguL
         u0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741177573; x=1741782373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6Rt50X7SkRvElgQbm7PK5W+Oj4QTSo0gp6TU9EySbo=;
        b=llCxdOlkgQIZNWKExHfYx8ewNKSiyChUkKEKH97Ya8HheqKwxFEdnyfhXfEbM9hp3t
         S6gWrE0DdLvUGB38fM4kiIEla9Ixo6la7vtI1Q9XG3qfRdQRdYspWinMMpIhM28nt73T
         X4zN4KNNpQ1qkSQ6Y0LuoZ72Bufd9bMIL3366WkhFW7o0xPGu9Cv7PD8LxQHjE/W0eMZ
         33HIJddzQ1IstaUo00g/eu71V/1W3S6kExDvi3hZZitfsZWy7/6NftA1yLkyWVSBQulc
         5/JCQc+D7S1kOcgL0OBokXEqzgaa0GtFNCoTkT2z2tyUb3tTDNsAQQRIqj1k3C8fJn0+
         jo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2BFLMyZFPyC/dFmvP+j8XlDSgSWmZD8LyFz3PfecIRyVOb+6g3uOA4Qc/RneMSuyZwo1I+4TZb+Of3w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7n3u+BjaLBBF4laNQ2VUfyNXtAE/3RnagVXqv95yWbhQniZJG
	4tkDl+E37gpOII9XwWZa94UDql+9iKBGpu2F0gJtVm931lLasu2MZpQv6gFQpNc=
X-Gm-Gg: ASbGncudKRBGjp+laA+aUjvtv3w7vY8WM8wXTCbSIxdOUPTMDyTm4gZ+3ccIcpEe0n0
	s9woi/AEihZH6qmHJ3O/19YsbDfZs4QVd9nU1j40o20yleJS5jXrdvzTE7cBeDkHGkuE67nxS/K
	5zg6PGN3hGmYluyuM7Y4HBjStQ+CL1bjOcZMP6f4CXeEO6WblhVdx1gpKh+VYWtS27ZrLKavK1m
	qbgytM46L/XlTEkcernXRbq05ezguCH2hrUfThi+GIwa4KKQyXgbJ2aBzeiHlKNl7SK8gvbO52Z
	e3Yasmp3INhSBNfipBxD6BGaEmkXQUxPmXd7XuiSZjbwqfYgl84/YS1UuzCIWc1mu4D5rSmSLFo
	Otgd8iHnSYA==
X-Google-Smtp-Source: AGHT+IFjDxd6p8WpkU8mEAcZkTMlxy1k8FZzR1EKtfrH7oGcu7GdsRm3iDCgI5fb4lflozIDyl7Lfw==
X-Received: by 2002:a05:6000:1845:b0:390:d61c:c777 with SMTP id ffacd0b85a97d-3911f7beb2bmr2613296f8f.46.1741177573347;
        Wed, 05 Mar 2025 04:26:13 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844913sm21209948f8f.66.2025.03.05.04.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 04:26:12 -0800 (PST)
Message-ID: <2e956745-7a3d-497d-8789-4e3d3c8be78b@linaro.org>
Date: Wed, 5 Mar 2025 12:26:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: drop video decoder and
 encoder nodes
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250303-b4-media-v2-1-893651a4b1c7@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250303-b4-media-v2-1-893651a4b1c7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 12:37, Vikash Garodia wrote:
> Decoder and encoder nodes are already deprecated from bindings. Update
> the venus node to align with bindings. The nodes were deprecated with
> commit 459997e8990d9 ("media: dt-bindings: qcom-venus: Deprecate
> video-decoder and video-encoder where applicable") and is part of
> v6.14-rc1 and onwards.
> 
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
> Changes in v2:
> - Add history in commit message about the deprecated nodes.
> - Link to v1: https://lore.kernel.org/r/20250303-b4-media-v1-1-ddc5c81cc2b3@quicinc.com
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0f2caf36910b65c398c9e03800a8ce0a8a1f8fc7..31abb2b9555f37ecc9c7753509e95acd57acf015 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -4301,14 +4301,6 @@ venus: video-codec@aa00000 {
>   
>   			status = "disabled";
>   
> -			video-decoder {
> -				compatible = "venus-decoder";
> -			};
> -
> -			video-encoder {
> -				compatible = "venus-encoder";
> -			};
> -
>   			venus_opp_table: opp-table {
>   				compatible = "operating-points-v2";
>   
> 
> ---
> base-commit: d98e9213a768a3cc3a99f5e1abe09ad3baff2104
> change-id: 20250303-b4-media-79ff0738b9cf
> 
> Best regards,
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

