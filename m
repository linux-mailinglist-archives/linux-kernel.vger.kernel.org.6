Return-Path: <linux-kernel+bounces-309295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5428B9668A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E031C21143
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C91BD038;
	Fri, 30 Aug 2024 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hncTTrDz"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E1A1BC06E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040967; cv=none; b=Qwy3t7d5G5dJTTSVP4orcB2d1U1u4JJF1KoJ/DEc1f12XJE9QQAYENnNLiIh8IfdQwEelp8gNDD3hoIiATxjbPukFhmBsGmMGacabPeGnl7KvMW0ctV2fbq59VfaExq6YBJszfU3/BKZkdxk+lHDxPQLZvghhDGn48tn2YRVpdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040967; c=relaxed/simple;
	bh=k9Yj8N7+CNONduZGW66WtwLdIDyZHwlEArsp28UOTIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5P7Pc2dLS6K60F24ngu2r8U80oMl08G/6MBKNofO10uPxv55v/RtpRTJVP2xQSqLTZARTAeARsYHv9Gwyu4ltOkf4VS4kfAljW7rm2W5LGn+ZDN6i/nACxYTB2rLP8WmuQGDhOXWHvN243P3JJARMmW/yeI2lCtmcUy6t5LdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hncTTrDz; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd83a973bdso65976a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040965; x=1725645765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKGNPxNsYKipWJTu2FnzfGVLgyBodzOHMPjLCFGxD/E=;
        b=hncTTrDzxIn+QoNsX8+QdNmvId2/WlUak+Sscn1FTY+HOI/NO88DOFHoayCOn7ehhk
         2cVY5hvqKN3cANsn7AdKquRfF2RSnkL1aIoooXX1eDXAA4St2DNKEO6ayDpg9NYSJPJx
         yMJ/6UDWLl5Co44xHNyKyBGwXbzEic3ICBcrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040965; x=1725645765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKGNPxNsYKipWJTu2FnzfGVLgyBodzOHMPjLCFGxD/E=;
        b=ZKOMqmBs6sxHC5evfOqYeJnzUs/ESw2p88VX201sKai6KF87O2WPDfsMtfNQpilJTk
         aopQc/pO3DRSjfsbEJegvUW8f8mCl/4G0fNa75FodFrICvwNtUZgrpEqn5A7nzV+jjvE
         vlvd+pxzbi2iaLVXOnMpj97gh5iz4D3AjoYkFwsIVocKSF2rZXzrz17ft78AqXjh/E+y
         WX/7XHUfR/nYmzrcX+cpPeqRDAPOT8FBar1qJMVjY5BvqY1S32MghfSR+QDRGAov2Mj2
         9Q4sgPXvlH3C/qT301lFqSjRMY5bUy4TyATKw9iYTGaT5YDcgZbeeSRrd9IwJgNhE/xa
         xrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn4HfuqWCCCJg/DGnwB0ySNTNnBx7TjHpNgFV454xpN8rj85dc2mGKdDWmddMOX3JC0KR7B4jXnep2a0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1BadnYGqft/q9Ml7llP1cg2RO35wmIMZ/ie7oU2gLB1NtSVr8
	6psUMieIszW3u0DEddw/+46tWCpC4EsPuNz6pS32NUdA6EB9/DjW6Bl5So53rQ==
X-Google-Smtp-Source: AGHT+IEihnCD63EfKi0DOVXqIMhOWH4VJANKaavsJJCvNs5Q8uboJudceTAmj4oEGAUcSNs9tNCDsA==
X-Received: by 2002:a17:90a:d904:b0:2d3:da94:171 with SMTP id 98e67ed59e1d1-2d86b8c3a42mr1724919a91.5.1725040964619;
        Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2d8445d5bb0sm6770604a91.1.2024.08.30.11.02.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:44 -0700 (PDT)
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
Subject: [PATCH v3 3/5] selftests/mseal: munmap across multiple vma ranges.
Date: Fri, 30 Aug 2024 18:02:35 +0000
Message-ID: <20240830180237.1220027-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830180237.1220027-1-jeffxu@chromium.org>
References: <20240830180237.1220027-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add a test to munmap across multiple vma ranges.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/mseal_test.c | 80 ++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 6d77dc9b5442..e855c8ccefc3 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -2147,6 +2147,81 @@ static void test_seal_discard_madvise_advice(void)
 	REPORT_TEST_PASS();
 }
 
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
@@ -2168,7 +2243,7 @@ int main(int argc, char **argv)
 	if (!get_vma_size_supported())
 		ksft_exit_skip("get_vma_size not supported\n");
 
-	ksft_set_plan(89);
+	ksft_set_plan(91);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -2279,5 +2354,8 @@ int main(int argc, char **argv)
 
 	test_seal_discard_madvise_advice();
 
+	test_munmap_free_multiple_ranges(false);
+	test_munmap_free_multiple_ranges(true);
+
 	ksft_finished();
 }
-- 
2.46.0.469.g59c65b2a67-goog


