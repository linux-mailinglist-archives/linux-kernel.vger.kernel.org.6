Return-Path: <linux-kernel+bounces-252202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7B930FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD57A1C216E6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422921849E9;
	Mon, 15 Jul 2024 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SagcaH2C"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B9184100
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032506; cv=none; b=iV/PU5+vSzreiQRGyNMvYGDLyUgK2Y99eRMLR5rPaLR8EtbT1soLSXrdRTyj3oybHmX4OSpXQeNfrVAS7MzyRBux5i1aGmuFjkCeYICXzeakxAE6HKYjxd041NgCOaKR8zidlb+pQiTZ6npBcah6y/zrmOyEyNT6m2TURDSc9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032506; c=relaxed/simple;
	bh=JW1v9I2QQq6tb8htzQlK+uUAsMhkhshbWkdi6NH34IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iPyOrVYsJaQb+UmNtNv7C1haDxGvXaQZgVSwmJA4FYrSBcSI1EB+ZS+3nbCDUMp4bQAgeUlmwaqYhAHSmJITiiTRNfdmBygFGEgzuek+ZOBZu8p8eRyz2i403OTLRQvKSc4g1z3lMzy7BcRWkrfP6OlonWPYsudoEN7oocfxxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SagcaH2C; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F7qhhC029356;
	Mon, 15 Jul 2024 10:34:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JW1v9I2QQq6tb8htzQlK+uUAsMhkhshbWkdi6NH34IU=; b=SagcaH2C4xzMgF4c
	c+Ga/kBrOnnKUsu2zRE7GEw8U5aWpvcVCLf9wq356oesQ+SNw/88kxPaD2ApXpnp
	TRfutITol0CmXQp+n63b4/IYUXT9vHrcfESb/TYdkBR4cp3rBrD/ZBZ1dms0OpdP
	x7YoEi3JrrQnlf9TgPORH8JpT07O5PSZMZ74QOAc3UnSKN/ahTkFJk7U/biHSDBN
	/Vn+XKXVr29RoKPsMdNJsdZkql3Up6hd/ciM0zSNI9Y91mSsF58y4sb2HxcPYdxa
	cuQNy8JyBXoGkWVvTUfAIyN2n3VjUOdb6iuiwOeH880mS3AHOQngboI7Wu4+J//q
	mbcvGA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40bgwx5sj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 10:34:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B799940045;
	Mon, 15 Jul 2024 10:34:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 447DE20E037;
	Mon, 15 Jul 2024 10:33:57 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 15 Jul
 2024 10:33:54 +0200
Message-ID: <ddc81a62-08d5-4f23-b86c-10754fb3e717@foss.st.com>
Date: Mon, 15 Jul 2024 10:33:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: check memory returned by devm_kzalloc()
To: Claudiu Beznea <claudiu.beznea@microchip.com>,
        <yannick.fertre@foss.st.com>, <philippe.cornu@foss.st.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230531072854.142629-1-claudiu.beznea@microchip.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230531072854.142629-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_03,2024-07-11_01,2024-05-17_01


On 5/31/23 09:28, Claudiu Beznea wrote:
> devm_kzalloc() can fail and return NULL pointer. Check its return status.
> Identified with Coccinelle (kmerr.cocci script).
>
> Fixes: 484e72d3146b ("drm/stm: ltdc: add support of ycbcr pixel formats")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>
> Hi,
>
> This has been addressed using kmerr.cocci script proposed for update
> at [1].
>
> Thank you,
> Claudiu Beznea
>
> [1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/
>
Hi Claudiu,

After some delay: applied on drm-misc-next.

Thank,
Raphaël


