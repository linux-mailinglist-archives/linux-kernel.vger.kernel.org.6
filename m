Return-Path: <linux-kernel+bounces-532449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DCA44DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9C8168EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BE318DB04;
	Tue, 25 Feb 2025 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PFGQEVdm"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3A1624C7
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516011; cv=none; b=rmpB2m7fPdiSamxIVgku9rxdJGg3BEnjtpXiFt/1K/Zivn5S1Li2AevYlLZPLRGnLS6XMpbbftDYh7RJkBZhjdjZVIe7Jhdtoo0/TUPXAsdhPydJPASaqFFOdX2IXHpZJ2xmacO/xrnCrchBSXLYR6eyGPEelTA4t+o3SKdIIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516011; c=relaxed/simple;
	bh=9BsCtCcnu7MMPlMkKmFdAjJ9bua6ZHsDjuUIbLWVUYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pze7i7uutEYC3Mqk6A8bvttYGq9mZEQD2wrZQbLdLEzwHOSm3DK1yPsU6/jpmISXWHlHUUjj/tFXKjgunU+2Fde4NMGsyJtRKKvluLgatnCcpyFeNhLj5O5BUvWTw07bzCeAnoNi2SRRafugA4OXJgohR9omYNLjYyVaNHekhw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PFGQEVdm; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740515997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nqVYrqcSMOi5LcIvezHNonnYNuu24asKYgq/puXYIws=;
	b=PFGQEVdmy9AkeI4YpB3YWtSTiW9227iOtC6iEPFR/oNn8cXJ6uSeZRfsgi183Nei74Wlsx
	rP5YgSzimLzugQdeqWGhnWL+659MBX+truaoXf3XTEPFrKlIqaTNJ/TRH8FsKdPldbEADn
	YbyxBQmIWZv6jz/gu/jTqwITSqeWhKA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gma500: Replace deprecated strncpy() with strscpy()
Date: Tue, 25 Feb 2025 21:39:32 +0100
Message-ID: <20250225203932.334123-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index cc2ed9b3fd2d..ca7f59ff1fda 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -855,8 +855,7 @@ cdv_intel_dp_i2c_init(struct gma_connector *connector,
 
 	memset(&intel_dp->adapter, '\0', sizeof (intel_dp->adapter));
 	intel_dp->adapter.owner = THIS_MODULE;
-	strncpy (intel_dp->adapter.name, name, sizeof(intel_dp->adapter.name) - 1);
-	intel_dp->adapter.name[sizeof(intel_dp->adapter.name) - 1] = '\0';
+	strscpy(intel_dp->adapter.name, name);
 	intel_dp->adapter.algo_data = &intel_dp->algo;
 	intel_dp->adapter.dev.parent = connector->base.kdev;
 
-- 
2.48.1


