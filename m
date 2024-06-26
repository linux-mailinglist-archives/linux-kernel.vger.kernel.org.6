Return-Path: <linux-kernel+bounces-230212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2009179E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DA51C22C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D115DBBA;
	Wed, 26 Jun 2024 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gipRCtU+"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221B15AD90
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387545; cv=none; b=QW+Rk7UepDbIOl9DVa/3PgmjTQOy1KKM0wLKrLxXve6bm4b8kcyLo2FeGxlZw7886Of6cvmJi4Cj018OKP1Q7POM1D46p1Rl+riHkKCcTXSovaHa/ILm33u+uaZnBXN0AVleHjFl5H3kCmOp7R0EuJ3xmKSDnyH6nM6soWHByIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387545; c=relaxed/simple;
	bh=5eKSu9kbRUyxtSZxREiwa4iaiU4wWAw7KDytPkzXp6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs7Cvo/Avi+HWqxdqobsLWT3Y9tcIHUykHsuX8XrpELBvp+FnJd9akduJ45//tU+r6GTiNMUjBIhfL7K8CHE54vEEBu5ot8GAXvB3HqWIiDoyRYWU5kheZIGcnceo4gm9FjsQvWTmKodY1QlWL6KHhrrEKt4kvzEcsOdspaYAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=gipRCtU+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-364fee5051fso193071f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1719387542; x=1719992342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80MAMiomnHDemOBSYAghnX0QKPPRb/cUff3aHHXhusQ=;
        b=gipRCtU+KFIEqvoDEROpolOcTltpEkg+vaLMUb1Uxe5znI8axC+pLADJ+7h8fw6s6v
         u0xBK8RQxxF5Krbj5woro7aJYO3nhrgTQxZBgcZqPRKWyAfedySHYieuk7FKgnjjfAAU
         xy9WS1pYJ+GOMoVLZSqgWVoxXda36UKeU2S/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719387542; x=1719992342;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80MAMiomnHDemOBSYAghnX0QKPPRb/cUff3aHHXhusQ=;
        b=aa0YbMZYkK/7moVnAUtKWtE+5nXoPSk/J/85votXojj0eOv3ulZMJy+wsvOeMBlERJ
         TPP3MT9VslrY87vY6iBqdeXOOk06she8H8q4pteCj2fbkfAbGer4q4ZLjRJA8ujhKuGX
         LI/+NZNj4dV7/EfJq374eUgF/K3xsxIm/Xi1TXB2pT/NxpQE9BAq8OTSFYFYdNIdL9Px
         Xv/WAEOFnFP9zLABMhNQXnqdStwEQOj8uxFRsqDOuslqJwEJGL1yKHKy6o+IiiuIAUH8
         5gnK1YNcbjRByRQX77p9DpnOIN6xHlntDRWHE6b+4HkTycbHLTXPxXbZoP1jkjiEx+F3
         Rqqg==
X-Forwarded-Encrypted: i=1; AJvYcCVgwNEbVoldxvF8EeXOFxchPR1hB6o+Iop9xBsL8XC71qiaq5sWJhmdo+F8u+z/hS3h1ZMkmExdGzekNHr3RJyqqUsTDMp147AAbkvm
X-Gm-Message-State: AOJu0Ywvb9sG11mK1j6YJ3GrkSc8ycKiP5lbZ3yH1fwPZ9IMHWYxkGLT
	tuPDwKaxapJhHUZRLebkWm5tD0YZXLCwn1bbCjutPndU2LoaqovwWZYXU/uaO0A=
X-Google-Smtp-Source: AGHT+IG+tOVxxsMsUBe/F8n5jaBqQ546UAl4FpKogj0GBgGhsdIigEJXGf0ITWrY3uCImJKz3vbuVw==
X-Received: by 2002:a05:6000:1fa9:b0:365:ca95:b6cd with SMTP id ffacd0b85a97d-366e2aa64ddmr7477185f8f.7.1719387542229;
        Wed, 26 Jun 2024 00:39:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f675esm14968835f8f.22.2024.06.26.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:39:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:38:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] drm: bridge: dw_hdmi: Call poweron/poweroff from
 atomic enable/disable
Message-ID: <ZnvFkwy1hBwxFxQL@phenom.ffwll.local>
Mail-Followup-To: Jonas Karlman <jonas@kwiboo.se>,
	neil.armstrong@linaro.org, Andrzej Hajda <andrzej.hajda@intel.com>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240611155108.1436502-1-jonas@kwiboo.se>
 <20240611155108.1436502-2-jonas@kwiboo.se>
 <dd6f7a67-e338-4c08-8520-8e85a953834b@linaro.org>
 <af41d129-53ce-4875-bee2-c331aa47c248@kwiboo.se>
 <2759176e-031b-4c63-8dc8-b017a63f00b0@linaro.org>
 <52845f6f-2593-4ecf-9f0c-f4e948c0e896@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52845f6f-2593-4ecf-9f0c-f4e948c0e896@kwiboo.se>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Mon, Jun 24, 2024 at 02:19:36PM +0200, Jonas Karlman wrote:
> Hi Neil,
> 
> On 2024-06-24 11:56, neil.armstrong@linaro.org wrote:
> > On 24/06/2024 11:41, Jonas Karlman wrote:
> >> Hi Neil,
> >>
> >> On 2024-06-24 11:23, Neil Armstrong wrote:
> >>> On 11/06/2024 17:50, Jonas Karlman wrote:
> >>>> Change to only call poweron/poweroff from atomic_enable/atomic_disable
> >>>> ops instead of trying to keep a bridge_is_on state and poweron/off in
> >>>> the hotplug irq handler.
> >>>>
> >>>> A benefit of this is that drm mode_config mutex is always held at
> >>>> poweron/off, something that may reduce the need for our own mutex.
> >>>>
> >>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>> ---
> >>>>    drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
> >>>>    1 file changed, 2 insertions(+), 31 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> index 9f2bc932c371..34bc6f4754b8 100644
> >>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> >>>> @@ -172,7 +172,6 @@ struct dw_hdmi {
> >>>>    	enum drm_connector_force force;	/* mutex-protected force state */
> >>>>    	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
> >>>>    	bool disabled;			/* DRM has disabled our bridge */
> >>>> -	bool bridge_is_on;		/* indicates the bridge is on */
> >>>>    	bool rxsense;			/* rxsense state */
> >>>>    	u8 phy_mask;			/* desired phy int mask settings */
> >>>>    	u8 mc_clkdis;			/* clock disable register */
> >>>> @@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
> >>>>    
> >>>>    static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
> >>>>    {
> >>>> -	hdmi->bridge_is_on = true;
> >>>> -
> >>>>    	/*
> >>>>    	 * The curr_conn field is guaranteed to be valid here, as this function
> >>>>    	 * is only be called when !hdmi->disabled.
> >>>> @@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
> >>>>    		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
> >>>>    		hdmi->phy.enabled = false;
> >>>>    	}
> >>>> -
> >>>> -	hdmi->bridge_is_on = false;
> >>>> -}
> >>>> -
> >>>> -static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
> >>>> -{
> >>>> -	int force = hdmi->force;
> >>>> -
> >>>> -	if (hdmi->disabled) {
> >>>> -		force = DRM_FORCE_OFF;
> >>>> -	} else if (force == DRM_FORCE_UNSPECIFIED) {
> >>>> -		if (hdmi->rxsense)
> >>>> -			force = DRM_FORCE_ON;
> >>>> -		else
> >>>> -			force = DRM_FORCE_OFF;
> >>>> -	}
> >>>
> >>> This means we always poweron the bridge even if rxsense is false ?
> >>
> >> If I follow the logic there should not be any difference, beside that
> >> power on now only happen in atomic_enable instead of sometime in irq
> >> handler.
> >>
> >> hdmi->rxsense is set to true based on hpd in dw_hdmi_setup_rx_sense().
> >> For both meson and dw-hdmi this means HPD=1 and not rxsense=1.
> > 
> > Yeah I know, I was worried for other platforms using rxsense
> 
> From what I can find only dw-hdmi.c and dw_hdmi_meson.c are caller of
> dw_hdmi_setup_rx_sense(). For meson the same value is passed for both
> hpd and rx_sense, everyone else hpd = HPD and rx_sense = RX_SENSE status.
> 
> My understanding and testing based on Rockchip has shown that rx_sense
> has no significant impact before and after this change.
> 
> > 
> >>
> >> drm core will call the force/detect ops and enable/disable based on
> >> forced/HPD state, so I am not expecting any difference in how this
> >> currently works.
> >>
> >> This change to only poweron/setup in atomic_enable should also fix
> >> issues/situations where dw-hdmi was poweron too early during bootup in
> >> irq handler, before the drm driver was fully probed.
> 
> I may have been wrong here, there is a check for disabled here so it
> should not have setup() before atomic_enable().
> 
> Still we should ensure configure happen in atomic_enable(). The
> hpd_irq_event/hpd_notify calls will trigger a detect() and signal core
> if the bridge should be enabled/disabled when connector status changes.
> 
> > 
> > Hmm, but I thought the code wouldn't poweron the bridge is rxsense was 0
> > even if a mode was set, this won't work like this anymore right ?
> 
> This is what I thought was happening, and the comment in code seem to
> indicate that. However, the code only seem to care about HPD=1 status to
> poweron() and possible both HPD=0 + RXSENSE=0 to poweroff().

More fundamental question: Why do we even care what happens in this case?
Userspace lit up an output that's not connected either

- it's broken, it gets to keep to pieces

- it knows what it's doing, there is a display, it's just broken, and it
  _really_ wants the output to be lit up.

Drivers trying to be clever isn't a good idea here imo ...
-Sima

> To make matter more complex core also mainly care about detect() status
> and most/all related drivers seem to only use the the HPD status.
> 
> So I would say that there should not be any changes in impact of the
> rxsense signal.
> 
> Will also send a new patch in a v2 for dw_hdmi_irq() that may be related:
> 
> -		if (phy_stat & HDMI_PHY_HPD)
> +		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
> +		    (phy_stat & HDMI_PHY_HPD))
> 			status = connector_status_connected;
> 
> or there may be a status_connected event triggered when rxsense goes
> from 1 to 0 and a second one with status_disconnected shortly after when
> hpd goes from 1 to 0 when the cable is removed.
> 
> Regards,
> Jonas
> 
> > 
> > Neil
> > 
> >>
> >> Regards,
> >> Jonas
> >>
> >>>
> >>> Neil
> >>>
> >>>> -
> >>>> -	if (force == DRM_FORCE_OFF) {
> >>>> -		if (hdmi->bridge_is_on)
> >>>> -			dw_hdmi_poweroff(hdmi);
> >>>> -	} else {
> >>>> -		if (!hdmi->bridge_is_on)
> >>>> -			dw_hdmi_poweron(hdmi);
> >>>> -	}
> >>>>    }
> >>>>    
> >>>>    /*
> >>>> @@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
> >>>>    
> >>>>    	mutex_lock(&hdmi->mutex);
> >>>>    	hdmi->force = connector->force;
> >>>> -	dw_hdmi_update_power(hdmi);
> >>>>    	dw_hdmi_update_phy_mask(hdmi);
> >>>>    	mutex_unlock(&hdmi->mutex);
> >>>>    }
> >>>> @@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
> >>>>    	mutex_lock(&hdmi->mutex);
> >>>>    	hdmi->disabled = true;
> >>>>    	hdmi->curr_conn = NULL;
> >>>> -	dw_hdmi_update_power(hdmi);
> >>>> +	dw_hdmi_poweroff(hdmi);
> >>>>    	dw_hdmi_update_phy_mask(hdmi);
> >>>>    	handle_plugged_change(hdmi, false);
> >>>>    	mutex_unlock(&hdmi->mutex);
> >>>> @@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
> >>>>    	mutex_lock(&hdmi->mutex);
> >>>>    	hdmi->disabled = false;
> >>>>    	hdmi->curr_conn = connector;
> >>>> -	dw_hdmi_update_power(hdmi);
> >>>> +	dw_hdmi_poweron(hdmi);
> >>>>    	dw_hdmi_update_phy_mask(hdmi);
> >>>>    	handle_plugged_change(hdmi, true);
> >>>>    	mutex_unlock(&hdmi->mutex);
> >>>> @@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
> >>>>    		if (hpd)
> >>>>    			hdmi->rxsense = true;
> >>>>    
> >>>> -		dw_hdmi_update_power(hdmi);
> >>>>    		dw_hdmi_update_phy_mask(hdmi);
> >>>>    	}
> >>>>    	mutex_unlock(&hdmi->mutex);
> >>>
> >>
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

