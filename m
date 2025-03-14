Return-Path: <linux-kernel+bounces-561901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA3A6184E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA45887DD8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF5E204849;
	Fri, 14 Mar 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="AMkNsEAW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DA204C14
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741974053; cv=pass; b=sxQA3bInRZn6xepwMVXIPdiVnBv6hGu54/Pa/7gI04/y0prN6SGmcv+I3oaeWfQaj272GpLZhtRxWfrlZZzKNjX8XDVL79daWrREVsB2un8RETJxCCxKwYnvy0LArysML9KSCIRtGGrpwImuH2pkTnCzgCl6KFiQWe2kaTKsSMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741974053; c=relaxed/simple;
	bh=1BwIRZC40VMZEZSyJIll031+muDxKnQdexYIW1265us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpvZvC17RoelcgnmP694vctaIcU/LKvlMg38MK8cGWUmY5h+PVJA+fV92T9vlczb2skdukpgk1xtBu920K+KURJhidrz3YZsjsCkBPRETMSMKJOrB7ygUJmNTYJH3QJyjsheKTI6qruwXOzuCWlqDh9dIrMuzN5pOQ1Hqrw6hC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=AMkNsEAW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741974029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RNfoLYrPcM5k+wBec+Ms/i559bYXoXcUmmz1PNU5mjFxjHmbsphVyTukDQBetPUpXWTT0v5mAc1q63mq3RFdn92Yd4JRiOkJKmVQWhzSy6pd4zSmew00j14JVbxBzawC6fQtNIm0cQ7Erg2fL0QT6nqh+gU+SejTVgxLPqK09Dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741974029; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8buXX1p3SURBMsTZcHdbZSaeDVkNSZ0ppj4rFscaaHQ=; 
	b=DOCwy5MrXkFSoLugFoUydcHQU/JPbVHOe9XWTSkRq8PkBpogPYe8CREedZJz5HYRmNWQ12q4New14Si8IZLRWpV5ASsPPdFcnrY8vkVA7AuE4yy8W0QqE6nwYZtdRKjGjZIGTik3H2/zBW+PlQYpR/AOGFy+idQyYGPs6iChwBY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741974029;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8buXX1p3SURBMsTZcHdbZSaeDVkNSZ0ppj4rFscaaHQ=;
	b=AMkNsEAWcF7JhcLYqecczRzn9fdLEf+3Eo0YksMngnTWgXanMox8HPLGbV7w0No4
	zzqcH5J2U/s5DYzDQqBEdtbYgkdIIkk1LSdOKeaTh5DHUpt1F7TyZBJHbZPF2RLikjQ
	TvAfwEpwQpeuxVzOtUlMCjBieFNpUCHnHLMYTnas=
Received: by mx.zohomail.com with SMTPS id 1741974027158733.9448801872073;
	Fri, 14 Mar 2025 10:40:27 -0700 (PDT)
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
Subject: [PATCH v2 6/6] drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8192
Date: Fri, 14 Mar 2025 14:38:58 -0300
Message-ID: <20250314173858.212264-7-ariel.dalessandro@collabora.com>
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

MediaTek MT8192 SoC has an ARM Mali-G57 MC5 GPU (Valhall-JM). Now that
Panfrost supports AARCH64_4K page table format, let's enable it on this
SoC.

Running glmark2-es2-drm [0] benchmark, reported the same performance
score on both modes Mali LPAE (LEGACY) vs. AARCH64_4K, before and after
this commit. Tested on a Mediatek (MT8395) Genio 1200 EVK board.

[0] https://github.com/glmark2/glmark2

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index e854f290858f9..ef30d314b2281 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -836,6 +836,7 @@ static const struct panfrost_compatible mediatek_mt8192_data = {
 	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
 	.pm_domain_names = mediatek_mt8192_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
 };
 
 static const struct of_device_id dt_match[] = {
-- 
2.47.2


