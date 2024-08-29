Return-Path: <linux-kernel+bounces-307228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A296E964A71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC50B1C21ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0C21B3758;
	Thu, 29 Aug 2024 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQvP27/r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B44084E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946410; cv=none; b=MSDkUXrfiT0nAfiHmtfInttihHTBnmhH77NcqXoYpWn4c3rUFSJmtOgMSEnJ0Gt4H8jXAeuXJBl58So926GueJUo6ku0H0P4UPMzF24KBIuwBgMPPNfTMdi7ifuo8CkiMQqnp4pPZQM5jvZwWzFLvEqsXrCRCwuIvLVUbVS3kAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946410; c=relaxed/simple;
	bh=KjcErCEgCmDjl43vjboJGBw0hPNn9Yt8aen+PL1k2vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZTS4luT8lBsZTgUDQT4bMSu9hA7Hsa4SzigGOxHTbdtwqzrjpYSZQTXWK/jEZ2aj2PHamQbwvhXuhrkX9u955rHRZGjtuR9g/aK3jl0+fqguXOWDz09kUCxNi7SkOoswGorje6jBQ2HsJWprgVIyXN3QLhwQH5CD/z49DpIUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQvP27/r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724946408; x=1756482408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KjcErCEgCmDjl43vjboJGBw0hPNn9Yt8aen+PL1k2vA=;
  b=IQvP27/rmafsmdLHtCitfBhOMfqbf7qxZvRzyz3PVwfYqNfSlLAsKQMw
   v3t9ikOf+QU7ZxO4FdR1eeQZ2m9pSQXM5NMd8LhAtElqT5n/6XtkU7mBh
   uIqOcmPmwrvX74YCLpKt3gg3lCz58/vlRHe/0AI/KOXb3w8F95IJdXOiH
   JKbFhMhhFT6Wu/PLTMV53HFHcO66SYqOdToiqZKx/ptXz/FVMOEueSpPZ
   572OddefSaKKTMh4pSYQrNsB0yBKSgZkC0drxyYfsNRnMneeH+DMw2OGZ
   mlpJbnBJLU+NF2DTK9DqYDE0AcPsrRLqiMFgzI9rjqcLYf3Pt7XeXtlLN
   Q==;
X-CSE-ConnectionGUID: BRnqMj3JRYO0B9MtdsOs0A==
X-CSE-MsgGUID: NemsR/ypTpOSoyb99dxzMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34122432"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34122432"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:46:47 -0700
X-CSE-ConnectionGUID: hE6iAtNqSb2ZkFN3oIwmHA==
X-CSE-MsgGUID: PKjTB9JzRMiu/SdC9mViRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="86845941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 29 Aug 2024 08:46:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 803C6610; Thu, 29 Aug 2024 18:46:44 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 1/1] drm/mm: Mark drm_mm_interval_tree*() functions with __maybe_unused
Date: Thu, 29 Aug 2024 18:46:40 +0300
Message-ID: <20240829154640.1120050-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The INTERVAL_TREE_DEFINE() uncoditionally provides a bunch of helper
functions which in some cases may be not used. This, in particular,
prevents kernel builds with `make W=1` and CONFIG_WERROR=y:

.../drm/drm_mm.c:152:1: error: unused function 'drm_mm_interval_tree_insert' [-Werror,-Wunused-function]
  152 | INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  153 |                      u64, __subtree_last,
      |                      ~~~~~~~~~~~~~~~~~~~~
  154 |                      START, LAST, static inline, drm_mm_interval_tree)
      |                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by marking drm_mm_interval_tree*() functions with __maybe_unused.

Fixes: 202b52b7fbf7 ("drm: Track drm_mm nodes with an interval tree")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/drm_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 5ace481c1901..1ed68d3cd80b 100644
--- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -151,7 +151,7 @@ static void show_leaks(struct drm_mm *mm) { }
 
 INTERVAL_TREE_DEFINE(struct drm_mm_node, rb,
 		     u64, __subtree_last,
-		     START, LAST, static inline, drm_mm_interval_tree)
+		     START, LAST, static inline __maybe_unused, drm_mm_interval_tree)
 
 struct drm_mm_node *
 __drm_mm_interval_first(const struct drm_mm *mm, u64 start, u64 last)
-- 
2.43.0.rc1.1336.g36b5255a03ac


