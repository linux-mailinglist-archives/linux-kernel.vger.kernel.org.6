Return-Path: <linux-kernel+bounces-372373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB719A47CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B021C21B06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FD205ACD;
	Fri, 18 Oct 2024 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmmm2Q83"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10F18C34D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282971; cv=none; b=ivbx4OHh/JMKGoL7y17D0OUWeHc408lxAtC7wSgkRjHcZ/KxXYXImyXL9CGrhyp3wy+aWd2fVLnxEJY1rhdaInqHngFyQMO7E/5pBMGAfImXPy1WYDrAFe2obxTPrgdA92KUx/i5EKcf3G0UQHFV+dGpAjObIdxnlsdhftHdWcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282971; c=relaxed/simple;
	bh=zA6sAGlmcsssfbHFHpdufD4jFViwc4hJ+qdlDWdA+ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbLSWboYy1+iCUqa5WH/5Kjg5ATqJe8b0cTwgfnBsV4KQa2bcV/eg+98BuhYjxgaLuY/atUgMmXBAwzaNzWGIdICNIO8BrR3vnaouVpZ3y5wAD4T+Dr4fhqNVi9KhKWWAL6ELbuF1OsF8aFt6D3C41jiiMj2Mu/CWHGkoI608lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tmmm2Q83; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso30133871fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729282966; x=1729887766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v6REwNIJhYaMRZTlPZFBNngTOjTKL4C0pCHHanFLiQM=;
        b=tmmm2Q83Ex1r8w75GH9gX9ooJ+E/ggD0+qKSQW4CP1Cevqgp9WXIg1ZlxuRcLAsy15
         vB+Xai1yjthtnY8Mtn9fJiZ28/G3Y7VhK3s+CRwWEFnOgSuUvEG9+UFEa9rRqXMvd63L
         nZWsrvHo8Tu9bb9sE+awR0R6kPDj5tuwB+jx41d8cetpQ9W3WFklQmM3LFs9xFyBK4rc
         /kySbSpUKq6oE4bBfJjXQBX62ViVaFQTakfpzqIbBvOaPWKcqyz57VvnLEr8pcYPUu4N
         4YyHwoiXg+7BZwkEJXGIxIyXYleALG6oLRjJbkKZTatJgPE8Ba6hPFTN9BNWy7TBxioe
         9KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729282966; x=1729887766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6REwNIJhYaMRZTlPZFBNngTOjTKL4C0pCHHanFLiQM=;
        b=Ut+7ZoqD8esgYQH0uCP81N/bu0Uq8MqZCyn+C/vFI9Bd7zbF49/UaMswN/Zend0iqh
         uVFw0FJkJ5aoTYbKY/cBnp38zKpOAvtrLe/vAJPwQX/dFKuL3a1ZxuWLO3JRf1rkjhYd
         zIk7y6FJDHFkX8lfGEtsFYyTLcE16sh5a/ae9CdhXHFog3J4fYU0P8iEdyhgAGr+awjh
         aXyL4+FFlQNr28P0bkuMDOlZTIPzht3QZ4rkKuxyZ9EeoIjgNd8zovOofWzs7qE9Nqww
         y0Nn2LlEglSOahrgrX+mqifoDIn5DcUk9cXC7xoh5H4cvtdu8juswhQldYJfHGl80IFz
         AxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfg8B6PwpKh3CSA6yu09FcTJ5vhHI/cLtrr2JE4t6AJmIw6tebd/kINAR97R4vO+LXDH3dFP45VFOtZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrcBLePbkNIz6FOxRInQyl/KR0QfBjZIyes7xRSnO7E/BkPn0
	Is9FiBdPtrzdWl+eQmbnwtL/1OkZl/ub8Jl/I7a+WhPL/To8fhjGO2xd9c05JGM=
X-Google-Smtp-Source: AGHT+IH/AY6GEGMQZHw2wLQvEVWlWfajQiWIOTSCuRjlgslgw34A6iVSxQUE0RsRM9/nr1mz4MO7fA==
X-Received: by 2002:a05:6512:3a8d:b0:536:7362:5923 with SMTP id 2adb3069b0e04-53a1520b285mr2532574e87.1.1729282966538;
        Fri, 18 Oct 2024 13:22:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211ac9sm312958e87.252.2024.10.18.13.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:22:46 -0700 (PDT)
Date: Fri, 18 Oct 2024 23:22:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Abhishek Sahu <absahu@codeaurora.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/11] clk: qcom: camcc-qcs615: Add QCS615 camera clock
 controller driver
Message-ID: <f5exjvacw4gz7s7byxz6aux7jt3kczn5waio3f3dukpdvzmkvi@c65xjssv4aqy>
References: <20241019-qcs615-mm-clockcontroller-v1-0-4cfb96d779ae@quicinc.com>
 <20241019-qcs615-mm-clockcontroller-v1-4-4cfb96d779ae@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-qcs615-mm-clockcontroller-v1-4-4cfb96d779ae@quicinc.com>

On Sat, Oct 19, 2024 at 12:45:40AM +0530, Taniya Das wrote:
> Add support for the camera clock controller for camera clients to
> be able to request for camcc clocks on QCS615 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |   10 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-qcs615.c | 1588 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1599 insertions(+)
> 

[...]

> +
> +static struct gdsc bps_gdsc = {
> +	.gdscr = 0x6004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "bps_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc ife_0_gdsc = {
> +	.gdscr = 0x9004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "ife_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc ife_1_gdsc = {
> +	.gdscr = 0xa004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "ife_1_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};

Shouldn't IFE GDSCs have titan_top as a parent?

> +
> +static struct gdsc ipe_0_gdsc = {
> +	.gdscr = 0x7004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "ipe_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> +};
> +
> +static struct gdsc titan_top_gdsc = {
> +	.gdscr = 0xb134,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.pd = {
> +		.name = "titan_top_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +

-- 
With best wishes
Dmitry

