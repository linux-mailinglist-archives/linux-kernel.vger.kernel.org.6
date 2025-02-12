Return-Path: <linux-kernel+bounces-511846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24B9A33073
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB263A42CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BE1202F88;
	Wed, 12 Feb 2025 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ynhjs+Yl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5925520103D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739390774; cv=none; b=uJPrYoJok9Xb5AMWAquFO2lhJ4dowXkB+qGGOMY6ptjygKrorkhmWWWvC0cU2/XUmZYJIsLyaBPVBKFL7ILYQdLCWF98P7jOVC0k6ogeRLOoyGC0BmXOvqnkNjVoVbU7nQ176ONsq9Ew2Lsi6IJ61hAbUQRI7G92VQPM9+Eltgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739390774; c=relaxed/simple;
	bh=Gr626Pije9wvykEMTGa0ijTndejJ/ehjVeon9HAk+UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pkwm/ByCrgUfhHxjGSAQ39+ThtIxqua/0T+dri3IkTQ0oNgL+H4hFHjIgVVSZCkrAQzblo+LqVdt+efdPITjPNIaIO6IE0Au7jE4eEyzv4ewmacXc2peVk/Mdoc+xyjtKfsCEBHTN8uOFNXi7bPEwIkvlgtVnrcsahDxOPVNads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ynhjs+Yl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739390772; x=1770926772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gr626Pije9wvykEMTGa0ijTndejJ/ehjVeon9HAk+UU=;
  b=Ynhjs+YlaJlX88RW2SUo26y1SWatVFhoux4nNIPoBMIC28LDK1ZycRl8
   kaaOr113PLbArG8U6M9PgYLQ/VFgRNmI84rAsDGZ2AFyRZvMh2JkemWHP
   lel8WeZJVnql06F0w5K0S87Hp4gKFK8ld265GZ4xVuI1BXqK4MVlbhS8D
   YTjlwIXBOHtEWYZ7FeNPJuGBB+G82RPvNgMlwzi63rIfTTDJ46IxVyi2o
   eV424p1LOltx8Sni9qOEnO3wswgOpMgHl5c4nbKW7jvO5FhdLAMFJUYyy
   VFv6s4yxqacAm87ntruBi0Bgaw0xEnqOnRADxblz2jAWxk5Vg5vxkzHHx
   g==;
X-CSE-ConnectionGUID: 3RSetXYhRFS3sZ5ms1v1yw==
X-CSE-MsgGUID: RcRVs/2aTGyZ9sLtngaNUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="50718509"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="50718509"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:06:08 -0800
X-CSE-ConnectionGUID: nO6j/1LaSwKZdrcUYzdffQ==
X-CSE-MsgGUID: TCOz3OYYR0y5qL07mSklIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="118010770"
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
Subject: [PATCH 6/6] drm/xe: Drop remove callback support
Date: Wed, 12 Feb 2025 12:05:42 -0800
Message-ID: <20250212200542.515493-7-lucas.demarchi@intel.com>
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

Now that devres supports component driver cleanup during driver removal
cleanup, the xe custom support for removal callbacks is not needed
anymore. Drop it.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c       | 79 ----------------------------
 drivers/gpu/drm/xe/xe_device.h       |  4 --
 drivers/gpu/drm/xe/xe_device_types.h | 17 ------
 drivers/gpu/drm/xe/xe_pci.c          |  4 +-
 4 files changed, 1 insertion(+), 103 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4b4039cf29fd4..d83400bbff8b1 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -65,12 +65,6 @@
 
 #include <generated/xe_wa_oob.h>
 
-struct xe_device_remove_action {
-	struct list_head node;
-	xe_device_remove_action_t remove;
-	void *data;
-};
-
 static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -752,9 +746,6 @@ int xe_device_probe(struct xe_device *xe)
 	int err;
 	u8 id;
 
-	xe->probing = true;
-	INIT_LIST_HEAD(&xe->remove_action_list);
-
 	xe_pat_init_early(xe);
 
 	err = xe_sriov_init(xe);
@@ -904,8 +895,6 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_vsec_init(xe);
 
-	xe->probing = false;
-
 	return devm_add_action_or_reset(xe->drm.dev, xe_device_sanitize, xe);
 
 err_unregister_display:
@@ -916,72 +905,6 @@ int xe_device_probe(struct xe_device *xe)
 	return err;
 }
 
-/**
- * xe_device_call_remove_actions - Call the remove actions
- * @xe: xe device instance
- *
- * This is only to be used by xe_pci and xe_device to call the remove actions
- * while removing the driver or handling probe failures.
- */
-void xe_device_call_remove_actions(struct xe_device *xe)
-{
-	struct xe_device_remove_action *ra, *tmp;
-
-	list_for_each_entry_safe(ra, tmp, &xe->remove_action_list, node) {
-		ra->remove(xe, ra->data);
-		list_del(&ra->node);
-		kfree(ra);
-	}
-
-	xe->probing = false;
-}
-
-/**
- * xe_device_add_action_or_reset - Add an action to run on driver removal
- * @xe: xe device instance
- * @ra: pointer to the object embedded into the object to cleanup
- * @remove: function to execute. The @ra is passed as argument
- *
- * Example:
- *
- * .. code-block:: c
- *
- *	static void foo_remove(struct xe_device_remove_action *ra)
- *	{
- *		struct xe_foo *foo = container_of(ra, struct xe_foo, remove_action);
- *		...
- *	}
- *
- *	int xe_foo_init(struct xe_foo *foo)
- *	{
- *		...
- *		xe_device_add_remove_action(xe, &foo->remove_action, foo_remove);
- *		...
- *		return 0;
- *	};
- */
-int xe_device_add_action_or_reset(struct xe_device *xe,
-				  xe_device_remove_action_t action,
-				  void *data)
-{
-	struct xe_device_remove_action *ra;
-
-	drm_WARN_ON(&xe->drm, !xe->probing);
-
-	ra = kmalloc(sizeof(*ra), GFP_KERNEL);
-	if (!ra) {
-		action(xe, data);
-		return -ENOMEM;
-	}
-
-	INIT_LIST_HEAD(&ra->node);
-	ra->remove = action;
-	ra->data = data;
-	list_add(&ra->node, &xe->remove_action_list);
-
-	return 0;
-}
-
 void xe_device_remove(struct xe_device *xe)
 {
 	xe_display_unregister(xe);
@@ -991,8 +914,6 @@ void xe_device_remove(struct xe_device *xe)
 	xe_display_driver_remove(xe);
 
 	xe_heci_gsc_fini(xe);
-
-	xe_device_call_remove_actions(xe);
 }
 
 void xe_device_shutdown(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index a6fedf1ef3c7b..0bc3bc8e68030 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -45,10 +45,6 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent);
 int xe_device_probe_early(struct xe_device *xe);
 int xe_device_probe(struct xe_device *xe);
-int xe_device_add_action_or_reset(struct xe_device *xe,
-				  xe_device_remove_action_t action,
-				  void *data);
-void xe_device_call_remove_actions(struct xe_device *xe);
 void xe_device_remove(struct xe_device *xe);
 void xe_device_shutdown(struct xe_device *xe);
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index b322d49c83c77..833c29fed3a37 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -35,7 +35,6 @@
 #include "intel_display_device.h"
 #endif
 
-struct xe_device;
 struct xe_ggtt;
 struct xe_pat_ops;
 struct xe_pxp;
@@ -71,8 +70,6 @@ struct xe_pxp;
 		 const struct xe_tile * : (const struct xe_device *)((tile__)->xe),	\
 		 struct xe_tile * : (tile__)->xe)
 
-typedef void (*xe_device_remove_action_t)(struct xe_device *xe, void *data);
-
 /**
  * struct xe_vram_region - memory region structure
  * This is used to describe a memory region in xe
@@ -431,20 +428,6 @@ struct xe_device {
 	/** @tiles: device tiles */
 	struct xe_tile tiles[XE_MAX_TILES_PER_DEVICE];
 
-	/**
-	 * @remove_action_list: list of actions to execute on device remove.
-	 * Use xe_device_add_remove_action() for that. Actions can only be added
-	 * during probe and are executed during the call from PCI subsystem to
-	 * remove the driver from the device.
-	 */
-	struct list_head remove_action_list;
-
-	/**
-	 * @probing: cover the section in which @remove_action_list can be used
-	 * to post cleaning actions
-	 */
-	bool probing;
-
 	/**
 	 * @mem_access: keep track of memory access in the device, possibly
 	 * triggering additional actions when they occur.
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 41ec6825b9bcc..447eacb355d7c 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -900,10 +900,8 @@ static int xe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return err;
 
 	err = xe_device_probe(xe);
-	if (err) {
-		xe_device_call_remove_actions(xe);
+	if (err)
 		return err;
-	}
 
 	err = xe_pm_init(xe);
 	if (err)
-- 
2.48.1


