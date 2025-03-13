Return-Path: <linux-kernel+bounces-560262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806FA60136
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6D37AF1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6330E1F30DD;
	Thu, 13 Mar 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyEKrDub"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B81F2B88
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894044; cv=none; b=BkJWuScXONszewUNXmVGlf+yRT5TdYjOdya4G7hS85NVHLeplpRh5oaDeuVStmOYq5gB+ZkeKSNB7I7S75yc6g3ipmknSZAPH85rQVq9olQeTa2oQ7t+E1cAlnnzLZlag8zXB7mnUs+/kxvCUJAkPLDpkfX/tSeXbzj8zx4mU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894044; c=relaxed/simple;
	bh=ILIt1I4K0yqsx2yeqHM01aYQOroUH63iR+NR+X1/jzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C6BAyx88hHTRZhbLUq20zYcQur/MnzBCEzOcnRqdt8O9ShwJnJUIQbfFap3vbtDjzyIGABG7i7a6uDc3wUg7GhIMdPk/AF0G9uUVAv9++InhtDMlJIaaJoshfqR4st1SuifEWudmii2opUdFe/SfFsUizfZzZQvaD1YlRBl6YuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyEKrDub; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c53b4b0d69so308622185a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741894042; x=1742498842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Flzo3lVXN6Qb29UsmAIPXEQO4WxyqMDpwWQQUOakg/A=;
        b=GyEKrDubZNrDsnddwJG8wfLf7QgcpHD9SL1LfAkhYSSJG9DIPEfMpilre2G2u5k8gD
         aWEjT2+PAYdTQKHgqRqk6NHcOQT2PvcvmibLeI6xItGVIuflcrLakzGpjrBDryvAV+8H
         ytA8pTqM2vpPpMQ/rI+qsHdvcjlzvqSV0ATKn6MYsdDZiTtyPuy9GCf2u5Dz1/vcJACZ
         GwT5T16v/sIzSA1IziEXE4vhAOrFOnJdAkjmSw1xKBafoQp2M98piq/bs40GlhxAl0Cv
         fzVcFBJX9B2HQjVw9YtqGnmcbXeUNeTUufMmA6QxxnaaUy2wsjDGisurFucAwaYXIFf/
         0tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894042; x=1742498842;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Flzo3lVXN6Qb29UsmAIPXEQO4WxyqMDpwWQQUOakg/A=;
        b=MU0Y00f98yORCilhmTf9BHI28hHoVq9jN2UScpVgUpmZzHLofQ385pO9SiIL35fUsH
         lM0BqO6jN60MvUaQ/OuzehfMRkT5gReKr9gkQ+WDxlD1M0FGKbasP10LMePPSgR2kajW
         6JgKzDkvbCyXS9myNM0Co7LQ29BUf2dXNJgEwIKcti8vjwZqCaL+7sIbMHaCkoJsz9kL
         misyokORJQ+YLZnyyB+xkajYnI6fhgoQKOZxUKBQXpL5mzk/jXeAhgY52BeCxmxfpMD5
         MaPFFBf6bI0u/JayU/PmRzBi6OxP5yosZ7XA5w8zO2s03AkNXMVqdvpwO+GcjOij6IB7
         w4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWlcscjht4z4dV9KyV4r86cdICxJRiuaVRwPhBK3gFI6MgLCwbXvHFsacMlMnFSH4jFEDuW6wn16jvTAPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3FOredWqvj0wvl9ow2E6noDBpi6HURHUXu5MkOpcXiJsJAVE
	Lo/ZRKxh64uiqeuEYJqjNsuGV67/hiH4sJmcMvcCAGz3EM4N2tEGZTuGMF7CW1cY/Q7EDgepAg=
	=
X-Google-Smtp-Source: AGHT+IEhCEWKmQjlaJ2Hf9ADlQ1vji3WEjuildMcB96v9vZqW2qrPWk46XWEkANhfAWxGwXSXAbZlKWs4Q==
X-Received: from qkd1.prod.google.com ([2002:a05:620a:a001:b0:7c3:cc0d:22fb])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2713:b0:7c5:67ac:a826
 with SMTP id af79cd13be357-7c579fafb41mr102376685a.50.1741894042243; Thu, 13
 Mar 2025 12:27:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:27:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313192714.1380005-1-rmoar@google.com>
Subject: [PATCH v3 1/2] kunit: tool: Fix bug in parsing test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

A bug was identified where the KTAP below caused an infinite loop:

 TAP version 13
 ok 4 test_case
 1..4

The infinite loop was caused by the parser not parsing a test plan
if following a test result line.

Fix this bug by parsing test plan line to avoid the infinite loop.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v2:
- None, adds test in second patch

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
2.49.0.rc1.451.g8f38331e32-goog


