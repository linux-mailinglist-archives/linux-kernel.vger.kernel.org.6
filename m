Return-Path: <linux-kernel+bounces-449809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE09F5668
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DC516FAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF81F758A;
	Tue, 17 Dec 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgEFJWre"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2496158DD1;
	Tue, 17 Dec 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460638; cv=none; b=kjgSPiZijFV0SVe6uJDtLzlBWuUT55eANPanUzzaI6Lw1at/j2wEFR0zl0DNellmI8dh7ETTKcpkV6Lt8rYnoBy11cnrCXuSMboSXCzp/Y9b2CQ6QugyiQkTFEpwX9nsrTi2nvxmMeFy0e2xflMfog+xiXVcVDBqa+WabeDY9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460638; c=relaxed/simple;
	bh=BNvXLoLBqNS3PBaRMcPRIf+H2Atow1toQbiBU4A8z0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iObROf011bjxwnodZvACCF2i/211IfjX1vGky0oCdxsDkoCQPBBcKhKWxapEOMmwiKTLOurYQJoQVYhGfcHUKfOJmVkDWqprEJM/KDhE+01bM42YhV69VT6GsxUMT19zNsDbBxHnAQGrogoMR8g5uQeLpuNyXPZk/IkbMGK+gTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgEFJWre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4617BC4CED3;
	Tue, 17 Dec 2024 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734460637;
	bh=BNvXLoLBqNS3PBaRMcPRIf+H2Atow1toQbiBU4A8z0k=;
	h=From:To:Cc:Subject:Date:From;
	b=MgEFJWreCDW8MP04t3fTsUiGJbWDOn/x6YJg0CaUgcaz8HbgM4xGiVIdhQHUC/HvT
	 tU+B3UpLd+oGrNmFY1zpV+/D0xsRmkevFQAUFAxEOwdTuJ+6TjxF5OHoeluS8WwwCf
	 eJVWpY8rkvsXYouCc15oP22QJICs4xXQyRtWU+qAr8X/z7ZFjYEzaLtVme6hc4kUqM
	 J3mmzIwpFZCbCnwQ/ZnlDHz7eRoFAzY1W8pIZgwgCCzEHB44h8t7dafIDiWC6TQ/g+
	 tWHxaqwmwrlR+l3WobDZ71IM7R766Tb1XIo+yxPutkQ72BXp55qBhNuPpFIOTjvQbX
	 ceinRMaeMdBVQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Saravana Kannan <saravanak@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] of: Add printf '%pOFm' for generating modalias
Date: Tue, 17 Dec 2024 12:37:09 -0600
Message-ID: <20241217183711.2525863-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers for of_modalias() generally need the module alias as part of
some larger string. That results in some error prone manipulation of the
buffer prepend/append the module alias string. In fact,
of_device_uevent_modalias() has several issues. First, it's off by one
too few characters in utilization of the full buffer. Second, the error
paths leave OF_MODALIAS with a truncated value when in the end nothing
should be added to the buffer. It is also fragile because it needs
internal details of struct kobj_uevent_env. add_uevent_var() really
wants to write the env variable and value in one shot which would need
either a temporary buffer for value or a format specifier.

Fix these issues by adding a new printf format specifier, "%pOFm". With
the format specifier in place, simplify all the callers of
of_modalias(). of_modalias() can also be simplified with vsprintf()
being the only caller as it avoids the error conditions.

Cc: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/core-api/printk-formats.rst |  1 +
 drivers/of/device.c                       | 25 ++--------------
 drivers/of/module.c                       | 35 +++++------------------
 drivers/of/unittest.c                     |  2 ++
 include/linux/of.h                        |  8 +++---
 lib/vsprintf.c                            |  7 +++--
 6 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index ecccc0473da9..d72fe3d8c427 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -496,6 +496,7 @@ equivalent to %pOFf.
 	- F - device node flags
 	- c - major compatible string
 	- C - full compatible string
+	- m - module alias string
 
 The separator when using multiple arguments is ':'
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index edf3be197265..ae8c47d5db8e 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -199,14 +199,9 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 	if (!dev || !dev->of_node || dev->of_node_reused)
 		return -ENODEV;
 
-	sl = of_modalias(dev->of_node, str, len - 2);
-	if (sl < 0)
-		return sl;
-	if (sl > len - 2)
+	sl = snprintf(str, len, "%pOFm\n", dev->of_node);
+	if (sl >= len)
 		return -ENOMEM;
-
-	str[sl++] = '\n';
-	str[sl] = 0;
 	return sl;
 }
 EXPORT_SYMBOL_GPL(of_device_modalias);
@@ -256,24 +251,10 @@ EXPORT_SYMBOL_GPL(of_device_uevent);
 
 int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
-	int sl;
-
 	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
 		return -ENODEV;
 
-	/* Devicetree modalias is tricky, we add it in 2 steps */
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
-
-	sl = of_modalias(dev->of_node, &env->buf[env->buflen-1],
-			 sizeof(env->buf) - env->buflen);
-	if (sl < 0)
-		return sl;
-	if (sl >= (sizeof(env->buf) - env->buflen))
-		return -ENOMEM;
-	env->buflen += sl;
-
-	return 0;
+	return add_uevent_var(env, "MODALIAS=%pOFm", dev->of_node);
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
 
diff --git a/drivers/of/module.c b/drivers/of/module.c
index 1e735fc130ad..80879d2abea8 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -8,21 +8,14 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
+/* Do not use directly, use %pOFm format specifier instead */
+size_t of_modalias(const struct device_node *np, char *str, size_t len)
 {
 	const char *compat;
 	char *c;
 	struct property *p;
-	ssize_t csize;
-	ssize_t tsize;
-
-	/*
-	 * Prevent a kernel oops in vsnprintf() -- it only allows passing a
-	 * NULL ptr when the length is also 0. Also filter out the negative
-	 * lengths...
-	 */
-	if ((len > 0 && !str) || len < 0)
-		return -EINVAL;
+	size_t csize;
+	size_t tsize;
 
 	/* Name & Type */
 	/* %p eats all alphanum characters, so %c must be used here */
@@ -53,29 +46,15 @@ ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
 
 int of_request_module(const struct device_node *np)
 {
-	char *str;
-	ssize_t size;
-	int ret;
+	char *str __free(kfree);
 
 	if (!np)
 		return -ENODEV;
 
-	size = of_modalias(np, NULL, 0);
-	if (size < 0)
-		return size;
-
-	/* Reserve an additional byte for the trailing '\0' */
-	size++;
-
-	str = kmalloc(size, GFP_KERNEL);
+	str = kasprintf(GFP_KERNEL, "%pOFm", np);
 	if (!str)
 		return -ENOMEM;
 
-	of_modalias(np, str, size);
-	str[size - 1] = '\0';
-	ret = request_module(str);
-	kfree(str);
-
-	return ret;
+	return request_module(str);
 }
 EXPORT_SYMBOL_GPL(of_request_module);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index daf9a2dddd7e..93921399f02d 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -342,6 +342,8 @@ static void __init of_unittest_printf(void)
 	of_unittest_printf_one(np, "%pOFc", "test-sub-device");
 	of_unittest_printf_one(np, "%pOFC",
 			"\"test-sub-device\",\"test-compat2\",\"test-compat3\"");
+	of_unittest_printf_one(np, "%pOFm",
+			"of:NdevT(null)Ctest-sub-deviceCtest-compat2Ctest-compat3");
 }
 
 struct node_hash {
diff --git a/include/linux/of.h b/include/linux/of.h
index f921786cb8ac..9fe7d17ce7e2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -382,7 +382,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
 /* module functions */
-extern ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len);
+extern size_t of_modalias(const struct device_node *np, char *str, size_t len);
 extern int of_request_module(const struct device_node *np);
 
 /* phandle iterator functions */
@@ -762,10 +762,10 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline ssize_t of_modalias(const struct device_node *np, char *str,
-				  ssize_t len)
+static inline size_t of_modalias(const struct device_node *np, char *str,
+				 size_t len)
 {
-	return -ENODEV;
+	return 0;
 }
 
 static inline int of_request_module(const struct device_node *np)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 9d3dac38a3f4..6a4f99b39de0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2169,10 +2169,10 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 
 	/* simple case without anything any more format specifiers */
 	fmt++;
-	if (fmt[0] == '\0' || strcspn(fmt,"fnpPFcC") > 0)
+	if (fmt[0] == '\0' || strcspn(fmt,"fnpPFcCm") > 0)
 		fmt = "f";
 
-	for (pass = false; strspn(fmt,"fnpPFcC"); fmt++, pass = true) {
+	for (pass = false; strspn(fmt,"fnpPFcCm"); fmt++, pass = true) {
 		int precision;
 		if (pass) {
 			if (buf < end)
@@ -2226,6 +2226,9 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
 				has_mult = true;
 			}
 			break;
+		case 'm':
+			buf += of_modalias(dn, buf, end - buf);
+			break;
 		default:
 			break;
 		}
-- 
2.45.2


