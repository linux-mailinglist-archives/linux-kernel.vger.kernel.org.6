Return-Path: <linux-kernel+bounces-298850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169795CC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5427A1C23C34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D624185B58;
	Fri, 23 Aug 2024 12:12:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18A185956
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415168; cv=none; b=QDZS5zIAyDuxHrNPtfl8et94Z4YA6ezi26bi88MoNe/0IatJNfN7V8gtaedh9ARCw5Yfu714Kzbu1G7YXf5Yc32VmT6LztPIXrU2g9HkVSdp1GYjGehyXIk8sFQTXHVSUpS1HE312S9Ml/Fq0cA/FQOxoZ1OplA3pi3u0x3VQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415168; c=relaxed/simple;
	bh=wxf4ZTtApPO4zVUrq/W6Nm1Ge0ewxwhuvWmGe7H6uyI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEjsKh3m1lEwXAm42sExG1j4esK9pibjuUy/PLGQuQpC31iIcjwfsaaxxVfqxD1QVBITBOjcKQTAsX0/WMj36haaxbEyFfXm0MnSoODg+/Wnto4ErAdzg5pjTdAOMOl+Cb6Lf9UK66TrRM3bCIGx5w4DG3l1TOjmJtWhVoqGAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqzPk4NKxz6G9PJ;
	Fri, 23 Aug 2024 20:08:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C8421400D4;
	Fri, 23 Aug 2024 20:12:43 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 13:12:43 +0100
Date: Fri, 23 Aug 2024 13:12:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wu Bo <bo.wu@vivo.com>
CC: <linux-kernel@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] bus: imx-weim: change to use devm_clk_get_enabled()
 helpers
Message-ID: <20240823131242.000070b2@Huawei.com>
In-Reply-To: <9bcf916828934b497ea13d27405105159aef1bff.1724408198.git.bo.wu@vivo.com>
References: <6afc96fc30403966d9be783c659b422186000a86.1724408198.git.bo.wu@vivo.com>
	<9bcf916828934b497ea13d27405105159aef1bff.1724408198.git.bo.wu@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 04:22:11 -0600
Wu Bo <bo.wu@vivo.com> wrote:

> Make the code cleaner and avoid call clk_disable_unprepare()
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  drivers/bus/imx-weim.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 837bf9d51c6e..81483461b514 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -282,19 +282,13 @@ static int weim_probe(struct platform_device *pdev)
>  	dev_set_drvdata(&pdev->dev, priv);
>  
>  	/* get the clock */
> -	clk = devm_clk_get(&pdev->dev, NULL);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	ret = clk_prepare_enable(clk);
> -	if (ret)
> -		return ret;
> -
>  	/* parse the device node */
>  	ret = weim_parse_dt(pdev);
> -	if (ret)
	if (ret)
		return ret;

	dev_info()

	return 0;


> -		clk_disable_unprepare(clk);
> -	else
> +	if (!ret)
>  		dev_info(&pdev->dev, "Driver registered.\n");
>  
>  	return ret;


