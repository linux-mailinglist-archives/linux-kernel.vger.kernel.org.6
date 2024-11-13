Return-Path: <linux-kernel+bounces-407475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E0B9C6DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A48CB24453
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0044200109;
	Wed, 13 Nov 2024 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U96RG3A+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A021FF7C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497211; cv=none; b=qjjrTEl4DqTvPjGg0RWevusDFCabETTRH0iFpZcNu0/RYrwopCGXheI9xfZMgWygnex2aJx+5zfrY34YYG6WmZe1GKSvT5hu+Tun3aNpiZjFHr53LVqsfBAsFgJynEqvFbf0+B3hZgcixRYlEW7wrFdC4DItgG48fALg2cNAHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497211; c=relaxed/simple;
	bh=9Eug4ny21FB+VTsG3HD8fvfihKPa9daeEy58mMwRL3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGFQxVN0e9QdCgslI5o7p7OlgQVuKb0hC82XiX8dQsDuV+aj55Ix6u7PZuuThxaIdz3LcfYymJUjPHs5iH9+2MLxContrq6vPAQ3pDtDNL9rfF1yadlujb0dRF7bJ4aTfugEix0PVpuPlfmaVMZpor2qfivh8hgs6A3m+qRQEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U96RG3A+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731497202;
	bh=9Eug4ny21FB+VTsG3HD8fvfihKPa9daeEy58mMwRL3w=;
	h=From:To:Cc:Subject:Date:From;
	b=U96RG3A+oyT3B1VxBjv5+QdzHqWTw1NK3NWneMnaZN2BzzN+oNkvmcvkgqDvLC4vH
	 xsD+hNeJLaL5ksbgYzr3F2qAfcExIDvD4lW2EIoSPqLZxDCnsNt20YYxpBaAInSUYR
	 g5fwlPD5v8t9SerEM2GA0I4xlvnQNKus1pZwE9vG5nH9qu9oZfdsqUu8siA066N9ya
	 jIYdr9F29j3DhrbUCHooiGfYR1otynOEFhPi5i7WYEx8jH8S9AaJrJCMk9HXdbbKv+
	 I/dp5UulhM5oLFs7JP8J/GpUZVf4yfq0iCIXsN752xOVNMqwmgTLk1z2lEsy3GZ2G5
	 ZAStRnsI4ZNyA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 93CAE17E3609;
	Wed, 13 Nov 2024 12:26:41 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: boris.brezillon@collabora.com
Cc: robh@kernel.org,
	steven.price@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] drm/panfrost: Add GPU ID for MT8188 Mali-G57 MC3
Date: Wed, 13 Nov 2024 12:26:22 +0100
Message-ID: <20241113112622.123044-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT8188 SoC has a Mali-G57 MC3 GPU and, similarly to
MT8192, it has yet another special GPU ID.

Add the GPU ID to the list and treat it as a standard Mali-G57.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index f5abde3866fb..174e190ba40f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -236,6 +236,10 @@ static const struct panfrost_model gpu_models[] = {
 	 */
 	GPU_MODEL(g57, 0x9003,
 		GPU_REV(g57, 0, 0)),
+
+	/* MediaTek MT8188 Mali-G57 MC3 */
+	GPU_MODEL(g57, 0x9093,
+		GPU_REV(g57, 0, 0)),
 };
 
 static void panfrost_gpu_init_features(struct panfrost_device *pfdev)
-- 
2.47.0


