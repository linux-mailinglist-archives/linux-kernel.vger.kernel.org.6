Return-Path: <linux-kernel+bounces-180929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 689918C74FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134D71F24701
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AEF1459E6;
	Thu, 16 May 2024 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V3QLOFjn"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45032145349
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857673; cv=none; b=koGyUkmoq7lTMzXrFcSeyh70RVCXgwOZ+ohlddQLLjK75PJQh1CP71GLn3tXKoiKdeykxM4zrNuUlNcF8WEzk/vsIG+/7Y4UtBBQAkz4/uGv/QOH+Bt5K2MuhVczYU218Cn7Qs7tDgv9gs6niiCJ8HeRAJAOMyIBHPdcekuBG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857673; c=relaxed/simple;
	bh=gB+RPtrAuYH3wBSkxeLUb6QdyugdGBCAugKEKXqfFI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKTTTPzkp0BMjnt/lYCJgZ8ODNHZbTPxv7WiFD95ZnlftiWXTDRYTO9xlyyQXClqHwnpwMZea70anSfIXTBW9diSO6xvOkDpQKrashcTexCv/sSeHruIAyCPr6ifVccz1c+XTC7GA+nWtncmrEl6V5J1KDsHelab7fSRjhr2y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V3QLOFjn; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: victor.liu@nxp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715857670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFIHxeP9M+LmvRKzSaSABRLWtsMlPkWTGAKIdrDLly8=;
	b=V3QLOFjnOS2kYE0zTuy6tvxGcsj+0CGXSiyOwMide0cs2H/kJ3N+C3vkmgNKLYb7vSVlHb
	+3PRTkyVw38DzQoLmy4x4uo1w1lBkyRRu5eu4/tPRFcQ1VqMjuYhq6sM8GS89k2jNwZtkW
	IvSks78CXOkxPEbRNmexG96GxdpIX90=
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: andrzej.hajda@intel.com
X-Envelope-To: neil.armstrong@linaro.org
X-Envelope-To: rfoss@kernel.org
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: jonas@kwiboo.se
X-Envelope-To: jernej.skrabec@gmail.com
X-Envelope-To: maarten.lankhorst@linux.intel.com
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: airlied@gmail.com
X-Envelope-To: daniel@ffwll.ch
X-Envelope-To: biju.das.jz@bp.renesas.com
X-Envelope-To: dmitry.baryshkov@linaro.org
X-Envelope-To: u.kleine-koenig@pengutronix.de
X-Envelope-To: aford173@gmail.com
X-Envelope-To: jani.nikula@intel.com
X-Envelope-To: bli@bang-olufsen.dk
Message-ID: <0ae84b3c-9935-4cb5-9ed5-3fc87a416857@linux.dev>
Date: Thu, 16 May 2024 19:07:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when
 necessary
To: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 biju.das.jz@bp.renesas.com, dmitry.baryshkov@linaro.org,
 u.kleine-koenig@pengutronix.de, aford173@gmail.com, jani.nikula@intel.com,
 bli@bang-olufsen.dk
References: <20240516101006.2388767-1-victor.liu@nxp.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240516101006.2388767-1-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 5/16/24 18:10, Liu Ying wrote:
> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> no interrupt requested at all.
> 
> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> a few times, but adv7511_irq_process() happens to refuse to handle
> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
> 
> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> handling from adv7511_irq_process().
> 
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index 6089b0bb9321..2074fa3c1b7b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>   		return ret;
>   
>   	/* If there is no IRQ to handle, exit indicating no IRQ data */
> -	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> +	if (adv7511->i2c_main->irq &&

Maybe you could use 'if (process_hpd)' here.

> +	    !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>   	    !(irq1 & ADV7511_INT1_DDC_ERROR))
>   		return -ENODATA;
>   

-- 
Best regards
Sui

