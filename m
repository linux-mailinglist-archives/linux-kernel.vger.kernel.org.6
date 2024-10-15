Return-Path: <linux-kernel+bounces-364958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56D99DBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08094287D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E715D5CE;
	Tue, 15 Oct 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1HQ6A54"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454915B115
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956034; cv=none; b=q7C83HznSiXx1yKcE5gZCLzH0Os3VZ2hrZaj2KAlku4dv7vs4kfHqhnr5KQmYPI4KTfmt/Ya7CH9v7p7ZDJw/kdSj8RK2eIIVLrMkphqFYVP/6aORBXnqHymzrvUoO9eW+jCa+VBSz3wndBilMCmavxo+oqVDy1teo8aZS3xXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956034; c=relaxed/simple;
	bh=QII9r4fc3119Wy1Fk5d28jwhD4LaT6craTteAVb6YM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSkF+8XKKJlfF6rPBP4IFk46x9MyjPi2bpWVECV36V8XmaI3saK5xDw8YSdNeTuobtiFrckV9v7nquxhARFeGvkOr//FB3i21RkspNeHBaXJ8s057egDZdUJ2KgdX46WmSsQNiAc4enhbYGN5YJ+j2utsRM2BpBEv3kt9A2Dv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1HQ6A54; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e483c83dbso2992392b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956032; x=1729560832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3z8aqN2PapGEchw6ngaiDWNeD417V3WkhQBwYXWFqM=;
        b=a1HQ6A54I/M1WHas+YuY5eWYYjMclIi//q4labA5I5vyV+qYSfpIWxNKwwn2xRd0Ev
         VzSQGVEBDMVynsqTK9+FUDS6SLVt3L96ALLQtDIGVi6viGs69wWXwHYUiI02LKq+gp/c
         DIKzf1ej3v2DdV1U49g1/P9nRRDzvJVRsPfHA4R/qfjrTr4LkkzJENNxjHswchEfrw31
         b5USs5LhCd6EjDXrBbPVYoVVCRsg+X2GS+fPoT6wWMirc/HZkkAYrAT87W/8b+nm6XQ0
         wl77/1R4RlBPi9t5VE6sEeXGV4s6D9hYh7O6nTpQzhxt9C4jNKjuPnCkPFXCFooUG1BN
         spVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956032; x=1729560832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3z8aqN2PapGEchw6ngaiDWNeD417V3WkhQBwYXWFqM=;
        b=oaJ2oQFdONNZWkOXCQjtLJgPACwGdApnzxcY+qs135pTSUZm8FI+5CzXBlgCDnNMyY
         lHMLgx9NuIJ+G0YrSPdHqGudiUZTPGkTziYv+xxx+uXzwGjkfj9boVv0Uasi82has3VR
         65S0GL4C3vmTIBVaM1nAnX4zIuJauv23p5d5IhRkg4WY6bqq5Jlhf6wIaiZBdN6NtIIG
         mLCNl8O+Dwh3b626BY9frLA8YC8HGckYi6zjRT6gthGhlXh65mYbYHfWqrsMikwjC7VL
         AOVLMpIbs+K0hiQ/Eru0AlXz/seXKoGfLMo8je0xp6wbiXP4yzudkuSf/zn7FhR5sR/9
         EI7A==
X-Forwarded-Encrypted: i=1; AJvYcCVsv14HYCqySzDUvoED8yb+kIrGa3zeq4Ub4R35DZO9pqIDIUZ7UIKVLt1qEpW2DgiloTbS1/HRtWgzI8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVpnn5xeS8O3T5urToG0q9HidTtMobFfYn6SYlwbgnjkmJE/HP
	BGqiqUKNUPttYj9ZpxtcxH9ga9liiUucWEXiiQyZQJ47JNMu6xrm
X-Google-Smtp-Source: AGHT+IGqbk3XkcP38tM4YL865mfr8G0wKwLOrKwm5cB+ZAuXCK3oFNnJ20ByJ9R3zI+2HFTRH1ioYA==
X-Received: by 2002:a05:6a00:9a1:b0:71d:f215:1d96 with SMTP id d2e1a72fcca58-71e37e287e7mr22675408b3a.6.1728956031701;
        Mon, 14 Oct 2024 18:33:51 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:33:51 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC RESEND v2 01/13] mm/kfence: Add a new kunit test test_use_after_free_read_nofault()
Date: Tue, 15 Oct 2024 07:03:24 +0530
Message-ID: <c987f2cb5d19e400ba3f1167e730a00bc16b7ca8.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirjhar Roy <nirjhar@linux.ibm.com>

Faults from copy_from_kernel_nofault() needs to be handled by fixup
table and should not be handled by kfence. Otherwise while reading
/proc/kcore which uses copy_from_kernel_nofault(), kfence can generate
false negatives. This can happen when /proc/kcore ends up reading an
unmapped address from kfence pool.

Let's add a testcase to cover this case.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: kasan-dev@googlegroups.com
Cc: Alexander Potapenko <glider@google.com>
Cc: linux-mm@kvack.org
---
 mm/kfence/kfence_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00fd17285285..f65fb182466d 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -383,6 +383,22 @@ static void test_use_after_free_read(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+static void test_use_after_free_read_nofault(struct kunit *test)
+{
+	const size_t size = 32;
+	char *addr;
+	char dst;
+	int ret;
+
+	setup_test_cache(test, size, 0, NULL);
+	addr = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
+	test_free(addr);
+	/* Use after free with *_nofault() */
+	ret = copy_from_kernel_nofault(&dst, addr, 1);
+	KUNIT_EXPECT_EQ(test, ret, -EFAULT);
+	KUNIT_EXPECT_FALSE(test, report_available());
+}
+
 static void test_double_free(struct kunit *test)
 {
 	const size_t size = 32;
@@ -780,6 +796,7 @@ static struct kunit_case kfence_test_cases[] = {
 	KFENCE_KUNIT_CASE(test_out_of_bounds_read),
 	KFENCE_KUNIT_CASE(test_out_of_bounds_write),
 	KFENCE_KUNIT_CASE(test_use_after_free_read),
+	KFENCE_KUNIT_CASE(test_use_after_free_read_nofault),
 	KFENCE_KUNIT_CASE(test_double_free),
 	KFENCE_KUNIT_CASE(test_invalid_addr_free),
 	KFENCE_KUNIT_CASE(test_corruption),
-- 
2.46.0


