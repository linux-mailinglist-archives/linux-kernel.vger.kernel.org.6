Return-Path: <linux-kernel+bounces-219005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6290C8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2241C22320
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7797220BA77;
	Tue, 18 Jun 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dr/V6qXr"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4220BA71
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704588; cv=none; b=S6ijr8VjfcIu9ygeBMZgrr7vZLGpgfTmMXhJF7UkPFroj0XcD1gdOz2dfayxge1JK8y7ohzeVrAsqwpwBHbrhijehdzkmetLA69Q6Xsqmrwmj/g7s32Bbo1mBqL3vzdNb85ZPSUPOUdCDIlJHiIYF2p9GAInxku5S+Cwes1iRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704588; c=relaxed/simple;
	bh=6X2tkuAJaFYHLaeP4FiicXyTEsjNMinu39BtYzgvbjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NWlmPP8tIHcpRsaY8Gc1aYwjmqks9GQ0kX8JduE2EE/b6+AVA59OvXENpNTCvUrVI/WDspaW9Kds1NNGHAuZ3Og4RjdjKu7fdnmhcUKhaqPApdKrL31vE5hn3UVE+zQXwEkS+vfTkz0rOCz1p/e4fVy03uH/5CMdmngp0NpvYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dr/V6qXr; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I9tUb4036131;
	Tue, 18 Jun 2024 04:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718704530;
	bh=kObidoHlbxPl2P/iVIdhGFea6f6bwjESIGwBw07LQkU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Dr/V6qXrecYWhpnQkS/NZ8/ZMKLZytWk5VwPawmR/oQCRvmB106qTP7vU4V6b7sov
	 0U2aoEnoZyYcALTcJBeYRQmVpFo/3W2bowIgbpk0KUr9v2zOsPtGHMnVg3q1E59nKj
	 ItK/AaE9uJtIlrGvpI89G05zfUWsiNbROP4TLbUM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I9tUAe052207
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 04:55:30 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 04:55:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 04:55:29 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I9tOHs036026;
	Tue, 18 Jun 2024 04:55:25 -0500
Message-ID: <e236648c-e257-42a3-a0a3-a1b88b539459@ti.com>
Date: Tue, 18 Jun 2024 15:25:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/bridge: ti-sn65dsi86: Add atomic_check hook
 for the bridge
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
 <20240618081418.250953-2-j-choudhary@ti.com>
 <r5szraxdqfs4v4hnvqgx6tbmc5e5ew5ljyf5xlaobywm55bohy@6kygxenn2tvd>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <r5szraxdqfs4v4hnvqgx6tbmc5e5ew5ljyf5xlaobywm55bohy@6kygxenn2tvd>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Dmitry,

Thanks for the review.

On 18/06/24 14:29, Dmitry Baryshkov wrote:
> On Tue, Jun 18, 2024 at 01:44:17PM GMT, Jayesh Choudhary wrote:
>> Add the atomic_check hook to ensure that the parameters are within the
>> valid range.
>> As of now, dsi clock freqency is being calculated in bridge_enable but
>> this needs to be checked in atomic_check which is called before
>> bridge_enable so move this calculation to atomic_check and write the
>> register value in bridge_enable as it is.
>>
>> For now, add mode clock check for the max resolution supported by the
>> bridge as mentioned in the SN65DSI86 datasheet[0] and dsi clock range
>> check for SN_DSIA_CLK_FREQ_REG.
>> According to the datasheet[0], the minimum value for that reg is 0x08
>> and the maximum value is 0x96. So add check for that.
>>
>> [0]: <https://www.ti.com/lit/gpn/sn65dsi86>
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 65 +++++++++++++++++++--------
>>   1 file changed, 46 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> index 84698a0b27a8..d13b42d7c512 100644
>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
>> @@ -113,6 +113,20 @@
>>   

[...]

>>   
>> +static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
>> +				     struct drm_bridge_state *bridge_state,
>> +				     struct drm_crtc_state *crtc_state,
>> +				     struct drm_connector_state *conn_state)
>> +{
>> +	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
>> +	struct drm_display_mode *mode = &crtc_state->mode;
>> +	unsigned int bit_rate_mhz, clk_freq_mhz;
>> +
>> +	/* Pixel clock check */
>> +	if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
>> +		return -EINVAL;
>> +
>> +	bit_rate_mhz = (mode->clock / 1000) *
>> +			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
>> +	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
>> +
>> +	/* for each increment in dsi_clk_range, frequency increases by 5MHz */
>> +	pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
>> +		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
> 
> atomic_check might be called several times, it might be called to test
> the state. As such, it should not modify anything outside of the
> state variables.
> 

If not in atomic_check, then where should I move this calculation and check?
mode_valid with returning MODE_BAD in case of failure?

I had to move it from bridge_enable based on the comments on v1:
https://patchwork.kernel.org/project/dri-devel/patch/20240408073623.186489-1-j-choudhary@ti.com/#25801801

Warm Regards,
Jayesh

[...]

