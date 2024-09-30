Return-Path: <linux-kernel+bounces-344222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F45698A6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683171C22763
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8918FDD8;
	Mon, 30 Sep 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Ea0yYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B9A433B6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705201; cv=none; b=hDEODLpYP+u3Oxofdvtgj8Z+ApW+MoTP1QPE2YTGjNVRc14jgCYfqRqdo3NVM4PmX5IGTPq7kby8nwg3VMtknX8QC7en1mQXP/g6XxiZAp2gZhOPnsrb2tSjYlWBDl8HKdISCvt7YMI8fKwas0J3qGOEs5KjQG/gjItjYgoqMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705201; c=relaxed/simple;
	bh=Ke1UnpfXgyOwVgjk/Ulk3tBxJVnjoH10oSo5vuJJS5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8UAdfcuzfAXWDmnO2iuknh0vt2a9IzLM/L6oJKa+0g6OS0Bn+9WQfpB3qNMPWrmbD6BbLwwrCGwqC3aeh5QEUL9W2QZVC7KuQuRcyGHVK78PwqQR2ZaBq9OjUsx8etvIRCL0TDV3XcUov4PVMeYKk5MXnbvF2C4ySq07GUvycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Ea0yYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF081C4CEC7;
	Mon, 30 Sep 2024 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727705200;
	bh=Ke1UnpfXgyOwVgjk/Ulk3tBxJVnjoH10oSo5vuJJS5o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b3Ea0yYqXLemODlI+RsT8K51DuYZMSfWYqD3J7zBxiHf4MnyZ40X0NoTkRw9LKIWM
	 ec44c586PB0GgrTb0XjsncY1d8axzkrgaf+Y4DbeOD+zVJFlFadvm6wupGM1XEVcXp
	 GvuigqNd7/k/W1uDDOX6LCZnZwRmdyiDYtqjyMSY2uSdufZPOlICNgkDXp7nve5M2r
	 G8DjO5bzgYPFKF57AkLEHiaDvVNG8+hlFBn5OkydnBDZIgCde6CWTt6baCFCPqhShR
	 CXrGGYWls7CuGbmkQrWkV3n0FI7nGn/qrq9j7Gt83Tqtt6IRMIJRdeYz3nBdEG2crT
	 8PSxcFf4egLuw==
Message-ID: <4b42b8e5-3246-4f58-b494-735930d2424a@kernel.org>
Date: Mon, 30 Sep 2024 17:06:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: ti: phy-j721e-wiz: fix usxgmii configuration
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
 kishon@kernel.org, thomas.richard@bootlin.com,
 krzysztof.kozlowski@linaro.org, nichen@iscas.ac.cn, c-vankar@ti.com,
 t-patil@ti.com
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240930095745.3007057-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240930095745.3007057-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Siddharth,

On 30/09/2024 12:57, Siddharth Vadapalli wrote:
> Commit b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in
> wiz driver") added support for USXGMII mode. In doing so, P0_REFCLK_SEL
> was set to "pcs_mac_clk_divx1_ln_0" (0x3) and P0_STANDARD_MODE was set to
> LANE_MODE_GEN1, which results in a data rate of 5.15625 Gbps. However,
> since the USXGMII mode can support up to 10.3125 Gbps data rate, the
> aforementioned fields should be set to "pcs_mac_clk_divx0_ln_0" (0x2) and
> LANE_MODE_GEN2 respectively. Fix the configuration accordingly to truly
> support USXGMII up to 10G.
> 
> Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 9852d85ec9d4 Linux 6.12-rc1
> of mainline Linux.
> 
> v1:
> https://lore.kernel.org/r/20240910091714.1082191-1-s-vadapalli@ti.com/
> Changes since v1:
> - Rebased to Linux 6.12-rc1.
> 
> Regards,
> Siddharth.
> 
>  drivers/phy/ti/phy-j721e-wiz.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index a6c0c5607ffd..c6e846d385d2 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -450,8 +450,8 @@ static int wiz_mode_select(struct wiz *wiz)
>  		} else if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
>  			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
>  			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);

I'm not sure. Don't we have to change rxfclk as well?

> -			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x3);
> -			mode = LANE_MODE_GEN1;
> +			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x2);
> +			mode = LANE_MODE_GEN2;
>  		} else {
>  			continue;
>  		}

-- 
cheers,
-roger

