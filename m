Return-Path: <linux-kernel+bounces-269292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE2594311C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD3A1C21EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AC1B1512;
	Wed, 31 Jul 2024 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TIlPfpTF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74B1AD9CB;
	Wed, 31 Jul 2024 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433211; cv=none; b=CJyNeNKJPZJ77upFKcZVU2cLRuoGoc7vw8CAofPqQARwzrxxoMWnoyCp/5QIlyDVNtmgnE1Fm8d+EXfRq3o1GErKfBwYo04ib4vDAahUMFbPJGfWnhrE5NTy1ySNLgXWf3Ky055oYhsyfjEqH2K6MxnovS48bXtM1P3+8CHmvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433211; c=relaxed/simple;
	bh=O6sVVzhYCQWQlIFwSeEGKl6TwZcesvyoa0yY5vdvTag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bKj7bY+785xMg1cu/G1vdsM5554BTGX9orjwL7Px7a4HbJRrzlvB5gZG8BrItySxpNNQ7luw/jWuPBPvDjAcaqc5fP0xec8wG0u/ARpmvC4d4SY5JxZ/mfvm1bc8PyXvgKe+y8z0D8IfxCiETiPsVPfDjrtqIvYuCOHz+9T9huQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TIlPfpTF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722433207;
	bh=O6sVVzhYCQWQlIFwSeEGKl6TwZcesvyoa0yY5vdvTag=;
	h=From:To:Cc:Subject:Date:From;
	b=TIlPfpTFcfhXyApE7Dq1PcwEZjlqGIWxBZ2wVEhtuKWP8yMhwBpWLa9Krhp/Q0OOb
	 G116R6ebNDfcuthKr5ooAkglD8SgSpCGxV1RDJXwYYKG6BR6E+QqonC/W0aqVxHbqB
	 jATIMNXzw3pLB1dMtX+iVKU6fpEGmZVj8KxeADJD1jWkUD6dCN/TiqnCLTSMMX6WsF
	 IlTpnEREQvqHcyA/L+iUn928WRNdciWkGabH67V+ry7BEbfrrUP8CS/16kvebPVQgN
	 UvwbDBr8dOrdUmyPWKl7bO3ihS3BfCohGp8JnNPUCxEh2GXUAeyqHPUFtC1GuNYpia
	 Um6WySAQUmAXw==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6497E37800DE;
	Wed, 31 Jul 2024 13:40:04 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: openat2: don't print total number of tests and then skip
Date: Wed, 31 Jul 2024 18:39:49 +0500
Message-Id: <20240731133951.404933-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't print that 88 sub-tests are going to be executed, but then skip.
This is against TAP compliance. Instead check pre-requisites first
before printing total number of tests.

Old non-tap compliant output:
  TAP version 13
  1..88
  ok 2 # SKIP all tests require euid == 0
  # Planned tests != run tests (88 != 1)
  # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

New and correct output:
  TAP version 13
  1..0 # SKIP all tests require euid == 0

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Remove simplifying if condition lines
- Update the patch message
---
 tools/testing/selftests/openat2/resolve_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index bbafad440893c..85a4c64ee950d 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -508,12 +508,13 @@ void test_openat2_opath_tests(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(NUM_TESTS);
 
 	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
 	if (geteuid() != 0)
 		ksft_exit_skip("all tests require euid == 0\n");
 
+	ksft_set_plan(NUM_TESTS);
+
 	test_openat2_opath_tests();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-- 
2.39.2


