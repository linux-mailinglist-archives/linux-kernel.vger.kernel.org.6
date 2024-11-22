Return-Path: <linux-kernel+bounces-418333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB7D9D607C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1D2827AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6051DFE33;
	Fri, 22 Nov 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="asEjhPON"
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACF1DF990
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286073; cv=none; b=UVELblxbzMw4MB2C8BjV0z5DOiE8kDoL/GNY/XshBYdZN7x7sJlQpAIdIVzFOIB7UaiM0HpNxipqdchyxmmeTDSlkdl0DF71xYrOjMQkbBNAw3EPgfd9H/trE8EGwyZHyzE3qxpmkTlsARdU2Lodmsc0kgDi8Btsb54jZCJLp/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286073; c=relaxed/simple;
	bh=mcO299gnz9ndiaMSwPmQbuZYoMNokkhMIATxSJ2kdIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6wUDq4exAprGMiVwtAcE61UCsVf1Mu87+GUwUHA27GLdsTUDGkYIN2p/GnhPs18z3w93/GY6xMEZz+ZJjbAwGsE0UzGg9d9Vq/SB73PQGQOY6SJo146h8+z4eaT2DZzgoGMA8nrM34k6moBScD9o2KslFnHSPDG+Ph1eS2cOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=asEjhPON; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKc2zV8zlSf;
	Fri, 22 Nov 2024 15:34:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286068;
	bh=Lq3kha7+yN0YJbY/oShjU2K3cOge2QbVPhVQ4nd4Oko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=asEjhPONGwsuFqUltq6GBOetEvMHRIQ25/kGigkrREcVN+PMoTAvVWB8w2A5JxWsK
	 wNs5d3uxtQpNrguLbelsMOivgIyfRBABijXEoDpPA6ZznNBYBRe3QxeLQNd1dqy9mJ
	 omltWKAT21kZLpRN1LidHmQdAmw3UEyUS9MEjwZc=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKb5VmxzHkl;
	Fri, 22 Nov 2024 15:34:27 +0100 (CET)
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
Subject: [PATCH v3 20/23] samples/landlock: Do not log denials from the sandboxer by default
Date: Fri, 22 Nov 2024 15:33:50 +0100
Message-ID: <20241122143353.59367-21-mic@digikod.net>
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

Do not pollute audit logs because of unknown sandboxed programs.
Indeed, the sandboxer's security policy might not be fitted to the set
of sandboxed processes that could be spawned (e.g. from a shell).

The LANDLOCK_RESTRICT_SELF_LOGLESS flag should be used for all similar
sandboxer tools by default.  Only natively-sandboxed programs should not
use this flag.

For test purpose, parse the LL_FORCE_LOG environment variable to still
log denials.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-21-mic@digikod.net
---

Changes since v2:
- New patch.
---
 samples/landlock/sandboxer.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..49fd4fdb1dcf 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -58,6 +58,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
 #define ENV_SCOPED_NAME "LL_SCOPED"
+#define ENV_FORCE_LOG_NAME "LL_FORCE_LOG"
 #define ENV_DELIMITER ":"
 
 static int str2num(const char *numstr, __u64 *num_dst)
@@ -288,7 +289,7 @@ static bool check_ruleset_scope(const char *const env_var,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 6
+#define LANDLOCK_ABI_LAST 7
 
 #define XSTR(s) #s
 #define STR(s) XSTR(s)
@@ -315,6 +316,9 @@ static const char help[] =
 	"  - \"a\" to restrict opening abstract unix sockets\n"
 	"  - \"s\" to restrict sending signals\n"
 	"\n"
+	"A sandboxer should not log denied access requests to avoid spamming logs, "
+	"but to test audit we can set " ENV_FORCE_LOG_NAME "=1\n"
+	"\n"
 	"Example:\n"
 	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
@@ -333,7 +337,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	const char *cmd_path;
 	char *const *cmd_argv;
 	int ruleset_fd, abi;
-	char *env_port_name;
+	char *env_port_name, *env_force_log;
 	__u64 access_fs_ro = ACCESS_FS_ROUGHLY_READ,
 	      access_fs_rw = ACCESS_FS_ROUGHLY_READ | ACCESS_FS_ROUGHLY_WRITE;
 
@@ -344,6 +348,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 			  LANDLOCK_SCOPE_SIGNAL,
 	};
+	/* Do not pollute audit logs because of unknown sandboxed programs. */
+	int restrict_flags = LANDLOCK_RESTRICT_SELF_LOGLESS;
 
 	if (argc < 2) {
 		fprintf(stderr, help, argv[0]);
@@ -415,6 +421,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
 		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
 					 LANDLOCK_SCOPE_SIGNAL);
+		__attribute__((fallthrough));
+	case 6:
+		/* Removes LANDLOCK_RESTRICT_SELF_LOGLESS for ABI < 7 */
+		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOGLESS;
+
+		/* Must be printed for any ABI < LANDLOCK_ABI_LAST. */
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
@@ -449,6 +461,23 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
 		return 1;
 
+	/* Enables optional logs. */
+	env_force_log = getenv(ENV_FORCE_LOG_NAME);
+	if (env_force_log) {
+		if (strcmp(env_force_log, "1") != 0) {
+			fprintf(stderr,
+				"Unknown value for " ENV_FORCE_LOG_NAME "\n");
+			return 1;
+		}
+		if (!(restrict_flags & LANDLOCK_RESTRICT_SELF_LOGLESS)) {
+			fprintf(stderr,
+				"Audit logs not supported by current kernel\n");
+			return 1;
+		}
+		restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOGLESS;
+		unsetenv(ENV_FORCE_LOG_NAME);
+	}
+
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
@@ -476,7 +505,7 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		perror("Failed to restrict privileges");
 		goto err_close_ruleset;
 	}
-	if (landlock_restrict_self(ruleset_fd, 0)) {
+	if (landlock_restrict_self(ruleset_fd, restrict_flags)) {
 		perror("Failed to enforce ruleset");
 		goto err_close_ruleset;
 	}
-- 
2.47.0


