Return-Path: <linux-kernel+bounces-376395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A229AB0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F0DB22CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D01A0B16;
	Tue, 22 Oct 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOpquXSX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5388719EED0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607256; cv=none; b=cYM5HSdVpVqCSxi5QNNy1IzQLlIkgCO7COsf/JnLsgbMqv6my9ZuIRGpWZNiE9frVEkyti6gMI3UXgDFie5GRmHbQlKdOw+iBFN7ML6HjRvxni8zPrB4Vev0ac+d/vxQs++cY3Lfnta2UX1YzOu7dM5vS5cKXElJlNLOmWZ4dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607256; c=relaxed/simple;
	bh=EEGZjkBVFIydk64RZp3TZOhsFaf+H/aAhwxYkoxUgWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOD9gZ31aLTIAhXrUa+J7Q6e3ElCriQmdNJqjSbfYwGwbeqWR9p77vnMH44At0LkNbcwHSPD0hhpHNpIer0emJOc6t+6MrVSgZuo2UxDx0/caxTw5tG1J2AviS04RHTGbAA0skInavZc/xeGEOVT6WlaR33BMwg19RxoEdiSds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KOpquXSX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431695fa98bso32458755e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729607252; x=1730212052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng8I+0cJXe7sxBRT/nYKZfXgC2lDhrQoGCa5lmPF3wo=;
        b=KOpquXSXaVLYFcnnNFX0hhPZ6+/IiDS6wBiiY2MPT93VWWFarsJ9XWMZre9OlRN0ws
         flxd4vWYvAzL8jF6JAqQX2QwhGr1ltMbt3VctwLRF0Xxry6Gw2q1C4o+kE3kPjJkuDTk
         7n+6/9iu8Bli2lOPeu5SnkWJyH6rxrBCJPvIaKheayo5qJi/VrQXmrYK6tyL7TmWui+e
         7Gc/kqkUNJOrNoc+qjTMM83VsgP86msHKceEiJPedCzDNkYLuBMkAgYSKU8r6Cl4xQFI
         NCJCcoN2wJaxitLIS41TQC+jma/jx8JA4drqCbYTvnb92bYID4N1VwvNd9/GKyjXTm8D
         t8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729607252; x=1730212052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ng8I+0cJXe7sxBRT/nYKZfXgC2lDhrQoGCa5lmPF3wo=;
        b=uGmWGMoj8Gr3r0aEmFIr/VCsmoLYio2gIAVc2yhOVwRnkApYVp03Lbp4hQZHhDbemM
         xYxjGwB0Oaym7Uxl6MjvzqmDySTJfppbUZn4qQz9AFsLCFQoybja1KGGIBoMcOL8UVcZ
         l6E/h5Foxgxojg0T5WjzjXwOCju+gNjaVbFB3BIvJYhY7vDuzLbMSPnDyxVQrfnydFak
         DB8HuxH0JZCR5507Pi3CJk4l9MF53Yx5FtR2LyPwfideqwbEpWaCBayPtsAkALFSpjUh
         mk08yYUQlcU/aZoLeDnT4lLje+JDPgdjTm0NSNVBDEysWV2zYUyPB5qQNSV8OYeJOy2Y
         kDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbBryGj5KSdb2ESLX7tZ/FmaKa0WgPqPF9sTnhSsKSQjUEwjRg8VlpZim9rmtI808Vu92JSNnGKfVKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxViebmNHoVBaJ6Lw0ZK/hi4yG4fArIFkj+OgFQXZ1a8pmn5qW
	D53kbsdqIJWleiZvpLwzJzSuk87Yck1YGSq280DgillotAKunRsCjJdL3g9A4qI=
X-Google-Smtp-Source: AGHT+IHQr5kFrKkenH9d+GMyxeVy1Tq7YzzpDy2LwfKIpAZkqFFPymqGx6C8CE6KYGTO2dSqHqAtkA==
X-Received: by 2002:a05:600c:35c6:b0:431:547e:81d0 with SMTP id 5b1f17b1804b1-431616318e5mr126513205e9.11.1729607251813;
        Tue, 22 Oct 2024 07:27:31 -0700 (PDT)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57f89fsm88544175e9.16.2024.10.22.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:27:31 -0700 (PDT)
Date: Tue, 22 Oct 2024 17:27:29 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Pengfei Li <pengfei.li_1@nxp.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] clk: imx: add i.MX91 clk
Message-ID: <Zxe2UUzhAR3yfG8L@linaro.org>
References: <20241017225137.1158924-1-pengfei.li_1@nxp.com>
 <20241017225137.1158924-5-pengfei.li_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017225137.1158924-5-pengfei.li_1@nxp.com>

On 24-10-17 15:51:37, Pengfei Li wrote:
> Reuse i.MX93 clk driver for i.MX91, because i.MX91 reuses the
> Clock Control Module from i.MX93, with only a few clocks removed
> and a few clocks added.
> 
> For clocks specific to i.MX93 use PLAT_IMX93 to flag them, for
> clocks specific to i.MX91, use PLAT_IMX91 to flag them. Others
> are shared by both.
> 
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 64 +++++++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index c8b65146e76e..4d1123f51903 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -15,7 +15,11 @@
>  
>  #include "clk.h"
>  
> -#define IMX93_CLK_END 202
> +
> +#define IMX93_CLK_END 207
> +
> +#define PLAT_IMX93 BIT(0)
> +#define PLAT_IMX91 BIT(1)
>  
>  enum clk_sel {
>  	LOW_SPEED_IO_SEL,
> @@ -55,6 +59,7 @@ static const struct imx93_clk_root {
>  	u32 off;
>  	enum clk_sel sel;
>  	unsigned long flags;
> +	unsigned long plat;
>  } root_array[] = {
>  	/* a55/m33/bus critical clk for system run */
>  	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
> @@ -65,7 +70,7 @@ static const struct imx93_clk_root {
>  	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
>  	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
> @@ -122,15 +127,15 @@ static const struct imx93_clk_root {
>  	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
>  	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
> -	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
> +	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
>  	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
>  	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
> +	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
>  	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
>  	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
> -	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
> -	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
> +	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
>  	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
>  	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
> @@ -139,13 +144,16 @@ static const struct imx93_clk_root {
>  	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
>  	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
>  	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
> -	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
> -	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
> -	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
> -	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
> +	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX91_CLK_ENET1_QOS_TSN, 	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
> +	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
> +	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
> +	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
> +	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
>  	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
>  };
> @@ -157,6 +165,7 @@ static const struct imx93_clk_ccgr {
>  	u32 off;
>  	unsigned long flags;
>  	u32 *shared_count;
> +	unsigned long plat;
>  } ccgr_array[] = {
>  	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
>  	/* M33 critical clk for system run */
> @@ -246,8 +255,10 @@ static const struct imx93_clk_ccgr {
>  	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
>  	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
>  	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
> -	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
> -	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
> +	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
> +	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
> +	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular",        "wakeup_axi_root",      0x9e00, 0, NULL, PLAT_IMX91, },
> +	{ IMX91_CLK_ENET1_QOS_TSN_GATE,     "enet1_qos_tsn",        "wakeup_axi_root",      0x9e40, 0, NULL, PLAT_IMX91, },
>  	/* Critical because clk accessed during CPU idle */
>  	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
>  	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
> @@ -267,6 +278,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  	const struct imx93_clk_ccgr *ccgr;
>  	void __iomem *base, *anatop_base;
>  	int i, ret;
> +	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
>  
>  	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
>  					  IMX93_CLK_END), GFP_KERNEL);
> @@ -316,17 +328,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
>  		root = &root_array[i];
> -		clks[root->clk] = imx93_clk_composite_flags(root->name,
> -							    parent_names[root->sel],
> -							    4, base + root->off, 3,
> -							    root->flags);
> +		if (!root->plat || root->plat & plat)
> +			clks[root->clk] = imx93_clk_composite_flags(root->name,
> +						parent_names[root->sel],
> +						4, base + root->off, 3,
> +						root->flags);
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
>  		ccgr = &ccgr_array[i];
> -		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
> -						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
> -						 ccgr->shared_count);
> +		if (!ccgr->plat || ccgr->plat & plat)
> +			clks[ccgr->clk] = imx93_clk_gate(NULL,
> +				ccgr->name, ccgr->parent_name,
> +				ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
> +				ccgr->shared_count);
>  	}

CHECK: Alignment should match open parenthesis             
#137: FILE: drivers/clk/imx/clk-imx93.c:333:            
+                       clks[root->clk] = imx93_clk_composite_flags(root->name,      
+                                               parent_names[root->sel],             
                                                           
CHECK: Alignment should match open parenthesis
#149: FILE: drivers/clk/imx/clk-imx93.c:342:
+                       clks[ccgr->clk] = imx93_clk_gate(NULL,                       
+                               ccgr->name, ccgr->parent_name,                       


Please run checkpatch before sending.

I'll apply once these are fixed.

>  
>  	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
> @@ -356,7 +371,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id imx93_clk_of_match[] = {
> -	{ .compatible = "fsl,imx93-ccm" },
> +	{ .compatible = "fsl,imx93-ccm", .data = (void *)PLAT_IMX93 },
> +	{ .compatible = "fsl,imx91-ccm", .data = (void *)PLAT_IMX91 },
>  	{ /* Sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
> -- 
> 2.34.1
> 

