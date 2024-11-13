Return-Path: <linux-kernel+bounces-407612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6C9C7054
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3F03B28346
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67431179954;
	Wed, 13 Nov 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efIva08s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEC6088F;
	Wed, 13 Nov 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502649; cv=none; b=DVea0CmVBcRYPkBAxCUuuhQoBfDgbkNXXfd3G1a8acbcQ7b/YREib3vOjxbnHkKcFJtu0W3rrQzuTYtOg5uYJZi8O50Qs+vG2LShfdLLgyayDVoCYwgKqlOJ3lQsq0S5Pa2vWKl3F2tYAX+rBHMU/Q8UcotSY5jLb6IUis4n6ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502649; c=relaxed/simple;
	bh=kufeckISsNhYdD+EXqrcRBtcik7Z28DuIhzYM013Ouo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz0ewgjND3xPD7ezoAQZczdPQ61fu2Y1sl225KdwGSZy2TpkceT8s5saF8OTjN5o7kmZWvW5Llj8nH1eGgm1vKP+xDalhgyu/pHFG/AySjvfjtFWfCCh9S9WwroXMrIYV34Z2eHcBNOoMhlBqjuDzEf8b15wd3gAaSMfRmgnOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efIva08s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A587C4CECF;
	Wed, 13 Nov 2024 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731502649;
	bh=kufeckISsNhYdD+EXqrcRBtcik7Z28DuIhzYM013Ouo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efIva08sMQZ4IhNeVQ3ER804zEMIRhL+uoDBCR5d83GeYtLIDQDA1gLCN+HGNu4HI
	 QPyiZmlh0sKX++ofC5gJIx3KZHzlbZCxfEfqkf3IuBgIFYNiT3pwr++3Zit+EY+hrC
	 kBWJzOZpOrj4lUm8H1h68Iity0E7OKMJxadm2vIMP4kAdCiLCIqFEOFo4LBsznYRTP
	 YZ6t1F0m12tqhosGnO4aW7CbEWYK5isYNxeZuVW9T9NNqR0Ab0wUphrQFCQQbUtZqh
	 PQhTqOtBmJn2ZC5hhIKTON3EoQIPFH9UxoZrLEYpcQqZfvU1Hq4kY3lQVjABJ0ceo2
	 AVxwkHGYF2ZKg==
Date: Wed, 13 Nov 2024 13:57:23 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] firmware/psci: Allow specifying an S2RAM state
 through CPU_SUSPEND
Message-ID: <ZzSiM6Pn6A9e1QUD@lpieralisi>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
 <20241028-topic-cpu_suspend_s2ram-v1-3-9fdd9a04b75c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-3-9fdd9a04b75c@oss.qualcomm.com>

On Mon, Oct 28, 2024 at 03:22:59PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Certain firmware implementations (such as the ones found on Qualcomm
> SoCs between roughly 2015 and 2023) expose an S3-like S2RAM state
> through the CPU_SUSPEND call.
> 
> This works exactly like SYSTEM_SUSPEND. The PSCI spec describes that
> call as optional (and only introduced in PSCIv1.0), so not all
> platforms expose it.
> 
> Marking a DT-described "domain-idle-state" as such isn't currently
> well accounted for in the PSCI idle topology infrastructure: the
> cpuidle and genpd framework are deeply intertwined, and trying to
> separate them would cause more havoc than good.

I don't understand what you mean here please elaborate.

The part of the story I understand is that you have a system (well,
firmware for an extended set of systems) that does not implement
SYSTEM_SUSPEND but can reach a S2R like system state through the
CPU_SUSPEND call. Firmware works in OS-initiated mode, idle-states
should allow you to define idle states that allow the system to
enter the S2R state through CPUidle.

Please explain to me what's missing.

> Instead, allow the specifying of a single CPU_SUSPEND sleep param
> under the /psci node that shall be treated exactly like SYSTEM_SUSPEND
> from Linux's POV. As a bonus, this way we also don't have to fight
> with the genpd idle governor to avoid taking the S3-like state into
> consideration.

That's not acceptable. I want to understand what's preventing this
system to enter that state through suspend2idle and the mainline code.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/firmware/psci/psci.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)

NACK

> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 0e622aa5ad58bbe69dfc3a71bced597618e73f15..20ae6a6d59a9f276db75260b6ca1a5827e443782 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -78,6 +78,7 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void)
>  
>  static u32 psci_cpu_suspend_feature;
>  static bool psci_system_reset2_supported;
> +static u32 psci_s2ram_suspend_param;
>  
>  static inline bool psci_has_ext_power_state(void)
>  {
> @@ -519,10 +520,10 @@ static int psci_system_suspend_begin(suspend_state_t state)
>  	return 0;
>  }
>  
> -static const struct platform_suspend_ops psci_suspend_ops = {
> -	.valid          = suspend_valid_only_mem,
> -	.enter          = psci_system_suspend_enter,
> -	.begin          = psci_system_suspend_begin,
> +static const struct platform_suspend_ops psci_system_suspend_ops = {
> +	.valid = suspend_valid_only_mem,
> +	.enter = psci_system_suspend_enter,
> +	.begin = psci_system_suspend_begin,
>  };
>  
>  static void __init psci_init_system_reset2(void)
> @@ -545,7 +546,7 @@ static void __init psci_init_system_suspend(void)
>  	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
>  
>  	if (ret != PSCI_RET_NOT_SUPPORTED)
> -		suspend_set_ops(&psci_suspend_ops);
> +		suspend_set_ops(&psci_system_suspend_ops);
>  }
>  
>  static void __init psci_init_cpu_suspend(void)
> @@ -673,6 +674,17 @@ static int __init psci_probe(void)
>  
>  typedef int (*psci_initcall_t)(const struct device_node *);
>  
> +static int psci_cpu_suspend_s2ram_enter(suspend_state_t state)
> +{
> +	return psci_cpu_suspend_enter(psci_s2ram_suspend_param);
> +}
> +
> +static const struct platform_suspend_ops psci_cpu_suspend_s2ram_ops = {
> +	.valid = suspend_valid_only_mem,
> +	.enter = psci_cpu_suspend_s2ram_enter,
> +	.begin = psci_system_suspend_begin,
> +};
> +
>  /*
>   * PSCI init function for PSCI versions >=0.2
>   *
> @@ -686,6 +698,20 @@ static int __init psci_0_2_init(const struct device_node *np)
>  	if (err)
>  		return err;
>  
> +	/*
> +	 * Some firmwares expose S2RAM entry through a custom suspend param.
> +	 *
> +	 * If found, register a suspend handler instead of registering the
> +	 * idle state with cpuidle.
> +	 */
> +	err = of_property_read_u32(np, "arm,psci-s2ram-param", &psci_s2ram_suspend_param);
> +	if (!err) {
> +		suspend_set_ops(&psci_cpu_suspend_s2ram_ops);
> +	} else if (err != -EINVAL) {
> +		pr_err("Couldn't read the S2RAM PSCI suspend param: %d\n",
> +		       psci_s2ram_suspend_param);
> +	}
> +
>  	/*
>  	 * Starting with v0.2, the PSCI specification introduced a call
>  	 * (PSCI_VERSION) that allows probing the firmware version, so
> 
> -- 
> 2.47.0
> 

