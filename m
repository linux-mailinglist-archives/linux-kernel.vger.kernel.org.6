Return-Path: <linux-kernel+bounces-343217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32999989846
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4420283B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1496614B970;
	Sun, 29 Sep 2024 22:18:30 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613874C69
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648309; cv=none; b=QT0voHhuKXVoowz6EFBM5LZUvbeXhw9K61I2XUzVD0OnW/Z1FvyvZW0e4Lt8WouJY9ebF91KQxa1BdOJhGgdj+C/kdzjzxY70zPnR0w8yZZ5T3FwQ7NRmSEi+jDwWZWzSYDEiwWEIfzfXtW9aZ0zeaQ7m5kra3SEMJzRn4FGhVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648309; c=relaxed/simple;
	bh=JSXP/CFMoxRbivglErf3x29sSNHWQvSQ9Q+6Gs0YZfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nt8whUTykuPHWy/f6yN+CAvaUYdtTs+pXwWAXh17aFYs1/v3eEUeU9DVn8rjLFni7ka3+y3uNfkSZN2HUg+DEuMS/6iHFgpD7fmld37VBCn1+0DmHx9Su17cGXBV1Nn/FPJ37L3MSjL5FFVG6tk78U3u/UYSBEn+QNkI+vTmFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id EB548153F903; Mon, 30 Sep 2024 00:10:35 +0200 (CEST)
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: 
Cc: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Set FMODE_UNSIGNED_OFFSET in fop_flags
Date: Mon, 30 Sep 2024 00:10:31 +0200
Message-ID: <20240929221034.1889572-1-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a regression introduced in commit
641bb4394f405cba498b100b44541ffc0aed5be1.  No panthor device, card or
render node, could be open() since this commit, returning EINVAL
instead.  This prevented Mesa from working on SoCs such as the rk3588
which contains a Mali-G610 GPU.

The commit mentions which drivers must be changed to set that flag, but
panthor seemingly got forgotten, triggering the WARN_ON_ONCE() added
in drm_open_helper().
---
 drivers/gpu/drm/panthor/panthor_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 34182f67136c..c520f156e2d7 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1383,6 +1383,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.fop_flags = FOP_UNSIGNED_OFFSET,
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.46.2


