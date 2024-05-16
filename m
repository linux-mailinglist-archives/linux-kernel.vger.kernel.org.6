Return-Path: <linux-kernel+bounces-181471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5D8C7C72
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384EC1C2173B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5E1635D5;
	Thu, 16 May 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fR0LeHvV"
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB916130C
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715883599; cv=none; b=YvbhmqVTwwIzoYEHcwQkW8svWFpgP9zFAnhAZAEIsfakqTCODrtaNWw29Mxb3HedVGJsGlOLw4gn3BbGH4M9K1ROGamt+o5aObU/n/N5OgONL/0ytIy6mEmflMele8T7c6Wb7wBamFfFdVYizEiZ9UuwyfjQsvBAcIKc/5zfRQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715883599; c=relaxed/simple;
	bh=PEuSbZLhQKUIRPOEn8RJsEZy8kxbEUrcpbilId0eRIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rB9iGHCqixDntTy6MHZ/4RIDso18NbTnOeeu3b4CbqLeEslcu5EoZ9bRYL7KHVCyhXgfu2H+Bw9Zl8q3AxsD+T+zzHQn43OyGRTu+ajq4nLMY75YjOABBl1OtFxq6zI7aw23Ve/juWiwDnZXDevaYM7H7KpPKeSEq5F/eQu1e5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=fR0LeHvV; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VgJKH6GxyzC4W;
	Thu, 16 May 2024 20:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1715883587;
	bh=KYMR4OePvmGxZRLXtqNU+jKooqvr8rCEU9LlTK0H0Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fR0LeHvVhl4K8KsQhRfiKMCXN08Rdgq31ZOrg3FnXBHUHr2eKtBaAHw22DBH6/IzJ
	 eVSRlsRUKw6eLatFhjobrpgVMYoBoTfe6Iz/dA0iYE4qgjHrUaXwFBffduqOvm1mhv
	 8o1AGUGQS1JXhScTzxIkH2QvkdK53RBaaJmB6p6s=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VgJKH2sc5zrSg;
	Thu, 16 May 2024 20:19:47 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	nathan@kernel.org,
	ndesaulniers@google.com,
	syzkaller-bugs@googlegroups.com,
	trix@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/landlock: Add layout1.refer_mount_root
Date: Thu, 16 May 2024 20:19:35 +0200
Message-ID: <20240516181935.1645983-3-mic@digikod.net>
In-Reply-To: <20240516181935.1645983-1-mic@digikod.net>
References: <20240516181935.1645983-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add tests to check error codes when linking or renaming a mount root
directory.  This previously triggered a kernel warning, but it is fixed
with the previous commit.

Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240516181935.1645983-3-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6b5a9ff88c3d..7d063c652be1 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -35,6 +35,7 @@
  * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
  */
 #include <linux/fs.h>
+#include <linux/mount.h>
 
 #include "common.h"
 
@@ -47,6 +48,13 @@ int renameat2(int olddirfd, const char *oldpath, int newdirfd,
 }
 #endif
 
+#ifndef open_tree
+int open_tree(int dfd, const char *filename, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dfd, filename, flags);
+}
+#endif
+
 #ifndef RENAME_EXCHANGE
 #define RENAME_EXCHANGE (1 << 1)
 #endif
@@ -2400,6 +2408,43 @@ TEST_F_FORK(layout1, refer_denied_by_default4)
 				layer_dir_s1d1_refer);
 }
 
+/*
+ * Tests walking through a denied root mount.
+ */
+TEST_F_FORK(layout1, refer_mount_root_deny)
+{
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_DIR,
+	};
+	int root_fd, ruleset_fd;
+
+	/* Creates a mount object from a non-mount point. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	root_fd =
+		open_tree(AT_FDCWD, dir_s1d1,
+			  AT_EMPTY_PATH | OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_LE(0, root_fd);
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Link denied by Landlock: EACCES. */
+	EXPECT_EQ(-1, linkat(root_fd, ".", root_fd, "does_not_exist", 0));
+	EXPECT_EQ(EACCES, errno);
+
+	/* renameat2() always returns EBUSY. */
+	EXPECT_EQ(-1, renameat2(root_fd, ".", root_fd, "does_not_exist", 0));
+	EXPECT_EQ(EBUSY, errno);
+
+	EXPECT_EQ(0, close(root_fd));
+}
+
 TEST_F_FORK(layout1, reparent_link)
 {
 	const struct rule layer1[] = {
-- 
2.45.0


