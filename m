Return-Path: <linux-kernel+bounces-397927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A30969BE28A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F890B213FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369651D9663;
	Wed,  6 Nov 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dU9+ycmj"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD521183CD6;
	Wed,  6 Nov 2024 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885455; cv=none; b=HtPe4r6jpYLabaC0pBhKD7/xTh0Rd16BJWSjw8eWomWo0CRoJcHqabL9FPpG/TP5UdVL5ufgPFg0fTNjXOrwnUPiawb65a42H7l+kwcucsMCnNz4OGJisw2UT5fnA3qAZCtgXaEVne8zL/nlB8YABFrgbDkulq2UjGKVRcMb3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885455; c=relaxed/simple;
	bh=HrfjV+ryo+ivU7+m1N9lWFnizPuwgUygEFHbUToJPhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G+ZM9yx63sDeXnG5aYUi0jY+WeJiY4ckiL+6yiqufi6GBu1vlqr60qGYDroEbtR3QR8HezYrUYHgGyVmg6IN+oggdq1Pp+9pk0r4rL65PedbayF/jg3zr5RjXXjK8soqGfxvZh2XoCqcIvs032llIVUnNjIJm55gd7EHV3DGfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dU9+ycmj; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A66feWa015451;
	Wed, 6 Nov 2024 10:30:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5Na2ucu6fM7s6QJT4BMpvEJuv3sVjdI3XxnANZwd4Dc=; b=dU9+ycmjtE42sb8w
	oTYYQKvMNf1mPliKCo9eSgYQpE/QmiAd/sjx5QYvDH8uK094O+5veClJIWnzfbMa
	JUaO12T9ZFiRddmBSaZ/FBllub9nuF8dW0ROzl5v3coLwKIzCs/wURciEvYL2/Yv
	QRhOIPpiWHciYVylXkGVrgqnqH5MjSMb1DuB9lPXp+A1kPSEYIPufORvYirLC9F/
	FvVLk2WVQKKNzeAgvy9TLNYh9sz1iZxna52SpgCyU5GoThmCt+uF/2GJBIt5kR5o
	JL2wIIjI0biOOqd+/2/N4vOjFpV/aVIXifefsl6bwwLHgS5qEPeRnD1SBO5p5Zei
	ySAKJw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42ncxc0cj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 10:30:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EDD3F40058;
	Wed,  6 Nov 2024 10:28:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F30C2251D3;
	Wed,  6 Nov 2024 10:27:56 +0100 (CET)
Received: from [10.252.15.15] (10.252.15.15) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 6 Nov
 2024 10:27:55 +0100
Message-ID: <f2d3778d-5fd6-49db-b418-b5411e617a0a@foss.st.com>
Date: Wed, 6 Nov 2024 10:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: stm: Prevent potential division by zero in
 stm32_sai_mclk_round_rate()
To: Luo Yifan <luoyifan@cmss.chinamobile.com>, <arnaud.pouliquen@foss.st.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241106014654.206860-1-luoyifan@cmss.chinamobile.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20241106014654.206860-1-luoyifan@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Luo,

On 11/6/24 02:46, Luo Yifan wrote:
> This patch checks if div is less than or equal to zero (div <= 0). If
> div is zero or negative, the function returns -EINVAL, ensuring the
> division operation (*prate / div) is safe to perform.
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>   sound/soc/stm/stm32_sai_sub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 7bc4a96b7..2570daa3e 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -378,8 +378,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
>   	int div;
>   
>   	div = stm32_sai_get_clk_div(sai, *prate, rate);
> -	if (div < 0)
> -		return div;
> +	if (div <= 0)
> +		return -EINVAL;
>   
>   	mclk->freq = *prate / div;
>   

Thanks for your patch. It looks fine, but I think that it has to
be extended.

In CR1 register, MCKDIV = 0 gives the same result as MCKDIV = 1.
But while MCKDIV = 0 is valid, for sure div = 0 is not valid.

I agree that that div = 0 has to be managed as an error
This could be rather handled in stm32_sai_get_clk_div() function itself,
by returning an error, if div is null.
This is relevant as we may also get an error on test "if (input_rate % 
div)".
I suggest to add a specific test and error message to handle this case 
in stm32_sai_get_clk_div().
Something like:
if (!div)) {
	dev_err(&sai->pdev->dev, "Invalid null divider\n");
	return -EINVAL;
}

BRs
Olivier





