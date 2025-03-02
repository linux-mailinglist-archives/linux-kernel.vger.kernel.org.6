Return-Path: <linux-kernel+bounces-540765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B511A4B4A9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214A3169F3B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B111EBA08;
	Sun,  2 Mar 2025 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="GrSDVLRe"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F81B0406
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740947243; cv=none; b=YyDLCg1Qq41LiY7uka1XjjyrwBXTEcM8rfhp9v3riRx//SFxrm8jTsmea3FzXHaxkYxkw+FMZX4/OPHqfqUokGmQLlSUVIVzAbRhtONKA0vQ+E0Eiq0dgc2hb5zuDhCmTS+fViy/dwOGi9COb+VW9eovtO/M/SYeNDQpXNoPAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740947243; c=relaxed/simple;
	bh=FoAngoI/MZZsdcjDEJuPOT1p8rOyhmYEoGGRxCCCKtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPa87DkGcZlAyfoHeKgVH1/GFYDgchHnlMUPwGrl2YYkNnNYSlhoClFUuqVkqxWX03L+/vRAGCu6iMhgErl0eyMr7PDR/zMDOOVPjWMno6XkLPm2X6KsM8pya1JgrLll1e3ghYotb5eiDF562mKHEqyHGdO3aV0UPdVNvA69220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=GrSDVLRe; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-390dc0a7605so2001691f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1740947240; x=1741552040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Toe+H3M/fPbLKjUPwqPGSh5JqM5rSp09PnBJvQRrlzo=;
        b=GrSDVLRe36b6HQCzwZgF4YuFk7zyjDG+svju8FtfgEhRmJ/pnSSKG1TqKmocX14mUn
         sXfNyTBOH6QjxTOc8ZMlIqECPJAj6dqIscg+ur65fypchIT/njIYmJWBYgU6F4ZMUpdq
         4n2L5INBXfbkFnt2Ul5jQSbdIiZHWJ9Z/Fom0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740947240; x=1741552040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Toe+H3M/fPbLKjUPwqPGSh5JqM5rSp09PnBJvQRrlzo=;
        b=b0aONhk+YI+XqtBz4CsRKRQOA+EMVaZs0BnDJCBL4tqa45C//zTSTOuZ4zF2lUpyeZ
         eECUvYlK6FB0KBXq6Lpqeeh0zK8OCLr3zvE5mnzokTldMaBg2duUgoYA8wPyHy/LmOBa
         ZMzhsyUs4/CDnsJUP3gimbeigFTgmu5m7BxZC+JOE/P9Kzgagjz17qqvmqOSGMEo9F9g
         jLbqGEgPfnPi/NeDE2x0B8fSFMOoA8PukBAc4I1/26KmNycBfyjQbifDgH337NJzKIho
         p20Rg6uYc3jTK+8U1MEGGYnC4y/V60Le/OOIgE2XVUHeW9TRaJwlY08xIA203vGq8OP7
         9j1w==
X-Forwarded-Encrypted: i=1; AJvYcCVXDphVsr7MYEDVKCtB4icqaSYf2YNupsFoQYTh/MLAzbiQuICCnwEbAUNxt77bV4qMs5lQVFAbC6llnOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAb5fT7sMg7wU7A+YYUZe41tapKYk7e2U1cF3hzGbB5jvsSPfC
	JUISWS0qQMi1qSDrjeeHcwt0ollRBkLbtAPhEuVN4MDdTXcbOF/Pch4meKeWU6c=
X-Gm-Gg: ASbGnctv44955VGMqtKSbkuTJhHEc4IHTjjA+Ik1Rz9DUanahDw9sPp8XDcX5fz9WXL
	R+Hc4j1qmZ3oh4PhnfWmfVAxPpdLqc27s2mH6K9V9hZ22Wl1u1xu7oyhWF2Uj3FyArWHDDCSs5c
	goPDPYUpZHuGfhziKQV+vWQAFAd7Ibh3/eH8mxdR8TcxbNxRcuDWh+f+zOk9P4NVY3AsMTVfAJ9
	GN88wrOuo91wQdba/DbRdfGe9r34+wz9tXl16GDf+8d8ZQm398g9FeKCAtdGtghMWAUTOERORMz
	lBc6J5GEEBykBvqOKSZMnfnuX9Rwt+zkqXy12Rz4IrFFTlnfMNDpMsO2Z4S6+3BlmWlUvBH/iNY
	FUJXa0w==
X-Google-Smtp-Source: AGHT+IHs9J8Ly/fXvEU8Y5V9qY4tcCR+glMwH6IFLDwq0w/R5uvEyofQymw0Rg1+CP7r0YIBRunl9g==
X-Received: by 2002:a05:600c:1d0e:b0:439:88bb:d020 with SMTP id 5b1f17b1804b1-43ba66e1dafmr93255355e9.8.1740947239536;
        Sun, 02 Mar 2025 12:27:19 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm133585295e9.12.2025.03.02.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:27:19 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] tools/nolibc: add support for openat(2)
Date: Sun,  2 Mar 2025 20:25:23 +0000
Message-ID: <20250302202528.4169024-1-louis@kragniz.eu>
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
 tools/include/nolibc/sys.h                   | 29 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 22 +++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 8f44c33b1213..e5ff34df4aee 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -765,6 +765,35 @@ int mount(const char *src, const char *tgt,
 	return __sysret(sys_mount(src, tgt, fst, flags, data));
 }
 
+/*
+ * int openat(int dirfd, const char *path, int flags[, mode_t mode]);
+ */
+
+static __attribute__((unused))
+int sys_openat(int dirfd, const char *path, int flags, mode_t mode)
+{
+#ifdef __NR_openat
+	return my_syscall4(__NR_openat, dirfd, path, flags, mode);
+#else
+	return __nolibc_enosys(__func__, dirfd, path, flags, mode);
+#endif
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
+		mode = va_arg(args, int);
+		va_end(args);
+	}
+
+	return __sysret(sys_openat(dirfd, path, flags, mode));
+}
 
 /*
  * int open(const char *path, int flags[, mode_t mode]);
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 79c3e6a845f3..97ded6c76f99 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1028,6 +1028,26 @@ int test_rlimit(void)
 	return 0;
 }
 
+int test_openat(void)
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
@@ -1116,6 +1136,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(openat_fdcwd);      EXPECT_SYSNE(1, tmp = openat(AT_FDCWD, "/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
+		CASE_TEST(openat_dir);        EXPECT_SYSNE(1, test_openat(), -1); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-- 
2.45.2


