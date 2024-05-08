Return-Path: <linux-kernel+bounces-173483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D408C00EC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1F7281A13
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883A7E0F0;
	Wed,  8 May 2024 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOm+oVcp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBAD128394
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182032; cv=none; b=KvkHZQn8o8v9NHGiEztuJDV4WQHPerwo/xlHLCB9qbxsuKAihTFrAstlO95A4aNQGmolajusj85EmaSgm4O/qermwjI0eBYOBfVvb4dDTbJ40e0kyMa9YykV8Kd9IwsLVPl79qCVsNr+E2ztQAw84KtDNXzMcYdAFnlBBYQ6p6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182032; c=relaxed/simple;
	bh=ItL86uGAqwtSHzvV7e4Z98MypI8As0zBjnzHJ4JD/+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E98Yzvt1G7wpLP1EnMT03AO1eFmHp5WbcUPJH6VOtYW0d966Ghn+zG+5t8obuWaDmGoT2y/9ZJYPl48+1m01RtJC7hSw7kaBNO3RpsJFmgfSnUgPGXJXQw1Qqs49Dqu8u8Z3Am55Umv9/MIK5DMxqqtFaUDsVEH66qNiDdJ9tjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOm+oVcp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715182026; x=1746718026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ItL86uGAqwtSHzvV7e4Z98MypI8As0zBjnzHJ4JD/+Y=;
  b=dOm+oVcptQSHYPRl4c6XlqEvrKHYUWZutkXiuUK1btFrnX4OLb3dk7ZJ
   P3noLjOYtDCoNkWdBs8LMGC81vEim2ow0K0AnpSStA20tC9wVEH1pMDzX
   aOND+fyeUAY+ZlgDnIxbRyy3mmlzzX/eDJAZKXWpKg6EuvdpyXCnBCYE1
   o+cDLgrUEL1VNYnoHaxL28i20OaM0OvZdRikILZrW1obhgvrl8BsA48b9
   QAMk2TWR7cJ5RbUHMVqhlK2XJq1KxF1eymZtrS+s9h5CFSGQh2lYtotMg
   hkC+B4x6N8P6g9mJIWzroXarbYsqOZkiLLyxfRcLOaao9HrwmDh4bBqu6
   w==;
X-CSE-ConnectionGUID: 8rp5oB4CT9a485hLh/rfIA==
X-CSE-MsgGUID: NlGaFvOzRR2GvmFs01oIcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11429086"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11429086"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 08:27:05 -0700
X-CSE-ConnectionGUID: MYnSKQ2/RdCXHfHJiF7k9w==
X-CSE-MsgGUID: U96b3+4LRi2AqLykBsphWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28851881"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 08 May 2024 08:27:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E52E2109; Wed, 08 May 2024 18:27:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v1 1/1] xen/xenbus: Use *-y instead of *-objs in Makefile
Date: Wed,  8 May 2024 18:26:47 +0300
Message-ID: <20240508152658.1445809-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*-objs suffix is reserved rather for (user-space) host programs while
usually *-y suffix is used for kernel drivers (although *-objs works
for that purpose for now).

Let's correct the old usages of *-objs in Makefiles.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Note, the original approach is weirdest from the existing.
Only a few drivers use this (-objs-y) one most likely by mistake.

 drivers/xen/xenbus/Makefile | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/xen/xenbus/Makefile b/drivers/xen/xenbus/Makefile
index 0c7532110815..b0d69602214e 100644
--- a/drivers/xen/xenbus/Makefile
+++ b/drivers/xen/xenbus/Makefile
@@ -1,15 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y	+= xenbus.o
+
+xenbus-y := xenbus_client.o
+xenbus-y += xenbus_comms.o
+xenbus-y += xenbus_xs.o
+xenbus-y += xenbus_probe.o
+
+xenbus-$(CONFIG_XEN_BACKEND) += xenbus_probe_backend.o
+
 obj-y	+= xenbus_dev_frontend.o
-
-xenbus-objs =
-xenbus-objs += xenbus_client.o
-xenbus-objs += xenbus_comms.o
-xenbus-objs += xenbus_xs.o
-xenbus-objs += xenbus_probe.o
-
-xenbus-be-objs-$(CONFIG_XEN_BACKEND) += xenbus_probe_backend.o
-xenbus-objs += $(xenbus-be-objs-y)
-
 obj-$(CONFIG_XEN_BACKEND) += xenbus_dev_backend.o
 obj-$(CONFIG_XEN_XENBUS_FRONTEND) += xenbus_probe_frontend.o
-- 
2.43.0.rc1.1336.g36b5255a03ac


