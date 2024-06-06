Return-Path: <linux-kernel+bounces-205002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352508FF606
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB04284031
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A912BE9F;
	Thu,  6 Jun 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="DPOwXyro"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6532C433C7;
	Thu,  6 Jun 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706193; cv=none; b=soDXqGBU9oI/4x9AY6cZdgljsESQVNITV1M+fCdn3QSQTBVQBeMem0VAOyVj1lrsPja+TVKaH0zkdltwsWUVAc9LF0DUJugVjVR9QVYyitg+wsLLCjnd0juzcp0z+sEGUdutJJaKqso+nKVodjUFEU78FY45cSEPOnxxPyLjmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706193; c=relaxed/simple;
	bh=wv17HOjMBsFVk+1c3l5xnw9XCjLK/kFYi9+LOAIk0j4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iIFjhWaNpwOQScTa2xSJnc4yfEogYSImdJIGTV/py1ARomInKAmqY2NWUBI2O2WS1XtZXMCQyO8N7TfX2mY4qDnziikZyaaSPxgzR7cSBhpnnEQs2biQ9yxFkOFY8k0JedrE1LyB/MlsGPnYwDzdNuS0pGIXy4pykcPlTXCk3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=DPOwXyro; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4VwGMH2CFQz9sjN;
	Thu,  6 Jun 2024 22:36:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717706187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7a+uTIuCVLKYioOfhmkji191JEJPYvDHdI+sYE/KQAM=;
	b=DPOwXyroOSaHbfjxX7deUekLF6Zh1Ir8FYzpm9YpSPot17FnGaMKsoTafpvY27N7a/qvSs
	wOD0MQVSMa0LjQbUScliFnlifr0D3jWjt3AqGS6ArslukjbRW0Or7rYVVBaAXcUugjJkSu
	x9+Egx1ck+zrr9c/fN6F1qPfVXrbuCnEOpFU0HPQestAtQ5J40zL3rxrDInZE+fQVJzVpE
	Qm+JKPRB1RPN1JlntC4UdN2af60m82v9D0RGS1UHEGbf/28movd4xZq+QBQp3aNu25MgNV
	whcnr2OwSQRMbZi8xUF9Mvo/xsWGsFzovbyeb7/Fkuw8kN4X7wdSLYtbXTSfAg==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org,
	gost.dev@samsung.com,
	David Hildenbrand <david@redhat.com>,
	willy@infradead.org,
	mcgrof@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <zi.yan@sent.com>,
	kernel@pankajraghav.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3] selftests/mm: use asm volatile to not optimize mmap read variable
Date: Thu,  6 Jun 2024 20:36:19 +0000
Message-ID: <20240606203619.677276-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

create_pagecache_thp_and_fd() in split_huge_page_test.c used the
variable dummy to perform mmap read.

However, this test was skipped even on XFS which has large folio
support. The issue was compiler (gcc 13.2.0) was optimizing out the
dummy variable, therefore, not creating huge page in the page cache.

Use asm volatile() trick to force the compiler not to optimize out
the loop where we read from the mmaped addr. This is similar to what is
being done in other tests (cow.c, etc)

As the variable is now used in the asm statement, remove the unused
attribute.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v2:
- Use the asm volatile trick to force the compiler to not optimize the
  read into dummy variable. (David)

 tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d3c7f5fb3e7b..e5e8dafc9d94 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 		char **addr)
 {
 	size_t i;
-	int __attribute__((unused)) dummy = 0;
+	int dummy = 0;
 
 	srand(time(NULL));
 
@@ -341,6 +341,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 
 	for (size_t i = 0; i < fd_size; i++)
 		dummy += *(*addr + i);
+	asm volatile("" : "+r" (dummy));
 
 	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
 		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");

base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
-- 
2.44.1


