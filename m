Return-Path: <linux-kernel+bounces-543433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECFAA4D583
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D4317319B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA11F8ACA;
	Tue,  4 Mar 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="YJ64afzg"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299471F4720
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075157; cv=none; b=jZE9aoxwgDRpX3bC4FIWEjAcMpjc1fmSdFr7UaI0yfrVHMcuooQdRkPxDiNWTUv220nrnZ2+WT/xYqmmztew/QF/tZRo6rFbUxv0ghBeOS60s0WX8aLDhrTxd3QKFq/StoySkH6ijxvzDvLzrSJAO6FMstT8TBgVvp4xN60IJJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075157; c=relaxed/simple;
	bh=CTRIoMGUhL6gYhD9n7OZD5t3HqwCo+j4dvhypyF3ink=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UpBEEopSSrx31scqWefTu+KTjLsgNXXLGl7m7wGp0Rmf06LAK05vNDMzNapeC0+v2Gk4n8jLzw5cttjBwwTJw76Rm13XLNxwIRKD1ePfWdq/UBxI10x6E733lIt8stvi2pWg/YoeZc3psM2Y028HNAFDWxx2aY5ky/j6dgZNxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=YJ64afzg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3910f525165so1274163f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075153; x=1741679953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEKpyMCCo3m2x0BF+c71o+pahMCFOq7W/z6rphmoY+E=;
        b=YJ64afzgObdjLDumJZrVw6SFZGUwluuMeeaAuYyozLU49vB/cfIBGhyY6cyo07ynpN
         k1nwdLjgYuwUCmhAJJ89N8aWQuqB6x49iRk/tohx9TpPwNqrNE1S30GFAAxrcc1XKMZD
         cLhcnQMNnCE3EintLTjwsmqkRxpAvE9VELrDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075153; x=1741679953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEKpyMCCo3m2x0BF+c71o+pahMCFOq7W/z6rphmoY+E=;
        b=Z1e5w77aEpKLLKDBRRJIfBL7+E+ff4H7TxYVcs6HqYDkZhakzQvh6Sm/V/q5igZGob
         zmK+jQ2Dx2qKhoJ6GcYwDm7l3WWo35p3uwp8NqW/KMYOvY+xsoGNmkXWW9QcW1ghEcpg
         C1wgx25PTt8RWTFLOHbZxOzzOvTKHn1eqr3AegYluBb+BZY9ERRuafEDBf9lwbKAG1Xn
         8/ztN2FbfQqmJfFUqkvpp9tgKU26gCQKsCCjvgehCjD8ITkdGl4WSG+xzKW0e8KpP6EZ
         pXfTsjXCnEkyL2gFP4krKUdVrKBic9+dKvKh0wv9AsXEdKWX2yAxUsX6BJNU95lhL00/
         3FWg==
X-Forwarded-Encrypted: i=1; AJvYcCULf5ZirpeVCZopojbsG1mRHKub8zKSe+tXl5UJtzmMKOJ8B2mUD3Mm7ecJfLIpvj/HJY4A7CSzoN1r/Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNXgCY2QpJo1hvtyJIPgs4Ehh7Z/CIpe30Tql9bykkT2p4SFE
	hUpRqEVzfNDPg/WdG5PLIimls8cluAXe+IW1Vd02bzuIfQzLwrNInsaalXYfw7k=
X-Gm-Gg: ASbGncu5FAos+KrJsXpmMgC08aZrHej8DbSNglULRcqfoCzU9sye9lSXFmCEppo6txa
	1xiNAm6DkddsJIGmONvNWiP+KQTaEU8LynnjKzWfIcLOs3YUfRVnDECudT+Z54pcNCl57un3Oqz
	tW2nucN0ksCDH7iQWAWtO1U/jtE6CbEo1u/snuo0J88xA9eE0Ax9GhAtnfpHsPsJhSnxJLRbDKv
	hilQf14za0Vn06jK+F8O301/VcwcFFfK5boWqbqJz1RljwF/VQ+EtB7NP8MVJxjlS/7gdWY5nSD
	z1v1HarVy0DCBnV9P9aGqu/NRmeP7RqZusvTxOUiCYm1zMG8Mz62HWrCwn22hJHH9DN7992czJJ
	mO/KCAQ==
X-Google-Smtp-Source: AGHT+IFnNvCJilidd2smenyhU8L+bYAQ4nimUKT3meVLiJdDM1dM9JKxUKglyvi4KEyJi72ujcATwA==
X-Received: by 2002:a05:6000:20c4:b0:38d:c627:f634 with SMTP id ffacd0b85a97d-390eca63fbbmr9557704f8f.50.1741075153406;
        Mon, 03 Mar 2025 23:59:13 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:13 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/5] tools/nolibc: add support for openat(2)
Date: Tue,  4 Mar 2025 07:58:15 +0000
Message-ID: <20250304075846.66563-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openat is useful to avoid needing to construct relative paths, so expose
a wrapper for using it directly.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/sys.h                   | 25 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 21 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8f44c33b1213..3cd938f9abda 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -765,6 +765,31 @@ int mount(const char *src, const char *tgt,
 	return __sysret(sys_mount(src, tgt, fst, flags, data));
 }
 
+/*
+ * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
+ */
+
+static __attribute__((unused))
+int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
+{
+	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
+}
+
+static __attribute__((unused))
+int openat(int dirfd, const char *path, int flags, ...)
+{
+	mode_t mode = 0;
+
+	if (flags & O_CREAT) {
+		va_list args;
+
+		va_start(args, flags);
+		mode = va_arg(args, mode_t);
+		va_end(args);
+	}
+
+	return __sysret(sys_openat(dirfd, path, flags, mode));
+}
 
 /*
  * int open(const char *path, int flags[, mode_t mode]);
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 79c3e6a845f3..2a1629938dd6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1028,6 +1028,26 @@ int test_rlimit(void)
 	return 0;
 }
 
+static int test_openat(void)
+{
+	int dev;
+	int null;
+
+	dev = openat(AT_FDCWD, "/dev", O_DIRECTORY);
+	if (dev < 0)
+		return -1;
+
+	null = openat(dev, "null", 0);
+	if (null < 0) {
+		close(dev);
+		return -1;
+	}
+
+	close(dev);
+	close(null);
+
+	return 0;
+}
 
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
@@ -1116,6 +1136,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-- 
2.45.2


