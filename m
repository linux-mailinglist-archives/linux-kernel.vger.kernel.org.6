Return-Path: <linux-kernel+bounces-206666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0F900C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48BB2857D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DCF14D717;
	Fri,  7 Jun 2024 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXIpaDUw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434E73471
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788754; cv=none; b=sh+WwxZAXj7oZO/1ypQCQTvxul31Uh0kIsjSgMHLuvGX556R3WNL1Tvyipmj0Pa0Ep4C6zQrn6IW28D6JWot1ZIt1dZLdewRXDp9rMNJTcjEtMyyEhziiZ09KsU4XH7DqGtUYhYTp7cwaUGcxNpL6J8xjdsXfemsdxZVu1asHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788754; c=relaxed/simple;
	bh=jthJjJ2zKTiLV2PBjpIfe6L6//S4w66QTWO5SgbSzSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihbjycHfBKrxkVX/uE8u6WzBcd+YnekQGWBL2sGoDryNOW0CHasNDMA3+Fr1K4O/6lVvUeuTWbRpe0AifJ0fDL6ihz0UruDCb3o32mFvLnpl5iL7got33Ld0nHXCsLq7ytlaDPyOhGf4ouggJj3bBYTelE0ZzVtzP35NQROvX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXIpaDUw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717788753; x=1749324753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jthJjJ2zKTiLV2PBjpIfe6L6//S4w66QTWO5SgbSzSU=;
  b=XXIpaDUwmNJPY0a198rgfenVx2bJEoByhXqQV1gNdhaN9TYE491ICeg6
   +W9y9WHmXFNXqEsfs7/8l8u2klGDPVl7BpgblZ/dGHNGB2IX8fEqxx8JA
   2BJLn5hpepZGzD5nzNt57hU7oIjY+VRHdOS56OnM4ujJVyCPqRdQqxG1R
   tRat4LeOYN8dv1mhBaVfQGMFvJLtMVB3KovDBtQjISfE9MKQBRasgLv+H
   TWUT6CiH6OLzWnOtiiFNqSQFPux1KvlNgUiJti1RxTua5mttTOfMTWCla
   FdiUo4SAoR67ruE9iJaeMUZN6hlMq1JdbzLUSP5tTJPXsgrMA6cOZYNOf
   g==;
X-CSE-ConnectionGUID: WoLCqib5Q/KMfB058eLV8Q==
X-CSE-MsgGUID: DLpOZgRWTYK9adgGM6JaoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14407268"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14407268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:32:32 -0700
X-CSE-ConnectionGUID: 3D2UOva2SSi1BIdUpy7PYg==
X-CSE-MsgGUID: naCm+GwKRDahBs06Fn/tkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="39089279"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 12:32:30 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v4 2/2] drm/xe: Increase devcoredump timeout
Date: Fri,  7 Jun 2024 12:32:20 -0700
Message-ID: <20240607193220.229760-2-jose.souza@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607193220.229760-1-jose.souza@intel.com>
References: <20240607193220.229760-1-jose.souza@intel.com>
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


