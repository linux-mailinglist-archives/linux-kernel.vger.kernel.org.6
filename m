Return-Path: <linux-kernel+bounces-215395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221E90921C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91601F25304
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2D19E7D3;
	Fri, 14 Jun 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPc9UwfG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FA19ADB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718388343; cv=none; b=E5+Wo0bbZ/REj8mzYsj88PKdatzSxiGm8A/XkJo50ZmsQluTAw8Kiu2ttaV317oNwPe7YJ0XfeA3labMs70iyjpaz2NAMZY0gz3cEf6TVxc7nsn7GanP6m4F5wuFWjzU6F5esWNtxwN6yGQXgrlK+K9q4ulltNzFpLSN7QS7MzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718388343; c=relaxed/simple;
	bh=hNhj4oQKB9aRCcIq7/rMXhmUVhPaDoni0j2lJhoy2OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhj6hyEYNBsCNqQgvuGSpYp46+uYWtKgcRfi2C6fUB7FRxiet5z9aC278WfIaJdwFSQQ24sFlhKZ6EZ54K5PUePrBiKoG+a8tOEyhVuSK11oQa0Y5f2rR8OJ5Q18FVSOVda/c8OLIpV94pQc/vyOtERXjfP+K1jieCphEWYMF5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iPc9UwfG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-681953ad4f2so1987424a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718388340; x=1718993140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SoNh1tojhGl6DE6Qa2dKAxuaT1KpRubysgC5JHV5d8A=;
        b=iPc9UwfG9F2f60RLwb4T07RP6kSSIIs0tEbH4EhGKGHjREha3Lh3E7KWCI88682BVT
         t/UkvtDsY4Inb4VkXr5qLeVNANzDUiZajMRTK47jTQxokXxyzPRM+mqU+QCthH1tN1Bw
         Z8a0CumQAQuuFtOgU2LB36yr+5IDGVYFL/MJuKZtNkWDg7f4yD8Uo3Jrken95dspQc8X
         Q82ty8+4kixbdl8inPYe8ks5RqHRGOiL7tYQzyK3zHv0LrkRdFw/NowraSY4EzysVfCs
         +ytHq5uxSFQT0VX7y5y/LUC8m5f3HV2zGmdkCP4+L6VDLEtmuKXdJMV8G5eqlF76DXqG
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718388340; x=1718993140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoNh1tojhGl6DE6Qa2dKAxuaT1KpRubysgC5JHV5d8A=;
        b=ByijcsRicxZM+rqQXqmFzirL+O6wqkpuU9U3A4Q/2uLbSzrUoVQ+eEZgy/QOeXYHCO
         oTa7gR+gsOJQ3QbD8z33OnK2LG3RzUMwknAZKKLRyGWYyQmejxuN7ln/Khd38tNDQJhI
         GpD03br6IZfTymImTe4dB1uaa18yteRVaDvxeNivUQFQEvjbroftSPiYLFG65X2eOsAl
         tbRGf7FkBCud2pNqxVvqjDEpQdzxw4HOmyzMfQb9bObMBrisWpacvhk1YFNcFzyVzbI7
         G2HM6TM+AQNhD5Z9DGBURMFlQkjtxL1fAADW3HlgZU69Vw3CAITbR/oePCQOl8QVbOIJ
         PSHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgizyYd/BCt8rX4ccUq7oP1GPQd7aeKOMTARFKq44Yxkrfoo2eyyWYpkaPe/00dSLnVCHau0aPVf1hSkHOpOtlb0v8YIBH5ELZG6Zz
X-Gm-Message-State: AOJu0YymkZfas8ls16DS6xw5QQoFp9Eat7exvbmXFny9hMS8Qwx6NOGM
	lXBud+fJ7eS+OWwhim801I6C0eS0rJ7JLMf9773lfF1CDNcspc07ofkKEmYLfE2EZtcQgN+lEAP
	qcmB7JcPdim1Ye8BO1CPvG6MJVo7s7T0vL+ATqA==
X-Google-Smtp-Source: AGHT+IGPXck+B6yocgMSj5EK96i63c8Roh0QGWnbr/CvcZMU0FTNUAr3Gy5zR4lrtPFEtUKFUicicx2KMW1qUtU069A=
X-Received: by 2002:a17:902:e74a:b0:1f6:ebe2:758d with SMTP id
 d9443c01a7336-1f862900731mr36854965ad.51.1718388340177; Fri, 14 Jun 2024
 11:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417133731.2055383-1-quic_c_gdjako@quicinc.com> <20240417133731.2055383-6-quic_c_gdjako@quicinc.com>
In-Reply-To: <20240417133731.2055383-6-quic_c_gdjako@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 14 Jun 2024 21:05:28 +0300
Message-ID: <CAA8EJppcXVu72OSo+OiYEiC1HQjP3qCwKMumOsUhcn6Czj0URg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: sdm845: Add DT nodes for the TBUs
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	iommu@lists.linux.dev, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, robdclark@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_cgoldswo@quicinc.com, 
	quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com, 
	djakov@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Apr 2024 at 16:39, Georgi Djakov <quic_c_gdjako@quicinc.com> wrote:
>
> Add the device-tree nodes for the TBUs (translation buffer units) that
> are present on the sdm845 platforms. The TBUs can be used debug the
> kernel and provide additional information when a context faults occur.
>
> Describe the all registers, clocks, interconnects and power-domain
> resources that are needed for each of the TBUs.
>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>

This patch now prevents interconnect drivers from hitting the sync
state on SDM845.
The TBU driver is enabled only when the ARM_SMMU_QCOM_DEBUG is
enabled, which is not a typical case on a normal system:

[   26.209151] qnoc-sdm845 1500000.interconnect: sync_state() pending
due to 150c5000.tbu
[   26.217228] qnoc-sdm845 1620000.interconnect: sync_state() pending
due to 150c5000.tbu
[   26.229926] qnoc-sdm845 1500000.interconnect: sync_state() pending
due to 150c9000.tbu
[   26.238008] qnoc-sdm845 1620000.interconnect: sync_state() pending
due to 150c9000.tbu
[   26.249068] qnoc-sdm845 1740000.interconnect: sync_state() pending
due to 150cd000.tbu
[   26.257127] qnoc-sdm845 1740000.interconnect: sync_state() pending
due to 150d1000.tbu
[   26.265159] qnoc-sdm845 1740000.interconnect: sync_state() pending
due to 150d5000.tbu
[   26.273189] qnoc-sdm845 1500000.interconnect: sync_state() pending
due to 150d9000.tbu
[   26.281206] qnoc-sdm845 1620000.interconnect: sync_state() pending
due to 150d9000.tbu
[   26.289203] qnoc-sdm845 1500000.interconnect: sync_state() pending
due to 150dd000.tbu
[   26.297196] qnoc-sdm845 1620000.interconnect: sync_state() pending
due to 150dd000.tbu
[   26.305201] qnoc-sdm845 1500000.interconnect: sync_state() pending
due to 150e1000.tbu
[   26.313207] qnoc-sdm845 1620000.interconnect: sync_state() pending
due to 150e1000.tbu


> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 73 ++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 2f20be99ee7e..fa9403aad96f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/dma/qcom-gpi.h>
>  #include <dt-bindings/firmware/qcom,scm.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -5085,6 +5086,78 @@ apps_smmu: iommu@15000000 {
>                                      <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>;
>                 };
>
> +               anoc_1_tbu: tbu@150c5000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150c5000 0x0 0x1000>;
> +                       interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x0 0x400>;
> +               };
> +
> +               anoc_2_tbu: tbu@150c9000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150c9000 0x0 0x1000>;
> +                       interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x400 0x400>;
> +               };
> +
> +               mnoc_hf_0_tbu: tbu@150cd000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150cd000 0x0 0x1000>;
> +                       interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x800 0x400>;
> +               };
> +
> +               mnoc_hf_1_tbu: tbu@150d1000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150d1000 0x0 0x1000>;
> +                       interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &mmss_noc SLAVE_MNOC_HF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0xc00 0x400>;
> +               };
> +
> +               mnoc_sf_0_tbu: tbu@150d5000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150d5000 0x0 0x1000>;
> +                       interconnects = <&mmss_noc MASTER_CAMNOC_SF QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &mmss_noc SLAVE_MNOC_SF_MEM_NOC QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x1000 0x400>;
> +               };
> +
> +               compute_dsp_tbu: tbu@150d9000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150d9000 0x0 0x1000>;
> +                       interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       qcom,stream-id-range = <&apps_smmu 0x1400 0x400>;
> +               };
> +
> +               adsp_tbu: tbu@150dd000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150dd000 0x0 0x1000>;
> +                       interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x1800 0x400>;
> +               };
> +
> +               anoc_1_pcie_tbu: tbu@150e1000 {
> +                       compatible = "qcom,sdm845-tbu";
> +                       reg = <0x0 0x150e1000 0x0 0x1000>;
> +                       clocks = <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
> +                       interconnects = <&system_noc MASTER_GNOC_SNOC QCOM_ICC_TAG_ACTIVE_ONLY
> +                                        &config_noc SLAVE_IMEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +                       power-domains = <&gcc HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC>;
> +                       qcom,stream-id-range = <&apps_smmu 0x1c00 0x400>;
> +               };
> +
>                 lpasscc: clock-controller@17014000 {
>                         compatible = "qcom,sdm845-lpasscc";
>                         reg = <0 0x17014000 0 0x1f004>, <0 0x17300000 0 0x200>;
>


-- 
With best wishes
Dmitry

