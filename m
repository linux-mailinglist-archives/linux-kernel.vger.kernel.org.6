Return-Path: <linux-kernel+bounces-334805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF1B97DC62
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5011C20D8A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8815382F;
	Sat, 21 Sep 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XeprdRyP"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF07DA6E
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911026; cv=none; b=oJEdAc86+Wa53vAlJ7LRIap3vk5cSBouBP4szldqCYXC1NFnZT0F1Ii4D7GbAl3lioXs/T/e9tGSEX3SbzMZjAzumVIVxzdX5EFgt06WjQYdWN0Z9RTkfnfEOVtDF6YlbPxzUqSJA3jmS095s6WvHzWpqmYeS+6dx4YQrfWdyRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911026; c=relaxed/simple;
	bh=+1oXdbzc8YQyfx4VNcNpGPvIBpzFoet1qxJgna9qKO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jaNw1NFdAA9RN+wBo5j4XxHZ/fgia/RD8x33/L2WM4wwpasNlthdTQfQsmb/54QlH2Ft8zSxbqSq8GFHdLMlxuV0h0OrcOpq19ZK/inEzpGJxwMUBP3M/Mz34BMQ4J24Z2xoR1hZiKsVK1IggZVfIkM8tvbZa1asKGWS1AzHcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XeprdRyP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726911021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vuFugV91Sk1vI2o8W8MmeKS5FmNjtYkmk4pOcg3mZZw=;
	b=XeprdRyP9KWV/lsLH3eBLymw6otwIz9fnyqLtEJbElJitMsDVgm+I+h6Y6ZN4P84jz9x5K
	tZ3EmLzhAOWOMZa6c41AdqgS888VeeBz7bUcEs1wlOZKyJWAXSIxK++NxsWxsO71XtCOoz
	QCh7UKr7KW7oDsHRR9Jw2c9XMAp2JSU=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 2/5] sysctl: support encoding values directly in the table entry
Date: Sat, 21 Sep 2024 17:29:01 +0800
Message-Id: <a086609632328c2feee69b10067e43115885b2ae.1726910671.git.wen.yang@linux.dev>
In-Reply-To: <cover.1726910671.git.wen.yang@linux.dev>
References: <cover.1726910671.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Eric points out: "by turning .extra1 and .extra2 into longs instead of
keeping them as pointers and needing constants to be pointed at somewhere
.. The only people I can see who find a significant benefit by
consolidating all of the constants into one place are people who know how
to stomp kernel memory."

This patch supports encoding values directly in table entries through the
following work:
- extra1/extra2 and min/max are placed in one union to ensure compatibility
  with previous code without increasing memory overhead, and then we could
  gradually remove these unnecessary extra1/extra2.
- two bits were used to represent the information of the above union:
  SYSCTL_FLAG_MIN: 0, using extra1. 1, using min.
  SYSCTL_FLAG_MAX: 0, using extra2. 1, using max.
- since the proc file's mode field only uses 9 bits(777), we could use the
  additional two bits(S_ISUID and S_ISGID) to temporarily represent
  SYSCTL_FLAG_MIN and SYSCTL_FLAG_MAX.
- added some helper macros.

By introducing long min/max to replace void * extra1/extra2 in most cases,
unnecessary variables can be removed to save memory and avoid attacks.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Thomas Weißschuh <thomas@t-8ch.de>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 fs/proc/proc_sysctl.c  |  8 ++++++--
 include/linux/sysctl.h | 24 ++++++++++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 3177e229ec46..f340978bbb63 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -842,8 +842,11 @@ static int proc_sys_getattr(struct mnt_idmap *idmap,
 		return PTR_ERR(head);
 
 	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	if (table)
+	if (table) {
 		stat->mode = (stat->mode & S_IFMT) | table->mode;
+		stat->mode &= ~SYSCTL_FLAG_MIN;
+		stat->mode &= ~SYSCTL_FLAG_MAX;
+	}
 
 	sysctl_head_finish(head);
 	return 0;
@@ -1157,7 +1160,8 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 		if (!entry->proc_handler)
 			err |= sysctl_err(path, entry, "No proc_handler");
 
-		if ((entry->mode & (S_IRUGO|S_IWUGO)) != entry->mode)
+		if ((entry->mode & (S_IRUGO|S_IWUGO|SYSCTL_FLAG_MIN|SYSCTL_FLAG_MAX))
+		    != entry->mode)
 			err |= sysctl_err(path, entry, "bogus .mode 0%o",
 				entry->mode);
 	}
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 48f907850c87..bbae74393d37 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -28,6 +28,7 @@
 #include <linux/rbtree.h>
 #include <linux/uidgid.h>
 #include <uapi/linux/sysctl.h>
+#include <uapi/linux/stat.h>
 
 /* For the /proc/sys support */
 struct completion;
@@ -131,6 +132,9 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 #define DEFINE_CTL_TABLE_POLL(name)					\
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
+#define  SYSCTL_FLAG_MIN	S_ISUID
+#define  SYSCTL_FLAG_MAX	S_ISGID
+
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
@@ -139,8 +143,16 @@ struct ctl_table {
 	umode_t mode;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
+	union {
+		struct {
+			void *extra1;
+			void *extra2;
+		};
+		struct {
+			long min;
+			long max;
+		};
+	};
 } __randomize_layout;
 
 struct ctl_node {
@@ -212,9 +224,13 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
-#define __SYSCTL_RANGE_MIN(_a, _b, _c) (((_a)->extra1) ? *(_b((_a)->extra1)) : (_c))
+#define __SYSCTL_RANGE_EXTRA1(_a, _b, _c) (((_a)->extra1) ? *(_b((_a)->extra1)) : (_c))
+#define __SYSCTL_RANGE_MIN(_a, _b, _c)    ((((_a)->mode) & SYSCTL_FLAG_MIN) ? \
+					   ((_a)->min) : __SYSCTL_RANGE_EXTRA1(_a, _b, _c))
 
-#define __SYSCTL_RANGE_MAX(_a, _b, _c) (((_a)->extra2) ? *(_b((_a)->extra2)) : (_c))
+#define __SYSCTL_RANGE_EXTRA2(_a, _b, _c) (((_a)->extra2) ? *(_b((_a)->extra2)) : (_c))
+#define __SYSCTL_RANGE_MAX(_a, _b, _c)    ((((_a)->mode) & SYSCTL_FLAG_MAX) ? \
+					   ((_a)->max) : __SYSCTL_RANGE_EXTRA2(_a, _b, _c))
 
 static inline unsigned int sysctl_range_min_u8(const struct ctl_table *table)
 {
-- 
2.25.1


