Return-Path: <linux-kernel+bounces-406609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 291EB9C6162
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4911F21648
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08765218D76;
	Tue, 12 Nov 2024 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q/Ukb1J0"
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C421832A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439517; cv=none; b=aE4sO01Wp1RLPmnInD9cKs+VYrD8mgrDy6KDuIMYIGPQBSVlemk1YEtX5EhARefbxPlJpeXUzU/JBVttz8RR8HXYz3FVeRnls36k4SHZUgehvuf+Jx99LQWSraf4y1Kwe0vmarn5APsX7ufWqcVxV0tfRz5gkHSimbpH4aDewt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439517; c=relaxed/simple;
	bh=BYg1gWZVbz/Xg0eZjTxJM/qrYcO7E9osI4vFp8r3itk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcTaqd8n2xlj950l6Vut+E5LVyVA7IoffXRzeqNU5IsFdKUOauL/ZQmANbqAsO4PNAVl/X82Wx/AG7nvFEkVXaV5ZD1XW4GPL+NOpIuysiYmcYwg3Waf0nM6arpH0Z3DDKq0Ub3xOrStPRA77E00aQ9B+fqzrjGVoi4Mkq2w6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q/Ukb1J0; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xnx6y67MVzJk4;
	Tue, 12 Nov 2024 20:19:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731439162;
	bh=W6EP0Gs1jrCUn7ogO4gOiMXjifVTH40IdORHs0QjdaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/Ukb1J0l0OQsCfqyvp37pt4MsjScaYnjnCSs2cwyFS8Wio2siEgoDhtkN11CbVk+
	 tSGOObMzxLnoza/ef1eKKmXNLKOftoX9LLa8+hCURfDLH4+lqahTr5PINDtnMNo5oA
	 T28OE1jwcUIvUH4Sp1xlawjbXlS9L12TqogMmDGk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xnx6x1l43zrXy;
	Tue, 12 Nov 2024 20:19:21 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [PATCH v21 4/6] selftests/landlock: Add tests for execveat + AT_EXECVE_CHECK
Date: Tue, 12 Nov 2024 20:18:56 +0100
Message-ID: <20241112191858.162021-5-mic@digikod.net>
In-Reply-To: <20241112191858.162021-1-mic@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend layout1.execute with the new AT_EXECVE_CHECK flag.  The semantic
with AT_EXECVE_CHECK is the same as with a simple execve(2),
LANDLOCK_ACCESS_FS_EXECUTE is enforced the same way.

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241112191858.162021-5-mic@digikod.net
---

Changes since v20:
* Rename AT_CHECK to AT_EXECVE_CHECK.
---
 tools/testing/selftests/landlock/fs_test.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 6788762188fe..cd66901be612 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -37,6 +37,10 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 
+/* Defines AT_EXECVE_CHECK without type conflicts. */
+#define _ASM_GENERIC_FCNTL_H
+#include <linux/fcntl.h>
+
 #include "common.h"
 
 #ifndef renameat2
@@ -2008,6 +2012,22 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	};
 }
 
+static void test_check_exec(struct __test_metadata *const _metadata,
+			    const int err, const char *const path)
+{
+	int ret;
+	char *const argv[] = { (char *)path, NULL };
+
+	ret = execveat(AT_FDCWD, path, argv, NULL,
+		       AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	if (err) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(errno, err);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+}
+
 TEST_F_FORK(layout1, execute)
 {
 	const struct rule rules[] = {
@@ -2025,20 +2045,27 @@ TEST_F_FORK(layout1, execute)
 	copy_binary(_metadata, file1_s1d2);
 	copy_binary(_metadata, file1_s1d3);
 
+	/* Checks before file1_s1d1 being denied. */
+	test_execute(_metadata, 0, file1_s1d1);
+	test_check_exec(_metadata, 0, file1_s1d1);
+
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	test_execute(_metadata, EACCES, file1_s1d1);
+	test_check_exec(_metadata, EACCES, file1_s1d1);
 
 	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d2);
+	test_check_exec(_metadata, 0, file1_s1d2);
 
 	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d3);
+	test_check_exec(_metadata, 0, file1_s1d3);
 }
 
 TEST_F_FORK(layout1, link)
-- 
2.47.0


