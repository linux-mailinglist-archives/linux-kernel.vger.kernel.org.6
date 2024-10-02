Return-Path: <linux-kernel+bounces-347138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11998CE62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AFF28522F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886F194A44;
	Wed,  2 Oct 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="urmDZD4S"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A05193436;
	Wed,  2 Oct 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856528; cv=none; b=t4JuO+RjT/lFbBhxwU0c+yPjWiMfdmuoQlyEtXtQ1VmdrSqcdSuBtUhgrn5BsZH3FH0BEeG4CayCqq0VOdX8m8cYDtaoPDHdPRhjmiiGp+msa3uvV4hxFksOI7YSJ5ZCsebgf8U/6Iv5g2uJ5pU7KWKqxryaxAOlAp7PHJ7FDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856528; c=relaxed/simple;
	bh=1X78mcwhw2j9Egv//hQ57Fq0S6OZ0HLqU+fW/t5yyfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry0/SrRacYlslLI4kf6Sg34RpH46YmOdm3z8bJPWBKCOmDeyMR5NfJSpTFK8O8An7J6OhB8ccL0tnKjEDWpxf+lQ5m2bvupus7/aisZer0T4Ut5dr5uVX8Sd5kzLruqC1UioDM4jFKZXfL2eFtnXz/wfufrVyFNDXQt8SyWfMh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=urmDZD4S; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ngZtLcRpFZYEbU0cMN+iS53JV9+mVWdy4I6j/UNOpVw=; b=urmDZD4S+Y2oCsXJ4MD08zWl5l
	arUKRdHB7l9nAkmsR0W2b6X0ziIKcpXmG396MxhfeEhMouCL+LbSm3eUtTo6ObaJTKG8mPTEu3lcx
	4qWdk1yjb6vgDGRr3ph9Nq+gPlr1AMXD9wsd/enyc3m9fcdiu3wBoD/FSshzPBgicmezKCUazb0uX
	s3+a/KXlsHmRmxebWrbcV0CREV/kxeA2K217roa4879uq83QWb8kGzK7bLbsKP/axjLvqmIezjbxI
	Ap4vte2UAMt6CcbtQZRG/XqY5w9+IU17FP3Hr5XJytfnwedY6AjzWC3tVRbrY50fWWRXXPmTfHHB8
	v/BwwHbw==;
Received: from i53875aa1.versanet.de ([83.135.90.161] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svuPV-0002ye-TS; Wed, 02 Oct 2024 10:08:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Yao Zi <ziyao@disroot.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 5/8] clk: rockchip: Add clock type GATE_NO_SET_RATE
Date: Wed, 02 Oct 2024 10:08:36 +0200
Message-ID: <9365795.CDJkKcVGEf@diego>
In-Reply-To: <20241001042401.31903-7-ziyao@disroot.org>
References:
 <20241001042401.31903-2-ziyao@disroot.org>
 <20241001042401.31903-7-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Dienstag, 1. Oktober 2024, 06:23:59 CEST schrieb Yao Zi:
> This clock type is similar to GATE, but doesn't allow rate setting,
> which presents on RK3528 platform.

this definitly needs more explanation in the commit message.

I.e. regular individual gates always set the CLK_SET_RATE_PARENT flag
because of course the gates themselfs cannot influence the rate.


But in general, I'm also not convinced yet. Yes if some driver tries to
change the rate on those, it may affect the parent rate, but that is also
true for the other individual gates.

So what makes aclk_emmc (as GATE_NO_SET_RATE) more special than
"hclk_emmc" (as regular GATE). [Same for the other clocks of course] .


So this either needs more explanation, or for the sake of simplicity
use regular GATE for now for those and we revisit when it becomes
necessary.


Heiko


> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/rockchip/clk.c |  8 ++++++++
>  drivers/clk/rockchip/clk.h | 14 ++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index 73d2cbdc716b..7d233770e68b 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -521,6 +521,14 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
>  		case branch_gate:
>  			flags |= CLK_SET_RATE_PARENT;
>  
> +			clk = clk_register_gate(NULL, list->name,
> +				list->parent_names[0], flags,
> +				ctx->reg_base + list->gate_offset,
> +				list->gate_shift, list->gate_flags, &ctx->lock);
> +			break;
> +		case branch_gate_no_set_rate:
> +			flags &= ~CLK_SET_RATE_PARENT;
> +
>  			clk = clk_register_gate(NULL, list->name,
>  				list->parent_names[0], flags,
>  				ctx->reg_base + list->gate_offset,
> diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
> index 1efc5c3a1e77..360d16402fe5 100644
> --- a/drivers/clk/rockchip/clk.h
> +++ b/drivers/clk/rockchip/clk.h
> @@ -519,6 +519,7 @@ enum rockchip_clk_branch_type {
>  	branch_divider,
>  	branch_fraction_divider,
>  	branch_gate,
> +	branch_gate_no_set_rate,
>  	branch_mmc,
>  	branch_inverter,
>  	branch_factor,
> @@ -844,6 +845,19 @@ struct rockchip_clk_branch {
>  		.gate_flags	= gf,				\
>  	}
>  
> +#define GATE_NO_SET_RATE(_id, cname, pname, f, o, b, gf)	\
> +	{							\
> +		.id		= _id,				\
> +		.branch_type	= branch_gate_no_set_rate,	\
> +		.name		= cname,			\
> +		.parent_names	= (const char *[]){ pname },	\
> +		.num_parents	= 1,				\
> +		.flags		= f,				\
> +		.gate_offset	= o,				\
> +		.gate_shift	= b,				\
> +		.gate_flags	= gf,				\
> +	}
> +
>  #define MMC(_id, cname, pname, offset, shift)			\
>  	{							\
>  		.id		= _id,				\
> 





