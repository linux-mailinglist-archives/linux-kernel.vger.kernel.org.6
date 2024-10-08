Return-Path: <linux-kernel+bounces-355489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD5995311
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193D6284174
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D701E00AD;
	Tue,  8 Oct 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3ZZmmGN"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D31E00A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400507; cv=none; b=Yu1nniZ8uGNGtlgu0KMbWdXtp7Uc+T2bVvqK9TVSCIPKKoVDi/3dOA95cOJBeahqSJlWNNi0buyDVBUcnbn4T07FNGuF25+y7Y/nX5aQ+UVIXL2zlt0m5aOKJJAJU6HNxB5tnr0inQPVgJKDA8nuPW8abMz9zZmEwvkAQaQc204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400507; c=relaxed/simple;
	bh=q0PitI0yZWG+MZAHzB/VIkFLgsl9zhiXWGrx0N04rE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=klUIcp048KtZgD2ki4Lp0ZUt/dT+9gAAVGTkYWES4Awa5YHoIvEEnKvP0ARLsbPSeqJSdMPSKBwGSGGjBB0avgnsGAyNFDTD2G5N+XtFv1NE3522iZLXCy12+VhqD7Q5luYG1up5bfhCq2CeRxn+TiGPzLk1lts4UAIb+Yi9ms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a3ZZmmGN; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728400501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKgcKjztMvSzconfE5q7GWsTXhZln0fmgE29pNkqj6g=;
	b=a3ZZmmGNZ8BP6OWd1HoaAS1exTMC2DC/kMhbgFMHq16bf+KJRrWEVcw1u2PyVXtecUutmQ
	oqUPYoejs7fIogdlcP5obN69EJNlTrb9ZbIxMZHtHdUvho1xPrjhz225ysUkCXFrWRU0fB
	ca9RZw42MHtGbjSbxJKCAOUZXIYljb4=
From: Wen Yang <wen.yang@linux.dev>
To: Joel Granados <j.granados@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [RESEND PATCH v4 1/5] sysctl: add helper functions to extract table->extra1/extra2
Date: Tue,  8 Oct 2024 23:14:04 +0800
Message-Id: <20241008151444.12453-1-wen.yang@linux.dev>
In-Reply-To: <cover.1726907948.git.wen.yang@linux.dev>
References: <cover.1726907948.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add some sysctl helper functions to avoid direct access to
table->extra1/extra2.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/proc_sysctl.c  | 21 +++++++++-----------
 include/linux/sysctl.h | 44 ++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        | 20 +++++++++----------
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fac566065ed5..90c99eb1abf6 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1115,18 +1115,15 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 		if (table->maxlen != sizeof(u8))
 			err |= sysctl_err(path, table, "array not allowed");
 
-		if (table->extra1) {
-			extra = *(unsigned int *) table->extra1;
-			if (extra > 255U)
-				err |= sysctl_err(path, table,
-						"range value too large for proc_dou8vec_minmax");
-		}
-		if (table->extra2) {
-			extra = *(unsigned int *) table->extra2;
-			if (extra > 255U)
-				err |= sysctl_err(path, table,
-						"range value too large for proc_dou8vec_minmax");
-		}
+		extra = sysctl_range_min_u8(table);
+		if (extra > 255U)
+			err |= sysctl_err(path, table,
+					"range value too large for proc_dou8vec_minmax\n");
+
+		extra = sysctl_range_max_u8(table);
+		if (extra > 255U)
+			err |= sysctl_err(path, table,
+					"range value too large for proc_dou8vec_minmax\n");
 	}
 
 	if (table->proc_handler == proc_dobool) {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 202855befa8b..edfcb22b1e3d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -212,6 +212,50 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+#define __SYSCTL_RANGE_MIN(_a, _b, _c) (((_a)->extra1) ? *(_b((_a)->extra1)) : (_c))
+
+#define __SYSCTL_RANGE_MAX(_a, _b, _c) (((_a)->extra2) ? *(_b((_a)->extra2)) : (_c))
+
+static inline unsigned int sysctl_range_min_u8(const struct ctl_table *table)
+{
+	return (unsigned int)__SYSCTL_RANGE_MIN(table, (unsigned int *), 0);
+}
+
+static inline unsigned int sysctl_range_max_u8(const struct ctl_table *table)
+{
+	return (unsigned int)__SYSCTL_RANGE_MAX(table, (unsigned int *), U8_MAX);
+}
+
+static inline int sysctl_range_min_int(const struct ctl_table *table)
+{
+	return (int)__SYSCTL_RANGE_MIN(table, (int *), INT_MIN);
+}
+
+static inline int sysctl_range_max_int(const struct ctl_table *table)
+{
+	return (int)__SYSCTL_RANGE_MAX(table, (int *), INT_MAX);
+}
+
+static inline unsigned int sysctl_range_min_uint(const struct ctl_table *table)
+{
+	return (unsigned int)__SYSCTL_RANGE_MIN(table, (unsigned int *), 0);
+}
+
+static inline unsigned int sysctl_range_max_uint(const struct ctl_table *table)
+{
+	return (unsigned int)__SYSCTL_RANGE_MAX(table, (unsigned int *), UINT_MAX);
+}
+
+static inline unsigned long sysctl_range_min_ulong(const struct ctl_table *table)
+{
+	return (unsigned long)__SYSCTL_RANGE_MIN(table, (unsigned long *), 0);
+}
+
+static inline unsigned long sysctl_range_max_ulong(const struct ctl_table *table)
+{
+	return (unsigned long)__SYSCTL_RANGE_MAX(table, (unsigned long *), ULONG_MAX);
+}
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 92305cdbb94a..86de15638e31 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -869,8 +869,8 @@ int proc_dointvec_minmax(const struct ctl_table *table, int write,
 {
 	struct proc_minmax_conv_param param;
 
-	param.min = (table->extra1) ?  *(int *) table->extra1 : INT_MIN;
-	param.max = (table->extra2) ?  *(int *) table->extra2 : INT_MAX;
+	param.min = sysctl_range_min_int(table);
+	param.max = sysctl_range_max_int(table);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
@@ -923,8 +923,8 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write,
 {
 	struct proc_minmax_conv_param param;
 
-	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
-	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
+	param.min = sysctl_range_min_uint(table);
+	param.max = sysctl_range_max_uint(table);
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -959,8 +959,8 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 	if (table->maxlen != sizeof(u8))
 		return -EINVAL;
 
-	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
-	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : 255U;
+	param.min = sysctl_range_min_u8(table);
+	param.max = sysctl_range_max_u8(table);
 	tmp = *table;
 
 	tmp.maxlen = sizeof(val);
@@ -1012,8 +1012,8 @@ static int __do_proc_doulongvec_minmax(void *data,
 	}
 
 	i = data;
-	min = (table->extra1) ? *(unsigned long *) table->extra1 : 0;
-	max = (table->extra2) ? *(unsigned long *) table->extra2 : ULONG_MAX;
+	min = sysctl_range_min_ulong(table);
+	max = sysctl_range_max_ulong(table);
 
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
@@ -1250,8 +1250,8 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 {
 	struct proc_minmax_conv_param param;
 
-	param.min =  (table->extra1) ? *(int *) table->extra1 : INT_MIN;
-	param.max =  (table->extra2) ? *(int *) table->extra2 : INT_MAX;
+	param.min = sysctl_range_min_int(table);
+	param.max = sysctl_range_max_int(table);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


