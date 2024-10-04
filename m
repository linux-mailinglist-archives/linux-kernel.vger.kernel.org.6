Return-Path: <linux-kernel+bounces-350116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEFF990016
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CDA1F24633
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE66155336;
	Fri,  4 Oct 2024 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CU0NBOOO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E154C18
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034901; cv=none; b=aJe3zxuFEFI2ToMFcRhtKNy8C9T1Tk7wak/Eh4cx+31fo1LMTblkJWQJoSALxILJOLwiVmng3mE27xQiKLROeB4LyVQwpLtupiq0dH9yYeRYeo98UMrXrVxOku+QMdR2QSR5Z17iAIdHJzwCurCLNkXrUWyXb1e38E64S/xEI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034901; c=relaxed/simple;
	bh=USG40SMQqbMviTDnCXPrAjwV57OJxqRrTUVV+A1CVBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guzpkm65yuHafpn3NF5EF/5XJorw9+RWVyrL4GmDjSv5KNQ8w8UZq5Gm6OJ3DoCxZPUaUnRZpnFCqFNiapZ+BEbawxWVVgpCsLG9pr/AcvLjcCDvNK+G6/H2k36chKrECBDaMV8wLojzog+pg+MZnH9Xw59XZsbg1dXGmk260AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CU0NBOOO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034899; x=1759570899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=USG40SMQqbMviTDnCXPrAjwV57OJxqRrTUVV+A1CVBo=;
  b=CU0NBOOOmVvtIb0ua/RQDAwPDOgFPAjoSrqG2Zd4I03dmszR93GMDcqq
   kud8015Z45/Za9AzUzk7rh2D/Y8ImrNcWcMP7rx1HmnkaZvCzm9HWGqcJ
   LwgmGL+Bx0k138iULCe/iCIY08/nAG4hmR/Ay/M92Gg7n2M5yBCWAjQgb
   fnV4PXC5U5ymeezuYJXLJBCMA7r8hyeWSnZ4rALy1Hdx1E+V8/mGMUB6N
   r7XLWxRKOkyV8n3UcoZGxO9yGQVNAvl6CCGP5Ic3iZV4wQhUtg9dsREDs
   Y6LS0p5I8YBQtFkf6GQlQ+4cTKC1MiclifDbWlhs5aIwROQ+GfZ6p9Cxk
   Q==;
X-CSE-ConnectionGUID: 22avtUK7SJ6DA1RsEm59Ow==
X-CSE-MsgGUID: rJ1AYfwZRZypfrsJKli8Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656245"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656245"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:37 -0700
X-CSE-ConnectionGUID: I4OqSpfBQn6Y+wpmMpipZA==
X-CSE-MsgGUID: N2L4ClLGSt2MWFiIxcQx7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975090"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:36 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id B364811FA28;
	Fri,  4 Oct 2024 12:41:33 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoX-000Tbs-2J;
	Fri, 04 Oct 2024 12:41:33 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 27/51] mei: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:33 +0300
Message-Id: <20241004094133.113810-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/client.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516..fcdf62400a50 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1014,7 +1014,7 @@ int mei_cl_disconnect(struct mei_cl *cl)
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 
 	return rets;
 }
@@ -1190,7 +1190,7 @@ int mei_cl_connect(struct mei_cl *cl, struct mei_me_client *me_cl,
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 
 	mei_io_cb_free(cb);
 
@@ -1577,7 +1577,7 @@ int mei_cl_notify_request(struct mei_cl *cl,
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 
 	mei_io_cb_free(cb);
 	return rets;
@@ -1725,7 +1725,7 @@ int mei_cl_read_start(struct mei_cl *cl, size_t length, const struct file *fp)
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 nortpm:
 	if (rets)
 		mei_io_cb_free(cb);
@@ -2115,7 +2115,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
 err:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 free:
 	mei_io_cb_free(cb);
 
@@ -2389,7 +2389,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 
 	mei_io_cb_free(cb);
 	return rets;
@@ -2467,7 +2467,7 @@ int mei_cl_dma_unmap(struct mei_cl *cl, const struct file *fp)
 out:
 	cl_dbg(dev, cl, "rpm: autosuspend\n");
 	pm_runtime_mark_last_busy(dev->dev);
-	pm_runtime_put_autosuspend(dev->dev);
+	__pm_runtime_put_autosuspend(dev->dev);
 
 	mei_io_cb_free(cb);
 	return rets;
-- 
2.39.5


