Return-Path: <linux-kernel+bounces-563861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4036EA649A3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B227A52A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2C223370D;
	Mon, 17 Mar 2025 10:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaav33xT"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C437119995D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206853; cv=none; b=jbuy3CcOCwqttzwLVq1JZeZbqqlxyrr1ph7tzxOa5vTSwDdt9lKifBc+bpLU+SfJTFe0u8YPPoXiN8fs1VsNp3kX4hR1GIDFudEhorqFJteY16nYmxPKar5cmPqA+dTCLwSpa69qHf6ZUXmGHi8yan+PyC611wIcwi055k9fsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206853; c=relaxed/simple;
	bh=xK2ZBkUkyt1F/UpRmUx4V+BWA8zhSQC4XnXhnJZY+2Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YrGqrcmh0GAyAMEFnFZZL7KJmgPzfiTn6tAGKDryq5aHrxbB1y9NpA+PJl396ch6tpz0UR8PPXQlzttz2B5HbkC0eV6KYALRJlmO7U3pAKIlMFsxC0JDXwqz2IF5r79P0wjTD24e6+evXM+XqHXRRPb3Hc16C5FxDuIgeM9Lq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaav33xT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so10306475e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742206849; x=1742811649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbZ86BA4kdFbqSY9+s8S+XusL7glxmlCPxfcM9oxYBA=;
        b=zaav33xTjNFCDYSGQOjKZZ+at+Gp6OpDwFcCApT4dAEFRgl3bLNTVvNxzKjZOMclkq
         mUsllDAvacdUuZIWs/UyVOMhElmf5FxemxfXiKtSvUjArM2AUrzfiFZnQCJNqj9+YKL3
         2WN7yHOmezs3XvGaroUCYH8jNZWZFoUkp6pEUabdl42tqm+whyRxffPx6tRWdNZ2lMER
         n77bASU2rsNkTew7Inx7dgAfrqFHieWNnZxtpQ9i3O97/60s1bhl5DVvDI5loWBh7tAI
         njma+i5yf+TLeeeLh+Blfi69SVsAi4V0tssw/MBz9lF0nx5Zb9Qg+SPEjXFmT6PR6Kf0
         M0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206849; x=1742811649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbZ86BA4kdFbqSY9+s8S+XusL7glxmlCPxfcM9oxYBA=;
        b=hf+VHGXk96/aT3/7SvdAXw72aZY9685HJ07lfKKzeBo1MzD2j0cWClDJVz0bXKKpte
         oMsRseYGFwVHZhcu2bY5y7Rp56Yjqirxb0X6nOCxAP+tZGxybD2Hx032r7vRoSCKzDzR
         41Sw/45WgRye73/+1N0TNtGDZiXpGDjI12PLEeEsXRnGe6TNdcS2yeTo7Yz4dH5gNPrw
         ENTTt66fk0gomPt94R2NXYmLgYqZw6F49MUsNgPtzv6O1bCqKxqzuOBz6Oh0aHyk6XUs
         ipf4656Kzi6p6jtX337qsrabgHKg0s7WyoR41t9TSWpBclZrWMqH0ohWz4C7lJLPPQem
         gjVA==
X-Forwarded-Encrypted: i=1; AJvYcCWy9Oj2xjuuol8+OA1/H7LOqGj/bYRqbvmma+or5OkMqxyjOfsW1qmBJzxHQ1Jo/GwbgNCy1PNcv/oKoBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhsYP8lewQAkcH8rgoNgrLrw40Womz7SH8l86cE9La3PLQDa3
	hM5+ESoeyf4pt4jalaZ1633me0gLGL0LbrgMmhmdwZmV2NTlDY4bAx9kwewWkGaCDhl+OXEW57j
	gpW2Sx1WGaA==
X-Google-Smtp-Source: AGHT+IEzYbPI9MyXHYu4Ac9ur08nSh+vGUDuVixK4h8Z9GABnEMfkvbGKDEW4lcqW9eMX+ON+NXpj/wTIp3w+Q==
X-Received: from wmdd21.prod.google.com ([2002:a05:600c:a215:b0:43b:c914:a2d9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350a:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43d1ec8643amr128960045e9.16.1742206849047;
 Mon, 17 Mar 2025 03:20:49 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:20:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHH312cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0NzXcuCtGLd5Pzc3NS8kmJdI5Mks7REUxND8+QUJaCegqLUtMwKsHn RsbW1ALTkndhfAAAA
X-Change-Id: 20250317-9pfs-comments-24b6fa5417cd
X-Mailer: b4 0.14.2
Message-ID: <20250317-9pfs-comments-v1-1-9ac96043e146@google.com>
Subject: [PATCH] selftests/mm: Add commentary about 9pfs bugs
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="utf-8"

As discussed here:

https://lore.kernel.org/lkml/Z9RRkL1hom48z3Tt@google.com/

This code could benefit from some more commentary.

To avoid needing to comment the same thing in multiple places (I guess
more of these SKIPs will need to be added over time, for now I am only
like 20% of the way through Project Run run_vmtests.sh Successfully),
add a dummy "skip tests for this specific reason" function that
basically just serves as a hook to hang comments on.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
To: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/gup_longterm.c |  6 +-----
 tools/testing/selftests/mm/map_populate.c |  8 +++-----
 tools/testing/selftests/mm/vm_util.h      | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 03271442aae5aed060fd44010df552a2eedcdafc..21595b20bbc391a0e5d0ab0563ac4ce5e1e0069f 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -97,11 +97,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 
 	if (ftruncate(fd, size)) {
 		if (errno == ENOENT) {
-			/*
-			 * This can happen if the file has been unlinked and the
-			 * filesystem doesn't support truncating unlinked files.
-			 */
-			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
+			skip_test_dodgy_fs("ftruncate()");
 		} else {
 			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
 		}
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 433e54fb634f793f2eb4c53ba6b791045c9f4986..9df2636c829bf34d6d0517e126b3deda1f3ba834 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -18,6 +18,8 @@
 #include <unistd.h>
 #include "../kselftest.h"
 
+#include "vm_util.h"
+
 #define MMAP_SZ		4096
 
 #define BUG_ON(condition, description)						\
@@ -88,11 +90,7 @@ int main(int argc, char **argv)
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
 	if (ret < 0 && errno == ENOENT) {
-		/*
-		 * This probably means tmpfile() made a file on a filesystem
-		 * that doesn't handle temporary files the way we want.
-		 */
-		ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?\n");
+		skip_test_dodgy_fs("ftruncate()");
 	}
 	BUG_ON(ret, "ftruncate()");
 
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 0e629586556b5aae580d8e4ce7491bc93adcc4d6..6effafdc4d8a23f91f0adcb9e43d6196d651ba88 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -5,6 +5,7 @@
 #include <err.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
+#include "../kselftest.h"
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
@@ -32,6 +33,23 @@ static inline unsigned int pshift(void)
 	return __page_shift;
 }
 
+/*
+ * Plan 9 FS has bugs (at least on QEMU) where certain operations fail with
+ * ENOENT on unlinked files. See
+ * https://gitlab.com/qemu-project/qemu/-/issues/103 for some info about such
+ * bugs. There are rumours of NFS implementations with similar bugs.
+ *
+ * Ideally, tests should just detect filesystems known to have such issues and
+ * bail early. But 9pfs has the additional "feature" that it causes fstatfs to
+ * pass through the f_type field from the host filesystem. To avoid having to
+ * scrape /proc/mounts or some other hackery, tests can call this function when
+ * it seems such a bug might have been encountered.
+ */
+static inline void skip_test_dodgy_fs(const char *op_name)
+{
+	ksft_test_result_skip("%s failed with ENOENT. Filesystem might be buggy (9pfs?)\n", op_name);
+}
+
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 bool pagemap_is_swapped(int fd, char *start);

---
base-commit: a91aaf8dd549dcee9caab227ecaa6cbc243bbc5a
change-id: 20250317-9pfs-comments-24b6fa5417cd

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


