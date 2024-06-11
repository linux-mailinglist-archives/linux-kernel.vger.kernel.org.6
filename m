Return-Path: <linux-kernel+bounces-209894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D9903C99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A001F23C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6AF17D8A0;
	Tue, 11 Jun 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rcbNm3cf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7817D88E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110889; cv=none; b=Kx+hZP6LAN7pysEXKhJQOUEnsMZKG7Dit9kfGM49FiSpvmX/dECqWA4iYqoe3Gxt1Z7i5BwALYMYxPTU4PU3s4a5j8K+O6SRNrCUXGgEkE7eOTR6123C7sY6LbHYxezHx+53x4sktI2rJihWtxVW38c4DqF9eHIyD6EZZMLySM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110889; c=relaxed/simple;
	bh=xtPXOUuB/wx/UU4cCnsOq18427qwbgXoc0E4MoJVc2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI5Eu3/lXFRK3U3WT6QjC9l8nuOoprdUmGwlZoT6rkH7+KltPZiEz6biEi83OE6MP7bg9EpOkSWP1wb1uO1cVnWRQR0lTr3ouh/m27ksXeCzc2CP86BHpQmDOY7HSBZZJDarbQPevCQr8kdKQRsEvbPqcP29pH/WKtmSFqmnvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rcbNm3cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F05C4AF49;
	Tue, 11 Jun 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110889;
	bh=xtPXOUuB/wx/UU4cCnsOq18427qwbgXoc0E4MoJVc2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcbNm3cfoURrrctq1sU+5U837WEiUPojwtuJa7WKnNWgCS+iWc21L1rfZ9UpqsynD
	 1qmwgAlvU0V9XrkWNsDsAkjDOypOXgux/2gfutyLB71N45rQCE0BKZOODJKBjDNdz0
	 dM0AdB41N4uzJjsDj2m/5CljcJleiBpW2ZsFO8po=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/6] driver core: mark async_driver as a const *
Date: Tue, 11 Jun 2024 15:01:09 +0200
Message-ID: <20240611130103.3262749-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3617; i=gregkh@linuxfoundation.org; h=from:subject; bh=xtPXOUuB/wx/UU4cCnsOq18427qwbgXoc0E4MoJVc2I=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkZXpMq0nsfWN1qf8KlPzPxkv4iizuzNrhMSnb+cipT+ +stW2OhjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZjIZD2GBVvN2jsmBLbE7rq9 f8La+bv/T1Thr2WYn7BJ0IRRtd3W48HG9zVLGHZJ89btBgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Within struct device_private, mark the async_driver * as const as it is
never modified.  This requires some internal-to-the-driver-core
functions to also have their parameters marked as constant, and there is
one place where we cast _back_ from the const pointer to a real one, as
the driver core still wants to modify the structure in a number of
remaining places.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h |  2 +-
 drivers/base/dd.c   | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 9df8028c3201..50151e7db796 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -112,7 +112,7 @@ struct device_private {
 	struct klist_node knode_bus;
 	struct klist_node knode_class;
 	struct list_head deferred_probe;
-	struct device_driver *async_driver;
+	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
 	struct device *device;
 	u8 dead:1;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 76b26096b033..8ec22229e259 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -568,7 +568,7 @@ static void device_remove(struct device *dev)
 		dev->driver->remove(dev);
 }
 
-static int call_driver_probe(struct device *dev, struct device_driver *drv)
+static int call_driver_probe(struct device *dev, const struct device_driver *drv)
 {
 	int ret = 0;
 
@@ -599,7 +599,7 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
 	return ret;
 }
 
-static int really_probe(struct device *dev, struct device_driver *drv)
+static int really_probe(struct device *dev, const struct device_driver *drv)
 {
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
 			   !drv->suppress_bind_attrs;
@@ -628,7 +628,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	}
 
 re_probe:
-	dev->driver = drv;
+	// FIXME - this cast should not be needed "soon"
+	dev->driver = (struct device_driver *)drv;
 
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
@@ -727,7 +728,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 /*
  * For initcall_debug, show the driver probe time.
  */
-static int really_probe_debug(struct device *dev, struct device_driver *drv)
+static int really_probe_debug(struct device *dev, const struct device_driver *drv)
 {
 	ktime_t calltime, rettime;
 	int ret;
@@ -774,7 +775,7 @@ void wait_for_device_probe(void)
 }
 EXPORT_SYMBOL_GPL(wait_for_device_probe);
 
-static int __driver_probe_device(struct device_driver *drv, struct device *dev)
+static int __driver_probe_device(const struct device_driver *drv, struct device *dev)
 {
 	int ret = 0;
 
@@ -819,7 +820,7 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
  *
  * If the device has a parent, runtime-resume the parent before driver probing.
  */
-static int driver_probe_device(struct device_driver *drv, struct device *dev)
+static int driver_probe_device(const struct device_driver *drv, struct device *dev)
 {
 	int trigger_count = atomic_read(&deferred_trigger_count);
 	int ret;
@@ -1137,7 +1138,7 @@ EXPORT_SYMBOL_GPL(device_driver_attach);
 static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
 {
 	struct device *dev = _dev;
-	struct device_driver *drv;
+	const struct device_driver *drv;
 	int ret;
 
 	__device_driver_lock(dev, dev->parent);
-- 
2.45.2


