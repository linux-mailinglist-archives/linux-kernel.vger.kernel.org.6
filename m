Return-Path: <linux-kernel+bounces-418015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D89D5BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CF4283ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54118B47B;
	Fri, 22 Nov 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f2cx4Iav"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C91B18BBA0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267320; cv=none; b=m9hp59XkKRegidGOebV5IDDJhU21XtuyMMfGJ4P6Pj/tRVnmDOqr+KsLhqtdNbiGib4nAckgLeEAbZ7n/YztZy17+PST76cYesvdJH1RC+bFi5e95Xya9jQv/BIZB0g2QPkoJ3CC8IO9WR8vcnVHwYcDtRkY2mb2bPrhuYi2bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267320; c=relaxed/simple;
	bh=PFPfni+0mt6Dw0aAiCQ9I/+7ZRwweg1H6/RkxYt+q2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bUDGdhPmRy1BdYV0wcE/GoKvA1EL3A55eWo8Mmb4N6/LU2sdjJTrIjl3fqin5dEX/Wupvbflom7TeUoWpShDv+H4Fcw9Rj4R1cAiAUsarcHzKdGWxyNmrSgMTYcLzmtBMFhdpiNp6d+lGFWtGR63Ven7Gl+yFTHpjPbZguSJwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f2cx4Iav; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AM80ENR014706;
	Fri, 22 Nov 2024 02:00:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1732262414;
	bh=NzwBJ9hoNy9zYFQF0RIjxpT+VZivN/OIvGYGZWYheJw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=f2cx4IavxdZ3ahzhjXIx07KhHeXhX9ET4PWQ56OAfnq8uVuu1ADYhF8umzu4HI1kZ
	 VRFxR3Vk2N/vtk+/QEWYa6Azsgrg8kPSDUAPVuAkEB3zXoCmMCXJ7Ih8smwig0+jWZ
	 j3INL2XAbltdIFGt9+wqIqTGcPwilYT1B9OB4sxE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AM80EaC049337
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Nov 2024 02:00:14 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Nov 2024 02:00:14 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Nov 2024 02:00:14 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AM80AMi052433;
	Fri, 22 Nov 2024 02:00:11 -0600
Message-ID: <1f47c3c3-812d-2e0e-16f8-db0209f1ebad@ti.com>
Date: Fri, 22 Nov 2024 13:30:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/7] drm/tidss: Remove unused OCP error flag
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
 <20241021-tidss-irq-fix-v1-2-82ddaec94e4a@ideasonboard.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-2-82ddaec94e4a@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 21/10/24 19:37, Tomi Valkeinen wrote:
> We never use the DSS_IRQ_DEVICE_OCP_ERR flag, and the HW doesn't even
> have such a bit... So remove it.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh
> ---
>  drivers/gpu/drm/tidss/tidss_irq.c | 5 +----
>  drivers/gpu/drm/tidss/tidss_irq.h | 4 +---
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
> index 604334ef526a..91498ff664a2 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -78,9 +78,6 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
>  			tidss_crtc_error_irq(crtc, irqstatus);
>  	}
>  
> -	if (irqstatus & DSS_IRQ_DEVICE_OCP_ERR)
> -		dev_err_ratelimited(tidss->dev, "OCP error\n");
> -
>  	return IRQ_HANDLED;
>  }
>  
> @@ -105,7 +102,7 @@ int tidss_irq_install(struct drm_device *ddev, unsigned int irq)
>  	if (ret)
>  		return ret;
>  
> -	tidss->irq_mask = DSS_IRQ_DEVICE_OCP_ERR;
> +	tidss->irq_mask = 0;
>  
>  	for (unsigned int i = 0; i < tidss->num_crtcs; ++i) {
>  		struct tidss_crtc *tcrtc = to_tidss_crtc(tidss->crtcs[i]);
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.h b/drivers/gpu/drm/tidss/tidss_irq.h
> index b512614d5863..dd61f645f662 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.h
> +++ b/drivers/gpu/drm/tidss/tidss_irq.h
> @@ -19,15 +19,13 @@
>   * bit use   |D  |fou|FEOL|FEOL|FEOL|FEOL|  UUUU  |          |
>   * bit number|0  |1-3|4-7 |8-11|  12-19  | 20-23  |  24-31   |
>   *
> - * device bits:	D = OCP error
> + * device bits:	D = Unused
>   * WB bits:	f = frame done wb, o = wb buffer overflow,
>   *		u = wb buffer uncomplete
>   * vp bits:	F = frame done, E = vsync even, O = vsync odd, L = sync lost
>   * plane bits:	U = fifo underflow
>   */
>  
> -#define DSS_IRQ_DEVICE_OCP_ERR			BIT(0)
> -
>  #define DSS_IRQ_DEVICE_FRAMEDONEWB		BIT(1)
>  #define DSS_IRQ_DEVICE_WBBUFFEROVERFLOW		BIT(2)
>  #define DSS_IRQ_DEVICE_WBUNCOMPLETEERROR	BIT(3)
> 

