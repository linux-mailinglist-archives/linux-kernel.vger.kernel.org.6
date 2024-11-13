Return-Path: <linux-kernel+bounces-408010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 587199C78D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9DA284A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E50165F01;
	Wed, 13 Nov 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYlow0+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B211632D3;
	Wed, 13 Nov 2024 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515190; cv=none; b=BKZePmtfp2jJByuHfLKIF0KCld1GEBMYk+sIusHN+SyG5MIV7wBNnZNikV/h1f7xJQkYDmb3itys/9pPBExSrzzbho5ORaiWLdcstCTEQjVhS54WKFcrsQEnY1NcN4VgHMbeAmXSXNqu6WKuqowPbdZYTwrYLBUtT0bJORgTxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515190; c=relaxed/simple;
	bh=BtvEp8Hm0X4D/xEUdKSvN4oIcwKIlo21XvAkEr+HAVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUxF3e3td0j/9TcLFDZgQ9eOyzMNCevhnesqUMEjoG6pHkAFhOL61j/GF11uzJ3GVvImefW1yKAisbjyP7YemSNWE1QA2CCBZJkjzk3yp+U7bgUDVSvDiXd65RkRcv9GUxHqIN0Q30fV80UCHPJfa/e2PWXwqXZ2FEIwrvzw4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYlow0+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF9C4CECD;
	Wed, 13 Nov 2024 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515190;
	bh=BtvEp8Hm0X4D/xEUdKSvN4oIcwKIlo21XvAkEr+HAVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AYlow0+U+zO+aZXFbzwnd2OZtD+GE1+1VHKHCBaOrZOupvzfnbZdIb0euKEF6f3DW
	 5kfguUwtgM01VM4jOY223QyQIrLAk4i5A/rj9LpC9q1xclbtlOktOguask3j01aiCS
	 ZytVYb2FVyh6gVIKErHiqL1WCujCStmIkhjO8TXLkXlT93afkYD6Ze1V+jaZ0VxUjn
	 n4jDaj+To31z1/Ym/XQ1AfcG9Bmnin7XdGsaWpe7puLMxTLLRNGFPbN+T2Gp25sef6
	 6VA7QkuEFHga2/argeI5lNYX5TN7PxLVPeZVB6lMQeIDNV+aREBy7904it3sQu6SU9
	 a7ebxVB/nHapQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 1/5] samples: introduce a skeleton of a sample DAMON module for working set size estimation
Date: Wed, 13 Nov 2024 08:26:20 -0800
Message-Id: <20241113162624.48973-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241113162624.48973-1-sj@kernel.org>
References: <20241113162624.48973-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a skeleton for a sample DAMON module that can be used for estimating
working set size of a given process.  It exposes two module parameters,
namely 'pid' and 'enable', which receives what process the module should
estimate the working set size of, and whether to start the work or not.
Nonetheless, because this is just a skeleton, no real work is
implemented.  The functionality will be implemented by following
commits.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS            |  1 +
 samples/Kconfig        |  2 ++
 samples/Makefile       |  1 +
 samples/damon/Kconfig  | 17 +++++++++++
 samples/damon/Makefile |  3 ++
 samples/damon/wsse.c   | 69 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+)
 create mode 100644 samples/damon/Kconfig
 create mode 100644 samples/damon/Makefile
 create mode 100644 samples/damon/wsse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0383fd7e0a40..d61f4f76c3d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6256,6 +6256,7 @@ F:	Documentation/mm/damon/
 F:	include/linux/damon.h
 F:	include/trace/events/damon.h
 F:	mm/damon/
+F:	samples/damon/
 F:	tools/testing/selftests/damon/
 
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..8d5a36f0e5d6 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,8 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+source "samples/damon/Kconfig"
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..726bb5293486 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
new file mode 100644
index 000000000000..b799e01345c8
--- /dev/null
+++ b/samples/damon/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "DAMON Samples"
+
+config SAMPLE_DAMON_WSSE
+	bool "DAMON sameple module for working set size estimation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for working set size estimation.
+
+	  The module receives a pid, monitor access to the virtual address
+	  space of the process, estimate working set size of the process, and
+	  repeatedly prints the size on the kernel log.
+
+	  If unsure, say N.
+
+endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
new file mode 100644
index 000000000000..ccbe93d40130
--- /dev/null
+++ b/samples/damon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
new file mode 100644
index 000000000000..5912f15181c8
--- /dev/null
+++ b/samples/damon/wsse.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * working set size estimation: monitor access pattern of given process and
+ * print estimated working set size (total size of regions that showing some
+ * access).
+ */
+
+#define pr_fmt(fmt) "damon_sample_wsse: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int target_pid __read_mostly;
+module_param(target_pid, int, 0600);
+
+static int damon_sample_wsse_enable_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enable_param_ops = {
+	.set = damon_sample_wsse_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enable __read_mostly;
+module_param_cb(enable, &enable_param_ops, &enable, 0600);
+MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
+
+static int damon_sample_wsse_start(void)
+{
+	pr_info("start\n");
+	return 0;
+}
+
+static void damon_sample_wsse_stop(void)
+{
+	pr_info("stop\n");
+}
+
+static int damon_sample_wsse_enable_store(
+		const char *val, const struct kernel_param *kp)
+{
+	bool enabled = enable;
+	int err;
+
+	err = kstrtobool(val, &enable);
+	if (err)
+		return err;
+
+	if (enable == enabled)
+		return 0;
+
+	if (enable)
+		return damon_sample_wsse_start();
+	damon_sample_wsse_stop();
+	return 0;
+}
+
+static int __init damon_sample_wsse_init(void)
+{
+	return 0;
+}
+
+module_init(damon_sample_wsse_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("SeongJae Park");
+MODULE_DESCRIPTION("DAMON sample module for working set size estimation");
-- 
2.39.5


