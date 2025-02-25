Return-Path: <linux-kernel+bounces-530935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A96A43A58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DFC1722C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77E262D05;
	Tue, 25 Feb 2025 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8AvmQiz"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF194263895
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477014; cv=none; b=c5XbI57a7j6ftiekZ4ZX24Gzxj2oSLGL2MTzNfFsNwJpOVzJ89xpXlekm/uhXCXEc3sKBN8RtoaCO/hF/+Fznr3poPTR3cztarTdh/T3Qfy4HhMrve6duBcBUds97LC/592zKowNBitrRsOgDqGMJc6izz/4GNkkvmUs+Sw0k2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477014; c=relaxed/simple;
	bh=YdYi+jldxRySwOYGSHC4IgPILTJajrReelAUFvdPiF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxg5SoTmcCRE3rYCe4StI3igZS1060I7n4l4oLz4iggtZFtkKrgu7NzSStgjSQVbtolfXwih3HFcXot5MPEARRtlA2b2qxirLKey930IFgtc9l13WFc2uH/GZMtVpxqr0cjd+hh3yIR2BXc9XQwsI+7DLSgFRt+J6iReTlGZ6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r8AvmQiz; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-307325f2436so52551391fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477009; x=1741081809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=otofrhCMJrvXe4MXmMzw0/uFlwKxINjHvm8fHlxwC3Y=;
        b=r8AvmQizahU6zwlj049X3atHHXm/PY1CdXkHt6keJhhoOjdi3Ow/9LtBtN4POxgVv/
         beaPwBezrnfGbdv8iq9SGvdwitY3Q9cDCYv4uFqd3Ptsv6/k7xUyyCaJHQgG5rqq2CTo
         IkOgugnhFuBvfSeUbFM5mA/f5Tnl9HL/fh7+VhedvKKYgZWlIl6qCaPwaF5gNX+zyuzL
         guhL0Udl3O1WGim97hky/HGm3o2eGPAnEIHOhcPe0Yjh1KCQHXcguSI1uceXv+v7PFy3
         O4HVJQYBUUn12PUIPmyCJpS+o53DpObjGjuc2rmduZx7DpgAtLw6rjxgTLDAgyPsstJX
         LGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477009; x=1741081809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otofrhCMJrvXe4MXmMzw0/uFlwKxINjHvm8fHlxwC3Y=;
        b=Gm3ocMi0IsAq2xqKj6cRK/juL/iKWf4NVS2vsdY0MLgprPJnfvWo3TKsmwEeJo/u95
         uhvMXzNlJuATDUiJsnkQzs/hg73WFWOAX66SvVoWj5XHAL72iEm8cgdX+ssu95J1vqy1
         ql11SY857BCNxC44x6aIj5WD8YDvtgV+JBpxulK0Lb7vgLN0SLSr/HbOn2LFfvB9Isb0
         aKbYP3s7nJ/3X1RRCSXTeDSKIYPacvbNvciiUuOgteLIWNOJ8oZJtd5Twp0C0pn6WT01
         KqcFGZv4s1D9HH3hxqcvfdOwYfSUk/3TyCz9Zvi4oItugkytzMZkMonfunUj2m2aoLdo
         mEjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNCrtOreQfcOqopSK+ko2Gz9vZGEP+cHxPQaT5yz66whXrx5+3ENe8Ble0F+DD6XFMn/PijBWXxv46LzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnj/sbvAXaIOkuM21QsID2VN8nBkQeZuhmENx4F1m2XxfEMq7Q
	OVLn+Lk7/Ps5eSEG5zH97Pi4rQRRqR2umJo8z2ViUKa9EDgnJprQKzrStScw/5VisVpDyvwckp2
	s
X-Gm-Gg: ASbGncsyO4dPSA5fOk1z+yVodbrbw7cA1EFnlrFodXrVwOLjwbwA+hWvCjIsv5HSdIP
	yUizMVmuEyD/FmYuLj3/arfnT63oLrZ++pIAXPaW+FIhGxrMyOzk29/IYXETYP/yixh4Fbzw3QC
	kTQafLiLGTyadnVtMD2PhssZsO0eoap1nitm5k6xUmRWmH2aOrJlh2C/7dWd2Nj09HARXqIJQ0Q
	VPApqWY8rJVqkRXvrFKpzzTBqneXy9+1aQTjF4ufIowdM8WFESOldkSEq95IonvRW+xFSHB9MNb
	1+oIJNzILQR6WL39E6wzVG6pPeo2C33yOelTEdaiOwtYAxx6Gkz7BI/54L5RlXrzGJl8KYZMhHa
	5c6fITQ==
X-Google-Smtp-Source: AGHT+IEtY9MXnrKuueCiRzVzb7OItS2ebjSxuUsGBPUIBg/R3EahURMlwlNSOkla7VNzEjmEglWcsg==
X-Received: by 2002:a05:651c:21c:b0:308:f3b4:ea66 with SMTP id 38308e7fff4ca-30a59987bc2mr54809491fa.28.1740477008948;
        Tue, 25 Feb 2025 01:50:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ae819esm1788281fa.103.2025.02.25.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:50:07 -0800 (PST)
Date: Tue, 25 Feb 2025 11:50:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Jeff Johnson <jjohnson@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-slim7x: Drop incorrect
 qcom,ath12k-calibration-variant
Message-ID: <sfhcmlz3x254fdowufeeuh4uiwxfgkphm4ch4laceivbrs3zir@qvqk6jxi6zhf>
References: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>

On Tue, Feb 25, 2025 at 10:30:51AM +0100, Krzysztof Kozlowski wrote:
> There is no such property as qcom,ath12k-calibration-variant: neither in
> the bindings nor in the driver.  See dtbs_check:
> 
>   x1e80100-lenovo-yoga-slim7x.dtb: wifi@0: 'qcom,ath12k-calibration-variant' does not match any of the regexes: 'pinctrl-[0-9]+'
> 

Adding Jeff and ath12k@ to the cc list. Is the driver able to find the
calibration variant in case it is not running on the ACPI system? I see
that it uses dmi_walk. Does it work in the non-ACPI case?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index a3d53f2ba2c3..9aff5a1f044d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> @@ -674,8 +674,6 @@ &pcie4_port0 {
>  	wifi@0 {
>  		compatible = "pci17cb,1107";
>  		reg = <0x10000 0x0 0x0 0x0 0x0>;
> -
> -		qcom,ath12k-calibration-variant = "LES790";
>  	};
>  };
>  
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

