Return-Path: <linux-kernel+bounces-307733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B8E96523C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AADF1C2454F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D981BBBD1;
	Thu, 29 Aug 2024 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vdihf0KT"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772D1BB6A0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967851; cv=none; b=Jdj9Gyfs4oJmzPUi132Mquw/CHszhUXcE0MnkwiW7YlNKSzkIovO/gBmPsopU9B9Vz6N5J8Uqs6XleHt23+TO/aRf+HuK7kLeIRv47DfR0I69jpa+TfaGVvfaLSa30oHE3OarmAEppbl8FRPk4BnyLC5VpzctDUF8ylU3TTcTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967851; c=relaxed/simple;
	bh=j5DIz/FwohbXIbAOYNtL4lsH2nx4Cd5E1K3MEN4JHG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHPk/Nc9Z9F9kvbuue6mrvmQRL3CQrtXZjfqMCcIS4aTQQbMg7PFuCJZxmsDCt1KAhLEoGW2tkbVFy8Zc+xfV1CrYqQ2lhYCviJswDncWG8Gw2wVGHHbd4Yh/zc4w/csWYb0UdzphdLsKzHPVGDgLhgHowiBGxeaQaafz+eN6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vdihf0KT; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3dd4297af75so70944b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967848; x=1725572648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOFHefv5origwTURYhXBdEyQH2l+L4eXRhYcbCi88yk=;
        b=Vdihf0KTL5G8F2ERjwy0ZOXENyZVsW4MVBZXPRWFwiZytZamcKr84ShU4RPD+C/TPe
         6sec6OMT3RTy4zCmCi6tl0iJutZv6NA+jlfk9p/wh2mFRk4IR+P/oQce95LqUaFgBjLW
         fEDsqIdii1lyOuUeqeUFmOml6vZdLL18ctdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967848; x=1725572648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOFHefv5origwTURYhXBdEyQH2l+L4eXRhYcbCi88yk=;
        b=b1bfuMeuFa+hUlTC1o2+mAZtTzGC6RRkt2xN41VrpnTwEdh9xwoTu6Kiwa8OPsMFeg
         6vDVSVHwsjmHfIid1FugXRpmV7odhVyqhsIh7hVEz89hgL6mtpYHPcHyvQhkRbH5nhuK
         QhkeIDzykzCPPcW6nqcSd8KUHXG5MmYzZIr1QH6VFCd69lAOOc8K1luykt8EOpNAXaSA
         NmoUMK8f+xEJWGGC66BwQvteVAsTt2iPgA545qRoCG519WS+aAfFF+3rdm2xomSrmORO
         ygxXW8sCMP2QTFJ2prSRTpR1q/8LGyHi6YGy5ukmysagUNtr+bzy607WDWqbLUKryDS3
         hb4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzAZMCnbFI7+zjdffGV9igaJuAxrBQlBv1I0St4MLpqM2sQh2BSFixgg4nnWBN1vvyQ+9BuK5i9utGqfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAsd8wzzjXkF4q3UAn9rqBuTzqWh7XDemjnztkmw8ZxPnrFqm
	1BiDSnM6kAwAWZmCVKCRM4aPqGXDtVJt7qkxw/oD7v2OjzyqB4D43uOhZR/wUw==
X-Google-Smtp-Source: AGHT+IFyc3ebYhYoxmlTy374CXmH+6Huc2oIlQtKye5oZuLAVTm63hVpSqGBNKx/nJcUYkxMgJL0wg==
X-Received: by 2002:a05:6870:8a26:b0:26f:de62:7d8a with SMTP id 586e51a60fabf-277903bdf4cmr2281204fac.10.1724967848269;
        Thu, 29 Aug 2024 14:44:08 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7d22e771c48sm1709417a12.23.2024.08.29.14.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:07 -0700 (PDT)
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
Subject: [PATCH v2 3/4] selftests/mm: mseal_test add more tests for mmap
Date: Thu, 29 Aug 2024 21:43:51 +0000
Message-ID: <20240829214352.963001-4-jeffxu@chromium.org>
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

Add sealing test to cover mmap for
Expand/shrink across vmas.
Reuse the same address in !MAP_FIXED case.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 125 +++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ae06c354220d..d83538039e76 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2222,6 +2222,122 @@ static void test_munmap_free_multiple_ranges(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_mmap_expand_seal_middle(bool seal)
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
+	/* ummap last 4 pages. */
+	ret = sys_munmap(ptr + 8 * page_size, 4 * page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == 8 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to expand. */
+	ret2 = mmap(ptr, 12 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_shrink_seal_middle(bool seal)
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
+	if (seal) {
+		ret = sys_mseal(ptr + 4 * page_size, 4 * page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to shrink. */
+	ret2 = mmap(ptr, 7 * page_size, PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+
+		size = get_vma_size(ptr, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+
+		size = get_vma_size(ptr + 4 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 4 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 0x4);
+	} else
+		FAIL_TEST_IF_FALSE(ret2 == ptr);
+
+	REPORT_TEST_PASS();
+}
+
+static void test_seal_mmap_reuse_addr(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = page_size;
+	int ret;
+	void *ret2;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	if (seal) {
+		ret = sys_mseal(ptr, size);
+		FAIL_TEST_IF_FALSE(!ret);
+	}
+
+	/* use mmap to change protection. */
+	ret2 = mmap(ptr, size, PROT_NONE,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	FAIL_TEST_IF_FALSE(!(ret2 == MAP_FAILED));
+	FAIL_TEST_IF_FALSE(ret2 != ptr);
+
+	size = get_vma_size(ptr, &prot);
+	FAIL_TEST_IF_FALSE(size == page_size);
+	FAIL_TEST_IF_FALSE(prot == 0x4);
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2243,7 +2359,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(91);
+	ksft_set_plan(97);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2357,5 +2473,12 @@ int main(int argc, char **argv)
 	test_munmap_free_multiple_ranges(false);
 	test_munmap_free_multiple_ranges(true);
 
+	test_seal_mmap_expand_seal_middle(false);
+	test_seal_mmap_expand_seal_middle(true);
+	test_seal_mmap_shrink_seal_middle(false);
+	test_seal_mmap_shrink_seal_middle(true);
+	test_seal_mmap_reuse_addr(false);
+	test_seal_mmap_reuse_addr(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


