Return-Path: <linux-kernel+bounces-376573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54A79AB362
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB15D1C22898
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6931A0AF5;
	Tue, 22 Oct 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uChcW7Dq"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2919F131
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613239; cv=none; b=rzWhKzNj73zjiUyZO2MerHy/6MNNqlWOEOPinw2waX7hEn6bz0ASs3z+u/4/ZT7xVRhanpN9AoBZ81RjYholCRWsSKp9cLPGQLHmfHgIUYfmTfi9pVC8XY/NEnDRTXdpDS/bKVwUWyrdFmM4CMKKXjQH3RHy9KsAfXzMnt473xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613239; c=relaxed/simple;
	bh=yzQsSYfHeihUsChvpuaOONbDivuLpNaJaW0LLuBKdN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nZ1yKGK3BWF18XZOB2IxGWSQ3RLXqTaVP0Ekkf8tnNAzqq9Wdtd+nbfd1IeUwVMvPVSs4YvBb72/hYfmkMw48gXCEhq8RJMccc+p5tjHWj/NK11+br1mLS8h8oRxTunfxRWTdCLMLG2xrUp8K4eu+0EE0yoJmH8IRj4gov5NQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uChcW7Dq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729613233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n52RayRNzRsyQEiYVNwVsqKfALVoNrkzsm4wddplA60=;
	b=uChcW7DqZ1Lp6aDNkqr2H6rWhe1k6hGZEIkci5asTlmZiCDzsHYkmEQiVR5qaZXB1YnAbK
	SBlextf1R1Hn/0YUD1qCQcT01YlHyYtRNFhSTKZOAkmKKt+DFjYo++cewFIuNJzbcfHZvI
	uJ9WtBwIRziAZ3/sqhiZ9WIY0WMxlQY=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: [PATCH] kasan: remove vmalloc_percpu test
Date: Tue, 22 Oct 2024 18:07:06 +0200
Message-Id: <20241022160706.38943-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

Commit 1a2473f0cbc0 ("kasan: improve vmalloc tests") added the
vmalloc_percpu KASAN test with the assumption that __alloc_percpu always
uses vmalloc internally, which is tagged by KASAN.

However, __alloc_percpu might allocate memory from the first per-CPU
chunk, which is not allocated via vmalloc(). As a result, the test might
fail.

Remove the test until proper KASAN annotation for the per-CPU allocated
are added; tracked in https://bugzilla.kernel.org/show_bug.cgi?id=215019.

Fixes: 1a2473f0cbc0 ("kasan: improve vmalloc tests")
Reported-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/all/4a245fff-cc46-44d1-a5f9-fd2f1c3764ae@sifive.com/
Reported-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Link: https://lore.kernel.org/all/CACzwLxiWzNqPBp4C1VkaXZ2wDwvY3yZeetCi1TLGFipKW77drA@mail.gmail.com/
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 mm/kasan/kasan_test_c.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d3..d8fb281e439d5 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1810,32 +1810,6 @@ static void vm_map_ram_tags(struct kunit *test)
 	free_pages((unsigned long)p_ptr, 1);
 }
 
-static void vmalloc_percpu(struct kunit *test)
-{
-	char __percpu *ptr;
-	int cpu;
-
-	/*
-	 * This test is specifically crafted for the software tag-based mode,
-	 * the only tag-based mode that poisons percpu mappings.
-	 */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
-
-	ptr = __alloc_percpu(PAGE_SIZE, PAGE_SIZE);
-
-	for_each_possible_cpu(cpu) {
-		char *c_ptr = per_cpu_ptr(ptr, cpu);
-
-		KUNIT_EXPECT_GE(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_MIN);
-		KUNIT_EXPECT_LT(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_KERNEL);
-
-		/* Make sure that in-bounds accesses don't crash the kernel. */
-		*c_ptr = 0;
-	}
-
-	free_percpu(ptr);
-}
-
 /*
  * Check that the assigned pointer tag falls within the [KASAN_TAG_MIN,
  * KASAN_TAG_KERNEL) range (note: excluding the match-all tag) for tag-based
@@ -2023,7 +1997,6 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
 	KUNIT_CASE(vm_map_ram_tags),
-	KUNIT_CASE(vmalloc_percpu),
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
-- 
2.25.1


