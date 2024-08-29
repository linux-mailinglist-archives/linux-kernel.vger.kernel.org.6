Return-Path: <linux-kernel+bounces-307734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F43696523E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50E91C24550
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DB1BBBEF;
	Thu, 29 Aug 2024 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i9NMRfNF"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB81BB6BF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967853; cv=none; b=aG7I3zgnmi1i9tpu3ztxHXGeVCHnQ1t5ln+TJhnUUdl/YggOO85gbGF9yJWc8KONNzEZVyI1lsbIj7LaEItoXT1JEosk21F7PWpG1yXhgLIu5ZHR17neiqvOFS2Br7xytg4N792GA0yP4O8yPJQhZMElxudtl9CSv2jvlg0GXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967853; c=relaxed/simple;
	bh=ACgdkIlvnRhZ7PHc5BWlTN2Eo+ik0nzcD6MIX1rROxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TibAg2wNoDrA6XfWWXJDzxA6yvtlxf4fKaGpP91gXp6iFj+MNoeFM89w9tj5ZWkJm6iJGyQuJPDZY9pnAmR6hEgRH6U8SiK7YPMjEcoCbIDUEQkl5rhnEyB3CfG2sqOuJ0SAL+DvUc7RsL4WtLseAVGNIYzqEeqNMz7y3amk6ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i9NMRfNF; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df075ef43cso91998b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967851; x=1725572651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAPF+mFWkE9aMPYn9qrkTRHhUapPOCqVhxefhrunDUc=;
        b=i9NMRfNFMGr3JCOXXE3q6gYMg8F8eTQZNKu1z/77/140ymVMZ4KjNAtJ9h+MhXDNLs
         pqj/Ts5TC3ije71bkF2NVNOykOfrdmnjyzxTCjWVQG2+kTuI0exNSGw5U1wM3lLtjH2a
         HIdvlo8cSQnYTW6Z4tcsLWXkPXdt53BJK5bmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967851; x=1725572651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAPF+mFWkE9aMPYn9qrkTRHhUapPOCqVhxefhrunDUc=;
        b=GFzmlyBI/kiUd/Yh0RfJSKIwSCKP4y2cadLYrzGPz1q64636U1IVF/beZ7guVLZIg5
         jjh1AaVdMpE88UlHu3VIifkyU4N8SX+k4/BCosfOkekR62sYZRTL3HgmCVXu6oHUjN/p
         Lqs116MvYO+Mhnu+LZZV8shNUetv5JEMo3Nc6k+yb381mKVWxNkQ9FwWXpEaQHM/ZkXP
         mEgjnst4ZM4i2+IAfmCsWF24lBZFQ6jbuJiTz4okzFq8l+llu8idUVMNHfuYPZd4JxFZ
         CUp49OKVOymbEYyjDzLufV0fP2ETT2qlWrTSo7n9oh7UTuRSQmwwSZl4JtHvObzSBeVc
         4u1g==
X-Forwarded-Encrypted: i=1; AJvYcCVbGaDG2P7Ti7NRW8Bu0SFekMQI/SH8/IYbORAFpnKepqMvyBTkwAFoZ9MI99MYS77vSNYPWQNEXgJh9c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmqunmoTZtQ5opO7OXPeNhnBq4LbT+oD8Q7BpI+wZqK3BQSoA
	JB3NbAF6pI50uwpdpsz5TpILAlwEQXbQ/0fJ1Tyw3sqEAfivzRNZjArT3yNYqg==
X-Google-Smtp-Source: AGHT+IHtVngpZOZlZonUTLqOqg/y/b0gvT/st7+gVnwMaqdrCOVHCIfjFfjqHOSo+TMO91gZzOvYCQ==
X-Received: by 2002:a05:6871:5226:b0:260:ccfd:2e52 with SMTP id 586e51a60fabf-27790377431mr2564127fac.7.1724967850809;
        Thu, 29 Aug 2024 14:44:10 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e56d7593sm1585108b3a.168.2024.08.29.14.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:10 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 4/4] selftests/mm: mseal_test add more tests for mremap
Date: Thu, 29 Aug 2024 21:43:52 +0000
Message-ID: <20240829214352.963001-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240829214352.963001-1-jeffxu@chromium.org>
References: <20240829214352.963001-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add sealing test to cover mremap for
Expand/shrink/move across vmas.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 202 +++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index d83538039e76..494035129d65 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2338,6 +2338,197 @@ static void test_seal_mmap_reuse_addr(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mremap_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 12 * page_size, 6 * page_size, 0, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	} else {
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	ret2 = sys_mremap(ptr, 8 * page_size, 12 * page_size, 0, 0);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_expand_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and expand cross VMA boundary will fail */
+	ret2 = sys_mremap(ptr, 8 * page_size, 10 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mremap_move_shrink_multiple_vmas(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 12 * page_size;
+	int ret;
+	void *ret2;
+	int prot;
+	void *ptr2;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+
+	ret = sys_munmap(ptr2, 12 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	ret = sys_mprotect(ptr + 4 * page_size, 4 * page_size, PROT_NONE);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* move and shrink cross VMA boundary is NOK */
+	ret2 = sys_mremap(ptr, 12 * page_size, 8 * page_size, MREMAP_FIXED | MREMAP_MAYMOVE, ptr2);
+	FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr + 4 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 4 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2359,7 +2550,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(97);
+	ksft_set_plan(105);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2480,5 +2671,14 @@ int main(int argc, char **argv)
 	test_seal_mmap_reuse_addr(false);
 	test_seal_mmap_reuse_addr(true);
 
+	test_seal_mremap_shrink_multiple_vmas(false);
+	test_seal_mremap_shrink_multiple_vmas(true);
+	test_seal_mremap_expand_multiple_vmas(false);
+	test_seal_mremap_expand_multiple_vmas(true);
+	test_seal_mremap_move_expand_multiple_vmas(false);
+	test_seal_mremap_move_expand_multiple_vmas(true);
+	test_seal_mremap_move_shrink_multiple_vmas(false);
+	test_seal_mremap_move_shrink_multiple_vmas(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


