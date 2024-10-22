Return-Path: <linux-kernel+bounces-377116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B69ABA14
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6071C22D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39D1CEEAC;
	Tue, 22 Oct 2024 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="RfgC+caG"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB61CEAD8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639790; cv=none; b=FXlgXwpaQQ5gv1Jr0+gjBROu1GgXXkinQXD4BSxvI7PDaNZ+sfH4kUbEA7/KWeTFAMe6gSSQlkOhsPf9vwMETxpzcpb0woEg2rGrJICHGDQaujukDIW5qz3kzLdeviKfA4mY8ohkeLpuSEuzhGebWn+nJbwq60TFbzeW9KxHmvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639790; c=relaxed/simple;
	bh=ShJZn/1jzEKzGtEdVAVCAsxwzTkHKyaE2pTo9xC+Irw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqZQjLbm7VYmcvFxKBQfB8YbFBIOBT2tKAFMZZzSCcDyI8aQ8eY5ZEcQt5vbYT5UIZiT1KTmbjVWcv/r+WOqdzqrXFpsMebQSoqfBiVuO3LXvTPSFfs+9JkFJhAn8498O07RA4Uf0Vrr25wIwXj4m/CV0mZotSbkQ09v9/87qBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=RfgC+caG; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=ysbfho3bNM6XX4PTBUAzuKwO5RGewbfKhzT2qUY5ztM=; b=RfgC+caGgGJpt6vy
	PkRfcfdL7k4tJ3Q3em7z+fNuMhMkhDz8MbHODCpF6ij85AVp9uw5ZggVi9fADHBok93X0vXwrVj41
	3S3Qqnc9wfbzmh/G/SCUy0agyIofFviTM5aTPSrcFxWjcJ07vexqr9bk1oMpySOQg38vswnjpOzpe
	KhVP7KaN2HTdGHYipY7/cVdbMeFb61BN+q8NufVECjWXovSsfR6j4gHKT7mlQquLZ9tBCMmdO0qig
	cY2nATh7MB6OQ7yDtP73uljUWOcGPuV/kM4rvcYLQ7Q3ezfjAPrGLsVCDTpYknCQAifZBEkFYZTkE
	Xu2C+pdhSEhsByloUA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t3OJo-00CtGr-3C;
	Tue, 22 Oct 2024 23:29:41 +0000
From: linux@treblig.org
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/5] drm/client: Remove unused drm_client_modeset_check
Date: Wed, 23 Oct 2024 00:29:34 +0100
Message-ID: <20241022232934.238124-6-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022232934.238124-1-linux@treblig.org>
References: <20241022232934.238124-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

drm_client_modeset_check() was explicitly added in 2020 by
commit 64593f2a6fc9 ("drm/client: Add drm_client_modeset_check()")
but has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/drm_client_modeset.c | 24 ------------------------
 include/drm/drm_client.h             |  1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index cee5eafbfb81..69e1ce4d18cd 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1126,30 +1126,6 @@ static int drm_client_modeset_commit_legacy(struct drm_client_dev *client)
 	return ret;
 }
 
-/**
- * drm_client_modeset_check() - Check modeset configuration
- * @client: DRM client
- *
- * Check modeset configuration.
- *
- * Returns:
- * Zero on success or negative error code on failure.
- */
-int drm_client_modeset_check(struct drm_client_dev *client)
-{
-	int ret;
-
-	if (!drm_drv_uses_atomic_modeset(client->dev))
-		return 0;
-
-	mutex_lock(&client->modeset_mutex);
-	ret = drm_client_modeset_commit_atomic(client, true, true);
-	mutex_unlock(&client->modeset_mutex);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_client_modeset_check);
-
 /**
  * drm_client_modeset_commit_locked() - Force commit CRTC configuration
  * @client: DRM client
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 560aae47e06d..e1fd32adb3e9 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -176,7 +176,6 @@ int drm_client_modeset_create(struct drm_client_dev *client);
 void drm_client_modeset_free(struct drm_client_dev *client);
 int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width, unsigned int height);
 bool drm_client_rotation(struct drm_mode_set *modeset, unsigned int *rotation);
-int drm_client_modeset_check(struct drm_client_dev *client);
 int drm_client_modeset_commit_locked(struct drm_client_dev *client);
 int drm_client_modeset_commit(struct drm_client_dev *client);
 int drm_client_modeset_dpms(struct drm_client_dev *client, int mode);
-- 
2.47.0


