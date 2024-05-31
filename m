Return-Path: <linux-kernel+bounces-196545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007F58D5DBB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D9F1C253D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CD6158D80;
	Fri, 31 May 2024 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHJdEKCc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD778158A37
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146321; cv=none; b=vEF/iikVts0yvj6+SrnCmlDkADXCCLZJnmjqfjBan59xECwTmRHduYAYT+XKiM/GbGN/XwykE46uhFjLzkxWDPX0updVpOR6WNkAOQcdhM6WdOVcRc+FLOxMmU5cPDHfcLnctHidqnK5L0oW1l9AwrmvLxmdX7HBa+kOouJgrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146321; c=relaxed/simple;
	bh=OPnQwap98xBOvs4o2m86J9Ax9g2AZnbnCVbcpM6vIJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6GYP+0vAKk1oOB+U+LBNmnVwAXUNlxkPYyLptS/l7QERq5UzWqaUMV+jmFNNonuIiXrvubPUbOHDl6qQpIaHnLDQwaPOGmEgyivFk4JQvUX4isTjkGyi0AvnEhLCqDpH8MinLYRMhp2oeuSbyV/dyfsFMMdBNDjxPLejkWFjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHJdEKCc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146320; x=1748682320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OPnQwap98xBOvs4o2m86J9Ax9g2AZnbnCVbcpM6vIJ0=;
  b=KHJdEKCcxhbaRpUQzMrzH3v7FgUH0JfG+2XMRHaIZV6pXvB4aUF8Wd0S
   VscKmZ+l+SpdNgmFoH4tps2GFWJg6bJzmXDB0NAuQsx4UPK7dvhSgNUL+
   INfNQEezEsNO1v0pGaQI3HI3IeaXd7xPH1t2w3mqHPIC93MOiZxPgZQsl
   aiSAwXlMwHydlrStFrrTC7woomztP+3VQ7C4pI2BkW6x+EZIVEV8GTvx1
   MHoQsLSa+dbSg1H4QReu52BceHmiUGxHQNTqSBPJRIxUyN1+kwhr4Vkmh
   W3+Ch1Rr2qbRGokMRw7xzQRoGsOQHtJ+7kw4TuwlWkscm8uRhipztGLNL
   g==;
X-CSE-ConnectionGUID: omXNirCJSE2JI8VYEyXeTg==
X-CSE-MsgGUID: CJNFdUlUTMGh7vCPVBhdrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39074080"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="39074080"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:19 -0700
X-CSE-ConnectionGUID: hLsLMt6fRJiqvdVEDx9SHQ==
X-CSE-MsgGUID: m+mfIFVoSXiBYvm6tFRHRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40543249"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:18 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 3/4] kernel/panic: initialize taint_flags[] using a macro
Date: Fri, 31 May 2024 12:04:56 +0300
Message-Id: <8a2498285d37953cfad9dce939ed3abef61051bd.1717146197.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1717146197.git.jani.nikula@intel.com>
References: <cover.1717146197.git.jani.nikula@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

Make it easier to extend struct taint_flags in follow-up.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 46 +++++++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index b7b2fb8b3625..8f7bb94ad7d8 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -472,32 +472,40 @@ void panic(const char *fmt, ...)
 
 EXPORT_SYMBOL(panic);
 
+#define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
+	[ TAINT_##taint ] = {						\
+		.c_true = _c_true, .c_false = _c_false,			\
+		.module = _module,					\
+	}
+
 /*
  * TAINT_FORCED_RMMOD could be a per-module flag but the module
  * is being removed anyway.
  */
 const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
-	[ TAINT_PROPRIETARY_MODULE ]	= { 'P', 'G', true },
-	[ TAINT_FORCED_MODULE ]		= { 'F', ' ', true },
-	[ TAINT_CPU_OUT_OF_SPEC ]	= { 'S', ' ', false },
-	[ TAINT_FORCED_RMMOD ]		= { 'R', ' ', false },
-	[ TAINT_MACHINE_CHECK ]		= { 'M', ' ', false },
-	[ TAINT_BAD_PAGE ]		= { 'B', ' ', false },
-	[ TAINT_USER ]			= { 'U', ' ', false },
-	[ TAINT_DIE ]			= { 'D', ' ', false },
-	[ TAINT_OVERRIDDEN_ACPI_TABLE ]	= { 'A', ' ', false },
-	[ TAINT_WARN ]			= { 'W', ' ', false },
-	[ TAINT_CRAP ]			= { 'C', ' ', true },
-	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
-	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
-	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
-	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
-	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
-	[ TAINT_AUX ]			= { 'X', ' ', true },
-	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
-	[ TAINT_TEST ]			= { 'N', ' ', true },
+	TAINT_FLAG(PROPRIETARY_MODULE,		'P', 'G', true),
+	TAINT_FLAG(FORCED_MODULE,		'F', ' ', true),
+	TAINT_FLAG(CPU_OUT_OF_SPEC,		'S', ' ', false),
+	TAINT_FLAG(FORCED_RMMOD,		'R', ' ', false),
+	TAINT_FLAG(MACHINE_CHECK,		'M', ' ', false),
+	TAINT_FLAG(BAD_PAGE,			'B', ' ', false),
+	TAINT_FLAG(USER,			'U', ' ', false),
+	TAINT_FLAG(DIE,				'D', ' ', false),
+	TAINT_FLAG(OVERRIDDEN_ACPI_TABLE,	'A', ' ', false),
+	TAINT_FLAG(WARN,			'W', ' ', false),
+	TAINT_FLAG(CRAP,			'C', ' ', true),
+	TAINT_FLAG(FIRMWARE_WORKAROUND,		'I', ' ', false),
+	TAINT_FLAG(OOT_MODULE,			'O', ' ', true),
+	TAINT_FLAG(UNSIGNED_MODULE,		'E', ' ', true),
+	TAINT_FLAG(SOFTLOCKUP,			'L', ' ', false),
+	TAINT_FLAG(LIVEPATCH,			'K', ' ', true),
+	TAINT_FLAG(AUX,				'X', ' ', true),
+	TAINT_FLAG(RANDSTRUCT,			'T', ' ', true),
+	TAINT_FLAG(TEST,			'N', ' ', true),
 };
 
+#undef TAINT_FLAG
+
 static void print_tainted_seq(struct seq_buf *s)
 {
 	int i;
-- 
2.39.2


