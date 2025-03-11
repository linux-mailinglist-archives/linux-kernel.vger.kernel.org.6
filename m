Return-Path: <linux-kernel+bounces-556653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95BCA5CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5262D189E24E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E32638BF;
	Tue, 11 Mar 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIsCiSzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838AB262D28;
	Tue, 11 Mar 2025 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715735; cv=none; b=RyRkOGfLWbhjnLF+TXVXardjKM9tLnlejk7lLVmbNGKoMh1lb8YU+TuaLVwgdrvCbRan80HQGlVFMwCtWsONgN7SukoPUvuiVNvpL7dTs9AxnwKgPZYu1mz9BtUgnByASi0RkdLL3igQ3Ki5pP1JS47mU+H6LdQtncqGHhyo6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715735; c=relaxed/simple;
	bh=FHCQATBSLmpAWXip31O8O52dTruLCf7XlwNyqmmZB48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBdxHuISd2/0veBDp6siD0b3LbWEzpq1xq9oq+zg50XRMvbQG+hM8aFusAZ+28brdCnHf9VEuwTYlz+MeflN4SfXuYfAMZESVZi8QNBYb/9fCqpKoy2kDYURPXD8RE4jVOhUmOcHLQHWBG8VtRzLHq1TANHm1GFh80Pouo0vBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIsCiSzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79177C4CEEA;
	Tue, 11 Mar 2025 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741715735;
	bh=FHCQATBSLmpAWXip31O8O52dTruLCf7XlwNyqmmZB48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIsCiSzSoNNNrb/fQOXo76LeQzur9FHZCWNiflQOIX6JaycSC9akz0PekJy1FYGrZ
	 f18+trn9uEb7WH/vKPf1+6t2pA/ptMvgil7eRrZw5KWKl7chtrvh7n+tEkMeezZwBf
	 zpA7Na4Zlgpo7N8ws59CUMFKdndUm/qbYdVfszMOsxBljDyF7j9Dh4+vKQLAXrAKY3
	 eMMlF/JCPQp2Af3UhlnkkEx0/95h6Tfc67uSPyxB+hzGNUw91NpWkCRCFmAcV+c9UW
	 z/do8YLiskrANur/5j+RzYsDZUhsb/WlHRHgTAJV+K7dzJi1UsFK+h+tflOYYWHW+1
	 oCr18+PLn5SJA==
Date: Tue, 11 Mar 2025 12:55:32 -0500
From: Rob Herring <robh@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: devicetree@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/irq: Refuse to of_irq_parse_one() more than one IRQ
 if #interrupt-cells = <0>
Message-ID: <20250311175532.GA3869198-robh@kernel.org>
References: <20250307135231.4080272-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307135231.4080272-1-alexander.sverdlin@siemens.com>

On Fri, Mar 07, 2025 at 02:52:18PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> An #interrupt-cells = <0> property may arguably be a right answer for an
> interrupt controller having just one interrupt and no options to configure.
> There are anyway already existing examples in the tree, both in DTs and in
> the bindings.

The existing examples are broken and hacks to take advantage of Linux 
implementation details (IRQCHIP_DECLARE()).

And #interrupt-cells==0 can't work with 'interrupts'.

> 
> Now the problem is that of_irq_count() called on an interrupt generating
> device having one of the former controllers as parent would result in an
> endless loop. It's especially unpleasant in the startup where
> of_irq_count() <= ... <= of_platform_default_populate_init() will silently
> hang forever (unless a watchdog bites).
> 
> Prevent others from spending the same time on debugging this by refusing to
> parse more than one IRQ for such controllers.

I'll happily take a dtschema patch to warn on 0 cells. Then you can find 
the problem at build time. I generally don't think it's the kernel's job 
to validate a DT, but if the code can handle something like this then 
that's good.

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/of/irq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 6c843d54ebb11..b3a359c7641d3 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -381,6 +381,13 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
>  		goto out;
>  	}
>  
> +	if (!intsize && index) {

Why are you checking index?

> +		pr_debug("%pOF trying to map IRQ %d in %pOF having #interrupt-cells = <0>\n",
> +			 device, index, p);
> +		res = -EINVAL;
> +		goto out;
> +	}
> +
>  	pr_debug(" parent=%pOF, intsize=%d\n", p, intsize);
>  
>  	/* Copy intspec into irq structure */
> -- 
> 2.48.1
> 

