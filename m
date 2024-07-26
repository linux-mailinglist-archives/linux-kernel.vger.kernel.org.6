Return-Path: <linux-kernel+bounces-263179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B98993D23D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3757B28124D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B017A598;
	Fri, 26 Jul 2024 11:27:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19457179204;
	Fri, 26 Jul 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993244; cv=none; b=Z0M0fKW7RJeYC/JSVAFYT5Jow/VobJQr+FIxNNjRNFh2F9HmwYVBVp2Mtd8EBvi9mlj56LDLDzkNMwI8+eymIxTzdfIeOOZnuzcYCCyjanyAnDc8FKjJJfSLs97QeLxQcq03FAzzblVZPoGvtlQ/97f1S2Y64d5/t7dzEf2wsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993244; c=relaxed/simple;
	bh=38jF0AoqXiOEq+fWlBN3oGDUYImZ8nnMr24hxlQDdjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJcgLK/ZhUrWtlxu+3pgQcAbba9icISCa++MQqUeB6IO4BuTnwJyDpFHAwYIx1IoEvz3oxL6g6v+MFjPu0PMhQdj5k6THpoMfi2MNjD4sBqWus4nrAWUq9NhLYQPLyPv/G/rALHyUPSPdpdsKBR3CThqfLJ7bjCFUWYrUA2wOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED9BC1007;
	Fri, 26 Jul 2024 04:27:46 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0501D3F73F;
	Fri, 26 Jul 2024 04:27:19 -0700 (PDT)
Date: Fri, 26 Jul 2024 12:27:17 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, mturquette@baylibre.com,
	sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] clk: scmi: add is_prepared hook
Message-ID: <ZqOIFfkxylcdIIFB@pluto>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725090741.1039642-1-peng.fan@oss.nxp.com>

On Thu, Jul 25, 2024 at 05:07:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 

.... one more remark..

> Some clks maybe default enabled by hardware, so add is_prepared hook
> to get the status of the clk. Then when disabling unused clks, those
> unused clks but default hardware on clks could be in off state to save
> power.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/clk-scmi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index d86a02563f6c..d2d370337ba5 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -142,6 +142,20 @@ static void scmi_clk_disable(struct clk_hw *hw)
>  	scmi_proto_clk_ops->disable(clk->ph, clk->id, NOT_ATOMIC);
>  }
>  
> +static int scmi_clk_is_enabled(struct clk_hw *hw)
> +{
> +	int ret;
> +	bool enabled = false;
> +	struct scmi_clk *clk = to_scmi_clk(hw);
> +
> +	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, NOT_ATOMIC);
> +	if (ret)
> +		dev_warn(clk->dev,
> +			 "Failed to get state for clock ID %d\n", clk->id);
> +
> +	return !!enabled;
> +}
> +
>  static int scmi_clk_atomic_enable(struct clk_hw *hw)
>  {
>  	struct scmi_clk *clk = to_scmi_clk(hw);
> @@ -280,6 +294,7 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
>  		} else {
>  			ops->prepare = scmi_clk_enable;
>  			ops->unprepare = scmi_clk_disable;
> +			ops->is_prepared = scmi_clk_is_enabled;

... you should NOT add the is_prepared ops here, since this would mean
that you will have the is_prepared ops available only when
SCMI_CLK_STATE_CTRL_SUPPORTED, WHILE you most probably want to be able
to check (non atomically) the current enabled-status for a clock EVEN IF
you are allowed to change its state...please add the is_prepared in the
else-branch down below where the ATOMIC is_enabled is added

Thanks,
Cristian

