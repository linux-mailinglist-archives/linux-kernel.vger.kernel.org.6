Return-Path: <linux-kernel+bounces-362569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD7999B67F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BEC8282B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937184A4D;
	Sat, 12 Oct 2024 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZqKWKsJY"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9573D994
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755647; cv=none; b=RyGJ5QXYJC8OF0wXPyCuaJ9BHaCqaJrYR2bnrgmhJzDmcLACXuyWK8bFzrjl5JNeSowoMtySo9mPwDi4+gW+7IGu5GQel1as0JSwoJlcbxECzi/OQXqfL3Z6+IW4SqB7f2v3Ji0/bbizoaCwP41O17FJRF8DR5V/dfgqApGzius=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755647; c=relaxed/simple;
	bh=Ce7SZ0Iu7l8l2ScnSH50KNhgpvs7MkDdV6dsa7AObZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kDjSCZf6zWITqlyG4+YLG9KypwZsYMejGjfQG3fxtIDLN7rse0/kgCK6jPDqQaQq5yTIdY/8+Pk2kuTX3JuCFtMjOnHNOL4pAZT/BgM9diuFNMg73IoHLUDhpdEnP21+KfticpgkgYoPMt/AancsPUZksaJBQOvHZWloGrjdKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZqKWKsJY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728755640;
	bh=Ce7SZ0Iu7l8l2ScnSH50KNhgpvs7MkDdV6dsa7AObZ0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZqKWKsJY86iWnjrfdsggPwDxsoveuZeNexK+rXTn8I3Br0jeIW0WxKUfNya1/mHFx
	 Tx9QuiFw65qdf7hk0Xps1R8/RyUu7FeZqjAMUaiCOZzn2PRNpDtSkl2uFQQMl9o1Ze
	 wQrt2WUC1bwmxXbUQ7aXYZlHOTc6EplVVssYeyr4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 12 Oct 2024 19:52:53 +0200
Subject: [PATCH] reboot: move reboot_notifier_list to kernel/reboot.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241012-reboot_notifier_list-v1-1-6093bb9455ce@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHS3CmcC/x3MwQoCIRRG4VeRu05QC6VeJWLImd/pQmhcJQLx3
 ZNZfotzOlUIo9JNdRJ8uXLJE/akaH098w7N2zQ54y7WWKcFsZS25NI4MWR5c236HHzwVzj4mGi
 mH0Hi37G9P8b4A8kXyuZmAAAA
X-Change-ID: 20241012-reboot_notifier_list-376769e2e6bf
To: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728755639; l=2453;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ce7SZ0Iu7l8l2ScnSH50KNhgpvs7MkDdV6dsa7AObZ0=;
 b=vecaCQDJY+8LVBK0bWkO5ies/I7/F/Imy33Yk/mk6qCUGASU+pO/zvldDaNu6uPg7djXYZtNb
 TraI05FhbgWBELQprQ2HxenEuymQzlf9DKP71ML3VINb8+cI2AEEjwe
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

All the functions related to the reboot notifier list are in
kernel/reboot.c. Move the list itself, too.
As there are no direct users anymore, make the declaration static.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/notifier.h | 2 --
 kernel/notifier.c        | 8 --------
 kernel/reboot.c          | 7 +++++++
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 45702bdcbceb4aa5e42ad7e0fafd71eaf74be9a5..b42e647349688248d8e45e90f997eaca9954c009 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -237,7 +237,5 @@ static inline int notifier_to_errno(int ret)
 #define KBD_KEYSYM		0x0004 /* Keyboard keysym */
 #define KBD_POST_KEYSYM		0x0005 /* Called after keyboard keysym interpretation */
 
-extern struct blocking_notifier_head reboot_notifier_list;
-
 #endif /* __KERNEL__ */
 #endif /* _LINUX_NOTIFIER_H */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index b3ce28f39eb654663eb934cb2d288632c5a56022..2f9fe7c30287f428654112a4956b44129c3ddb16 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -5,18 +5,10 @@
 #include <linux/notifier.h>
 #include <linux/rcupdate.h>
 #include <linux/vmalloc.h>
-#include <linux/reboot.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/notifier.h>
 
-/*
- *	Notifier list for kernel code which wants to be called
- *	at shutdown. This is used to stop any idling DMA operations
- *	and the like.
- */
-BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
-
 /*
  *	Notifier chain core routines.  The exported routines below
  *	are layered on top of these, with appropriate locking added.
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f05dbde2c93fe709ff01491e8a31e0b3c7b66744..ffdf86b717abc0d869a81e1109eaef1e53a5937c 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -72,6 +72,13 @@ static bool poweroff_fallback_to_halt;
  */
 void __weak (*pm_power_off)(void);
 
+/*
+ *	Notifier list for kernel code which wants to be called
+ *	at shutdown. This is used to stop any idling DMA operations
+ *	and the like.
+ */
+static BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
+
 /**
  *	emergency_restart - reboot the system
  *

---
base-commit: 7234e2ea0edd00bfb6bb2159e55878c19885ce68
change-id: 20241012-reboot_notifier_list-376769e2e6bf

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


