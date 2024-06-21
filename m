Return-Path: <linux-kernel+bounces-224893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF621912849
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA2F1F27C09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DB4F60D;
	Fri, 21 Jun 2024 14:45:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD232C182
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981125; cv=none; b=jM/wGkuApkTiSX0LqESDGseGQOkSXC8T2FwLfWUaf3GCyRyhWT1MvfOt1tiO6AIe64tU8eM9znnycE4KBq17xFQy6lsDKCaHJtDeJrT3uahXBTRppH9OqdVmQfwHu5WW9XOqp0aATtrkSK9Hs4gIsFddmRwOPV+lxokVqiSqchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981125; c=relaxed/simple;
	bh=Vr+H0Eg31r75yyu1gzZALDFfArQi3M7lhhLm1v+jA0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vzg/YB0tza4LMAskGE28JlBbB+AsAsw9RaUGJwvAqe6Mk/pQpuuIU3Bf8qv1OU9rUSlmu+LTixaY0tcvFyUzgFmRlD0iiFMOLsBuBa+g59mUBU79c46YN2XDLgGZyLJ4Z3bsAJX4aJ+/7slaPOthQyk0LaIxLIf84Vc4d4oMHy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKfVn-0004LC-DR; Fri, 21 Jun 2024 16:45:11 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 21 Jun 2024 16:45:03 +0200
Subject: [PATCH RFC 2/3] reset: Add devres helpers to request
 pre-deasserted reset controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-reset-get-deasserted-v1-2-94ee76fb7b7d@pengutronix.de>
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

Add devres helpers

 - devm_reset_control_bulk_get_exclusive_deasserted
 - devm_reset_control_bulk_get_optional_exclusive_deasserted
 - devm_reset_control_bulk_get_optional_shared_deasserted
 - devm_reset_control_bulk_get_shared_deasserted
 - devm_reset_control_get_exclusive_deasserted
 - devm_reset_control_get_optional_exclusive_deasserted
 - devm_reset_control_get_optional_shared_deasserted
 - devm_reset_control_get_shared_deasserted

to request and immediately deassert reset controls. During cleanup,
reset_control_assert() will be called automatically on the returned
reset controls.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c  |  44 +++++++++++++++++++-
 include/linux/reset.h | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 3658fe089147..cf4a16da9f34 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1232,13 +1232,23 @@ static void devm_reset_control_release(struct device *dev, void *res)
 	reset_control_put(*(struct reset_control **)res);
 }
 
+static void devm_reset_control_release_deasserted(struct device *dev, void *res)
+{
+	struct reset_control *rstc = *(struct reset_control **)res;
+
+	reset_control_assert(rstc);
+	reset_control_put(rstc);
+}
+
 struct reset_control *
 __devm_reset_control_get(struct device *dev, const char *id, int index,
 			 enum reset_control_flags flags)
 {
 	struct reset_control **ptr, *rstc;
+	bool deasserted = flags & RESET_CONTROL_FLAGS_BIT_DEASSERTED;
 
-	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
+	ptr = devres_alloc(deasserted ? devm_reset_control_release_deasserted :
+			   devm_reset_control_release, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
@@ -1249,6 +1259,17 @@ __devm_reset_control_get(struct device *dev, const char *id, int index,
 		return rstc;
 	}
 
+	if (deasserted) {
+		int ret;
+
+		ret = reset_control_deassert(rstc);
+		if (ret) {
+			reset_control_put(rstc);
+			devres_free(ptr);
+			return ERR_PTR(ret);
+		}
+	}
+
 	*ptr = rstc;
 	devres_add(dev, ptr);
 
@@ -1268,14 +1289,24 @@ static void devm_reset_control_bulk_release(struct device *dev, void *res)
 	reset_control_bulk_put(devres->num_rstcs, devres->rstcs);
 }
 
+static void devm_reset_control_bulk_release_deasserted(struct device *dev, void *res)
+{
+	struct reset_control_bulk_devres *devres = res;
+
+	reset_control_bulk_assert(devres->num_rstcs, devres->rstcs);
+	reset_control_bulk_put(devres->num_rstcs, devres->rstcs);
+}
+
 int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 				  struct reset_control_bulk_data *rstcs,
 				  enum reset_control_flags flags)
 {
 	struct reset_control_bulk_devres *ptr;
+	bool deasserted = flags & RESET_CONTROL_FLAGS_BIT_DEASSERTED;
 	int ret;
 
-	ptr = devres_alloc(devm_reset_control_bulk_release, sizeof(*ptr),
+	ptr = devres_alloc(deasserted ? devm_reset_control_bulk_release_deasserted :
+			   devm_reset_control_bulk_release, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
@@ -1286,6 +1317,15 @@ int __devm_reset_control_bulk_get(struct device *dev, int num_rstcs,
 		return ret;
 	}
 
+	if (deasserted) {
+		ret = reset_control_bulk_deassert(num_rstcs, rstcs);
+		if (ret) {
+			reset_control_bulk_put(num_rstcs, rstcs);
+			devres_free(ptr);
+			return ret;
+		}
+	}
+
 	ptr->num_rstcs = num_rstcs;
 	ptr->rstcs = rstcs;
 	devres_add(dev, ptr);
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 99296af98f81..2986ced69a02 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -28,6 +28,7 @@ struct reset_control_bulk_data {
 #define RESET_CONTROL_FLAGS_BIT_SHARED		BIT(0)	/* not exclusive */
 #define RESET_CONTROL_FLAGS_BIT_OPTIONAL	BIT(1)
 #define RESET_CONTROL_FLAGS_BIT_ACQUIRED	BIT(2)	/* iff exclusive, not released */
+#define RESET_CONTROL_FLAGS_BIT_DEASSERTED	BIT(3)
 
 /**
  * enum reset_control_flags - Flags that can be passed to the reset_control_get functions
@@ -35,21 +36,35 @@ struct reset_control_bulk_data {
  *                    These values cannot be OR'd.
  *
  * @RESET_CONTROL_EXCLUSIVE:				exclusive, acquired,
+ * @RESET_CONTROL_EXCLUSIVE_DEASSERTED:			exclusive, acquired, deasserted
  * @RESET_CONTROL_EXCLUSIVE_RELEASED:			exclusive, released,
  * @RESET_CONTROL_SHARED:				shared
+ * @RESET_CONTROL_SHARED_DEASSERTED:			shared, deasserted
  * @RESET_CONTROL_OPTIONAL_EXCLUSIVE:			optional, exclusive, acquired
+ * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_DEASSERTED:	optional, exclusive, acquired, deasserted
  * @RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED:		optional, exclusive, released
  * @RESET_CONTROL_OPTIONAL_SHARED:			optional, shared
+ * @RESET_CONTROL_OPTIONAL_SHARED_DEASSERTED:		optional, shared, deasserted
  */
 enum reset_control_flags {
 	RESET_CONTROL_EXCLUSIVE				= RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_EXCLUSIVE_DEASSERTED		= RESET_CONTROL_FLAGS_BIT_ACQUIRED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_EXCLUSIVE_RELEASED		= 0,
 	RESET_CONTROL_SHARED				= RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_SHARED_DEASSERTED			= RESET_CONTROL_FLAGS_BIT_SHARED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_OPTIONAL_EXCLUSIVE		= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
 							  RESET_CONTROL_FLAGS_BIT_ACQUIRED,
+	RESET_CONTROL_OPTIONAL_EXCLUSIVE_DEASSERTED	= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_ACQUIRED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 	RESET_CONTROL_OPTIONAL_EXCLUSIVE_RELEASED	= RESET_CONTROL_FLAGS_BIT_OPTIONAL,
 	RESET_CONTROL_OPTIONAL_SHARED			= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
 							  RESET_CONTROL_FLAGS_BIT_SHARED,
+	RESET_CONTROL_OPTIONAL_SHARED_DEASSERTED	= RESET_CONTROL_FLAGS_BIT_OPTIONAL |
+							  RESET_CONTROL_FLAGS_BIT_SHARED |
+							  RESET_CONTROL_FLAGS_BIT_DEASSERTED,
 };
 
 #ifdef CONFIG_RESET_CONTROLLER
@@ -596,6 +611,25 @@ __must_check devm_reset_control_get_exclusive(struct device *dev,
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE);
 }
 
+/**
+ * devm_reset_control_get_exclusive_deasserted - resource managed
+ *                                    reset_control_get_exclusive() +
+ *                                    reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_exclusive() + reset_control_deassert(). For reset
+ * controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See reset_control_get_exclusive() for more information.
+ */
+static inline struct reset_control * __must_check
+devm_reset_control_get_exclusive_deasserted(struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_EXCLUSIVE_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_exclusive - resource managed
  *                                         reset_control_bulk_get_exclusive()
@@ -712,6 +746,25 @@ static inline struct reset_control *devm_reset_control_get_shared(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED);
 }
 
+/**
+ * devm_reset_control_get_shared_deasserted - resource managed
+ *                                            reset_control_get_shared() +
+ *                                            reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_shared() + reset_control_deassert(). For reset
+ * controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_shared() for more information.
+ */
+static inline struct reset_control * __must_check
+devm_reset_control_get_shared_deasserted(struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_SHARED_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_shared - resource managed
  *                                      reset_control_bulk_get_shared()
@@ -732,6 +785,28 @@ devm_reset_control_bulk_get_shared(struct device *dev, int num_rstcs,
 	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, RESET_CONTROL_SHARED);
 }
 
+/**
+ * devm_reset_control_bulk_get_shared_deasserted - resource managed
+ *                                                 reset_control_bulk_get_shared() +
+ *                                                 reset_control_bulk_deassert()
+ * @dev: device to be reset by the controller
+ * @num_rstcs: number of entries in rstcs array
+ * @rstcs: array of struct reset_control_bulk_data with reset line names set
+ *
+ * Managed reset_control_bulk_get_shared() + reset_control_bulk_deassert(). For
+ * reset controllers returned from this function, reset_control_bulk_assert() +
+ * reset_control_bulk_put() are called automatically on driver detach.
+ *
+ * See devm_reset_control_bulk_get_shared() for more information.
+ */
+static inline int __must_check
+devm_reset_control_bulk_get_shared_deasserted(struct device *dev, int num_rstcs,
+					      struct reset_control_bulk_data *rstcs)
+{
+	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs,
+					     RESET_CONTROL_SHARED_DEASSERTED);
+}
+
 /**
  * devm_reset_control_get_optional_exclusive - resource managed
  *                                             reset_control_get_optional_exclusive()
@@ -750,6 +825,25 @@ static inline struct reset_control *devm_reset_control_get_optional_exclusive(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE);
 }
 
+/**
+ * devm_reset_control_get_optional_exclusive_deasserted - resource managed
+ *                                                        reset_control_get_optional_exclusive() +
+ *                                                        reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_exclusive() + reset_control_deassert().
+ * For reset controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_optional_exclusive() for more information.
+ */
+static inline struct reset_control *
+devm_reset_control_get_optional_exclusive_deasserted(struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_EXCLUSIVE_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_optional_exclusive - resource managed
  *                                                  reset_control_bulk_get_optional_exclusive()
@@ -789,6 +883,25 @@ static inline struct reset_control *devm_reset_control_get_optional_shared(
 	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED);
 }
 
+/**
+ * devm_reset_control_get_optional_shared_deasserted - resource managed
+ *                                                     reset_control_get_optional_shared() +
+ *                                                     reset_control_deassert()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get_optional_shared() + reset_control_deassert(). For
+ * reset controllers returned from this function, reset_control_assert() +
+ * reset_control_put() is called automatically on driver detach.
+ *
+ * See devm_reset_control_get_optional_shared() for more information.
+ */
+static inline struct reset_control *
+devm_reset_control_get_optional_shared_deasserted(struct device *dev, const char *id)
+{
+	return __devm_reset_control_get(dev, id, 0, RESET_CONTROL_OPTIONAL_SHARED_DEASSERTED);
+}
+
 /**
  * devm_reset_control_bulk_get_optional_shared - resource managed
  *                                               reset_control_bulk_get_optional_shared()

-- 
2.39.2


