Return-Path: <linux-kernel+bounces-352562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D59920C3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644C5280E47
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6EE18A94F;
	Sun,  6 Oct 2024 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ev4FKfZC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A71189912
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243489; cv=none; b=ElJM9ahmybDMDpATiimqyg1yDkDEM7naifSuMnyqgB1nJmh+4lHW/nJNXip5w2ND3Fyne+I17+KKRysLM4X7p8neyj3nIvoZQV5P+EOYPMdkeLe1esFWferLKg9BkeoSSSa2GS0F/afuikzoE1TlOchHWH+1gNG6qkvgNzUmBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243489; c=relaxed/simple;
	bh=nGCKPyHCbVOABGsadXdZRFQMzNLpRALFEsFtuJp1LHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcbzO5Kt1E2GYsfNg74e8nbCNGtmkiLSktJMb/XQ7aVGnD7l4fhrc5/G720yfeliEV9DFdi6b3qHwPgxbURGlxcNib6a2n5WUQop/MCvJmhJBiIYT8oV7XLcgC39IMj2LRBl4qaUersnvV4J+O+FTI1uCuqy7bcP+vicZGS83wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ev4FKfZC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53959a88668so4487317e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728243486; x=1728848286; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=upZ4clr0F2UsTRyI8VlcQRyvrRgYUFHH9md0SsXfnKw=;
        b=ev4FKfZCNF1YYGrY4hN3qWnvTDtgdk/hzEo417P2AaLWBI5Vicx7aIRsqJ9JgIryr3
         ovSy+Ks/aBBtYaJKWi7+T8IMq1qckVssrafWBayB/rtYwOsEgNSQDnFXyV3X0ip94sv2
         3+pVmi48X9oSqED32Q3SZ3/I91f2RRzd0i+klaLrD9Q1D5cM2NUZEik4TVvzSvDl23NT
         /QOxb0Kc1FSzsF7ZR72pdZbJatQRbqC1oXi0/Lxz7dbwMZULx9mwpp3KrA/SpeT0TDkw
         ztHDv7ySW5tIPbXcAKTr8w0Oc1dsx7BgUc+opUR6sdpRTV+82HeB/mGjToGKJCU02b7S
         n/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728243486; x=1728848286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upZ4clr0F2UsTRyI8VlcQRyvrRgYUFHH9md0SsXfnKw=;
        b=tSwr0IVCqpfKqTUusCU08Cs0QnCl3ZpMID116kb8mC1LR89nKudozcz9QY9ejHrZbZ
         qVUQgnpp6JRGOeFNaaqCVm3cmEexbnho7o4xRKMp8B+DfsdocS+VVQY64u0Vn5Y/YqY9
         0Ld4xwcGY7Lj5fD88+ZA7MxLaq+6qGZkLe1kcwtUmiKeOZTqIVzbACD8qFLfj3xW/krb
         yR0o6btDphM1hJ4r2R2nMEvO4o9168AgAHnQ11z8C4x/5TAf2lr+B6UD/oLmnvc5N37u
         KFgizJChU3LoBVN0Spiepro4qZY02hQw10OR7wSwM3YCJ2QEnVh00Wj0H29JxEMYZAwr
         0/kA==
X-Forwarded-Encrypted: i=1; AJvYcCWuDqt7ZgW/GBikhNcVbrVDiYnZCajNo/3OqVSrHp2lpTIEYcCTlrihb6GBC78gz19L+ieYPJG46YUlW8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIQdw9AWinrfE8L/Bc6VNROCvMeVp1oaKIOz8sItn1dhBioB3
	Pbkyue3hSuvYjgX3A0k2fH+hMCAGXhylAxGRmxRi7ICBcmNrL3ihd1QtzQmoKMM=
X-Google-Smtp-Source: AGHT+IFIivfrQ3y82dM65cowlrVIzn8SYf/7aafm0slhsyFxAL2Qv51m/k+OjLSS5i1zo89hxTuJPg==
X-Received: by 2002:a05:6512:33d2:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-539ab9e16femr4171004e87.47.1728243485598;
        Sun, 06 Oct 2024 12:38:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d230sm594819e87.162.2024.10.06.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:38:04 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:38:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shiraz Hashim <quic_shashim@quicinc.com>
Subject: Re: [PATCH 1/6] dt-bindings: remoteproc: qcom,pas-common: Introduce
 iommus and qcom,devmem property
Message-ID: <pt5x7miszg3vrqjimhdfesxghnpdsu4zzdr37vcmuze7yccmkn@twjeb5cfdqph>
References: <20241004212359.2263502-1-quic_mojha@quicinc.com>
 <20241004212359.2263502-2-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004212359.2263502-2-quic_mojha@quicinc.com>

On Sat, Oct 05, 2024 at 02:53:54AM GMT, Mukesh Ojha wrote:
> From: Shiraz Hashim <quic_shashim@quicinc.com>
> 
> Qualcomm’s PAS implementation for remote processors only supports a
> single stage of IOMMU translation and is presently managed by the
> Qualcomm EL2 hypervisor (QHEE) if it is present. In the absence of QHEE,
> such as with a KVM hypervisor, IOMMU translations need to be set up by
> the KVM host. Remoteproc needs carveout memory region and its resource
> (device memory) permissions to be set before it comes up, and this
> information is presently available statically with QHEE.
> 
> In the absence of QHEE, the boot firmware needs to overlay this
> information based on SoCs running with either QHEE or a KVM hypervisor
> (CPUs booted in EL2).
> 
> The qcom,devmem property provides IOMMU devmem translation information
> intended for non-QHEE based systems.
> 
> Signed-off-by: Shiraz Hashim <quic_shashim@quicinc.com>
> Co-Developed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  .../bindings/remoteproc/qcom,pas-common.yaml  | 42 +++++++++++++++++++
>  .../bindings/remoteproc/qcom,sa8775p-pas.yaml | 20 +++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> index 63a82e7a8bf8..068e177ad934 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
> @@ -52,6 +52,48 @@ properties:
>      minItems: 1
>      maxItems: 3
>  
> +  iommus:
> +    maxItems: 1
> +
> +  qcom,devmem:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description:
> +      Qualcomm’s PAS implementation for remote processors only supports a
> +      single stage of IOMMU translation and is presently managed by the
> +      Qualcomm EL2 hypervisor (QHEE) if it is present. In the absence of QHEE,
> +      such as with a KVM hypervisor, IOMMU translations need to be set up by
> +      the KVM host. Remoteproc might need some device resources and related
> +      access permissions to be set before it comes up, and this information is
> +      presently available statically with QHEE.
> +
> +      In the absence of QHEE, the boot firmware needs to overlay this
> +      information based on SoCs running with either QHEE or a KVM hypervisor
> +      (CPUs booted in EL2).
> +
> +      The qcom,devmem property provides IOMMU devmem translation information
> +      intended for non-QHEE based systems. It is an array of u32 values
> +      describing the device memory regions for which IOMMU translations need to
> +      be set up before bringing up Remoteproc. This array consists of 4-tuples
> +      defining the device address, physical address, size, and attribute flags
> +      with which it has to be mapped.

I'd expect that this kind of information is hardware-dependent. As such
it can go to the driver itself, rather than the device tree. The driver
can use compatible string to select the correct table.

> +
> +      remoteproc@3000000 {
> +          ...
> +
> +          qcom,devmem = <0x82000 0x82000 0x2000 0x3>,
> +                        <0x92000 0x92000 0x1000 0x1>;
> +      }
> +
> +    items:
> +      items:
> +        - description: device address
> +        - description: physical address
> +        - description: size of mapping
> +        - description: |
> +            iommu attributes - IOMMU_READ, IOMMU_WRITE, IOMMU_CACHE, IOMMU_NOEXEC, IOMMU_MMIO
> +          enum: [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
> +                  25, 26, 27, 28, 29, 30, 31 ]

Attributes should definitely be defined and then the DT should use
defines rather than the raw values.

> +
>    qcom,smem-states:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: States used by the AP to signal the Hexagon core
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> index 7fe401a06805..503c5c9d8ea7 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sa8775p-pas.yaml
> @@ -139,6 +139,26 @@ examples:
>          power-domains = <&rpmhpd RPMHPD_LCX>, <&rpmhpd RPMHPD_LMX>;
>          power-domain-names = "lcx", "lmx";
>  
> +        iommus = <&apps_smmu 0x3000 0x0>;
> +        qcom,devmem = <0x00110000 0x00110000 0x4000 0x1>,
> +                      <0x00123000 0x00123000 0x1000 0x3>,
> +                      <0x00124000 0x00124000 0x3000 0x3>,
> +                      <0x00127000 0x00127000 0x2000 0x3>,
> +                      <0x0012a000 0x0012a000 0x3000 0x3>,
> +                      <0x0012e000 0x0012e000 0x1000 0x3>,
> +                      <0x0012f000 0x0012f000 0x1000 0x1>,
> +                      <0x00144000 0x00144000 0x1000 0x1>,
> +                      <0x00148000 0x00148000 0x1000 0x1>,
> +                      <0x00149000 0x00149000 0xe000 0x3>,
> +                      <0x00157000 0x00157000 0x1000 0x3>,
> +                      <0x00158000 0x00158000 0xd000 0x3>,
> +                      <0x00165000 0x00165000 0x1000 0x3>,
> +                      <0x00172000 0x00172000 0x1000 0x3>,
> +                      <0x00173000 0x00173000 0x8000 0x3>,
> +                      <0x0017b000 0x0017b000 0x2000 0x3>,
> +                      <0x0017f000 0x0017f000 0x1000 0x3>,
> +                      <0x00184000 0x00184000 0x1000 0x1>;
> +
>          interconnects = <&lpass_ag_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
>  
>          memory-region = <&pil_adsp_mem>;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

