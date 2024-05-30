Return-Path: <linux-kernel+bounces-195202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217928D48C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB991F21B93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953986F31D;
	Thu, 30 May 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KUMpS0DR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD418396C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062035; cv=none; b=jlWR2N15hi0XGDz/tcXSapYcodp3tPrH7CltoBheGN1o88tjXCBb9QdNZFzZ0CbWtuxDqRgDYvGnUiWCx3BxkfR82HeaWyxk1Bb2SKcogpW/Mp2QJDP4T8lmzvDniRfz0KfZ/UKGyC7wnH1xltHWpXoR2YnHoAR8X362GsAiowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062035; c=relaxed/simple;
	bh=u0YKPUnLFVDOQYLIYRiTFVUATH5P/PqjieWnNLiJrA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pz7es6Jgup1CFs6/X1FEPJX720r8ONXdaeYGeNt6CcJYFuRPH8Z2Azfe7yvs/oZxdgHhEij9rMmV7BQb7fc+Jug63rgMad9v9Xddq3/AnCBU1PKBAXVbA9jr8eP/Fb4c2EaR2KHmaQqasudWEH2r4gI9aw3aK/gYeeYFR4QlNvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KUMpS0DR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9do6C056008;
	Thu, 30 May 2024 04:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061990;
	bh=lnFMblmb1eA3dL1Hq9rIjS5XMCLMapKZP4XOTfarCDg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KUMpS0DRb4w4KLBNeCHIDld2VUr8xGTNdrzrT1lg2gYv7oHgRwJNJ496GP7niR9JO
	 2rzknj1+QByJJ2FRqa5LQf9V8yl24H2HmpswMuA7Ut+8WS5nSZC99bsMULwO4A0ToK
	 Nc75iJaZ+SRCfoaCsrNtU7+mu3t6Wit+8XmeLRRg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9dodp056797
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:39:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:39:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:39:50 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9dgkv004387;
	Thu, 30 May 2024 04:39:43 -0500
Message-ID: <ce332f8d-3a4f-4046-bde0-6e12c99ebb09@ti.com>
Date: Thu, 30 May 2024 15:09:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/tidss: Add CRTC mode_fixup
To: Maxime Ripard <mripard@kernel.org>
CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas
 Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>,
        DRI Development List
	<dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-2-a-bhatia1@ti.com>
 <20240516-tuscan-mamba-of-debate-c4cddf@penduick>
 <1c4f5862-b1a2-4812-a109-987338ec3a72@ti.com>
 <20240521-lean-dragon-of-perfection-043fad@houat>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240521-lean-dragon-of-perfection-043fad@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Maxime,

On 21/05/24 18:48, Maxime Ripard wrote:
> On Thu, May 16, 2024 at 04:33:40PM GMT, Aradhya Bhatia wrote:
>> Hi Maxime,
>>
>> Thank you for reviewing the patches.
>>
>> On 16/05/24 13:40, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Sat, May 11, 2024 at 09:00:45PM +0530, Aradhya Bhatia wrote:
>>>> Add support for mode_fixup for the tidss CRTC.
>>>>
>>>> Some bridges like the cdns-dsi consume the crtc_* timing parameters for
>>>> programming the blanking values. Allow for the normal timing parameters
>>>> to get copied to crtc_* timing params.
>>>>
>>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>>> ---
>>>>  drivers/gpu/drm/tidss/tidss_crtc.c | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
>>>> index 94f8e3178df5..797ef53d9ad2 100644
>>>> --- a/drivers/gpu/drm/tidss/tidss_crtc.c
>>>> +++ b/drivers/gpu/drm/tidss/tidss_crtc.c
>>>> @@ -309,12 +309,23 @@ enum drm_mode_status tidss_crtc_mode_valid(struct drm_crtc *crtc,
>>>>  	return dispc_vp_mode_valid(tidss->dispc, tcrtc->hw_videoport, mode);
>>>>  }
>>>>  
>>>> +static
>>>> +bool tidss_crtc_mode_fixup(struct drm_crtc *crtc,
>>>> +			   const struct drm_display_mode *mode,
>>>> +			   struct drm_display_mode *adjusted_mode)
>>>> +{
>>>> +	drm_mode_set_crtcinfo(adjusted_mode, 0);
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>>  static const struct drm_crtc_helper_funcs tidss_crtc_helper_funcs = {
>>>>  	.atomic_check = tidss_crtc_atomic_check,
>>>>  	.atomic_flush = tidss_crtc_atomic_flush,
>>>>  	.atomic_enable = tidss_crtc_atomic_enable,
>>>>  	.atomic_disable = tidss_crtc_atomic_disable,
>>>>  
>>>> +	.mode_fixup = tidss_crtc_mode_fixup,
>>>>  	.mode_valid = tidss_crtc_mode_valid,
>>>>  };
>>>
>>> mode_fixup is deprecated for atomic drivers, so the solution must be
>>> different there.
>>>
>>> It's also not clear to me how it could change anything there:
>>> drm_mode_set_crtcinfo with no flags will make crtc_* field exactly
>>> identical to their !crtc counterparts.
>>>
>>
>> I checked the flag options. There isn't any flag required. The only
>> reason to add this call is because cdns-dsi strictly requires the crtc_*
>> fields to be populated during the bridge enable.
>>
>> Secondly, if mode_fixup is deprecated, I think the crtc_atomic_check
>> would be the next best place to add this call.
> 
> That would be better, yes, but we shouldn't even have to do that in the
> first place. AFAIK all the path that create a drm_display_mode will call
> drm_mode_set_crtcinfo on it to fill those fields. So if they are missing
> somewhere, that's what the actual bug is, not something we should work
> around of at the driver level.
> 

You are right. This patch isn't required at all. The fix around the
mode->crtc_clock usage in one place in the cdns-dsi driver makes this
patch unnecessary. The DRM core does duplicate the timing parameters at
a later stage for the cdns-dsi bridge_enable to consume.

Dropped this patch in v2. Thanks!

Regards
Aradhya


