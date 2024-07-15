Return-Path: <linux-kernel+bounces-252722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C291493174F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7768B1F21A18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12618EFE8;
	Mon, 15 Jul 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o6x/5RXu"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4486A3A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055780; cv=none; b=ZITd0zV7j8eo/Gvbn6R/hdegFKWGyRw5/f2ywf0r8lmtcFNJPUn2QGuWlnpflTAb/er/ybdAKAHCAXMaoAu/Uibtq/breFty7Hg4Ug3rtMk7KEE1NXjalb+m9zyv5IXXilYsL992uUfLV+TZF7ZO9bm0m+n+mqnDbvkKjq26CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055780; c=relaxed/simple;
	bh=BVp8/vLYgin82ZhjajWKsO46wXqB030JTOQyJwmasUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SjOvD3F41iGhtZfyZvmHut8200o10g8AFQH9/744GKe6ZdiDvBG8m7DvbCzqZmPHQ1BUmokEH5Pxs8uZ28hiEJ1j20nUOdikhVxPzLEhYAZ992fFGH/ADDjrggECq8tsYX6OTONyJMmxNpWSRZSNCm9oudh95eVIi5DSvot4M+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o6x/5RXu; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ebiederm@xmission.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721055775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Bx+gGuyNyRPLgNDsnj1ZJCJdVf1Ptadvr7DRfDMYOk=;
	b=o6x/5RXuBV05qJmx2HqbQk3KO7utVbOvX/XPWxNM+2VlXzvDzFZkB3Ebnj8Nw2hkZ8rbD6
	p4BmcVn4e47drr+XM3IV384BQ9se95FyVJE6+P93qgJSt0omKfC981Ju0zUmj4okEUSw4n
	qzJqjyLs425n/6iFIaXLlD75ntVAMV0=
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: keescook@chromium.org
X-Envelope-To: j.granados@samsung.com
X-Envelope-To: brauner@kernel.org
X-Envelope-To: wen.yang@linux.dev
X-Envelope-To: dyoung@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sysctl: simplify the min/max boundary check
Date: Mon, 15 Jul 2024 23:02:23 +0800
Message-Id: <20240715150223.54707-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The do_proc_dointvec_minmax_conv_param structure provides the minimum and
maximum values for doing range checking for the proc_dointvec_minmax()
handler, while the do_proc_douintvec_minmax_conv_param structure also
provides the minimum and maximum values for doing range checking for the
proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.

To avoid duplicate code, a new do_proc_minmax_conv_param structure has been
introduced to replace both do_proc_dointvec_minmax_conv_param and
do_proc_douintvec_minmax_conv_param mentioned above.

This also prepares for the removal of sysctl_vals and sysctl_long_vals.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl.c | 107 ++++++++++++++++++++++++++----------------------
 1 file changed, 57 insertions(+), 50 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e4421594fc25..bc784d726e09 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -809,17 +809,18 @@ static int proc_taint(struct ctl_table *table, int write,
 }
 
 /**
- * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
+ * struct do_proc_minmax_conv_param - proc_dointvec_minmax() range checking structure
+ * @min: the minimum allowable value
+ * @max: the maximum allowable value
  *
- * The do_proc_dointvec_minmax_conv_param structure provides the
+ * The do_proc_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_dointvec_minmax() handler.
+ * parameters that use the proc_dointvec_minmax(), proc_douintvec_minmax(),
+ * proc_dou8vec_minmax() and so on.
  */
-struct do_proc_dointvec_minmax_conv_param {
-	int *min;
-	int *max;
+struct do_proc_minmax_conv_param {
+	long min;
+	long max;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -827,7 +828,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int write, void *data)
 {
 	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	struct do_proc_minmax_conv_param *param = data;
 	/*
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
@@ -839,8 +840,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -EINVAL;
 		WRITE_ONCE(*valp, tmp);
 	}
@@ -867,35 +867,27 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
+	struct do_proc_minmax_conv_param param = {
+		.min = INT_MIN,
+		.max = INT_MAX,
 	};
+
+	if (table->extra1)
+		param.min = *(int *) table->extra1;
+	if (table->extra2)
+		param.max = *(int *) table->extra2;
+
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
 
-/**
- * struct do_proc_douintvec_minmax_conv_param - proc_douintvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
- *
- * The do_proc_douintvec_minmax_conv_param structure provides the
- * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_douintvec_minmax() handler.
- */
-struct do_proc_douintvec_minmax_conv_param {
-	unsigned int *min;
-	unsigned int *max;
-};
-
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 					 unsigned int *valp,
 					 int write, void *data)
 {
 	int ret;
 	unsigned int tmp;
-	struct do_proc_douintvec_minmax_conv_param *param = data;
+	struct do_proc_minmax_conv_param *param = data;
 	/* write via temporary local uint for bounds-checking */
 	unsigned int *up = write ? &tmp : valp;
 
@@ -904,8 +896,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -ERANGE;
 
 		WRITE_ONCE(*valp, tmp);
@@ -936,10 +927,16 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
+	struct do_proc_minmax_conv_param param = {
+		.min = 0,
+		.max = UINT_MAX,
 	};
+
+	if (table->extra1)
+		param.min = *(unsigned int *) table->extra1;
+	if (table->extra2)
+		param.max = *(unsigned int *) table->extra2;
+
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -965,11 +962,11 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
-	unsigned int min = 0, max = 255U, val;
+	unsigned int val;
 	u8 *data = table->data;
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = &min,
-		.max = &max,
+	struct do_proc_minmax_conv_param param = {
+		.min = 0,
+		.max = 255U,
 	};
 	int res;
 
@@ -978,9 +975,9 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 		return -EINVAL;
 
 	if (table->extra1)
-		min = *(unsigned int *) table->extra1;
+		param.min = *(unsigned int *) table->extra1;
 	if (table->extra2)
-		max = *(unsigned int *) table->extra2;
+		param.max = *(unsigned int *) table->extra2;
 
 	tmp = *table;
 
@@ -1022,7 +1019,8 @@ static int __do_proc_doulongvec_minmax(void *data,
 		void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
-	unsigned long *i, *min, *max;
+	unsigned long min = 0, max = ULONG_MAX;
+	unsigned long *i;
 	int vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
@@ -1033,8 +1031,12 @@ static int __do_proc_doulongvec_minmax(void *data,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
+
+	if (table->extra1)
+		min = *(unsigned long *) table->extra1;
+	if (table->extra2)
+		max = *(unsigned long *) table->extra2;
+
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1066,7 +1068,7 @@ static int __do_proc_doulongvec_minmax(void *data,
 			}
 
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max)) {
+			if ((val < min) || (val > max)) {
 				err = -EINVAL;
 				break;
 			}
@@ -1224,7 +1226,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 						int *valp, int write, void *data)
 {
 	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	struct do_proc_minmax_conv_param *param = data;
 	/*
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
@@ -1236,8 +1238,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-				(param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -EINVAL;
 		*valp = tmp;
 	}
@@ -1269,10 +1270,16 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
 int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
+	struct do_proc_minmax_conv_param param = {
+		.min = INT_MIN,
+		.max = INT_MAX,
 	};
+
+	if (table->extra1)
+		param.min = *(int *) table->extra1;
+	if (table->extra2)
+		param.max = *(int *) table->extra2;
+
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


