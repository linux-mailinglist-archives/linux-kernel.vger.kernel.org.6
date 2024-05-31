Return-Path: <linux-kernel+bounces-197020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F28D650F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABC31F2699F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB36F318;
	Fri, 31 May 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cgV8psTi"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804B6F2EB;
	Fri, 31 May 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167553; cv=none; b=b0riGXPLo7OMMGhiy6P4vP589cIwBlxA6eldH4hm2csOQmaWEBOUg9Sm2uvQhSkl+iQkpKFYCIPh1j/GFUUL5sKgFHLvKa9HeipFW4DvGKx06FBXhgf8RgdLiUAT/zkDGY+tbn6mf7/ShIq3H1Wn93au+2rxXmtI1BgAFTx09bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167553; c=relaxed/simple;
	bh=9+6h3DiodrT9YFrdp+kdRsd+uvX5l44PO21I4T4zFO4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaJtWdqUsnXtb9munJsZjDSJS24deBDnIKEAef+bzlIYLsdPR545lVbIJVLbFUHqE5ISGCMQEabcuI7fYr3vFve6xioiUNFhygj+Cv3cMrY3T39mfmyAan0MY3eHoL4vELeKGfacHHqDgUI7p0Ep2TrxqKlJHACQe8oL3xaqM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cgV8psTi; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9Swso003313;
	Fri, 31 May 2024 09:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=hxGvSEqlUm/4Gr1/Y7
	FisaucBu8jAHnTKI/Obg6VI9c=; b=cgV8psTiVp2etlgNlYKT/Xz5UTa72Adwnp
	Mz2p1O9qHqFUPa15bt9k4vOaw0BFh7bPfJ1p4wP2ArTWshr7L1GtTFZWa18VmbEX
	efyhNCr7LGDVTGEkFIdZ0+fQ7lrmWR08B7gFutkTdq4gik7dVbbMx17C3hPbsiqX
	FCCs7+w31Fz3cjSd/vTp8fxiOXlBH0SixpDYUeNAgOZyC/WqXTvNGN/y23eabUCD
	5uteqKIcoNKlQlCxYfRo5l/rbU0dUpjor+W6lYVOnFoOCyW4y/NdaGcm+icIdEzg
	FzQyVFTV5U46MBSRn9vkeAmsXDfnV3tfBs9CiTKaysNGvNIL1WOg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ybdcwwwuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:58:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 15:58:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 31 May 2024 15:58:04 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 05CBE820244;
	Fri, 31 May 2024 14:58:04 +0000 (UTC)
Date: Fri, 31 May 2024 14:58:02 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rob Herring <robh@kernel.org>, Weidong Wang <wangweidong.a@awinic.com>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
        Shenghao Ding <shenghao-ding@ti.com>,
        "Marco Felsch" <m.felsch@pengutronix.de>,
        Alper Nebi Yasak
	<alpernebiyasak@gmail.com>,
        Chancel Liu <chancel.liu@nxp.com>,
        "Kuninori
 Morimoto" <kuninori.morimoto.gx@renesas.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linuxppc-dev@lists.ozlabs.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "James
 Schulman" <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner
	<heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v1 1/6] ASoC: codecs: Remove unused of_gpio.h
Message-ID: <ZlnleuSae2C6/WRU@opensource.cirrus.com>
References: <20240530230037.1156253-1-andriy.shevchenko@linux.intel.com>
 <20240530230037.1156253-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240530230037.1156253-2-andriy.shevchenko@linux.intel.com>
X-Proofpoint-GUID: QOHrrhhsAlL1BvB8LD1NFqOZRJaPkXqI
X-Proofpoint-ORIG-GUID: QOHrrhhsAlL1BvB8LD1NFqOZRJaPkXqI
X-Proofpoint-Spam-Reason: safe

On Fri, May 31, 2024 at 01:58:47AM +0300, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove. The drivers in question
> don't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/codecs/cs53l30.c        | 1 -

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

