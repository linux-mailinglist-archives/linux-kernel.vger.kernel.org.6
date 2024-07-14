Return-Path: <linux-kernel+bounces-251888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57701930B0A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 19:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A2D2821A8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC42513C69C;
	Sun, 14 Jul 2024 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/5h0ZcN"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B41B64E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978788; cv=none; b=CTDwrexJK8O0a4sv7YSclEekHMW47ErAzOAJqLt2I9+wu6YhDmW2p8eNqJdCKemI5RKAjE/8AtCHsG1rYgdXqC1fV8/YTJwdq/q0Lhv5ZVo/W0bMiqSdIjoLZCF0hrGu/3sqpPCmqA/xNe/2U7PYh3jiW85NWPjN1CBjDVIAl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978788; c=relaxed/simple;
	bh=S+HLUVtEC8JRD8Fxtr8++OIjIkdlqjKWuSFtDhOBK6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D7zHHnZ+DB2eBGNv8NVhvwpW4mzFlocHeZNUrHnOQnQlcK51fAwX3y8ajJV/9YNsALoD4LdjvwDQ64omw5l1Hr1mS/LH1YsHngoT1QlToECuTA9baJwP+EA6n3X5OpS60CtxrbD6b013+NZ4AXbaHaL6ZcjjJQVPXZllFPbdY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/5h0ZcN; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ebiederm@xmission.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720978780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wR6neTBRVsBQbwOYI2WuLar72mKO6WfMr5X+0o8BApQ=;
	b=O/5h0ZcN92GP1ttm67CuoHoeGoYFGFbP+bS1aytfUHTBIwOLOYiuSESCjADD7x1PqZTjU/
	/kVy9ZBfVCayDD7gfvfviQua5OWiQPX5dXA1n2u1MPPKTOqhIP8A1kn3VKkljtAITmMmwg
	8QW/ZhcR8alLml8wozjhRdOwcHbVXDQ=
X-Envelope-To: mcgrof@kernel.org
X-Envelope-To: keescook@chromium.org
X-Envelope-To: j.granados@samsung.com
X-Envelope-To: brauner@kernel.org
X-Envelope-To: wen.yang@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: simplify the min/max boundary check
Date: Mon, 15 Jul 2024 01:38:58 +0800
Message-Id: <20240714173858.52163-1-wen.yang@linux.dev>
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
provides the minimumand maximum values for doing range checking for the
proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.

Introduce a new do_proc_dointvec_minmax_conv_param structure to replace the
do_proc_dointvec_minmax_conv_param and do_proc_douintvec_minmax_conv_param
structures mentioned above.
This simplifies the code and also prepares for the removal of sysctl_vals.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
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


