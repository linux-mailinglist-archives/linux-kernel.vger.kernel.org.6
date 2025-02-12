Return-Path: <linux-kernel+bounces-511845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C872A33071
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DE31887100
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87473202F71;
	Wed, 12 Feb 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3h1vEvj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E020103B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390773; cv=none; b=Bv1ahYB7comziVWP+2kBeary+EBREDNQOoFXl0znYIDBtPyz25QTE7ag+6V4ePMA96oyiAGXS1+SjI/xPEdh6OOeKmwD7hhQyI94QVWnkS84iDOdZVsvy962NljmymNfhgNxOVJX9GRh+Ao/xjPHwL5kbvfJ0k589jnVib6Ivso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390773; c=relaxed/simple;
	bh=eRnfdU2vmfJPGvUWDmysQE9CdXMXytxNB8DSsopwuTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLe/iUJaejSVSa+enter3vBVcL8Pw+wzJiuUNvWx6PGnQwYulCUg8kAKB3ozJAZ6e+sN77x4HoElUEeIrsOP+5BDT8fQPvlc2ITLo88+kGXU8IRPD1zaPTAc41sMCJsbv6JsSEefh1lj3fKpSu8TxJGZ9f09+NadcGVRD43lj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3h1vEvj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390772; x=1770926772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRnfdU2vmfJPGvUWDmysQE9CdXMXytxNB8DSsopwuTM=;
  b=K3h1vEvjDV7CqLwtzMh81H37TT52K9/4cmjlLOBegRt+WqnEu5Zx71+l
   YpvPBw5qCe9rXNopjWv5I/26+QdwPfpzpaKCwFp5uOSO4NxhswGOvehbx
   sNVPRjkua/ziU3bnpBDcHIA3F3tU0/IG0BP/GqRnpltpofsePSbrg5ANL
   7YSK9uWTioCOkjwltIuGP0zd4uK5v2nyPpIzg4fyva0fyitx6spLk0IFH
   idrmvs52jVBqqnPtFJGpMztEgWK7F6wY+cT9fHU3XgJPq/+HOppODUTHG
   ISISqEDMSSBz1qFBDIIKjS6MrviFc8aKUjB4HaHyHej+IReLb2uRhCNbf
   g==;
X-CSE-ConnectionGUID: CFQ/Ol9TSwSz9LCNUIxKWw==
X-CSE-MsgGUID: V7dXEnfIRp+FVIPQNILMoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718505"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
X-CSE-ConnectionGUID: QyREsbHrRkazVNBE+qYUaA==
X-CSE-MsgGUID: s2C2m5g4TBiX9UjAq70xYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010767"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 5/6] drm/xe: Switch from xe to devm actions
Date: Wed, 12 Feb 2025 12:05:41 -0800
Message-ID: <20250212200542.515493-6-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212200542.515493-1-lucas.demarchi@intel.com>
References: <20250212200542.515493-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that component drivers are compatible with devm, switch to using it
instead of our own.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/display/xe_display.c | 4 ++--
 drivers/gpu/drm/xe/xe_gsc_proxy.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index bdcc56e51433f..302f533af037d 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -161,7 +161,7 @@ int xe_display_init_early(struct xe_device *xe)
 	return err;
 }
 
-static void xe_display_fini(struct xe_device *__xe, void *arg)
+static void xe_display_fini(void *arg)
 {
 	struct xe_device *xe = arg;
 	struct intel_display *display = &xe->display;
@@ -183,7 +183,7 @@ int xe_display_init(struct xe_device *xe)
 	if (err)
 		return err;
 
-	return xe_device_add_action_or_reset(xe, xe_display_fini, xe);
+	return devm_add_action_or_reset(xe->drm.dev, xe_display_fini, xe);
 }
 
 void xe_display_register(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_gsc_proxy.c b/drivers/gpu/drm/xe/xe_gsc_proxy.c
index 6aa76a7843cfa..8cf70b228ff3b 100644
--- a/drivers/gpu/drm/xe/xe_gsc_proxy.c
+++ b/drivers/gpu/drm/xe/xe_gsc_proxy.c
@@ -423,7 +423,7 @@ static int proxy_channel_alloc(struct xe_gsc *gsc)
 	return 0;
 }
 
-static void xe_gsc_proxy_remove(struct xe_device *__xe, void *arg)
+static void xe_gsc_proxy_remove(void *arg)
 {
 	struct xe_gsc *gsc = arg;
 	struct xe_gt *gt = gsc_to_gt(gsc);
@@ -490,7 +490,7 @@ int xe_gsc_proxy_init(struct xe_gsc *gsc)
 
 	gsc->proxy.component_added = true;
 
-	return xe_device_add_action_or_reset(xe, xe_gsc_proxy_remove, gsc);
+	return devm_add_action_or_reset(xe->drm.dev, xe_gsc_proxy_remove, gsc);
 }
 
 /**
-- 
2.48.1


