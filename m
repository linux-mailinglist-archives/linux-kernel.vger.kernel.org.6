Return-Path: <linux-kernel+bounces-196483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072308D5CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F2B288619
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0898152196;
	Fri, 31 May 2024 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGHiXMM3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86041514DB;
	Fri, 31 May 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144565; cv=none; b=CL+QQysemsn0H6aTB7Jpakv0aGwiySXYfjqAE7L9eo5kMKYZTOKD/sx/Joo4rMdGLUnAs5sg+h9eyrCGtsjqzY4YzAdhGN0PQ7q5wpKJoE1mSdfTEXBk4exDHbXybxLYDhooS6iSz5RsFIdVlEkFEFAlHYAtE8zwHl1ixT1lIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144565; c=relaxed/simple;
	bh=AjD0KgKUTNk/qht295XZG6rAGKTm2KqnG8awsW8O1ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYqOxRODuJvqJy/W6HCyauXUK1z5lsdaWNEWJCaOHSNoUrgnzinSwkAKZe6fOofriI9Z1tdojfY+ed8slI6vR3SThHKpyowJpgMx1IZWTfZJuOX6BIuJdKAzGHnWKPIE2f4CT+QVcy1u9rAaw4+NtyPU1wNbdeHX0ffBqeOiIg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGHiXMM3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717144564; x=1748680564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjD0KgKUTNk/qht295XZG6rAGKTm2KqnG8awsW8O1ow=;
  b=mGHiXMM3uItbSmdmn5R+Fm9hxLlriJUf0jc3S0H+FwFEX6U2T77wE+VH
   xb9Pqhswipw5rJPeIoz/aDYTkBp8mDcGVoiyCUxUdIkiv0CuqiReSeSE+
   yfcwC7BL1jH+i+FQAI+OBxia5PfzTxhQqV/EprJbMwg7GqMCrMFHtfn6h
   /GuP1OVcdBQkTC8tH6qvXHbmVKIcvQuSsmv3znwnypJBLGbfv8uR9TGTg
   6BEGrGFQt4JKq3In2x6DQDkbX8P2i7axGOU2BbiSTliqpAE18TTy6ziK1
   IOyjZ8ZD4LZYAX51fn+Vk9mP/2t6ZK/7UUmqGNnTzC/0v6PJnxCJpnY9e
   g==;
X-CSE-ConnectionGUID: lc/f5RZ5QKKq/osUW5FWjw==
X-CSE-MsgGUID: C1nU6ZZIQjSwkykIltOvuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13495954"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13495954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 01:36:00 -0700
X-CSE-ConnectionGUID: qjIXNYGLS7muvdOWx6t1XQ==
X-CSE-MsgGUID: 8xIiutGhSgO7Onbd+mLuhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36193455"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2024 01:36:00 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	rui.zhang@intel.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] platform/x86: ISST: Use only TPMI interface when present
Date: Fri, 31 May 2024 01:35:48 -0700
Message-ID: <20240531083554.1313110-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
References: <20240531083554.1313110-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the TPMI interface is present, use this interface instead of legacy.
On some systems legacy IO device is also present. Using both interfaces
together is confusing and may set the hardware in inconsistent state.

When TPMI interface is present, don't load legacy drivers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Previously 2/2, now 3/3
No change except reviewed-by Ilpo.

 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 7ea058571ab5..10e21563fa46 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -775,6 +775,9 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 	if (device_type >= ISST_IF_DEV_MAX)
 		return -EINVAL;
 
+	if (device_type < ISST_IF_DEV_TPMI && isst_hpm_support)
+		return -ENODEV;
+
 	mutex_lock(&punit_misc_dev_open_lock);
 	/* Device is already open, we don't want to add new callbacks */
 	if (misc_device_open) {
-- 
2.40.1


