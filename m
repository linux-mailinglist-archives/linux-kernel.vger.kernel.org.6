Return-Path: <linux-kernel+bounces-414043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D59D224E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3B8282CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98E19AA5F;
	Tue, 19 Nov 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T1N0iS/W"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017D155A21
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007786; cv=none; b=CX5Z4m3eghzHOr279nRGdg8jCGqLuK02nu/1Y77eQo1jpFpvcgZsZJBqFcPgjKSuyB3XF8cCS+dgLyX5ocfMcBZ8bDBCLLMbq8++45o32yznmbkPioF+ml3t7TRZ8GvVMnm9a6dS/K6dl+7fAOPXAUTLxcs7TU06+YIksmn3TW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007786; c=relaxed/simple;
	bh=X6GAMSsXTjJQqYbDR5soYjiKpd/477BQAQcfGhNwh1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVyE734YHW5WXejWGrCbPTyaf5s8VYI0AkAYmWZWQxzx8r9NdwCI2GUhw6/f/U5arjiK3TDGtzM3CTxwUM1VvZjIvXppzom1gywLopv6uo6sJDakytH0DmjfQK+WIqYyvwj1RzxiGZApl1Qa4g/vwo54dgdcTG5KXaQXCupXAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T1N0iS/W; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732007777;
	bh=X6GAMSsXTjJQqYbDR5soYjiKpd/477BQAQcfGhNwh1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T1N0iS/WRqLcuoMcbLrzNBzCmelEM17akjwszbWfTgHde9wXpQfSNCv9R55etZLTE
	 APnaj5zQSMtp/H/VQXrrUxy7sylP9jghnR16gypGWDsAXZ6rPPg7R9X9aWLOscAZTS
	 LWPsAlAmkNs7KYkELD17kDlS0Ggtq3cYYhO5XCWL3VRWFvlUuKS+S7ONOqgDFW2/+w
	 mypqQVy7B4rWpSZmhZlA8MST6iLTMFmJ6uXoK+29/6YJ2QGRfESnbKosBkFDsyyeA/
	 bgVzYHSZ3El49H/qB7VaLrKCY78i+Oe1i8WZxY/xxPc8u5BcHuhwg1lyDYEK/3V0Ny
	 sc+JZCypeXFGQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E5D3517E35D1;
	Tue, 19 Nov 2024 10:16:16 +0100 (CET)
Date: Tue, 19 Nov 2024 10:16:12 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: nd@arm.com, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Simplify FW fast reset path
Message-ID: <20241119101612.351c6302@collabora.com>
In-Reply-To: <20241118152152.2921611-1-karunika.choo@arm.com>
References: <20241118152152.2921611-1-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 15:21:52 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Stop checking the FW halt_status as MCU_STATUS should be sufficient.
> This should make the check for successful FW halt and subsequently
> setting fast_reset to true more robust.
> 
> We should also clear GLB_REQ.GLB_HALT bit only on post-reset prior
> to starting the FW.

And maybe add 'only if we're doing a fast reset, because the slow reset
will re-initialize all FW sections, including the global interface.'

> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
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

Can you add
                 * This is not needed on a slow reset, because FW
                 * sections are re-initialized.

?

> +		 */
> +		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> +
>  		ret = panthor_fw_start(ptdev);
>  		if (!ret)
>  			goto out;

This these 2 minor nits addressed, the patch is

`Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>`

