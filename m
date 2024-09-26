Return-Path: <linux-kernel+bounces-340502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABA987441
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551682824A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F524B2F;
	Thu, 26 Sep 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8ZmRUY9"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF552179A7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356338; cv=none; b=IMFzF9BUFEw63RivWnqwBQ5v1D31JJ95vXdpNproIYedRTi2bSYSoO4sVEpQKY4QFRGrz4FzO5TmbEGgTEhM9Sc4BazUdd6CU1b9hl+M70sm+CU2c3nFUf6zASreufvGv79isn8WKoyVxA9UhCFQVQ8nQ9HbNn+uSPEp5YulWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356338; c=relaxed/simple;
	bh=olYrCsbi/wSziH0EE5DB3RMwDthW3ZKLc8++5NEfxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmdqinK9R3v23eoRJ941FPr2lHAxCoq3AMQ2n+wz1gzZ6mpAo5bl7j/rJnihJrFYS6652FNtdwL58w8z2UDfljhuOCbdU5X6ZMzIqZEoVD7JiV2Tu6cs9VdbpWaDXJ69cCxOg1LHg9ivMjlqlO2BLcoIL10CYv278FEHtr+gZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8ZmRUY9; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f75c6ed397so10148401fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727356335; x=1727961135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKriAI4eZkRaHODPjuZ+jj+F+rk5iOr07UhYYqdkBLg=;
        b=I8ZmRUY9XXgrIe/hhq2E7TPAF+jMeSjLU+rLMDZX8t2hdaT/iM/D25C5roi/Dkycx8
         0GwaDjD3XoVTvmPae0dRk6Q1gsr95xpuILXBJDqchOX2gIDcBjAC4W0i4b1DamzU/xbO
         reuL9AFhacVCEKC/TEOlR3CmYE23x7S0zvLfhZVNuWPRb1Ld7Rz+S+v3UFuw4NKEMcCi
         +tUAcZ7O/HmTfiXawetPzhi/4zr0MKh0iR0A00KzXvRg/v/3Og972krkCYNTyISRLJc2
         1otuqMX9YCC3SuMttc0C5BnGIXaVJvUUQEBbHbDXnEsOuEX7ftUmYBommOzwlJIKwaRZ
         sDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727356335; x=1727961135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKriAI4eZkRaHODPjuZ+jj+F+rk5iOr07UhYYqdkBLg=;
        b=jGHip5gSnsBWHmca8Q8VNend4ujspNAsW5x5U7696smC0KTm7G9W6DDX171LdSH4JM
         i4EGBJygEsDS0hbkwmxiDBMS2ZuVrht2v4yTbe7t7xdycrurPvO+lmQ083XCF9o/JYnS
         D/Bnp7BQcqOgUNxWGo4G0rhbWn3gHGnnSXPGvIftESe0L/lEloFQqTcCONq2X78QSYug
         AJaUY2dC+whAq26KnfMP+AI8weu6nn1dCXhkBvhKSWvteTKHp++TFMwT0r2gZ3oAxqtS
         wnkW2ZSLW3XI7b4D8ztgALNxNgDrlpjPE4W/m7cam8sUN1p+dDLvL5wRfAZwilFWtGHN
         jFzw==
X-Forwarded-Encrypted: i=1; AJvYcCWdjMywkoltU5ycTI2LZpiun9WjyGjxiR2vC6oSNxcM9OUhyz+l2I60TjqPzEasObqp913VskARj7EppwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKESg8WikcULaCk+L5XVpfK9uy4IHQNgNmpU27qcyufed5gY7o
	SuHltRu9PIVAAVFpo25GFKgz2BBJkGlqSPt+vK4fx5LTcPxadyHHG2tRGsEGMn0=
X-Google-Smtp-Source: AGHT+IEdvfytwo17gCgvymeEaRhz2m8Z7wR8D5FYIwCXKva9/v1xhvvhMLWRmcQBnqRRYBVmBQbL8g==
X-Received: by 2002:a05:651c:50f:b0:2f6:62c3:4e0e with SMTP id 38308e7fff4ca-2f914ac3ff9mr40894901fa.6.1727356334934;
        Thu, 26 Sep 2024 06:12:14 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289b54bsm7832621fa.109.2024.09.26.06.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 06:12:13 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:12:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sa8775p: add display dt nodes
Message-ID: <hyhsyl43xurr25ws2blejxbyae47a73f77hnjmjql3jwcpocvk@565kpktxs2fi>
References: <20240926110137.2200158-1-quic_mahap@quicinc.com>
 <20240926110137.2200158-6-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926110137.2200158-6-quic_mahap@quicinc.com>

On Thu, Sep 26, 2024 at 04:31:37PM GMT, Mahadevan wrote:
> Add mdss0 and mdp devicetree nodes for sa8775p target.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> 
> ---
> 
> This patch depends on the clock enablement change:
> https://lore.kernel.org/all/20240816-sa8775p-mm-v3-v1-0-77d53c3c0cef@quicinc.com/
> 
> ---
> 
> [v2]
> - Update commit message mentioning enablement of mdss0 only is done. [Dmitry]

It doesn't

> - Add resets node and fix indentation. [Dmitry]
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 87 +++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 93be4683a31f..27ab1921c1f3 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -6,6 +6,7 @@
>  #include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> @@ -2937,6 +2938,92 @@ camcc: clock-controller@ade0000 {
>  			#power-domain-cells = <1>;
>  		};
> 
> +		mdss0: display-subsystem@ae00000 {
> +			compatible = "qcom,sa8775p-mdss";
> +			reg = <0x0 0x0ae00000 0x0 0x1000>;
> +			reg-names = "mdss";
> +
> +			/* same path used twice */
> +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>,

QCOM_ICC_TAG_ACTIVE_ONLY ?

> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "mdp0-mem",
> +					     "mdp1-mem",
> +					     "cpu-cfg";
> +
> +			resets = <&dispcc0 MDSS_DISP_CC_MDSS_CORE_BCR>;
> +
> +			power-domains = <&dispcc0 MDSS_DISP_CC_MDSS_CORE_GDSC>;
> +
> +			clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +				 <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>;
> +
> +			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			iommus = <&apps_smmu 0x1000 0x402>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdss0_mdp: display-controller@ae01000 {
> +				compatible = "qcom,sa8775p-dpu";
> +				reg = <0x0 0x0ae01000 0x0 0x8f000>,
> +				      <0x0 0x0aeb0000 0x0 0x2008>;
> +				reg-names = "mdp", "vbif";
> +
> +				clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
> +					 <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +				clock-names = "bus",
> +					      "iface",
> +					      "lut",
> +					      "core",
> +					      "vsync";
> +
> +				assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +				assigned-clock-rates = <19200000>;
> +
> +				operating-points-v2 = <&mdss0_mdp_opp_table>;
> +				power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +				interrupt-parent = <&mdss0>;
> +				interrupts = <0>;
> +
> +				mdss0_mdp_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-375000000 {
> +						opp-hz = /bits/ 64 <375000000>;
> +						required-opps = <&rpmhpd_opp_svs_l1>;
> +					};
> +
> +					opp-500000000 {
> +						opp-hz = /bits/ 64 <500000000>;
> +						required-opps = <&rpmhpd_opp_nom>;
> +					};
> +
> +					opp-575000000 {
> +						opp-hz = /bits/ 64 <575000000>;
> +						required-opps = <&rpmhpd_opp_turbo>;
> +					};
> +
> +					opp-650000000 {
> +						opp-hz = /bits/ 64 <650000000>;
> +						required-opps = <&rpmhpd_opp_turbo_l1>;
> +					};
> +				};
> +			};
> +		};
> +
>  		dispcc0: clock-controller@af00000 {
>  			compatible = "qcom,sa8775p-dispcc0";
>  			reg = <0x0 0x0af00000 0x0 0x20000>;
> --
> 2.34.1
> 

-- 
With best wishes
Dmitry

