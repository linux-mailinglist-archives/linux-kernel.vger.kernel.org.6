Return-Path: <linux-kernel+bounces-562477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1FA62940
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC21F7A2FCE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9051DC9BB;
	Sat, 15 Mar 2025 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LQO04r4q"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733A192D77
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028451; cv=none; b=SQRNzg2mufvae4wfwBMFWUvuicH4KxlphflJIwG2ZgtpIZlTkjxtRtAgzBrUk2etFeNfm5zDmiHBwTjQtRcatJUjXbD7F0DBkHInY6HUw+Mlw4ZrzxZFmwLBFqNfCcQkl28G8Xgnweo5i8pVIoJUnoIBLDbOsw+uZLkf4B7WnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028451; c=relaxed/simple;
	bh=G8uYSrifhqywqfMO1IBBhasEEunS+Y3jrko3Aki/XA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk+LDnHYj94T5EeHh1gVQT5Pf8u4ONLAt1mcjjBB0MQ7S7Fya/C/XqdI+feL5YujrS9Oq1LqwaDdscut/4LlHYx+mCgEm7rp4hzpVQtkhhUg7EckIEFYM4dhlcll2M1KJZSvHB9SPxRG9RDlIOyzGfNm8yZ+0eiuZHMhDeuaIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LQO04r4q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742028448;
	bh=G8uYSrifhqywqfMO1IBBhasEEunS+Y3jrko3Aki/XA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LQO04r4q3Sevfv8mmADPojqCSJcQxUVqr4wr2MLx8Y89UPKMJ/9MVD3Ka68IF5d2V
	 fYWoNfuPE/yl6yzB4kFEUFU5qHLrhdKhuBuFwd1RfDrwkkbACsdMEBPxSty6ki57Qv
	 hwdp7lNTn0Bit7z2HUoapOazm5azakK1LwI0jFXyxelzE5e/0z3uO+SkZnOLl8x9m2
	 FPIaialuC/Wp1qsgs/2EiYwo5CYKPsf/VkuTaDuUC8zbgYfWp+0LH7vtssH5L+PWpw
	 7pu4dbwDbgizk1/LFSBduf/h4FFXinQyo+bIydoS5dF9tqeLGWIDNMQ7ruU9xJHH7z
	 bLG9gUCBi32qA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CCFF117E05C8;
	Sat, 15 Mar 2025 09:47:27 +0100 (CET)
Date: Sat, 15 Mar 2025 09:47:22 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com,
 angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 6/6] drm/panfrost: Force AARCH64_4K page table format
 on MediaTek MT8192
Message-ID: <20250315094722.4c4804c6@collabora.com>
In-Reply-To: <20250314173858.212264-7-ariel.dalessandro@collabora.com>
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
	<20250314173858.212264-7-ariel.dalessandro@collabora.com>
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

On Fri, 14 Mar 2025 14:38:58 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> MediaTek MT8192 SoC has an ARM Mali-G57 MC5 GPU (Valhall-JM). Now that
> Panfrost supports AARCH64_4K page table format, let's enable it on this
> SoC.
> 
> Running glmark2-es2-drm [0] benchmark, reported the same performance
> score on both modes Mali LPAE (LEGACY) vs. AARCH64_4K, before and after
> this commit. Tested on a Mediatek (MT8395) Genio 1200 EVK board.
> 
> [0] https://github.com/glmark2/glmark2
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index e854f290858f9..ef30d314b2281 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -836,6 +836,7 @@ static const struct panfrost_compatible mediatek_mt8192_data = {
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
>  	.pm_domain_names = mediatek_mt8192_pm_domains,
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
>  };
>  
>  static const struct of_device_id dt_match[] = {


