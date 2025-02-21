Return-Path: <linux-kernel+bounces-526440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB646A3FEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC75819C70CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAE252907;
	Fri, 21 Feb 2025 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYqmcKdt"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083242512D9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162352; cv=none; b=Igho4nykPKa9tP15NZezbPmF0MLgYisYRZ1p83F2s/eu6TveZcL2pAn1+tnhbXMmv7563ZXm5mZDAD72Ew4KZMZZY5wodJA/jQUV8jYPETZVZSK9gP7PJ9lgJl5NqBJLc2LaQqwDZWxUJ7dXZ0YHgJ46t6/hTK2oYevgQebvuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162352; c=relaxed/simple;
	bh=LdWgN7oTOnT2kR0V/qGOZgaNhPW+WowUTBFN2liAgPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KyBc/IUQB+q3o7HTKR2j/lRo8v/qmjv+jQpkdEu2fdrpLNyHFDFJaFhDSogDwdKtZO6TVu5vNpkUYEobvLSYgILNfvz4IJ35VlcwBMmGJNFMotdG/jP35d1hvrWGkW96LPWvgEYuSt1Dt8xaYVUlQVKiNWzR4dWHnJ/8dxcMf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYqmcKdt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so24895865e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162349; x=1740767149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hk2q4ahcZVTOKS3B3OzgKX2VwvrQ5wObjbXK4TuFM6g=;
        b=GYqmcKdtAY+4g4KLednJRXqlzcApOgcJ/kPYxPZ0p3QudNDoGD1hFq1hn42LAqRpbo
         cGo2nXQcjgYtQCrx+C3cL98SzDCU19ZABmyUJ0+vzOpWNzd1XXEGkd3lCOnbp3jLs3pd
         jGXHXdX7zjDHy2esnNiS2LykHWyxz7uGx3GyU5qiTNndGo0TTaPnJyouzY/5FVMbsMYT
         YX7Gew71Lq60TPxuJeWV6sCOjOTqScCahMqMcnVx/M6yE8x+DGaq2aAJN1vOB0AKbDwH
         5zmx2lS1KrgxW3ViAPkTAQ4WYmJiwL5AifMzBvbFAT5f9z6EQRbNY7/VeBr9CML2QA63
         RFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162349; x=1740767149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk2q4ahcZVTOKS3B3OzgKX2VwvrQ5wObjbXK4TuFM6g=;
        b=NeG32iJNXnmdMnaiLOWWmrJmDDa3P5yfmU2t8iBHxxwfENS3yopsF3Di//a903TSiJ
         39XXWPe1hJwAXNWuejs+NSd0vrC3ShYnucw1qbmcaXj4ZAMlDP1io9YAeavxfHvPkX7t
         FbE+5Dq+jU5pdec6gglzGUN4Ye12RERNiTZsD0aKF2ju2QnyGxIHxH9aJz/NcnGNJCXW
         aKYGG+DQXQwJP3TCCM/qoCimgvVC3CaIeF/k7pAfqIYln1cfZ3vmZcsRiT/Xpgmn72pG
         2hZNNN+vlZA7JZOHJIPByzTb9QNjmjk8iZjlVqKMoZJ8GC93vfx5BuDXu6wpb25UGIoe
         SKsw==
X-Forwarded-Encrypted: i=1; AJvYcCUptPXQ0Exp3gB/OmtycV9pCpSrZL0QnEkxGTs0T7Sn0lwMEsgqCTaXLvj6ncxsHLiDy3RSJRHxaJSoi4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe6nTEJLxsKSxuM07YFuwcqYP7xRndu7MqQKI9+s378JfBn4ya
	7A25G8331l2/Eh05e8hAaCKDwbeCRUVS7sxKNH0dmfz9EF3JdTNT9c9n0O12iLlbbK/RtNveJHr
	R9O6f9+OLWA==
X-Google-Smtp-Source: AGHT+IEEX+9NDAYtaEsuvzkkpt2t6wfcS1DgyAfislLJA+1+8RZByMs7UTp84Gy/Woac1f/+GF5PHTZ0HNJ1aQ==
X-Received: from wmsp4.prod.google.com ([2002:a05:600c:1d84:b0:439:942c:b180])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b09:b0:439:9e13:2dd7 with SMTP id 5b1f17b1804b1-439aeae1c7emr34111985e9.2.1740162349573;
 Fri, 21 Feb 2025 10:25:49 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:40 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-1-28c4d66383c5@google.com>
Subject: [PATCH v2 1/9] selftests/mm: Report errno when things fail in gup_longterm
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Just reporting failure doesn't tell you what went wrong. This can fail
in different ways so report errno to help the reader get started
debugging.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a6140163bdef2974615bb86406a8c14..879e9e4e8cce8127656fabe098abf7db5f6c5e23 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -96,13 +96,13 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 	int ret;
 
 	if (ftruncate(fd, size)) {
-		ksft_test_result_fail("ftruncate() failed\n");
+		ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	if (fallocate(fd, 0, 0, size)) {
 		if (size == pagesize)
-			ksft_test_result_fail("fallocate() failed\n");
+			ksft_test_result_fail("fallocate() failed (%s)\n", strerror(errno));
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -112,7 +112,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		   shared ? MAP_SHARED : MAP_PRIVATE, fd, 0);
 	if (mem == MAP_FAILED) {
 		if (size == pagesize || shared)
-			ksft_test_result_fail("mmap() failed\n");
+			ksft_test_result_fail("mmap() failed (%s)\n", strerror(errno));
 		else
 			ksft_test_result_skip("need more free huge pages\n");
 		return;
@@ -130,7 +130,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		 */
 		ret = mprotect(mem, size, PROT_READ);
 		if (ret) {
-			ksft_test_result_fail("mprotect() failed\n");
+			ksft_test_result_fail("mprotect() failed (%s)\n", strerror(errno));
 			goto munmap;
 		}
 		/* FALLTHROUGH */
@@ -165,18 +165,20 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		args.flags |= rw ? PIN_LONGTERM_TEST_FLAG_USE_WRITE : 0;
 		ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
 		if (ret && errno == EINVAL) {
-			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed\n");
+			ksft_test_result_skip("PIN_LONGTERM_TEST_START failed (EINVAL)n");
 			break;
 		} else if (ret && errno == EFAULT) {
 			ksft_test_result(!should_work, "Should have failed\n");
 			break;
 		} else if (ret) {
-			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed\n");
+			ksft_test_result_fail("PIN_LONGTERM_TEST_START failed (%s)\n",
+					      strerror(errno));
 			break;
 		}
 
 		if (ioctl(gup_fd, PIN_LONGTERM_TEST_STOP))
-			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed\n");
+			ksft_print_msg("[INFO] PIN_LONGTERM_TEST_STOP failed (%s)\n",
+				       strerror(errno));
 
 		/*
 		 * TODO: if the kernel ever supports long-term R/W pinning on
@@ -202,7 +204,8 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Skip on errors, as we might just lack kernel support. */
 		ret = io_uring_queue_init(1, &ring, 0);
 		if (ret < 0) {
-			ksft_test_result_skip("io_uring_queue_init() failed\n");
+			ksft_test_result_skip("io_uring_queue_init() failed (%s)\n",
+					      strerror(errno));
 			break;
 		}
 		/*
@@ -215,13 +218,15 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		/* Only new kernels return EFAULT. */
 		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
 			    errno == EFAULT)) {
-			ksft_test_result(!should_work, "Should have failed\n");
+			ksft_test_result(!should_work, "Should have failed (%s)\n",
+					 strerror(errno));
 		} else if (ret) {
 			/*
 			 * We might just lack support or have insufficient
 			 * MEMLOCK limits.
 			 */
-			ksft_test_result_skip("io_uring_register_buffers() failed\n");
+			ksft_test_result_skip("io_uring_register_buffers() failed (%s)\n",
+					      strerror(errno));
 		} else {
 			ksft_test_result(should_work, "Should have worked\n");
 			io_uring_unregister_buffers(&ring);
@@ -249,7 +254,7 @@ static void run_with_memfd(test_fn fn, const char *desc)
 
 	fd = memfd_create("test", 0);
 	if (fd < 0) {
-		ksft_test_result_fail("memfd_create() failed\n");
+		ksft_test_result_fail("memfd_create() failed (%s)\n", strerror(errno));
 		return;
 	}
 
@@ -266,13 +271,13 @@ static void run_with_tmpfile(test_fn fn, const char *desc)
 
 	file = tmpfile();
 	if (!file) {
-		ksft_test_result_fail("tmpfile() failed\n");
+		ksft_test_result_fail("tmpfile() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	fd = fileno(file);
 	if (fd < 0) {
-		ksft_test_result_fail("fileno() failed\n");
+		ksft_test_result_fail("fileno() failed (%s)\n", strerror(errno));
 		goto close;
 	}
 
@@ -290,12 +295,12 @@ static void run_with_local_tmpfile(test_fn fn, const char *desc)
 
 	fd = mkstemp(filename);
 	if (fd < 0) {
-		ksft_test_result_fail("mkstemp() failed\n");
+		ksft_test_result_fail("mkstemp() failed (%s)\n", strerror(errno));
 		return;
 	}
 
 	if (unlink(filename)) {
-		ksft_test_result_fail("unlink() failed\n");
+		ksft_test_result_fail("unlink() failed (%s)\n", strerror(errno));
 		goto close;
 	}
 
@@ -317,7 +322,7 @@ static void run_with_memfd_hugetlb(test_fn fn, const char *desc,
 
 	fd = memfd_create("test", flags);
 	if (fd < 0) {
-		ksft_test_result_skip("memfd_create() failed\n");
+		ksft_test_result_skip("memfd_create() failed (%s)\n", strerror(errno));
 		return;
 	}
 

-- 
2.48.1.601.g30ceb7b040-goog


