Return-Path: <linux-kernel+bounces-179526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708668C60E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F96D1F212E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FE40848;
	Wed, 15 May 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mBAkrGGB"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F453C488
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755303; cv=none; b=rv+2tODS8FNihTivA1pRnU9w4Byb5VUHaCBtCNu21YyWGkOEJaJfIkDqfryHqGD684Z1eQDHTpMirMVbE0JbseT6J9kJQ6evh+1rergLCO8YA0/HPT3kIPE0dzJcAOPSn7QGpPig3ZU9NDbvEG1ABfXhlTsmOCLHNtycOWVmdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755303; c=relaxed/simple;
	bh=TJKrpcrkUxV5ZjMdLlFyHc7tyMjEZpRrDQ7anUNUSxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AMVrJfGO97tlJAVfZyvoUqVzePPZ3ci2ZQP5yXMwmI1zCQAX/owH46rxPjjxWJCEgdCVoQ7asF/gYur00VKlFwCbuUok602zRyHm3c38/oQwMGkBaBR1UHv5OqviRVY7hAsegWMuhABPJB97zGerL+m+A550YMSHnIa7+1PD+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mBAkrGGB; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F056TZ012890;
	Wed, 15 May 2024 08:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=grZoncYN/Ex6YBE6MWMsZg3hoMkBe2yN4z13XwIKYPs=; b=mB
	AkrGGBA18gIrlZuvQmXNp+jkBFd/Ny1YXK83q03Q/JTRfAIhLZF24O0vxgOAthnz
	YpgtayqGlszvQD0STawOg0Hs04I2Vzo0F0iA7jnyXrQsJ9fnHXT8yJD6FLzwscgy
	GbNrcFpyE4Xm/XCLSWS/vlGQFi1JbTVcEhvm4ukk0HZPoiF9QwKywqdlQk+SGV6y
	IQuC9c8UrCuCcLh0Z+teECj+Ntxa89V4xGcDuiHfxzfSiTOM5jRethunhQ9CV0Xo
	DOb8x8dHxrT7QzrPjjPAhnOh+suDdQibNMgTBh9k9JpUQ1UkpX0LRR49ePaFAInK
	4lDJGc4oC67xjHGoIFJw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y1yjbe0u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 08:40:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C5C5740044;
	Wed, 15 May 2024 08:40:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 52EA920DD93;
	Wed, 15 May 2024 08:39:51 +0200 (CEST)
Received: from [10.252.19.151] (10.252.19.151) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 08:39:50 +0200
Message-ID: <b58c9073-02c6-4b5e-9082-fb11f388842d@foss.st.com>
Date: Wed, 15 May 2024 08:39:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
To: Sean Nyekjaer <sean@geanix.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Robert Foss
	<rfoss@kernel.org>,
        Antonio Borneo <antonio.borneo@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240322104732.2327060-1-sean@geanix.com>
 <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_02,2024-05-14_01,2023-05-22_02

Hi Sean,

thanks for your patch.

Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>

I think that a helper could be useful in simplifying this part.
This might be reworked when a new helper will be implemented.

Best regards


On 4/22/24 16:05, Sean Nyekjaer wrote:
> On Fri, Mar 22, 2024 at 11:47:31AM +0100, Sean Nyekjaer wrote:
>> When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
>> to reguire the requested and the actual px clock to be within
>> 50Hz. A typical LVDS display requires the px clock to be within +-10%.
>>
>> In case for HDMI .5% tolerance is required.
>>
>> Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mode_valid()")
>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> ---
> Any feedback on this?
>
>>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> index d5f8c923d7bc..97936b0ef702 100644
>> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
>> @@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
>>   	return 0;
>>   }
>>   
>> -#define CLK_TOLERANCE_HZ 50
>> -
>>   static enum drm_mode_status
>>   dw_mipi_dsi_stm_mode_valid(void *priv_data,
>>   			   const struct drm_display_mode *mode,
>> @@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
>>   		/*
>>   		 * Filter modes according to the clock value, particularly useful for
>>   		 * hdmi modes that require precise pixel clocks.
>> +		 * Check that px_clock is within .5% tolerance.
>>   		 */
>> -		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
>> -		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
>> +		if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000) ||
>> +		    px_clock_hz > mult_frac(target_px_clock_hz, 1005, 1000))
>>   			return MODE_CLOCK_RANGE;
>>   
>>   		/* sync packets are codes as DSI short packets (4 bytes) */
>> -- 
>> 2.44.0
>>

