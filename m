Return-Path: <linux-kernel+bounces-224774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245C9126BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C0AB21A31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621FE79D8;
	Fri, 21 Jun 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="joQzu6Pf"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788F63BF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976846; cv=none; b=hPnPnj3bcWBu4mog45ju1Llwc5LwFXdw3pxNQx1YK3mJGJt/dEfJnbyMwITqGuW+V0I2dHGNFS1QiJMcLVlTZ871vRZuQGwojwYa2qQHkkjsWKP8cwivCzS6JV1WhKSOxewUPsUN0SyP3DNqrX3sj9Ep/f5hcYP4gKaBwgX1Yhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976846; c=relaxed/simple;
	bh=7V0RclItNFdKo29WOSpHddexvDxa6KYtY5l56bgncyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=IO4BzKngovoGkZbX2jNzvLNQbrNiF18/HpsOajVOmy5/3usLAff+gLaam/7U2D/Gk9xeta09jfDSrTzv1OTxmPpAyQF9zFw6vLoksslaZuM6QG8vhk6OoqyPGTZETqFPCpEvpw2u7ZQ3Si2vOj2bRkXbNhgV3WwG0RG0zeEKREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=joQzu6Pf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LB3BRq021260;
	Fri, 21 Jun 2024 15:33:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7V0RclItNFdKo29WOSpHddexvDxa6KYtY5l56bgncyo=; b=joQzu6Pf829wWuft
	mvJv87vpSqWVXiOZWA+bAqqmzslUFyEAvPJuzYRN+lI0yNlCl+M+uPn7exIwGDkQ
	bgxV/lz9d1yWH5QkfCyCpH73vz2G5cz+njQMV5CYx7tTwE8xXfrP9nB9aVJfVkpp
	EITOg+lucS4jbqqjnAJt5Z+10Kzc0PPv5OH8jI4NZ7LRy/hxO5AkiyvogIdd7piN
	m+hb+DtY9tk7heqkHsTK4wdwsCc7KLL5dPXMSZcD0JUs4xCU4wJ/IrE20E61zs6X
	8O7lpsr99DGIRiBaRACWH45Isxcv2y5dgyJFWpN4wKqg9RL3Md/iLtW0ak9DPDba
	ShZsZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yvrkbkvv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 15:33:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B679B40044;
	Fri, 21 Jun 2024 15:33:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C2B4D221942;
	Fri, 21 Jun 2024 15:32:54 +0200 (CEST)
Received: from [10.48.87.177] (10.48.87.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 21 Jun
 2024 15:32:54 +0200
Message-ID: <902e6037-9ba9-41ab-bfd0-a25fe2c26bce@foss.st.com>
Date: Fri, 21 Jun 2024 15:32:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TR: [PATCH v4] drm/stm: Avoid use-after-free issues with crtc and
 plane
To: Katya Orlova <e.orlova@ispras.ru>
References: <20240216125040.8968-1-e.orlova@ispras.ru>
 <0b91cb58-b9ca-4c67-b15a-77c60bc2ee18@foss.st.com>
 <ef635048bc7b4521be09ca06c66b57a5@foss.st.com>
Content-Language: en-US
CC: Philippe Cornu <philippe.cornu@foss.st.com>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <ef635048bc7b4521be09ca06c66b57a5@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_05,2024-06-21_01,2024-05-17_01

Hi Katya,

thanks for the patch.

Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>

BR

Le 19/03/2024 à 14:47, Philippe CORNU - foss a écrit :
> zut, déjà un acked-by de RGA...
> tu confirmes que je prends?
> Philippe
> ________________________________________
> De : Raphael GALLAIS-POU - foss
> Envoyé : lundi 26 février 2024 14:50
> À : Katya Orlova
> Cc : Yannick FERTRE - foss; Philippe CORNU - foss; David Airlie; Daniel Vetter; Maxime Coquelin; Alexandre TORGUE - foss; Philipp Zabel; dri-devel@lists.freedesktop.org; linux-stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org
> Objet : Re: [PATCH v4] drm/stm: Avoid use-after-free issues with crtc and plane
>
> On 2/16/24 13:50, Katya Orlova wrote:
>> ltdc_load() calls functions drm_crtc_init_with_planes(),
>> drm_universal_plane_init() and drm_encoder_init(). These functions
>> should not be called with parameters allocated with devm_kzalloc()
>> to avoid use-after-free issues [1].
>>
>> Use allocations managed by the DRM framework.
>>
>> Found by Linux Verification Center (linuxtesting.org).
>>
>> [1]
>> https://lore.kernel.org/lkml/u366i76e3qhh3ra5oxrtngjtm2u5lterkekcz6y2jkndhuxzli@diujon4h7qwb/
>>
>> Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
> Hi Katya,
>
>
> Thanks for this submission.
>
> Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
>
>
> Regards,
> Raphaël
>

