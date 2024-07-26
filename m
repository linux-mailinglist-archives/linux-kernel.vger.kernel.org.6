Return-Path: <linux-kernel+bounces-263335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4093D470
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD7E1C20441
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1F17C216;
	Fri, 26 Jul 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OhCl0UwW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832A1E4A4;
	Fri, 26 Jul 2024 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001473; cv=none; b=gOpb63L05b+Wi9wg8NiTvVliGm6jOWY88TDtAGsX6b750wdoCbbTTCX9GtP1ymwNKojdHeuaJmI6E0BmbpGD4fL6iBXrcfXREDVzG/eYyJBke5NEBb+3KT2bobiqKrbEDi8KEj6fi3awnwXwit/wiRVeDRIaEhCNMVPkh4RsSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001473; c=relaxed/simple;
	bh=yLql+EgH02szDam6UeTjVjaj/2U2RMBFK9rLkSSo4V8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um8+lCPg3mI7ipdvkEgCrq9b7wdycuZxQlt0Ff2ApxWItLCwqktGf+Td3ROZQypZO/a13VImCN5lQ0ViEszMkJYJlk7P7PleGALiMm1+20qchPt1qLk6XcZ743QDQCvvq7n9eQiZxDrlgLRcpJ8FuYgzIFIDs7ZjzmPlecpOAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OhCl0UwW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46QDiFiw090992;
	Fri, 26 Jul 2024 08:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722001455;
	bh=X0pibor5pyzf+QqC+/UM1qD3iaGriTi2Gh105sjdVh4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OhCl0UwWpzz1kVYK/32vVtQ1Se9DK0Hq1B8dNyGyrObnqc/OMnHQ1dKYxzIzscWru
	 U79EuqvTQV3+uwk0ByDzfRP8RaG00xt5fI43GVKdsn9eYOP3QP/XxDtxtcOdWziKxW
	 mDr5V+ad34EtwewbC6uz4/d7M92xcANs2SHVWmvg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46QDiFlD095564
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Jul 2024 08:44:15 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Jul 2024 08:44:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Jul 2024 08:44:15 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46QDiEe4101072;
	Fri, 26 Jul 2024 08:44:15 -0500
Date: Fri, 26 Jul 2024 19:14:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] clk: scmi: add is_prepared hook
Message-ID: <20240726134414.2ctbtt53sd3lyfjl@dhruva>
References: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240726131007.1651996-1-peng.fan@oss.nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jul 26, 2024 at 21:10:07 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some clks maybe default enabled by hardware, so add is_prepared hook
> for non-atomic clk_ops to get the status of the clk. Then when disabling
> unused clks, those unused clks but default hardware on clks could be
> in off state to save power.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Provider helper __scmi_clk_is_enabled for atomic and non-atomic usage
>  Move is_prepared hook out of SCMI_CLK_STATE_CTRL_SUPPORTED
> 
>  drivers/clk/clk-scmi.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index d86a02563f6c..15510c2ff21c 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -156,13 +156,13 @@ static void scmi_clk_atomic_disable(struct clk_hw *hw)
>  	scmi_proto_clk_ops->disable(clk->ph, clk->id, ATOMIC);
>  }
>  
> -static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> +static int __scmi_clk_is_enabled(struct clk_hw *hw, bool atomic)

I think we can combine other atomic/non atomic in the same way no?
Let me know if I should send a follow up patch based on this to make
__scmi_clk_enable(hw,atomic) and __scmi_clk_disable(hw,atomic)

I'd be more than happy to do so.

>  {
>  	int ret;
>  	bool enabled = false;
>  	struct scmi_clk *clk = to_scmi_clk(hw);
>  
> -	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, ATOMIC);
> +	ret = scmi_proto_clk_ops->state_get(clk->ph, clk->id, &enabled, atomic);
>  	if (ret)
>  		dev_warn(clk->dev,
>  			 "Failed to get state for clock ID %d\n", clk->id);
> @@ -170,6 +170,16 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
>  	return !!enabled;
>  }
>  
> +static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
> +{
> +	return __scmi_clk_is_enabled(hw, ATOMIC);
> +}
> +
> +static int scmi_clk_is_enabled(struct clk_hw *hw)
> +{
> +	return __scmi_clk_is_enabled(hw, NOT_ATOMIC);
> +}
> +
>  static int scmi_clk_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>  {
>  	int ret;
> @@ -285,6 +295,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
>  
>  	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
>  		ops->is_enabled = scmi_clk_atomic_is_enabled;
> +	else
> +		ops->is_prepared = scmi_clk_is_enabled;

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

