Return-Path: <linux-kernel+bounces-226733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49369142D2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3EAB241A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF25376F1;
	Mon, 24 Jun 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="562J2h7w"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407553A8D2
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210877; cv=none; b=ruj71pRCh+418qIkYY9eUP527mjFOofaTrQmCYIPAnN4vmZLeK57V6evfPa/7HrOOWKiJotjYDlbo6lT2XMhf6sKMY8bGqN9aIaXzurhG0BS0X3xXPHNMsBShuVpLedOhHDIEhRORUJPWgscHv1FDtisebmIIk6ZoJ1G5zga5pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210877; c=relaxed/simple;
	bh=SteysrwAHMMgc3MdIJ01b3nEIBxSaycWXBNfyu+17y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rEEf7DK/qAoQLSKW5Xfynv+evvsKw9tGglA6NKinz9WXfEYTZie4OGut1RA0tV7gRwKzIbrQqkv3QPeYq4kPhtuPDS5rW8p/hrAOCmq9w+mjyiaNuNdzioeHbCuM0uqAL7EJRtLx0Dr3Cvm9FZ3i9l63sHAOKH4o38P9ZEsSRek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=562J2h7w; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O2RW1Z023858;
	Mon, 24 Jun 2024 08:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AYdNd57iAuRtoezAk2Hw4WaTeN0KxsUMdYBv57EkAXM=; b=562J2h7wZJ4LeIMR
	C3h7xoriDTH5zmwWtUtz4m68927A0dbGLaR/B/WVz7gRjdDZlJpx+8CpMKlP7EVS
	zBL/IRZRNWYyPz+WHHYWuUhIJNLHFTkGTy1+EfjhfE4lBRulGyf/FhRmWbT/8RJl
	yv23aeErmZBg+a7Xtxq4hOFRyNgvPb1Vkp1G+B3vv7grer9n0tD8p8JsmZ0XXmqf
	Cz3fQYHqBQUbFD363DmjUmbEuyqh7QTJXTovOJyUFL3BeQPGXyKUmXfJa44nzZP5
	MM++5puibrzkYSkHawxmJztzKbT9/l1m9OykHs51AbeECS4DCRJV/ql9Nzu09uFb
	Z96O5A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywm1g5qbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 08:34:21 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C32440044;
	Mon, 24 Jun 2024 08:34:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B07C82105AF;
	Mon, 24 Jun 2024 08:33:59 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 08:33:59 +0200
Message-ID: <00f3fe1f-1778-4b7d-b905-8a7017cc68ac@foss.st.com>
Date: Mon, 24 Jun 2024 08:33:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reset: sti: allow building under COMPILE_TEST
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@pengutronix.de>
References: <20240621-reset-compile-sti-v1-1-b7a66ce29911@pengutronix.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240621-reset-compile-sti-v1-1-b7a66ce29911@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_06,2024-06-21_01,2024-05-17_01



On 6/21/24 17:21, Philipp Zabel wrote:
> The STIH407 reset driver can be compiled without ARCH_STI being
> enabled. Allow it to be built under COMPILE_TEST.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Makefile    | 2 +-
>  drivers/reset/sti/Kconfig | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..ff716f9afc84 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -2,7 +2,7 @@
>  obj-y += core.o
>  obj-y += hisilicon/
>  obj-y += starfive/
> -obj-$(CONFIG_ARCH_STI) += sti/
> +obj-y += sti/
>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>  obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
>  obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
> diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
> index a2622e146b8b..0b599f7cf6ed 100644
> --- a/drivers/reset/sti/Kconfig
> +++ b/drivers/reset/sti/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -if ARCH_STI
> +if ARCH_STI || COMPILE_TEST
>  
>  config STIH407_RESET
> -	bool
> +	bool "STIH407 Reset Driver" if COMPILE_TEST
>  
>  endif
> 
> ---
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> change-id: 20240621-reset-compile-sti-ca6c2ddd0c63
> 
> Best regards,

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

