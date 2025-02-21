Return-Path: <linux-kernel+bounces-525771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B72A3F4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E00C7014CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F735205AD0;
	Fri, 21 Feb 2025 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EttI1ex3"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72ED1E493
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740142060; cv=none; b=ATWt14vPg1R0hrQxdP+M6Rj5OK0MvSMu2NUY3BGvdozRMuGb3f9eR+8IDd7AiFLwwxfV4U2N6I52KTbu0Krijo5wuARVca0VBWYOj9OWbXsCpTLuBZIPDWDky/XvGTAk8eeqytrGI1Oo29++iWIR67+U5GqWOdk04e4UU8GR/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740142060; c=relaxed/simple;
	bh=YaGDtt7cEBjQEPuK2P+NBfMCulX2bFrlHYN1kHN/snM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCr9ihTAx6Qu8bJiR12ASeG7EMKC1U8G7iWHCoAR3boP4ZhEszmQ741FWhVxpsRxEAjRd/XyRS3StKtDsE9ZTpyGD1P49No+YuLUKeDBaMGVso0N/O9YMIbC1xbnRE/0AZhUzdLfczZCMg43oGLqVUnOiL0O0lMwLD005FXVNwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EttI1ex3; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb8d63b447so267845566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740142057; x=1740746857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8sq8P1/rLnQs2ac3SqMeH/6Kwi56/5UD1RraEg8IJY=;
        b=EttI1ex3QwFZcq64tpbZuN4nEh5eduKWKwiUbaYkBjNi/5shgSnPiNMf7R05v1od7+
         maX+k8m/JiKzqBHQpzJq9XJ5peLt393vmm0OfYma2ESdNnkWM4HQiDsf8QHa3o43LKXU
         gclxdtxgb50MFq5zWLN/W24nsNXxpkoc91oALTofbbrOq2Roq4rEaNg0WPpv7kaSlWgv
         vifs7QGxrO+gQ228H7MHcckgKRYg9jrnhzl9mQZgWuUTlS43po1FxOoziqlLYRI1TtV2
         i/ev5sBqYQi1fXVBW19EaR2AJxibVCXidn9vbfC6X8wpjNr89Y53BizrIj7kjEKHM0zL
         4RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740142057; x=1740746857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8sq8P1/rLnQs2ac3SqMeH/6Kwi56/5UD1RraEg8IJY=;
        b=B4O6KCeyU90Q3kVpul9E8uHTyULUvQ56s+6M02AlOo2jre5/WNP/YkbDWeTofCGjlY
         MTEnNGjtSnDVqfY6swfAwclwYeBn/REcObL3VsWTvDE+i225prAaMcE4KVzviaBioMb3
         BlRog6ANKYSRqQCcFWErUuLwYHuFAbD1CfYspYoW/VF8sZjVUFcgPrefWrJAKbfzDeKr
         acQNh9LWDTMqo1stVzvZajA3enrCr8u+CVqacFXfu3XiRUbJtN4C3wq4fcNEuIUPTVtU
         EuXGoLzQFWft8420Vch+PSe/proyQ4PExRCLI6im1dU9Z5iiEPSh/SCxLgT6uUgkmgL8
         PCvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVa7UlZJRFjKe5bJLNdtl0cYKb4YBMmalwoclUhl8dcSmneepKDgXQbK1aNu6uGjC0ZmZFke4fIzNrQ7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqIp5sD2zYeQCXV6OqVrEKne1ysrsjT0ZkLTOEA2SuopeTBBkr
	4fBfbHJkb24rIXy0FQw0lhSigVfNubZzgxA7XqSWlwLyiYP4qGMIitwh15gP98Q=
X-Gm-Gg: ASbGncsvW1XjtCoMNU/m4cx3VQ4R/B/PFzIh+HDocGk6Fp2mbxFa12Ay3hdpfKq0L4W
	BRCP7ZG5eS+pA5db89fPwFqsEsYMHolR3BYqyKSl0xe6LBHmXezG5vfvpUlo6rTnItCuinp7Cy5
	eMX1QxpQmGZg++xlWU+/f0F//hkFwTXPcJS7rZlgZSed5wdv7ai3zXcht/l8ZaJjhTuB4OS5y0k
	zjg1JdGYjGdIFVqhatghXUGaPzKrB28fmC8c8u/150fQr4jQzAOZ1k/JvTfCtioFDtJX/6mjfMO
	lwfvc7SzxaMcbSmliY1n3b4=
X-Google-Smtp-Source: AGHT+IH3aBzzFWyzyN1k83NMWlVN/InEeUhlRu8jOe9fZXx46+LcdtbGo1F3wi+BlPMYt7I1iE4rwg==
X-Received: by 2002:a17:906:31d7:b0:abb:cbba:c346 with SMTP id a640c23a62f3a-abc099b8029mr280917466b.2.1740142056993;
        Fri, 21 Feb 2025 04:47:36 -0800 (PST)
Received: from linaro.org ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb916db37bsm1046317766b.165.2025.02.21.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 04:47:36 -0800 (PST)
Date: Fri, 21 Feb 2025 14:47:35 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add crypto engine
Message-ID: <Z7h152O5EV74WSEZ@linaro.org>
References: <20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org>
 <Z63xEdcvCRHchHWu@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z63xEdcvCRHchHWu@linaro.org>

On 25-02-13 14:18:09, Stephan Gerhold wrote:
> On Thu, Feb 13, 2025 at 02:44:02PM +0200, Abel Vesa wrote:
> > On X Elite, there is a crypto engine IP block similar to ones found on
> > SM8x50 platforms.
> > 
> > Describe the crypto engine and its BAM.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
> > ---
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > index 9d38436763432892ceef95daf0335d4cf446357c..5a2c5dd1dc2950b918af23c0939a112cbe47398b 100644
> > --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> > @@ -3708,6 +3708,36 @@ pcie4_phy: phy@1c0e000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		cryptobam: dma-controller@1dc4000 {
> > +			compatible = "qcom,bam-v1.7.0";
> 
> Hm, I would expect this is at least "qcom,bam-v1.7.4", "qcom,bam-v1.7.0"
> given that this is a pretty recent SoC. I don't think this makes any
> functional difference though, and we don't seem to have it on other
> recent SoCs...

Yep, will add both compatibles as suggested.

> 
> > +			reg = <0 0x01dc4000 0 0x28000>;
> > +
> > +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			#dma-cells = <1>;
> > +
> > +			iommus = <&apps_smmu 0x480 0>,
> > +				 <&apps_smmu 0x481 0>;
> 
> Should be same as <&apps_smmu 0x480 0x1> (0x1 is applied as mask to the
> SID, and 0x481 & ~0x1 = 0x480).

Nope, the mask is on bit 16 through 31. That will result in different
sid.

> 
> > +
> > +			qcom,ee = <0>;
> > +			qcom,controlled-remotely;
> 
> Please add "num-channels" and "qcom,num-ees". Otherwise you risk causing
> crashes if the interconnect listed below isn't up (anymore) when the
> driver probes the device. See:
> https://lore.kernel.org/linux-arm-msm/20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org/T/

Sure. Will do. This platform has 7 EEs and 30 channels according to
documentation.

> 
> > +		};
> > +
> > +		crypto: crypto@1dfa000 {
> > +			compatible = "qcom,x1e80100-qce", "qcom,sm8150-qce", "qcom,qce";
> > +			reg = <0 0x01dfa000 0 0x6000>;
> > +
> > +			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
> > +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
> > +			interconnect-names = "memory";
> > +
> > +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> > +			dma-names = "rx", "tx";
> > +
> > +			iommus = <&apps_smmu 0x480 0>,
> > +				 <&apps_smmu 0x481 0>;
> 
> <&apps_smmu 0x480 0x1>;

See above.

> 
> Thanks,
> Stephan


Thanks for reviewing.

Abel

