Return-Path: <linux-kernel+bounces-237569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA9923B00
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4832B1F21A24
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5305C156F46;
	Tue,  2 Jul 2024 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="meLx/pde"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3784DFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914539; cv=none; b=RSoibdYunoImSKOtTwUbkcLilwYL+0uek4mNhBvcqXZeczpnTLaN5zG202eAV+1TeHsaZQVLjIy3YEJMTEAyz1CatOtv7S7IbD0rhUXHbqk6t0midR0s8LP8lzmfMDODaM6mtbnkfa216Y5Wuu1mSlQwStsyveizhdtZAWe37pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914539; c=relaxed/simple;
	bh=kfQXYHa0/iq3VMeEyiTVIoiCqBLBnSRbpgiMa9uKD2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R9J0fNyzMXOO2ITejhL6wdutQFI1/lf93H07PTBsakztNC5OFTYtGe++xoUSESKhwgmbPlgtGmvn7jYMccp5fVIuP9UeuYrqTE69w2YfE6eliReUuaNdkEPpzW89zkR+g8h8aDUGTN/GIXQnyMuSA+sTVfj5Q32y1/7NPCTWQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=meLx/pde; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46284MAV002305;
	Tue, 2 Jul 2024 12:01:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	MIg3DBI11sSmG6wbpd1DN3SW8f/bMTTym/JO7g3ovAY=; b=meLx/pdejVh1bTGy
	uiOCkKrNavNX2j6fEcHeoDBVA9rQI/vqeh/OSOWTTRsttxc8sHmjPcZIS0i6dlcF
	r+2Ekv1DYq9MKu9Bruma9yWFHdmR9uvctzaJnTFSVuZDm8JO/c57GsEqoC4ifMI9
	kXj+u56SubQnamAqrK9K6qSex+Ehy3cegUGyr0LfhS39ypwUB4pmajtm8SCuwWd3
	XWmUfNPcJ8z+WzEWJrmrwF8JgfzQKOezzYepK7oL7lWlxRAXGiCiUDAlB0QU3gpB
	Wn5O+H0ZWUHuZa/LOv5itGw0pYjiPz3vFkGgN7oH6f23+83dPscbIS4xiiklspxG
	YxxZdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4027pgjyqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 12:01:35 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 725024004B;
	Tue,  2 Jul 2024 12:01:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2BE492207C0;
	Tue,  2 Jul 2024 12:00:37 +0200 (CEST)
Received: from [10.252.8.242] (10.252.8.242) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jul
 2024 12:00:36 +0200
Message-ID: <b33d9470-b845-478f-97d3-636e158693d2@foss.st.com>
Date: Tue, 2 Jul 2024 12:00:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: Remove unnecessary .owner for
 lvds_platform_driver
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <yannick.fertre@foss.st.com>
CC: <philippe.cornu@foss.st.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Abaci
 Robot <abaci@linux.alibaba.com>
References: <20240701062304.42844-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240701062304.42844-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_06,2024-07-02_02,2024-05-17_01

Hi Jiapeng,

On 7/1/24 08:23, Jiapeng Chong wrote:
> Remove .owner field if calls are used which set it automatically.
>
> ./drivers/gpu/drm/stm/lvds.c:1213:3-8: No need to set .owner here. The core will do it.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9457
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/stm/lvds.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
> index 2fa2c81784e9..06f2d7a56cc9 100644
> --- a/drivers/gpu/drm/stm/lvds.c
> +++ b/drivers/gpu/drm/stm/lvds.c
> @@ -1210,7 +1210,6 @@ static struct platform_driver lvds_platform_driver = {
>  	.remove = lvds_remove,
>  	.driver = {
>  		.name = "stm32-display-lvds",
> -		.owner = THIS_MODULE,
>  		.of_match_table = lvds_dt_ids,
>  	},
>  };


Indeed, platform_driver_register() overrides the value of the owner.

Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thanks,
Raphaël


