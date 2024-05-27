Return-Path: <linux-kernel+bounces-191088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911CF8D0670
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38671C2248F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457F9535A4;
	Mon, 27 May 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzgvlbBH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F217E8EE
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824632; cv=none; b=QwBvdop3vF/e7ZW4YbehxtnGnkx8DDcAvU2DnVBljHOcKIcsGELPtimJwj7GH78yAsKoGCq7LEz4fV0FsD4382rp4UPgazdYDYXmNzL35TkEj+E0wl9x043E/f2kqGvnmou7JxhPmDAjXvn6X6nZYvwXELMoEmKKyHOdtQQW6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824632; c=relaxed/simple;
	bh=gWlPRCbQw4BrNJ0Uo/ss+o/zOFQxCYl5zrKyhT5UEio=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GQGgG06wyGYhQHwPQyVKlxD9oIJ9OmviN2mNkdQg6Lt/EFBUOTsq7Sk/Kj46MRBYIn1DJlSj3sE+l+EM5C3wytjHOULZSWZOHdCf4Izr6orYag+rBn8KplRTEwKiE9FF8YG9sh3j8wqNrSLWc+UtayCqhUQ1GjcCWsW6lO/6/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzgvlbBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C852C2BBFC;
	Mon, 27 May 2024 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716824632;
	bh=gWlPRCbQw4BrNJ0Uo/ss+o/zOFQxCYl5zrKyhT5UEio=;
	h=Date:From:To:Cc:Subject:From;
	b=VzgvlbBHqRJbQqiQKmTEvv/DED38k8jXNKNg1ZJK+rbfLfh2BDnNMP0IGlRWxfHa6
	 YPa9bxQdcT7yor+lIDXccYtvnqGnNlOBf73/GTXRPuQbZF/74psvCdph8L4d1MWxS3
	 +6JRzDsygnf8WU+SUAZG53HCqQNDw/A1/I8F2plN+jH6aJSl/eLL9LHwJySYLnNk3/
	 23vyF18H7aN4hM9SKh5/66/l7kkRlTigFnoDyAg0k+fWDDzlcpmjhQHDb/ezHHDVLg
	 Xu7rnKOPNil/lQpL/jNjaJ00IBBJdgObJlEm1cFoVGL71ZhnWVEdexz5/DYJn1tdNc
	 gOBJ0W5c/1FOQ==
Date: Mon, 27 May 2024 12:43:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync fcntl.h with the kernel
 sources to pick F_DUPFD_QUERY
Message-ID: <ZlSqNQH9mFw2bmjq@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

There is no scrape script yet for those, but the warning pointed out we
need to update the array with the F_LINUX_SPECIFIC_BASE entries, do it.

Now 'perf trace' can decode that cmd and also use it in filter, as in:

  root@number:~# perf trace -e syscalls:*enter_fcntl --filter 'cmd != SETFL && cmd != GETFL'
     0.000 sssd_kcm/303828 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLK, arg: 0x7fffdc6a8a50)
     0.013 sssd_kcm/303828 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLKW, arg: 0x7fffdc6a8aa0)
     0.090 sssd_kcm/303828 syscalls:sys_enter_fcntl(fd: 13</var/lib/sss/secrets/secrets.ldb>, cmd: SETLKW, arg: 0x7fffdc6a88e0)
  ^Croot@number:~#

This picks up the changes in:

  c62b758bae6af16f ("fcntl: add F_DUPFD_QUERY fcntl()")

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                         |  2 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 51eca671c797607e..08a3a6effac18e43 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -765,7 +765,7 @@ static const char *fcntl_cmds[] = {
 static DEFINE_STRARRAY(fcntl_cmds, "F_");
 
 static const char *fcntl_linux_specific_cmds[] = {
-	"SETLEASE", "GETLEASE", "NOTIFY", [5] =	"CANCELLK", "DUPFD_CLOEXEC",
+	"SETLEASE", "GETLEASE", "NOTIFY", "DUPFD_QUERY", [5] = "CANCELLK", "DUPFD_CLOEXEC",
 	"SETPIPE_SZ", "GETPIPE_SZ", "ADD_SEALS", "GET_SEALS",
 	"GET_RW_HINT", "SET_RW_HINT", "GET_FILE_RW_HINT", "SET_FILE_RW_HINT",
 };
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index 282e90aeb163c028..c0bcc185fa48f852 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -8,6 +8,14 @@
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
 
+/*
+ * Request nofications on a directory.
+ * See below for events that may be notified.
+ */
+#define F_NOTIFY	(F_LINUX_SPECIFIC_BASE + 2)
+
+#define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
+
 /*
  * Cancel a blocking posix lock; internal use only until we expose an
  * asynchronous lock api to userspace:
@@ -17,12 +25,6 @@
 /* Create a file descriptor with FD_CLOEXEC set. */
 #define F_DUPFD_CLOEXEC	(F_LINUX_SPECIFIC_BASE + 6)
 
-/*
- * Request nofications on a directory.
- * See below for events that may be notified.
- */
-#define F_NOTIFY	(F_LINUX_SPECIFIC_BASE+2)
-
 /*
  * Set and get of pipe page size array
  */
-- 
2.45.1


