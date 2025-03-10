Return-Path: <linux-kernel+bounces-553646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E356BA58CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B5165B10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D571D63FC;
	Mon, 10 Mar 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs65k6cP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924B17BA5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741591616; cv=none; b=fI9Je/TC9Y1j8YFgUBrmfly+ueK8nhL+HPTj1kWSckrFsDoDwVGXBtY3+3j11L6IagFLVpFz4q0qFSunHlVzA98CPdFcMgjn+x3dXzKMOKR3+I3XJg9gy1JT4p/z0orW4V5YyChvomzjhMkqgHuXnWaC40/q+Hq+Qbm1omJs/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741591616; c=relaxed/simple;
	bh=7wBfnmZleX7Y85tYsTskYok1c1ngfWy+JcWmAk0PEZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtpxFaPGncszTNe8WGl9T5Eh5f2+AdcVxIQG4Gdt/QLhZaAsOW85DSkwhcfD2XGdrxSFAeJXhYIiNW4kuIGDefM3V+yYceB5JmPNFFuFYgYU6fWSofhk3lblu8YA9w8/R6/tu1YaqI7yMxrpX8ZLfBuoF8mQkSPwNtvxgU7WO94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs65k6cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFD5C4CEE5;
	Mon, 10 Mar 2025 07:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741591614;
	bh=7wBfnmZleX7Y85tYsTskYok1c1ngfWy+JcWmAk0PEZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zs65k6cPyITwlw4q7+nFyQLTJ+9cSdxFo2+sEvOpPBWysAq7W331LPGSq6AKxj85j
	 CbHaN6iZOmqT0H/aRFAWEqIvVQo4f91FP3pXcP7WYdCGQZl9N8YSivakG5dY1DXB4C
	 NEC+XQ/m2cGiHjBv/ZSq/8d18XrWFbYhSp5aWeltzsLb7qFU4KeSd9VSZwWzcG9a4K
	 9DlUpDQzhoOV+QliJQwjhLQjMbZ1eZol3ztJl6gPd5YDTXhk1Juznlw3vJBcKe9Uvj
	 eO4a84IOxLQ+/B3fGsukNS/m2G68aM7JjXEi+0jPDwwMqAfukaEL2eaNi4KJU5j9L4
	 9qftv9+ALTn5w==
Date: Mon, 10 Mar 2025 12:56:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, kishon@kernel.org, sebastian.reichel@collabora.com,
	yubing.zhang@rock-chips.com, dmitry.baryshkov@linaro.org,
	frank.wang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH] phy: rockchip: usbdp: Check these parameters only when
 the corresponding set flags are set
Message-ID: <Z86UOmPg/UDSBajZ@vaman>
References: <20250306065952.485809-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306065952.485809-1-andyshrk@163.com>

On 06-03-25, 14:59, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> According documentation of phy_configure_opts_dp, at the configure
> stage, we should only verify/configure the link_rate when set_rate
> flag is set, the same applies to lanes and voltage.
> 
> So we do it as the documentation says, also record the link rate
> and lanes in phy internal for set_voltate stage.

Whenever you say also, that is a sign that it should be another patch!

> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 63 +++++++++++------------
>  1 file changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index c04cf64f8a35..d1bbdf382aa2 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -187,6 +187,8 @@ struct rk_udphy {
>  	u32 dp_aux_din_sel;
>  	bool dp_sink_hpd_sel;
>  	bool dp_sink_hpd_cfg;
> +	unsigned int link_rate;
> +	unsigned int lanes;
>  	u8 bw;
>  	int id;
>  
> @@ -1102,42 +1104,39 @@ static int rk_udphy_dp_phy_power_off(struct phy *phy)
>  	return 0;
>  }
>  
> -static int rk_udphy_dp_phy_verify_link_rate(unsigned int link_rate)
> -{
> -	switch (link_rate) {
> -	case 1620:
> -	case 2700:
> -	case 5400:
> -	case 8100:
> -		break;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>  static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
>  					 struct phy_configure_opts_dp *dp)
>  {
> -	int i, ret;
> +	int i;
>  
> -	/* If changing link rate was required, verify it's supported. */
> -	ret = rk_udphy_dp_phy_verify_link_rate(dp->link_rate);
> -	if (ret)
> -		return ret;
> +	/* Verify link rate. */
> +	if (dp->set_rate) {
> +		switch (dp->link_rate) {
> +		case 1620:
> +		case 2700:
> +		case 5400:
> +		case 8100:
> +			udphy->link_rate = dp->link_rate;
> +			break;
> +
> +		default:
> +			return -EINVAL;
> +		}

why drop helper? Why not set the rate on success?

> +	}
>  
>  	/* Verify lane count. */
> -	switch (dp->lanes) {
> -	case 1:
> -	case 2:
> -	case 4:
> -		/* valid lane count. */
> -		break;
> +	if (dp->set_lanes) {
> +		switch (dp->lanes) {
> +		case 1:
> +		case 2:
> +		case 4:
> +			/* valid lane count. */
> +			udphy->lanes = dp->lanes;
> +			break;
>  
> -	default:
> -		return -EINVAL;
> +		default:
> +			return -EINVAL;
> +		}

another change where helper would have made this look better

>  	}
>  
>  	/*
> @@ -1146,7 +1145,7 @@ static int rk_udphy_dp_phy_verify_config(struct rk_udphy *udphy,
>  	 */
>  	if (dp->set_voltages) {
>  		/* Lane count verified previously. */
> -		for (i = 0; i < dp->lanes; i++) {
> +		for (i = 0; i < udphy->lanes; i++) {
>  			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
>  				return -EINVAL;
>  
> @@ -1243,9 +1242,9 @@ static int rk_udphy_dp_phy_configure(struct phy *phy,
>  	}
>  
>  	if (dp->set_voltages) {
> -		for (i = 0; i < dp->lanes; i++) {
> +		for (i = 0; i < udphy->lanes; i++) {
>  			lane = udphy->dp_lane_sel[i];
> -			switch (dp->link_rate) {
> +			switch (udphy->link_rate) {
>  			case 1620:
>  			case 2700:
>  				regmap_update_bits(udphy->pma_regmap,
> -- 
> 2.34.1

-- 
~Vinod

