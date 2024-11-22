Return-Path: <linux-kernel+bounces-417917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B09D5AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804C91F21FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBF18A94C;
	Fri, 22 Nov 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Is3WRlFj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26E17DFEF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732262895; cv=none; b=hKLyLdBtrbu+auWvW9AjChm21f9F8AoVdorJBqtad8GQjM9hogFNBU80d2n612pd58ZwMTAB01sNjuuqSqh0QoyjlUrYawdKOePvnKIedX18qhtLkRLSB1nsS4jhtNZ/DVqb5KR996LspRuYC8NJKgoonk5XW7fC/6w3x1hkUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732262895; c=relaxed/simple;
	bh=PtPk3EirH9fdVGRnXfTdeXZ6a2flM/hQkE0DX+WASxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ukj2I+Vec6xmCXoH/m9Pl52QzyuWHyMQlKBsmWwrSzw6ULi8NOT1B47uyAW9z2V7pfAG/Vr7BSRBUeIzNigCfTcLlFMqo+XhtPXUCuv4YSbAb3Zp+6OHjSwX2hLBe3OqrXM+0b3PFEG1xom1cIxT/2VN152f6jIGgyq5yqiAMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Is3WRlFj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AM87oPC063175;
	Fri, 22 Nov 2024 02:07:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732262870;
	bh=w3IYk5HUCJnCl2QQEaFrleUP/IkGwFmpCkaOMycfS7o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Is3WRlFjAMmjnHYE0pGmkl9RteuNnrvZETtO6/ObDfmaOVsthS8RPzCtjCEq7AKcx
	 +f4MSjUJ5Ec2z7hM4XwoGZVfYkC3Rry+vF4ODwxisU1NxFziofa8qAAMwXNQlMSeq7
	 NldnU6qCm5ltTHfSHg3hVOFuKPnJ9gdM7pRClOrE=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AM87oBn054825
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Nov 2024 02:07:50 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Nov 2024 02:07:49 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Nov 2024 02:07:50 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AM87kof065582;
	Fri, 22 Nov 2024 02:07:46 -0600
Message-ID: <f51c5f0a-7fcf-971b-f190-fa52a939158d@ti.com>
Date: Fri, 22 Nov 2024 13:37:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] drm/tidss: Add printing of underflows
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha
	<jyri.sarha@iki.fi>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jonathan
 Cormier <jcormier@criticallink.com>
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com>
 <20241021-tidss-irq-fix-v1-4-82ddaec94e4a@ideasonboard.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-4-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 21/10/24 19:37, Tomi Valkeinen wrote:
> Add printing of underflows the same way as we handle sync losts.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
>  drivers/gpu/drm/tidss/tidss_irq.c   | 14 ++++++++++++++
>  drivers/gpu/drm/tidss/tidss_plane.c |  8 ++++++++
>  drivers/gpu/drm/tidss/tidss_plane.h |  2 ++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
> index 91498ff664a2..3cc4024ec7ff 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -78,6 +78,14 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
>  			tidss_crtc_error_irq(crtc, irqstatus);
>  	}
>  
> +	for (unsigned int i = 0; i < tidss->num_planes; ++i) {
> +		struct drm_plane *plane = tidss->planes[i];
> +		struct tidss_plane *tplane = to_tidss_plane(plane);
> +
> +		if (irqstatus & DSS_IRQ_PLANE_FIFO_UNDERFLOW(tplane->hw_plane_id))
> +			tidss_plane_error_irq(plane, irqstatus);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -112,6 +120,12 @@ int tidss_irq_install(struct drm_device *ddev, unsigned int irq)
>  		tidss->irq_mask |= DSS_IRQ_VP_FRAME_DONE(tcrtc->hw_videoport);
>  	}
>  
> +	for (unsigned int i = 0; i < tidss->num_planes; ++i) {
> +		struct tidss_plane *tplane = to_tidss_plane(tidss->planes[i]);
> +
> +		tidss->irq_mask |= DSS_IRQ_PLANE_FIFO_UNDERFLOW(tplane->hw_plane_id);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index a5d86822c9e3..116de124bddb 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -18,6 +18,14 @@
>  #include "tidss_drv.h"
>  #include "tidss_plane.h"
>  
> +void tidss_plane_error_irq(struct drm_plane *plane, u64 irqstatus)
> +{
> +	struct tidss_plane *tplane = to_tidss_plane(plane);
> +
> +	dev_err_ratelimited(plane->dev->dev, "Plane%u underflow (irq %llx)\n",
> +			    tplane->hw_plane_id, irqstatus);
> +}
> +
>  /* drm_plane_helper_funcs */
>  
>  static int tidss_plane_atomic_check(struct drm_plane *plane,
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.h b/drivers/gpu/drm/tidss/tidss_plane.h
> index e933e158b617..aecaf2728406 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.h
> +++ b/drivers/gpu/drm/tidss/tidss_plane.h
> @@ -22,4 +22,6 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
>  				       u32 crtc_mask, const u32 *formats,
>  				       u32 num_formats);
>  
> +void tidss_plane_error_irq(struct drm_plane *plane, u64 irqstatus);
> +
>  #endif
> 

