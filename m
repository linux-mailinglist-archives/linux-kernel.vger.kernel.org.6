Return-Path: <linux-kernel+bounces-219027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F31C90C8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143D3288032
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A32139D3;
	Tue, 18 Jun 2024 10:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wWCM7kqO"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984862139C3
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705145; cv=none; b=YKTUROY3HkRlwtaws1vEHzV3QXjAPoqSOQ2rb+jxaw20XEe7SnvlzvkALzTgTXOcXkbjLAw5OvZ2kez1lCT4/B2+jLO29JHZw9CvgZh5F8wlskAdKvKuj6n7T2SZ18U6mJU0lAptCrYL8NxrdsAUaUMp8G2NZ8xcZtT81X0uUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705145; c=relaxed/simple;
	bh=pXJhCqZ0SId/ySdHWcJzS0ATy4iZvP54YPLrDyz9xJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QLNK95Vt3dnbQRl1ZydqYT6H3EEhvVryjNA/TNXTizJP81iQKJ9UNlRtL70/CKdB2Ut9E79haf62mP136X+L47tA8nez4X7j5kauq1Y7d3WvveVxo301mdR5qQAEXBxR+/K3pNX4FfHREagaYnEJ6JjShYJ+yM/KyKX+HPPjX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wWCM7kqO; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45IA56GF037923;
	Tue, 18 Jun 2024 05:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718705106;
	bh=hDe7PFr29gM0BEOn/PNzAB+6EQaX3UaXAIJTy8mJu1w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wWCM7kqOIX13pOLGBqI8Lyqfw8JquoMkHjw35VjG8eCvvfqW6DvJI1SFCMBsMX4tT
	 xt52+swCZDRB0+qwFJ7vdO86l+DjiM7XVkdUwpr6JEeSmeFgwHIxR7I4ZN5ZEFaYcQ
	 4uW7nr1U5O6dlhTVIQxSfoKyMuCL1TXQrj0X6zoo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45IA5543063768
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 05:05:06 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 05:05:05 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 05:05:05 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45IA50VM054399;
	Tue, 18 Jun 2024 05:05:01 -0500
Message-ID: <a34116ff-989f-411b-8846-2f53b16b3773@ti.com>
Date: Tue, 18 Jun 2024 15:34:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Fix
 ti_sn_bridge_set_dsi_rate function
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <dianders@chromium.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <spanda@codeaurora.org>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
References: <20240618081418.250953-1-j-choudhary@ti.com>
 <20240618081418.250953-3-j-choudhary@ti.com>
 <k4t7zcvweap6e3fqrcixu7szqtvykn3nnqryyd3hdybhhufcgk@snimim34rrwh>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <k4t7zcvweap6e3fqrcixu7szqtvykn3nnqryyd3hdybhhufcgk@snimim34rrwh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Dmitry,

On 18/06/24 14:33, Dmitry Baryshkov wrote:
> On Tue, Jun 18, 2024 at 01:44:18PM GMT, Jayesh Choudhary wrote:
>> During code inspection, it was found that due to integer calculations,
>> the rounding off can cause errors in the final value propagated in the
>> registers.
>> Considering the example of 1080p (very common resolution), the mode->clock
>> is 148500, dsi->lanes = 4, and bpp = 24, with the previous logic, the DSI
>> clock frequency would come as 444 when we are expecting the value 445.5
>> which would reflect in SN_DSIA_CLK_FREQ_REG.
>> So move the division to be the last operation where rounding off will not
>> impact the register value.
> 
> Should this division use DIV_ROUND_UP instead? DIV_ROUND_CLOSEST?
> 

Floor of the final value is expected according to datasheet.
The error was due to taking floor earlier and then error propagation
due to multiplication later on.
I think we can come up with a case when DIV_ROUND_UP can also give this
error. So this particular approach seemed okay to me.

>>
>> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> 
> Fixes should go before feature patches. Please change the order of you
> patches for the next submission.

Okay. this was supposed to be code snippet movement in the first patch 
and fix in the second patch as suggested in v1:
https://patchwork.kernel.org/project/dri-devel/patch/20240408073623.186489-1-j-choudhary@ti.com/#25801801

I can fix it in next revision.

Thanks,
Jayesh

> 
>> ---
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> index d13b42d7c512..5bf12af6b657 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> @@ -111,8 +111,6 @@
>>   #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
>>   #define  AUX_IRQ_STATUS_NAT_I2C_FAIL		BIT(6)
>>   
>> -#define MIN_DSI_CLK_FREQ_MHZ	40
>> -
>>   /*
>>    * NOTE: DSI clock frequency range: [40MHz,755MHz)
>>    * DSI clock frequency range is in 5-MHz increments
>> @@ -1219,19 +1217,21 @@ static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
>>   {
>>   	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>>   	struct drm_display_mode *mode = &crtc_state->mode;
>> -	unsigned int bit_rate_mhz, clk_freq_mhz;
>> +	unsigned int bit_rate_khz;
>>   
>>   	/* Pixel clock check */
>>   	if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
>>   		return -EINVAL;
>>   
>> -	bit_rate_mhz = (mode->clock / 1000) *
>> +	bit_rate_khz = mode->clock *
>>   			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
>> -	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
>>   
>> -	/* for each increment in dsi_clk_range, frequency increases by 5MHz */
>> -	pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
>> -		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
>> +	/*
>> +	 * For each increment in dsi_clk_range, frequency increases by 5MHz
>> +	 * and the factor of 1000 comes from kHz to MHz conversion
>> +	 */
>> +	pdata->dsi_clk_range = (bit_rate_khz /
>> +				(pdata->dsi->lanes * 2 * 1000 * 5)) & 0xFF;
>>   
>>   	/* SN_DSIA_CLK_FREQ_REG check */
>>   	if (pdata->dsi_clk_range > MAX_DSI_CLK_RANGE ||
>> -- 
>> 2.25.1
>>
> 

