Return-Path: <linux-kernel+bounces-447258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E879F2FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9437C16B6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51E2066F3;
	Mon, 16 Dec 2024 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="N5W6GuU5"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BF203D77
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348895; cv=none; b=TF/dmO08ARd2Gj4pdrKNL38UXga1r91qu/kLIWD0wpBAgjcq2emOHmrJ4M0ouyz67OSMbRV8F0SCDJpJUCApjZmtZcM2Ygv4HajMUMsvDwnNrBKjy259A0epdfIWpNoKsW24/BLdbVMIKjsR55the6A36n7h5TgtDOY3um/TpyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348895; c=relaxed/simple;
	bh=1qtbMa2oIpffo9qrfeElmnz139mrppvwu3zsjT10qrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPkS4Uk6AidJZSqJx2xcOy7L5NGsWgEJ04ObrJY+cUT9WsCv8AKOt0iC+262DDMUNM6829DtsbKG9ZwOFgRHZnFQEDM9bRKa8cpiL1qTrl/T1878GUd3kxYUWc5JvRo8ozz6TGO3/3JijWEzkeZY1VLBZ4J9tVrlc+W3hCLjDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=N5W6GuU5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348890;
	bh=1qtbMa2oIpffo9qrfeElmnz139mrppvwu3zsjT10qrM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N5W6GuU506HNT67hwXsBzcHmTOnA3z9T530lNzo6ZAFFjhK4OuxHW/hT28vPUXRUe
	 HxFFqadWxwc4SPCpP6eFLmSoFTcMlA8bB15EBXUpbmR7cdcRtfIUouR+vVKt9Uw2e0
	 Rea2lK1bB6x6zC30dJQ1M2KZpt3Bi2wn3c2giG7g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:34:48 +0100
Subject: [PATCH 2/5] drm/lima: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-drm-v1-2-210f2b36b9bf@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-drm-v1-0-210f2b36b9bf@weissschuh.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Qiang Yu <yuq825@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 lima@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348889; l=1710;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1qtbMa2oIpffo9qrfeElmnz139mrppvwu3zsjT10qrM=;
 b=1WNI1ZkIE8rqLbERLmmdHNShe5o5cZbun/mqENhN73fwlitBkkCVqnSWtvKibM9ZtYm50iZQz
 jn1nSK2Tek2Du1yWr9Wxx1x0jCnSs6GepiyTnnI7BHf93+3qRL9WWgz
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/gpu/drm/lima/lima_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index fb3062c872b317ef27cd321b2638944f8a5dc33a..b969bd3f28968304946c0bb629460e91622d5fbc 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -311,7 +311,7 @@ static bool lima_read_block(struct lima_block_reader *reader,
 }
 
 static ssize_t lima_error_state_read(struct file *filp, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -337,7 +337,7 @@ static ssize_t lima_error_state_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t lima_error_state_write(struct file *file, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -363,8 +363,8 @@ static const struct bin_attribute lima_error_state_attr = {
 	.attr.name = "error",
 	.attr.mode = 0600,
 	.size = 0,
-	.read = lima_error_state_read,
-	.write = lima_error_state_write,
+	.read_new = lima_error_state_read,
+	.write_new = lima_error_state_write,
 };
 
 static int lima_pdev_probe(struct platform_device *pdev)

-- 
2.47.1


