Return-Path: <linux-kernel+bounces-555629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6409CA5BA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9553A91D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2552236E9;
	Tue, 11 Mar 2025 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AIC5nti+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1661EDA15
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680451; cv=none; b=pmgTd79ti1uOrQoF8UHANRe5LgH9O7RvCY6YCSv7rqL5psIdm76Owzj8zbQoouLezLbB51/Mu45w631ZZzjZVji246r6lSOPZB1/CnKJPSyt9SH7ACHxYwPcjJQYhSAQHLv/ZwcvPVK+MC1yYSi04ZihFmX+PaSlSYzb5zI+zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680451; c=relaxed/simple;
	bh=Wln6HbJ1YhxwRZiQK3YIiagu79K/yCUP4PftsyrzyJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrAM/28JcYCf2oSjxztXt2xwbPq92HX6w/xoC7+xPJkn8BxkLDSsQVCzqeA1IvXVgwg7jmQbxvfb4mZSdUFzXmsiJmh2hZn/TQ+CoSF5Kr1svTGY0OODNn79qi4Ok0DY0mJK+nkvXRVwtWTHK+hQCrwzFxCyLPggwp/kqQUoBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AIC5nti+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741680448;
	bh=Wln6HbJ1YhxwRZiQK3YIiagu79K/yCUP4PftsyrzyJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AIC5nti+7eUbHYa6koRGpGRDZWZUbDap8+kiOPa6xudRu7/6HjjqlTTTq6qe2/eUP
	 Lm4HrDY94i1XeUGM9dBC7TanQ2zW+Ew7KiM7mA8Ctfvllyh/j//QUiaA5cyubszlpZ
	 rHDwH9F0Wyj/ZftoFQL26wvIBB4Sk/UFeymsxRC1g2gSxQqBxV3ptne2FoWM4mLYP7
	 NNjC+9XFBIeDBcAmhb62N601XSk9+J/cDysAdY9y47RnM8oh/ZxJDcpITuPm5ULtQO
	 MocuUeeR4PIDK+pPBZY+m3Epg6xukvWc30vrwWYQIjNEFgmaJYhZQZNkgdMyrtJi4q
	 QY0VkpuOtjtlg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6CBD17E0237;
	Tue, 11 Mar 2025 09:07:27 +0100 (CET)
Date: Tue, 11 Mar 2025 09:06:49 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com
Subject: Re: [PATCH v1 5/6] drm/panfrost: Enable AARCH64_4K page table
 format on mediatek_mt8188
Message-ID: <20250311090649.0d15d74d@collabora.com>
In-Reply-To: <20250310195921.157511-6-ariel.dalessandro@collabora.com>
References: <20250310195921.157511-1-ariel.dalessandro@collabora.com>
	<20250310195921.157511-6-ariel.dalessandro@collabora.com>
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

On Mon, 10 Mar 2025 16:59:20 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> Now that Panfrost supports AARCH64_4K page table format, let's enable it
> on Mediatek MT8188.

Can you maybe give more details on why this is needed
(legacy shareability/cacheability not suitable for this GPU?)?

> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 0f3935556ac76..d7b8bded6d784 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -824,6 +824,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>  	.pm_domain_names = mediatek_mt8183_pm_domains,
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +	.gpu_configs = BIT(GPU_CONFIG_AARCH64_4K),
>  };
>  
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };


