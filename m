Return-Path: <linux-kernel+bounces-574280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2680BA6E300
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A991894E67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96853268C78;
	Mon, 24 Mar 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="fk7CoS5p"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69330268C52
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842825; cv=pass; b=K32dXcRSKsMb+L2gy4pIwFssbUQmAMZHCAcanuEGstdryDhe1rjvHYIhb8947ct2BHohuydSdHtVyj4NwwdcE1E6kMerG/fGYkO4z8wBpS1Hi9avwWrbJ/o/z5bFJdsh3L+arNggXV5lhlqS9tIdBKCQYmX7tIB1/X2niK8f4XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842825; c=relaxed/simple;
	bh=lTF+acXauNDd5vEDXZeI7xJampfx/FI5Q7pOaX/h/RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz4qY+IVJaQbOZBvT8WD89ZLtwtZO8LsyzvIoxDNj8agQ4HR8Uxfj76wDF3ijt9OM4m3F0hJVLuAOFscR0P8potzfFZmUp2TQO9zzZEsTePGRRB1HOmIdGAE6c3UJ+ROui9Fv7O/xw2cf5kNC5dwOWJAfp1zlfXubt+09ofRquY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=fk7CoS5p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742842796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bJt1y4i/ehYsNO7hM5jVKOhrvEse1fiM1TFcl3MYIcmgiZplh5zRBgewFoSbWFy2EZ6+ghE8Gsuo6TLL/LXDiiee9ACqfdTUjnN0XpUxdo4lzQDptQOF2W4GuWM1Wk9O3SSgHawv50mlKGq5QlVQi7hmnbSSct6rI9LyLL+Y1mw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742842796; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uu3d0MtSSjzAtw+Qhy9CyN3/i5xOqsepAkaEuUF8bc8=; 
	b=lB5UCEoGnZdPFFQ0S5uR0ZjV6DXkCeSHLSrNu+oWewq2ldkV7y/VEzvSXZ9lV7I8UcTAIhO2OZw4oGXVYAuQsuaf7e4jwA+7wMKF3O2Pn4BkjriTvFwn0uXT8NEYgD2ZKOzl73ZqBuA4vG7EvqzM3O3S5Zgx1R1vwA5Sj67Ob4g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742842796;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uu3d0MtSSjzAtw+Qhy9CyN3/i5xOqsepAkaEuUF8bc8=;
	b=fk7CoS5pCtIWrMdXWC7Xg9VA45aN11Bf+iu/k+3J0ozV34hlPFayd/DLB+ddh7il
	jNeRIqVqUDpp/Ljhwe7Er7UNxGz1WSLyvgA2AjO/hOOK6DgS1TQrWKoDu5G99OYOc6R
	Wc7of82scqX9i8IthnMWsjCpLY6fNHDvLScnJ4vA=
Received: by mx.zohomail.com with SMTPS id 1742842794374585.952480853528;
	Mon, 24 Mar 2025 11:59:54 -0700 (PDT)
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
Subject: [PATCH v5 6/6] drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8192
Date: Mon, 24 Mar 2025 15:58:01 -0300
Message-ID: <20250324185801.168664-7-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324185801.168664-1-ariel.dalessandro@collabora.com>
References: <20250324185801.168664-1-ariel.dalessandro@collabora.com>
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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 21e2f6c8d6be..237e6054d0af 100644
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
2.49.0


