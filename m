Return-Path: <linux-kernel+bounces-190728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD848D0209
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 873A6B29267
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97EA161920;
	Mon, 27 May 2024 13:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRl7QEkr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB384161337;
	Mon, 27 May 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816859; cv=none; b=dCgfmBuFkBxajDCuLMqWZSFyzLKu8FeIAtuKkZDQx7JlVXxOFJn9PC0KxTh9ME0XKOc9ISn76qEd8M/3DSkaVGI6yi0C0L/evpWQ5veQC/RZ4YXvjxFCrOTGYDszCq/ECrYTGlXU+Gp88ZS0wNBdpoM764J49pRYJij4dcyj1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816859; c=relaxed/simple;
	bh=oAYpfPyONrBoi3el/ojRvweH3QWlcxgfAJBc0S4l784=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhP8VethiXOHopXPXxYdoZ3Bf+pjQ+d7JXL5c7gnutVCw34ZS9HH4BfdGPIzAb2mSDTLqvJzeY0pXnfuqHGJ6XJnTcQwNiac+uFbZMI8kGKNCdUKJ1aW7H5+CSxRUQOcGERYUxada88dZP4zdvXJi7DcHV/t8qBZmwEYeEw/r6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRl7QEkr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816858; x=1748352858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oAYpfPyONrBoi3el/ojRvweH3QWlcxgfAJBc0S4l784=;
  b=fRl7QEkrFLN8GT/C2pKlZa5IJwYDBBSSEohB0jWw1An7GfiWzjsYmvD4
   Uc6VV+qj4f8ccX8SKmakQqGosvKO82Xx2MD/55AVcXZ6d0zbqKgDzdDHc
   ZYiD9h+PrnmGjij9ukL5CgU6Ddrc9lSSrDsyLZ8fGmCw1KOzWncVP1ivm
   geyqfms3Q4bM96hbQKooyeShrnrgp4QKIHI26RCTO8NzaABBOZXJN41ZY
   k54VkIBbjagmMt+jFnctrZiJDpyVEzUaWRJ7j6uZ2AsM5o/VtydpSmvSs
   QJGyHf4mDS8F0qAu4uxMtCa8J6ZqpvhWUw7rjUuTmPMIHIUmaKSAAnPeF
   g==;
X-CSE-ConnectionGUID: 4B/eIP1RQYayyAST1fOpyQ==
X-CSE-MsgGUID: UPMCC83eSUWC4aYYkCEBjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="11714375"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11714375"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:17 -0700
X-CSE-ConnectionGUID: Q9lznOfnSwO5OoPndgmoPQ==
X-CSE-MsgGUID: ChExoITsR0iFjVDtq6tLoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34847975"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.180])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:34:15 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/6] platform/x86/intel/tpmi: Add API to get debugfs root
Date: Mon, 27 May 2024 16:29:34 +0300
Message-ID: <20240527133400.483634-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527133400.483634-1-tero.kristo@linux.intel.com>
References: <20240527133400.483634-1-tero.kristo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add new API to get the debugfs root directory for TPMI. This allows any
TPMI devices to add their own debugfs items under the same directory
structure.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/platform/x86/intel/tpmi.c | 9 +++++++++
 include/linux/intel_tpmi.h        | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index c2ef2cd587ba..83e8b1fe53b3 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -357,6 +357,15 @@ int tpmi_get_feature_status(struct auxiliary_device *auxdev,
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
 
+struct dentry *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev)
+{
+	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
+	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
+
+	return tpmi_info->dbgfs_dir;
+}
+EXPORT_SYMBOL_NS_GPL(tpmi_get_debugfs_dir, INTEL_TPMI);
+
 static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 {
 	struct intel_tpmi_info *tpmi_info = s->private;
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index a88ac937d2c2..ff480b47ae64 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -54,4 +54,5 @@ struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, bool *read_blocked,
 			    bool *write_blocked);
+struct dentry *tpmi_get_debugfs_dir(struct auxiliary_device *auxdev);
 #endif
-- 
2.43.1


