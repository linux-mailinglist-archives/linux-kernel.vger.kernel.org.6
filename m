Return-Path: <linux-kernel+bounces-393867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728DA9BA685
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 17:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E21C20C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098E185955;
	Sun,  3 Nov 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="jLmMv8Pa"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CF7081E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730649942; cv=none; b=lpZuYqlmNW31NkdRNvonVCdmQ/6w1X9k2ZTz+M/sWPcRtmobg4epfS7dNORb7uCByHTmaAOrZ+aNsPV60H0PKV5pO7I6TQgI+5F5xUchP8UsbYBLVEFZ5pRwjYuouPzm+MGjGk9D2OxjjORtYfFR92dIpIOiIDBGcNfNj8ljn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730649942; c=relaxed/simple;
	bh=KZ+iLQj0T2o2WZghVKDpgCmaCn3Bxc5QF4QHzV+oTwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g7Umr/ASLfGaDcJBci/YF2sOyQf1AzlglOFO3F/Udde54uFi03p+AmV6eoiN8e8Ii+z5ALpnZuAZz6rv39CURSHDrEEeyuKn6eyOz2xjGEgpFq3czwBY6Utj6+86GwI6Hk5ldNSnZLfZEi/kXMdEui25iW2pgb+1doZL+/RPSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=jLmMv8Pa; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=sLYvPhK748ifX38GduHWW9veoVLTSotaJiOgpQyoN+k=; b=jLmMv8PaWG1t0T0z
	Qd+KFpQ+0jhZo+xpu4fo4yNRYd1uRFN7WrBw9gvmETR5hEOodYvv3RZUrikZXHJI9aBPSjIbDkWbn
	2eHq9ptYhH/FjhnvJVRC7vICwpp0icDtfdsYJ7yDu2VSABDfQUOCL9LSiSJD60UWnMPpyBy/qOqPc
	drrYzY6Ix0gTWdQfddC7TmE522BnskmfuvTHR2lmPY888q/NKtnCbqBepEkBKqnlnyP58JESLtvm3
	YENIlrCgDRtiDNq40TVdUeJL+7wJ0H98DO46cnCuB9oCYC8ooeZ3UArOZTYG4wBjrOcmYmUzgxgv4
	t892bGhEdcpJC3sNeQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7d6e-00FBTA-1p;
	Sun, 03 Nov 2024 16:05:36 +0000
From: linux@treblig.org
To: myungjoo.ham@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] extcon: Remove deadcode
Date: Sun,  3 Nov 2024 16:05:35 +0000
Message-ID: <20241103160535.268705-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

extcon_get_edev_name() has been unused since it was added in 2015 by
commit 707d7550875a ("extcon: Add extcon_get_edev_name() API to get the
extcon device name")

extcon_get_property_capability() has been unused since it was added
in 2016 by
commit ceaa98f442cf ("extcon: Add the support for the capability of each
property")
(It seems everyone just uses extcon_get_property)

extcon_set_property_sync() has been unused since it was added in 2016
by
commit a580982f0836 ("extcon: Add the synchronization extcon APIs to
support the notification")
Everyone seems to use the none _sync version, and there's one place
where they just call sync after it.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/extcon/extcon.c         | 67 ---------------------------------
 include/linux/extcon-provider.h | 10 -----
 include/linux/extcon.h          | 20 +---------
 3 files changed, 1 insertion(+), 96 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7f55c021e56..41a31cc46004 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -755,63 +755,6 @@ int extcon_set_property(struct extcon_dev *edev, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(extcon_set_property);
 
-/**
- * extcon_set_property_sync() - Set property of an external connector with sync.
- * @edev:	the extcon device
- * @id:		the unique id indicating an external connector
- * @prop:	the property id indicating an extcon property
- * @prop_val:	the pointer including the new value of extcon property
- *
- * Note that when setting the property value of external connector,
- * the external connector should be attached. The each property should
- * be included in the list of supported properties according to extcon type.
- *
- * Returns 0 if success or error number if fail.
- */
-int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
-				unsigned int prop,
-				union extcon_property_value prop_val)
-{
-	int ret;
-
-	ret = extcon_set_property(edev, id, prop, prop_val);
-	if (ret < 0)
-		return ret;
-
-	return extcon_sync(edev, id);
-}
-EXPORT_SYMBOL_GPL(extcon_set_property_sync);
-
-/**
- * extcon_get_property_capability() - Get the capability of the property
- *					for an external connector.
- * @edev:	the extcon device
- * @id:		the unique id indicating an external connector
- * @prop:	the property id indicating an extcon property
- *
- * Returns 1 if the property is available or 0 if not available.
- */
-int extcon_get_property_capability(struct extcon_dev *edev, unsigned int id,
-					unsigned int prop)
-{
-	int index;
-
-	if (!edev)
-		return -EINVAL;
-
-	/* Check whether the property is supported or not */
-	if (!is_extcon_property_supported(id, prop))
-		return -EINVAL;
-
-	/* Find the cable index of external connector by using id */
-	index = find_cable_index_by_id(edev, id);
-	if (index < 0)
-		return index;
-
-	return is_extcon_property_capability(edev, id, index, prop);
-}
-EXPORT_SYMBOL_GPL(extcon_get_property_capability);
-
 /**
  * extcon_set_property_capability() - Set the capability of the property
  *					for an external connector.
@@ -1465,16 +1408,6 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
 EXPORT_SYMBOL_GPL(extcon_find_edev_by_node);
 EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
 
-/**
- * extcon_get_edev_name() - Get the name of the extcon device.
- * @edev:	the extcon device
- */
-const char *extcon_get_edev_name(struct extcon_dev *edev)
-{
-	return !edev ? NULL : edev->name;
-}
-EXPORT_SYMBOL_GPL(extcon_get_edev_name);
-
 static int __init extcon_class_init(void)
 {
 	return create_extcon_class();
diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
index fa70945f4e6b..4ed3262f4386 100644
--- a/include/linux/extcon-provider.h
+++ b/include/linux/extcon-provider.h
@@ -55,9 +55,6 @@ int extcon_set_state_sync(struct extcon_dev *edev, unsigned int id,
 int extcon_set_property(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value prop_val);
-int extcon_set_property_sync(struct extcon_dev *edev, unsigned int id,
-				unsigned int prop,
-				union extcon_property_value prop_val);
 int extcon_set_property_capability(struct extcon_dev *edev,
 				unsigned int id, unsigned int prop);
 
@@ -118,13 +115,6 @@ static inline int extcon_set_property(struct extcon_dev *edev, unsigned int id,
 	return 0;
 }
 
-static inline int extcon_set_property_sync(struct extcon_dev *edev,
-				unsigned int id, unsigned int prop,
-				union extcon_property_value prop_val)
-{
-	return 0;
-}
-
 static inline int extcon_set_property_capability(struct extcon_dev *edev,
 				unsigned int id, unsigned int prop)
 {
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index e596a0abcb27..eb55b25e74ae 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -175,19 +175,14 @@ struct extcon_dev;
 int extcon_get_state(struct extcon_dev *edev, unsigned int id);
 
 /*
- * Following APIs get the property of each external connector.
+ * Following API get the property of each external connector.
  * The 'id' argument indicates the defined external connector
  * and the 'prop' indicates the extcon property.
  *
- * And extcon_get_property_capability() get the capability of the property
- * for each external connector. They are used to get the capability of the
- * property of each external connector based on the id and property.
  */
 int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 				unsigned int prop,
 				union extcon_property_value *prop_val);
-int extcon_get_property_capability(struct extcon_dev *edev,
-				unsigned int id, unsigned int prop);
 
 /*
  * Following APIs register the notifier block in order to detect
@@ -228,9 +223,6 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
 struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 						     int index);
 
-/* Following API get the name of extcon device. */
-const char *extcon_get_edev_name(struct extcon_dev *edev);
-
 #else /* CONFIG_EXTCON */
 static inline int extcon_get_state(struct extcon_dev *edev, unsigned int id)
 {
@@ -244,12 +236,6 @@ static inline int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 	return 0;
 }
 
-static inline int extcon_get_property_capability(struct extcon_dev *edev,
-				unsigned int id, unsigned int prop)
-{
-	return 0;
-}
-
 static inline int extcon_register_notifier(struct extcon_dev *edev,
 				unsigned int id, struct notifier_block *nb)
 {
@@ -312,10 +298,6 @@ static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline const char *extcon_get_edev_name(struct extcon_dev *edev)
-{
-	return NULL;
-}
 #endif /* CONFIG_EXTCON */
 
 /*
-- 
2.47.0


