Return-Path: <linux-kernel+bounces-317193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F996DAC2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C26A1C22E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986C19D8A0;
	Thu,  5 Sep 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rr3tca+i"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF519D063
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544129; cv=none; b=fOtgyluRBTmicSy3r5BzNL9vmLpJ1EKxMAr2PWZCkmMIJu0//8izQdmu5JIDpOCpywKl+DvHJhCZePnSaRjeM/BiAUVSEbrK/qH4i/IOIyrg7jqPZPq9xurLKZCc8h3xLoFZUpz0rsWmKEFEumIoc/I+C2K2SYO9seGa6jwKxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544129; c=relaxed/simple;
	bh=hYi7Em6xyMqmYJw3uVKzeS2OkCvSGj+g6fuB3Bg9S68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NkjEMg3SCndpuJzYdPeKA7KcDxFCvOyIZ/EsXNE6/dJiwyLZWUqVe0H0SL5eNV6tBKjncJw+84T/pCTpPtXhvNEgoUyVkyMqAJ8ugNz5FNip6g7Gz9WDimgazrIb6kQ2/bb1O3dcS06xsBamG0bWEgpq0py4G2/vbwwoddOlTNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rr3tca+i; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725544124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hv4THZ171etWiuRAMHtpZz9WOVnqDt4/Ch3TvuhHnmA=;
	b=Rr3tca+iX9BLvw0z2GmCCnFmtz+iJoizcR5SBCGiBjcOSI6QdWeH/hPWbFTJAvBduJdkD9
	YPfaLx1s2oUn2Dms6oje78sEm808tiN0y4CNdnvwt+jvdYLJC1rgeMY8gIq1gC8BrKBg+R
	dW/x/RXxx6/o+ECFQQkbV+39XQQv59Q=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] sysctl: simplify the min/max boundary check
Date: Thu,  5 Sep 2024 21:48:18 +0800
Message-Id: <20240905134818.4104-1-wen.yang@linux.dev>
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
provides these min/max values for doing range checking for the
proc_douintvec_minmax()/proc_dou8vec_minmax() handlers.

To avoid duplicate code, a new proc_minmax_conv_param structure has been
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
 kernel/sysctl.c | 93 +++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 57 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..92305cdbb94a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -809,17 +809,18 @@ static int proc_taint(const struct ctl_table *table, int write,
 }
 
 /**
- * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
+ * struct proc_minmax_conv_param - proc_dointvec_minmax() range checking structure
+ * @min: the minimum allowable value
+ * @max: the maximum allowable value
  *
- * The do_proc_dointvec_minmax_conv_param structure provides the
+ * The proc_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_dointvec_minmax() handler.
+ * parameters that use the proc_dointvec_minmax(), proc_douintvec_minmax(),
+ * proc_dou8vec_minmax() and so on.
  */
-struct do_proc_dointvec_minmax_conv_param {
-	int *min;
-	int *max;
+struct proc_minmax_conv_param {
+	long min;
+	long max;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -827,7 +828,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int write, void *data)
 {
 	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	struct proc_minmax_conv_param *param = data;
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
@@ -867,35 +867,21 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct proc_minmax_conv_param param;
+
+	param.min = (table->extra1) ?  *(int *) table->extra1 : INT_MIN;
+	param.max = (table->extra2) ?  *(int *) table->extra2 : INT_MAX;
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
+	struct proc_minmax_conv_param *param = data;
 	/* write via temporary local uint for bounds-checking */
 	unsigned int *up = write ? &tmp : valp;
 
@@ -904,8 +890,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -ERANGE;
 
 		WRITE_ONCE(*valp, tmp);
@@ -936,10 +921,10 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
-	};
+	struct proc_minmax_conv_param param;
+
+	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
+	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -965,23 +950,17 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
-	unsigned int min = 0, max = 255U, val;
+	unsigned int val;
 	u8 *data = table->data;
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = &min,
-		.max = &max,
-	};
+	struct proc_minmax_conv_param param;
 	int res;
 
 	/* Do not support arrays yet. */
 	if (table->maxlen != sizeof(u8))
 		return -EINVAL;
 
-	if (table->extra1)
-		min = *(unsigned int *) table->extra1;
-	if (table->extra2)
-		max = *(unsigned int *) table->extra2;
-
+	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
+	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : 255U;
 	tmp = *table;
 
 	tmp.maxlen = sizeof(val);
@@ -1022,7 +1001,7 @@ static int __do_proc_doulongvec_minmax(void *data,
 		void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
-	unsigned long *i, *min, *max;
+	unsigned long *i, min, max;
 	int vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
@@ -1033,8 +1012,9 @@ static int __do_proc_doulongvec_minmax(void *data,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
+	min = (table->extra1) ? *(unsigned long *) table->extra1 : 0;
+	max = (table->extra2) ? *(unsigned long *) table->extra2 : ULONG_MAX;
+
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1066,7 +1046,7 @@ static int __do_proc_doulongvec_minmax(void *data,
 			}
 
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max)) {
+			if ((val < min) || (val > max)) {
 				err = -EINVAL;
 				break;
 			}
@@ -1224,7 +1204,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 						int *valp, int write, void *data)
 {
 	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	struct proc_minmax_conv_param *param = data;
 	/*
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
@@ -1236,8 +1216,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-				(param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -EINVAL;
 		*valp = tmp;
 	}
@@ -1269,10 +1248,10 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int write,
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct proc_minmax_conv_param param;
+
+	param.min =  (table->extra1) ? *(int *) table->extra1 : INT_MIN;
+	param.max =  (table->extra2) ? *(int *) table->extra2 : INT_MAX;
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


