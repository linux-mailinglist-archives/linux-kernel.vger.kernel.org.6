Return-Path: <linux-kernel+bounces-201356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A875F8FBD79
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F2E282F67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89214B974;
	Tue,  4 Jun 2024 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="N61vra7C";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="r4JvKN3M"
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEB1350FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533744; cv=none; b=lHxOH/1RsFivC/DS57Vlg8xefso7DuMaSV/MFgIFbjFnID96vllBUL5zXeyan38zGDXRjiLWYahr8Z5cWcCJI4+oOjB8/JRzZbOM9pdPS9/VXUCvRmHLB37aOMsLDF62ca/tKFTMGps/pdamrbpyLEHvl3M5pUw+WGjToN8PlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533744; c=relaxed/simple;
	bh=1dWSYg0dVf/rqsLrOmw8N6/UvJ03wpNFLYhrom2Lml0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCk7zTw4zuVu0owWMdk7wMSnOwESBA8Bup9r44G9FXg5Sx0b8/732scmuSlDsZUu3j6x8vXxZ++Jj8MYm+pR2RI/JZqnRupmZbj6bLp0tv//DP7FBUWt17R7YRq6/3qUh2E0xkFM9SFFbJLbWGo1lRLeHos2gIq5PvAkvwz2/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=N61vra7C; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=r4JvKN3M; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Dk4sfgI36ZWaPJ+eBS/GI/TZ8w55X9bgUEDY5cQtdtU=;
	b=N61vra7CHLZfKe5uIUlYx3GQv9YGIc7bLyEhl3+9zNcLfrg/064TgGMDdyq/ZA10mlYXb06vgNF0h
	 qwxtSmeWRmsmmd3wrCCBBvUY+SFythORAs9pyE4otLatq0n/0MIHh8STbOiAKmU9DUOex9d1E4YSfX
	 x8KwPBxjY/1bPXa3W4ZVzNJZE8vyRU4ysM0VrCOe55RkF7hCRcl+V9ySXs0kbLERYnt8ZjSy6kIePK
	 853Zbg7dZnTvyDX2GrBxleUad6prFsi1lEZKiKL68eW9CCm5QisalqofZTtORQWuI1bSEXtwK7zLcI
	 Xu0tUkNa02dSjD3QS04pgnpBnbZ1OSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=Dk4sfgI36ZWaPJ+eBS/GI/TZ8w55X9bgUEDY5cQtdtU=;
	b=r4JvKN3MaF/e09yO6vz7gW/+Vs/xVKV1CvUIVwJnko5Bqds84IFN0/PUeYg4Zdo1itqPMmJMDSrRa
	 fTI/wgXCg==
X-HalOne-ID: c619a21d-22b2-11ef-9886-bf3d7f4c9d3b
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id c619a21d-22b2-11ef-9886-bf3d7f4c9d3b;
	Tue, 04 Jun 2024 20:41:12 +0000 (UTC)
Date: Tue, 4 Jun 2024 22:41:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
Message-ID: <20240604204110.GA84949@ravnborg.org>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
 <20240601143226.GA2003970@ravnborg.org>
 <59519381-2729-4839-9882-65a981a0c551@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59519381-2729-4839-9882-65a981a0c551@collabora.com>

Hi Cristian.

On Tue, Jun 04, 2024 at 10:32:04PM +0300, Cristian Ciocaltea wrote:
> Hi Sam,
> 
> On 6/1/24 5:32 PM, Sam Ravnborg wrote:
> > Hi Cristian,
> > 
> > a few drive-by comments below.
> > 
> > 	Sam
> > 
> > 
> >> +
> >> +static const struct drm_connector_funcs dw_hdmi_qp_connector_funcs = {
> >> +	.fill_modes = drm_helper_probe_single_connector_modes,
> >> +	.detect = dw_hdmi_connector_detect,
> >> +	.destroy = drm_connector_cleanup,
> >> +	.force = dw_hdmi_qp_connector_force,
> >> +	.reset = drm_atomic_helper_connector_reset,
> >> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >> +};
> >> +
> >> +static int dw_hdmi_qp_bridge_attach(struct drm_bridge *bridge,
> >> +				    enum drm_bridge_attach_flags flags)
> >> +{
> >> +	struct dw_hdmi *hdmi = bridge->driver_private;
> >> +
> >> +	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> >> +		return drm_bridge_attach(bridge->encoder, hdmi->next_bridge,
> >> +					 bridge, flags);
> >> +
> >> +	return dw_hdmi_connector_create(hdmi, &dw_hdmi_qp_connector_funcs);
> >> +}
> > 
> > Are there any users left that requires the display driver to create the
> > connector?
> > In other words - could this driver fail if DRM_BRIDGE_ATTACH_NO_CONNECTOR
> > is not passed and drop dw_hdmi_connector_create()?
> > 
> > I did not try to verify this - just a naive question.
> 
> I've just tested this and it doesn't work - dw_hdmi_connector_create()
> is still needed.

Hmm, seems the display driver or some other bridge driver fails to
support "DRM_BRIDGE_ATTACH_NO_CONNECTOR".
what other drivers are involved?

Note that my comments here should be seen as potential future
improvements, and do not block the patch from being used.

	Sam

