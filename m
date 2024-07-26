Return-Path: <linux-kernel+bounces-263025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AD093CFEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C51F2492F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A3C178367;
	Fri, 26 Jul 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IPD6iSfz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B6A17799B;
	Fri, 26 Jul 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984007; cv=none; b=GE0Bq1pRg2RhGrfiA+oKdy0arO2gbYQ5/ckA0cRyxd8QbfTkKVHsuMXhhX25T/BitBY4Nt6UVFKUWlpP2AdLgahPeNHyfbF/0bbc3etOs2Y5FpNN+7l4dJOqTciuoEVPsBaldgNN8CND8aXCAnk8BFhVeygvpT7p52STc1pABN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984007; c=relaxed/simple;
	bh=2Y6CmgvW3y7wt9simLTPtNm1Xvf9suGCMEAqYc1psKU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBUNP6kaZIyjRSrzOhmtw78RUf/4s9Nl/+VkdgLvke+40lw0wZnd9CHvDQC/nVNYnxdrmn0Eqal7Pr5XiqOEc4kWuAq+0QsrHOaYmR9Yx8QaMOWepQ0Q4tFP5CvL50l2XovOW8GvccRFv/X/TDNAibrksqOoYEV2r8aX1ZzGu3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IPD6iSfz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46Q8r7ww066495;
	Fri, 26 Jul 2024 03:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721983987;
	bh=O/uow5tUi6p+KYTJeircOQo9Nkglx2i1OnNlTDinozI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=IPD6iSfzrI9BNSqD0Uf104eNnIEqraCUISCobNZdX1Rs88r5dhVV6cHTVsA5osxH1
	 Gwb3cCDkqYZGzz+K2iKfbTlA/Z8tYy8ZdS0xsbDztSIJ7jFU2U3S/lGUBnfsmJYHpj
	 4Mk++UfA2m4AMC8mLZQ6+vAlE81dR4LRqgYoLgHo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46Q8r7tN031537
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 03:53:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 03:53:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 03:53:07 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46Q8r6mr066490;
	Fri, 26 Jul 2024 03:53:06 -0500
Date: Fri, 26 Jul 2024 14:23:05 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, <vigneshr@ti.com>, <kamlesh@ti.com>
Subject: Re: [PATCH] clk: scmi: add is_prepared hook
Message-ID: <20240726085305.sb57f3i2ezvtwrwz@dhruva>
References: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725090741.1039642-1-peng.fan@oss.nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jul 25, 2024 at 17:07:41 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clks maybe default enabled by hardware, so add is_prepared hook

Why is_prepared when there is an is_enabled hook?
See in the atomic case we already have something similar:

ops->is_enabled = scmi_clk_atomic_is_enabled;

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

IMO from the decription and what the function is doing is_enabled makes
more sense here to me, unless there's a better explanation.

Ref: linux/clk-provider.h
is_prepared: Queries the hardware to determine if the clock is prepared
vs
is_enabled: Queries the hardware to determine if the clock is enabled

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

