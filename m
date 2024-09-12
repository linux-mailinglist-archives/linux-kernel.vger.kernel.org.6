Return-Path: <linux-kernel+bounces-326127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D0976359
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9728655B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8118E03A;
	Thu, 12 Sep 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ngXwistB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A415C3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127447; cv=none; b=ODhnGzke7sbGlWVWtPGxwG1VD5AS41tAYNy8PmpKexDjgagSUqioDZQ0MD/tEFtl6gRLU2gK8GMtMTTFUZ8xGFb4ZoK0q438n+89qMukQ0aots2Liuun+/l0L7WePl9pBrMcOyU0mGupY3waD8qZcwhgBVU/0zJz/r2CZnR1u3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127447; c=relaxed/simple;
	bh=2LqACrC/f67ckKFHLjd87qsLYIsC7RhOTFV9UjSebdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS9KQ1Y3SiffzCKemHQegYGbNmMuhfdpa2MmQV6jMZ6bDDJAmzA824u35bBVtGkXAUnsvxT/PkiWXu5mbalG3vx/U8FpgC2OsPS6YPAV7ogdFKQmZdavspIDFRRhrjrPEN10s/FXj2/2P9nWAKWygNNkp5x4UO9ClYVtu3IoW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ngXwistB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-535be093a43so863000e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127443; x=1726732243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fW1OWTJTwPN4yaezyohYYBkn9WSUMxGliMksrCDxZTM=;
        b=ngXwistBAw5V27C17Dysz59HDg7+En3IRTe2HPl81klWsejMxubnDQySLcrg50ra8Y
         JSdCUOjFw+Ofwh3L6cF427VMHSY5dryv36xZG0PkRijgGTpjIAt+yOGsr0PS7h/GSi0Z
         26/ncx6hRChTHs9HWMAaPKm09gX9TgyeiodF14TDE7eK7ZVvlQcLAguauS3YJWQEf06J
         m16qCRUlf3PGCB7Rg/l7vPIAlUTx2VOnq+aHdCvzzl0W0QyCcut+F/uD6K3O17/ClVBq
         x6e1h6s1mJOP+Rf0mnyQcJ1G+1gILlqjXZhqsqSbKatVL7cIoGdEBcHeHSxvObZm/7jg
         +v+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127443; x=1726732243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fW1OWTJTwPN4yaezyohYYBkn9WSUMxGliMksrCDxZTM=;
        b=CPOo2E3BoNF5MunExM843f97g6T4DnUEj2+9O6fSFIl6QZBTopn0rnhKgTY1oD2Pza
         ygaXxlWvG3bZv9RBBOLYRbq2THyGh653KE64UDviqgtoPFqqnuGHEUSB/vj3FsfEzWeg
         K/xPH+uypzJT7ATMbV9JfIl6NCsetS1FIpdWEx8HoPV9C/bZmDgnrOCOaycf0dtxV8FV
         742Gh3FD8CH58Uj+ScB81BJ2k5LgD4t9NDw7NPBD/Ugimhb7DqV2ETfJuGXrtXwW+TTR
         AsC2jx4reTy2bh4UmWiYE/OK5sL/RvcRyNJwBd3wRoaPFqTiGKNT1s/DjWF9iOwd5UMV
         oktg==
X-Forwarded-Encrypted: i=1; AJvYcCWD5VV0/hwYpDR3m4ZvXosw6kovUoTZWYTRegoFI3pgOZIadOmJdR9WlhwzLVU/0c/XXp75ShLuo9zDmOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2TkhZ926tNFYyM9zpif4pMRhhYs7Dp8MPBJfoVP13EFqfppe
	BGaEq7PHfjVU2Q8idhmyDJHBspc6vuy8bZH/DzAhmLABL3mi5J8gl62tcn8ZH9A=
X-Google-Smtp-Source: AGHT+IHoEgXXvb2ufgKWD0LwGRMcBYHnNU0FkrySQs1z/TctRwUffjKkgYYzPpaPmZYfOUsY8xivgg==
X-Received: by 2002:a05:6512:b1e:b0:533:4b70:8722 with SMTP id 2adb3069b0e04-53678fba601mr1172150e87.15.1726127441934;
        Thu, 12 Sep 2024 00:50:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb7ccsm1852871e87.128.2024.09.12.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:50:40 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:50:38 +0300
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
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: Document MDSS on SA8775P
Message-ID: <7sj55umpspghithnuczpmqn7ex2shui2seqx23buwrkiu3736n@hoitmsdkhv2f>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-2-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-2-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:33PM GMT, Mahadevan wrote:
> Document the MDSS hardware found on the Qualcomm SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>

I don't think this was tested before submission. I observe obvious
issues which should have been reported while testing dt bindings.
I will not point those, letting you discover, identify and fix them.

Nevertheless,

> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sa8775p.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interconnect/qcom,sa8775p.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    mdss0: display-subsystem@ae00000 {

Drop unused label

> +        compatible = "qcom,sa8775p-mdss";
> +        reg = <0 0x0ae00000 0 0x1000>;
> +        reg-names = "mdss";
> +
> +        /* same path used twice */
> +        interconnects = <&mmss_noc MASTER_MDP0 0 &mc_virt SLAVE_EBI1 0>,
> +                        <&mmss_noc MASTER_MDP1 0 &mc_virt SLAVE_EBI1 0>,
> +                        <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +                        &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
> +        interconnect-names = "mdp0-mem",
> +                             "mdp1-mem",
> +                             "cpu-cfg";

Missing reset.

> +
> +        power-domains = <&dispcc0 MDSS_DISP_CC_MDSS_CORE_GDSC>;
> +
> +        clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +                 <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>;
> +
> +        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        iommus = <&apps_smmu 0x1000 0x402>;
> +
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        ranges;
> +
> +        status = "disabled";

Drop

> +
> +        mdss_mdp: display-controller@ae01000 {
> +            compatible = "qcom,sa8775p-dpu";
> +            reg = <0 0x0ae01000 0 0x8f000>,
> +                  <0 0x0aeb0000 0 0x2008>;
> +            reg-names = "mdp", "vbif";
> +
> +            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
> +                     <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +            clock-names = "bus",
> +                          "iface",
> +                          "lut",
> +                          "core",
> +                          "vsync";
> +
> +            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +            assigned-clock-rates = <19200000>;

empty line

> +            operating-points-v2 = <&mdss0_mdp_opp_table>;
> +            power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +            interrupt-parent = <&mdss0>;
> +            interrupts = <0>;

empty line

> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;

empty line

> +                port@0 {
> +                    reg = <0>;
> +                    dpu_intf0_out: endpoint {
> +                         remote-endpoint = <&mdss0_dp0_in>;
> +                    };
> +                };
> +            };
> +
> +            mdss0_mdp_opp_table: opp-table {
> +                compatible = "operating-points-v2";
> +
> +                opp-375000000 {
> +                    opp-hz = /bits/ 64 <375000000>;
> +                    required-opps = <&rpmhpd_opp_svs_l1>;
> +                };
> +
> +                opp-500000000 {
> +                    opp-hz = /bits/ 64 <500000000>;
> +                    required-opps = <&rpmhpd_opp_nom>;
> +                };
> +
> +                opp-575000000 {
> +                    opp-hz = /bits/ 64 <575000000>;
> +                    required-opps = <&rpmhpd_opp_turbo>;
> +                };
> +
> +                opp-650000000 {
> +                    opp-hz = /bits/ 64 <650000000>;
> +                    required-opps = <&rpmhpd_opp_turbo_l1>;
> +                };
> +            };
> +        };
> +
> +        mdss0_dp0: displayport-controller@af54000 {

Drop unused label

> +            compatible = "qcom,sa8775p-dp";
> +
> +            pinctrl-0 = <&dp_hot_plug_det>;
> +            pinctrl-names = "default";
> +
> +            reg = <0 0xaf54000 0 0x104>,
> +                <0 0xaf54200 0 0x0c0>,
> +                <0 0xaf55000 0 0x770>,
> +                <0 0xaf56000 0 0x09c>;

Wrong identation (here and afterwards).
Missing p1 block

> +
> +            interrupt-parent = <&mdss0>;
> +            interrupts = <12>;
> +            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +                <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
> +                <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
> +                <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
> +                <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>;
> +            clock-names = "core_iface",
> +                "core_aux",
> +                "ctrl_link",
> +                "ctrl_link_iface",
> +                "stream_pixel";
> +            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>;
> +            assigned-clock-parents = <&mdss0_edp_phy 0>, <&mdss0_edp_phy 1>;
> +            phys = <&mdss0_edp_phy>;
> +            phy-names = "dp";
> +            operating-points-v2 = <&dp_opp_table>;
> +            power-domains = <&rpmhpd SA8775P_MMCX>;
> +            #sound-dai-cells = <0>;
> +            status = "disabled";

Drop

> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                port@0 {
> +                    reg = <0>;
> +                    mdss0_dp0_in: endpoint {
> +                        remote-endpoint = <&dpu_intf0_out>;
> +                    };
> +                };
> +                port@1 {
> +                   reg = <1>;
> +                   mdss0_dp_out: endpoint { };
> +                };
> +            };
> +            dp_opp_table: opp-table {
> +                compatible = "operating-points-v2";
> +                opp-160000000 {
> +                    opp-hz = /bits/ 64 <160000000>;
> +                    required-opps = <&rpmhpd_opp_low_svs>;
> +                };
> +                opp-270000000 {
> +                     opp-hz = /bits/ 64 <270000000>;
> +                     required-opps = <&rpmhpd_opp_svs>;
> +                };
> +
> +                opp-540000000 {
> +                    opp-hz = /bits/ 64 <540000000>;
> +                    required-opps = <&rpmhpd_opp_svs_l1>;
> +                };
> +                opp-810000000 {
> +                    opp-hz = /bits/ 64 <810000000>;
> +                    required-opps = <&rpmhpd_opp_nom>;
> +                };
> +            };
> +
> +    };
> +...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

