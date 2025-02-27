Return-Path: <linux-kernel+bounces-536636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726FCA4821E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643113A63ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A625E46D;
	Thu, 27 Feb 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJKktULN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FE925E452
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668092; cv=none; b=lBG8NjKVFfGvrwb/zzihtuPPpMXbbFFZWUxDysYqH3omCYgytSdvTxKDPAjNHhYR8rcNkV7AEUOBkIIo6vdwU3hilOPvesZ+1Wk8m/XsXmHwROfhEmTpILzM5KS6qjTpayeB0DPvCAGnyoe9GkHS6keojBfpa2E2CQnSk2YAdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668092; c=relaxed/simple;
	bh=KboGCxx7OgmWNnz4unI5atpIG8j1s+NhJgz2Wlu5UaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXN2Pfpi2nwauQx5jhnX3IKJ2tSy2PyB0fwQYMksVsx3q3qnHe6Iun/0VbOzKvP5D4cJe8uC6JwxOreRCDdeAqZ9FcJE4daaEf673Os3KPzWPDoa666YA+sGOA7HUucDHJV2E2zSgZD/k3GxevNhcmBMdvSr5QyzEnPMv3ROQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJKktULN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5439a6179a7so1226107e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740668088; x=1741272888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCMeltnZVSG7sz0LhzAVQweBa8yRnjaqRK41n2Tk0AM=;
        b=rJKktULNRwmz5XhYh7Ao7P2IEkXIaqACQ8BjfV+6U2+0ipde90bPpyfp2DHYol3aEw
         W/TcIzf9uZm4a9eW2uNIjX5BkP6/jvWigBzk/UIbEp5VKhoPH6tvgTdR7qXtPoDwbmaJ
         L86Uml4QaHSqiT7mAp5nXR2PkzLt1lvEOseWmTQ0UyfATE3LZPgGmTZPLq8c84JesUZL
         geqA4k3TdvE7EL7w2hZD78722+idldzwyqQRlPF9RsccMc+oFFFTFkE74S0MMHJ0HR0U
         N4dcM1I1aPha080jaZAOsZtziHr7uGY4sDk521TnuVR01IkKTl27dxbrg217v9+XEt5T
         SDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740668088; x=1741272888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCMeltnZVSG7sz0LhzAVQweBa8yRnjaqRK41n2Tk0AM=;
        b=bFrOOaFguzwLQC5fxEbMW0T6AmQJri/c0tgrTKhFrmZyFjM1HJnWv+Q+PxvqXycau1
         G0PyLHOb5IPDgR1bPJMPIdzK1YqQfuTx3AnTdalmii0kF9ORlXF94nQGyCVN5zQB0urr
         58UD8xSrooek7wI1eckD7gZkCA/9sQ1y+RcgDFwGvHiZnVtxCoA9pYLzVBqs15zSQfEV
         KY5LlV7Tz/ohmvBBtmNzNIVz/eeN3DqSZdlF4Zn7B0370JviUeQvQ0jTjGdBNWA++br+
         v6yXCwIKqHW+ZFgc6JPBWthvSsdLZaRaDBwkT5Jy+uR6TFX8Ng1rtIea/zIhBfwrvYII
         QCcA==
X-Forwarded-Encrypted: i=1; AJvYcCXc+NrNUUXBNzSlOK/fglrtzE5RBUUkfDJG5Yf59hsoVr7/+DrhkN6lrexhWxb4rfoATkasXo9tY8xD/ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRr7/gvRW0SBCeY77E9JH7hSyDdwqMha/nB5cac54QqH1oq21
	wsiA1KRzuMCnRiwhiQYoyPL/iYIuRTbFnAqupT5Hl/25S29v6NdyCiePJbxmLEHSsvgDdy0EOqT
	XA34=
X-Gm-Gg: ASbGncsddXMYibzPdcDSZjivNcJ2FkGRo7SF+t2V4B/rYS1ED95SCvFPCpIR0mA4mVv
	6UPIK7Q6qRCT4y1AALjhYJjNMhe7DTDo3HN3yGBK8bYgeameO7QlpKJ1XtZsEvdCNlNfFCN/yKi
	kIlBPiJFBpdksBTYOUhTQVM8WWjtUslZAIFAykASridWt7jSDm7J9RQ6H4Rx7z3OIuYYBAt6juY
	3Y9Eqp1orH6CWr3fvdkcMWr21ez3BA2aB3DadFnWfSQyo5DfjBfOP6mx+TKyTPyLmYVo1hYbD5G
	bkrpURG4mNqyK/tYXFnvkZupXDFPTV+qzRiZlvmsza03apbHlTWZzBVhUXq7OcXhkFKXC46ycKN
	jV/du8w==
X-Google-Smtp-Source: AGHT+IF94UxahrgvKnqbDIyQP2SoOHuqTWRLMtDqEw4LEuHBKdFhk7jgfYz2acmAzH6fUFJ672CotA==
X-Received: by 2002:a05:6512:308c:b0:545:4f00:f92a with SMTP id 2adb3069b0e04-5494332104amr1421507e87.20.1740668088335;
        Thu, 27 Feb 2025 06:54:48 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441741d4sm184217e87.33.2025.02.27.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 06:54:47 -0800 (PST)
Date: Thu, 27 Feb 2025 16:54:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] arm64: dts: qcom: Add 'global' IRQ to supported
 SoCs
Message-ID: <26ohpisuitzaghsxbbyjgb2rbhrubu4ipt7zopyuakxbgyqi7i@xa3tjwlwwjoq>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>

On Thu, Feb 27, 2025 at 07:10:42PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series adds the Qualcomm specific 'global' IRQ to the supported SoCs.
> This IRQ is used to receive the PCIe controller and link specific events
> such as Link Up/Down, MSI, PTM etc... in the driver. Support for this IRQ
> was already added to the pcie-qcom driver. So enabling this IRQ would allow
> the driver to enumerate the endpoint device and also retrain the link when
> the device is removed [1] without user intervention.
> 
> This series also adds missing MSI SPI IRQ to some of the SoCs.
> 
> Testing
> =======
> 
> This series was tested on Qualcomm RB5 board based on SM8250 SoC and
> Qualcomm Ride MX board based on SA8775p SoC.
> 
> NOTE
> ====
> 
> I've left a few SoCs in the tree like QCS404, SC8280XP due to lack of
> documentation. Those will be added later.

Also IPQ9574. For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> [1] https://lore.kernel.org/linux-pci/20250221172309.120009-1-manivannan.sadhasivam@linaro.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (23):
>       dt-bindings: PCI: qcom,pcie-sm8150: Add 'global' interrupt
>       arm64: dts: qcom: sm8150: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sm8250: Add 'global' interrupt
>       arm64: dts: qcom: sm8250: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sm8350: Add 'global' interrupt
>       arm64: dts: qcom: sm8350: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sa8775p: Add 'global' interrupt
>       arm64: dts: qcom: sa8775p: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom,pcie-sc7280: Add 'global' interrupt
>       arm64: dts: qcom: sc7280: Add 'global' PCIe interrupt
>       dt-bindings: PCI: qcom: Add 'global' interrupt for SDM845 SoC
>       arm64: dts: qcom: sdm845: Add missing MSI and 'global' IRQs
>       arm64: dts: qcom: msm8996: Add missing MSI SPI interrupts
>       dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: msm8998: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: ipq8074: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom: Allow IPQ6018 to use 8 MSI and one 'global' interrupt
>       arm64: dts: qcom: ipq6018: Add missing MSI and 'global' IRQs
>       dt-bindings: PCI: qcom,pcie-sc8180x: Add 'global' interrupt
>       arm64: dts: qcom: sc8180x: Add 'global' PCIe interrupt
>       arm64: dts: qcom: sar2130p: Add 'global' PCIe interrupt
>       arm64: dts: qcom: x1e80100: Add missing 'global' PCIe interrupt
> 
>  .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml | 10 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 10 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  |  9 ++--
>  .../devicetree/bindings/pci/qcom,pcie.yaml         | 14 ++++--
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              | 20 +++++++-
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 40 ++++++++++++++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 54 +++++++++++++++++++---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi              | 20 +++++++-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 28 ++++++++---
>  arch/arm64/boot/dts/qcom/sar2130p.dtsi             | 12 +++--
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               | 14 ++++--
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 24 ++++++----
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 40 ++++++++++++++--
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               | 12 +++--
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               | 18 +++++---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               | 12 +++--
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 18 +++++---
>  20 files changed, 300 insertions(+), 82 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250227-pcie-global-irq-dd1cd5688d71
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 

-- 
With best wishes
Dmitry

