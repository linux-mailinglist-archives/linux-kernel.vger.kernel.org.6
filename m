Return-Path: <linux-kernel+bounces-427907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884E9E0AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB44B2C1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51133209681;
	Mon,  2 Dec 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqmPlnHq"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9B209F26
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154192; cv=none; b=Qzpje2Zmp6oxITdfZaalz50m0fs8pO4ic4E+vI0QX1JkqmgL/ooJsQWQednwq7r7DNx4J6PHWRNN9gvr7j3S1nKwQQGXG5vgCQ4ocjlyyYbmPCQzwLjIpw1VbILM2uTBIO7B7vStNIOQRrabB282t5qtkR5LwTDECtHXtyk5+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154192; c=relaxed/simple;
	bh=k/f3AXTfh4IjLpqTVVBdk7brWdn7oU78wvX2hwXU6+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhMWLtee40ORTeLNSrxpMWvaz+Yx6D6bq5/JrFmeD3gsh6oRaELhAuLnFdOCW3L5jnR/lOtJQsPaH3uHqC4Addn+dcC7dVkM4EOBdeOvUzkGsmZK0Va3FtayBMQy4CIpL5ZKi/CJYujzvrVJoUAFnpP+CLHaV0rNQ7gtB9pMjKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqmPlnHq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso3961428276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733154190; x=1733758990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QbUP+dvKWDKM0wMQ0TznKmY7PM7PyjlXbsmxh8B0to8=;
        b=IqmPlnHqHkx9fZ4PM+jApLoKAxqFgyHu6GrVatp2BwLJ07iS9QBXBVJrZ1CpBcK9ms
         KgHIbGlEBRDZYqOV9hVaNq+l2El+qTmIXDNdLk2r3i8HoJEFgBNi2JzXOArI7dEu212B
         Dpi8RwRQAnxRWXM6NIgh/ahe+nfDCtWUTP/siTnKXuCcv5FQKYYK2FuI4zaWEH1UpIGF
         Pmvvgh+qz/5HNGdLLH20AtP57Kn5ZgfkCQnyKPu2uaENfRMsoKoYmJrZRhWupu18u9ZF
         I/t3OgvNbmWC187Ow7OUC8NCP9lnovuj1xm3Qs8WU8/8rHfuOJsCtKwwWr/sUiX5vF0x
         5Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154190; x=1733758990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbUP+dvKWDKM0wMQ0TznKmY7PM7PyjlXbsmxh8B0to8=;
        b=OQ5OCyAQr8j6sexBy39W5rfdmAeXHm72csoQYZkY7voS932p/ReHuY833GElRoyB2k
         jvMzIr0qrVfftv2Vd8lbtGf75DAJRnLHosNhylOEljfK7QqI8lnEV6DZMQJDzBHGcmRe
         qDtR24zM8ONx40Ca27a31yS3AcHkH9HALfpi3EsNz8l3HQSHM8/BRLl7haGTbwkKpMij
         YLPVjAzq9mr4u2xHXgkaIJ/tKULjcAFhDp8KCTg0VPTc8MoqBxIe0KPCLGq0+HvaW57y
         uBuqVf3+FRFuQfOu9MBVqyClzzID8J7QI4KpYfUnHA4tAIhtL4Ou8o+XimsM7G+8xwQB
         mwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXlKhsWCZ2UG2IaHMn05WFtRuHeoXj283ANWS1k77EJJLd6T+7S3aQvJ0NJxIfLA8T18/qLtqmkAAHDUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKs2oa+gpB+3qLOf45d9AjkMeeV4Ci0dDMS3di3eVMDibTPk8
	I9hZ00jcIMYuD71xvUZwbXd9OSAd+5QBfQXbqEPo0/Sbc4144NZoPxsHuBamWlQkBtUi+xL5fgc
	rZDHdvyhBK4Ze5E3hPfcM6CjEEWN1KyFmXKHhbA==
X-Gm-Gg: ASbGnctINNOk5P7qjiz4mb0sGAnEzmz/mAefMSBwyPZPD73YjgNjmoBJv2g5tdKX69S
	Q+8E840glrlMQo9b2fJHaZumN66Qf1dxW
X-Google-Smtp-Source: AGHT+IGP8X//RtopJ14zcmxJJXKBWB66Fq15r096151qIaf1u6T7kK82VeRXbbWQnNMTUe+do88W/Mt9VjkNBUNU2jY=
X-Received: by 2002:a05:6902:2804:b0:e2e:440e:d29f with SMTP id
 3f1490d57ef6-e395b8939bdmr23346211276.20.1733154190066; Mon, 02 Dec 2024
 07:43:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
In-Reply-To: <20241202151228.32609-1-ansuelsmth@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:42:33 +0100
Message-ID: <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Document required property for Airoha EN7581 CPUFreq .
>
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> to ATF and no clocks are exposed to the OS.
>
> The SoC have performance state described by ID for each OPP, for this a
> Power Domain is used that sets the performance state ID according to the
> required OPPs defined in the CPU OPP tables.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v4:
> - Add this patch
>
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
>  1 file changed, 259 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> new file mode 100644
> index 000000000000..a5bdea7f34b5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml

[...]

> +examples:
> +  - |
> +    / {
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
> +                clocks = <&cpufreq>;
> +                clock-names = "cpu";
> +                power-domains = <&cpufreq>;
> +                power-domain-names = "cpu_pd";

Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
indicate it's a power-domain with performance scaling support.

> +                next-level-cache = <&l2>;
> +                #cooling-cells = <2>;
> +            };
> +

[...]

Other than the very minor thing above, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

