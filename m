Return-Path: <linux-kernel+bounces-446654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997C9F2799
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599757A1471
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4C0DDAB;
	Mon, 16 Dec 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="EdnHadMU"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C358F49
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734309725; cv=none; b=fJb8kSoeaA+9TqOixUulaTDKuSXMFKskMAg84E7WFlU/w3WqCMi6ac3hSiAxzZQ7NYQSlWWKKR3x2VAbfcaVwiEaAa3YpGHeVsnggFeobN8puVVXGI4rFgLCFt+FxT5KENzc79QnHpaQcbbLa3HOO0S1n+ah866Z2LBk9cACnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734309725; c=relaxed/simple;
	bh=nSYXCv7Z/bKVTSvJE3MUbp8NkYW76YNJJBAJAlkRWY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD5McTiCk3OqFG9ZRn5oBw8ueo00RtRIgthy60vTNiWJSsX8SjZOH5/LbVNqbvtDuPKKFjoAaRtavR/a8JMjGKXwjHspsHW1DubsT3/QjQyxHnizSf/ynZBPQQ/jsxWCMID4zCASFr15nMDCrw4jP8JuhYgj67oeA5IFdtRFDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=EdnHadMU; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734309723;
	bh=Ak4E137BxRWwHua7Mm4mhu/aSYLHuL/rTY58sloG2vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=EdnHadMUmgr7r4hIOT4FUgy7fRvgdd16kUhJv2os4pjD+CqUWxucoGbcFPsT7OzYf
	 THM78NPM80HSMy2SHayB1Nut6wFpbHvIgxnyXvxuoCGM9dwoUIlM4Gp5k0YXBZ7G/t
	 YoSaXyyOUbDacKCefMoUApi0+HKHopMSh9Inqfz4cIUaO+lT5L0Ld+95E9t7zl6D22
	 AFRzEHS8ZA4+hOqdHRKSNzhktrAXDSBMV2E8qD+oYJRJd4NWqwEg4cQJgQ50CYIP+H
	 C1negPcaY8S59P2+wQMKssu1+ZR2dw090h67vUZos955bA1KCLZ/MZgj3T2AXQFu67
	 LWFdcc4ocDnNg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 3F7F5D0015A;
	Mon, 16 Dec 2024 00:41:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Mon, 16 Dec 2024 08:40:45 +0800
Subject: [PATCH v2 6/7] of: Fix potential wrong MODALIAS uevent value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-of_core_fix-v2-6-e69b8f60da63@quicinc.com>
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
In-Reply-To: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

API of_device_uevent_modalias() makes uevent "MODALIAS=ITS_VALUE" in two
steps, namely, produces "MODALIAS=" with add_uevent_var() fistly, then
remainning "ITS_VALUE" with of_modalias() finally, and that may result
in various wrong uevents as explained below:

"MODALIAS=\0"                  // @env->buf is full after the 1st step.
"MODALIAS=ITS_\0"              // @env->buf is not enough during 2nd step.
"MODALIAS=ITS_VAR=VAR_VALUE\0" // another uevent "VAR=VAR_VALUE" comes.

The API depends on uevent internal design, so is not good practice as well.

Fix by:
1) Respin the callee of_modalias() with new prototype which is friendly
   with its callers.
2) Invoke add_uevent_var() to make the whole MODALIAS uevent.
3) Adapt new of_modalias() for its other callers.

BTW, there are no external callers of of_modalias() now.

Closes: https://lore.kernel.org/all/CAL_JsqL+CRmCQMzcF4-A-PRBrCsfK8nduJtOO=RrsDtCUUR7og@mail.gmail.com
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/device.c |  39 +++++++-------------
 drivers/of/module.c | 103 +++++++++++++++++++++++++++++++---------------------
 include/linux/of.h  |   5 +--
 3 files changed, 78 insertions(+), 69 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index f24c19e7aba8e01656f503ae328a4e08aab5a5f3..6355707c200da9ced354132528adbcce24121247 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -195,19 +195,18 @@ EXPORT_SYMBOL(of_device_get_match_data);
 ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
 {
 	ssize_t sl;
+	char *ptr __free(kfree) = NULL;
 
 	if (!dev || !dev->of_node || dev->of_node_reused)
 		return -ENODEV;
 
-	sl = of_modalias(dev->of_node, str, len - 2);
-	if (sl < 0)
-		return sl;
-	if (sl > len - 2)
+	ptr = of_modalias(dev->of_node, &sl);
+	if (IS_ERR(ptr))
+		return PTR_ERR(no_free_ptr(ptr));
+	if (sl + 2 > len)
 		return -ENOMEM;
 
-	str[sl++] = '\n';
-	str[sl] = 0;
-	return sl;
+	return snprintf(str, len, "%s\n", ptr);
 }
 EXPORT_SYMBOL_GPL(of_device_modalias);
 
@@ -256,30 +255,20 @@ EXPORT_SYMBOL_GPL(of_device_uevent);
 
 int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *env)
 {
-	int sl;
-	int pos;
+	int ret;
+	char *ptr;
 
 	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
 		return -ENODEV;
 
-	/* Devicetree modalias is tricky, we add it in 2 steps */
-	if (add_uevent_var(env, "MODALIAS="))
-		return -ENOMEM;
+	ptr = of_modalias(dev->of_node, NULL);
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
 
-	/*
-	 * @env->buflen is pointing to the char after '\0' now
-	 * override the '\0' to save MODALIAS value.
-	 */
-	pos = env->buflen - 1;
-	sl = of_modalias(dev->of_node, &env->buf[pos],
-			 sizeof(env->buf) - pos);
-	if (sl < 0)
-		return sl;
-	if (sl >= (sizeof(env->buf) - pos))
-		return -ENOMEM;
-	env->buflen = pos + sl + 1;
+	ret = add_uevent_var(env, "MODALIAS=%s", ptr);
 
-	return 0;
+	kfree(ptr);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
 
diff --git a/drivers/of/module.c b/drivers/of/module.c
index 1e735fc130ad3ea9046f08bfab2cc9a07914e633..03a2b1b381e5b353b6699dac183c03186afb0486 100644
--- a/drivers/of/module.c
+++ b/drivers/of/module.c
@@ -8,71 +8,92 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
-ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len)
+/*
+ * of_modalias - get MODALIAS string value for a OF device node
+ * @np: the OF device node
+ * @lenp: MODALIAS string length returned if set, exclude '\0'
+ *
+ * This function gets MODALIAS value for a device node.
+ *
+ * Returns MODALIAS string on success, or ERR_PTR() on error.
+ *
+ * Note: please kfree successful return value afer using it.
+ */
+char *of_modalias(const struct device_node *np, ssize_t *lenp)
 {
 	const char *compat;
 	char *c;
 	struct property *p;
 	ssize_t csize;
 	ssize_t tsize;
+	char *str = NULL;
+	ssize_t len = 0;
+	ssize_t pos = 0;
+	int counting = 1;
+
+	if (lenp)
+		*lenp = 0;
 
 	/*
-	 * Prevent a kernel oops in vsnprintf() -- it only allows passing a
-	 * NULL ptr when the length is also 0. Also filter out the negative
-	 * lengths...
+	 * Two cycles controlled by @counting, the fist cycle counts
+	 * chars, the second saves chars.
 	 */
-	if ((len > 0 && !str) || len < 0)
-		return -EINVAL;
+	do {
+		/* Name & Type */
+		/* %p eats all alphanum characters, so %c must be used here */
+		csize = snprintf(str + pos, len - pos, "of:N%pOFn%c%s", np, 'T',
+				 of_node_get_device_type(np));
+		if (counting)
+			tsize = csize;
+		else
+			pos += csize;
 
-	/* Name & Type */
-	/* %p eats all alphanum characters, so %c must be used here */
-	csize = snprintf(str, len, "of:N%pOFn%c%s", np, 'T',
-			 of_node_get_device_type(np));
-	tsize = csize;
-	if (csize >= len)
-		csize = len > 0 ? len - 1 : 0;
-	len -= csize;
-	str += csize;
+		of_property_for_each_string(np, "compatible", p, compat) {
+			csize = snprintf(str + pos, len - pos, "C%s", compat);
+			if (counting) {
+				tsize += csize;
+				continue;
+			}
 
-	of_property_for_each_string(np, "compatible", p, compat) {
-		csize = snprintf(str, len, "C%s", compat);
-		tsize += csize;
-		if (csize >= len)
-			continue;
-		for (c = str; c; ) {
-			c = strchr(c, ' ');
-			if (c)
-				*c++ = '_';
+			for (c = str + pos; c; ) {
+				c = strchr(c, ' ');
+				if (c)
+					*c++ = '_';
+			}
+			pos += csize;
 		}
-		len -= csize;
-		str += csize;
-	}
 
-	return tsize;
+		if (counting) {
+			/* Include '\0' of MODALIAS string. */
+			len = tsize + 1;
+			/* MODALIAS value is too long */
+			if (unlikely(len > 2048))
+				return ERR_PTR(-EINVAL);
+
+			str = kmalloc(len, GFP_KERNEL);
+			if (!str)
+				return ERR_PTR(-ENOMEM);
+		}
+
+	}	while (counting--);
+
+	if (lenp)
+		*lenp = tsize;
+	return str;
 }
 
 int of_request_module(const struct device_node *np)
 {
 	char *str;
-	ssize_t size;
 	int ret;
 
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
-	if (!str)
-		return -ENOMEM;
+	str = of_modalias(np, NULL);
+	if (IS_ERR(str))
+		return PTR_ERR(str);
 
-	of_modalias(np, str, size);
-	str[size - 1] = '\0';
 	ret = request_module(str);
 	kfree(str);
 
diff --git a/include/linux/of.h b/include/linux/of.h
index 7b0da8d352dffd8b872998903282119b6164a5bc..2fcc12de4a9178276a24cd4d6c975495b9eb04a2 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -382,7 +382,7 @@ extern int of_count_phandle_with_args(const struct device_node *np,
 	const char *list_name, const char *cells_name);
 
 /* module functions */
-extern ssize_t of_modalias(const struct device_node *np, char *str, ssize_t len);
+char *of_modalias(const struct device_node *np, ssize_t *lenp);
 extern int of_request_module(const struct device_node *np);
 
 /* phandle iterator functions */
@@ -762,8 +762,7 @@ static inline int of_count_phandle_with_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline ssize_t of_modalias(const struct device_node *np, char *str,
-				  ssize_t len)
+static inline char *of_modalias(const struct device_node *np, ssize_t *lenp)
 {
 	return -ENODEV;
 }

-- 
2.34.1


