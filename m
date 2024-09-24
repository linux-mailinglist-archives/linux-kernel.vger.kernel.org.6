Return-Path: <linux-kernel+bounces-337515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D16A984B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F691F223CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DD01AD3FD;
	Tue, 24 Sep 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ICCYT+6T"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBC1AD3EB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203451; cv=none; b=LMKX3QRGl++s+k+JMkAybRicrpGcc1llVDJC5ponnfpVpuLynA5wP5kxisDBjrE/KOUVFfEtlTbYvISnbANpezXBtKkniU6MWJOBSxq1Pk2hBmLfrTmgUdqwDE6BPCvlqrE7La/LSJW+A/a1TKiq5Yl6y8Qyfzahu8u5ECo8ZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203451; c=relaxed/simple;
	bh=K4ipj/F3NB0jOguIlNsqwGp8ZR4U5A/NO4flIB98um4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAsvkQDI1wfiuyOyzjIIPPn49XeEIzJXYsQiSYET8d/Z30yqJkBuC3AjHLbaV/QDNkrEj8HlO83Y3VmaNLyIm9+BZ2BxhKCgCla/JUV+w+P1GR1CpqzmoGNvGqpS+CsHormoGLEs9v5H/q9FovFUePYfuCabKElpvml0v74XkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ICCYT+6T; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 38642C8E;
	Tue, 24 Sep 2024 20:42:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1727203360;
	bh=K4ipj/F3NB0jOguIlNsqwGp8ZR4U5A/NO4flIB98um4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICCYT+6ThZOw3owTfXdSqxF4IZSxMyxUJLLDOtHbdWlQ4IVSqIrqKPdQrMWq/a143
	 0mTCvwf7SNgIOb1+Ry2g6nYPg9zAedDLXWbZoK6rBzc4zCZ7EAnbCVTjF2TFtitSvc
	 lsAg/yUVTQEXGCqLXcxNeOxiVqnvugcO6Pxl+6ic=
Date: Tue, 24 Sep 2024 21:43:35 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: lists@steffen.cc
Cc: dri-devel@lists.freedesktop.org,
	Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: zynqmp_dpsub: also call
 drm_helper_hpd_irq_event
Message-ID: <20240924184335.GJ30551@pendragon.ideasonboard.com>
References: <20240923074803.10306-1-lists@steffen.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923074803.10306-1-lists@steffen.cc>

Hi Steffen,

Thank you for the patch.

On Mon, Sep 23, 2024 at 09:48:03AM +0200, lists@steffen.cc wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> With hpd going through the bridge as of commit eb2d64bfcc17
> ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> we don't get hotplug events in userspace on zynqmp hardware.
> Also sending hotplug events with drm_helper_hpd_irq_event works.

Why does the driver need to call both drm_helper_hpd_irq_event() and
drm_bridge_hpd_notify() ? The latter should end up calling
drm_kms_helper_connector_hotplug_event(), which is the same function
that drm_helper_hpd_irq_event() calls.

> Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 1846c4971fd8..cb823540a412 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -17,6 +17,7 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_probe_helper.h>
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> @@ -1614,6 +1615,9 @@ static void zynqmp_dp_hpd_work_func(struct work_struct *work)
>  					    hpd_work.work);
>  	enum drm_connector_status status;
>  
> +	if (dp->bridge.dev)
> +		drm_helper_hpd_irq_event(dp->bridge.dev);
> +
>  	status = zynqmp_dp_bridge_detect(&dp->bridge);
>  	drm_bridge_hpd_notify(&dp->bridge, status);
>  }

-- 
Regards,

Laurent Pinchart

