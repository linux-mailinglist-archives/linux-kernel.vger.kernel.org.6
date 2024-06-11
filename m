Return-Path: <linux-kernel+bounces-210351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E091A9042AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA72875B0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528145A117;
	Tue, 11 Jun 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7UcGnXD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA061CD2B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128049; cv=none; b=FKZpTOXW3Tr6BG+RNzmqJGZz+3Bb494bV7dcOURq+AEiPSpzvsgJ0UCzUlmUi+J8JApYzXskqeQF12MgnCanl0XFqFe0DuOAolAeL2VUccR0alXbzYsCEKf+JRq9Ys1QC+dgMugA1GmlgGNNaHx346SOaK6HBl2l1RRg6Hf2p9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128049; c=relaxed/simple;
	bh=/XdZHubJ6eMhZ1fMCUnTP4sNv9CCswIT96ACgXjCY40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WoOU4XhN/prD5DR2pv0rh0MRzmGRUmEH7CEgsks4H5ULQ7ERowZICQw/jpPbSb2BjMEM2dxRmiZ9tkXZq2qi/FQ9sVMNBAqeB185xV0DY8cohpllDVvDJzB+eqHrxv51c+UQZZu/5dM9TxLZgrg+Tc1f2Gy637LUYqa5Eaxo3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7UcGnXD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718128048; x=1749664048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/XdZHubJ6eMhZ1fMCUnTP4sNv9CCswIT96ACgXjCY40=;
  b=J7UcGnXDRGcG5u9uU8/j5axv17yQCXlFf2FZKfNOr0CQy0BK3idQSk8B
   obAZvrfxBPPWVQXYOZuj7elqmilUflQGwXjLXKLvz10CTDyD8OyF8lWIx
   oOfUGAlN7Ugj+mUhgTcxhtBxhZZSzFIuFFnPAqB2Id1ZrehVuLmGKmkd8
   bf65SrZHxQ7619NktrK9PF7hjkbEEYIL1BrOERptGDlOvTWIguIayoy7j
   aNpBEMIF5xFMGTuG0g+ikkRPD1lXwzqix1GwC2f73DyhsfwyGwysJCONs
   EjuWaoRRBnVa2Nrb7wa+fcXLLh5PwVKVbsg+widOFO4EHiEfZhmCjK4OD
   A==;
X-CSE-ConnectionGUID: WgfVSMV2QseJBp/TD6EhSQ==
X-CSE-MsgGUID: 6t3xF0BsST6kFZqkWXTd0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18635931"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18635931"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:47:28 -0700
X-CSE-ConnectionGUID: vH1GHzfDR7mOoi0oxXIJDg==
X-CSE-MsgGUID: XsipVPqERVCrj4cZFTfp+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39614180"
Received: from josouza-mobl2.bz.intel.com ([10.87.243.88])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 10:47:26 -0700
From: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
To: linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>
Subject: [PATCH v6 2/2] drm/xe: Increase devcoredump timeout
Date: Tue, 11 Jun 2024 10:47:16 -0700
Message-ID: <20240611174716.72660-2-jose.souza@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611174716.72660-1-jose.souza@intel.com>
References: <20240611174716.72660-1-jose.souza@intel.com>
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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
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


