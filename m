Return-Path: <linux-kernel+bounces-564178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C581A64F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F2E176357
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8723DE85;
	Mon, 17 Mar 2025 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="OkfHSrIs"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000A23BD0B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215413; cv=pass; b=MG8Fb1RBMp8tIoe9GfB5tCHUGOzjo984Fpgw2qHwVD1NtE4fV1UucAEs1ZHOsQxumecqfOe9abyLCV9NyRURRkMGCYWU2XLP8wm8hnEMUFWa7SG9PKpZgAiMpP+WH/i7Kf9kjMEqlW9fiQXNhUBYrzqX/djULbSBUlrSpwu7Zog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215413; c=relaxed/simple;
	bh=4g2ZQBFOSqDtFo7TcFJmBzRGTqG+IeUHgHmpfqX2nx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp1r6PTbkHc9MTOQPfayPLU8w6CuG8Lq8sUMIpV2A9u1gKn9Ead56km+wdhe3iaVb0UlWJUymkvk1wtuyZep8SSyrRkFqhLzxbbOmiMdbrqJiKXyVC9U6FSohij1qWrBLlIo0FQhXRQrasNhQ/izzDp9Zspyyzw8W/HwlQDgV3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=OkfHSrIs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742215393; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W/8A6fXZMKuCo7yUW8I8FHOZojX8UAAcSDBG9imgFl5PeZ2NYsdDcluh5eHBAOULjnU8hgh0xJFyqlwtadsFDiS8PRiU9nykISmIdY/RMzjnUxbGOBRNCAm/x1D8l49E53aPOQCWWj97nOHyJnlhCg+HaOdF+K0WJ+WQ3/RVXeA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742215393; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=shM7+TC0TXgX3AuBtBbLz5FbCbczMV6yD/4P/qN2rI4=; 
	b=MwCdaGOOs9ebmu4IcYdfX22qmjpwTQa7COKws79IFpzW8VfEfzNwptQ+hP1SSGfJv4RXdx1n9ygWajUnyFnYlOrIyBl6wC2xEYaFSyut0+a80dTZWGtGIKdE3DV9Lp5EcK//yLPFCrqZwuUXHO4QkaE5WKvpTZsvTfKW/C6YVCo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742215393;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=shM7+TC0TXgX3AuBtBbLz5FbCbczMV6yD/4P/qN2rI4=;
	b=OkfHSrIsBxJzTXcPR4jVqm/6LfIZAQTv4yvcZNw/J3zSglqeeyBC2rlheQqlHOaH
	+26HPd/l9kWLb6PiB02Q62F3yd3D6LBrtde59SV53yYo6+1SXtNudesPF/Q6Dt/9GO5
	5tOkRkxeKAwL96yOkDNE6iZyhaEjVQNdUN1euCuU=
Received: by mx.zohomail.com with SMTPS id 1742215391542357.2105699159947;
	Mon, 17 Mar 2025 05:43:11 -0700 (PDT)
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
Subject: [PATCH v3 6/6] drm/panfrost: Force AARCH64_4K page table format on MediaTek MT8192
Date: Mon, 17 Mar 2025 09:40:44 -0300
Message-ID: <20250317124044.16257-7-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
References: <20250317124044.16257-1-ariel.dalessandro@collabora.com>
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


