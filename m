Return-Path: <linux-kernel+bounces-537078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A7CA487D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBD63A45E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CF7238157;
	Thu, 27 Feb 2025 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQYwdyQv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD6207644
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681005; cv=none; b=BJSUtLeb5YioxTP2ag+CwEo7jjYCi82NY/Z11bQ/m4wy4oHyTk1OgAqIG1Y1YzdSVEfonOOmnAkGl9OlAU1FrRtaW0p1GrokxOPbngcxlNJDlbwboKc9cHn5HXWgkM1qQ1FQeJOZSa+HTjMhJVWnGA/XFC5mQLtwLVbfaFkGJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681005; c=relaxed/simple;
	bh=qWTescY9VTpDYccdLyalIWu+a+eTm21wFuIg/J+tQlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7MTn6q16umsEJy5pa2tsRmpjjIcxAtyJd+Py9G4Yz8I3abV7Kva6CDJXTcoe3gHs1TD/1vVNrOIrW2TIOorTUhatnINNW1FdkQP0Vw/SBRvyfWhoSLDyHQacwiMtcNSdh0Jpa1LYp1IOFJSaGLVxk1Mmi0aOQTvdSCYF55jOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQYwdyQv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-547bcef2f96so1294962e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740681002; x=1741285802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiVWALSTD//m/UIip3RqCj0OCMJzxffojcYsREWRIbE=;
        b=ZQYwdyQvslX7PKKqIh//93rkKkNK0HjO7nNhFkgbBuYvPKrUXSCL4/lxKfyvb5dRuo
         qn+wkRa75PHU1t1XdeFhT6fiqy5Ul2+JiiB0TxGAGqfeNX1oHEi1FJtGK+C2isH0bOvn
         l9bJCs5H96EEDiWF06OhdANVUtSSKI7mZrgojtT78nrfKOD9q5sJxNoKbc797+iAnwIR
         lXR0b3YlB0INf2GpTmcRsLloi9S6GjI/U4gDwU4HvK5W5O9KhNIP6/nJChheuoK72Xq0
         Qyfvn/cmIAPieQLXNRprRJc6evPiQ27lEz0uKdy2ccIChMlzk8m9Tjb2UdUipxA9E+Be
         nFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740681002; x=1741285802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiVWALSTD//m/UIip3RqCj0OCMJzxffojcYsREWRIbE=;
        b=mP/YdbfE8pXkqu892Hx0P0J4jXoqTwYEFg0MV/7daiQjeWsm0g8QFgivHyZjh42c3N
         LFyrj6+cxlU3yt1y9ux+4ucxYNB7qW0rIpY7Oyg/8Tw9nX+NgufyqnS+knrFClZLOCEa
         iTMgIw5QuQrZKC6OCtdl6GQPcwuk1VSzZYcHbDJE6zDYuE3nPIN6fJOfzvdFDH6ZRRlj
         0xth7OxackJMVYnc/eDNdQIE8NYQOPxkz9PPDFJwaKiBGJSYokmwihlA5MCY6/xtpb6n
         8xc/nPb5QiFzTgb+hcrorhqd+CLQj/0JMRt79suyRWTIUTRbE0plF6WL6JUlzDkalu76
         /STw==
X-Forwarded-Encrypted: i=1; AJvYcCUQhyRZsVbO6kcdg5sJ7IRjObhJjWV0PS0MIpnPC1NERVdH087SZkXigm39NJA9NWnmwW7pXIc0tlONNrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2QbCW5N6zPUeqU9wmetsNWDJOzL7/O/dnpFjasPwDuVu+0FRN
	QMCmIvqbic+Z8TQUtzXzg3DRcdB5nevOSrk4hlZ7DOAnaqQX7ZBUtxEy9fMkJ94=
X-Gm-Gg: ASbGnct99eDk5dFcTqxJ1MBxsKFlTZ2yIQovQhSs1cd33PnfzAAwWTpHWlIRigsCOd4
	FvI4Eyi7Z3WQjEpNWtQa2D9srS6oeCur9jIT22Zpm/ojstYgx6i5F31pTs3G5LJ09x0pli545fe
	LFeMRAIFbW6+AJ3LlYqSSy6CpL2Lwdp7ZssyMRcb7eqG/yutFKtubGbt+44MmoYTCc2CMoeG3eu
	A+FUtLuCRbHmbQRG+q+nc6p4NfcpSs9oNIsJmySgysjE7rXmnLQpb93Yk6HKCMIS5dcN/C4TMXf
	gnGJRdqdiWWPpvnKxSFVAb7AVDec7f6GuHjw+iXkpaPBE1l6U8oqf+1j1CqaB1ZsauFF7pllKS7
	Pj3KaQA==
X-Google-Smtp-Source: AGHT+IHBikfdMSK2JkSKuT0fc4cM+qKPdJZs+aMwAQcHRUzz0Xs5ze16P/SepqSYoZv2Lgzl1OHSNg==
X-Received: by 2002:a05:6512:1103:b0:545:225d:6463 with SMTP id 2adb3069b0e04-5494c36bcc8mr200018e87.42.1740681001614;
        Thu, 27 Feb 2025 10:30:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417b66fsm224376e87.93.2025.02.27.10.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:30:01 -0800 (PST)
Date: Thu, 27 Feb 2025 20:29:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8750: Add USB support to SM8750
 platforms
Message-ID: <g47ac6bzxqyqbkuqsvuwm5vdc7x5wjfppv6fj4mftwyjlyuz7t@jzmw2kfa2jnp>
References: <20250113-sm8750_usb_master-v1-0-09afe1dc2524@quicinc.com>
 <20250113-sm8750_usb_master-v1-7-09afe1dc2524@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-sm8750_usb_master-v1-7-09afe1dc2524@quicinc.com>

On Mon, Jan 13, 2025 at 01:52:13PM -0800, Melody Olvera wrote:
> From: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Enable USB support on SM8750 MTP and QRD variants. SM8750 has a QMP combo
> PHY for the SSUSB path, and a M31 eUSB2 PHY for the HSUSB path.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts |  24 ++++++
>  arch/arm64/boot/dts/qcom/sm8750-qrd.dts |  24 ++++++
>  arch/arm64/boot/dts/qcom/sm8750.dtsi    | 134 ++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+)
> 

> +
> +		usb_dp_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8750-qmp-usb3-dp-phy";
> +			reg = <0x0 0x088e8000 0x0 0x3000>;

If I understand anything correctly, this should be 0x4000, not 0x3000.
You have missed the DP part of it.

> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "com_aux",
> +				      "usb3_pipe";
> +
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
> +			reset-names = "phy",
> +				      "common";
> +
> +			power-domains = <&gcc GCC_USB3_PHY_GDSC>;
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
> +
> +			status = "disabled";
> +		};
> +

-- 
With best wishes
Dmitry

