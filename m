Return-Path: <linux-kernel+bounces-335362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5597E49C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA4D280FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F2EACE;
	Mon, 23 Sep 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Y59K7PX4"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540D2F24
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054708; cv=none; b=dLdl7E2kx4NsW9wrDpq1hMAt9+guLXAjP/MKsN+jqHFI9KUi8yj70/P+iSinP+ML0g35uuMKjIBcC6+Qwsx7xjmAtNVw6ySdYCQGqZC8TyzgYbQcOwUNiBaVzOfU69YAFSXPqNKdomgOejOcm+sTz8oBeU0iB/um15urjd/54GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054708; c=relaxed/simple;
	bh=Fvtu4ZkdFuQWVZdn5JXLgUl8Jc7OA3Gk3vZhH2QQ9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRCT6xa5EObnaxq9n36jRITLBG/+Or4R80i0vVyDjr4zb1Wgazzy/PFHOPDACJl1f6mBeTESPomuYfbn5zwXGGk+2Cc2zlPsy5x9dPaoF2BmMUuO37yt59GT2DTEIszDwrpYd27+32ZUUEg4iOrxHNUqvZqVbbLGASzvz1vnVAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Y59K7PX4; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Kc9zefA0QswG8gCmJgyLW5CUDw57gg8nkHoO6NYXt7k=; b=Y59K7PX4yi5wXvuT
	d3Jt+iWNwUU/7nb1YkuN5P/ehVQgu8Aq5K3qnsr35Cbbls12+bG3Jb9UuFL1H+fmUJEZsHHKtX2ta
	Q7iakA5ZMCgYtcwdVK1UEPRLR/gQx/n7H4NCSsBdeEZXlX36M/Dh5YGUUKzpIhRIQT8/k1wxy7hdO
	uSl7o1HURYQxH6x9n7sye5Kd6otF6STv+TknDHBGXo4uymjz51HU29R0aoxpmVpLjhdl8GbHUCcrj
	gebo5MBfHQQSYaS5IYgldpcJiMiqsn32lNNVAVBs1lpmiVPaFD+HKAPE7+sxkDF9rU3BpkpHqhHSy
	ZvO2diVG4x6KFsFoTg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXoz-006k2k-2F;
	Mon, 23 Sep 2024 01:25:01 +0000
From: linux@treblig.org
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 5/5] drm/amdgpu: Remove unused amdgpu_i2c functions
Date: Mon, 23 Sep 2024 02:24:46 +0100
Message-ID: <20240923012446.4965-6-linux@treblig.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923012446.4965-1-linux@treblig.org>
References: <20240923012446.4965-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

amdgpu_i2c_add and amdgpu_i2c_init were added in 2015's commit
d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
but never used.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 25 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h |  4 ----
 2 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 00d6211e0fbf..f0765ccde668 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -225,15 +225,6 @@ void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c)
 	kfree(i2c);
 }
 
-/* Add the default buses */
-void amdgpu_i2c_init(struct amdgpu_device *adev)
-{
-	if (amdgpu_hw_i2c)
-		DRM_INFO("hw_i2c forced on, you may experience display detection problems!\n");
-
-	amdgpu_atombios_i2c_init(adev);
-}
-
 /* remove all the buses */
 void amdgpu_i2c_fini(struct amdgpu_device *adev)
 {
@@ -247,22 +238,6 @@ void amdgpu_i2c_fini(struct amdgpu_device *adev)
 	}
 }
 
-/* Add additional buses */
-void amdgpu_i2c_add(struct amdgpu_device *adev,
-		    const struct amdgpu_i2c_bus_rec *rec,
-		    const char *name)
-{
-	struct drm_device *dev = adev_to_drm(adev);
-	int i;
-
-	for (i = 0; i < AMDGPU_MAX_I2C_BUS; i++) {
-		if (!adev->i2c_bus[i]) {
-			adev->i2c_bus[i] = amdgpu_i2c_create(dev, rec, name);
-			return;
-		}
-	}
-}
-
 /* looks up bus based on id */
 struct amdgpu_i2c_chan *
 amdgpu_i2c_lookup(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
index 63c2ff7499e1..21e3d1dad0a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.h
@@ -28,11 +28,7 @@ struct amdgpu_i2c_chan *amdgpu_i2c_create(struct drm_device *dev,
 					  const struct amdgpu_i2c_bus_rec *rec,
 					  const char *name);
 void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c);
-void amdgpu_i2c_init(struct amdgpu_device *adev);
 void amdgpu_i2c_fini(struct amdgpu_device *adev);
-void amdgpu_i2c_add(struct amdgpu_device *adev,
-		    const struct amdgpu_i2c_bus_rec *rec,
-		    const char *name);
 struct amdgpu_i2c_chan *
 amdgpu_i2c_lookup(struct amdgpu_device *adev,
 		  const struct amdgpu_i2c_bus_rec *i2c_bus);
-- 
2.46.1


