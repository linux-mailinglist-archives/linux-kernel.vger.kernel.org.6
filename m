Return-Path: <linux-kernel+bounces-177555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4B08C40B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A2F1C22CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3860614F13C;
	Mon, 13 May 2024 12:26:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A439914F133
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603209; cv=none; b=Ac33/Yh4XWv59uOsup4qFdV30Pq3FVlIIEjJkko7HQFF/rjLNGLqSC9XFkRjAmRGbJEDpswi7cYIiEjlUNoD1Ky/MYSwBcVsCvlIMBSY81Sm274KBr0ZKm0qwimgWN8t+ugW0HTdUEc/lCcEHc//Gl9XjpW0yIfCyrB6n2+2TaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603209; c=relaxed/simple;
	bh=QqDCC4k0NPdJbIRo5g2C9AZNgV71fSbSWfaOiOVXx8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZ/joQXCh5zs+AnRH76GIbj2z3oTDn4YfheTnM3Wr5HYwc78B1vd9MEouBJdZAJRRRqkew20j85TY3ehjRUdQQ3EH6LI7Eecv+z/KCT75ywKmt28xTCOrcEK6UgDShEN8hNL8ye9GpY5jJ99YfbUCpw4iGe4UlhgfjR0E8jKvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1s6Ul4-0006Rd-I3; Mon, 13 May 2024 14:26:22 +0200
Message-ID: <3ecbba68-d8c8-4700-b438-b47e9b8a4525@pengutronix.de>
Date: Mon, 13 May 2024 14:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] clk: imx: imx8mp: fix clock tree update of TF-A
 managed clocks
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>,
 linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 Abel Vesa <abel.vesa@linaro.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-8-c998f315d29c@nxp.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240510-imx-clk-v2-8-c998f315d29c@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Peng,

The commit message looks eerily familiar ;)
Small correction below.

On 10.05.24 11:19, Peng Fan (OSS) wrote:
> From: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> 
> On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
> for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
> SiP and then does clk_set_parent on the DDR muxes to synchronize
> the clock tree.
> 
> since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
> these TF-A managed muxes have SET_PARENT_GATE set, which results
> in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:
> 
> clk_set_parent(dram_apb_src, sys1_pll_40m);(busfreq-imx8mq.c)
> 
> This is safe to do, because updating the Linux clock tree to reflect
> reality will always be glitch-free.

This refers to the next sentence, thus swap position of this sentence
with the next one:

> 
> commit 926bf91248dd
> ("clk: imx8m: fix clock tree update of TF-A managed clocks") adds this
> method and enables 8mm, 8mn and 8mq. i.MX8MP also needs it.
s/this method/imx8m_clk_hw_fw_managed_composite which sets the SET_PARENT_GATE flag/

> 
> Another reason to this patch is that powersave image BT music
> requires dram to be 400MTS, so clk_set_parent(dram_alt_src,
> sys1_pll_800m); is required. Without this patch, it will not succeed.
> 
> Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

With commit message adjusted:

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Thanks,
Ahmad

> ---
>  drivers/clk/imx/clk-imx8mp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 670aa2bab301..e561ff7b135f 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  
>  	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
>  
> -	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
> -	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
> +	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
> +	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
>  	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
>  	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
>  	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


