Return-Path: <linux-kernel+bounces-426638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270E9DF5E9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 15:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C9EB2143F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501AF1D359D;
	Sun,  1 Dec 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JAQVW9rH"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637601D3596
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733061688; cv=none; b=p2WI+KcPz9fDyD23NGaGr5x9rZjZM6klsAZPwll4YR0t208CQHZOnRMzHQ0cheidqYS0kefNO4xMBKWjpTGDMdCTaNIElAdm2pFdpo4pAtGKPt+rlgqkeQasKOeCCCHmBSgnWUMsUVsZkqA2ym2kHNZb/ZvRjiDyWhNgPIoJhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733061688; c=relaxed/simple;
	bh=YFSuX/3Pge/YTQ3iL8J93PAXkH2s+zZDGa9dawjJwws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oUCzpKg647CQvyF//zJFOhTi/kb4pJnSqmp51lQryQk7QpApQTJ9dzx2gFSi0+zQ0BXWnnyeCm+HaQHXyI28cr5nFVIWtJR3az5WeKPdqs9c7+1aTHSbquM/oLawOGt2ePBv0Dnlwj9GKPhsK+Vxt3KlrWdQQH7/DhjkvOCZybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JAQVW9rH; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733061683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rSb7itKfSKg3WQK3DynsLBRqKwQ1qvtzFvtHQxo9MtI=;
	b=JAQVW9rHja04CTXJsRgNRBwV7GkRXEyElPOGee28PiX4b+rz5riwXWQLMMZea22Wdyva7S
	ZTFUlmrULfPyU99qXnaPQ0HUr/izM8ZpemAm2PKrvc0UCgW3SZ1CvGybRj9GelpdzWTCYb
	I2lmxkXsP6cA1nvXXAZMVv8nNqFzUE4=
From: Wen Yang <wen.yang@linux.dev>
To: Joel Granados <joel.granados@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4] sysctl: simplify the min/max boundary check
Date: Sun,  1 Dec 2024 22:00:58 +0800
Message-Id: <20241201140058.5653-1-wen.yang@linux.dev>
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
handler, however min/max is a pointer and may be NULL, so the following
code snippet appears multiple times:
        if ((param->min && *param->min > tmp) ||
            (param->max && *param->max < tmp))

And int types also have min/max values, so when the pointer is NULL,
explicitly setting min/max to INT_{MIN/MAX} could simplify the code a bit.

Similar changes were also made for do_proc_douintvec_minmax_conv_param.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl.c | 75 ++++++++++++++++++++++---------------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..47e2fe4fe978 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -810,16 +810,16 @@ static int proc_taint(const struct ctl_table *table, int write,
 
 /**
  * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
+ * @min: the minimum allowable value
+ * @max: the maximum allowable value
  *
  * The do_proc_dointvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_dointvec_minmax() handler.
+ * parameters that use the proc_dointvec_minmax(), proc_dou8vec_minmax() and so on.
  */
 struct do_proc_dointvec_minmax_conv_param {
-	int *min;
-	int *max;
+	int min;
+	int max;
 };
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
@@ -839,8 +839,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -EINVAL;
 		WRITE_ONCE(*valp, tmp);
 	}
@@ -867,26 +866,26 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	param.min = (table->extra1) ? *(int *) table->extra1 : INT_MIN;
+	param.max = (table->extra2) ? *(int *) table->extra2 : INT_MAX;
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
 
 /**
  * struct do_proc_douintvec_minmax_conv_param - proc_douintvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
+ * @min: minimum allowable value
+ * @max: maximum allowable value
  *
  * The do_proc_douintvec_minmax_conv_param structure provides the
  * minimum and maximum values for doing range checking for those sysctl
  * parameters that use the proc_douintvec_minmax() handler.
  */
 struct do_proc_douintvec_minmax_conv_param {
-	unsigned int *min;
-	unsigned int *max;
+	unsigned int min;
+	unsigned int max;
 };
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
@@ -904,8 +903,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -ERANGE;
 
 		WRITE_ONCE(*valp, tmp);
@@ -936,10 +934,11 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
-	};
+	struct do_proc_douintvec_minmax_conv_param param;
+
+	param.min = (table->extra1) ? *(unsigned int *) table->extra1 : 0;
+	param.max = (table->extra2) ? *(unsigned int *) table->extra2 : UINT_MAX;
+
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -965,23 +964,17 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
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
+	struct do_proc_douintvec_minmax_conv_param param;
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
@@ -1022,7 +1015,7 @@ static int __do_proc_doulongvec_minmax(void *data,
 		void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
-	unsigned long *i, *min, *max;
+	unsigned long *i, min, max;
 	int vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
@@ -1033,8 +1026,9 @@ static int __do_proc_doulongvec_minmax(void *data,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
+	min = (table->extra1) ? *(unsigned long *) table->extra1 : 0;
+	max = (table->extra2) ? *(unsigned long *) table->extra2 : ULONG_MAX;
+
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1066,7 +1060,7 @@ static int __do_proc_doulongvec_minmax(void *data,
 			}
 
 			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max)) {
+			if ((val < min) || (val > max)) {
 				err = -EINVAL;
 				break;
 			}
@@ -1236,8 +1230,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-				(param->max && *param->max < tmp))
+		if ((param->min > tmp) || (param->max < tmp))
 			return -EINVAL;
 		*valp = tmp;
 	}
@@ -1269,10 +1262,10 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int write,
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	param.min = (table->extra1) ? *(int *) table->extra1 : INT_MIN;
+	param.max = (table->extra2) ? *(int *) table->extra2 : INT_MAX;
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


