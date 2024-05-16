Return-Path: <linux-kernel+bounces-180855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09B8C73F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7411F23C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8498143757;
	Thu, 16 May 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fP4RN99z"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48B14293
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852467; cv=none; b=cEnb5l0Q6QgvTnE7+Dh3wVeOP/vC5AvYHUoM4fjkBv7Ag1Huv9UQmj9hnczQNoSNRQMaGO5IBIHQKC0dEnW5Do4j9NOiZ2f4YQRij09UR/EPgM4WBp5HALajUER6Gxa9l6L5oDuHNzHL7FfgUeiHLAva+Th/xmEk4GHco0Vr9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852467; c=relaxed/simple;
	bh=VI9ADdnHNha/UMhul5eMR4A7dgZlDaY3TOxKJBUjFRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vdd6e90XnhGQi74x7pIfcUPqzapZTtcJGwQV0o2uLb9gy7clb8cgEw0Z2AIvbZ4oRCuKUstuSWO0zG1rBtIu/sCTWXqIPozxKI9MU9KkyNOSDz7KFl1VzyRloy8fZ4RRV9aD6EfoPIzjyDuH/ptgeyNzkcMXnQooEvHBRg9HCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fP4RN99z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G9eOEN068647;
	Thu, 16 May 2024 04:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715852424;
	bh=ml6HgEfz0pCFcM1KFjw67YfcKvqpKdM587cI/IJIk4g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fP4RN99z1mpZnokn16cVVr97noUU5XphtytGCNT7Dwlt1sl/v9hIQvVPhMfMLvdDH
	 cR3HY+4KdDH8uUrVgClukDtcb50adfj4VhNhxV4fgbNJR7kNoXRExlVzPEdU+rUuqt
	 XF1t+m3mQb6IuYIfxCI8yssD5znMYML+g/xNW9bI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G9eOFP116928
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 04:40:24 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 04:40:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 04:40:24 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G9eGIB064483;
	Thu, 16 May 2024 04:40:17 -0500
Message-ID: <ba8d0b98-67d2-41e2-b568-a40543a9b0fa@ti.com>
Date: Thu, 16 May 2024 15:10:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/bridge: Introduce early_enable and late disable
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
        Boris Brezillon
	<boris.brezillon@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
 <20240511153051.1355825-7-a-bhatia1@ti.com>
 <20240516-bipedal-keen-taipan-eedbe7@penduick>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240516-bipedal-keen-taipan-eedbe7@penduick>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Maxime,

Thank you for reviewing the patches!

On 16/05/24 13:52, Maxime Ripard wrote:
> On Sat, May 11, 2024 at 09:00:50PM +0530, Aradhya Bhatia wrote:
>> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
>> index 4baca0d9107b..40f93230abb2 100644
>> --- a/include/drm/drm_bridge.h
>> +++ b/include/drm/drm_bridge.h
>> @@ -206,6 +206,20 @@ struct drm_bridge_funcs {
>>  	 */
>>  	void (*post_disable)(struct drm_bridge *bridge);
>>  
>> +	/**
>> +	 * @late_disable:
>> +	 *
>> +	 * This callback should disable the bridge. It is called right after the
>> +	 * preceding element in the display pipe is disabled. If the preceding
>> +	 * element is a bridge this means it's called after that bridge's
>> +	 * @atomic_post_disable. If the preceding element is a &drm_crtc it's
>> +	 * called right after the crtc's &drm_crtc_helper_funcs.atomic_disable
>> +	 * hook.
>> +	 *
>> +	 * The @late_disable callback is optional.
>> +	 */
>> +	void (*late_disable)(struct drm_bridge *bridge);
>> +
>>  	/**
>>  	 * @mode_set:
>>  	 *
>> @@ -235,6 +249,26 @@ struct drm_bridge_funcs {
>>  	void (*mode_set)(struct drm_bridge *bridge,
>>  			 const struct drm_display_mode *mode,
>>  			 const struct drm_display_mode *adjusted_mode);
>> +
>> +	/**
>> +	 * @early_enable:
>> +	 *
>> +	 * This callback should enable the bridge. It is called right before
>> +	 * the preceding element in the display pipe is enabled. If the
>> +	 * preceding element is a bridge this means it's called before that
>> +	 * bridge's @early_enable. If the preceding element is a &drm_crtc it's
>> +	 * called right before the crtc's &drm_crtc_helper_funcs.atomic_enable
>> +	 * hook.
>> +	 *
>> +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
>> +	 * will not yet be running when this callback is called. The bridge can
>> +	 * enable the display link feeding the next bridge in the chain (if
>> +	 * there is one) when this callback is called.
>> +	 *
>> +	 * The @early_enable callback is optional.
>> +	 */
>> +	void (*early_enable)(struct drm_bridge *bridge);
>> +
> 
> You don't need the legacy option here, just go straight for the atomic one.

Got it! I can remove these in v2.

> 
>>  	/**
>>  	 * @pre_enable:
>>  	 *
>> @@ -285,6 +319,26 @@ struct drm_bridge_funcs {
>>  	 */
>>  	void (*enable)(struct drm_bridge *bridge);
>>  
>> +	/**
>> +	 * @atomic_early_enable:
>> +	 *
>> +	 * This callback should enable the bridge. It is called right before
>> +	 * the preceding element in the display pipe is enabled. If the
>> +	 * preceding element is a bridge this means it's called before that
>> +	 * bridge's @atomic_early_enable. If the preceding element is a
>> +	 * &drm_crtc it's called right before the crtc's
>> +	 * &drm_crtc_helper_funcs.atomic_enable hook.
>> +	 *
>> +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
>> +	 * will not yet be running when this callback is called. The bridge can
>> +	 * enable the display link feeding the next bridge in the chain (if
>> +	 * there is one) when this callback is called.
>> +	 *
>> +	 * The @early_enable callback is optional.
>> +	 */
>> +	void (*atomic_early_enable)(struct drm_bridge *bridge,
>> +				    struct drm_bridge_state *old_bridge_state);
>> +
>>  	/**
>>  	 * @atomic_pre_enable:
>>  	 *
>> @@ -361,6 +415,21 @@ struct drm_bridge_funcs {
>>  	void (*atomic_post_disable)(struct drm_bridge *bridge,
>>  				    struct drm_bridge_state *old_bridge_state);
>>  
>> +	/**
>> +	 * @atomic_late_disable:
>> +	 *
>> +	 * This callback should disable the bridge. It is called right after the
>> +	 * preceding element in the display pipe is disabled. If the preceding
>> +	 * element is a bridge this means it's called after that bridge's
>> +	 * @atomic_late_disable. If the preceding element is a &drm_crtc it's
>> +	 * called right after the crtc's &drm_crtc_helper_funcs.atomic_disable
>> +	 * hook.
>> +	 *
>> +	 * The @atomic_late_disable callback is optional.
>> +	 */
>> +	void (*atomic_late_disable)(struct drm_bridge *bridge,
>> +				    struct drm_bridge_state *old_bridge_state);
>> +
> 
> But more importantly, I don't quite get the use case you're trying to
> solve here.
> 
> If I got the rest of your series, the Cadence DSI bridge needs to be
> powered up before its source is started. You can't use atomic_enable or
> atomic_pre_enable because it would start the source before the DSI
> bridge. Is that correct?
> 

That's right. I cannot use bridge_atomic_pre_enable /
bridge_atomic_enable here. But that's because my source is CRTC, which
gets enabled via crtc_atomic_enable.


> If it is, then how is it different from what
> drm_atomic_bridge_chain_pre_enable is doing? The assumption there is
> that it starts enabling bridges last to first, to it should be enabled
> before anything starts.
> 
> The whole bridge enabling order code starts to be a bit of a mess, so it
> would be great if you could list all the order variations we have
> currently, and why none work for cdns-dsi.
> 

Of course! I can elaborate on the order.

Without my patches (and given there isn't any bridge setting the
"pre_enable_prev_first" flag) the order of enable for any single display
chain, looks like this -

	crtc_enable
	
	bridge[n]_pre_enable
	---
	bridge[1]_pre_enable

	encoder_enable

	bridge[1]_enable
	---
	bridge[n]_enable

The tidss enables at the crtc_enable level, and hence is the first
entity with stream on. cdns-dsi doesn't stand a chance with
bridge_atmoic_pre_enable / bridge_atmoic_enable hooks. And there is no
bridge call happening before crtc currently.

That's where the early_enable APIs come into picture. They are being
called before the crtc is even enabled, helping cdns-dsi to be enabled
before tidss. The order then looks like -


	bridge[1]_early_enable
	---
	bridge[n]_early_enable

	crtc_enable
	---
	(the order is same from here on)


Regards
Aradhya

