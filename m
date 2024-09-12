Return-Path: <linux-kernel+bounces-326147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB419763C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38D51C23408
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7866C18DF9B;
	Thu, 12 Sep 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uur9dmxa"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B9189B88
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128042; cv=none; b=A1CgD/By1bIIWF5K2x5Q1aQO6B/WmJ8i1ynNB6oq+YmmjuYfCYOu3E2kOJG1CmWZDhSq/WWQkJD373ePgTfEmyqMp70svWj0JspgCq0C1SNxjC1wlrqDjlJaClEVioVckLY8046uAHZ+9fhxzJRotxSM3L0VQnfockFjltolYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128042; c=relaxed/simple;
	bh=Q5Q4yukVQCdw40/7wDBQrcY2I6g4IYljJ4ajwKiCGUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBtuXPAHCmwK7BZy71imVwDxezZJxPSzH7Pz+t2RMQ1RlpjIooCzGVS5Ud93FgHhG6vtfuY/hedocPEvg8D/rPRW8V73pdIzVdjqh7vJI71DkXC1/sgYIIuMWb3KCgDlw0UUW42KIho67+9RXy0adgJrbgU6lk9Jb4/cPu8vDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uur9dmxa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso905530e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726128039; x=1726732839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5modn5x5ktb92R2/Sf1154fPo8VvDbqrTciHNWoobzQ=;
        b=uur9dmxaVg0gRv/o+ymERQqYV5YOmrNYWE1en4I2+1T1iv3CQeuci0jzJFh/4V1R7l
         DYn7c15uiTlQTgbqggYDu9k/g6hWrcqHul5fzg7i1kAIpxyfIlpm1g+g1tSkW/6aid87
         QGSU4n0reQDqf8w5rLKEt4HVyXi+VLf5ZjmHJpZfzIEYUjRvnQFgf/1JFPdFRWFds5u+
         qYsm8G83pePM/LWLEb92f6lYgYn6x5/TgXn9MW+LI1qzLOxOSN92MP5KWApl+P5oar8n
         epxYVedC2Kv+iuUV5a9QvAYs2B0cMKJTXwRgR80cUDk4h9EehuEZN1ICaKONfe0meBAT
         BuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726128039; x=1726732839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5modn5x5ktb92R2/Sf1154fPo8VvDbqrTciHNWoobzQ=;
        b=osH5a/S6v1z/uAs4Kh4eNxh9gKHV+/xwHF9Pb4Zhou5qZMaQ6mujsYsk5QRlImEgct
         KwKU4ICxSp+kMg8EEdlP7Acy4EX9xydWZ9/gu/QfqNc2Buy33uZImyZOLw0IoClgSKHD
         qndVnIhvz9Sa+rTwAsgz30ZobsFWnL1u48HrBgcNh7rXq4Bm80JbPxs9ZtJvYkTxEIPT
         KAcsxqpSLyaHR6sIZW7reXnPdoa+dGDWwIJc7X8DhCcep+xBCcBB2UDDH/Dppd9UvW0e
         Oj7fIFabNVp2fSBd23d+sknQkQJNFVcxJCZ/yefe1V0p1LqEwHruple32d00KXX2FMfI
         7pUA==
X-Forwarded-Encrypted: i=1; AJvYcCUnDdfqcqwWbWTXZACKNcq0WcSN+J4hIAgMd8bnJVFDHC9PHbrDYfJ15r08W2x/72lyLgjWb8V1eIPI1A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRkjeEA5AG5yVj6eARs26wxvbDyV19gCdUz6bfwL1+lZXiTgy
	pWR9BrmYdS295ftpW65HsQAs2LTEXxmvXZqz11gqPjjil+qjOOUnHE+NdcINjP0=
X-Google-Smtp-Source: AGHT+IHahBSHVXIeldwwf3pO17r+LD9jwU2Se1YwQ3QQIuNHAGAmDpStfbv4s0gMC389h59Yw6vybA==
X-Received: by 2002:a05:6512:3b22:b0:536:741a:6bc5 with SMTP id 2adb3069b0e04-53678fab49dmr1746967e87.12.1726128037823;
        Thu, 12 Sep 2024 01:00:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb73esm1831653e87.174.2024.09.12.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:00:37 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:00:35 +0300
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
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sa8775p: add display dt nodes
Message-ID: <kxxcjrqndc2qzmexn4mm4vmfugfo23y63aa6oyia3uiwpe3arr@sbvdni2f2hq2>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-6-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-6-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:37PM GMT, Mahadevan wrote:
> Add mdss and mdp DT nodes for SA8775P.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 85 +++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 67ba124d20f8..d5d8e02fdb29 100644
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
> @@ -2937,6 +2938,90 @@ camcc: clock-controller@ade0000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		mdss0: display-subsystem@ae00000 {

Is there going to be mdss1?

> +			compatible = "qcom,sa8775p-mdss";
> +			reg = <0x0 0x0ae00000 0x0 0x1000>;
> +			reg-names = "mdss";
> +
> +			/* same path used twice */
> +			interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> +					<&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +			interconnect-names = "mdp0-mem",
> +					     "mdp1-mem",
> +					     "cpu-cfg";
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
> +					<&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +					<&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
> +					<&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
> +					<&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;

Wrong indentation

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

