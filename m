Return-Path: <linux-kernel+bounces-560263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D3A60126
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F717F2CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA01F3D49;
	Thu, 13 Mar 2025 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXN9Jwju"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8001F192E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894047; cv=none; b=Q21hchcudMDRGFw4qmgSX5r3MTov+KTkSBQHVCR5p2s4/BeZaja4EyQ+qMxqLcRHT6hCqBP9ikxYTSrYtAQjuC6R7853pmO/clX71gkrIN2b5OwGHb4Se32ZdccqJakaOke9B6UPxVvEDgg81Yr7qgt2RQzlS0jme/3x9Sz1J5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894047; c=relaxed/simple;
	bh=KrBlLCuENNqmAXVG7c3+/aqpGnMQ9/bc/NOxjGDGs0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiiOgsWSjTPZFz8BPEQynUjGPcsNeKo04uInJob0RAAoiXoh3tuy33VcS7LO24L5cR/q39GTXC8VEHkcIsBIDvzVQ5nooZxeObKlH4+i9g1hw2bNhb8OcgGZlje0S4Y8VyjVoidYYpR5On94vRfBwNsGP9H9TVfmK2M4ASQUwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXN9Jwju; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4768eed4649so27671521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741894044; x=1742498844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ3Mm17hODYwuzWnxvtURLhRnjoSjhRLoip0t8b11co=;
        b=rXN9Jwjubd6oyzjen+mmS9k4ogZ6tjRnMp+PIB1GrgklTIcowcerWR0XQwTt1YF1xU
         pntxHPA68VpL1qZI0zxoOqnWvQ6WjIjVX46wB6KiexmprVTFeP0He8EEJpHO5IxheN37
         1wAiLH94tI7szTbtqshesuf0PboiFBNR20egXOeuFozLFkujG8w7sfbiusvUnp02ttSX
         U9UyKz9ej0OP/zPiX5tsalzzr1kFEGJQ3AdItCb/0EEQiDisa5lQmCAQSLr8hcgyDdme
         Nx1RwObfwJNdgAIGGMm8gAPbRYOczSSCUivpu4gCtnyJhrM6hjh/i2zPAAE4H9FoTdGM
         DlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894044; x=1742498844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ3Mm17hODYwuzWnxvtURLhRnjoSjhRLoip0t8b11co=;
        b=wTNAOXvm88HmAgGUqRWxyCdbSfRGjNQUFiaeiRYXQSpWS6Kf7bsn8W7gs5bD6IdJ+c
         mYYMvdlkEsDoAXuYosa49ENCRUisrng24p1ii8zdNs4HyHwtG3oZfji8+TEddypO8X8O
         hKIkgl7MWYmjY3ie0F0ukI/fUiFE+41E+nwOfcjvJY4azZDayHxYVO+U+ghPuYv8D8Uv
         2eYGdeuGEA9IDH8K5zB1zL+TnJ+UGK9PBK1a1MUe1nVbsqxVwCV+dxPbrJ9TXTvYBk8r
         dbtwxCkax6aJGU0fK9ptoJBu2bcHgmCom3WwZfuzyfpvcuo7ipqZFK0kWoDMHWJ2oQYH
         w/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUn7fxn+Qk2/0gDIDWNOUOfs8eMpXAoWNi/m0+oimMSGyJfFHuAc6BratfZVA8ieeKwKHMG0ZTMrdG14lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25IWNacBgx/G0tUGAS+iRi7mFnaNSKUdrQDi5lC/QCspqeIK3
	OlZBh30bzmk8iGm+q96eDkMo/CyQKPjVBBlqs202PSv92Fi+do0G3nEODVziSWxouzeEsZKnow=
	=
X-Google-Smtp-Source: AGHT+IHUUkUlx830CBpJPHMfzFNdP1ycZ9vkfSY6GnZkeGYCtQvF2FUhUcJ6pbIDO6vFgtx9ZVgMs/nRng==
X-Received: from qtbhj5.prod.google.com ([2002:a05:622a:6205:b0:476:7266:9db9])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:1a1e:b0:474:f5fb:b11a
 with SMTP id d75a77b69052e-476ba8b317bmr46779441cf.3.1741894044398; Thu, 13
 Mar 2025 12:27:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 19:27:14 +0000
In-Reply-To: <20250313192714.1380005-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313192714.1380005-1-rmoar@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250313192714.1380005-2-rmoar@google.com>
Subject: [PATCH v3 2/2] kunit: tool: add test to check parsing late test plan
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com
Cc: jackmanb@google.com, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add test to check for the infinite loop caused by the inability
to parse a late test plan.

The test parses the following output:
 TAP version 13
 ok 4 test4
 1..4

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v2:
- Adds this patch to add a test for this behavior

 tools/testing/kunit/kunit_tool_test.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0bcb0cc002f8..5ff4f6ffd873 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -363,6 +363,17 @@ class KUnitParserTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('  Indented more.'))
 		self.noPrintCallContains('not ok 1 test1')
 
+	def test_parse_late_test_plan(self):
+		output = """
+		TAP version 13
+		ok 4 test4
+		1..4
+		"""
+		result = kunit_parser.parse_run_tests(output.splitlines(), stdout)
+		# Missing test results after test plan should alert a suspected test crash.
+		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, crashed=1, errors=1))
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


