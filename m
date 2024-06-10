Return-Path: <linux-kernel+bounces-208532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD0902665
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1888BB21D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6C14373F;
	Mon, 10 Jun 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3IuokHy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CF1422C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718035907; cv=none; b=hcypHvhDexkc348rfTMfLTJt5ewuWMZu9kLChckTFFPdk9d+Zt6msCltq0MeIvaL4FvDhrw28GivIFBcH2ZgIPF0TJlfZLno1Qc3dkDW4KQ92f8BnxkBxfQieow5bFim4/PjrCgFVMQUO572Z076kMUSLB5mEJyd2qcI+8IhLeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718035907; c=relaxed/simple;
	bh=jthJjJ2zKTiLV2PBjpIfe6L6//S4w66QTWO5SgbSzSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7g+w6yIb4i0F7mUphjYy26L7frLCQ8yRjaAHxjfnIv+B8zZjPG8xMd+14vkZaDub1V4J7GXgy7gtyl0PAouGR/KIJVt3V9TcIUDDZ74XSgv/gdFw+2oXVwc2SCBQodj7Tt5N0/yvpEGubSwxLqyO7ZOf/pDjBUTSZfTt0tJwUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3IuokHy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718035906; x=1749571906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jthJjJ2zKTiLV2PBjpIfe6L6//S4w66QTWO5SgbSzSU=;
  b=F3IuokHy4a52TC487ipa2fjGKPb87Ga0HQX8Xc0Ipg9YyyVXCFTcRPpM
   +xL8yoeO7l5VTlxFwH4XveYgtwXxQMwb1pvBFuG4g/5cJ0bzrZSZm4b4i
   dy85C0zOLLxsk2R4ChcVL1fAWMzZr1t0g3UvWbWPShFE1T+2c4zii+7Kj
   A4ZSRZuS+oc2yUZ+ijU+9hCkhzCBXB99+uAmKWyR62BoF0tJhyzT6hZ7G
   9u43LyJ0bn9KUq/USc7HEXwMVJIVez9yeK585W6el3T04wgwzKNQ8fGzq
   OSRaKn0AxciHvXFaXbMBsni3GBBu511CABgzhGrcJRQs84p5FZdFIdLIW
   g==;
X-CSE-ConnectionGUID: WAyuv/L6Shi5EdRhURIoew==
X-CSE-MsgGUID: XhK3yfyvRqanp862WRbhEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32193234"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="32193234"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:11:45 -0700
X-CSE-ConnectionGUID: T1Eb7ZF/S9urMerLp+Am7g==
X-CSE-MsgGUID: IkcbREIBTGWs8Dn1ZLkHMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="62281526"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 09:11:43 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v5 2/2] drm/xe: Increase devcoredump timeout
Date: Mon, 10 Jun 2024 09:11:33 -0700
Message-ID: <20240610161133.156566-2-jose.souza@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240610161133.156566-1-jose.souza@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5 minutes is too short for a regular user to search and understand
what he needs to do to report capture devcoredump and report a bug to
us, so here increasing this timeout to 1 hour.

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Acked-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
---
 drivers/gpu/drm/xe/xe_devcoredump.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
index d7f2d19a77c10..62c2b10fbf1d2 100644
--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -53,6 +53,9 @@
 
 #ifdef CONFIG_DEV_COREDUMP
 
+/* 1 hour timeout */
+#define XE_COREDUMP_TIMEOUT_JIFFIES (60 * 60 * HZ)
+
 static struct xe_device *coredump_to_xe(const struct xe_devcoredump *coredump)
 {
 	return container_of(coredump, struct xe_device, devcoredump);
@@ -247,8 +250,9 @@ void xe_devcoredump(struct xe_sched_job *job)
 	drm_info(&xe->drm, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
 		 xe->drm.primary->index);
 
-	dev_coredumpm(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
-		      xe_devcoredump_read, xe_devcoredump_free);
+	dev_coredumpm_timeout(xe->drm.dev, THIS_MODULE, coredump, 0, GFP_KERNEL,
+			      xe_devcoredump_read, xe_devcoredump_free,
+			      XE_COREDUMP_TIMEOUT_JIFFIES);
 }
 
 static void xe_driver_devcoredump_fini(void *arg)
-- 
2.45.2


