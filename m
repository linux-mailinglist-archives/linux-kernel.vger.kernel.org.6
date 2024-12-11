Return-Path: <linux-kernel+bounces-441399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01B9ECDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24A60285A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1022368F2;
	Wed, 11 Dec 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzK9TjPJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2245038DE9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925463; cv=none; b=pYnfM2JTSYc8nDYt5eXUmi/xxu0O9Be99jh7iWzoVmMMnMD67h+pv9eGibgdMyBpcpGb5FgIXdeM48NFR6g4wK5Xui2vekudH0Oxa4Dm+wR0k0vsfUNwQ2w+HyOFRoQ866dExTH7RMVXZtjndMmzFwu9qiytLTF8+Boy+q2/wAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925463; c=relaxed/simple;
	bh=VDR/LFkNhR6c+K0FS5fF1XjxZAJmm0jHxt2NQS8CF3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5Ux9TvPFBO4hzX2inCA72GkjHi00G0ovRlJNoQq8H0HylZbLpU4YINp0G2s22Hduv535E6B0hwP5Hb2bTcwtocc4pbM2+pOZ4t+n4Or05tOj0SGd8KYEolrF5V5F+7ziFvDj+8iSWa6fUAsu9v89XSxemj5jU+QJoCQE8OfiSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EzK9TjPJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434e69857d9so4404625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733925460; x=1734530260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwRyufZV4Hv4BKUozZCvb8TTCpopa4m9EKT2fS3FdAQ=;
        b=EzK9TjPJf4p9YNiCcinbbsZc9eOyC31xRpwKlqNj6vPaudvGrB756CRAxwtJre4hB2
         GmKB8lKxbgkNZYAkBT7trWg4tuwauU7P12QG+o/BPwafGWiA5a0TTtwHTATwH7AyP0/n
         A6tOw0JigkJRIo5ltbjLDbQHr8Sw/puUciiJwNN9CRXOyh4TJuVkiKbYA7z5JrKmO8tb
         mKqG66OcsxeYYjpkUCEB1ysEcvpaz6py6sARKm6iIgrzQRnyv2rH5qN5ZdsnNdlxM9l3
         IblOH7HMPKjcNBRPb4DipTd36ipSXWPMIUkvooiZaUy38jWQw7SxnHsn4n2ZK8fldIgl
         b7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925460; x=1734530260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwRyufZV4Hv4BKUozZCvb8TTCpopa4m9EKT2fS3FdAQ=;
        b=NkGF+gqOgXs+IfkTSLmc+KN0xkOhqZHac/NW8CoHlORQjpUNyRcK8rPsL4n3oBjp+Y
         YWWDIdiGwSo6esoanAKKJUh4OwLGS/j3vEZVOZEj83XrA4hvhexSwS/AjzpvmhH8yHHB
         YUfAtv0YsAdwzAAlwhXO80LGGmzJYbD5QcDhuF8z9eeUcySts5Rcpbqw93a61QG9mNCq
         eJVKe3xO4GH5/wZciSpuKgu+fEIqlz16QYHiI2jd6BavX+gJ1UipifLntJC5XN7qHQF8
         gxBuq+9RgAUQbnIMfp2ujJWN5km1paCKPP1q1+5HL/7K+mnALZoOPF9P8hsrPgwiCLn4
         Yfyg==
X-Forwarded-Encrypted: i=1; AJvYcCVx/hoblx6364PhfEqUp6E+PS7pNLBfgnmuZ+ALwiiDBF53H+UgSgvzU+GMeyvUk3ytSWVQQwZCuL9VwWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynMFZkLiv5Y1rOk636znFvRZ0TuGj9vu/XU7Rb07CBsrc1csmG
	r9RAF1qWMHLkLzZdIl93v4VHcT6Hxy8o/qj1vFFzD4KVS386lpe3VHj0WNlcgbo=
X-Gm-Gg: ASbGncsG5d3woSios5IlKU/TNNJSb98Kj7J8p3T42w/hx+VRSLJX0YVBUJmvxo3dylE
	rroYYuhEe6/VxA5K7inpsXdgL0VKGFlT/xnlXb6eriVT4fYB4W27jBva5LxY5GCODY2WlT5fDTf
	SREWGxKvrdgfe7sVhxKm/AJ/MTZ2qtkukYAF9+hYOcgCgaD0TUJm2RDo1VlSF1U8VMZsY5C2paz
	qgzY7IGzrQx8zb3tu18foIgHNVPqOHc37qRyA0LkguD2TmCT/92
X-Google-Smtp-Source: AGHT+IHHGvcjsAaWoQmNtBBOZEdx4io9usowsti1WQThV36SDH9Hnc+lVGaPEvltgGcV3XhTkCAoMw==
X-Received: by 2002:a05:600c:1616:b0:436:185f:dfae with SMTP id 5b1f17b1804b1-4361c5a3918mr21096715e9.6.1733925460593;
        Wed, 11 Dec 2024 05:57:40 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4a31sm1355432f8f.30.2024.12.11.05.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:57:40 -0800 (PST)
Date: Wed, 11 Dec 2024 15:57:38 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jonathan Marek <jonathan@marek.ca>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v3 2/3] Revert "arm64: dts: qcom: x1e80100-crd: enable
 otg on usb ports"
Message-ID: <Z1maUvW26Cl/VXLr@linaro.org>
References: <20241210111444.26240-1-johan+linaro@kernel.org>
 <20241210111444.26240-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210111444.26240-3-johan+linaro@kernel.org>

On 24-12-10 12:14:43, Johan Hovold wrote:
> This reverts commit 2dd3250191bcfe93b0c9da46624af830310400a7.
> 
> A recent change enabling OTG mode on the x1e81000 CRD breaks suspend.
> Specifically, the device hard resets during resume if suspended with all
> controllers in device mode (i.e. no USB device connected).
> 
> The corresponding change on the T14s also led to SuperSpeed hotplugs not
> being detected.
> 
> With retimer (and orientation detection) support not even merged yet,
> let's revert at least until we have stable host mode in mainline.
> 
> Fixes: 2dd3250191bc ("arm64: dts: qcom: x1e80100-crd: enable otg on usb ports")
> Reported-by: Abel Vesa <abel.vesa@linaro.org>
> Cc: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 199f6b42aa11..66360390ae7d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -1840,6 +1840,10 @@ &usb_1_ss0 {
>  	status = "okay";
>  };
>  
> +&usb_1_ss0_dwc3 {
> +	dr_mode = "host";
> +};
> +
>  &usb_1_ss0_dwc3_hs {
>  	remote-endpoint = <&pmic_glink_ss0_hs_in>;
>  };
> @@ -1868,6 +1872,10 @@ &usb_1_ss1 {
>  	status = "okay";
>  };
>  
> +&usb_1_ss1_dwc3 {
> +	dr_mode = "host";
> +};
> +
>  &usb_1_ss1_dwc3_hs {
>  	remote-endpoint = <&pmic_glink_ss1_hs_in>;
>  };
> @@ -1896,6 +1904,10 @@ &usb_1_ss2 {
>  	status = "okay";
>  };
>  
> +&usb_1_ss2_dwc3 {
> +	dr_mode = "host";
> +};
> +
>  &usb_1_ss2_dwc3_hs {
>  	remote-endpoint = <&pmic_glink_ss2_hs_in>;
>  };
> -- 
> 2.45.2
> 

