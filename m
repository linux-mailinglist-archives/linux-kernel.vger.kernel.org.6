Return-Path: <linux-kernel+bounces-440334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322AA9EBBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC0828467E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F6237A3F;
	Tue, 10 Dec 2024 21:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKrZ7EJj"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878D23238E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866269; cv=none; b=ZSlt2EugJrqCN43pxYjk0fb+gqIcZAaL1BD5GNLmgJgM/vNCAZ0BwX0Hi8hgAmaHwYHy5E0c5siMNqP22wEplK1s+m7yLpbesW3bVBELKzC0vucLY5K4reyYTWqpgGagBQEmp7dRUDb1SnCtSTUVODnkuU53pYteYC/6qbyLinc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866269; c=relaxed/simple;
	bh=Fo+jcVx3pAYgTTMoKfson94C1ceVwwTfSgpbPciuP1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qh+mVYHQzgVoP8nvMZ74L/v55dbPgju1d5X+g2lV68rMeWVP35kIAru59jm8b0P7RciRbg27QuKthTnvAIVa4FjbS9U9UwZ/Uva9sdtzRGa7ThX6SA83sYKDjYq2cqJY2bQ1t8DTM1lmpj7rczk560MDvGlnKjpUnmFHy6dMDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKrZ7EJj; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46775c891d2so50402971cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733866264; x=1734471064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Ew5mGOm8qX6hJiqcK96oIfktQ2zB7aJWIvrQrH8Us=;
        b=zKrZ7EJjCHzcD2CWQD9GlJWDU5BJqFwcd0CbBENW0tchiXxlhuuoJpTo2mQQ+TMFPd
         RTiMBUNU4+e98Xswxy4TLPvQXIKAAjf/9KZ8qNLIyBCA/tGfLs/oLvaXqI+dlYoLrnS4
         xtJ1pBwq8AqjsVMjmVxqpkNK6bCNclIMp6tZuX8uF3G1d7K5sSGEGVxJjbIwvN5RBNG9
         37x2cdIF0CpWRQGl07wzHRxZ2IdH/DD8HQdsvu2omRa0JILuAhiQHrtheJLd5PzrWNhk
         vzS5ALET417MeLqJp7AZffXOxW/GtmrZblziyqUz4WOlwSXDmuCF2e7+ho+6gK4yfiyG
         Rbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733866264; x=1734471064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Ew5mGOm8qX6hJiqcK96oIfktQ2zB7aJWIvrQrH8Us=;
        b=V6brck1ydwqKjPwieRSeUJmo1hMPTqiLSMeU5kXgDrntcCWdtneRd/uuTgtiNUYG9M
         KRuvcL+Gf8BKq+gl+eGcAqgGDvSQwAMODAR6OpsQKSd4kMmalxAqRM7r0Ygc8cLMVevq
         U7qpK7UhRXN3hQBb4JLNpYJvrqM9ZFyLr1K9BaJs4jzLPRC84A8HazVseUfxcpRDvIdt
         8TXaG9vxWIV9rfCDuQUymcnFo86JaPWPUHyPmILtou1Ol/PDaw9pIwkNI9RlVpqIM3/S
         N+4f5yz1F/EiTPqUPm8iELiUMEjLEW+rP2rE4YOiVnD37yUGAZVSYDuiQZOOfCDQSrfb
         dLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNMNSbGQ3UXO2LPMaaLLl+NevhSqSbGdKQpHVE+yYwoPIF3ZeUGMWxchs3DtPSUQ0ujFgLkDQxRu5Dlcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ey4f3dB5Fbd2IUjJUOA/oumXrqZi+9qAGZ452753F80e4aD7
	ISHmCdem/kmvPqyYxvvRlP341z5lLt/mO/xTlkh0teUMfL4psXnW3uDDB1rywl2YVswrSLzIMEI
	XBEQzyA==
X-Google-Smtp-Source: AGHT+IHcROXBNbjH71/lURsLY2Z1G5CKon5Ljv9fq9orhUweiNnkkP9Uhr+rnjfYEZKZsBEOScmUDcRF+8Fv
X-Received: from qtbcg3.prod.google.com ([2002:a05:622a:4083:b0:466:9f81:8c8c])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:1389:b0:467:7fbf:d115
 with SMTP id d75a77b69052e-467892a43f3mr8418101cf.12.1733866263990; Tue, 10
 Dec 2024 13:31:03 -0800 (PST)
Date: Tue, 10 Dec 2024 16:30:50 -0500
In-Reply-To: <20241210213050.2839638-1-bgeffon@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210213050.2839638-1-bgeffon@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210213050.2839638-6-bgeffon@google.com>
Subject: [RFC PATCH 5/5] selftests: mm: Add selftest for new_addr hint with MREMAP_MAYMOVE.
From: Brian Geffon <bgeffon@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Marco Vanotti <mvanotti@google.com>, linux-kernel@vger.kernel.org, 
	Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"

This selftest tries to validate that a hint will be used with
MREMAP_MAYMOVE. Given it's just a hint we try to structure the test
in a way where it will succeed.

To ensure we can validate the behavior we create a single mapping
and split it by unmapping the middle and we'll use that as a hint
for MREMAP_MAYMOVE without using MREMAP_FIXED.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/testing/selftests/mm/mremap_test.c | 113 ++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5a3a9bcba640..42ed869e2e01 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <syscall.h>
 #include <sys/mman.h>
 #include <time.h>
 #include <stdbool.h>
@@ -270,6 +271,115 @@ static void mremap_expand_merge(FILE *maps_fp, unsigned long page_size)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+/*
+ * This test validates that mremap(2) with MREMAP_MAYMOVE uses the new
+ * address as a hint.
+ */
+static void mremap_maymove_hint(FILE *maps_fp, unsigned long page_size)
+{
+	char *test_name = "mremap MAY_MOVE with hint";
+	void *mapping_a, *mapping_b, *mapping_c, *remapped, *hint;
+	intptr_t base_map_addr = 0x8FF00000;
+
+#if !defined(__i386__) && !defined(__x86_64__)
+	/*
+	 * This test is written with knowledge about the architecture specific behavior of
+	 * get_unmapped_area(). For that reason this specific test is only applicable to x86.
+	 */
+	ksft_test_result_skip("%s\n", test_name);
+	return;
+#endif
+
+	/*
+	 * To validate the behavior we'll use the following layout:
+	 *
+	 * | mapping a |                   |   mapping b    |   mapping c   |
+	 * | 1 page    | 10 pages unmapped | 2 pages mapped | 1 page mapped |
+	 *
+	 * To guarantee we can get this layout we'll do a single mmap and then
+	 * munmap and mprotect accordingly, this will prevent the test from being
+	 * flaky.
+	 *
+	 * We'll attempt to resize mapping b to 3 pages using MAYMOVE, because
+	 * mapping c is beyond it it'll have to be moved. We will use mapping a
+	 * as the hint to validate it lands just beyond it. The final result:
+	 *
+	 * | mapping a |                  | mapping b      |                  |   mapping c   |
+	 * | 1 page    | 2 pages unmapped | 3 pages mapped | 7 pages unampped | 1 page mapped |
+	 *
+	 */
+	mapping_a = mmap((void*)base_map_addr, 14 * page_size, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (mapping_a == MAP_FAILED) {
+		ksft_print_msg("mmap failed: %s\n", strerror(errno));
+		goto out_fail;
+	}
+
+	mapping_b = (void*)((intptr_t)mapping_a + 11*page_size);
+	mapping_c = (void*)((intptr_t)mapping_a + 13*page_size);
+
+	/* unmap the 10 pages after mapping a */
+	munmap((void*)((intptr_t)(mapping_a) + page_size), 10*page_size);
+
+	/* make mapping a and c PROT_NONE to complete the vma splitting */
+	mprotect(mapping_a, page_size, PROT_NONE);
+	mprotect(mapping_c, page_size, PROT_NONE);
+
+	/*
+	 * Validate the split: mapping a, b, and c are mapped with a gap after 'a'.
+	 */
+	if (!is_range_mapped(maps_fp, (unsigned long)mapping_a,
+				  (unsigned long)(mapping_a + page_size))) {
+		ksft_print_msg("mapping 'a' was not mapped at %p\n", mapping_a);
+		goto out_fail;
+	}
+
+	if (is_range_mapped(maps_fp, (unsigned long)mapping_a + page_size,
+				  (unsigned long)mapping_a + 10*page_size)) {
+		ksft_print_msg("unmapped area after mapping 'a' not found\n");
+		goto out_fail;
+	}
+
+	if (!is_range_mapped(maps_fp, (unsigned long)mapping_b,
+				  (unsigned long)(mapping_b + 2*page_size))) {
+		ksft_print_msg("mapping 'b' was not mapped at %p\n", mapping_b);
+		goto out_fail;
+	}
+
+	if (!is_range_mapped(maps_fp, (unsigned long)mapping_c,
+				  (unsigned long)(mapping_c + page_size))) {
+		ksft_print_msg("mapping 'c' was not mapped at %p\n", mapping_c);
+		goto out_fail;
+	}
+
+	/*
+	 * Now try to mremap mapping 'b' using a hint, it will be increased in size
+	 * so that the VMA must be moved. Bypass the glibc wrapper of mremap(2) becuase
+	 * it will attempt to 0 the hint unless MREMAP_DONTUNMAP is set, for reference:
+	 * https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=6c40cb0e9f893d49dc7caee580a055de53562206;hp=54252394c25ddf0062e288d4a6ab7a885f8ae009
+	 */
+	hint = (void*)((intptr_t)mapping_a + 3*page_size);
+	remapped = (void*)syscall(SYS_mremap, mapping_b, 2*page_size, 3*page_size, MREMAP_MAYMOVE, hint);
+	if ((intptr_t)remapped != (intptr_t)hint) {
+		if (remapped == MAP_FAILED)
+			ksft_print_msg("remap of 'b' failed %s\n", strerror(errno));
+		else
+			ksft_print_msg("mapping 'b' was unexpectedly remapped from %p to %p. expected: %p\n",
+				mapping_b, remapped, hint);
+		goto out_fail;
+	}
+
+	munmap(mapping_a, page_size);
+	munmap(remapped, 3 * page_size);
+	munmap(mapping_c, page_size);
+	ksft_test_result_pass("%s\n", test_name);
+	return;
+
+out_fail:
+	ksft_test_result_fail("%s\n", test_name);
+}
+
 /*
  * Similar to mremap_expand_merge() except instead of removing the middle page,
  * we remove the last then attempt to remap offset from the second page. This
@@ -720,7 +830,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 3;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -842,6 +952,7 @@ int main(int argc, char **argv)
 
 	mremap_expand_merge(maps_fp, page_size);
 	mremap_expand_merge_offset(maps_fp, page_size);
+	mremap_maymove_hint(maps_fp, page_size);
 
 	fclose(maps_fp);
 
-- 
2.47.0.338.g60cca15819-goog


