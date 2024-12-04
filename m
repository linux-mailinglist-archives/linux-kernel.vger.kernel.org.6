Return-Path: <linux-kernel+bounces-430574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B89E3317
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57343166C37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17529185949;
	Wed,  4 Dec 2024 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gl4Xng5u"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4A171658
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733290336; cv=none; b=dyX1MRm2djhGJJej7Zl75PsMgyC3r1CF8mbl5j7+DpP/u/QHD3C7BaJ0lJwFxl1ZfngstsOuawNLlfZTm/khBSZ2v1EGkguTT7+xGWEMbCjfRoQIwJ6k3qJxobet2b3BaL3YXdw9hvwEOkbpN9v1QlsDiXuoZhF6hQ+I+56bP6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733290336; c=relaxed/simple;
	bh=7yzDt2THE5UiqFlbGqXqjqL/3debzqNeA00lnjfD6RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgDrTu5m4GbGcN/6PZcqKIvSJ4HPG8eg2ENuGnUHqP2c5tGQVR43/xipZZK5CyTf3ZhpqElCFefORYGhaVcdEJoL/byt9tBITJGoOWTKLD6Sfan80SKOEP7iemCkGpTXxmSRLYHPADU/jGOg0EAhsvh77ixiYzbyvoO1iEVjMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gl4Xng5u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21572ca3cccso32277495ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 21:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733290334; x=1733895134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xH+XGfz/MFflVGjWhhbYcbFyLOKyHtqNKF1p6JTm9o=;
        b=gl4Xng5u+KyebJym4yGuyIFGO51WJHaDqkq1AhrFE5E44nz4QSBmfRZEhh4I2NVxqW
         iMn/uuoaqfOW2X27o+JeZn7kTy+QJZ98uDtv1Yi9yqvOBtApxC6EwWE0u8C3zand7IyT
         9A+UhUsG7b4NucWZ4bFe+md1nkN7aONV5imKtAvVFsB0dMjOHvWWLNxHs5AogkOXhDot
         m0ZP0qSAimjMYUJDCtvKic1ctJdeMJ505sfwCamgBRvFKi/cI7j5KrdBB0e+/Uv+lYCI
         V4UjpnSJxUU4pQsjRtmzjbOfFCtqNtmP25UMnKhQeMaWhXFQM/59lNdHD7HU0vSr+dDL
         HiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733290334; x=1733895134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xH+XGfz/MFflVGjWhhbYcbFyLOKyHtqNKF1p6JTm9o=;
        b=gkyybxZOgukw0w0fzAP4JXrpgiccvCgEqw8G5nLYZ2fcX6eh5ngu+FZ+YqtuYQEb5H
         HTh5dM4KLJUVBAfX5dLL2bfnCydJZlOPndFWqegbf7b7l1bJYFDdJlAmboeismLneV7n
         DCi+J4qeFWSaf+oIDD7UbMZ2kBFZeb1N/4EKzCVcO2v5dqcVwRjyTneo6PzB6/i8HWQC
         oHmroxY7hiAgYGF0avixYDgLzwLI+q6Mu1KmvXwCQ+L9kRAXMKUiGNCHsHIOF94nGqH0
         88GNuKd3bkqvzyqeDDGK6fR7+ssEujdCtm/xkKZRhSr2DR8ITsKrgNuYvfpus4ko0ser
         4BeA==
X-Forwarded-Encrypted: i=1; AJvYcCXm+p4btYPV4dC/nClzQBQBfQExPK2VYf67hFi5UMvcRThky7IHlVkCVTr8Hl/k1bCvaA6fqVlRvaY0zlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvKG9AD48SiMZMTQ2U3Y0IvpSf9C8kc5xEiFfijR51aCZihD4
	bd51kP2bVrE6IPY9BIxdvG0B8q8z7WoNpfUXchy3DvPcNn5Mju6tlGJr/madbWk=
X-Gm-Gg: ASbGncskk1WHX+wH+z88wgUwl9OxTPY5P09mjNC7c+WBcYF8UHkeiSnxtufeNyTnWCD
	bvNxH6afYv7RgMUI26l2l4dAA0vg2ikOgS4c2rR6LCPXupFFKsbgMqG+yMjT7eLZR7sv1k8gkKE
	0srAZePv3kbcz/1HveuEphwZciT7SaxoQg4OfCzRxDqFLNgTgBB9nVLT8PmYUI9eTckVFsr5zlg
	pVejqTTBivTdwr97nxQD2xp3v8yaMynkaceK16BFeZ8GRLyi2qT
X-Google-Smtp-Source: AGHT+IHI2jzyqH0buZt4jEgwjAnflBCcsEvaoj9C3brK3XgP4S7w4dRM1Ni3AlMJnPowOpakPzhdzg==
X-Received: by 2002:a17:902:da81:b0:215:5d43:6f0e with SMTP id d9443c01a7336-215bd24af1cmr62921975ad.41.1733290334226;
        Tue, 03 Dec 2024 21:32:14 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215b08965b4sm28711185ad.180.2024.12.03.21.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 21:32:13 -0800 (PST)
Date: Wed, 4 Dec 2024 11:02:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v5 2/2] cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver
Message-ID: <20241204053211.6gdogcpi4g3eavw5@vireshk-i7>
References: <20241203163158.580-1-ansuelsmth@gmail.com>
 <20241203163158.580-2-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203163158.580-2-ansuelsmth@gmail.com>

On 03-12-24, 17:31, Christian Marangi wrote:
> diff --git a/drivers/cpufreq/airoha-cpufreq.c b/drivers/cpufreq/airoha-cpufreq.c
> +struct airoha_cpufreq_priv {
> +	struct clk_hw hw;
> +	struct generic_pm_domain pd;
> +
> +	int opp_token;
> +	struct dev_pm_domain_list *pd_list;
> +	struct platform_device *cpufreq_dt;
> +};
> +
> +static long airoha_cpufreq_clk_round(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *parent_rate)
> +{
> +	return rate;
> +}
> +
> +static unsigned long airoha_cpufreq_clk_get(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	const struct arm_smccc_1_2_regs args = {
> +		.a0 = AIROHA_SIP_AVS_HANDLE,
> +		.a1 = AIROHA_AVS_OP_GET_FREQ,
> +	};
> +	struct arm_smccc_1_2_regs res;
> +
> +	arm_smccc_1_2_smc(&args, &res);
> +
> +	/* SMCCC returns freq in MHz */
> +	return (int)(res.a0 * 1000 * 1000);

Why casting to "int" when we can return ulong ?

> +}
> +
> +/* Airoha CPU clk SMCC is always enabled */
> +static int airoha_cpufreq_clk_is_enabled(struct clk_hw *hw)
> +{
> +	return true;
> +}
> +
> +static const struct clk_ops airoha_cpufreq_clk_ops = {
> +	.recalc_rate = airoha_cpufreq_clk_get,
> +	.is_enabled = airoha_cpufreq_clk_is_enabled,
> +	.round_rate = airoha_cpufreq_clk_round,
> +};
> +
> +static const char * const airoha_cpufreq_clk_names[] = { "cpu", NULL };
> +
> +/* NOP function to disable OPP from setting clock */
> +static int airoha_cpufreq_config_clks_nop(struct device *dev,
> +					  struct opp_table *opp_table,
> +					  struct dev_pm_opp *opp,
> +					  void *data, bool scaling_down)
> +{
> +	return 0;
> +}

I wonder whats better here. Provide this helper or provide a dummy clk-set-rate
at the provider itself ?

-- 
viresh

