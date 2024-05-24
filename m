Return-Path: <linux-kernel+bounces-188815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DF18CE756
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C911C20939
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080F12C80F;
	Fri, 24 May 2024 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXUA2lmw"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4F86643
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562317; cv=none; b=SkEuWnPAQNu23SQJwfp0ADRVjNGf5HAM1JsHpKnT0Q9/Leibq/mjZfHshKY9RqX114gqQU/nUqm+tgE6WJ8d5Rd6c3bZwcuYNNLm0uXDkoM2T7+pZnvrZ0wTgTPCjseqQGyz/Hb/3zAvNROOsb3mNa5MgdG3V+Y1diadLk6wO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562317; c=relaxed/simple;
	bh=WjiI8ybe4eiixG0uMQlez0Dv2iXjBfm7PVw47/YjSvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8eQCuqUIrGqdfoZ3LOB8kLS5277+J44J3yASZn8v2XpzyZoKd09oL0mLBf02ogtGjNryuPl+44/YiMZ18iZ5ZGGa4ttshGCgUvnQLYHKtxuY/N5jQ6mctDZ1EfbMP/HfiOAC+4fZDGGRnQHzRLIRY/i58xjGVz1/eIx8GILzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tXUA2lmw; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-68187b5d3fcso656276a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716562314; x=1717167114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pIFIsBuVWw6jkhTpTL23angRB7Fq2EWXtvTb6t5SofI=;
        b=tXUA2lmw9vhuj1nZ6qhRIyaAp4z79knpUJhj/p2BIMrxZYE22UmsL1edRfcVe03xMy
         LS48LgBM0koKQ/E5r7diWGkYRq30j8Fh9RAOsmOLSvxvWeikjP8hNRXQqfRzSWJX6Olx
         E9Fx71QjTRTokiUS76j2zCc0RwWudROfCt30aqJ9xv+r1Az4RQkdh7ji1avdD6MfXGl7
         QL4WrZWhAFueIyFpY5xHFAf2WoDmkWP77Pqu852sHMzNkaRtJWYk7lrJeR1e0ydiQ0b5
         XBr1ErxQakl7nu+GhjdB3Bz7O8jX7qQQk72/n1Fujdv06HzxutogEg6KK6J26NTZCIkE
         zl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562314; x=1717167114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pIFIsBuVWw6jkhTpTL23angRB7Fq2EWXtvTb6t5SofI=;
        b=as4RPoky/1JcA3ri52ZlnxLCeTkFkOp8ErV8i4XmiMA/zoJIQ6SSuNKWEAJrLbdkNE
         WaVeQvAS62s0qLrmzuq+QQ1X5Kg5enj/dsTE4JA+4HknmrshXTXaJJ6ZEHhP38P5bSUS
         8PmS5/jLyGdcTguWZVd14ekMir07XAZUn/mlmZF9FbWSbwW9gf4eDubEPX+EXqyq7/ar
         MFTXfWKvmcjdgBQTNW4BFV1FnPoHnENTlA8gCKq37xygS1vu6IonocLWn9GMspz5NWeb
         aNe3oxs+qY7v145YykYIN1/BWb/yk0CxZTPjNecypVvCSEalSL3qHuYEGVn97BLXLSg6
         1Qkg==
X-Forwarded-Encrypted: i=1; AJvYcCUKvBHqg+VKFTiZZCPetxpOdbb8cRKZ0phpaU2j1Svyi6ayli/xlqkmrgKopsrVfJWqrPw069ItkgKrTkpd9EssKbJSnFiaM8kFZ5+A
X-Gm-Message-State: AOJu0Yxu0yQ2T5AFkoqQ1OBFeod3UcjFBzGRg6LhxJZTmF16nn1QLC9g
	ihnvq6qfmunQ3//Vw8t72Dj2rj+ETeQfYV0L4zbIlbRqkTEJRaOznW0nLX4n6A==
X-Google-Smtp-Source: AGHT+IHBzq1mSEGRsqLs5Du9N3tIUDTGCmvjWHX1HnwVoO6x/qVcbswIrti1nAmJXzHXEekp1t5ZRA==
X-Received: by 2002:a17:90a:c903:b0:2bd:92e6:99ac with SMTP id 98e67ed59e1d1-2bf5f7512e9mr2417536a91.40.1716562313659;
        Fri, 24 May 2024 07:51:53 -0700 (PDT)
Received: from thinkpad ([120.60.56.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9ece075sm3400385a91.9.2024.05.24.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 07:51:53 -0700 (PDT)
Date: Fri, 24 May 2024 20:21:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sa8775p: Adding iommus property
 in pcie DT nodes
Message-ID: <20240524145143.GB5758@thinkpad>
References: <1714494711-10322-1-git-send-email-quic_msarkar@quicinc.com>
 <1714494711-10322-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1714494711-10322-2-git-send-email-quic_msarkar@quicinc.com>

On Tue, Apr 30, 2024 at 10:01:50PM +0530, Mrinmay Sarkar wrote:
> 'iommus' is a list of phandle and IOMMU specifier pairs that describe
> the IOMMU master interfaces of the device. Specified this property in
> PCIe DT nodes so that IOMMU can be used for address translation.
> 

This patch description is heavily misleading. Even without the 'iommus'
property, there will be IOMMU translation because of 'iommu-map'. And I recently
got rid of 'iommus' property from all DTs because it is not really required for
the translation (it allows the host bridge to bind to IOMMU, but that's not what
we want).

This patch is intented to fix the IOMMU fault that occurs whenever the EP is
attached to the host. But you never described or even mentioned about the IOMMU
fault. Please describe the problem clearly and explain how the patch fixes that
in patch description.

Now for the IOMMU fault, I did some investigation and found that the fault is
happening due to some AER generated by the bridge whenever the device is
attached to the host. Interestingly, there was no AER IRQ received on the host.
But that can be expected due to the IOMMU fault as that could've blocked the AER
MSI from reaching the interrupt controller. And 'lspci' shows that the bridge
(even device) generated CE error (RxErr):

                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout+ AdvNonFatalErr-

But I dont' know why the IOMMU fault occurs. I also tried to manually inject the
AER errors and I saw the AER IRQs are generated correctly. So this confirms that
there is no problem with AER itself.

For experimenting, I reduced the PCIe bandwidth to Gen 2, and the above error
was gone. So this hints that there could be something wrong with the PHY.

And yes, adding the 'iommus' property indeed makes the IOMMU fault go away, but
still I can see the AER error in lspci, but no actual IRQ received (weird). So
this patch is not really _fixing_ the issue, but just masking it in some form.

Please investigate on why the RxErr is being generated and how that ended up as
an IOMMU fault instead of an IRQ.

- Mani

> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 9065645..0c52180 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -3666,6 +3666,7 @@
>  				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_0 0>;
>  		interconnect-names = "pcie-mem", "cpu-pcie";
>  
> +		iommus = <&pcie_smmu 0x0000 0x7f>;
>  		iommu-map = <0x0 &pcie_smmu 0x0000 0x1>,
>  			    <0x100 &pcie_smmu 0x0001 0x1>;
>  
> @@ -3822,6 +3823,7 @@
>  				<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_1 0>;
>  		interconnect-names = "pcie-mem", "cpu-pcie";
>  
> +		iommus = <&pcie_smmu 0x0080 0x7f>;
>  		iommu-map = <0x0 &pcie_smmu 0x0080 0x1>,
>  			    <0x100 &pcie_smmu 0x0081 0x1>;
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

