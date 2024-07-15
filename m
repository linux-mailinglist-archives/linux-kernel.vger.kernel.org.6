Return-Path: <linux-kernel+bounces-252286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD39310F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241C1B237C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8212185E76;
	Mon, 15 Jul 2024 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="B9roO90g"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7F185E73
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034849; cv=none; b=IkR98WYXVlNLxn56LIQW77WZmIrsZpvJPQtSWOUzjDlcSlWOV2s92y9NugnzrfQR5vmljWk195s1aFQnurSmgFYMHTRIaKIJCG/nREb9Ec3v97dAUiRVC+bJX3FDCjz+0UcbYjghpqbXzehMbl5xm35v6gvzkcneDmp0aFyw3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034849; c=relaxed/simple;
	bh=kuaNFAqThOoB9rmCaN7C7WwFLev4HV8YKvV5v5sDUiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZMghrbDBw5jdevEayu7GRYTqOMPWy4C1K+e4PFjL5bMEzcp4VmnzEXb6QiiVdMD9TC9mxqJaHLri5UOnpluKYqEi3pV5SMgdkUO2FHuNEdGRT1jdVVMcVV7VEYv8ntByLp/0EXFTWPnq6FEYV5wH7+tRAtc/A2RGmmYPyKJFsJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=B9roO90g; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F7r7Hx026109;
	Mon, 15 Jul 2024 11:13:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kuaNFAqThOoB9rmCaN7C7WwFLev4HV8YKvV5v5sDUiQ=; b=B9roO90gcn1ENBF0
	z4Ev6meXnFIEMQhMSpW7RHj+DQm/EkcFglSpDKrz6+qJnLksQLg1067WfCmR402L
	bZhP+deSisnB4KRc/xrHW76cn3aofR3tb8oLDdbdyjKgT69EhSlYn4fTpACyCpy3
	Rg+RhewE/ATVrwapVybaIPwaXIxOyEZJkvL7Ht6sJLXOGIOMAQH+SMVvS/kDibYH
	Q/4C6xvjf+IaFWbC1QtKPsAr2DG5UD6CFkX2XVZnxkQVXe9yiY7lmAgPAy6pBYFc
	4aPpkc+LBclVBHhHG8RtJUTjt3zEoULHEx1fGxzrG7+xiGtUb5Fogov5+vt7Yz+w
	qGsbxg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40c4hhupjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 11:13:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EEA3B4002D;
	Mon, 15 Jul 2024 11:13:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85B06210F9C;
	Mon, 15 Jul 2024 11:12:56 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 15 Jul
 2024 11:12:55 +0200
Message-ID: <16438bb1-2677-48bb-bdb0-91dc9d83792e@foss.st.com>
Date: Mon, 15 Jul 2024 11:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/stm: Avoid use-after-free issues with crtc and
 plane
To: Katya Orlova <e.orlova@ispras.ru>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20240216125040.8968-1-e.orlova@ispras.ru>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240216125040.8968-1-e.orlova@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_05,2024-07-11_01,2024-05-17_01


On 2/16/24 13:50, Katya Orlova wrote:
> ltdc_load() calls functions drm_crtc_init_with_planes(),
> drm_universal_plane_init() and drm_encoder_init(). These functions
> should not be called with parameters allocated with devm_kzalloc()
> to avoid use-after-free issues [1].
>
> Use allocations managed by the DRM framework.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> [1]
> https://lore.kernel.org/lkml/u366i76e3qhh3ra5oxrtngjtm2u5lterkekcz6y2jkndhuxzli@diujon4h7qwb/
>
> Signed-off-by: Katya Orlova <e.orlova@ispras.ru>


Hi Katya,

After some delay: applied on drm-misc-next.

Thanks,
Raphaël


