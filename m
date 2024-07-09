Return-Path: <linux-kernel+bounces-245408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82692B22E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BA71F21F5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80812153509;
	Tue,  9 Jul 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wsEFis3C"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240412D75A;
	Tue,  9 Jul 2024 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720513851; cv=none; b=cSz8qfo7rUiF3IijXgJZ4H6f7VW/3eNSVZa9JtQan+TVpsbDBB7dfGaKGZKjXuk/jNLxWYusQ0XjuH7RMgjOroPKVHE4MRUI2eaPeBpXqerTAwRXS1A3q3qTfTFelHlszNnpbaxqVBYURcTCKdBgIKBimL3/XGftMFLVtJv/p9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720513851; c=relaxed/simple;
	bh=4ddWApf5yRC6Suz8B9WVJ/vHSrjM8rDrQEFG9pPzp1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=la8AYASPKPpwbZN8e7fuyB+i/bHASmmgYF++qWKFevzsWL0AddLdsuaKujV9rz0RT7jxnafvfFrVBkzYKPKpoi8bIrjQCp0yYxwi/bBRYYeKcOpP1cf6GxxgE3et11YCFO+nDYx5/PVX8aF8uQ/nJblN52WdKv4cTkeVKUvWqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wsEFis3C; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46970J4r031206;
	Tue, 9 Jul 2024 10:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4ddWApf5yRC6Suz8B9WVJ/vHSrjM8rDrQEFG9pPzp1s=; b=wsEFis3CIz+Vjztg
	XX4X+LydYiLGCdtCM6SabJwpr3ie+6IWfe5khJcstAyiK9MvQwDF62bwvkt+yG5m
	WDGDPT+PiVLG5MPbHD2Q2e2FY6eIYnYZhCjGYuOyEeo3T5qWd42xn8v+kCq8Kvgy
	e589FH4mwHKGI+kOz6DHR0tWMTBeTwQY1auHQeTPmnp1B1rdgdQDAXzgKskL8EMU
	+wQu9wpBqV2WDdxYpOfPfrGHSfmb2vWyXqx4lO6L9/KD1Nw+OacTQ0gnZd4aBXYe
	V4SCC36O5e0JsvY66L55pTxUy6+WgmoQZ6i8euGr9g02YRXW+Jlej17VdIaj7tHA
	N6dp+Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 406whft9m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 10:30:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id ADADB40044;
	Tue,  9 Jul 2024 10:29:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09C5F216821;
	Tue,  9 Jul 2024 10:28:55 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jul
 2024 10:28:53 +0200
Message-ID: <f8295b75-1c98-44d3-9da3-92cc192297e2@foss.st.com>
Date: Tue, 9 Jul 2024 10:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: Fix an error handling path in
 stm_drm_platform_probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Anholt <eric@anholt.net>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Yannick Fertre" <yannick.fertre@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20fff7f853f20a48a96db8ff186124470ec4d976.1704560028.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20fff7f853f20a48a96db8ff186124470ec4d976.1704560028.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01


On 1/6/24 17:54, Christophe JAILLET wrote:
> If drm_dev_register() fails, a call to drv_load() must be undone, as
> already done in the remove function.
>
> Fixes: b759012c5fa7 ("drm/stm: Add STM32 LTDC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Hi Christophe,

After some delay: applied on drm-misc-next.

Thanks,
Raphaël


