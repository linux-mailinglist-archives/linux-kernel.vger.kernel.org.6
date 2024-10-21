Return-Path: <linux-kernel+bounces-374150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D09A6598
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9267283EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141331E411D;
	Mon, 21 Oct 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTwTo4Uo"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9871E3784
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508227; cv=none; b=P3aBVtg2sreiMbClqTg0fWuDWp9vXCXBPM5lmbINExsPEZJEKmuaTaK8XPKwURVA+shaByjdS++OKrO6f+jnMboKFHWWQSuc12RCAvOTEZWB6gUddtX0X647DvUwqpbMrW6kSHqkj2pi2d9EqzaQn+/++a4NjnNTUtEcgemJV6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508227; c=relaxed/simple;
	bh=CDBHa4HhpZ93hMV4Cyf19fbWiPeaQcK01LUJDJBdBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9IrxuRF8GatXfndrBvb0WLiuu/SG5wb1FD6cJ5EmTo2vaudrp2fnLzD3rB5/6I541Iev47193mFGiFgGRl3z12KsBjR10ZvKdEzRgB/Azn/NFQWeWZoZvIV0W0uGsILOmHST1PoOIJM011HkxPYFi/iSrfQ6yFdElQxjneEnpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xTwTo4Uo; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e13375d3so4682501e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729508223; x=1730113023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sJa6EKXXiP19VVbfMZOnJkIoAIvDNdNKcWXx8p9So8=;
        b=xTwTo4UoyjZNuBrKGscAWHLLhPYoltif0Gu2BKm7BJZHRwZQh7Zq1b4gCF5CeuKVVt
         YXqOa4Dkz0eDH5ba1lUvbNKCQp3H3dGzwmlPvXMfM+f4v5hTo34oG8OXKdDBqv7Mhrcx
         dHJ0Iec/nYD+tEkcvhynBLpNlio3qXxcfZtK7RDjcH6lzzfOlWY+u2I+XPJeXGMIh4zT
         gBRDLARVfCzoppTuUpCp0/N2gFzxLlIF7SM6QFWErQewNhVlR6B+qWo1juqaJHIK1X4U
         TZaaO6WbZ6xzi5AzGkXbgQFBGZPjozZa+26JKaUAFkO132tudd0+bki3Eb9K5tvf78+2
         GV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508223; x=1730113023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sJa6EKXXiP19VVbfMZOnJkIoAIvDNdNKcWXx8p9So8=;
        b=dLTav881zHDEMA/zCsGDGBeJr3QR/zuZ/cotcnV7XEt3Y2/YyQKX1RlLTSfRaCUtkD
         A+llVVUsK7QW2kxN5+xcf7ctJkIeiVDwMuK6QiMCFEn5BibuDpnjCDyZL5T8C15YvHbS
         H3yJ7rLe/cx7Von7PsqXDC6fk5C+CeVJ+1wj4gjbh6lFpLrdMFuWYD2hKBqXoT7dbrip
         X46QPLYf97SwfQ5ZREgP1FZdC5HZPlIXxWsES6PF+PHz01IJlnId6XlzKKlVU2pntfey
         unmccrsSIwECiK3rmV0sy9ngoB0Ip3XDifyfi+HYQMWiMFxUVKmZNyAjPQlMUD2XSg9G
         NxlA==
X-Forwarded-Encrypted: i=1; AJvYcCWvtJ/rRBU+w5ctTrW3scNg+Q93a7ROz/knzzlRqE1QabwaunwRi5fOW5UQATvweCrqgW90v2gz9/v4yEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+OON/vfzIiYe0NPmV4ypdt9qnPV9NPjYVbwRb3DaUMWDblV9
	Fs0yYUfDikOOR2vDe6CFMrSPNOn0OuhIJXl2cYmf+khaqfYWFF5EcWCDzW5Dx70=
X-Google-Smtp-Source: AGHT+IHMXgWU4v7Fzqllu7BsHwkTqs7vhzF+ABH7oaEiwqvEmG1ej27+CESFkjwyqXjFWNy4DYBV1g==
X-Received: by 2002:a05:6512:33d3:b0:533:4689:973c with SMTP id 2adb3069b0e04-53a15497022mr4270762e87.23.1729508222934;
        Mon, 21 Oct 2024 03:57:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e5903sm454768e87.11.2024.10.21.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:57:01 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:56:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Imran Shaik <quic_imrashai@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] clk: qcom: Add support for GPU Clock Controller on
 QCS8300
Message-ID: <o5v3fch5oxol4t7j4xlqswk6m6uo4tleck2cnfk6whpfqsrvjc@s2yrjumgvw6j>
References: <20241018-qcs8300-mm-patches-v1-0-859095e0776c@quicinc.com>
 <20241018-qcs8300-mm-patches-v1-2-859095e0776c@quicinc.com>
 <puhpztfn6ga5rxv4mwu7wyvk63hqme2nzffcvzwv7t4oo5hlvc@4ugxncmu3wwk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <puhpztfn6ga5rxv4mwu7wyvk63hqme2nzffcvzwv7t4oo5hlvc@4ugxncmu3wwk>

On Mon, Oct 21, 2024 at 09:56:08AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Oct 18, 2024 at 04:42:30PM +0530, Imran Shaik wrote:
> > Add support to the QCS8300 GPU clock controller by extending
> > the SA8775P GPU clock controller, which is mostly identical
> > but QCS8300 has few additional clocks and minor differences.
> > 
> > Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> > ---
> >  drivers/clk/qcom/gpucc-sa8775p.c | 47 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gpucc-sa8775p.c b/drivers/clk/qcom/gpucc-sa8775p.c
> > index f8a8ac343d70..99a8344b00db 100644
> > --- a/drivers/clk/qcom/gpucc-sa8775p.c
> > +++ b/drivers/clk/qcom/gpucc-sa8775p.c
> > @@ -317,6 +317,24 @@ static struct clk_branch gpu_cc_crc_ahb_clk = {
> >  	},
> >  };
> >  
> > +static struct clk_branch gpu_cc_cx_accu_shift_clk = {
> > +	.halt_reg = 0x95e8,
> > +	.halt_check = BRANCH_HALT,
> > +	.clkr = {
> > +		.enable_reg = 0x95e8,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(const struct clk_init_data){
> > +			.name = "gpu_cc_cx_accu_shift_clk",
> > +			.parent_hws = (const struct clk_hw*[]){
> > +				&gpu_cc_xo_clk_src.clkr.hw,
> > +			},
> > +			.num_parents = 1,
> > +			.flags = CLK_SET_RATE_PARENT,
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >  static struct clk_branch gpu_cc_cx_ff_clk = {
> >  	.halt_reg = 0x914c,
> >  	.halt_check = BRANCH_HALT,
> > @@ -420,6 +438,24 @@ static struct clk_branch gpu_cc_demet_clk = {
> >  	},
> >  };
> >  
> > +static struct clk_branch gpu_cc_gx_accu_shift_clk = {
> > +	.halt_reg = 0x95e4,
> > +	.halt_check = BRANCH_HALT,
> > +	.clkr = {
> > +		.enable_reg = 0x95e4,
> > +		.enable_mask = BIT(0),
> > +		.hw.init = &(const struct clk_init_data){
> > +			.name = "gpu_cc_gx_accu_shift_clk",
> > +			.parent_hws = (const struct clk_hw*[]){
> > +				&gpu_cc_xo_clk_src.clkr.hw,
> > +			},
> > +			.num_parents = 1,
> > +			.flags = CLK_SET_RATE_PARENT,
> > +			.ops = &clk_branch2_ops,
> > +		},
> > +	},
> > +};
> > +
> >  static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
> >  	.halt_reg = 0x7000,
> >  	.halt_check = BRANCH_HALT_VOTED,
> > @@ -499,6 +535,7 @@ static struct clk_regmap *gpu_cc_sa8775p_clocks[] = {
> >  	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
> >  	[GPU_CC_CB_CLK] = &gpu_cc_cb_clk.clkr,
> >  	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
> > +	[GPU_CC_CX_ACCU_SHIFT_CLK] = NULL,
> >  	[GPU_CC_CX_FF_CLK] = &gpu_cc_cx_ff_clk.clkr,
> >  	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> >  	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
> > @@ -508,6 +545,7 @@ static struct clk_regmap *gpu_cc_sa8775p_clocks[] = {
> >  	[GPU_CC_DEMET_DIV_CLK_SRC] = &gpu_cc_demet_div_clk_src.clkr,
> >  	[GPU_CC_FF_CLK_SRC] = &gpu_cc_ff_clk_src.clkr,
> >  	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> > +	[GPU_CC_GX_ACCU_SHIFT_CLK] = NULL,
> >  	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
> >  	[GPU_CC_HUB_AHB_DIV_CLK_SRC] = &gpu_cc_hub_ahb_div_clk_src.clkr,
> >  	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
> > @@ -583,6 +621,7 @@ static const struct qcom_cc_desc gpu_cc_sa8775p_desc = {
> >  };
> >  
> >  static const struct of_device_id gpu_cc_sa8775p_match_table[] = {
> > +	{ .compatible = "qcom,qcs8300-gpucc" },
> >  	{ .compatible = "qcom,sa8775p-gpucc" },
> 
> I just wanted to comment on your binding that devices should be made
> compatible...
> 
> >  	{ }
> >  };
> > @@ -596,6 +635,14 @@ static int gpu_cc_sa8775p_probe(struct platform_device *pdev)
> >  	if (IS_ERR(regmap))
> >  		return PTR_ERR(regmap);
> >  
> > +	if (of_device_is_compatible(pdev->dev.of_node, "qcom,qcs8300-gpucc")) {
> 
> Why we cannot use match data? Seeing compatibles in the code is
> unexpected and does not scale.

Because using match data doesn't scale in such cases. We have been using
compatibles to patch clock trees for the platforms for quite a while.
You can see that each of the "tunings" is slightly different. From my
point of view, this approach provides a nice balance between having a
completely duplicate driver and having a driver which self-patches the
tree.

-- 
With best wishes
Dmitry

