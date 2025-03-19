Return-Path: <linux-kernel+bounces-568921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD040A69C19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962DE3BB845
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6418A21A453;
	Wed, 19 Mar 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klPZ2fpW"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D822204C3A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423638; cv=none; b=gNmLsaZw4y7uiYgr2oNQOOSbAKO0VJSvOwtF3BG+UDXTtpIriUjnjWPapCmqUTHTlmwJ82OMo2Buch5oXuBH6fhVAoNpW/LxjQGWRjTEFgLrjhsvSE3bFcQ3bM+yHwSYmFGQ8XcGj+E2AqLCcdi2JkuJmgApUXhqye3nrjgwEI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423638; c=relaxed/simple;
	bh=mAw0ZqLyiCoZH8VesbHgz3Uo62i3I75t/54lqWtHLbI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JROIIXe2Czyhc9bd/OW17ESorEAtyfwaNw/h5/byqF0K8M2jACOXkkYfxmuJjs1nzGaBnY7bLlp4efgGA9Tmuh/O/2Qf+GnKs8dnVZfHkhG8piAdUBeVQpusVVHrXKb3BHFOXas6/ikRejphTyubS4OhdXZP9RMltXFcl5vBiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klPZ2fpW; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c54e9f6e00so230529685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742423636; x=1743028436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4C+KM7i+5msFmhxzSya6NuHf1KqUp3SPPWG0X4qbCm4=;
        b=klPZ2fpWIThmuIg6fPnpK3HBw2Bde2ventAr1ty3vctNpCkZ+vzDD2BwZ3lDyIppBf
         M7i8bgLWFq1q2VHwhKbdvatSefewcNuwSCU+dPIgSXIrHTI3T/duhl6YF3FYVJAR9Dzc
         vpgWB2wicQQ7Ay22bdjHJ17qLZK7kZ3NTGohwqEBghQfQ36eoPTX8Z2zuTNRmWuFOvCQ
         xEC6EMVCYNG5zCR42E8uYejeUgv1Mjrxltm7uAkC5vx3C0oyzB41mgXb30GfpSmuZvq3
         EfNrd/fL1IPFUIadM7Z6evx9nSBYs/nsIBxcjj5pHcz6nBKcQ3P0j80nHWzF2WQvOfKS
         W8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742423636; x=1743028436;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4C+KM7i+5msFmhxzSya6NuHf1KqUp3SPPWG0X4qbCm4=;
        b=P54IV2ICM4dLRH4os/rfe2/dSWoLu5vj2lTpCFcOefa7cnjfuvAF7Zb84Ou0CZ4UQM
         wxkxNBmQbxtrHyrKgb2NeQhiuqMUVmDJisCbzXm+Eja3AQO36E1NCMxil4dcRl7xBR4z
         ihrqe/T15akUXm0QPJBP/n2FVkHNO8jtH0+bdQgGSAILIb7ZRwivT78QVWQQKLVjQKe8
         UKTKTleN1TQXzdOJHut6/YCGOruuN1BMAqFAUjwXJmBlP2dWcl6SQSDn4y6XW8/Od2Qc
         lwWtceFQ71BJXC2cXzw9RICaEtxonQSZtbVZQgd84S/L4g7x2HqB6x7+imRU9JIa0i8l
         ThXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7RQ8a79Of9SNcqmhUOouJ0EiSVU4xo20K90hz/To3lEjOjQYv2A+nzO9cSsdYW3N09ngI3M0t2ZYkozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOWPkGVB9+DX++bV7HH6N4kr/8qLYYQZf8wAi8Gjel7jWxPGO
	WuD9EKtvrunxj6FkkIG6uDbgFRv6Ng6jsDw5nlX8P6wUBeX+AjjIsPjHTeqMazvhWJ8o8X0Kqw=
	=
X-Google-Smtp-Source: AGHT+IGgY6Pywck8gcnGUljLZeNyCEzuS5WpPE6KmbgsB+SQUpG+8SqJTA5d2qQJratKJKjIajld0MC0dw==
X-Received: from qknrv15.prod.google.com ([2002:a05:620a:688f:b0:7c5:496d:d669])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:318b:b0:7c5:a20f:a091
 with SMTP id af79cd13be357-7c5b04e1f5fmr202494385a.2.1742423636221; Wed, 19
 Mar 2025 15:33:56 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250319223351.1517262-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: fix count of tests if late test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix test count with late test plan.

For example,
  TAP version 13
  ok 1 test1
  1..4

Returns a count of 1 passed, 1 crashed (because it expects tests after
the test plan): returning the total count of 2 tests

Change this to be 1 passed, 1 error: total count of 1 test

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 4 ++++
 tools/testing/kunit/kunit_tool_test.py | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index da53a709773a..c176487356e6 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -809,6 +809,10 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		test.log.extend(parse_diagnostic(lines))
 		if test.name != "" and not peek_test_name_match(lines, test):
 			test.add_error(printer, 'missing subtest result line!')
+		elif not lines:
+			print_log(test.log, printer)
+			test.status = TestStatus.NO_TESTS
+			test.add_error(printer, 'No more test results!')
 		else:
 			parse_test_result(lines, test, expected_num, printer)
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 5ff4f6ffd873..bbba921e0eac 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -371,8 +371,8 @@ class KUnitParserTest(unittest.TestCase):
 		"""
 		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
 		# Missing test results after test plan should alert a suspected test crash.
-		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
-		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, crashed=1, errors=1))
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=2))
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))

base-commit: 2e0cf2b32f72b20b0db5cc665cd8465d0f257278
-- 
2.49.0.395.g12beb8f557-goog


