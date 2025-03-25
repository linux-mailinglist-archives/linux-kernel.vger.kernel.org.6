Return-Path: <linux-kernel+bounces-574637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0BA6E7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0941898D31
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E614D433;
	Tue, 25 Mar 2025 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="fS/TbaFe"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2471448E3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742865186; cv=none; b=GfKqyL6cq+jfY0wJO6mqJ/SfP0r4iiRs0GdQxvaStf44j0JzDtkKdZbIJdeaTLm0QonJwVMpDBWklYXi8Y8GVi3BkIhs7/TOZOb41KnAe46MQS3WsbwNTB7yTCJMHIgla4XnlC2vgTOcMjyRNi+GI2dmJYknH9HCMFl1nyOJsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742865186; c=relaxed/simple;
	bh=59b8GxSKdHIoohtTVvoh6d2qSq20IxVL/ynPTXhEdgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gaJyJzlszC5iQ/CQbczvpHeCVOsY5hez4vhuEixcvd4xV89fmn3rKHFrWwv3Ltlwd6Lh6uvXhsjOpAvfz7p61ukiIoaB8BtRyHVVc1BCLbUhcQpt26mpT0S32q2XxoVK5B/rQvJDt1Jdk0oyAbFLiyF9uu+mZDQ6dzS7lWMNCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=fS/TbaFe; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d571ac3d2fso48238625ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1742865184; x=1743469984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tilX7QnvKAF8sEocr5hjC3RCRlvcCP2GLlCgaOM9mZU=;
        b=fS/TbaFeyrcMwOU69Oifk/aTtztKozl07K1xH4DNdY0LmOgvVJGesuaitLdkPnFQXj
         ostoAvOyzLeLEJ5gZxtwj8IQAP9CYrYpSqz/Cb7VQsm6YIGRPf0YzpBRiWfkPxlcN2L8
         GWmITUYWEkdYPEqIP+xdcRLv2WPgrMDxlJw3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742865184; x=1743469984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tilX7QnvKAF8sEocr5hjC3RCRlvcCP2GLlCgaOM9mZU=;
        b=qI/KqEkCDxK/2eFD/LFY8LHtO67eN9dKI0bo31Q2rpPq4EsEm917ucLZXda50arzJ1
         mcYbtkz4Ep+8UU+oq5MsXQO9VLGmL2LgfPfnER2s8nk4ulZjpQmkBwERhCYbr+2Px2n3
         Kf7wMIbVj/oYtLJ2YgSfoFTZ0sakgQa8HtjExU7tNvwbs07BLBn0MLm6zGnp95Zu9eKn
         DW5icnAcmx10d3B8/kfr0ax99pvGdBTXD6s0Aeewbz4jkERMCaXWU2GZ4FiiHRNTzYJ9
         t0lCm8cdwD40qikO/qUrpvpBn/Og5mH0A6m/LWDnYuCPPyFQq6EOZnRb8xtb3aVpw8OP
         DQLw==
X-Forwarded-Encrypted: i=1; AJvYcCVnJiTs1p6Y6hV6I/RQ+HMoyuSA/ChhUtpNPl+W0mDDTqA2fuVkPVpeGqSHWeBm2rPhucw+RooR+gqEHAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxK4WcoqfFjFdXQBiTqKVl5NLB/1Z0G4Tf5S9yN83RCVZ5xoTh
	3cH1ogyaS7qDPs1on61NevpvUadens4h+8/PkINlSTCEeEQZcljSmpxLCR9znQ==
X-Gm-Gg: ASbGncsSZNQexhzMcdpuduSV989WROgbJg5WIolepDJZcSN2swIECN0SUClxxbOuvGE
	tYcAW8uvtsBCCWeZLD9HFJpP3XTaKl5ol6Le/JCezeEFFZKzUPp+o7D4QUKUDPUsGbPQS0ahXfR
	l3Aj7iCPcuM19cEwHG5UJbfsORkjxcEVC+AZ6DCvwW90g5dfWq64gFpFWxUaZsPvE1kUWLnlzCy
	qjDTjOpg5e8Kkx4uiHilkS/YJXH9k276hkpDx3J0Zg9k13mWdt+vHzpVCNxIYcPtCvHCTQfzU8P
	UV6rkyGAwC77/0DfJk6PtEdiPPhR6eUBKKCZwD2X9I8mTg6F2U1u+Mvk5Y9/MDlqz6gN12nDjew
	E/P7APg/W9+Kt
X-Google-Smtp-Source: AGHT+IGSsAzB0Of7YOYUV68uvoK6ZCJ/6KJgHQicf12+sgaAuVAWuoM864+T45bF4b0vuJZt/1JG6w==
X-Received: by 2002:a05:6e02:3904:b0:3d4:4010:4eff with SMTP id e9e14a558f8ab-3d596164076mr128011515ab.13.1742865183547;
        Mon, 24 Mar 2025 18:13:03 -0700 (PDT)
Received: from [10.211.55.5] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d59606ee04sm20819565ab.6.2025.03.24.18.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 18:13:02 -0700 (PDT)
Message-ID: <5c8fa538-6c04-4fcf-bcad-21fc1e2a0a9b@ieee.org>
Date: Mon, 24 Mar 2025 20:12:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: qcom,ipa: Correct indentation and style
 in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324125222.82057-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250324125222.82057-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/25 7:52 AM, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Looks identical with the exception of the white space change.
Thanks Krzysztof.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   .../devicetree/bindings/net/qcom,ipa.yaml     | 124 +++++++++---------
>   1 file changed, 62 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qcom,ipa.yaml b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> index 1a46d80a66e8..b4a79912d473 100644
> --- a/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,ipa.yaml
> @@ -210,70 +210,70 @@ additionalProperties: false
>   
>   examples:
>     - |
> -        #include <dt-bindings/interrupt-controller/arm-gic.h>
> -        #include <dt-bindings/clock/qcom,rpmh.h>
> -        #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
>   
> -        smp2p-mpss {
> -                compatible = "qcom,smp2p";
> -                interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
> -                mboxes = <&apss_shared 6>;
> -                qcom,smem = <94>, <432>;
> -                qcom,local-pid = <0>;
> -                qcom,remote-pid = <5>;
> +    smp2p-mpss {
> +        compatible = "qcom,smp2p";
> +        interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
> +        mboxes = <&apss_shared 6>;
> +        qcom,smem = <94>, <432>;
> +        qcom,local-pid = <0>;
> +        qcom,remote-pid = <5>;
>   
> -                ipa_smp2p_out: ipa-ap-to-modem {
> -                        qcom,entry-name = "ipa";
> -                        #qcom,smem-state-cells = <1>;
> -                };
> -
> -                ipa_smp2p_in: ipa-modem-to-ap {
> -                        qcom,entry-name = "ipa";
> -                        interrupt-controller;
> -                        #interrupt-cells = <2>;
> -                };
> +        ipa_smp2p_out: ipa-ap-to-modem {
> +                qcom,entry-name = "ipa";
> +                #qcom,smem-state-cells = <1>;
>           };
>   
> -        ipa@1e40000 {
> -                compatible = "qcom,sc7180-ipa";
> -
> -                qcom,gsi-loader = "self";
> -                memory-region = <&ipa_fw_mem>;
> -                firmware-name = "qcom/sc7180-trogdor/modem/modem.mbn";
> -
> -                iommus = <&apps_smmu 0x440 0x0>,
> -                         <&apps_smmu 0x442 0x0>;
> -                reg = <0x1e40000 0x7000>,
> -                      <0x1e47000 0x2000>,
> -                      <0x1e04000 0x2c000>;
> -                reg-names = "ipa-reg",
> -                            "ipa-shared",
> -                            "gsi";
> -
> -                interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
> -                                      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
> -                                      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> -                                      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> -                interrupt-names = "ipa",
> -                                  "gsi",
> -                                  "ipa-clock-query",
> -                                  "ipa-setup-ready";
> -
> -                clocks = <&rpmhcc RPMH_IPA_CLK>;
> -                clock-names = "core";
> -
> -                interconnects =
> -                        <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
> -                        <&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
> -                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
> -                interconnect-names = "memory",
> -                                     "imem",
> -                                     "config";
> -
> -                qcom,qmp = <&aoss_qmp>;
> -
> -                qcom,smem-states = <&ipa_smp2p_out 0>,
> -                                   <&ipa_smp2p_out 1>;
> -                qcom,smem-state-names = "ipa-clock-enabled-valid",
> -                                        "ipa-clock-enabled";
> +        ipa_smp2p_in: ipa-modem-to-ap {
> +                qcom,entry-name = "ipa";
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
>           };
> +    };
> +
> +    ipa@1e40000 {
> +        compatible = "qcom,sc7180-ipa";
> +
> +        qcom,gsi-loader = "self";
> +        memory-region = <&ipa_fw_mem>;
> +        firmware-name = "qcom/sc7180-trogdor/modem/modem.mbn";
> +
> +        iommus = <&apps_smmu 0x440 0x0>,
> +                 <&apps_smmu 0x442 0x0>;
> +        reg = <0x1e40000 0x7000>,
> +              <0x1e47000 0x2000>,
> +              <0x1e04000 0x2c000>;
> +        reg-names = "ipa-reg",
> +                    "ipa-shared",
> +                    "gsi";
> +
> +        interrupts-extended = <&intc GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
> +                              <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
> +                              <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +                              <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "ipa",
> +                          "gsi",
> +                          "ipa-clock-query",
> +                          "ipa-setup-ready";
> +
> +        clocks = <&rpmhcc RPMH_IPA_CLK>;
> +        clock-names = "core";
> +
> +        interconnects =
> +                <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
> +                <&aggre2_noc MASTER_IPA 0 &system_noc SLAVE_IMEM 0>,
> +                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
> +        interconnect-names = "memory",
> +                             "imem",
> +                             "config";
> +
> +        qcom,qmp = <&aoss_qmp>;
> +
> +        qcom,smem-states = <&ipa_smp2p_out 0>,
> +                           <&ipa_smp2p_out 1>;
> +        qcom,smem-state-names = "ipa-clock-enabled-valid",
> +                                "ipa-clock-enabled";
> +    };


