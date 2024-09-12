Return-Path: <linux-kernel+bounces-326132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D5097637D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643A32865A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D42188A00;
	Thu, 12 Sep 2024 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDsrMbZU"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E318890E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127566; cv=none; b=U7gB85O6mwhhlB9jowR42PQxXubJk4/k6ISVm7Qw7qQ0r7cBanaHri1v5EFTzs3IFjlv0Ec+GdHh/UDQ92o5c7SiVFBXkSxW6D3BjOvkjtTkmXzx4VT0nnAk7ySEUvQXwLIo4tcyVLxfY0CJm/A0+uNnsfWX7y95ZrCMkDqwwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127566; c=relaxed/simple;
	bh=KpZ/OBjQ952uyEtwlzqLtUdjSueYLObXbMJk3aHGCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awsBKAFcSB/tIwzUnhktJCYEqnyr4OC7VTTZR/gmqWwwdSVfnFayUkSbicsKDNJcuUB18gvhBu8vMHmWWhPI6A/lYxFle1XSfB2XnHKQiazBfPTAZNCLUP2BWoQvF0v4Brd6iM6fDm0zxb3lBnHTQwoYc+4JjBUvHZUKRmPTsR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fDsrMbZU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5365a9574b6so946349e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127563; x=1726732363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eTkWSFh0slefdYYlB8sOq3Alq45nxHEpvtMyVah6e0Q=;
        b=fDsrMbZULkh5Ouv2B2W+/c/cD8HBjgKcNwaU+WIm3X5FPRCth0WR/ZwRrRRgra7lpV
         qEV3qy8DQuMrVc+3ggfDKSa7mEWje7ASCxrKqsWwtsYVmQLfnfb14oB8OJxfBdD+mNX8
         hndtfPmaeAKY7rP+CWgfwx9RZWKkhGv7qkomotadNrjnqQj8uEWqFgNzq+uHSy35OfAF
         7O9M2Sb3QvFYzhDmH45zzxkhLebUYyAh8TebXGxtnkDlAsF6LvBy9LpRzmVHducVvNrE
         eMBZaEICv98zFJ8t+X9rSMN8ke5Sv+gzLbTmYP/boe9tiRCu72j+7HcqqqdZKwEv85Mw
         /upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127563; x=1726732363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTkWSFh0slefdYYlB8sOq3Alq45nxHEpvtMyVah6e0Q=;
        b=YpOtohCw2aa2ZS/XY3CZLOkROngGwkJrm/lVJjP8GM+SmM/KYnaS7NpcsHALegM3ls
         4Y/m9BddVOgZhP++DU1e3rv0oq2NHiA0kjx0zDkDmSaZqo27inHex8komZFlmpUhnxEk
         pKEgJrRg0jq9XPNlXaWZVP3erZOFfkITBfYMkSBJtizy9TWt+cGm1hbKdUb5tK8YQmDM
         0fqDAa3RE2oXpUiVsuxAszBxlcRxFGNuo+JAsVpAAPH1NrUWvwfol8ZbjJqpNCECa1VV
         8MAMWu0TGj2IRVDqnhYYhy9Uo8GGDgUnxyMPgJdeZZqB7OPUTcDb70NsQ+FQut8sIvf0
         Ry/w==
X-Forwarded-Encrypted: i=1; AJvYcCUDmGCsGBVffjBiJwAf4ht6gMf8vnfOdUeti947BNgLOmJz9iXn1pF+oOccvjoHeSLmXdRMuKKZYDehTLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFfAEty8rAezBMkaPkeF5YmjSpCLOr5RP6z6QEhII8OeiFiPsQ
	4k4sYru/iXEHnoyBTM7kEzy0EXijkkRzDmILZaryCncMytuqJ8bUdYMVUIa15kw=
X-Google-Smtp-Source: AGHT+IFreFJR91Jk0jO+3GaqJhwxC3JIon4VS/a8wOCAEnO6MaGHHHfffcWsljomGO5+V5BT8hHE/w==
X-Received: by 2002:a05:6512:4029:b0:52c:9ae0:beed with SMTP id 2adb3069b0e04-53678fec4fcmr1533271e87.52.1726127562565;
        Thu, 12 Sep 2024 00:52:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8caba6sm1832730e87.169.2024.09.12.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 00:52:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 10:52:40 +0300
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
Subject: Re: [PATCH 2/5] dt-bindings: display/msm: Document the DPU for
 SA8775P
Message-ID: <73tpotwk5xotzpbbikzx2jx5re2i3g5w2ze3zqm2yrqcrt3ncx@oyid2nlcu65l>
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-3-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912071437.1708969-3-quic_mahap@quicinc.com>

On Thu, Sep 12, 2024 at 12:44:34PM GMT, Mahadevan wrote:
> Document the DPU for Qualcomm SA8775P platform.

Please fix errors reported by DT tools before submission.

> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
>  .../display/msm/qcom,sa8775p-dpu.yaml         | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
> new file mode 100644
> index 000000000000..4e1bf5ffa2ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-dpu.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sa8775p-dpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SA8775P Display DPU
> +
> +maintainers:
> +  - Mahadevan <quic_mahap@quicinc.com>
> +
> +$ref: /schemas/display/msm/dpu-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sa8775p-dpu
> +
> +  reg:
> +    items:
> +      - description: Address offset and size for mdp register set
> +      - description: Address offset and size for vbif register set
> +
> +  reg-names:
> +    items:
> +      - const: mdp
> +      - const: vbif
> +
> +  clocks:
> +    items:
> +      - description: Display hf axi

AXI

> +      - description: Display ahb

AHB

> +      - description: Display lut
> +      - description: Display core
> +      - description: Display vsync
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: iface
> +      - const: lut
> +      - const: core
> +      - const: vsync
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sa8775p.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interconnect/qcom,sa8775p.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +
> +    display-controller@ae01000 {
> +        compatible = "qcom,sa8775p-dpu";
> +        reg = <0 0x0ae01000 0 0x8f000>,
> +              <0 0x0aeb0000 0 0x2008>;
> +        reg-names = "mdp", "vbif";
> +
> +        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
> +                 <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +        clock-names = "bus",
> +                      "iface",
> +                      "lut",
> +                      "core",
> +                      "vsync";
> +
> +        assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
> +        assigned-clock-rates = <19200000>;
> +        operating-points-v2 = <&mdss0_mdp_opp_table>;
> +        power-domains = <&rpmhpd RPMHPD_MMCX>;
> +
> +        interrupt-parent = <&mdss0>;
> +        interrupts = <0>;

empty line

> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;

empty line

> +            port@0 {
> +                reg = <0>;
> +                dpu_intf0_out: endpoint {
> +                    remote-endpoint = <&mdss0_dp0_in>;
> +                };
> +            };
> +        };
> +
> +        mdss0_mdp_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-375000000 {
> +                opp-hz = /bits/ 64 <375000000>;
> +                required-opps = <&rpmhpd_opp_svs_l1>;
> +            };
> +
> +            opp-500000000 {
> +                opp-hz = /bits/ 64 <500000000>;
> +                required-opps = <&rpmhpd_opp_nom>;
> +            };
> +
> +            opp-575000000 {
> +                opp-hz = /bits/ 64 <575000000>;
> +                required-opps = <&rpmhpd_opp_turbo>;
> +            };
> +
> +            opp-650000000 {
> +                opp-hz = /bits/ 64 <650000000>;
> +                required-opps = <&rpmhpd_opp_turbo_l1>;
> +            };
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

