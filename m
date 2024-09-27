Return-Path: <linux-kernel+bounces-341819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3664A9886A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D991C20CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954A4D8AE;
	Fri, 27 Sep 2024 14:02:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DB1C6A5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445766; cv=none; b=kT7MM9t/6bbv3347YWsCvzmUvKVXHzgii+7TrHM8TMK38Tz/vKcLM/3qjtov5JGdzlIvB25sHtPJYde5kNl6rH5hkmoYP+IU6RgOJPTxSGdYIEevwXOm+PGq/SlzKZovVD074JqXEwt64c5rsvknaOyTorqUA06vlkxMApSDwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445766; c=relaxed/simple;
	bh=DbIQG7Ikmt0U5AkqHrtP94Mr5y3++IEU076T+/9xjq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A/B75d/ZBn8cFrVRL0vWhB4XPG/jeqv7AeDjhxAqWVwxv4Q29eqUO8j22GoNcTywUW9zb4POGFS4+rdEQvirBNgyt5c2ZWV1TKPqStSVA4Lzud6xo5YNtxhKK0zGssMdPmIlZbaKwkUl/t+35sLwgFiBbQZ6Abd0sDHOTHIaWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1suBYH-000740-8T; Fri, 27 Sep 2024 16:02:33 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 27 Sep 2024 16:02:32 +0200
Subject: [PATCH] reset: Further simplify locking with guard()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-reset-guard-v1-1-293bf1302210@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAPe69mYC/y3MSwqAMAxF0a1IxhZqKIpuRRyUNmomftIqQnHvF
 nV4HrybIJAwBeiKBEInB16XjKoswM12mUixzwbUaHSLjRIKFNV0WPHKGfSjR4u1ayA/NqGRr7f
 WD5+F9iNH4z/e9wO22c/WcgAAAA==
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use guard(mutex) to automatically unlock mutexes when going out of
scope. Simplify error paths by removing a goto and manual mutex
unlocking in multiple places.

Follow-up to commit 3ec21e7fa854 ("reset: simplify locking with
guard()").

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4d509d41456a..6fbc6f3c14c9 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -676,25 +676,20 @@ int reset_control_acquire(struct reset_control *rstc)
 	if (reset_control_is_array(rstc))
 		return reset_control_array_acquire(rstc_to_array(rstc));
 
-	mutex_lock(&reset_list_mutex);
+	guard(mutex)(&reset_list_mutex);
 
-	if (rstc->acquired) {
-		mutex_unlock(&reset_list_mutex);
+	if (rstc->acquired)
 		return 0;
-	}
 
 	list_for_each_entry(rc, &rstc->rcdev->reset_control_head, list) {
 		if (rstc != rc && rstc->id == rc->id) {
-			if (rc->acquired) {
-				mutex_unlock(&reset_list_mutex);
+			if (rc->acquired)
 				return -EBUSY;
-			}
 		}
 	}
 
 	rstc->acquired = true;
 
-	mutex_unlock(&reset_list_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(reset_control_acquire);
@@ -1041,29 +1036,27 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 		}
 	}
 
-	mutex_lock(&reset_list_mutex);
+	guard(mutex)(&reset_list_mutex);
 	rcdev = __reset_find_rcdev(&args, gpio_fallback);
 	if (!rcdev) {
 		rstc = ERR_PTR(-EPROBE_DEFER);
-		goto out_unlock;
+		goto out_put;
 	}
 
 	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
 		rstc = ERR_PTR(-EINVAL);
-		goto out_unlock;
+		goto out_put;
 	}
 
 	rstc_id = rcdev->of_xlate(rcdev, &args);
 	if (rstc_id < 0) {
 		rstc = ERR_PTR(rstc_id);
-		goto out_unlock;
+		goto out_put;
 	}
 
 	/* reset_list_mutex also protects the rcdev's reset_control list */
 	rstc = __reset_control_get_internal(rcdev, rstc_id, shared, acquired);
 
-out_unlock:
-	mutex_unlock(&reset_list_mutex);
 out_put:
 	of_node_put(args.np);
 
@@ -1098,7 +1091,7 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 	const char *dev_id = dev_name(dev);
 	struct reset_control *rstc = NULL;
 
-	mutex_lock(&reset_lookup_mutex);
+	guard(mutex)(&reset_lookup_mutex);
 
 	list_for_each_entry(lookup, &reset_lookup_list, list) {
 		if (strcmp(lookup->dev_id, dev_id))
@@ -1107,11 +1100,9 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 		if ((!con_id && !lookup->con_id) ||
 		    ((con_id && lookup->con_id) &&
 		     !strcmp(con_id, lookup->con_id))) {
-			mutex_lock(&reset_list_mutex);
+			guard(mutex)(&reset_list_mutex);
 			rcdev = __reset_controller_by_name(lookup->provider);
 			if (!rcdev) {
-				mutex_unlock(&reset_list_mutex);
-				mutex_unlock(&reset_lookup_mutex);
 				/* Reset provider may not be ready yet. */
 				return ERR_PTR(-EPROBE_DEFER);
 			}
@@ -1119,13 +1110,10 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
 							    shared, acquired);
-			mutex_unlock(&reset_list_mutex);
 			break;
 		}
 	}
 
-	mutex_unlock(&reset_lookup_mutex);
-
 	if (!rstc)
 		return optional ? NULL : ERR_PTR(-ENOENT);
 

---
base-commit: 487b1b32e317b85c2948eb4013f3e089a0433d49
change-id: 20240927-reset-guard-c42dfd2a26c7

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


