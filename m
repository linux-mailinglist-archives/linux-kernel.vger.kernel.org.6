Return-Path: <linux-kernel+bounces-413327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 224779D176B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB05B229F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C071C173C;
	Mon, 18 Nov 2024 17:52:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E401ADFE4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952352; cv=none; b=CMTbocaK68bXXBF7/ybhiQWT2vdinAPhUy/h+Tv9MNuU1mbzk1cMyYW5oAI3gASMS8rm66UP1/xdtnVzTV146EhGmdh8gJOcsRexy2bTXC3sK6V6pkX+bxaD3QsVdGZhiXlPTZLSYr15NjBwvtYpdRSM6o58ATxPyZ7su2uKFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952352; c=relaxed/simple;
	bh=BeD403GIeKdkR198XepdV+9SnsBwCbkbvBi6a8m97jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sndFSdRWsGN6A31L0v5BaW28/uzIvk3omY6T5LrDBHj6EfMVa22REo7enRldF8E4fMj7Nd3P5UbtEHKC2hnjkbXop20SStuWf8Eup6LVHS2j6aMyhNnQlFOUqxP9yc5ovkpND5kcoxZOJdH5hCPEG3Iq5KUaRxQuZwmaFmyfrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 355901516
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:52:59 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 020813F5A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:52:28 -0800 (PST)
Date: Mon, 18 Nov 2024 17:52:17 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: boris.brezillon@collabora.com, nd@arm.com,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Simplify FW fast reset path
Message-ID: <Zzt-0QzO5XePyBkF@e110455-lin.cambridge.arm.com>
References: <20241118152152.2921611-1-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118152152.2921611-1-karunika.choo@arm.com>

On Mon, Nov 18, 2024 at 03:21:52PM +0000, Karunika Choo wrote:
> Stop checking the FW halt_status as MCU_STATUS should be sufficient.
> This should make the check for successful FW halt and subsequently
> setting fast_reset to true more robust.
> 
> We should also clear GLB_REQ.GLB_HALT bit only on post-reset prior
> to starting the FW.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index ecca5565ce41..6d41089b84ab 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1098,17 +1098,11 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
>  		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
>  		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> -					status == MCU_STATUS_HALT, 10, 100000) &&
> -		    glb_iface->output->halt_status == PANTHOR_FW_HALT_OK) {
> +					status == MCU_STATUS_HALT, 10, 100000)) {
>  			ptdev->fw->fast_reset = true;
>  		} else {
>  			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
>  		}
> -
> -		/* The FW detects 0 -> 1 transitions. Make sure we reset
> -		 * the HALT bit before the FW is rebooted.
> -		 */
> -		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
>  	}
>  
>  	panthor_job_irq_suspend(&ptdev->fw->irq);
> @@ -1134,6 +1128,11 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  	 * the FW sections. If it fails, go for a full reset.
>  	 */
>  	if (ptdev->fw->fast_reset) {
> +		/* The FW detects 0 -> 1 transitions. Make sure we reset
> +		 * the HALT bit before the FW is rebooted.
> +		 */
> +		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> +
>  		ret = panthor_fw_start(ptdev);
>  		if (!ret)
>  			goto out;
> -- 
> 2.25.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

