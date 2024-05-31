Return-Path: <linux-kernel+bounces-196546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9CC8D5DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8538D1C24BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22173158D98;
	Fri, 31 May 2024 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+0lQjkh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4313156F20
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146326; cv=none; b=oP/lVUWPckRph7uk/Oho0T+7skTgl9OvZDD6t59HdUuqkcYfhoJj6ZIHnoBOnqLOdrLhxeK1HdD+2LYKhbcNBHCi82nHQqEYdUoJbY0VTUN3ZJ2/ukB/F8fAFBuFVnMF7TJXkFLFWOxCrYa2lY5BqEH2x50UKwflsrwI/fB99tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146326; c=relaxed/simple;
	bh=T30Nd2PdPbzDqMDHg57Y0dcrPInQXZHw0rwiqt2FO94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sD34uo2DnuEG8sDe0IG6yU1c7dZMQIp5f6ksXg3bifiQfyfkkuGpKcwmiAyBWMTrrBc8JrCM7IMOdmRuf6tTdg23Rgj2f45bqPaXZ4U85rXy2F7r0hZFxdEh3rbz8oF0+PXah+UyyWGpQxhr8C9HqnTHmlMprFIFgZPUd7UDU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+0lQjkh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717146325; x=1748682325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T30Nd2PdPbzDqMDHg57Y0dcrPInQXZHw0rwiqt2FO94=;
  b=E+0lQjkhmUfaiIaHuXy5A+9ZBAn74baZxdAm0Y/dH8s+xK97Vj5GdTJQ
   2qEbvNgaINHlDarKv71P4m6mdEDuQAiZWa1KAElDvH9s5qvWo5U+lXAuw
   eH5QqRFyFrDH0ieZaMjs9Y++Ac75oD7zKf1q+2pV2mkFJudJrcUUEbYPs
   +llfWlo9M0+DbymIrjMYRkZHOpY1MNH4RRGvePGz8qlApRD9U1F1GuJF+
   wGk6jG4sjOtZvLN+V+2m3VZvq2dD5RI55V8EJZtvYEJKdYMV16ASpQgAR
   PlOJKk+/aWmEFMFEdr4Q/a5ew6ac1rItcGVrmXBT5/YQqm6GJwF30SvqN
   w==;
X-CSE-ConnectionGUID: Pobw1BBtRuS3GEPxv1r1aQ==
X-CSE-MsgGUID: 7S4CBYy4SRaxsdFmSgDjXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="39074088"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="39074088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:24 -0700
X-CSE-ConnectionGUID: OryVlFjhQYuJzdh1bD8L9Q==
X-CSE-MsgGUID: JtkIRRQETMON7xeoJg0Vuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="40543256"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.190])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:05:23 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 4/4] kernel/panic: add verbose logging of kernel taints in backtraces
Date: Fri, 31 May 2024 12:04:57 +0300
Message-Id: <7321e306166cb2ca2807ab8639e665baa2462e9c.1717146197.git.jani.nikula@intel.com>
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

With nearly 20 taint flags and respective characters, it's getting a bit
difficult to remember what each taint flag character means. Add verbose
logging of the set taints in the format:

Tainted: [P]=PROPRIETARY_MODULE, [W]=WARN

in dump_stack_print_info() when there are taints.

Note that the "negative flag" G is not included.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 include/linux/panic.h |  8 +++++---
 kernel/panic.c        | 45 ++++++++++++++++++++++++++++++++-----------
 lib/dump_stack.c      |  3 +++
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 6717b15e798c..3130e0b5116b 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -77,9 +77,10 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
 #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
 
 struct taint_flag {
-	char c_true;	/* character printed when tainted */
-	char c_false;	/* character printed when not tainted */
-	bool module;	/* also show as a per-module taint flag */
+	char c_true;		/* character printed when tainted */
+	char c_false;		/* character printed when not tainted */
+	bool module;		/* also show as a per-module taint flag */
+	const char *desc;	/* verbose description of the set taint flag */
 };
 
 extern const struct taint_flag taint_flags[TAINT_FLAGS_COUNT];
@@ -90,6 +91,7 @@ enum lockdep_ok {
 };
 
 extern const char *print_tainted(void);
+extern const char *print_tainted_verbose(void);
 extern void add_taint(unsigned flag, enum lockdep_ok);
 extern int test_taint(unsigned flag);
 extern unsigned long get_taint(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 8f7bb94ad7d8..a914f2fcf9ad 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -476,6 +476,7 @@ EXPORT_SYMBOL(panic);
 	[ TAINT_##taint ] = {						\
 		.c_true = _c_true, .c_false = _c_false,			\
 		.module = _module,					\
+		.desc = #taint,						\
 	}
 
 /*
@@ -506,8 +507,9 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 
 #undef TAINT_FLAG
 
-static void print_tainted_seq(struct seq_buf *s)
+static void print_tainted_seq(struct seq_buf *s, bool verbose)
 {
+	const char *sep = "";
 	int i;
 
 	if (!tainted_mask) {
@@ -521,10 +523,32 @@ static void print_tainted_seq(struct seq_buf *s)
 		bool is_set = test_bit(i, &tainted_mask);
 		char c = is_set ? t->c_true : t->c_false;
 
-		seq_buf_putc(s, c);
+		if (verbose) {
+			if (is_set) {
+				seq_buf_printf(s, "%s[%c]=%s", sep, c, t->desc);
+				sep = ", ";
+			}
+		} else {
+			seq_buf_putc(s, c);
+		}
 	}
 }
 
+static const char *_print_tainted(bool verbose)
+{
+	/* FIXME: what should the size be? */
+	static char buf[sizeof(taint_flags)];
+	struct seq_buf s;
+
+	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
+
+	seq_buf_init(&s, buf, sizeof(buf));
+
+	print_tainted_seq(&s, verbose);
+
+	return seq_buf_str(&s);
+}
+
 /**
  * print_tainted - return a string to represent the kernel taint state.
  *
@@ -535,16 +559,15 @@ static void print_tainted_seq(struct seq_buf *s)
  */
 const char *print_tainted(void)
 {
-	static char buf[TAINT_FLAGS_COUNT + sizeof("Tainted: ")];
-	struct seq_buf s;
-
-	BUILD_BUG_ON(ARRAY_SIZE(taint_flags) != TAINT_FLAGS_COUNT);
-
-	seq_buf_init(&s, buf, sizeof(buf));
-
-	print_tainted_seq(&s);
+	return _print_tainted(false);
+}
 
-	return seq_buf_str(&s);
+/**
+ * print_tainted_verbose - A more verbose version of print_tainted()
+ */
+const char *print_tainted_verbose(void)
+{
+	return _print_tainted(true);
 }
 
 int test_taint(unsigned flag)
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 222c6d6c8281..8b6b70eaf949 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -62,6 +62,9 @@ void dump_stack_print_info(const char *log_lvl)
 	       (int)strcspn(init_utsname()->version, " "),
 	       init_utsname()->version, BUILD_ID_VAL);
 
+	if (get_taint())
+		printk("%s%s\n", log_lvl, print_tainted_verbose());
+
 	if (dump_stack_arch_desc_str[0] != '\0')
 		printk("%sHardware name: %s\n",
 		       log_lvl, dump_stack_arch_desc_str);
-- 
2.39.2


