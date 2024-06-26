Return-Path: <linux-kernel+bounces-230893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6B918372
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA601C21F25
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A119184113;
	Wed, 26 Jun 2024 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LSL72Lvu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326813CFBC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410254; cv=none; b=PCxixKWmXvRfFs9F7g9AT4DPZO88QA0bTbYPSk7E7ZAPNfMm+mQzoppZdSDQuDgeMOPM8udWXLmkugFgWN4UYLPTLsJ+/ZRylDiMXgJ4oV8jy0b945iD03xbofs4GzoHMIPu8qKjZIb6bNGA3Jvtiy3BWajOXvpMzcPDY+z3/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410254; c=relaxed/simple;
	bh=zvKtuKgBaTespiR6RMkqLKklB9Utdfyyjx8B+f3tuDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cMngDxw+4z/XSO6ScN0TUuIkzNfJkDWRWMieUvvQIiZidDGSDFTER5r0BrBucPL8ksc42l2zvjoHL8e5fH/xppoZDicNUoDouc3vHQfiUnp0we/BEYRwqbbIyNRHhPlZTzCpwPv0abOAB+mAMn9hjd6+DQyHeZo7XSaJdQlmRX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LSL72Lvu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45QDusO1012190;
	Wed, 26 Jun 2024 08:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719410214;
	bh=6ZfQCtFhca3BvaTLDs9BV+HylXiVe8ipVaxzUNzNlt0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LSL72LvupNifb3aKaHULhW1ebmQ5Qlx9A0l1JdfBGscokrStfXLolFiGSel3bvUzQ
	 sSbs/sLbDe9eRO6/nmck2kpZo+yncN3aIWQHA9O6X9JQ23mMgJJaNxKHWScpz8w9FR
	 RGZ3BHUmkSehfp9VfG7cF+sa3XJet0TN1UNRhvGs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45QDusK5000531
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Jun 2024 08:56:54 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jun 2024 08:56:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jun 2024 08:56:53 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45QDukC7000410;
	Wed, 26 Jun 2024 08:56:46 -0500
Message-ID: <6f099c5e-0342-48c8-a952-4dc6eb4fd3ae@ti.com>
Date: Wed, 26 Jun 2024 19:26:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] drm/bridge: cdns-dsi: Fix the clock variable for
 mode_valid()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Dominik Haller <d.haller@phytec.de>, Sam
 Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Kieran
 Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>
References: <20240622110929.3115714-1-a-bhatia1@ti.com>
 <20240622110929.3115714-6-a-bhatia1@ti.com>
 <6aca2e93-034f-4731-adc4-4eaa3d148193@ideasonboard.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <6aca2e93-034f-4731-adc4-4eaa3d148193@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 26/06/24 16:17, Tomi Valkeinen wrote:
> On 22/06/2024 14:09, Aradhya Bhatia wrote:
>> Allow the D-Phy config checks to use mode->clock instead of
>> mode->crtc_clock during mode_valid checks, like everywhere else in the
>> driver.
>>
>> Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>> ---
>>   drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> index 03a5af52ec0b..426f77092341 100644
>> --- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> +++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
>> @@ -574,7 +574,7 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
>>       if (ret)
>>           return ret;
>>   -    phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
>> +    phy_mipi_dphy_get_default_config((mode_valid_check ? mode->clock
>> : mode->crtc_clock) * 1000,
>>                        mipi_dsi_pixel_format_to_bpp(output->dev->format),
>>                        nlanes, phy_cfg);
>>   
> 
> I think this is fine as a fix.
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> However... The code looks a bit messy. Maybe the first one is something
> that could be addressed in this series.
> 
> - Return value of phy_mipi_dphy_get_default_config() is not checked

Sure, I can fix that.

> 
> - Using the non-crtc and crtc versions of the timings this way looks
> bad, but that's not a problem of the driver. It would be better to have
> a struct that contains the timings, and struct drm_display_mode would
> contain two instances of that struct. The driver code could then just
> pick the correct instance, instead of making the choice for each and
> every field. This would be an interesting coccinelle project ;)
> 
> - Calling cdns_dsi_check_conf() in cdns_dsi_bridge_enable() is odd.
> Everything should already have been checked. In fact, at the check phase
> the resulting config values could have been stored somewhere, so that
> they're ready for use by cdns_dsi_bridge_enable(). But this rises the
> question if the non-crtc and crtc timings can actually be different, and
> if they are... doesn't it break everything if at the check phase we use
> the non-crtc ones, but at enable phase we use crtc ones?

It'd appear that it does. I don't fully understand why the driver uses
non-crtc_* timing parameters during the check phase, only to use the
crtc_* timing parameters during _enable().

Since with tidss, both the sets are same, I haven't had to think too
much about this! =)

What is the ideal way that this should get addressed though? If we have
an agreeable resolution then maybe I can fix that as well.

> 
> Ah, I see, this is with non-atomic. Maybe after you switch to atomic
> callbacks, atomic_check could be used so that there's no need for the
> WARN_ON_ONCE() in enable callback.
> 

Yes, I think this would be better. We can use atomic_check() to verify
the crtc_* timing parameters, while the already existing mode_valid()
can continue checking the non-crtc_* ones.

I will add this change when I am adding other atomic_* APIs later in the
series.


Regards
Aradhya


