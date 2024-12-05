Return-Path: <linux-kernel+bounces-433625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03A9E5AC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7DDE28804C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E021CA1B;
	Thu,  5 Dec 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VtFKL0JX"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9701E1CD2B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414869; cv=none; b=uJaJdUWT+eWxSKMQa7/e5KmgUb/nPnnFjXvPYLed/vkA2AfO0ktWQoWM+1eSfUWn/L5Urrxsn57Z2L9fl4Eme0W+Yg75pY4Vh5/8ubn6a/LV7ri6whSCYoclD06Q4XzLTNVV6zQbbyJOJaCkQPfeyo3OsDQ73ZDJFZLqa8AxLUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414869; c=relaxed/simple;
	bh=bS1AiJeyV1FdE50S5p/ntCiwbSksmeWWJTfmSZhcetw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYn5t0G3wr8WKS9OguuxOC9bxH2qpeY2OEqbgi7EsWk6VUHjkFCLDqSCTPIUdOB2wGFLGCcIAXtJF+S/Vk3GvKb6xexqmo4fkhoLu0ouyg+vFIzirG1EnXlcKG4oenjMmTW0sqKhZKa+Y/I1oTcLrIA1VP7DOvgk9goLlVN0/Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VtFKL0JX; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0d71d7f00so1658788a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733414865; x=1734019665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+V7m48apPBjAuCJ6fyNfCURcukhtBD0FGIuBJwZd0c=;
        b=VtFKL0JXs0WtMuj1f6TSF+LyW0w6KgCrV3BIF12WAtUwuPvR6SDVE2li8c5iGuzEBO
         JFS+nhoY9LnONE+6CHg9HGiqvwAc3GBoBa/RXGgsQ1NBJr07b9qgsNiMsWyU8fWCF5AL
         XAt/Y5Jw8MlYehR2o3PZiQyxodAmrTy22ZO2mIvrhiW0qNRN/MPIQOOpiBDcmgtqF3cK
         RbrPCH+Cgd1P7ic1WrhUU8WC2mor4br0WK9UM1y/yskO7ch4ZEXdE5EKBM7nm8uiKXnL
         /2u2zE6iOM/CEUh5xtC451mclQVdO6BWtS2lS7sGW9oKcmxQ40MUsBo0WdQPCJhm3NC0
         MPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733414865; x=1734019665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+V7m48apPBjAuCJ6fyNfCURcukhtBD0FGIuBJwZd0c=;
        b=ZdPdzs/MpJ4P2FjDPwsNVJwou4larwFspzm4qaeGdzzBZ8zjjZFN8Ek8p9DibB+7sg
         dGghvHbQ7OvjWEq87NInfun/GYFBXYLqZmth87CJLZtoIcopcsTPzdo1x9XJAXtWTtt3
         CWDk77tfkFhjTRe+eix7YVPpHaZjN2tmHZhFrXLWcjZvOqTnj2ceiGEK09aJh7bY4QdB
         bPRJ6ipSs8XenemZYSn7XMyPad8MIboPLMu0zuTTJ3J+04Fd94tkAakY4FHNuhIHBB7G
         X5+FBSAea9hsOW34kRaLUK9nDfePZEO5d7+A0P1bKd8F5KqQcFCuQCjpDR8+ZSqkBFAg
         MTiw==
X-Forwarded-Encrypted: i=1; AJvYcCXkdot//Xr8DiSZ7CoDDNfYcHysJg536CLN6nZz7It1Wb9ZgTjUtVEieg4XhrzwwGb+967qbbCtc+RCEGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuSR3M2JVfwbR7MZjy/nOe8lJCbLe0DRnbrTtiDWEcYVoCC5F
	gDSrOU2BUSePCrNqGlscW+u3mj64uH6cWtyuw47QStBWqJ4k3CGSemSFaVvSD65AGalnRAktP5V
	a/WXw3uFDhJMbYJ8N8X2ppvQoHBkMTeG++7IHFJMJuwt9v4w5
X-Gm-Gg: ASbGncvGEs5KyIZsj8dFSB5hEbewUXjw0DxjTm9OVvmBoW2y+Jcfp1NkuGXQRWI4s1y
	3allTWxgA3gnHGBRVCSw4M6AbAtRM1ezlrgS3PqNlKNnlNrW8xiz7Dljr5O7iu5NVTA==
X-Google-Smtp-Source: AGHT+IGrEDZp6sJ4+Bu2mkylebWpYdSyYAxZtnULPylirbVqfrRu6SF8zr3etJzVy0DqT1d10gEiV+p5oLfQq079TOk=
X-Received: by 2002:a17:906:2189:b0:aa6:1aaf:87e3 with SMTP id
 a640c23a62f3a-aa61aaf8da4mr439853466b.2.1733414864813; Thu, 05 Dec 2024
 08:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204182323.15192-1-ansuelsmth@gmail.com>
In-Reply-To: <20241204182323.15192-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Dec 2024 17:07:07 +0100
Message-ID: <CAPDyKFqq03OnRoUiJkczbNFH4EHO6cFJkwTasdEzVSwDdxqUzg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Dec 2024 at 19:24, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Document required property for Airoha EN7581 CPUFreq .
>
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> to ATF and no clocks are exposed to the OS.
>
> The SoC have performance state described by ID for each OPP, for this a
> Power Domain is used that sets the performance state ID according to the
> required OPPs defined in the CPU OPP tables.

To clarify this, I would rather speak about a performance-domain with
performance-levels, where each level corresponds to a frequency that
is controlled by the FW/HW.

>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes v6:
> - No changes
> Changes v5:
> - Add Reviewed-by tag
> - Fix OPP node name error
> - Rename cpufreq node name to power-domain
> - Rename CPU node power domain name to perf
> - Add model and compatible to example
> Changes v4:
> - Add this patch
>
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 262 ++++++++++++++++++
>  1 file changed, 262 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> new file mode 100644
> index 000000000000..7e36fa037e4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> @@ -0,0 +1,262 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/cpufreq/airoha,en7581-cpufreq.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 CPUFreq
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |
> +  On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> +  to ATF and no clocks are exposed to the OS.
> +
> +  The SoC have performance state described by ID for each OPP, for this a
> +  Power Domain is used that sets the performance state ID according to the
> +  required OPPs defined in the CPU OPP tables.
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-cpufreq
> +
> +  '#clock-cells':
> +    const: 0

I think Rob questioned this too. Why do we need a clock provider here?

If this is only to keep the CPUfreq DT driver happy, I think this
should be dropped. There is only a performance-domain here, right?

> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +  operating-points-v2: true
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> +  - '#power-domain-cells'
> +  - operating-points-v2
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    / {
> +        model = "Airoha EN7581 Evaluation Board";
> +        compatible = "airoha,en7581-evb", "airoha,en7581";
> +
> +        #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +        cpus {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x0>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu1: cpu@1 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x1>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu2: cpu@2 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x2>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +
> +            cpu3: cpu@3 {
> +                device_type = "cpu";
> +                compatible = "arm,cortex-a53";
> +                reg = <0x3>;
> +                operating-points-v2 = <&cpu_opp_table>;
> +                enable-method = "psci";
> +                clocks = <&cpu_pd>;
> +                clock-names = "cpu";
> +                power-domains = <&cpu_pd>;
> +                power-domain-names = "perf";
> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +        };
> +
> +        cpu_opp_table: opp-table-cpu {
> +            compatible = "operating-points-v2";
> +            opp-shared;
> +
> +            opp-500000000 {
> +                opp-hz = /bits/ 64 <500000000>;
> +                required-opps = <&smcc_opp0>;
> +            };
> +
> +            opp-550000000 {
> +                opp-hz = /bits/ 64 <550000000>;
> +                required-opps = <&smcc_opp1>;
> +            };
> +
> +            opp-600000000 {
> +                opp-hz = /bits/ 64 <600000000>;
> +                required-opps = <&smcc_opp2>;
> +            };
> +
> +            opp-650000000 {
> +                opp-hz = /bits/ 64 <650000000>;
> +                required-opps = <&smcc_opp3>;
> +            };
> +
> +            opp-7000000000 {
> +                opp-hz = /bits/ 64 <700000000>;
> +                required-opps = <&smcc_opp4>;
> +            };
> +
> +            opp-7500000000 {
> +                opp-hz = /bits/ 64 <750000000>;
> +                required-opps = <&smcc_opp5>;
> +            };
> +
> +            opp-8000000000 {
> +                opp-hz = /bits/ 64 <800000000>;
> +                required-opps = <&smcc_opp6>;
> +            };
> +
> +            opp-8500000000 {
> +                opp-hz = /bits/ 64 <850000000>;
> +                required-opps = <&smcc_opp7>;
> +            };
> +
> +            opp-9000000000 {
> +                opp-hz = /bits/ 64 <900000000>;
> +                required-opps = <&smcc_opp8>;
> +            };
> +
> +            opp-9500000000 {
> +                opp-hz = /bits/ 64 <950000000>;
> +                required-opps = <&smcc_opp9>;
> +            };
> +
> +            opp-10000000000 {
> +                opp-hz = /bits/ 64 <1000000000>;
> +                required-opps = <&smcc_opp10>;
> +            };
> +
> +            opp-10500000000 {
> +                opp-hz = /bits/ 64 <1050000000>;
> +                required-opps = <&smcc_opp11>;
> +            };
> +
> +            opp-11000000000 {
> +                opp-hz = /bits/ 64 <1100000000>;
> +                required-opps = <&smcc_opp12>;
> +            };
> +
> +            opp-11500000000 {
> +                opp-hz = /bits/ 64 <1150000000>;
> +                required-opps = <&smcc_opp13>;
> +            };
> +
> +            opp-12000000000 {
> +                opp-hz = /bits/ 64 <1200000000>;
> +                required-opps = <&smcc_opp14>;
> +            };
> +        };
> +
> +        cpu_smcc_opp_table: opp-table-smcc {
> +            compatible = "operating-points-v2";
> +
> +            smcc_opp0: opp-0 {
> +               opp-level = <0>;
> +            };
> +
> +            smcc_opp1: opp-1 {
> +                opp-level = <1>;
> +            };
> +
> +            smcc_opp2: opp-2 {
> +               opp-level = <2>;
> +            };
> +
> +            smcc_opp3: opp-3 {
> +               opp-level = <3>;
> +            };
> +
> +            smcc_opp4: opp-4 {
> +                opp-level = <4>;
> +            };
> +
> +            smcc_opp5: opp-5 {
> +                opp-level = <5>;
> +            };
> +
> +            smcc_opp6: opp-6 {
> +               opp-level = <6>;
> +            };
> +
> +            smcc_opp7: opp-7 {
> +               opp-level = <7>;
> +            };
> +
> +            smcc_opp8: opp-8 {
> +                opp-level = <8>;
> +            };
> +
> +            smcc_opp9: opp-9 {
> +               opp-level = <9>;
> +            };
> +
> +            smcc_opp10: opp-10 {
> +                opp-level = <10>;
> +            };
> +
> +            smcc_opp11: opp-11 {
> +                opp-level = <11>;
> +            };
> +
> +            smcc_opp12: opp-12 {
> +                opp-level = <12>;
> +            };
> +
> +            smcc_opp13: opp-13 {
> +                opp-level = <13>;
> +            };
> +
> +            smcc_opp14: opp-14 {
> +                opp-level = <14>;
> +            };
> +        };
> +
> +        cpu_pd: power-domain {

Nitpick: We could use the name *performance-domain* here instead, that
would make it even more clear what this node describes.

> +            compatible = "airoha,en7581-cpufreq";
> +
> +            operating-points-v2 = <&cpu_smcc_opp_table>;
> +
> +            #power-domain-cells = <0>;
> +            #clock-cells = <0>;
> +        };
> +    };
> --
> 2.45.2
>

With those changes I am still happy with this approach, so feel free
to keep my Reviewed-by tag.

Kind regards
Uffe

