Return-Path: <linux-kernel+bounces-334804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20497DC61
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E284A1C20C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6951531F2;
	Sat, 21 Sep 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z2p10ue2"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23A4156F3C
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911015; cv=none; b=f+A302RsHt9mE1jPBQpvU6USC/3Kb6S4XF/Eq+Gj4BJStvrMRFAK8+PhPgbeKUWlCq0k/yGwWpRf4neTMDWMsbbn1nhgyED0Pe5bOiXuK07MKESEnMDQCnE6fSyCvU5hC6JP+WsCQIz7zNzgvJFzNyPTc7akBfFiaeVcz9JEC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911015; c=relaxed/simple;
	bh=fetJdy5pXH7vcniScyc1DbNPDuNoFArEM1g2oEge5os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hod3LyqXXyZLcQB4j6ul25cfsZYqzL+a7CUkhVuxQpoGAcGHi+xgU5fOyFrAFDEQnSEpZS0x2hSwTGXeQ4PDsjuVwQ4z778pCFaxhZ94ioW4EZrq69GcPleARMEdC4V9zM6HLxaApvcDxqITKgbWmTJw+1hFf521yapSSNW3P+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z2p10ue2; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726911007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp8Th0D53b7j8GPLVDMOM7Ybnut5JoYsWD95S/96SwQ=;
	b=Z2p10ue2DgM05R4JF6s5Q+AZyEw+0SYfhqcHKq6SXrmITpqmhxLoDE4EI0RgvLyiT8q/Ld
	1VNIgpM+pW+TjbLQCLIf8Qh9nPR/BUjIQgC5LJ7OJGyF5Y333XDy/t2QuiIu7YJ29dKPBg
	QVoylhOILXGKXiFFLA1LMJZcJxMP1/Q=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 1/5] sysctl: add helper functions to extract table->extra1/extra2
Date: Sat, 21 Sep 2024 17:29:00 +0800
Message-Id: <0f4a5233b75e6484a6236d85d2b506c96ea41ef1.1726910671.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add some sysctl helper functions to avoid direct access to
table->extra1/extra2.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
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
index d11ebc055ce0..3177e229ec46 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1109,18 +1109,15 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
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
index aa4c6d44aaa0..48f907850c87 100644
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


