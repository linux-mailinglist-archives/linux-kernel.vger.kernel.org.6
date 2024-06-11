Return-Path: <linux-kernel+bounces-210213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CB9040E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92EBB219FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C63A8E4;
	Tue, 11 Jun 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bvmxlu98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECC2C694;
	Tue, 11 Jun 2024 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122191; cv=none; b=EpyG+Kngdb7MuPyS9LDQ2k+Oc3IS/4iGKrYlRulLRWO5NvCvsMnwxz+wn8Im7+PDVXVyllJSRMP+979hw1CPgF/45jEbNn07umsSrGozN6WxVo3SSbLvzbjCBcd0g9Fq2JEZRmYNgxvKNKaxQde5FsNlfmxUESy9GsqPpH8Uu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122191; c=relaxed/simple;
	bh=OBoA2p8QUxX2YtCi+LzDy3re7iW0nv+1GXUkJNvdsDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rkklZVO9XnA04xiG1TkPAPkPwsN6pN4w3gCL5XKpedumTLI5fERPzbwpRlkLUfJlcsvGZcZ9vEdI16RSLqP9VorTE/C/Gb8D7ykP9lYthBCQcyPZ2Sy9bsSCpzGWk3gGiDC/Uo+4kTxNATrdYoBRaHxy58v1nrRHgOaythxRYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bvmxlu98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE99EC2BD10;
	Tue, 11 Jun 2024 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718122190;
	bh=OBoA2p8QUxX2YtCi+LzDy3re7iW0nv+1GXUkJNvdsDI=;
	h=From:To:Cc:Subject:Date:From;
	b=Bvmxlu98iciUZNvAZSJZSsrsMj9aBuOSwhWbwHu9WAz58bDJlUJvw0iHoHJ455++C
	 +TBtEcyUJ0WVbPM5v2jUerd8Gvy6lKHBwrgWbsQSeQZFlWIEnYkAFMKVtXzgOfTKuZ
	 ryPqV/2zr1uyinq9DIY9H8WPgcAf+MepUxRF/cWEwCORG1AGR6xKSTXSIAUlAQ5fAq
	 YwO9SuuzO3wQiELHZSsLHuwaoowl23lLW1SaknVZolX4O036aB4VjALxGKsptyIXG/
	 L7swlNzPWS05WjF+1X5kJEA3V/1tEyEkOsm5zW7CBymoYHUuFhUdlluIoT9wGlgvIk
	 T304MfCs4Nb2g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] kconfig: add -e and -u options to *conf-cfg.sh scripts
Date: Wed, 12 Jun 2024 01:08:05 +0900
Message-ID: <20240611160938.3511096-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set -e to make these scripts fail on the first error.

Set -u because these scripts are invoked by Makefile, and do not work
properly without necessary variables defined.

Both options are described in POSIX. [1]

[1]: https://pubs.opengroup.org/onlinepubs/009604499/utilities/set.html

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/gconf-cfg.sh | 2 ++
 scripts/kconfig/mconf-cfg.sh | 2 ++
 scripts/kconfig/nconf-cfg.sh | 2 ++
 scripts/kconfig/qconf-cfg.sh | 2 ++
 4 files changed, 8 insertions(+)

diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
index 040d8f338820..fc954c0538fa 100755
--- a/scripts/kconfig/gconf-cfg.sh
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+set -eu
+
 cflags=$1
 libs=$2
 
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index 1e61f50a5905..1bc304dc2f7d 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+set -eu
+
 cflags=$1
 libs=$2
 
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index f871a2160e36..a20290b1a37d 100755
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+set -eu
+
 cflags=$1
 libs=$2
 
diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index 0e113b0f2455..bb2df66363a8 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+set -eu
+
 cflags=$1
 libs=$2
 bin=$3
-- 
2.43.0


