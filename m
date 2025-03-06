Return-Path: <linux-kernel+bounces-549637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E52A554DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9F13B77E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58C272932;
	Thu,  6 Mar 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvxewfJZ"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E8272931
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285217; cv=none; b=ZoiH3H+VTQSNBOZ2zYLUW69aihCvY8SRddM8OwLc7ftBb6Eg34N9WySFJkTV6ztBpeEM/gH00+LvlmFVUdf06ptfybWEIKgUSXzSRP/bF72jvQqt78tfW4uqHC76sEt5MmXtQSbjEM6OWAEiGFqbKjXM3cczG1CBI31kY+Fn+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285217; c=relaxed/simple;
	bh=4VuzvYvLcN6dJPQ8n675nSqrtosRx5EBY2qJGYXH/ro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Rfr8K5Ad+xw6k6mQJ5Az329bUhd9VFzNBiBHbo2hYkdjXck3wLQyYtkd1Y4lml1czVKwsRPUPcyDa0bGJUB9oDq2ByJLlXkmbrwiwvHcDxFfghp/YhD2/t88w0d5rEOKIJ9I46BA4C70qPozPZuGKXTX/JTHbk081vk8d321+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvxewfJZ; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-474f98ba7e4so31398501cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741285215; x=1741890015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOXNDTF2vrh5uDiXj9TnU3A+yLNXaCYv0mbF7Mtjths=;
        b=dvxewfJZslxNOdhnlRUtPhvXrlJ0Oivq0SPYtWUmxRIUQdhJTKTdW14+sVEn1OoWB4
         s4BVjci44rGlIm31woq+MBsuh+7sTsGvSKI/myE608Gdkri6A4YU+OPUoRSynzsH637z
         8TTAR6ZwA/aYW4clpGJPtjjRECxTFKQgtJKwIBsuBdSifHauD1qjWo8VrlClRZM1RfU/
         +36D1GNu8ESsyun1rzjqqyqUTK2YBn7BczCzsR0MGboK72mg9LIXyExD7FFAsPmJRhRN
         V94+VHb82Z2zEod6KStLxOPeg3hS1kKct86gTb67YEeRYittW59h/akvA0L3jPgZWRYl
         KVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741285215; x=1741890015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOXNDTF2vrh5uDiXj9TnU3A+yLNXaCYv0mbF7Mtjths=;
        b=hjP31wuzb2DIEcYPHpQNgOC3tLR1od+fqxeJsqDPHJiqvIxFTEEbJTUevtW2iE+3ZY
         ju24Hz1cjxJrLJF6LdzDpVw16rMNyWLc24RnX9VBNyGQedugJ8yowDqkng3TqsQNsvrH
         M5Cfz0Xa/j+vDvK2zodwoapfG3RbR+EcBSmyNjD7dKPCJRvTY+VXWs3GW27tonbPLirS
         Hxfr3aNLNMIaiomGtPr+XCs4fw0bBYWF87GHCWUSzmzNd8y2R4LnXtYMmmgFYFF2quZ3
         tb3x1qTRMQ0gxO/soDyxOKhxFWlMRbD/ey9czfLQ3vaavzv65TJ7RnbuOvoYGZJM8ajB
         VOeA==
X-Forwarded-Encrypted: i=1; AJvYcCXxGQ2cJKfv8Y/2obxaTdkP63E8VEpgF6y8nV7+zNzi1VhDCbbtD+svlVl9rjMg9C8Dt4w2QdGGRhNc97w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QqmRncOceOQuiDngjt4kqySIjrhXitLojee17WJdq8e2PqAM
	zqvu3CLti0m4eU8cAB/wLX0L051S0AJIL+tRc4ZBCCDGaGG5utRWw+zxbAvlWoxy7gxX9Iyw2A=
	=
X-Google-Smtp-Source: AGHT+IGgevzdqxTVQQgC72vwzEi5eRcrXB5iZhhzO5dAs3E7uSwYJSqTNfeHkjj5cciErEZHjXxSo/dUtA==
X-Received: from qtcw41.prod.google.com ([2002:a05:622a:1929:b0:475:580:4020])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:134a:b0:472:2021:b786
 with SMTP id d75a77b69052e-47611959d6emr657611cf.35.1741285214860; Thu, 06
 Mar 2025 10:20:14 -0800 (PST)
Date: Thu,  6 Mar 2025 18:20:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250306182009.2255241-1-rmoar@google.com>
Subject: [PATCH v2] kunit: tool: Fix bug in parsing test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, jackmanb@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

A bug was identified where the KTAP below caused an infinite loop:

 TAP version 13
 ok 4 test_case
 1..4

The infinite loop was caused by the parser not parsing a test plan
if following a test result line.

Fix this bug to correctly parse test plan line.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v1:
- Remove error reported when test plan is missing.

 tools/testing/kunit/kunit_parser.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 29fc27e8949b..da53a709773a 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -759,7 +759,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
 		test.name = "main"
-		ktap_line = parse_ktap_header(lines, test, printer)
+		parse_ktap_header(lines, test, printer)
 		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
@@ -768,13 +768,12 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# the KTAP version line and/or subtest header line
 		ktap_line = parse_ktap_header(lines, test, printer)
 		subtest_line = parse_test_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
+		parse_test_plan(lines, test)
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
-			# If KTAP version line and/or subtest header is found, attempt
-			# to parse test plan and print test header
-			test.log.extend(parse_diagnostic(lines))
-			parse_test_plan(lines, test)
 			print_test_header(test, printer)
+
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1

base-commit: 0619a4868fc1b32b07fb9ed6c69adc5e5cf4e4b2
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


