Return-Path: <linux-kernel+bounces-561900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C1A61849
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D8E8875F5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49F2046B8;
	Fri, 14 Mar 2025 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="hMgiWr2b"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78428204684
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974047; cv=pass; b=ELvhXIwOiS2ACqgsnEIQHETzaRJLxfhdJsoOD+oY42q1tpygvlz41kYMVCcRC9wajKPpFfrSovMtXw2ZRYEiuEhqwI3NhPvMALli5xbSzS11siXMH0FzKwwL2ZPawBQKZJkCVcLbTbFjDXawWUWvJj0NZjPqcCst2LIF8t22B/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974047; c=relaxed/simple;
	bh=+b4U3LJz1vB7D0UDwstEPbmwTlT00zWqYKS6INfK70o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQ0HgUOUWBgaozL3+jyAKYiOgMiA8+6tUUfdLhy+4Lp6VKlOlYIf8Gxm1tdJDAmgPBTwNJRKmO4TgzzRM3iRvtOAUq0eDTB+cLDaDlsoF5GvaeWv4Hvk48k1aUwnfRFjJp8ip4izPuSwYX26+aZh0cZwIbj7BafTZGgC104U9xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=hMgiWr2b; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741974023; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bJbiAG9LSQ+x4bOHoIC9xDu2iOeJH1hafofDoR9AY4jfRVO83OwEW6TX870dj7MigH/+WgpvcAjKC/nKkf+SXslv7RZXEhIdzR6LFZ7bffyN/I0kle/TNkxg7RYkyovZ3CTI49236zgSgEZIyIZNHngsijEENnOQFHSBK3qQQFM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741974023; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=S9mLEJ4wU0OThnD85l5/tcj+3b+DKxl3RKGucACMmN8=; 
	b=P8i+sAcjqtFV42513VQsmKyecq4jFUZpS+Q246nGlzdpSTFblTa4SDdgf7OiBXKcuyZsOeV9CNKUUkrnMgCWN/baLSEM0BSAmcNZYavjuZtds8caki355n+QE3+3VHHW7P9C54lKD3aJghVd+M/uw7ugAlS5N0L5R3IuVjQ8sHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741974023;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=S9mLEJ4wU0OThnD85l5/tcj+3b+DKxl3RKGucACMmN8=;
	b=hMgiWr2byfyTUNQqTo9ftHBizACLWwxnGYUWkNihyn8ow/y0TbC9Wc6L/TGZRgj7
	MmbJ2HI0TRGzCql4i0Hs8VP5+/koB8gPmRPJxCd8LtD+6XiJPZILkZEaKKZTo0QMegc
	D5z6nnJ29+YP264ODL+TKMcfOY6N+M62xeXOuJ/E=
Received: by mx.zohomail.com with SMTPS id 174197402139047.56598304813804;
	Fri, 14 Mar 2025 10:40:21 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com,
	robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	kernel@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	sjoerd@collabora.com,
	angelogioacchino.delregno@collabora.com,
	Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [PATCH v2 5/6] drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8188
Date: Fri, 14 Mar 2025 14:38:57 -0300
Message-ID: <20250314173858.212264-6-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

MediaTek MT8188 SoC has an ARM Mali-G57 MC3 GPU (Valhall-JM), which
constantly faults with the current panfrost support.

For instance, running `glmark2-es2-drm` benchmark test:
```
[   79.617461] panfrost 13000000.gpu: js fault, js=1, status=JOB_BUS_FAULT, head=0xaadc380, tail=0xaadc380
[   80.119811] panfrost 13000000.gpu: gpu sched timeout, js=0, config=0x7300, status=0x58, head=0xaaca180, tail=0xaaca180, sched_job=000000002fd03ccc
[   80.129083] panfrost 13000000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
[   80.129083] Reason: TODO
[   80.129083] raw fault status: 0x1C2
[   80.129083] decoded fault status: SLAVE FAULT
[   80.129083] exception type 0xC2: TRANSLATION_FAULT_2
[   80.129083] access type 0x1: EXECUTE
[   80.129083] source id 0x0
```

Note that current panfrost mode (Mali LPAE - LEGACY) only allows to
specify write-cache or implementation-defined as the caching policy,
probably not matching the right configuration. As depicted in the source
code:

drivers/iommu/io-pgtable-arm.c:
```
* MEMATTR: Mali has no actual notion of a non-cacheable type, so the
* best we can do is mimic the out-of-tree driver and hope that the
* "implementation-defined caching policy" is good enough...
```

Now that Panfrost supports AARCH64_4K page table format, let's enable it
on Mediatek MT8188 and configure the cache/shareability policies
properly.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 0f3935556ac76..e854f290858f9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -824,6 +824,7 @@ static const struct panfrost_compatible mediatek_mt8188_data = {
 	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
 	.pm_domain_names = mediatek_mt8183_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
 };
 
 static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
-- 
2.47.2


