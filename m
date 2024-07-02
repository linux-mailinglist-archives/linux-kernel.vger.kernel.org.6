Return-Path: <linux-kernel+bounces-237143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 252D091EC41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CBF1F22219
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 01:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB44C8B;
	Tue,  2 Jul 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y7balNkR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F036FCB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719882290; cv=none; b=Ngus5x/eN9jBeYomgeoWhQ184pj0+U0TO1WnU3GSVDZgljIaQ3+y9n1h1rOBBn3QCpiYOyf8K+nd+gfwo8Iaw9bcmxgFciVrX0P8WoU5uph7ntlxK9r4PoQcqFkQ/vOgU6Uha9rowa/+3rstBXxLpN10f+8MFZQMUPdahUaGyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719882290; c=relaxed/simple;
	bh=5z7atQ1VjiYvr2o9gWZIqlkvHfprQlCHTqWMYytQ00Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LRufVOGNQpBneLi0tLB3OTespLlIUQ05+ZQhx3iygdtFbZ6/iFTkhe2t/QsEaa/lIQnlkLTVRNzvfF74bVTTsEcdneL8bdjBLQyvdTO4ypiIMQIpvzQvClZTHnuTW0W/O3W50sNNynTBWJwSJthXJDvxoR9sevk70/DGoR8mSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y7balNkR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719882287;
	bh=5z7atQ1VjiYvr2o9gWZIqlkvHfprQlCHTqWMYytQ00Y=;
	h=From:Date:Subject:To:Cc:From;
	b=Y7balNkRr12dGs53p8cujgzf8a47EFsbUeTXjjdWPBY7trHiJ2tdYeKKS44bBXmNt
	 CrEAd825ApjlVEufjeg8bJeTe5K9Ax8Zn4H8LAjPOPQbr3lXjZf4peHGJzdt/tIGPU
	 uQqXNdB80pLMHFk7rCs67NVjm97/kYifhZYwfAShvguDiCZron2f88CCzapobKTT58
	 ZRFj1s0POiyHvpUKGB9sxN62gUdUDHdrpmOHvovRuKqB2qFdwZcz9+HASuGSN37uAF
	 XWgIS9AQ27aCbldlDNk7oWAzCKOZ34Wc1oiCbguVTGIqVJlVswFHauvHsYcEFqaJLD
	 Xn3U1Y7AYGSVw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B399937820DE;
	Tue,  2 Jul 2024 01:04:46 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Jul 2024 04:04:24 +0300
Subject: [PATCH] drm/rockchip: Unregister platform drivers in reverse order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-rk-drm-fix-unreg-v1-1-5bd325ed42b4@collabora.com>
X-B4-Tracking: v=1; b=H4sIABdSg2YC/x2MQQqAMAzAviI9W6hTlPkV8SCu0yJO6VAE2d8dH
 kNIXoiswhH64gXlW6IcIUNVFjCvU1gYxWUGQ6ahjgzqhk539PLgFZQXtL72xlrbTkSQs1M5y38
 5jCl9N7zm72IAAAA=
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sean Paul <seanpaul@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Mark Yao <markyao0591@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Move rockchip_drm_platform_driver unregistration after its sub-drivers,
which ensures all drivers are unregistered in the reverse order used
when they were registered.

Fixes: 8820b68bd378 ("drm/rockchip: Refactor the component match logic.")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 44d769d9234d..ca7b07503fbe 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -528,10 +528,9 @@ static int __init rockchip_drm_init(void)
 
 static void __exit rockchip_drm_fini(void)
 {
-	platform_driver_unregister(&rockchip_drm_platform_driver);
-
 	platform_unregister_drivers(rockchip_sub_drivers,
 				    num_rockchip_sub_drivers);
+	platform_driver_unregister(&rockchip_drm_platform_driver);
 }
 
 module_init(rockchip_drm_init);

---
base-commit: 1eb586a9782cde8e5091b9de74603e0a8386b09e
change-id: 20240702-rk-drm-fix-unreg-9f3f29996a00


