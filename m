Return-Path: <linux-kernel+bounces-414444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B959D2811
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9749B1F24265
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882061CCEF5;
	Tue, 19 Nov 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BI1rR6UE"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06514658D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026333; cv=none; b=k11zeNNHLVnY9+UtupKVDcPA0Znc2jUVcQV446U7FZ9VZCHtln9tbORyNVIhca1SA/I+a+9KkgSg4VYveCediBFnykEx9R68hbVX6XRIkIm6yMkFtSGKraq3uF7d90GXJq0Z6Qc52BisRJnTnoXL5TsW2bQI9WlLX+a0xXUgZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026333; c=relaxed/simple;
	bh=faK1wOPEMLtbvFH81uS6UZRz8bVRI065aqq+c3yNj20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oi+9//mjqfjgbQKmWh1RMdpOU7nGXyz9zBtKROQAgY9QzQ/LyLBZ/94CABak6NinURsFpILlNZUTcTD3zsrPq7JX6SI+tYMEofvWZ9Hh0ESbFwp4cw7B2HaLSkpxTGqU1IX7mQBDt36ucTDNq9ewjtPOpW0sbGHnDbl1BpJM6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BI1rR6UE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732026330;
	bh=faK1wOPEMLtbvFH81uS6UZRz8bVRI065aqq+c3yNj20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BI1rR6UE8VDSPWVwM/oVINfzLu0uAo3iAHbmC+Tb+6qF74JI470cHeuM1EvB6es6g
	 NnkJptto2Db6LwHeenpTHKeRCtRQJXOjIxAKCd0fEqRZYWHzl3tKfHBE9w7Z8B4TS4
	 eXRlQApxY3MDB6SyVwvd7clfkzkAZjOVswoBDzLzCoRk0ZwwvilPHy++6sv9+W2EDr
	 +T0uakXyHXERzHEZECJzMCwYbKuGOwolaJpaEB0Nx2CE5eC7L+JC18hOUjUlvJ66++
	 xZhRfSEnDuWubV26Cv8Zb0blPT5Yfd+WA4NLa79c4Fhi6fkxuJ52/VJeEaD24lTSIA
	 lC6czZ2XkOCrg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3F7417E36C5;
	Tue, 19 Nov 2024 15:25:29 +0100 (CET)
Date: Tue, 19 Nov 2024 15:25:25 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: nd@arm.com, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: Simplify FW fast reset path
Message-ID: <20241119152525.6579b438@collabora.com>
In-Reply-To: <20241119135030.3352939-1-karunika.choo@arm.com>
References: <20241119135030.3352939-1-karunika.choo@arm.com>
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

On Tue, 19 Nov 2024 13:50:29 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> Stop checking the FW halt_status as MCU_STATUS should be sufficient.
> This should make the check for successful FW halt and subsequently
> setting fast_reset to true more robust.
> 
> We should also clear GLB_REQ.GLB_HALT bit only on post-reset prior
> to starting the FW and only if we're doing a fast reset, because
> the slow reset will re-initialize all FW sections, including the
> global interface.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

and I think you forgot to add Liviu's R-b

> ---
> v2:
> - clarify comments and commit message with regards to when to clear the
>   GLB_HALT flag.
> 
>  drivers/gpu/drm/panthor/panthor_fw.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index ecca5565ce41..4bc52b1b1a28 100644
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
> @@ -1134,6 +1128,13 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  	 * the FW sections. If it fails, go for a full reset.
>  	 */
>  	if (ptdev->fw->fast_reset) {
> +		/* The FW detects 0 -> 1 transitions. Make sure we reset
> +		 * the HALT bit before the FW is rebooted.
> +		 * This is not needed on a slow reset because FW sections are
> +		 * re-initialized.
> +		 */
> +		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> +
>  		ret = panthor_fw_start(ptdev);
>  		if (!ret)
>  			goto out;


