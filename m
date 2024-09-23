Return-Path: <linux-kernel+bounces-335359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC0897E499
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0192811F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56A4A1E;
	Mon, 23 Sep 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="QBr7ddZj"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6393624
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054706; cv=none; b=jvrWFEKbNHunQPiFZHoVc8UD/xSRjOb28OCtPMIdqbaQ5Lon3pu/lOxap3qwQCc0an2PTcR/kUembtiLMHx1vQCk7zUxSPOi3p5Pd31SS8r0Qhephrg4VPX+T/TkFgr3N0yxyUMr+1f3DKJxpMJ5wRaqU+WAX3tDFyCik9Lu2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054706; c=relaxed/simple;
	bh=gLxFg5mVO63UvR8Prnu5hVDQWxuuFpMZ5gtHevV+ROE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWmeyFBj0Y4Nx5kPXTlJkPvkrAFs8v86O8ilZ5YzjnkCvnuEcnq6Xn52RKy5BtuiS6z9IZsb2wsewYVkux35PPtXGNdiJzgRWHaixocI6OPOM++Y5teA7qYHQ4rJirU7p3ACihv6+ZQzjBayCWstx7CmnrtU5QwPKDhJLP/UpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=QBr7ddZj; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0V2AdfgE23jS7hBIUEzp4BsZ0ty7sP1XLQloMvwgZOc=; b=QBr7ddZjimhR3pK5
	/Amz5CPf/6CBLQ38h+GLfjAr9adVboARmO9+K5OohmdlGKiNXEudlawNVqqDNDCHbmdHxViRSVyNJ
	8IJ82MDD6/djEl+Nlt2CDrhR9nsamtqVxyduqLsf9B4i0F7wPq8oU3RGWpYtoxinOxUcg6P8kXov1
	Wxv4AT64FKRXXqsd31RMMWZ33rOFmFY/n51FffBgzT6/ykTsaTpIKi6vgtOb6OKlcM+ofFk7BFuG1
	UMC/PtK+ckoH31Q0dI5FIwzcYNLya6gtw3fQoXQy7/Yf42aKDrqnmRasrrEPgQ4YFdvMvtXa7Ksct
	Ot5pA3rQ3VmFmub4YQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ssXow-006k2k-2p;
	Mon, 23 Sep 2024 01:24:58 +0000
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
Subject: [PATCH 2/5] drm/amdgpu: Remove unused amdgpu_atpx functions
Date: Mon, 23 Sep 2024 02:24:43 +0100
Message-ID: <20240923012446.4965-3-linux@treblig.org>
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

amdgpu_atpx_dgpu_req_power_for_displays has been unused since
commit bdb1ccb080da ("drm/amdgpu: remove ATPX_DGPU_REQ_POWER_FOR_DISPLAYS
check when hotplug-in")

amdgpu_atpx_get_dhandle has been unused since commit
f9b7f3703ff9 ("drm/amdgpu/acpi: make ATPX/ATCS structures global (v2)")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h              |  8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c654668e2a56..f360296fc9da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1452,23 +1452,15 @@ void amdgpu_register_atpx_handler(void);
 void amdgpu_unregister_atpx_handler(void);
 bool amdgpu_has_atpx_dgpu_power_cntl(void);
 bool amdgpu_is_atpx_hybrid(void);
-bool amdgpu_atpx_dgpu_req_power_for_displays(void);
 bool amdgpu_has_atpx(void);
 #else
 static inline void amdgpu_register_atpx_handler(void) {}
 static inline void amdgpu_unregister_atpx_handler(void) {}
 static inline bool amdgpu_has_atpx_dgpu_power_cntl(void) { return false; }
 static inline bool amdgpu_is_atpx_hybrid(void) { return false; }
-static inline bool amdgpu_atpx_dgpu_req_power_for_displays(void) { return false; }
 static inline bool amdgpu_has_atpx(void) { return false; }
 #endif
 
-#if defined(CONFIG_VGA_SWITCHEROO) && defined(CONFIG_ACPI)
-void *amdgpu_atpx_get_dhandle(void);
-#else
-static inline void *amdgpu_atpx_get_dhandle(void) { return NULL; }
-#endif
-
 /*
  * KMS
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 375f02002579..3893e6fc2f03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -89,18 +89,6 @@ bool amdgpu_is_atpx_hybrid(void)
 	return amdgpu_atpx_priv.atpx.is_hybrid;
 }
 
-bool amdgpu_atpx_dgpu_req_power_for_displays(void)
-{
-	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
-}
-
-#if defined(CONFIG_ACPI)
-void *amdgpu_atpx_get_dhandle(void)
-{
-	return amdgpu_atpx_priv.dhandle;
-}
-#endif
-
 /**
  * amdgpu_atpx_call - call an ATPX method
  *
-- 
2.46.1


