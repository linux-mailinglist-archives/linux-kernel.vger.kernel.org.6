Return-Path: <linux-kernel+bounces-233056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7D91B1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F160A1C227E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8131A01D3;
	Thu, 27 Jun 2024 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW9K8bQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628E249F9;
	Thu, 27 Jun 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719524637; cv=none; b=YKl/alV7LH+X9hTBmqXiwcUHQqwIGwWa/+hdEnE9XN5YZgVn6x+Spksu4zbNvPMXAGZvM5nK18FpUSPyQDsNy3CZPTrnEy7/PTlqtPHNG/M9N+VyVq8reLJY4Yyk9xQb/soxD42a1KkovpyHyLqp0Txvbm1wnJk3HuUmtU0opAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719524637; c=relaxed/simple;
	bh=LoSc8x+ZYO2DbQ6k06wW/rHJbFqw9BW9Fn/mAoYoxNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj1Q6KUbSLGkjvuFtqEOp8G4+gINZ0epKf6Q3vwFFxzchc/R6fL7Y9WcAjFeLuwOm0fvWdvX5eyjqvsVgadmJ0KdcPM2uYhwBxQGypM7B4zdLqhL0LU0BztaHYgBUurcS4Ha68sDzn5WLi0SUwjRqav3NEX88zURnpexDovBGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW9K8bQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76CAC2BBFC;
	Thu, 27 Jun 2024 21:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719524637;
	bh=LoSc8x+ZYO2DbQ6k06wW/rHJbFqw9BW9Fn/mAoYoxNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW9K8bQshV4fI4PJ4ukdJ+HwrMS8pqrrVEbuTv1pC2P9Xmpmo20UtxVF0gjbLxHmH
	 N83WbKbsH6ZOKEqCQm6gxojWE06gwKSN4AqqGKgGk00HwrR/8M388gT08mSLiAsbFt
	 6VxmcyworkMWTVL9HRWjvqQE8V8b6NdsPMY61dX/K4L0P8zaUfAmdiBWa7reHb63bK
	 IX9S/Kt2/ohUvq/GRWbuQHQZ0Yg6+7S+Uh2rF9HPLJsBXO7dJ8f7j8LQTAe1yGEgqk
	 BUq+DEqcGBh4q/4RJfaOgpPSptCUhaEriFBScQns5e/5qnG+nHWucW1W3d8HT50+eh
	 /RAob/Yfz+18A==
Date: Thu, 27 Jun 2024 15:43:55 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
Message-ID: <20240627214355.GA601888-robh@kernel.org>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
 <20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-clk-u64-v1-1-d28a611b2621@nxp.com>

+Luca

On Fri, Jun 21, 2024 at 08:36:39PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Preparing for assigned-clock-rates-u64 support, add function
> of_property_for_each_u64 to iterate each u64 value
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/of/property.c | 23 +++++++++++++++++++++++
>  include/linux/of.h    | 24 ++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 164d77cb9445..b89c3ab01d44 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
>  }
>  EXPORT_SYMBOL_GPL(of_prop_next_u32);
>  
> +const __be32 *of_prop_next_u64(struct property *prop, const __be32 *cur,
> +			       u64 *pu)

struct property can be const

> +{
> +	const void *curv = cur;
> +
> +	if (!prop)
> +		return NULL;
> +
> +	if (!cur) {
> +		curv = prop->value;
> +		goto out_val;
> +	}
> +
> +	curv += sizeof(*cur) * 2;
> +	if (curv >= prop->value + prop->length)
> +		return NULL;
> +
> +out_val:
> +	*pu = of_read_number(curv, 2);
> +	return curv;
> +}
> +EXPORT_SYMBOL_GPL(of_prop_next_u64);
> +
>  const char *of_prop_next_string(struct property *prop, const char *cur)
>  {
>  	const void *curv = cur;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 13cf7a43b473..464eca6a4636 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -439,6 +439,18 @@ extern int of_detach_node(struct device_node *);
>   */
>  const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
>  			       u32 *pu);
> +
> +/*
> + * struct property *prop;
> + * const __be32 *p;
> + * u64 u;
> + *
> + * of_property_for_each_u64(np, "propname", prop, p, u)
> + *         printk("U64 value: %llx\n", u);
> + */
> +const __be32 *of_prop_next_u64(struct property *prop, const __be32 *cur,
> +			       u64 *pu);
> +
>  /*
>   * struct property *prop;
>   * const char *s;
> @@ -834,6 +846,12 @@ static inline const __be32 *of_prop_next_u32(struct property *prop,
>  	return NULL;
>  }
>  
> +static inline const __be32 *of_prop_next_u64(struct property *prop,
> +		const __be32 *cur, u64 *pu)
> +{
> +	return NULL;
> +}
> +
>  static inline const char *of_prop_next_string(struct property *prop,
>  		const char *cur)
>  {
> @@ -1437,6 +1455,12 @@ static inline int of_property_read_s32(const struct device_node *np,
>  		p;						\
>  		p = of_prop_next_u32(prop, p, &u))
>  
> +#define of_property_for_each_u64(np, propname, prop, p, u)	\
> +	for (prop = of_find_property(np, propname, NULL),	\
> +		p = of_prop_next_u64(prop, NULL, &u);		\
> +		p;						\
> +		p = of_prop_next_u64(prop, p, &u))

I think we want to define this differently to avoid exposing struct 
property and the property data directly. Like this:

#define of_property_for_each_u64(np, propname, u) \
  for (struct property *_prop = of_find_property(np, propname, NULL),
         const __be32 *_p = of_prop_next_u64(_prop, NULL, &u);
         _p;
         _p = of_prop_next_u64(_prop, _p, &u))

See this discussion for context[1].

Rob

[1] https://lore.kernel.org/all/20240624232122.3cfe03f8@booty/

