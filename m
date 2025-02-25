Return-Path: <linux-kernel+bounces-532361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF459A44C11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34CD917BA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E2A20E028;
	Tue, 25 Feb 2025 20:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvodTOYi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60701EBFE6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514147; cv=none; b=tx7/KagDHBmG4sPws8PPmvjUD3sfHthZ78+UfizZmyTwQ57HbONpKbwzZFqZNQEkSkVg3n5miwJrNt/66zZ+jXw+kOGQYmgXD1AAJ8R+0NgEWFktAcs+phBPn4rD4Ae1v6j1AykKpWCcqK3xy0dluw1ALtlxbhlXnfZR6cUw1I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514147; c=relaxed/simple;
	bh=xBkc39cTQDwiDEofgep3iX9dGL/1NrWOWxUE4XdfEXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1kut2bdavF5iyii0SD68BCBEn77vLuOvirJtBNk23qmp7stuA+TIr67jydFl6z+cf25lHzkN1oIDqsZqQsspQeBx9RngnGLQ1dbtAqJ1VtwUaIC7kf6Vtv6JN5KIBtuq/pmQxK1I2PZwmR/KGX6F23Zfa3ubSJa5sFqmII39Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvodTOYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF6C4CEDD;
	Tue, 25 Feb 2025 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514146;
	bh=xBkc39cTQDwiDEofgep3iX9dGL/1NrWOWxUE4XdfEXs=;
	h=From:To:Cc:Subject:Date:From;
	b=EvodTOYiuc93Q3u7BJGsP8U4+iqK2hqXcvoHVm6JCz0a/Zf9sllragKc6SGBFDm83
	 JyuFUKs/ka/eLlLxcSxY1I4cZfoBDjhzajtIRgVHRnXyPsaF6AY1pHzIMek1bz3qO6
	 MHOULi0CV9OfZIn07Fxt3RFEggehmyrjndIhxdPpb0F6Deq0hbzozWZaME20b5AaLc
	 DlzdzptQWHR3/rrj+HwZV+Qltci+3YxVHxat0j/+gQFF5ay3+0axUXF07xVUhIHUl+
	 zlciV9KcIKekVAve5ol4Phu7GgJE+QvnVvoIAOE97KO+9DyfSaWX3WIQXD5jMB5IOa
	 n0LOCVu38DT3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Mike Marshall <hubcap@omnibond.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Martin Brandenburg <martin@omnibond.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: move s_kmod_keyword_mask_map[] into debugfs.c
Date: Tue, 25 Feb 2025 21:08:52 +0100
Message-Id: <20250225200901.4041575-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about unused const variables when building with W=1

    In file included from fs/orangefs/protocol.h:287,
                     from fs/orangefs/acl.c:8:
    fs/orangefs/orangefs-debug.h:86:18: error: 'num_kmod_keyword_mask_map' defined but not used [-Werror=unused-const-variable=]
       86 | static const int num_kmod_keyword_mask_map = (int)
          |                  ^~~~~~~~~~~~~~~~~~~~~~~~~

This one is only used in one file, so just move the definition
next to its only user.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/orangefs/orangefs-debug.h   | 43 ----------------------------------
 fs/orangefs/orangefs-debugfs.c | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/orangefs/orangefs-debug.h b/fs/orangefs/orangefs-debug.h
index 6e079d4230d0..d4463534cec6 100644
--- a/fs/orangefs/orangefs-debug.h
+++ b/fs/orangefs/orangefs-debug.h
@@ -43,47 +43,4 @@
 #define GOSSIP_MAX_NR                 16
 #define GOSSIP_MAX_DEBUG              (((__u64)1 << GOSSIP_MAX_NR) - 1)
 
-/* a private internal type */
-struct __keyword_mask_s {
-	const char *keyword;
-	__u64 mask_val;
-};
-
-/*
- * Map all kmod keywords to kmod debug masks here. Keep this
- * structure "packed":
- *
- *   "all" is always last...
- *
- *   keyword     mask_val     index
- *     foo          1           0
- *     bar          2           1
- *     baz          4           2
- *     qux          8           3
- *      .           .           .
- */
-static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
-	{"super", GOSSIP_SUPER_DEBUG},
-	{"inode", GOSSIP_INODE_DEBUG},
-	{"file", GOSSIP_FILE_DEBUG},
-	{"dir", GOSSIP_DIR_DEBUG},
-	{"utils", GOSSIP_UTILS_DEBUG},
-	{"wait", GOSSIP_WAIT_DEBUG},
-	{"acl", GOSSIP_ACL_DEBUG},
-	{"dcache", GOSSIP_DCACHE_DEBUG},
-	{"dev", GOSSIP_DEV_DEBUG},
-	{"name", GOSSIP_NAME_DEBUG},
-	{"bufmap", GOSSIP_BUFMAP_DEBUG},
-	{"cache", GOSSIP_CACHE_DEBUG},
-	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
-	{"xattr", GOSSIP_XATTR_DEBUG},
-	{"init", GOSSIP_INIT_DEBUG},
-	{"sysfs", GOSSIP_SYSFS_DEBUG},
-	{"none", GOSSIP_NO_DEBUG},
-	{"all", GOSSIP_MAX_DEBUG}
-};
-
-static const int num_kmod_keyword_mask_map = (int)
-	(ARRAY_SIZE(s_kmod_keyword_mask_map));
-
 #endif /* __ORANGEFS_DEBUG_H */
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index f52073022fae..6a34e6feac45 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -54,6 +54,49 @@
 #define ORANGEFS_VERBOSE "verbose"
 #define ORANGEFS_ALL "all"
 
+/* a private internal type */
+struct __keyword_mask_s {
+	const char *keyword;
+	__u64 mask_val;
+};
+
+/*
+ * Map all kmod keywords to kmod debug masks here. Keep this
+ * structure "packed":
+ *
+ *   "all" is always last...
+ *
+ *   keyword     mask_val     index
+ *     foo          1           0
+ *     bar          2           1
+ *     baz          4           2
+ *     qux          8           3
+ *      .           .           .
+ */
+static struct __keyword_mask_s s_kmod_keyword_mask_map[] = {
+	{"super", GOSSIP_SUPER_DEBUG},
+	{"inode", GOSSIP_INODE_DEBUG},
+	{"file", GOSSIP_FILE_DEBUG},
+	{"dir", GOSSIP_DIR_DEBUG},
+	{"utils", GOSSIP_UTILS_DEBUG},
+	{"wait", GOSSIP_WAIT_DEBUG},
+	{"acl", GOSSIP_ACL_DEBUG},
+	{"dcache", GOSSIP_DCACHE_DEBUG},
+	{"dev", GOSSIP_DEV_DEBUG},
+	{"name", GOSSIP_NAME_DEBUG},
+	{"bufmap", GOSSIP_BUFMAP_DEBUG},
+	{"cache", GOSSIP_CACHE_DEBUG},
+	{"debugfs", GOSSIP_DEBUGFS_DEBUG},
+	{"xattr", GOSSIP_XATTR_DEBUG},
+	{"init", GOSSIP_INIT_DEBUG},
+	{"sysfs", GOSSIP_SYSFS_DEBUG},
+	{"none", GOSSIP_NO_DEBUG},
+	{"all", GOSSIP_MAX_DEBUG}
+};
+
+static const int num_kmod_keyword_mask_map = (int)
+	(ARRAY_SIZE(s_kmod_keyword_mask_map));
+
 /*
  * An array of client_debug_mask will be built to hold debug keyword/mask
  * values fetched from userspace.
-- 
2.39.5


