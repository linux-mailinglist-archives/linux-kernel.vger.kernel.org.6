Return-Path: <linux-kernel+bounces-532358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599DA44C03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EBD3AE09F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5EE20E31D;
	Tue, 25 Feb 2025 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKzlaEeo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041539ACC;
	Tue, 25 Feb 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514086; cv=none; b=RcSupwAr73MSBR2/iDXPTsB2UwYTuLoFOla3KmeI69Adw4R3nKDd1VTvT58QsBiEBDvW5TmW+Wfgervke9BddcbwNBixVM4jfU2xyefHOatAOptxq2yGfNNrV0FhJ7zNqNJuZ9dNPAQp2G/GXOJt/QhHMPj7CYs+J6S6Gw0xfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514086; c=relaxed/simple;
	bh=JHvTrakxRhdhuk+kBY06tb9Lr0ActVSa7Q4+RPH0pK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDV7Dygjvi1S+VeJWLcs+lFtSWKlkEzZ0Xsiu/RLWqJsWL7hwk8Hc0P7fBzE4SPpuFBsTylJUjym1cFYgd3IF1ZFnW15dLk6REulxpTpJTmXL9mcKQLG9IcvOqrTlN6syPaq2vq4iTAVwBw1620esg3UbTVH0xZyVI7sxDtQ/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKzlaEeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CD0C4CEDD;
	Tue, 25 Feb 2025 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514086;
	bh=JHvTrakxRhdhuk+kBY06tb9Lr0ActVSa7Q4+RPH0pK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKzlaEeoJRWop5oAYb/YCS8M3HQGqwjJwMv93yKTF+5ZGXcyYNs0jDb3SNTw2tE5J
	 Y2ZVchmubya8cGdPdunn3Ce8SurKCWGHt/gqiUrr+4TYEEVqF8CWl8HQvLBMawu7yx
	 rpOagGnIsYYfUx8KIPZbgV8XwUOGMqFV3Y0UB3dWZRxljWZ4wXQXHoVluPPmSaNA4C
	 UvHnD0OexH1v/9kWeA+M6xRzcJMA8tZfAN3JDiMNFq/syCAaM8RS7tEmJA5uvpMlw5
	 84wLguasfXtfSnVYJZwDwQ0MjBqzp5XPCyuLAIbZHkTFbJTfYI+Dae4eBG+y+YKwa5
	 YFGCilE1PYtIA==
Date: Tue, 25 Feb 2025 14:08:04 -0600
From: Rob Herring <robh@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Frank Li <Frank.li@nxp.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: display/lvds-codec: add
 ti,sn65lvds822
Message-ID: <20250225200804.GA2947190-robh@kernel.org>
References: <20250106-skov-dt-updates-v2-0-4504d3f00ecb@pengutronix.de>
 <20250106-skov-dt-updates-v2-5-4504d3f00ecb@pengutronix.de>
 <37d2a7bb-1c8c-4c33-a277-dc1a7448433b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d2a7bb-1c8c-4c33-a277-dc1a7448433b@pengutronix.de>

On Wed, Feb 19, 2025 at 02:26:52PM +0100, Ahmad Fatoum wrote:
> Dear DRM bridge maintainers,
> 
> On 06.01.25 17:06, Ahmad Fatoum wrote:
> > Add compatible strings for TI SN65LVDS822, a FlatLink LVDS receiver.
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> Shawn has asked that the DT or display maintainers take this one patch
> through their tree. He has already applied the remainder of the series.
> 
> Can you take a look? DT maintainers already acked it.

I've applied it.

Rob

