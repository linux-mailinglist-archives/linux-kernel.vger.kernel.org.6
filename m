Return-Path: <linux-kernel+bounces-227188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC99149AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4E5B22887
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84113B58C;
	Mon, 24 Jun 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="PDBgmmQR"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B8137777
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231622; cv=none; b=qeOMt65iinQcAJcl2Fe+5on+HgS8msQd7Hfx2EB2dLL24M+wUh+3cZ6+n9q/AbDTDHtOFc8eobEMuusWdlAiIivC4TcEMaihyfvWv2E1EcU4XuOg0+ela3flXcb9g5UEipl9NaUSmiqMKMYJq3ohH8tHrbaVAI4cStWJ5WzTXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231622; c=relaxed/simple;
	bh=5bKiNX7duhvm8bTe+AqPAZDwP5kUF0kWeoF+vCAFWak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDWXaYu6+BS9dHfZoCB9Kp2edoPA2bgA36feQzvEfgT/2QDJp2eV3s6FSZBI19UqOsB2H/oMKGNVduOJM1LlrPuszrPUKnUN/LsTkodlxnK/pcsQWyB8nSFXcrJIfg1x/9Ii5WJGgIod9zjKwd4qqeFWGLqlB7EnIYD65C9MzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=PDBgmmQR; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1719231605;
 bh=pk4OJ05lJO30wCYaTyiWAs1biu8A+ZyGDUB/gIorX1c=;
 b=PDBgmmQR4mGx5PUWYKZg9cHY76qKAlAFeRVNRynFw+lWBQWx2GE+ePD/jKrC8hcjoU8NgbuSz
 wNj8ZGRHU35erw5mu6xycidlVSmAXiQgQIbESI7xplo/COQwFlbGzpF6HF3HNVdM6R2XMAbbHe4
 Kawkr7A37fIoWF/zdNE+zN06T2HgY5ugKODvGRhkfQNQbyy+DiNEVyz30ZS5Zx5XhSCco56DNNu
 qcyG4Pja8k8iIYS84DlHcn+onIlCTLGyX68NUArTRGadcwuNyLaViX9JDQ6pPGTl7WpV8RiZN66
 TCYfP+07Bq4f4XOQrl2Oe6JQqDGP/6wU1OjcoYEwF5/w==
Message-ID: <52845f6f-2593-4ecf-9f0c-f4e948c0e896@kwiboo.se>
Date: Mon, 24 Jun 2024 14:19:36 +0200
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
 <af41d129-53ce-4875-bee2-c331aa47c248@kwiboo.se>
 <2759176e-031b-4c63-8dc8-b017a63f00b0@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <2759176e-031b-4c63-8dc8-b017a63f00b0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6679645de55100373d413d03

Hi Neil,

On 2024-06-24 11:56, neil.armstrong@linaro.org wrote:
> On 24/06/2024 11:41, Jonas Karlman wrote:
>> Hi Neil,
>>
>> On 2024-06-24 11:23, Neil Armstrong wrote:
>>> On 11/06/2024 17:50, Jonas Karlman wrote:
>>>> Change to only call poweron/poweroff from atomic_enable/atomic_disable
>>>> ops instead of trying to keep a bridge_is_on state and poweron/off in
>>>> the hotplug irq handler.
>>>>
>>>> A benefit of this is that drm mode_config mutex is always held at
>>>> poweron/off, something that may reduce the need for our own mutex.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
>>>>    1 file changed, 2 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> index 9f2bc932c371..34bc6f4754b8 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -172,7 +172,6 @@ struct dw_hdmi {
>>>>    	enum drm_connector_force force;	/* mutex-protected force state */
>>>>    	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
>>>>    	bool disabled;			/* DRM has disabled our bridge */
>>>> -	bool bridge_is_on;		/* indicates the bridge is on */
>>>>    	bool rxsense;			/* rxsense state */
>>>>    	u8 phy_mask;			/* desired phy int mask settings */
>>>>    	u8 mc_clkdis;			/* clock disable register */
>>>> @@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
>>>>    
>>>>    static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
>>>>    {
>>>> -	hdmi->bridge_is_on = true;
>>>> -
>>>>    	/*
>>>>    	 * The curr_conn field is guaranteed to be valid here, as this function
>>>>    	 * is only be called when !hdmi->disabled.
>>>> @@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
>>>>    		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
>>>>    		hdmi->phy.enabled = false;
>>>>    	}
>>>> -
>>>> -	hdmi->bridge_is_on = false;
>>>> -}
>>>> -
>>>> -static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
>>>> -{
>>>> -	int force = hdmi->force;
>>>> -
>>>> -	if (hdmi->disabled) {
>>>> -		force = DRM_FORCE_OFF;
>>>> -	} else if (force == DRM_FORCE_UNSPECIFIED) {
>>>> -		if (hdmi->rxsense)
>>>> -			force = DRM_FORCE_ON;
>>>> -		else
>>>> -			force = DRM_FORCE_OFF;
>>>> -	}
>>>
>>> This means we always poweron the bridge even if rxsense is false ?
>>
>> If I follow the logic there should not be any difference, beside that
>> power on now only happen in atomic_enable instead of sometime in irq
>> handler.
>>
>> hdmi->rxsense is set to true based on hpd in dw_hdmi_setup_rx_sense().
>> For both meson and dw-hdmi this means HPD=1 and not rxsense=1.
> 
> Yeah I know, I was worried for other platforms using rxsense

From what I can find only dw-hdmi.c and dw_hdmi_meson.c are caller of
dw_hdmi_setup_rx_sense(). For meson the same value is passed for both
hpd and rx_sense, everyone else hpd = HPD and rx_sense = RX_SENSE status.

My understanding and testing based on Rockchip has shown that rx_sense
has no significant impact before and after this change.

> 
>>
>> drm core will call the force/detect ops and enable/disable based on
>> forced/HPD state, so I am not expecting any difference in how this
>> currently works.
>>
>> This change to only poweron/setup in atomic_enable should also fix
>> issues/situations where dw-hdmi was poweron too early during bootup in
>> irq handler, before the drm driver was fully probed.

I may have been wrong here, there is a check for disabled here so it
should not have setup() before atomic_enable().

Still we should ensure configure happen in atomic_enable(). The
hpd_irq_event/hpd_notify calls will trigger a detect() and signal core
if the bridge should be enabled/disabled when connector status changes.

> 
> Hmm, but I thought the code wouldn't poweron the bridge is rxsense was 0
> even if a mode was set, this won't work like this anymore right ?

This is what I thought was happening, and the comment in code seem to
indicate that. However, the code only seem to care about HPD=1 status to
poweron() and possible both HPD=0 + RXSENSE=0 to poweroff().

To make matter more complex core also mainly care about detect() status
and most/all related drivers seem to only use the the HPD status.

So I would say that there should not be any changes in impact of the
rxsense signal.

Will also send a new patch in a v2 for dw_hdmi_irq() that may be related:

-		if (phy_stat & HDMI_PHY_HPD)
+		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
+		    (phy_stat & HDMI_PHY_HPD))
			status = connector_status_connected;

or there may be a status_connected event triggered when rxsense goes
from 1 to 0 and a second one with status_disconnected shortly after when
hpd goes from 1 to 0 when the cable is removed.

Regards,
Jonas

> 
> Neil
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Neil
>>>
>>>> -
>>>> -	if (force == DRM_FORCE_OFF) {
>>>> -		if (hdmi->bridge_is_on)
>>>> -			dw_hdmi_poweroff(hdmi);
>>>> -	} else {
>>>> -		if (!hdmi->bridge_is_on)
>>>> -			dw_hdmi_poweron(hdmi);
>>>> -	}
>>>>    }
>>>>    
>>>>    /*
>>>> @@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
>>>>    
>>>>    	mutex_lock(&hdmi->mutex);
>>>>    	hdmi->force = connector->force;
>>>> -	dw_hdmi_update_power(hdmi);
>>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>>    	mutex_unlock(&hdmi->mutex);
>>>>    }
>>>> @@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
>>>>    	mutex_lock(&hdmi->mutex);
>>>>    	hdmi->disabled = true;
>>>>    	hdmi->curr_conn = NULL;
>>>> -	dw_hdmi_update_power(hdmi);
>>>> +	dw_hdmi_poweroff(hdmi);
>>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>>    	handle_plugged_change(hdmi, false);
>>>>    	mutex_unlock(&hdmi->mutex);
>>>> @@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
>>>>    	mutex_lock(&hdmi->mutex);
>>>>    	hdmi->disabled = false;
>>>>    	hdmi->curr_conn = connector;
>>>> -	dw_hdmi_update_power(hdmi);
>>>> +	dw_hdmi_poweron(hdmi);
>>>>    	dw_hdmi_update_phy_mask(hdmi);
>>>>    	handle_plugged_change(hdmi, true);
>>>>    	mutex_unlock(&hdmi->mutex);
>>>> @@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
>>>>    		if (hpd)
>>>>    			hdmi->rxsense = true;
>>>>    
>>>> -		dw_hdmi_update_power(hdmi);
>>>>    		dw_hdmi_update_phy_mask(hdmi);
>>>>    	}
>>>>    	mutex_unlock(&hdmi->mutex);
>>>
>>
> 


