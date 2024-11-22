Return-Path: <linux-kernel+bounces-418331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF689D6075
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C145A281A40
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA81DFE20;
	Fri, 22 Nov 2024 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rZvMXWQJ"
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463841DFD8D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286069; cv=none; b=Gk54mj6ksfb4+iKCDEsRy9eqCdFVPiluG+d+TQ7EiK3GwKRS62JWhJ4+b/GEVpGVNZER62hR5osAO6c60HncEfdwnhU7e/mJrFSlT/cJFd+eve7o6QME6GjLvcfuFEInJ4FpHHfsp99boXY0ZGmFSzybWUw+MT19o5GcEabc804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286069; c=relaxed/simple;
	bh=5jhXIrCKW9G90gP+X+JAGYcArPkac3fHOXKVNwSJI20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vfg3y4UWa5DHiehjAD4U+vGb5ZR1zNrnkJwpavpUpoUAfEDS9oCU1k8gTWIfNLBIqYm8KK4SLO1aKbBgqF+6YamwzCkQTzE2Sx/g650FArUtH1j0TWY0RxioXeN56z823K47OxrHcZ05nf+eKMnmZwMQyDa6WgvAkDLRiRv6A6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rZvMXWQJ; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKS3jrhzZsx;
	Fri, 22 Nov 2024 15:34:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286060;
	bh=+NTh0aRLS4WQhSiSk2pWdvUKQlq2NLeswsQdqGHb16Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZvMXWQJJE1Hrk7rMLICf+JRABO9hjsv/AjjE2WomOaE+zZHQum7xuOmVVu3TnXPl
	 p+y53yHGANGNRdMicklvaUH9p+9pv97o/pzhG7TXE7WHKDB5grJquGJlhxjv2TR8Xn
	 wemY3kzzewoCcAy0ZPSsEA2iKEbuX0RHlDbaPey8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKR5CDzzkXR;
	Fri, 22 Nov 2024 15:34:19 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 13/23] selftests/landlock: Add test to check partial access in a mount tree
Date: Fri, 22 Nov 2024 15:33:43 +0100
Message-ID: <20241122143353.59367-14-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add layout1.refer_part_mount_tree_is_allowed to test the masked logical
issue regarding collect_domain_accesses() calls followed by the
is_access_to_paths_allowed() check in current_check_refer_path().  See
previous commit.

This test should work without the previous fix as well, but it enables
us to make sure future changes will not have impact regarding this
behavior.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-14-mic@digikod.net
---

Changes since v2:
- New patch.
---
 tools/testing/selftests/landlock/fs_test.c | 54 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6788762188fe..42ce1e79ba82 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -85,6 +85,9 @@ static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
+static const char file1_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3/f1";
+static const char dir_s3d4[] = TMP_DIR "/s3d1/s3d2/s3d4";
+static const char file1_s3d4[] = TMP_DIR "/s3d1/s3d2/s3d4/f1";
 
 /*
  * layout1 hierarchy:
@@ -108,8 +111,11 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
  * │           └── f2
  * └── s3d1
  *     ├── f1
- *     └── s3d2
- *         └── s3d3
+ *     └── s3d2 [mount point]
+ *         ├── s3d3
+ *         │   └── f1
+ *         └── s3d4
+ *             └── f1
  */
 
 static bool fgrep(FILE *const inf, const char *const str)
@@ -358,7 +364,8 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
-	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
+	create_file(_metadata, file1_s3d3);
+	create_file(_metadata, file1_s3d4);
 }
 
 static void remove_layout1(struct __test_metadata *const _metadata)
@@ -378,7 +385,8 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(dir_s2d2));
 
 	EXPECT_EQ(0, remove_path(file1_s3d1));
-	EXPECT_EQ(0, remove_path(dir_s3d3));
+	EXPECT_EQ(0, remove_path(file1_s3d3));
+	EXPECT_EQ(0, remove_path(file1_s3d4));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
@@ -2444,6 +2452,44 @@ TEST_F_FORK(layout1, refer_mount_root_deny)
 	EXPECT_EQ(0, close(root_fd));
 }
 
+TEST_F_FORK(layout1, refer_part_mount_tree_is_allowed)
+{
+	const struct rule layer1[] = {
+		{
+			/* Parent mount point. */
+			.path = dir_s3d1,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{
+			/*
+			 * Removing the source file is allowed because its
+			 * access rights are already a superset of the
+			 * destination.
+			 */
+			.path = dir_s3d4,
+			.access = LANDLOCK_ACCESS_FS_REFER |
+				  LANDLOCK_ACCESS_FS_MAKE_REG |
+				  LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	ASSERT_EQ(0, unlink(file1_s3d3));
+	ruleset_fd = create_ruleset(_metadata,
+				    LANDLOCK_ACCESS_FS_REFER |
+					    LANDLOCK_ACCESS_FS_MAKE_REG |
+					    LANDLOCK_ACCESS_FS_REMOVE_FILE,
+				    layer1);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, rename(file1_s3d4, file1_s3d3));
+}
+
 TEST_F_FORK(layout1, reparent_link)
 {
 	const struct rule layer1[] = {
-- 
2.47.0


