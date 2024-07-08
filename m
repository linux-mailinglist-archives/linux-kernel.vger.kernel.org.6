Return-Path: <linux-kernel+bounces-244395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E0F92A3B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B22B7283BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B28120D;
	Mon,  8 Jul 2024 13:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="c/wXRHcT"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798CB28E3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445661; cv=none; b=ma6woX6FnGsQkY6EyS98AQVcYtv0cwJYH2092h/3P1gvEtVMgD64M9gmSedGwg4FdHtV6Y1HEdjI13MXZMBBxBG6RUBm6cGG48mRD4Hi0pEZEJAIna8XRAI5EqMPdBN3390orztBuL1TyjxRrgyfkxbICM6PLB9Wh2UXGhGoOUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445661; c=relaxed/simple;
	bh=rzu8YeWFMIpX2LFGWzhRhNhE1/1Kenjfbn/z0WpATv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o1s9koX7niSmk8kDSnsWxJ1K4YppeNTaO0oPMU1scHZ2m3OUYwzuUf7OKjrKSoCs0Dg3roD6tLVBwYs0kx7TB5JEpX9BqyLdzWwpdvjmmCAiJfK6hQWIX9KPBkX2Arx6e1/ohiLXXPXJteXPM0KTNe9Y5LhePGxs2lo6peAq8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=c/wXRHcT; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468CKG7F014260;
	Mon, 8 Jul 2024 15:33:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pQZd32lrwSdbK0qtBZuTFC92e7n3xKS/AFWQ/E+TqbY=; b=c/wXRHcTxFs5gH/5
	YRtl8gvXgiXGdQCjMn2vHnt20BZYsH8+1B4JFmJoUANjxUIdM7xm0GZyyKiBKswQ
	/3se3CkImCgtX8gixqqWJUzujsRFrrzjWuo1QLDkop+tfH7J1N5dSnZRuYYBnCSm
	MZp0+S6J93IZ5iGg0hzZJz9aWRYPsw5gskZrNqU5B/kobtwIltPLeeG7Z4zGsyr4
	8IlVofsitziA7SMrfrXzSEfGn7/0uw8RM7Sl0tAxzT+24mQmHmQoiuNGoljwicZx
	6RN+90bLmqmPAerLHrfRkDI2+LGfDFTUSp3UyDL5kyMLBzpbxgdgehemST71Cx9n
	kWzQoQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 406whfq3jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 15:33:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C364740044;
	Mon,  8 Jul 2024 15:33:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F3A1D223644;
	Mon,  8 Jul 2024 15:32:36 +0200 (CEST)
Received: from [10.48.86.145] (10.48.86.145) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jul
 2024 15:32:35 +0200
Message-ID: <9d60f79c-6cf3-eb6c-57ae-e6ea391fa618@foss.st.com>
Date: Mon, 8 Jul 2024 15:32:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/stm: Remove unnecessary .owner for
 lvds_platform_driver
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <yannick.fertre@foss.st.com>
CC: <raphael.gallais-pou@foss.st.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci
 Robot <abaci@linux.alibaba.com>
References: <20240701062304.42844-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20240701062304.42844-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01



On 7/1/24 08:23, Jiapeng Chong wrote:
> Remove .owner field if calls are used which set it automatically.
> 
> ./drivers/gpu/drm/stm/lvds.c:1213:3-8: No need to set .owner here. The core will do it.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9457
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   drivers/gpu/drm/stm/lvds.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index 2fa2c81784e9..06f2d7a56cc9 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -1210,7 +1210,6 @@ static struct platform_driver lvds_platform_driver = {
>   	.remove = lvds_remove,
>   	.driver = {
>   		.name = "stm32-display-lvds",
> -		.owner = THIS_MODULE,
>   		.of_match_table = lvds_dt_ids,
>   	},
>   };

Hi Jiapeng,
Applied on drm-misc-next.
Many thanks,
Philippe :-)

