Return-Path: <linux-kernel+bounces-399604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6369C017F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDF31C2095E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912A71E5712;
	Thu,  7 Nov 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NfeoeYa8"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DA1DFE24;
	Thu,  7 Nov 2024 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973087; cv=none; b=TO8gsCLoVTaYW8pXKHQvvhHwgDIfLd3ex2cBIZbbO4zno5BNgbmhjck7j6I4oTPWBb+uWFZbK7ueXgOGSUv+M5u6GFADmG1F6OQQsWdt5jRfON5JXAGxNWeHb6+sVCv5Jx3lk3MAz3zHvC7Gvoav1fj2fh/jBoMsZRhfOGwOmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973087; c=relaxed/simple;
	bh=vPNPFAMbtGJHLpTEL0vI/goTPvu3oF0UlgRsmou/YEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g+hNpLSjOtzBzYGmLd0NQudOsS338u4dzKn/BBRfeS2wifEYPsTO9brIS/OPqP168fU1sWIGI9+XUHwEhcaSnTA5tyk/GDjCDlNaA9givA/qcB1Nnv3j59Q2ozM/j8A4fomPuqgEqKeRBLw4pL3R40J3sPjTEQ4vdYewIcZb9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NfeoeYa8; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A75cHeY006257;
	Thu, 7 Nov 2024 10:50:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	de6Kcufr6UT1ym/eWTdGsV5OFcqLnwSoWKhUAhTVrZw=; b=NfeoeYa8ACbnyhVC
	f26OqBc2GLDkv/KnG0DOaovJoSIIMtWjfIuXMnSDBwcxtGq2wFUIiINqHj+ybLAV
	Ae6sL8Xi40JABcOCkfUwbWOivXvKgkQidqEHJFQyR3Ahs9gsQdJaTpsqgUHQ0qoG
	2LVdln6ztK02pCa9aE4AW1ZF3nsw+1KsUb5LlvmfYHpOXpP2O4WlKSR4C4j4P2gl
	IVAFp/DOpjg3T//MokmTu2PY4XaOUyFpa8ftQ0901DEK0+Kt4A682W9jW6adBjih
	sVAxRCjRCTV5datzzg9hY0Anl3D+Pxx0l5liNSwDEYnCbcyiRQ+cRlBMM1CBNA9e
	Irv0PA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42nxh43e5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 10:50:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3D1AA40047;
	Thu,  7 Nov 2024 10:48:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4164B268999;
	Thu,  7 Nov 2024 10:48:13 +0100 (CET)
Received: from [10.48.86.132] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 7 Nov
 2024 10:48:12 +0100
Message-ID: <e40beda1-56cf-4757-8eac-a9263f88e2fc@foss.st.com>
Date: Thu, 7 Nov 2024 10:48:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: stm: Prevent potential division by zero in
 stm32_sai_get_clk_div()
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
CC: <arnaud.pouliquen@foss.st.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <perex@perex.cz>,
        <tiwai@suse.com>
References: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
 <20241107015936.211902-1-luoyifan@cmss.chinamobile.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20241107015936.211902-1-luoyifan@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

On 11/7/24 02:59, Luo Yifan wrote:
> This patch checks if div is less than or equal to zero (div <= 0). If
> div is zero or negative, the function returns -EINVAL, ensuring the
> division operation is safe to perform.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>   sound/soc/stm/stm32_sai_sub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 7bc4a96b7..43fb1dcb9 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -317,7 +317,7 @@ static int stm32_sai_get_clk_div(struct stm32_sai_sub_data *sai,
>   	int div;
>   
>   	div = DIV_ROUND_CLOSEST(input_rate, output_rate);
> -	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
> +	if (div > SAI_XCR1_MCKDIV_MAX(version) || div <= 0) {
>   		dev_err(&sai->pdev->dev, "Divider %d out of range\n", div);
>   		return -EINVAL;
>   	}

Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>

thanks

