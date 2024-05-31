Return-Path: <linux-kernel+bounces-196543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA58D5DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349BFB28AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C4156C67;
	Fri, 31 May 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7J122fB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E65158878
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146315; cv=none; b=dOORs+D/1RSALmyvNgZQ5o+I0DTGcyZ+OW7WDDdr1owvK2cGtoRmJoNGF4Br8fQj0VwnQd++b/X/2y4cWglolCz3Ru+SYB+xH53iSGL43gUL4JaCphkFHwwa+RZoTH+o3ngirHe3EcBb2/5U7OuTX2RBeCi1DDJU46sAj9kGNX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146315; c=relaxed/simple;
	bh=TFgdIL/o05mXh9mn/TW+lrAw5f/LmbhsEY4ucnUQogs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NT8xaFZmAYScnYTg3d0zSBK/p8GnxoOfPv7jZ4PiJ5iRaTDDxfx1yftQNquAnDPBR8UUZWUotnsPu7x3YyV/WK/tGFV/xN+5ml0rY4tLGV0hx07BDL4HUlo2/mVU0sqbWCgO2/lLaJk+3G53TIBCMDx7dFtS8JPnKFEWPWjySFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7J122fB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146314; x=1748682314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFgdIL/o05mXh9mn/TW+lrAw5f/LmbhsEY4ucnUQogs=;
  b=l7J122fBBGFjsZVXFSaBy4apA5ld+FKceBQbCk9FIqt8zO5tGLHA73Nn
   chpN9NcXOpEqs9rU3JzSo7rXEU24xMahfaUKmnjTOhHNpo6WBy7t/2qHW
   ICCVbX6ZCPscx3ScEj2FzhumfiiKKQ/nJleKIZiW9bJNM8IKmWXNpbYpn
   WgpdTc8F0SAWdMBmrl5QivvRxfrbvmV3zDOvDc8yvQPF55ky0H/bb9ekb
   7Cu1DoXJpyreclKYlGLm/QMGXD4fQHuUQUYrMkSv518EesUYV2sZBpfRL
   E8xULbso2a7wF78C5UOh7rgZMdCA+Jp+zpAXgVMuzTmWCL2EC+g6a/gyN
   w==;
X-CSE-ConnectionGUID: vzSRiIvRTHarPRm+hhm5dQ==
X-CSE-MsgGUID: kh11MXO6QUSfYN9yl9AuOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39074070"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="39074070"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:14 -0700
X-CSE-ConnectionGUID: 411iwXpMQuSVAaztMpV0eQ==
X-CSE-MsgGUID: xOKqWE8HQ+Gs8qdTnY/tPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40543240"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:12 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 2/4] kernel/panic: convert print_tainted() to use struct seq_buf internally
Date: Fri, 31 May 2024 12:04:55 +0300
Message-Id: <cb6006fa7c0f82a6b6885e8eea2920fcdc4fc9d0.1717146197.git.jani.nikula@intel.com>
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

Convert print_tainted() to use struct seq_buf internally in order to be
more aware of the buffer constraints as well as make it easier to extend
in follow-up work.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 kernel/panic.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 5c9396418e1c..b7b2fb8b3625 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/sysfs.h>
 #include <linux/context_tracking.h>
+#include <linux/seq_buf.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -497,6 +498,25 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_TEST ]			= { 'N', ' ', true },
 };
 
+static void print_tainted_seq(struct seq_buf *s)
+{
+	int i;
+
+	if (!tainted_mask) {
+		seq_buf_puts(s, "Not tainted");
+		return;
+	}
+
+	seq_buf_printf(s, "Tainted: ");
+	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
+		const struct taint_flag *t = &taint_flags[i];
+		bool is_set = test_bit(i, &tainted_mask);
+		char c = is_set ? t->c_true : t->c_false;
+
+		seq_buf_putc(s, c);
+	}
+}
+
 /**
  * print_tainted - return a string to represent the kernel taint state.
  *
@@ -508,25 +528,15 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 const char *print_tainted(void)
 {
 	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
-	char *s;
-	int i;
+	struct seq_buf s;
 
 	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
 
-	if (!tainted_mask) {
-		snprintf(buf, sizeof(buf), "Not tainted");
-		return buf;
-	}
+	seq_buf_init(&s, buf, sizeof(buf));
 
-	s = buf + sprintf(buf, "Tainted: ");
-	for (i = 0; i < TAINT_FLAGS_COUNT; i++) {
-		const struct taint_flag *t = &taint_flags[i];
-		*s++ = test_bit(i, &tainted_mask) ?
-			t->c_true : t->c_false;
-	}
-	*s = 0;
+	print_tainted_seq(&s);
 
-	return buf;
+	return seq_buf_str(&s);
 }
 
 int test_taint(unsigned flag)
-- 
2.39.2


