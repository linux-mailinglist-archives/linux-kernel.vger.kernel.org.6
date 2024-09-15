Return-Path: <linux-kernel+bounces-329653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D28979450
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC09B1F21A81
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420E323D;
	Sun, 15 Sep 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOsP00wX"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF03D2FF
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366183; cv=none; b=sqC0TWF1YSR4QYaKKt85REOBbZb2xFIobfiMEzKCOSt4d8qcwY2FJQeZOVCMVlR3xNgRb5jTHYqsh06GKcwci60HiL8z4RuotlBhibg1XleOjVlj2M2t+lMl1l/yXAWWm7qcW6Ffasa5/2b81OGA+bSc6RqYm15R7MU57UQaoqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366183; c=relaxed/simple;
	bh=mNz6SJ0qIET1HZIfM2/2YEL+90Dv8kw5sh7UAsMhTOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UF3KKYj/1dJgsrVnvrMQ0BxmQ0sZ06xkY6AdWcOql4Tl/6NFi41AHbVceQEg/R3XhgtzaVnYyq0dZmSswXQCABZq9oAlISzN930Uy9wD1sCVaVfcN2IIseWVlOHFTe6tvTUiFnkzg9ImPKW/F1hRHVN5IwQbcQxj9X1i9S5uWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOsP00wX; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726366178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ljC/VBRr3GFRZnta2fsCZG7zwZAbaP9X3IzNuE/5UMY=;
	b=kOsP00wXsLWwMVpU9Gyfy7CBlD4aCOX28BlpIqXTfVWVyI58nJRSPzQBYpXCf79mdmiLk3
	+oeHVeo2rU9trwA3eUBTBwm3R0NjvcgoyNGmZr+ZU9Ty6tdbKWvDhuYInGj/H8qJDVr1qZ
	ZaAZH4I3WO2Nj38/1zV1tw18u4UDVg4=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v3 1/5] sysctl: add helper functions to extract table->extra1/extra2
Date: Sun, 15 Sep 2024 10:08:27 +0800
Message-Id: <364936c4a83abcddabb08504b4e26a7b92daef68.1726365007.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726365007.git.wen.yang@linux.dev>
References: <cover.1726365007.git.wen.yang@linux.dev>
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
 fs/proc/proc_sysctl.c  | 21 +++++++++------------
 include/linux/sysctl.h | 40 ++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        | 20 ++++++++++----------
 3 files changed, 59 insertions(+), 22 deletions(-)

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
index 202855befa8b..20e3914ec53f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -212,6 +212,46 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+static inline unsigned int sysctl_range_min_u8(const struct ctl_table *table)
+{
+	return (table->extra1) ? *(unsigned int *) table->extra1 : 0;
+}
+
+static inline unsigned int sysctl_range_max_u8(const struct ctl_table *table)
+{
+	return (table->extra2) ? *(unsigned int *) table->extra2 : U8_MAX;
+}
+
+static inline int sysctl_range_min_int(const struct ctl_table *table)
+{
+	return (table->extra1) ? *(int *) table->extra1 : INT_MIN;
+}
+
+static inline int sysctl_range_max_int(const struct ctl_table *table)
+{
+	return (table->extra2) ? *(int *) table->extra2 : INT_MAX;
+}
+
+static inline unsigned int sysctl_range_min_uint(const struct ctl_table *table)
+{
+	return (table->extra1) ? *(unsigned int *) table->extra1 : 0;
+}
+
+static inline unsigned int sysctl_range_max_uint(const struct ctl_table *table)
+{
+	return (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
+}
+
+static inline unsigned long sysctl_range_min_ulong(const struct ctl_table *table)
+{
+	return (table->extra1) ? *(unsigned long *) table->extra1 : 0;
+}
+
+static inline unsigned long sysctl_range_max_ulong(const struct ctl_table *table)
+{
+	return (table->extra2) ? *(unsigned long *) table->extra2 : ULONG_MAX;
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


