Return-Path: <linux-kernel+bounces-562476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D66A6293E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75966189F9ED
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4D193074;
	Sat, 15 Mar 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mXq+HKz7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B82AD25
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028426; cv=none; b=NZp+8rAYgrP5k/LhFnwOVrEPu/8PJH4/b+TuBMhueL3IKZTgQyypWsMpafPwoLeBBsor89yxwWSFYxZG64Cckr4Vn58j+VNumxz/OWAD4e1UJ8AuxapOud8hYB8+wfJcwcFThALIbdCV139S1Me+YUD7DN6nt5gOFmP/nCG3NEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028426; c=relaxed/simple;
	bh=v/k0cq1PYeZ9P+GP2imf/tD1dXH1+3qfgJfx3mmiyXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueKvBmuhR/NuBHaXoGk2AZhCnIhR4Ox4VAmdTuVHdgcpkIyVnhagB9Z82ew/QLCw6cR1lUcM1fZ+01i2ych3L6I46zPuxwocDIK+lHEchtwUaX9wym8Xk1xS9FLkrSxrBpCFqEYiZ4Cu6edIs0gzYlSJlwwdiXsZBQdKv9mXmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mXq+HKz7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742028423;
	bh=v/k0cq1PYeZ9P+GP2imf/tD1dXH1+3qfgJfx3mmiyXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mXq+HKz7p3rsapeUpBufJgc0rDhMfIgQy3PhjK3fDoVWzef4tBgKj9mVTdpCIZzSX
	 YCqOr9CZ4lqTAlyZPMPFkh539dz8Cklfa/YHWCuT9jRut8YrkU9VGleYdqjb6m2Azk
	 CuW/PRR45wqMC8UlKP5IAv0Qkc99ARprdawb92uuDrlJIUuhYTImw8nO2jdgBo5o/d
	 kiLZaA4i+8eEwwNAh6WMfVtParc3LOH7OcFWX5+UGtI8zyZf8ZcQr9EXcC9Jy9aqd3
	 /FW0GO67fZRbYFLsRAgk4Pury50v9FzxgPY1mEfGqQbQ1pa53OQi9o8K3fO05hnWmo
	 mR05DmGZrakiA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6055317E0848;
	Sat, 15 Mar 2025 09:47:02 +0100 (CET)
Date: Sat, 15 Mar 2025 09:46:57 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, kernel@collabora.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, sjoerd@collabora.com,
 angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v2 5/6] drm/panfrost: Force AARCH64_4K page table format
 on MediaTek MT8188
Message-ID: <20250315094657.7939e532@collabora.com>
In-Reply-To: <20250314173858.212264-6-ariel.dalessandro@collabora.com>
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
	<20250314173858.212264-6-ariel.dalessandro@collabora.com>
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

On Fri, 14 Mar 2025 14:38:57 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> MediaTek MT8188 SoC has an ARM Mali-G57 MC3 GPU (Valhall-JM), which
> constantly faults with the current panfrost support.
> 
> For instance, running `glmark2-es2-drm` benchmark test:
> ```
> [   79.617461] panfrost 13000000.gpu: js fault, js=1, status=JOB_BUS_FAULT, head=0xaadc380, tail=0xaadc380
> [   80.119811] panfrost 13000000.gpu: gpu sched timeout, js=0, config=0x7300, status=0x58, head=0xaaca180, tail=0xaaca180, sched_job=000000002fd03ccc
> [   80.129083] panfrost 13000000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
> [   80.129083] Reason: TODO
> [   80.129083] raw fault status: 0x1C2
> [   80.129083] decoded fault status: SLAVE FAULT
> [   80.129083] exception type 0xC2: TRANSLATION_FAULT_2
> [   80.129083] access type 0x1: EXECUTE
> [   80.129083] source id 0x0
> ```
> 
> Note that current panfrost mode (Mali LPAE - LEGACY) only allows to
> specify write-cache or implementation-defined as the caching policy,
> probably not matching the right configuration. As depicted in the source
> code:
> 
> drivers/iommu/io-pgtable-arm.c:
> ```
> * MEMATTR: Mali has no actual notion of a non-cacheable type, so the
> * best we can do is mimic the out-of-tree driver and hope that the
> * "implementation-defined caching policy" is good enough...
> ```
> 
> Now that Panfrost supports AARCH64_4K page table format, let's enable it
> on Mediatek MT8188 and configure the cache/shareability policies
> properly.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 0f3935556ac76..e854f290858f9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -824,6 +824,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
>  	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
>  	.pm_domain_names = mediatek_mt8183_pm_domains,
>  	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
> +	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
>  };
>  
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };


