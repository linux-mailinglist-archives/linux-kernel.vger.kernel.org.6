Return-Path: <linux-kernel+bounces-573226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA38A6D47B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522EF3B2C8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A379E2066CB;
	Mon, 24 Mar 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN51GcXY"
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2E1204C2C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742799218; cv=none; b=i1cBaCrwjikGBNmuCgtK90+S2ijiiOzQWVzIZ0Eh5ZferJRtjOao7Ld6+ZhILUX05WKi1Yq6aySMa4C1TFCrvtgeiTzPMTva4q89AgQWYhJMx0rpyCRqskgRJO4pMcvsDyP88kT+y/Ol26+R0b/UPAaUq/29TjIQkqHr0GdP5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742799218; c=relaxed/simple;
	bh=a/655ARJD96yOrrJq8qv2chSeO2igeF+EpgPoB34Lko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWezqAqbUUDLWVavow+1F2W6JQ9koCtOqIF2WSDX4KIDO8L/7uKOlbPQdhAnZ6BweUQFMS94LJT25rgssL0zgKIBX7cQGYzG2jPQr951iXikxQynzWXiKXa3N4qak2JHXcWMHnyfSJmJGgO3mnsqN5jnRYqWcYfP9/jBgk6EQzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN51GcXY; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-85dad46e9ddso338942339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742799214; x=1743404014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ffy3DLCEfKN3in8d5zlc7vx3iwgfrqHuCXTxXTm84ts=;
        b=BN51GcXYon69e0DC3wmCG7WMntjOUTb3SBB+Gr7psZ5Oic05Ub9A9VnlMIxiQg4OVo
         sSY0y99d38pDT6F/BgOq0k0Udql1nVxT5qHpxlHlaQp2NsOtgK8L3JaEcF7TTszUaDt6
         yP99+3LZjCg9G4p1e96aAxYOLxcuqz69LRCD1x8uvrmPZyzkz7Zw0G40PTfaZ0V1QxFi
         uXYyjgnQKtrP5OFOuXEtXczjFPIa70OcCf5nCarrYczJulzXcQyMmdknixeTutMEWAob
         F8GOkto/ckriWp8A2xVKwRUZD+8BqJfqK4K+gU7GuIsWDJwy+ealOAWjyEtaIZYeB8sI
         V6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742799214; x=1743404014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffy3DLCEfKN3in8d5zlc7vx3iwgfrqHuCXTxXTm84ts=;
        b=IIxQQ0S/jmiJpAU+tMlI1qAWXXwONFn0xFUrJ+0c/P2lDDvAabeigRimVLCyb2M2BY
         SjoLd3yHPSVV5Lf2G/8p1Sw7gyndbBRBT6h7FP/yveQZpOAKLk2CAyfv7gFCVnD3f15H
         9P0SpQBKEjBhi5NNRokky/h03vm5SOAC97VHV/kSiix1Ey+3JmxHcdcGU3VZz028mfma
         hfM8PBjr9dnxh9CApGBV1zqf4rhXtlqObNT3UVrSDhY9jTGBGQG7Xr7rK8FE93ePi/I8
         VoFirDEckaQdFcQ6b/psLOMXdO2BdKDONM69EUHiZBZTsGy5VTiDMacspDZAVqBjIYRA
         Di3A==
X-Gm-Message-State: AOJu0YztRSurbtgi/74aisXNPND9iEXcRT0ohFA9bzBvnJ3TgXwTR65e
	PNHV0i/1Tgq32hiGRlMCFiytrF1swuRcuUppyUgOGiFCvViLM/28xNS7xhwctmRs2KcIulv/gD9
	VUg==
X-Google-Smtp-Source: AGHT+IFwtFlPb7SBpjbVuF+q5bn8QiiRzWt4tMIZGVuP7apCHzJYW7HGlUxBgl+wR+Dv2VtTkkVMvH9ZZQw=
X-Received: from iobbw19.prod.google.com ([2002:a05:6602:3993:b0:85b:40c7:ce65])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a6b:7b07:0:b0:85b:5511:e47f
 with SMTP id ca18e2360f4ac-85e1ef9251emr1427245839f.3.1742799214336; Sun, 23
 Mar 2025 23:53:34 -0700 (PDT)
Date: Mon, 24 Mar 2025 06:53:28 +0000
In-Reply-To: <20250324065328.107678-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324065328.107678-1-avagin@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324065328.107678-4-avagin@google.com>
Subject: [PATCH 3/3] selftests/mm: add PAGEMAP_SCAN guard region test
From: Andrei Vagin <avagin@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Andrei Vagin <avagin@gmail.com>

Add a selftest to verify the PAGEMAP_SCAN ioctl correctly reports guard
regions using the newly introduced PAGE_IS_GUARD flag.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/mm/guard-regions.c | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index 0c7183e8b661..c99f3da8bfb7 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -8,6 +8,7 @@
 #include <fcntl.h>
 #include <linux/limits.h>
 #include <linux/userfaultfd.h>
+#include <linux/fs.h>
 #include <setjmp.h>
 #include <signal.h>
 #include <stdbool.h>
@@ -2079,4 +2080,60 @@ TEST_F(guard_regions, pagemap)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+/*
+ * Assert that PAGEMAP_SCAN correctly reports guard region ranges.
+ */
+TEST_F(guard_regions, pagemap_scan)
+{
+	const unsigned long page_size = self->page_size;
+	struct page_region pm_regs[10];
+	struct pm_scan_arg pm_scan_args = {
+		.size = sizeof(struct pm_scan_arg),
+		.category_anyof_mask = PAGE_IS_GUARD,
+		.return_mask = PAGE_IS_GUARD,
+		.vec = (long)&pm_regs,
+		.vec_len = ARRAY_SIZE(pm_regs),
+	};
+	int proc_fd, i;
+	char *ptr;
+
+	proc_fd = open("/proc/self/pagemap", O_RDONLY);
+	ASSERT_NE(proc_fd, -1);
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	pm_scan_args.start = (long)ptr;
+	pm_scan_args.end = (long)ptr + 10 * page_size;
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 0);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Install a guard region in every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(syscall(__NR_madvise, ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/*
+	 * Assert ioctl() returns the count of located regions, where each
+	 * region spans every other page within the range of 10 pages.
+	 */
+	ASSERT_EQ(ioctl(proc_fd, PAGEMAP_SCAN, &pm_scan_args), 5);
+	ASSERT_EQ(pm_scan_args.walk_end, (long)ptr + 10 * page_size);
+
+	/* Re-read from pagemap, and assert guard regions are detected. */
+	for (i = 0; i < 5; i++) {
+		long ptr_p = (long)&ptr[2 * i * page_size];
+
+		ASSERT_EQ(pm_regs[i].start, ptr_p);
+		ASSERT_EQ(pm_regs[i].end, ptr_p + page_size);
+		ASSERT_EQ(pm_regs[i].categories, PAGE_IS_GUARD);
+	}
+
+	ASSERT_EQ(close(proc_fd), 0);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.49.0.395.g12beb8f557-goog


