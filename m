Return-Path: <linux-kernel+bounces-307732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44B965239
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B248D1C245C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9888B1BAECC;
	Thu, 29 Aug 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RUk41ce4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741B1BAEDE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967848; cv=none; b=BotveIQkn4klpbg0jqgiY1f0hlsX/qvUvxvpcNElJG58Ch30etC+A9QCcfRcpjxBKhvYnfMfeyIQ5e7jduAUAJpj28Fjw8Cz/JZpfWDNUVHq4p3MWLvhudfQJRUCELjGlXATq7cxqSwjrqhM1Nw5ixMy722tBJ9x1rtqJ7Sl9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967848; c=relaxed/simple;
	bh=/IMNJ95SpejvcUBxNqKXzFolTjM9jYB1KqtTg3owDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE2mv1la46983xZKLESArr/DlnO67inGMnQ3HUV4gI5vHsHtHLyGCsii5k2rJYn9Vjm+Ym5NnmWOzLZTLnwgvCL5SyI+Ro3wtpcFXm5YA5DTeBCaV7o2G8YqaMAOFHzewmltqJxSr5WfSwTgtM2NdS2yg8mY6/eB9HTcTAUN6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RUk41ce4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c2e1441eddso9881a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967846; x=1725572646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qngXRj3l1V5w2+Tk+0qChrUc0VPNj8YHKUhOOfdL/8E=;
        b=RUk41ce4GTZcfQNQ5jQ6IdTUD1C9NU5KJHte9pmHqksLBkLUgpHn81h1tHOmnscD4Y
         2BJxb9rJVdrVtRjAIhz1744DgzJ65bR19CiYITJpB8WlvshCSCaWb8Dy1P844XxVCALz
         vz6NnMoRUvKXO0tlXFrGzrsUwyKV9ik/IPRTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967846; x=1725572646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qngXRj3l1V5w2+Tk+0qChrUc0VPNj8YHKUhOOfdL/8E=;
        b=GOk1JY2LXoAQ/EIwdWAuUqa0NBqFGNnS00jInj9PafuWx66K+DzrRBAUsFWY4e5qCd
         asXGi/aZx1vFhpen9S35Pf409vin+wklcHSseQh4kt9PQlIa+W3D6DPx8iJDXXRZrmi5
         ryO40yn1Py8bqQfIGe9tEFZyv10WhxS+jnQtRTxLu5OIkAF2xcVi1R1l8/G7AQK52U68
         5qgnGuWnWpLkovI8ozbIdstW2uJgMfiyHC6SDmpt5KZmQcYBaFj3+DB4JsIAbH0RzLrg
         Op8xJ+pOpWhDN0chMS2bATnBum5ttPOLKvCLnWdnSFbYZairBXhAdie+ZIEGfZrwur2p
         M/Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX9oTuK5X7FqtnCH5YSqXjQRyWh9JNdS146XIm4888oxHP3FQMZJU4S+09yqjGXnaVfqjQDtVUpW3tZ8ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5XFNl1eUB4Z9J1aQ6LDaSA0juyNKcfRVnPI5JoK1qm4CvSF0q
	6ze5kP0DbuG0KUQn8pd8plCn9v1jvkGnv8g70yK/C8yYnIwcLZg1Mq6QoEuwtQ==
X-Google-Smtp-Source: AGHT+IGw6LhTiqcHA4wOD2hbInscY7fZlLpfvydbHUPkI3AUpW/gqVA9D8kpvdBYJgGdQzekGp3weg==
X-Received: by 2002:a17:903:2350:b0:1fa:a9f5:64b1 with SMTP id d9443c01a7336-2052761fcd8mr1316265ad.3.1724967846304;
        Thu, 29 Aug 2024 14:44:06 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205152b26b2sm15882985ad.6.2024.08.29.14.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:05 -0700 (PDT)
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
Subject: [PATCH v2 2/4] selftests/mm: mseal_test add sealed madvise type
Date: Thu, 29 Aug 2024 21:43:50 +0000
Message-ID: <20240829214352.963001-3-jeffxu@chromium.org>
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

Add a testcase to cover all sealed madvise type.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 108 +++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index adc646cf576c..ae06c354220d 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2121,6 +2121,107 @@ static void test_seal_madvise_nodiscard(bool seal)
 	REPORT_TEST_PASS();
 }
 
+static void test_seal_discard_madvise_advice(void)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 4 * page_size;
+	int ret;
+	int sealed_advice[] = {MADV_FREE, MADV_DONTNEED,
+		MADV_DONTNEED_LOCKED, MADV_REMOVE,
+		MADV_DONTFORK, MADV_WIPEONFORK};
+	int size_sealed_advice = sizeof(sealed_advice) / sizeof(int);
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	ret = seal_single_address(ptr, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	for (int i = 0; i < size_sealed_advice; i++) {
+		ret = sys_madvise(ptr, size, sealed_advice[i]);
+		FAIL_TEST_IF_FALSE(ret < 0);
+		FAIL_TEST_IF_FALSE(errno == EPERM);
+	}
+
+	REPORT_TEST_PASS();
+}
+
+static void test_munmap_free_multiple_ranges(bool seal)
+{
+	void *ptr;
+	unsigned long page_size = getpagesize();
+	unsigned long size = 8 * page_size;
+	int ret;
+	int prot;
+
+	setup_single_address(size, &ptr);
+	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
+
+	/* unmap one page from beginning. */
+	ret = sys_munmap(ptr, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/* unmap one page from middle. */
+	ret = sys_munmap(ptr + 4 * page_size, page_size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	size = get_vma_size(ptr + page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+	size = get_vma_size(ptr +  5 * page_size, &prot);
+	FAIL_TEST_IF_FALSE(size == 3 * page_size);
+	FAIL_TEST_IF_FALSE(prot == 4);
+
+
+	/* seal the last page */
+	if (seal) {
+		ret = sys_mseal(ptr + 7 * page_size, page_size);
+		FAIL_TEST_IF_FALSE(!ret);
+
+		size = get_vma_size(ptr +  1 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  5 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  7 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	}
+
+	/* munmap all 8  pages from beginning */
+	ret = sys_munmap(ptr, 8 * page_size);
+	if (seal) {
+		FAIL_TEST_IF_FALSE(ret);
+
+		/* verify mapping are not changed */
+		size = get_vma_size(ptr + 1 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 3 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  5 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 2 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+
+		size = get_vma_size(ptr +  7 * page_size, &prot);
+		FAIL_TEST_IF_FALSE(size == 1 * page_size);
+		FAIL_TEST_IF_FALSE(prot == 4);
+	} else {
+		FAIL_TEST_IF_FALSE(!ret);
+
+		for (int i = 0; i < 8; i++) {
+			size = get_vma_size(ptr, &prot);
+			FAIL_TEST_IF_FALSE(size == 0);
+		}
+	}
+
+	REPORT_TEST_PASS();
+}
+
 int main(int argc, char **argv)
 {
 	bool test_seal = seal_support();
@@ -2142,7 +2243,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(91);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2251,5 +2352,10 @@ int main(int argc, char **argv)
 	test_seal_discard_ro_anon_on_pkey(false);
 	test_seal_discard_ro_anon_on_pkey(true);
 
+	test_seal_discard_madvise_advice();
+
+	test_munmap_free_multiple_ranges(false);
+	test_munmap_free_multiple_ranges(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


