Return-Path: <linux-kernel+bounces-226975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B341914692
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA370B21280
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55246131BDF;
	Mon, 24 Jun 2024 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ruheMyKN"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D1B40BE5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719222109; cv=none; b=gfONP5PI8jnlukIo2oyAdqefNXiKYsh6jSABbyX23Fnmdk09b9TPOngvxsObo/BlPvpZgG3Hu+yA8TvQde+JVzACFteulSWwUViewjNJBlQMwdf+wxW0dKpTkh2QnHymJbuEtd4ImcO0i8eLRMtwSbALUPOSgXUdRf1NbpCsmVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719222109; c=relaxed/simple;
	bh=BotLkRd5Ic12PreUUp144z6UmcFk5/cq7mgSz01VhxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQU7g6KZ+1Hw8rgtpNhbFtoeMV9VfpiXNqjVzvX4t/x+NagltBCJf3P3u03tmcu93K7AtRDu+rYePjBp6dGG7Fm09gZhiy7RbNVULPSrzCg9VEL4b6hM0eRpPieachmV2wB3ntd/YlDjVAHfBScvH5gryZfRiIBpWhpWS9glnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ruheMyKN; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719222102;
 bh=BdV2tuC48NG4yYKfC4Tz5zl1VXkraBQh0nyshKoiFUA=;
 b=ruheMyKNW3UF5U88mWwgz3/BJ8bV6jHXcFm3WsFipFemZSDPE11r6JtKKuwCNl535PsGUiZHf
 TRzdHcer2ULnOHqXjPBBLE/0dqdAjjTBeG0YJqqnlKELYfdwYCjyI3+X5dJYxjKBaFf4mzAYOOv
 rD+0ScOUVwpAnj8DAKSGYPuGDbAGrDFxS5B3Rtt4fTafBFF3io/4+5oFRs+KMib6pNl9n3hdRKd
 Np3/B3vzTJnGQFO6Kj/G0u19x5x2tnsDbkJrjkSS1PXTRYcYKMIwf3s7pY/03sT9VCg01EMonQA
 FeeNaXA/SgoGmu7bnd68ChNEpuHTCR5QfYDN91Yfd+lg==
Message-ID: <af41d129-53ce-4875-bee2-c331aa47c248@kwiboo.se>
Date: Mon, 24 Jun 2024 11:41:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
To: neil.armstrong@linaro.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss
 <rfoss@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-2-jonas@kwiboo.se>
 <dd6f7a67-e338-4c08-8520-8e85a953834b@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <dd6f7a67-e338-4c08-8520-8e85a953834b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66793f55e55100373d412cfb

Hi Neil,

On 2024-06-24 11:23, Neil Armstrong wrote:
> On 11/06/2024 17:50, Jonas Karlman wrote:
>> Change to only call poweron/poweroff from atomic_enable/atomic_disable
>> ops instead of trying to keep a bridge_is_on state and poweron/off in
>> the hotplug irq handler.
>>
>> A benefit of this is that drm mode_config mutex is always held at
>> poweron/off, something that may reduce the need for our own mutex.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
>>   1 file changed, 2 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 9f2bc932c371..34bc6f4754b8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -172,7 +172,6 @@ struct dw_hdmi {
>>   	enum drm_connector_force force;	/* mutex-protected force state */
>>   	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>>   	bool disabled;			/* DRM has disabled our bridge */
>> -	bool bridge_is_on;		/* indicates the bridge is on */
>>   	bool rxsense;			/* rxsense state */
>>   	u8 phy_mask;			/* desired phy int mask settings */
>>   	u8 mc_clkdis;			/* clock disable register */
>> @@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>>   
>>   static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
>>   {
>> -	hdmi->bridge_is_on = true;
>> -
>>   	/*
>>   	 * The curr_conn field is guaranteed to be valid here, as this function
>>   	 * is only be called when !hdmi->disabled.
>> @@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>>   		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>>   		hdmi->phy.enabled = false;
>>   	}
>> -
>> -	hdmi->bridge_is_on = false;
>> -}
>> -
>> -static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
>> -{
>> -	int force = hdmi->force;
>> -
>> -	if (hdmi->disabled) {
>> -		force = DRM_FORCE_OFF;
>> -	} else if (force == DRM_FORCE_UNSPECIFIED) {
>> -		if (hdmi->rxsense)
>> -			force = DRM_FORCE_ON;
>> -		else
>> -			force = DRM_FORCE_OFF;
>> -	}
> 
> This means we always poweron the bridge even if rxsense is false ?

If I follow the logic there should not be any difference, beside that
power on now only happen in atomic_enable instead of sometime in irq
handler.

hdmi->rxsense is set to true based on hpd in dw_hdmi_setup_rx_sense().
For both meson and dw-hdmi this means HPD=1 and not rxsense=1.

drm core will call the force/detect ops and enable/disable based on
forced/HPD state, so I am not expecting any difference in how this
currently works.

This change to only poweron/setup in atomic_enable should also fix
issues/situations where dw-hdmi was poweron too early during bootup in
irq handler, before the drm driver was fully probed.

Regards,
Jonas

> 
> Neil
> 
>> -
>> -	if (force == DRM_FORCE_OFF) {
>> -		if (hdmi->bridge_is_on)
>> -			dw_hdmi_poweroff(hdmi);
>> -	} else {
>> -		if (!hdmi->bridge_is_on)
>> -			dw_hdmi_poweron(hdmi);
>> -	}
>>   }
>>   
>>   /*
>> @@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>   
>>   	mutex_lock(&hdmi->mutex);
>>   	hdmi->force = connector->force;
>> -	dw_hdmi_update_power(hdmi);
>>   	dw_hdmi_update_phy_mask(hdmi);
>>   	mutex_unlock(&hdmi->mutex);
>>   }
>> @@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>>   	mutex_lock(&hdmi->mutex);
>>   	hdmi->disabled = true;
>>   	hdmi->curr_conn = NULL;
>> -	dw_hdmi_update_power(hdmi);
>> +	dw_hdmi_poweroff(hdmi);
>>   	dw_hdmi_update_phy_mask(hdmi);
>>   	handle_plugged_change(hdmi, false);
>>   	mutex_unlock(&hdmi->mutex);
>> @@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>>   	mutex_lock(&hdmi->mutex);
>>   	hdmi->disabled = false;
>>   	hdmi->curr_conn = connector;
>> -	dw_hdmi_update_power(hdmi);
>> +	dw_hdmi_poweron(hdmi);
>>   	dw_hdmi_update_phy_mask(hdmi);
>>   	handle_plugged_change(hdmi, true);
>>   	mutex_unlock(&hdmi->mutex);
>> @@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>>   		if (hpd)
>>   			hdmi->rxsense = true;
>>   
>> -		dw_hdmi_update_power(hdmi);
>>   		dw_hdmi_update_phy_mask(hdmi);
>>   	}
>>   	mutex_unlock(&hdmi->mutex);
> 


