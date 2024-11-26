Return-Path: <linux-kernel+bounces-422299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BED9D974E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A196165A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339321CCEED;
	Tue, 26 Nov 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="mqZlj+0x"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8C27442
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624386; cv=none; b=olHVPYN1Et0cjb08YWGF+Af+BF4qcWYEcTAM6CcNuE6n/Xr2RENu1rQ6p4huk0JgAPAmjbng1Nlr3AjGhs6I/NEvzZ1TNu5sHtm17iJ72bRqlt18jB75xUlHFRxxt8bSuY37sL00j3hH6wfl1RVJqMZDyUPb7c0wVRla66vDVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624386; c=relaxed/simple;
	bh=VWBwwYDrYSPqco3vJKAcKsxo+QDzyL/dDLDUdf+f59o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP+Y5n3x3zo4tbugaCKpsUMShlpxLJkLazYZD0tM4TwS0TRp41AS4JP9IhVCOMAj+GUQ0wwv0X2SL7dA4OUEa/ed+vOLQQp8OEH6IgzWxwMGV67nkQtpCLS//4dygx2ztOrmy2Vymr0kXOXHx1Z5NozYT4eODWgFcD8VQIptj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=mqZlj+0x; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 61CA9526;
	Tue, 26 Nov 2024 13:32:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1732624360;
	bh=VWBwwYDrYSPqco3vJKAcKsxo+QDzyL/dDLDUdf+f59o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqZlj+0x+eUa8ByKbmVQCDIxlTbP+UHFyUjw2qVJuX12+08oPOiteslOV0U1j8xQL
	 i9YdcHZsLSDWKzB2X7eXGp6bbhmPsKoE1ZEj8IApu9lfu0ZfPVrzFlok7Pf4tsrpo9
	 lu6jXE3SmZzaDHLN4bggX/xoJJt5FaJyr09J0cYU=
Date: Tue, 26 Nov 2024 14:32:53 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexey Brodkin <abrodkin@synopsys.com>,
	dri-devel@lists.freedesktop.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/3] gpu: drm: replace of_graph_get_next_endpoint()
Message-ID: <20241126123253.GF5461@pendragon.ideasonboard.com>
References: <87o722sg6y.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o722sg6y.wl-kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

On Tue, Nov 26, 2024 at 05:43:34AM +0000, Kuninori Morimoto wrote:
> 
> Hi Maarten, Maxime, Thomas
> Cc Laurent
> 
> The patch has been created as 1 patch for "drivers/gpu/drm", but this time
> I have finely disassembled the patch into 3 patches.

Thomas has merged v6 in drm-misc in commit 17558f97fe62fbe14757880a0aa998bfd194ea95

> v6 -> v7
> 	- created as 3 patches
> 
> Kuninori Morimoto (3):
>   gpu: drm: drm_of: replace of_graph_get_next_endpoint()
>   gpu: drm: panel: replace of_graph_get_next_endpoint()
>   gpu: drm: tiny: replace of_graph_get_next_endpoint()
> 
>  drivers/gpu/drm/drm_of.c                              | 4 +++-
>  drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
>  drivers/gpu/drm/tiny/arcpgu.c                         | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 

-- 
Regards,

Laurent Pinchart

