Return-Path: <linux-kernel+bounces-257213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 754249376C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158201F21A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25597E782;
	Fri, 19 Jul 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rZDhHyMu"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D8983CDA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386099; cv=none; b=tGZQnEuBD1l0tC5Iouz7yPA39Qf6J5bO20frHa9rbnqzirPehunHGZImMddbT1ZqA/L7K7xmFA80jSa/AbH7ZU6WcUe1zqT7Jxnapv1oPZegaHPIYYJXTWd8azKre6G54eEYi0hBR/R4V1dhJ8r8FBgrX5dlI0QH+FdxzNhNslg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386099; c=relaxed/simple;
	bh=6v9mXPTP2gc6lkDgu/ArdtuvjDBIS/gGTRxcEZCHv1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YVEIUQTI0xLZEHcRXamlj+aZqPyBzq7/52F1/cPtLFTSZEA/VdR/wxl+9wcnFJ7OR0CjUbMvP0TLENSKbBQjj2uYY6oJnLCOJOuoPn8j6n9lVIqgA/iX7SUB5xqKMXiitNOdgWW1a7lYbEepszsHe4GLk/N7NOOx4tYUwYxiFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rZDhHyMu; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46J9RJFn010370;
	Fri, 19 Jul 2024 12:48:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6v9mXPTP2gc6lkDgu/ArdtuvjDBIS/gGTRxcEZCHv1o=; b=rZDhHyMun4/53BuU
	+9QWLUT/eVCruYA4C3tkEraS5AfXQ5pojtaT/hbz9kgsJ/KoUNOF7g2I+keWKUDC
	/5Sk5Fs3IwMadbzTTJnt4qshuKF3W8QiGCUV7RjztBrpa5H71rAIeohvGMqiEVSf
	2Hb+27lDCw1mGxsmCwwlFpdAaEqB6njLGEQ8rpl6gZOX8r+PPCj5Es8N+h8INIuV
	/u9BDXnqqLA8zI5/6FxlidC5nOfT/zGPQMoi+jx7gKL+efxLN2ArKB7jXZDbx6wl
	1cUwA1OCnyTeE3G4ZkOHB5/PL1vpBm9g1vH0zAh5DJi3heZ7+S9M9qDNoMDJwH9t
	8XYM4Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40fe179yuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 12:48:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 261BF4002D;
	Fri, 19 Jul 2024 12:47:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 800D924F390;
	Fri, 19 Jul 2024 12:47:28 +0200 (CEST)
Received: from [10.129.178.17] (10.129.178.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 19 Jul
 2024 12:47:25 +0200
Message-ID: <fca733ed-198a-4aa5-b180-f6746e6e37d8@foss.st.com>
Date: Fri, 19 Jul 2024 12:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: reset plane transparency after plane
 disable
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240712131344.98113-1-yannick.fertre@foss.st.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240712131344.98113-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01


On 7/12/24 15:13, Yannick Fertre wrote:
> The plane's opacity should be reseted while the plane
> is disabled. It prevents from seeing a possible global
> or layer background color set earlier.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>

Hi Yannick,

Applied on drm-misc-next.

Thanks,
Raphaël


