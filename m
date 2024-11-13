Return-Path: <linux-kernel+bounces-408013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD99C78D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF91C284A64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69C20101B;
	Wed, 13 Nov 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzYlZYVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3411FF7C6;
	Wed, 13 Nov 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515194; cv=none; b=d0aoQBHJncGN84AAM6WQKf2DRbiq0Cb6hfsVbxQGKgesn5MYNMchW8SWHG2KDZaPbVBOt63XpvG65+8Wv4t92Zp4aipvjc6aKtPXk0f57e3w/Qs/7SDwx52G6ouQlas2APOmv6MkJt9m89wF73FDAvTh2d345HS+K8wYCTnKpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515194; c=relaxed/simple;
	bh=nvp2mMbvRyEYpGGB8GVuStSGx5/+sBiAwPQ8jRBowzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K+1uDVirKQlAOEBbBmJQ6z7ZaEzfJPL/FDOgL2ah0fVHGkiSPTLRDAeK8bAvM9csT2FlzhwlwNbNpi5WiSQhgwpC3jtF6W5AqRgp0HDA0zBoTvRrrAc47BkqXCyaE5/D/4zIpPC+ahNo8zwcEgJASl2wAJcSIbrNlKKN01EMXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzYlZYVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09AEC4CEDA;
	Wed, 13 Nov 2024 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731515193;
	bh=nvp2mMbvRyEYpGGB8GVuStSGx5/+sBiAwPQ8jRBowzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzYlZYVWfpmFdoSg5mqCA2/vMt8lNAryL/Qeyopf1laH1M7ZHFQ8p0ykW9VOdcJh8
	 QERHe9jyUv6PPQWlcy+OZQmMaVZUKzvcTAtpSDf8U1phkVpOe2bzKcf+6Qiqk0Btm0
	 ZjRmiMhGClDT1cBdOeFLeNqM0iHlUF2cs56Wu4r0rTvkZ1vZ+Q3FnemvCgZ7aiIIFK
	 NFwiOxsY/h4+PN42u737de7plor3eb0vrolvMCpzzIuiubuDelDYWAUqvwUPy4V1pP
	 FBL0v4F4mKXSEs1Sc94U7GsviRoyS7F/h8vtH3Js7xQrYCZSBNaaKRlUM/h/Arvj6V
	 shacV75K8YH0Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 4/5] samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation
Date: Wed, 13 Nov 2024 08:26:23 -0800
Message-Id: <20241113162624.48973-5-sj@kernel.org>
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

Add a skeleton for a sample DAMON module that can be used for
proactively reclaiming cold memory regions of a given process.  The
skeleton is actually same to working set size estimation sample module,
but only the names of the file and symbols are changed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/Makefile       |   1 +
 samples/damon/Kconfig  |  13 +++++
 samples/damon/Makefile |   1 +
 samples/damon/prcl.c   | 120 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 samples/damon/prcl.c

diff --git a/samples/Makefile b/samples/Makefile
index 726bb5293486..5af6bb8afb07 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -40,3 +40,4 @@ obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
 obj-$(CONFIG_SAMPLE_DAMON_WSSE)		+= damon/
+obj-$(CONFIG_SAMPLE_DAMON_PRCL)		+= damon/
diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index b799e01345c8..63f6dcd71daa 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -14,4 +14,17 @@ config SAMPLE_DAMON_WSSE
 
 	  If unsure, say N.
 
+config SAMPLE_DAMON_PRCL
+	bool "DAMON sameple module for access-aware proactive reclamation"
+	depends on DAMON && DAMON_VADDR
+	help
+	  This builds DAMON sample module for access-aware proactive
+	  reclamation.
+
+	  The module receives a pid, monitor access to the virtual address
+	  space of the process, find memory regions that not accessed, and
+	  proactively reclaim the regions.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/samples/damon/Makefile b/samples/damon/Makefile
index ccbe93d40130..7f155143f237 100644
--- a/samples/damon/Makefile
+++ b/samples/damon/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SAMPLE_DAMON_WSSE) += wsse.o
+obj-$(CONFIG_SAMPLE_DAMON_PRCL) += prcl.o
diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
new file mode 100644
index 000000000000..32ccdd91cf55
--- /dev/null
+++ b/samples/damon/prcl.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * proactive reclamation: monitor access pattern of a given process, find
+ * regiosn that seems not accessed, and proactively page out the regions.
+ */
+
+#define pr_fmt(fmt) "damon_sample_prcl: " fmt
+
+#include <linux/damon.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+static int target_pid __read_mostly;
+module_param(target_pid, int, 0600);
+
+static int damon_sample_prcl_enable_store(
+		const char *val, const struct kernel_param *kp);
+
+static const struct kernel_param_ops enable_param_ops = {
+	.set = damon_sample_prcl_enable_store,
+	.get = param_get_bool,
+};
+
+static bool enable __read_mostly;
+module_param_cb(enable, &enable_param_ops, &enable, 0600);
+MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_WSSE");
+
+static struct damon_ctx *ctx;
+static struct pid *target_pidp;
+
+static int damon_sample_prcl_after_aggregate(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long wss = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				wss += r->ar.end - r->ar.start;
+		}
+		pr_info("wss: %lu\n", wss);
+	}
+	return 0;
+}
+
+static int damon_sample_prcl_start(void)
+{
+	struct damon_target *target;
+
+	pr_info("start\n");
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		return -ENOMEM;
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR)) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+
+	target = damon_new_target();
+	if (!target) {
+		damon_destroy_ctx(ctx);
+		return -ENOMEM;
+	}
+	damon_add_target(ctx, target);
+	target_pidp = find_get_pid(target_pid);
+	if (!target_pidp) {
+		damon_destroy_ctx(ctx);
+		return -EINVAL;
+	}
+	target->pid = target_pidp;
+
+	ctx->callback.after_aggregation = damon_sample_prcl_after_aggregate;
+
+	return damon_start(&ctx, 1, true);
+}
+
+static void damon_sample_prcl_stop(void)
+{
+	pr_info("stop\n");
+	if (ctx) {
+		damon_stop(&ctx, 1);
+		damon_destroy_ctx(ctx);
+	}
+	if (target_pidp)
+		put_pid(target_pidp);
+}
+
+static int damon_sample_prcl_enable_store(
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
+		return damon_sample_prcl_start();
+	damon_sample_prcl_stop();
+	return 0;
+}
+
+static int __init damon_sample_prcl_init(void)
+{
+	return 0;
+}
+
+module_init(damon_sample_prcl_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("SeongJae Park");
+MODULE_DESCRIPTION("DAMON sample module for proactive reclamation");
-- 
2.39.5


