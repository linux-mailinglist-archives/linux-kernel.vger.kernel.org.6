Return-Path: <linux-kernel+bounces-224717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E0A912601
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C597A1F26366
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB4152790;
	Fri, 21 Jun 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CJPhnDgg"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE8374CB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974334; cv=none; b=Ri1BAw1FA/hqBHFXo3jUVo27Dv7Bz+U4J81F7R8eCtjAeemKk0HarCogYtKSxJt2IGv9vDL2rL+95xO4YNnEsQU+QA4BpR2+vL6Gq0O6NBejfKpy04uG7H4p+biynGmw1miEW/HvOdSaOym8yQLhqaO6ISt0U/jBwe/BD3YERE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974334; c=relaxed/simple;
	bh=J6HJD+3VycErkeut20jaMSHoaezmyVeZb7e1McWGOlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z3ca4ex3iwdLsdwDiZuaCcUfhJyjl8o4nBfOMTGqF0G5SYl9qHe3mHRwyJra0d7ll6q5NOvPVJhz75eLbIn+Y/pp7Nxqq9TRPw6zUi2d9Voo7fcjbZKQvOv9Uwp/KIgkKyLddtlBVeA7khoSIZWSzSkOLTMKIPg1C5MAse3xpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CJPhnDgg; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBc0dZ007039;
	Fri, 21 Jun 2024 14:51:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	faGsSAC8ulOthkvxWXbNTJoYirta5hMr2PYlnCbqe+A=; b=CJPhnDggnyBO2OL6
	QBlbiCq+wpmtunvZJ4Aw8T4+S9jxDpULUeCkAj6lQTxhsH2QzXVeZwCcKCACFZEs
	DTV1vfUuhCpHHjP+lI9pV44RHlDolTi1PeuXwP3PVYH4Ox0cCHdyPC5mw4vNe20S
	+/6SNeV80q4IIFEGh/SdbBdSxn96C/4aDiJGeO+XWXeewqTMBZN9WyeH6a+kRtM7
	DpVtM0sTHh05bMCsfSZPfPe7aVnY0nhyR5WigSvJ9Gg/w2Gy1chCluapmNxmDLwN
	D3T07wohV2QasIKyegJe5LaQDCbJctibgVxJYkKkFigWLp9FfSl185LNK5quPKU1
	YmmpxQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yvrkk3nub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:51:44 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DC35D4002D;
	Fri, 21 Jun 2024 14:51:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1399E21F15B;
	Fri, 21 Jun 2024 14:50:59 +0200 (CEST)
Received: from [10.48.87.177] (10.48.87.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 21 Jun
 2024 14:50:58 +0200
Message-ID: <f95e0485-0073-40b1-84ae-535b55d0cd0d@foss.st.com>
Date: Fri, 21 Jun 2024 14:50:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/3] drm/stm: dsi: add pm runtime ops
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240129104106.43141-1-raphael.gallais-pou@foss.st.com>
 <20240129104106.43141-3-raphael.gallais-pou@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20240129104106.43141-3-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01

Hi Raphael,

thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>

BR


Le 29/01/2024 à 11:41, Raphael Gallais-Pou a écrit :
> From: Yannick Fertre <yannick.fertre@foss.st.com>
>
> Update control of clocks and supply thanks to the PM runtime
> mechanism to avoid kernel crash during a system suspend.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Changes in v2:
> 	- Changed SET_RUNTIME_PM_OPS to RUNTIME_PM_OPS and removed
> 	__maybe_unused
> ---
>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index b1aee43d51e9..82fff9e84345 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -11,6 +11,7 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/regulator/consumer.h>
>   
>   #include <video/mipi_display.h>
> @@ -77,6 +78,7 @@ enum dsi_color {
>   struct dw_mipi_dsi_stm {
>   	void __iomem *base;
>   	struct clk *pllref_clk;
> +	struct clk *pclk;
>   	struct dw_mipi_dsi *dsi;
>   	u32 hw_version;
>   	int lane_min_kbps;
> @@ -443,7 +445,6 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct dw_mipi_dsi_stm *dsi;
> -	struct clk *pclk;
>   	int ret;
>   
>   	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
> @@ -483,21 +484,21 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>   		goto err_clk_get;
>   	}
>   
> -	pclk = devm_clk_get(dev, "pclk");
> -	if (IS_ERR(pclk)) {
> -		ret = PTR_ERR(pclk);
> +	dsi->pclk = devm_clk_get(dev, "pclk");
> +	if (IS_ERR(dsi->pclk)) {
> +		ret = PTR_ERR(dsi->pclk);
>   		DRM_ERROR("Unable to get peripheral clock: %d\n", ret);
>   		goto err_dsi_probe;
>   	}
>   
> -	ret = clk_prepare_enable(pclk);
> +	ret = clk_prepare_enable(dsi->pclk);
>   	if (ret) {
>   		DRM_ERROR("%s: Failed to enable peripheral clk\n", __func__);
>   		goto err_dsi_probe;
>   	}
>   
>   	dsi->hw_version = dsi_read(dsi, DSI_VERSION) & VERSION;
> -	clk_disable_unprepare(pclk);
> +	clk_disable_unprepare(dsi->pclk);
>   
>   	if (dsi->hw_version != HWVER_130 && dsi->hw_version != HWVER_131) {
>   		ret = -ENODEV;
> @@ -551,6 +552,7 @@ static int dw_mipi_dsi_stm_suspend(struct device *dev)
>   	DRM_DEBUG_DRIVER("\n");
>   
>   	clk_disable_unprepare(dsi->pllref_clk);
> +	clk_disable_unprepare(dsi->pclk);
>   	regulator_disable(dsi->vdd_supply);
>   
>   	return 0;
> @@ -569,8 +571,16 @@ static int dw_mipi_dsi_stm_resume(struct device *dev)
>   		return ret;
>   	}
>   
> +	ret = clk_prepare_enable(dsi->pclk);
> +	if (ret) {
> +		regulator_disable(dsi->vdd_supply);
> +		DRM_ERROR("Failed to enable pclk: %d\n", ret);
> +		return ret;
> +	}
> +
>   	ret = clk_prepare_enable(dsi->pllref_clk);
>   	if (ret) {
> +		clk_disable_unprepare(dsi->pclk);
>   		regulator_disable(dsi->vdd_supply);
>   		DRM_ERROR("Failed to enable pllref_clk: %d\n", ret);
>   		return ret;
> @@ -582,6 +592,8 @@ static int dw_mipi_dsi_stm_resume(struct device *dev)
>   static const struct dev_pm_ops dw_mipi_dsi_stm_pm_ops = {
>   	SYSTEM_SLEEP_PM_OPS(dw_mipi_dsi_stm_suspend,
>   			    dw_mipi_dsi_stm_resume)
> +	RUNTIME_PM_OPS(dw_mipi_dsi_stm_suspend,
> +		       dw_mipi_dsi_stm_resume, NULL)
>   };
>   
>   static struct platform_driver dw_mipi_dsi_stm_driver = {

