Return-Path: <linux-kernel+bounces-188637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F628CE4B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554F91F22844
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E185C70;
	Fri, 24 May 2024 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RBdlo+b6"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7942078
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548947; cv=none; b=XQx/98NHfgAvAdalASAIt5T8j28qv71l9AoUP5x7LFErru4BRQe7Syoem64/G+FR2sT1J6cX/+olKajklUJgybE/TWG9kRysOS+2xP3IYfOqjQIRxRsqRSyALkk1zajZcmcIR+ZPMyNEWbdOwCH1IK3KYd3LIKiNBNGzezY+U/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548947; c=relaxed/simple;
	bh=rn9YRk5eG8ZY8mbR8dGpjOxuH4c3Z+VFNQjatRUvllg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dHPBFtjRPzINUzaQlv3dMN76Q3j7B+p9CgwKHYJ5zE+XUXP6/fu5Uiv6KydSRYG38umXv72x40fFCHnQb0psmJnszFgccHyT4P66fyAiSGTptiuT0oCUChE1cnX0gwfo0qPCy6gbBXWQsix4Zo3anC/caRNSK+Jw+cGPq18/yWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RBdlo+b6; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OB8Nlo030281;
	Fri, 24 May 2024 06:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716548903;
	bh=MzuQhoSyM1xymektG2r7GA3lDYRYUkIhwJOnrDgdovY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RBdlo+b6Qn8pduCS6QzmH6qM61UWs7D2uoYpkellbCYBYUOLW0RX2dFd35W66XJiM
	 uGyJsuKWGSSVnlBg7zq5eQ9+RuGEq/p8T8fs3H/vyC7i/u5AH4ENe0kcLcm7YuIlzo
	 IpVKy1AH6RjS+7prwVC8Ah2razCTkMtSIG229qRo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OB8NCl043568
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 06:08:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 06:08:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 06:08:23 -0500
Received: from [172.24.227.31] (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OB8ECf047117;
	Fri, 24 May 2024 06:08:15 -0500
Message-ID: <1a6b8a83-b378-4869-b536-0fca76e428bf@ti.com>
Date: Fri, 24 May 2024 16:38:13 +0530
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
 <ba8d0b98-67d2-41e2-b568-a40543a9b0fa@ti.com>
 <20240521-realistic-imposing-lemur-aac3ad@houat>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240521-realistic-imposing-lemur-aac3ad@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Maxime,

On 21/05/24 18:45, Maxime Ripard wrote:
> Hi,
> 
> On Thu, May 16, 2024 at 03:10:15PM GMT, Aradhya Bhatia wrote:
>>>>  	/**
>>>>  	 * @pre_enable:
>>>>  	 *
>>>> @@ -285,6 +319,26 @@ struct drm_bridge_funcs {
>>>>  	 */
>>>>  	void (*enable)(struct drm_bridge *bridge);
>>>>  
>>>> +	/**
>>>> +	 * @atomic_early_enable:
>>>> +	 *
>>>> +	 * This callback should enable the bridge. It is called right before
>>>> +	 * the preceding element in the display pipe is enabled. If the
>>>> +	 * preceding element is a bridge this means it's called before that
>>>> +	 * bridge's @atomic_early_enable. If the preceding element is a
>>>> +	 * &drm_crtc it's called right before the crtc's
>>>> +	 * &drm_crtc_helper_funcs.atomic_enable hook.
>>>> +	 *
>>>> +	 * The display pipe (i.e. clocks and timing signals) feeding this bridge
>>>> +	 * will not yet be running when this callback is called. The bridge can
>>>> +	 * enable the display link feeding the next bridge in the chain (if
>>>> +	 * there is one) when this callback is called.
>>>> +	 *
>>>> +	 * The @early_enable callback is optional.
>>>> +	 */
>>>> +	void (*atomic_early_enable)(struct drm_bridge *bridge,
>>>> +				    struct drm_bridge_state *old_bridge_state);
>>>> +
>>>>  	/**
>>>>  	 * @atomic_pre_enable:
>>>>  	 *
>>>> @@ -361,6 +415,21 @@ struct drm_bridge_funcs {
>>>>  	void (*atomic_post_disable)(struct drm_bridge *bridge,
>>>>  				    struct drm_bridge_state *old_bridge_state);
>>>>  
>>>> +	/**
>>>> +	 * @atomic_late_disable:
>>>> +	 *
>>>> +	 * This callback should disable the bridge. It is called right after the
>>>> +	 * preceding element in the display pipe is disabled. If the preceding
>>>> +	 * element is a bridge this means it's called after that bridge's
>>>> +	 * @atomic_late_disable. If the preceding element is a &drm_crtc it's
>>>> +	 * called right after the crtc's &drm_crtc_helper_funcs.atomic_disable
>>>> +	 * hook.
>>>> +	 *
>>>> +	 * The @atomic_late_disable callback is optional.
>>>> +	 */
>>>> +	void (*atomic_late_disable)(struct drm_bridge *bridge,
>>>> +				    struct drm_bridge_state *old_bridge_state);
>>>> +
>>>
>>> But more importantly, I don't quite get the use case you're trying to
>>> solve here.
>>>
>>> If I got the rest of your series, the Cadence DSI bridge needs to be
>>> powered up before its source is started. You can't use atomic_enable or
>>> atomic_pre_enable because it would start the source before the DSI
>>> bridge. Is that correct?
>>>
>>
>> That's right. I cannot use bridge_atomic_pre_enable /
>> bridge_atomic_enable here. But that's because my source is CRTC, which
>> gets enabled via crtc_atomic_enable.
>>
>>
>>> If it is, then how is it different from what
>>> drm_atomic_bridge_chain_pre_enable is doing? The assumption there is
>>> that it starts enabling bridges last to first, to it should be enabled
>>> before anything starts.
>>>
>>> The whole bridge enabling order code starts to be a bit of a mess, so it
>>> would be great if you could list all the order variations we have
>>> currently, and why none work for cdns-dsi.
>>>
>>
>> Of course! I can elaborate on the order.
>>
>> Without my patches (and given there isn't any bridge setting the
>> "pre_enable_prev_first" flag) the order of enable for any single display
>> chain, looks like this -
>>
>> 	crtc_enable
>> 	
>> 	bridge[n]_pre_enable
>> 	---
>> 	bridge[1]_pre_enable
>>
>> 	encoder_enable
>>
>> 	bridge[1]_enable
>> 	---
>> 	bridge[n]_enable
>>
>> The tidss enables at the crtc_enable level, and hence is the first
>> entity with stream on. cdns-dsi doesn't stand a chance with
>> bridge_atmoic_pre_enable / bridge_atmoic_enable hooks. And there is no
>> bridge call happening before crtc currently.
> 
> Thanks for filling the blanks :)
> 
> I assume that since cdns-dsi is a bridge, and it only has a simple
> encoder implementation, for it to receive some video signal we need to
> enable the CRTC before the bridge.
> 
> If so, I think that's the original intent between the bridge pre_enable.
> The original documentation had:
> 
>   pre_enable: this contains things needed to be done for the bridge
>   before this contains things needed to be done for the bridge before
>   this contains things needed to be done for the bridge before.
> 
> and the current one has:
> 
>   The display pipe (i.e. clocks and timing signals) feeding this bridge
>   will not yet be running when this callback is called. The bridge must
>   not enable the display link feeding the next bridge in the chain (if
>   there is one) when this callback is called.
> 
> I would say the CRTC is such a source, even more so now that the encoder
> is usually transparent, so I think we should instead move the crtc
> enable call after the bridge pre_enable.

Hmm, if I understand you right, the newer sequence of calls will look
like this,

	bridge[n]_pre_enable
	---
	bridge[1]_pre_enable

	crtc_enable
	encoder_enable

	bridge[1]_enable
	---
	bridge[n]_enable

I do agree with this. This makes sense. CRTC is indeed such a source,
and should ideally be enabled after the bridges are pre_enabled.

> 
> Would that work?
> 

So, this could potentially work, yes. The cdns-dsi would get pre_enabled
after all bridges after cdns-dsi are pre_enabled. But over a quick test
with BBAI64 + RPi Panel, I don't see any issue.

However, the one concern that I have right now, is about breaking any
existing (albeit faulty) implementation which relies on CRTC being
enabled before the bridges are pre_enabled. =)


Regards
Aradhya

