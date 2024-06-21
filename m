Return-Path: <linux-kernel+bounces-224894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F3991284A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45BC51C2108C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684EC57CBB;
	Fri, 21 Jun 2024 14:45:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54B18E3F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981125; cv=none; b=Fy6PJ3x4kxiv69nCKtzldkX4rr8KpsX8VGUrc/lmOBSYls+fFgWK3FdAneNr020LXSzL3r989/oX8s87XcLKER24KxytDC0eLBIIi/BHKoXMfETIaiFqQRHR529YOljKtov0M7AXwfLpAno/F9NBWsdme438vAp/Vx3UodcVUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981125; c=relaxed/simple;
	bh=0P7gsjVEu25LgV/vOE0esGPK2ifxNQtyqNYVuXvYGQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paIiMD1ygWiXo0/AvPh2PBehcCjCmQ6i6DOZL2PrAVnas7DtuNP2f8HD1uA/ItUwx/lm7n7XYgyAaNLzKH6eHIOk5Q3Z7Ciy7DD5hFpNi5ghHAXo4x641HJ7GXubHxHpBukdDyTX6FzFxXIBiwSuv5kIQJmaQotAVGgcqUA5vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKfVn-0004LC-C8; Fri, 21 Jun 2024 16:45:11 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 21 Jun 2024 16:45:02 +0200
Subject: [PATCH RFC 1/3] reset: replace boolean parameters with flags
 parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-reset-get-deasserted-v1-1-94ee76fb7b7d@pengutronix.de>
References: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
In-Reply-To: <20240621-reset-get-deasserted-v1-0-94ee76fb7b7d@pengutronix.de>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Introduce enum reset_control_flags and replace the list of boolean
parameters to the internal reset_control_get functions with a single
flags parameter, before adding more boolean options.

The separate boolean parameters have been shown to be error prone in
the past. See for example commit a57f68ddc886 ("reset: Fix devm bulk
optional exclusive control getter").

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c  |  59 +++++++++---------
 include/linux/reset.h | 161 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 129 insertions(+), 91 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index dba74e857be6..3658fe089147 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -773,8 +773,10 @@ EXPORT_SYMBOL_GPL(reset_control_bulk_release);
 
 static struct reset_control *
 __reset_control_get_internal(struct reset_controller_dev *rcdev,
-			     unsigned int index, bool shared, bool acquired)
+			     unsigned int index, enum reset_control_flags flags)
 {
+	bool shared = flags & RESET_CONTROL_FLAGS_BIT_SHARED;
+	bool acquired = flags & RESET_CONTROL_FLAGS_BIT_ACQUIRED;
 	struct reset_control *rstc;
 
 	lockdep_assert_held(&reset_list_mutex);
@@ -999,8 +1001,9 @@ static struct reset_controller_dev *__reset_find_rcdev(const struct of_phandle_a
 
 struct reset_control *
 __of_reset_control_get(struct device_node *node, const char *id, int index,
-		       bool shared, bool optional, bool acquired)
+		       enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	bool gpio_fallback = false;
 	struct reset_control *rstc;
 	struct reset_controller_dev *rcdev;
@@ -1065,7 +1068,7 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
-	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
+	rstc = __reset_control_get_internal(rcdev, rstc_id, flags);
 
 out_unlock:
 	mutex_unlock(&reset_list_mutex);
@@ -1096,8 +1099,9 @@ __reset_controller_by_name(const char *name)
 
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
-				bool shared, bool optional, bool acquired)
+				enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
 	const char *dev_id = dev_name(dev);
@@ -1123,7 +1127,7 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 
 			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
-							    shared, acquired);
+							    flags);
 			mutex_unlock(&reset_list_mutex);
 			break;
 		}
@@ -1138,30 +1142,29 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 }
 
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
-					  int index, bool shared, bool optional,
-					  bool acquired)
+					  int index, enum reset_control_flags flags)
 {
+	bool shared = flags & RESET_CONTROL_FLAGS_BIT_SHARED;
+	bool acquired = flags & RESET_CONTROL_FLAGS_BIT_ACQUIRED;
+
 	if (WARN_ON(shared && acquired))
 		return ERR_PTR(-EINVAL);
 
 	if (dev->of_node)
-		return __of_reset_control_get(dev->of_node, id, index, shared,
-					      optional, acquired);
+		return __of_reset_control_get(dev->of_node, id, index, flags);
 
-	return __reset_control_get_from_lookup(dev, id, shared, optional,
-					       acquired);
+	return __reset_control_get_from_lookup(dev, id, flags);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
-			     bool shared, bool optional, bool acquired)
+			     enum reset_control_flags flags)
 {
 	int ret, i;
 
 	for (i = 0; i < num_rstcs; i++) {
-		rstcs[i].rstc = __reset_control_get(dev, rstcs[i].id, 0,
-						    shared, optional, acquired);
+		rstcs[i].rstc = __reset_control_get(dev, rstcs[i].id, 0, flags);
 		if (IS_ERR(rstcs[i].rstc)) {
 			ret = PTR_ERR(rstcs[i].rstc);
 			goto err;
@@ -1231,7 +1234,7 @@ static void devm_reset_control_release(struct device *dev, void *res)
 
 struct reset_control *
 __devm_reset_control_get(struct device *dev, const char *id, int index,
-			 bool shared, bool optional, bool acquired)
+			 enum reset_control_flags flags)
 {
 	struct reset_control **ptr, *rstc;
 
@@ -1240,7 +1243,7 @@ __devm_reset_control_get(struct device *dev, const char *id, int index,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
+	rstc = __reset_control_get(dev, id, index, flags);
 	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
 		return rstc;
@@ -1267,7 +1270,7 @@ static void devm_reset_control_bulk_release(struct device *dev, void *res)
 
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
-				  bool shared, bool optional, bool acquired)
+				  enum reset_control_flags flags)
 {
 	struct reset_control_bulk_devres *ptr;
 	int ret;
@@ -1277,7 +1280,7 @@ int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 	if (!ptr)
 		return -ENOMEM;
 
-	ret = __reset_control_bulk_get(dev, num_rstcs, rstcs, shared, optional, acquired);
+	ret = __reset_control_bulk_get(dev, num_rstcs, rstcs, flags);
 	if (ret < 0) {
 		devres_free(ptr);
 		return ret;
@@ -1303,6 +1306,7 @@ EXPORT_SYMBOL_GPL(__devm_reset_control_bulk_get);
  */
 int __device_reset(struct device *dev, bool optional)
 {
+	enum reset_control_flags flags;
 	struct reset_control *rstc;
 	int ret;
 
@@ -1318,7 +1322,8 @@ int __device_reset(struct device *dev, bool optional)
 	}
 #endif
 
-	rstc = __reset_control_get(dev, NULL, 0, 0, optional, true);
+	flags = optional ? RESET_CONTROL_OPTIONAL_EXCLUSIVE : RESET_CONTROL_EXCLUSIVE;
+	rstc = __reset_control_get(dev, NULL, 0, flags);
 	if (IS_ERR(rstc))
 		return PTR_ERR(rstc);
 
@@ -1361,17 +1366,14 @@ static int of_reset_control_get_count(struct device_node *node)
  *				device node.
  *
  * @np: device node for the device that requests the reset controls array
- * @shared: whether reset controls are shared or not
- * @optional: whether it is optional to get the reset controls
- * @acquired: only one reset control may be acquired for a given controller
- *            and ID
+ * @flags: whether reset controls are shared, optional, acquired
  *
  * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
-			   bool acquired)
+of_reset_control_array_get(struct device_node *np, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
 	struct reset_control_array *resets;
 	struct reset_control *rstc;
 	int num, i;
@@ -1386,8 +1388,7 @@ of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
 	resets->num_rstcs = num;
 
 	for (i = 0; i < num; i++) {
-		rstc = __of_reset_control_get(np, NULL, i, shared, optional,
-					      acquired);
+		rstc = __of_reset_control_get(np, NULL, i, flags);
 		if (IS_ERR(rstc))
 			goto err_rst;
 		resets->rstc[i] = rstc;
@@ -1422,7 +1423,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
  * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
-devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
+devm_reset_control_array_get(struct device *dev, enum reset_control_flags flags)
 {
 	struct reset_control **ptr, *rstc;
 
@@ -1431,7 +1432,7 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
+	rstc = of_reset_control_array_get(dev->of_node, flags);
 	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(ptr);
 		return rstc;
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 514ddf003efc..99296af98f81 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -25,6 +25,33 @@ struct reset_control_bulk_data {
 	struct reset_control		*rstc;
 };
 
+#define RESET_CONTROL_FLAGS_BIT_SHARED		BIT(0)	/* not exclusive */
+#define RESET_CONTROL_FLAGS_BIT_OPTIONAL	BIT(1)
+#define RESET_CONTROL_FLAGS_BIT_ACQUIRED	BIT(2)	/* iff exclusive, not released */
+
+/**
+ * enum reset_control_flags - Flags that can be passed to the reset_control_get functions
+ *                    to determine the type of reset control.
+ *                    These values cannot be OR'd.
+ *
+ * @RESET_CONTROL_EXCLUSIVE:				exclusive, acquired,
+ * @RESET_CONTROL_EXCLUSIVE_RELEASED:			exclusive, released,
+ * @RESET_CONTROL_SHARED:				shared
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE:			optional, exclusive, acquired
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED:		optional, exclusive, released
+ * @RESET_CONTROL_OPTIONAL_SHARED:			optional, shared
+ */
+enum reset_control_flags {
+	RESET_CONTROL_EXCLUSIVE				= RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_EXCLUSIVE_RELEASED		= 0,
+	RESET_CONTROL_SHARED				= RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE		= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED	= RESET_CONTROL_FLAGS_BIT_OPTIONAL,
+	RESET_CONTROL_OPTIONAL_SHARED			= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_SHARED,
+};
+
 #ifdef CONFIG_RESET_CONTROLLER
 
 int reset_control_reset(struct reset_control *rstc);
@@ -42,30 +69,25 @@ int reset_control_bulk_acquire(int num_rstcs, struct reset_control_bulk_data *rs
 void reset_control_bulk_release(int num_rstcs, struct reset_control_bulk_data *rstcs);
 
 struct reset_control *__of_reset_control_get(struct device_node *node,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired);
+				     const char *id, int index, enum reset_control_flags flags);
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
-					  int index, bool shared,
-					  bool optional, bool acquired);
+					  int index, enum reset_control_flags flags);
 void reset_control_put(struct reset_control *rstc);
 int __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			     struct reset_control_bulk_data *rstcs,
-			     bool shared, bool optional, bool acquired);
+			     enum reset_control_flags flags);
 void reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data *rstcs);
 
 int __device_reset(struct device *dev, bool optional);
 struct reset_control *__devm_reset_control_get(struct device *dev,
-				     const char *id, int index, bool shared,
-				     bool optional, bool acquired);
+				     const char *id, int index, enum reset_control_flags flags);
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
-				  bool shared, bool optional, bool acquired);
+				  enum reset_control_flags flags);
 
 struct reset_control *devm_reset_control_array_get(struct device *dev,
-						   bool shared, bool optional);
-struct reset_control *of_reset_control_array_get(struct device_node *np,
-						 bool shared, bool optional,
-						 bool acquired);
+						   enum reset_control_flags flags);
+struct reset_control *of_reset_control_array_get(struct device_node *np, enum reset_control_flags);
 
 int reset_control_get_count(struct device *dev);
 
@@ -116,17 +138,19 @@ static inline int __device_reset(struct device *dev, bool optional)
 
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
-					const char *id, int index, bool shared,
-					bool optional, bool acquired)
+					const char *id, int index, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *__reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional,
-					bool acquired)
+					int index, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
@@ -162,8 +186,10 @@ reset_control_bulk_release(int num_rstcs, struct reset_control_bulk_data *rstcs)
 static inline int
 __reset_control_bulk_get(struct device *dev, int num_rstcs,
 			 struct reset_control_bulk_data *rstcs,
-			 bool shared, bool optional, bool acquired)
+			 enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? 0 : -EOPNOTSUPP;
 }
 
@@ -174,30 +200,36 @@ reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data *rstcs)
 
 static inline struct reset_control *__devm_reset_control_get(
 					struct device *dev, const char *id,
-					int index, bool shared, bool optional,
-					bool acquired)
+					int index, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline int
 __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 			      struct reset_control_bulk_data *rstcs,
-			      bool shared, bool optional, bool acquired)
+			      enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? 0 : -EOPNOTSUPP;
 }
 
 static inline struct reset_control *
-devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
+devm_reset_control_array_get(struct device *dev, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
 static inline struct reset_control *
-of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
-			   bool acquired)
+of_reset_control_array_get(struct device_node *np, enum reset_control_flags flags)
 {
+	bool optional = flags & RESET_CONTROL_FLAGS_BIT_OPTIONAL;
+
 	return optional ? NULL : ERR_PTR(-ENOTSUPP);
 }
 
@@ -236,7 +268,7 @@ static inline int device_reset_optional(struct device *dev)
 static inline struct reset_control *
 __must_check reset_control_get_exclusive(struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false, true);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -253,7 +285,7 @@ static inline int __must_check
 reset_control_bulk_get_exclusive(struct device *dev, int num_rstcs,
 				 struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, true);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -274,7 +306,7 @@ static inline struct reset_control *
 __must_check reset_control_get_exclusive_released(struct device *dev,
 						  const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, false, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -295,7 +327,7 @@ static inline int __must_check
 reset_control_bulk_get_exclusive_released(struct device *dev, int num_rstcs,
 					  struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, false);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -316,7 +348,8 @@ static inline int __must_check
 reset_control_bulk_get_optional_exclusive_released(struct device *dev, int num_rstcs,
 						   struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, false);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs,
+					RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -344,7 +377,7 @@ reset_control_bulk_get_optional_exclusive_released(struct device *dev, int num_r
 static inline struct reset_control *reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, false, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -361,7 +394,7 @@ static inline int __must_check
 reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 			      struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, false);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -378,7 +411,7 @@ reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 static inline struct reset_control *reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, false, true, true);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 /**
@@ -398,7 +431,7 @@ static inline int __must_check
 reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
 					  struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 /**
@@ -415,7 +448,7 @@ reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
 static inline struct reset_control *reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __reset_control_get(dev, id, 0, true, true, false);
+	return __reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
 /**
@@ -435,7 +468,7 @@ static inline int __must_check
 reset_control_bulk_get_optional_shared(struct device *dev, int num_rstcs,
 				       struct reset_control_bulk_data *rstcs)
 {
-	return __reset_control_bulk_get(dev, num_rstcs, rstcs, true, true, false);
+	return __reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
 /**
@@ -451,7 +484,7 @@ reset_control_bulk_get_optional_shared(struct device *dev, int num_rstcs,
 static inline struct reset_control *of_reset_control_get_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, false, true);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -471,7 +504,7 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 static inline struct reset_control *of_reset_control_get_optional_exclusive(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, false, true, true);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 /**
@@ -496,7 +529,7 @@ static inline struct reset_control *of_reset_control_get_optional_exclusive(
 static inline struct reset_control *of_reset_control_get_shared(
 				struct device_node *node, const char *id)
 {
-	return __of_reset_control_get(node, id, 0, true, false, false);
+	return __of_reset_control_get(node, id, 0, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -513,7 +546,7 @@ static inline struct reset_control *of_reset_control_get_shared(
 static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, false, false, true);
+	return __of_reset_control_get(node, NULL, index, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -541,7 +574,7 @@ static inline struct reset_control *of_reset_control_get_exclusive_by_index(
 static inline struct reset_control *of_reset_control_get_shared_by_index(
 					struct device_node *node, int index)
 {
-	return __of_reset_control_get(node, NULL, index, true, false, false);
+	return __of_reset_control_get(node, NULL, index, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -560,7 +593,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive(struct device *dev,
 					      const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false, true);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -580,7 +613,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_exclusive(struct device *dev, int num_rstcs,
 				      struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, true);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -599,7 +633,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_exclusive_released(struct device *dev,
 						       const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, false, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -619,7 +653,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_exclusive_released(struct device *dev, int num_rstcs,
 					       struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, false, false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -638,7 +673,7 @@ static inline struct reset_control *
 __must_check devm_reset_control_get_optional_exclusive_released(struct device *dev,
 								const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -658,7 +693,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_exclusive_released(struct device *dev, int num_rstcs,
 							struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED);
 }
 
 /**
@@ -673,7 +709,7 @@ devm_reset_control_bulk_get_optional_exclusive_released(struct device *dev, int
 static inline struct reset_control *devm_reset_control_get_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, false, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -693,7 +729,7 @@ static inline int __must_check
 devm_reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 				   struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_SHARED);
 }
 
 /**
@@ -711,7 +747,7 @@ devm_reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, false, true, true);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 /**
@@ -731,7 +767,8 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
 					       struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 /**
@@ -749,7 +786,7 @@ devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs
 static inline struct reset_control *devm_reset_control_get_optional_shared(
 					struct device *dev, const char *id)
 {
-	return __devm_reset_control_get(dev, id, 0, true, true, false);
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
 /**
@@ -769,7 +806,7 @@ static inline int __must_check
 devm_reset_control_bulk_get_optional_shared(struct device *dev, int num_rstcs,
 					    struct reset_control_bulk_data *rstcs)
 {
-	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, true, false);
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
 /**
@@ -787,7 +824,7 @@ devm_reset_control_bulk_get_optional_shared(struct device *dev, int num_rstcs,
 static inline struct reset_control *
 devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, false, false, true);
+	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_EXCLUSIVE);
 }
 
 /**
@@ -803,7 +840,7 @@ devm_reset_control_get_exclusive_by_index(struct device *dev, int index)
 static inline struct reset_control *
 devm_reset_control_get_shared_by_index(struct device *dev, int index)
 {
-	return __devm_reset_control_get(dev, NULL, index, true, false, false);
+	return __devm_reset_control_get(dev, NULL, index, RESET_CONTROL_SHARED);
 }
 
 /*
@@ -851,54 +888,54 @@ static inline struct reset_control *devm_reset_control_get_by_index(
 static inline struct reset_control *
 devm_reset_control_array_get_exclusive(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, false, false);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE);
 }
 
 static inline struct reset_control *
 devm_reset_control_array_get_shared(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, true, false);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_SHARED);
 }
 
 static inline struct reset_control *
 devm_reset_control_array_get_optional_exclusive(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, false, true);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 static inline struct reset_control *
 devm_reset_control_array_get_optional_shared(struct device *dev)
 {
-	return devm_reset_control_array_get(dev, true, true);
+	return devm_reset_control_array_get(dev, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, false, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_EXCLUSIVE);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_exclusive_released(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, false, false);
+	return of_reset_control_array_get(node, RESET_CONTROL_EXCLUSIVE_RELEASED);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, false, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_SHARED);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_optional_exclusive(struct device_node *node)
 {
-	return of_reset_control_array_get(node, false, true, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
 static inline struct reset_control *
 of_reset_control_array_get_optional_shared(struct device_node *node)
 {
-	return of_reset_control_array_get(node, true, true, true);
+	return of_reset_control_array_get(node, RESET_CONTROL_OPTIONAL_SHARED);
 }
 #endif

-- 
2.39.2


