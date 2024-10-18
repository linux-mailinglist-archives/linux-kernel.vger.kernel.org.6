Return-Path: <linux-kernel+bounces-372248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25769A463E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16AD1C22D82
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631C317DFF2;
	Fri, 18 Oct 2024 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKjg7ysV"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545FA204F86
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277196; cv=none; b=e3KAh+J7291fAOpY4QWcihZmPs8Xl52/DcUhGKZvFmrFExdCPkx+tD5IP8c0lkzVdwMQL19kFk5uKyBYr7oECYco2Z1bAK3saCHj7Km3PAU8DlcYC7isTV+pZxAl8UJgYxCFE0hxInrsjj2TDOZAJRVWEMPsWK+kHn4i9atNtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277196; c=relaxed/simple;
	bh=iiF/iqYRiu45yTxffz/ijQIZQ8eLEifGJ+mn4QK66qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLtEiuIYctNIHdP9wqk5J3nZ+1CU5xDd5d69ylGhKeoiVaBk9lARxK9Q5FA2hutLF5u5EOuvF0GWdPk/E/3hnOH5BB0iR2ObEDXiPqWd7QdO0HlPKdSmhQLsTfnM5E65uCHOR4b5VoXAU1H/gqN+neYLXtBz/JK9w9GgOIVhv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKjg7ysV; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e8586b53so2924185e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729277192; x=1729881992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qySaWXXkrwmDT03ehuJXVekr/k61K5MvAp+B5Hja0FU=;
        b=tKjg7ysVy0x9vvWpW3CfD67rSGcXoQf9pngWY3tTk3mr8oTFI6VAaaLBXdOAYJUuIh
         WJi1Gbf3gelwAjgCTo7YGJzO3JoJ8DSQqr0jXLM4EvrK2klO4T9O5J2ZV2T8OLP3Mxuy
         DItmACEwUjFRUfSN9drYjjFVwH96muvGO8MGQlf/N04U8HGf9g7GU7bcE+tl995xaqU3
         QNP3YJKE2Ba9zb0weMRPLB57bNgROl+Efa3x6FY/bZHhD4jhZq88vUYwzDzgt670AsTX
         gNGdx0Uw48x5cX/wbzu7uG5j12a4IpdoYLX+2qC0H9Au16cdP1hoPp1bK6Tb5f6lym9C
         stng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729277192; x=1729881992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qySaWXXkrwmDT03ehuJXVekr/k61K5MvAp+B5Hja0FU=;
        b=btlRjz07SHbmehw2fMK/Ku++GSZW72OSTyTIk+A3ulmYy73R56+YpIQ9d9pqN5vyiM
         bVAcl7LWetiwtC+hFqXmj1bZRpG6MzFhZEKR+B/X5xTOvk4I8sG3UD6oAi+EJtpGGdg8
         47wxMId5okZKD/UuKnrXDhIInYL85JR2H5vsJLLz+jprmRaDUG0adUjiZtdyrHahMr8E
         u197ey7tBxA3akIZEks2VbubH/eC/9MM/rf/yK99Okpjn/sdjQw6nFB2Zvanfj4eT5LM
         WbagDF9iCZrnrB/9WSa3WECOZkCSifgod1V+Hgm5/19t5PLClZNu1X45qwiAjBi3GjUo
         03CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkWIIe9yYsc9HhG4ZpcwCpF9w8G6cZMMGDvenRjFNlrNx6kE/9Gg73AjmIjzUU/BmBtPFcbVrxaAhwres=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYam/tiCnAi0i8Ai4vl6SNaXG21du4OZ3ughDvS4R/xurT7Vt
	BEPuhm9W3jQ0hSjDZQboH7SzauEK+TuyK4o3MzAX0I8E7FFzFnVfSIB/EwoRpik=
X-Google-Smtp-Source: AGHT+IHcTXealoenjwjaH04th06Qrdau8HBNM6BI1gxY955Qk1Fu36XMvT2aaESzzxFES0p+7+jh/g==
X-Received: by 2002:a05:6512:3b99:b0:539:fd98:d87a with SMTP id 2adb3069b0e04-53a1583d155mr1105910e87.5.1729277192311;
        Fri, 18 Oct 2024 11:46:32 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a15211ac9sm290980e87.252.2024.10.18.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:46:30 -0700 (PDT)
Date: Fri, 18 Oct 2024 21:46:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: qcom: gcc: Add support for QCS615 GCC clocks
Message-ID: <7bumydtmwbd7tecurxioqqzw4xj4rkm6mpm527fpwgetai5xzh@rdekj226xfbr>
References: <20240920-qcs615-clock-driver-v2-0-2f6de44eb2aa@quicinc.com>
 <20240920-qcs615-clock-driver-v2-4-2f6de44eb2aa@quicinc.com>
 <gokgyvnunjswjdjmbhfvjzvdc6ag7r3dztj2hqk3cglwyz5f5a@aarbe4rrifme>
 <f1080f46-ed96-4360-ae91-0d5b7aa138ce@quicinc.com>
 <kgtg7seem6jhidn4svxttobwvs44uwezsj2f6hydjm7er4qt5d@kehfmwi437wg>
 <bdd2a873-3d5b-4986-a79c-d2bb54997b43@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd2a873-3d5b-4986-a79c-d2bb54997b43@quicinc.com>

On Fri, Oct 18, 2024 at 11:14:00PM +0530, Taniya Das wrote:
> 
> 
> On 10/16/2024 3:46 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 16, 2024 at 09:40:07AM +0530, Taniya Das wrote:
> > > 
> > > 
> > > On 9/20/2024 4:33 PM, Dmitry Baryshkov wrote:
> > > > On Fri, Sep 20, 2024 at 04:08:18PM GMT, Taniya Das wrote:
> > > > > Add the global clock controller support for QCS615 SoC.
> > > > > 
> > > > > Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> > > > > ---
> > > > >    drivers/clk/qcom/Kconfig      |    9 +
> > > > >    drivers/clk/qcom/Makefile     |    1 +
> > > > >    drivers/clk/qcom/gcc-qcs615.c | 3035 +++++++++++++++++++++++++++++++++++++++++
> > > > >    3 files changed, 3045 insertions(+)
> 
> > > > > +};
> > > > > +
> > > > > +static struct clk_alpha_pll gpll0 = {
> > > > > +	.offset = 0x0,
> > > > > +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> > > > > +	.clkr = {
> > > > > +		.enable_reg = 0x52000,
> > > > > +		.enable_mask = BIT(0),
> > > > > +		.hw.init = &(const struct clk_init_data) {
> > > > > +			.name = "gpll0",
> > > > > +			.parent_data = &(const struct clk_parent_data) {
> > > > > +				.index = DT_BI_TCXO,
> > > > > +			},
> > > > > +			.num_parents = 1,
> > > > > +			.ops = &clk_alpha_pll_ops,
> > > > > +		},
> > > > > +	},
> > > > > +};
> > > > > +
> > > > > +static struct clk_fixed_factor gpll0_out_aux2_div = {
> > > > > +	.mult = 1,
> > > > > +	.div = 2,
> > > > > +	.hw.init = &(struct clk_init_data) {
> > > > > +		.name = "gpll0_out_aux2_div",
> > > > > +		.parent_data = &(const struct clk_parent_data) {
> > > > > +			.hw = &gpll0.clkr.hw,
> > > > > +		},
> > > > > +		.num_parents = 1,
> > > > > +		.ops = &clk_fixed_factor_ops,
> > > > > +	},
> > > > > +};
> > > > 
> > > > Should it be clk_alpha_pll_postdiv_foo_ops ?
> > > > 
> > > 
> > > This is not the PLL output, but it is a fixed divider which is placed as
> > > input to the RCG.
> > > That is the reason to use the fixed factor.
> > 
> > Usually OUT_AUX2 is the PLL output, isn't it? Even by its name. See
> > gcc-qcm2290 / gcc-sm6115 and most of other clock controller drivers,
> > except gcc-sm6125. Maybe I don't understand the difference between the
> > two usecases. Is there a difference in the GCC / PLL design?
> > 
> 
> Yes, your understanding is correct out_aux2/out_main are the PLL leaf
> outputs. But on QCS615 the PLL dividers are not used and thus the aux2 and
> the other leaf outputs are at the same frequency as the main output of the
> VCO and instead there was a fixed divider placed after the PLL to divide the
> VCO output. There was a GCC design change required to meet timing closures.

Ack, please add a comment that this PLL uses fixed divider instead of
a normal postdiv (and to other out_aux2 clocks too).

> > > > 
> > > > > +
> > > > > +static struct clk_branch gcc_pcie_0_pipe_clk = {
> > > > > +	.halt_reg = 0x6b024,
> > > > > +	.halt_check = BRANCH_HALT_SKIP,
> > > > > +	.clkr = {
> > > > > +		.enable_reg = 0x5200c,
> > > > > +		.enable_mask = BIT(4),
> > > > > +		.hw.init = &(const struct clk_init_data) {
> > > > > +			.name = "gcc_pcie_0_pipe_clk",
> > > > > +			.ops = &clk_branch2_ops,
> > > > > +		},
> > > > > +	},
> > > > > +};
> > > > 
> > > > No corresponding gcc_pcie_0_pipe_clk_src?
> > > > 
> > > 
> > > On QCS615 the pipe clock source is not required to be modelled as the mux is
> > > default Power on reset is set to external pipe clock.
> > 
> > And do we need to toggle the source of the clk_src together with the
> > GDSC toggling?
> > 
> 
> AFAIR, QCS615 didn't require toggling for GDSC, as even on downstream kernel
> we do not have the pipe_clk_src modelled in our driver.

OK, thanks for the explanation.

-- 
With best wishes
Dmitry

