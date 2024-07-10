Return-Path: <linux-kernel+bounces-247997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1393C92D728
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F0C28184F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F99195F2D;
	Wed, 10 Jul 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1Kg3oww"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DF195B33
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631211; cv=none; b=psDz4MUKB9tcxgYymq+1FpJWgY2LFjtsJePXCLx1nX9e/4/nlN33jjg6rY8aHfdNnUs/ISqE0hi1SOMgWOUCCCfZ1W+jTKRv+w5zVEJLKdYEPfe2AQmeR653RE13Ez3wk92+ajmC//bJOCrf7q5LRLfG+Ii4Iy8+SjnhIybP198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631211; c=relaxed/simple;
	bh=55IgR9SW1v2kkYXqH0kYD4+uvDouI7DdE0FHu/jM0R0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oJaB2mVsZArEXKz2YYEDGb60hcMYivcOoWXzoU9Ib9tiMrYGEGH1/qZ9goEB8lVgNjvoFP72NHTx45yYq9PMHOlztz3xj/MRSKdWf6m0LdGkB7K1mEtpjlwMqvl6neK307DHY62B78cYf8VQQVRs/QoRp0yRjkVAXTW00MvEU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1Kg3oww; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e039fe0346eso11658344276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631209; x=1721236009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HEsXihW5jwk6/3bgpeafAIIwL8vXDyFBDI7gKiAkO+8=;
        b=B1Kg3owwOJCFLyekFvKzfMGY0w4B0je/8/WbpfO5FBfAQOKPaga5/MtWoTbzYyH00/
         bvQYSFYlDUrYtdna0vEYQB3rraVBlV8kPxp1i0Gwmh5ThKb5afdu795zvITSCU+mTD+p
         GLBBPg49AWnq7QNXMuJdqT0JmZ/I92Ml6Xyw0mhXetrxNDZf4Jyo6nwi7cA1kDfJciDT
         YSX3vnAJ1dBI05sx7Hvah+ZtIpMg4WU0HwaSKn93viCEwsJe8wdN8IlWTIgn3ocKO7e5
         CmP4YcJDXW+s5ZGDVuS6+OphI2lzzK086LRGFWWNJdxuJ2YckFvg5Qx0sv3nBlhCgJ8G
         zobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631209; x=1721236009;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEsXihW5jwk6/3bgpeafAIIwL8vXDyFBDI7gKiAkO+8=;
        b=vCcFOdWTNqhVUG5e5cQYWoSZ/jzPSvMyqwZoBH3gVHABd4BT/TXPy0OJv4J5ls8DtO
         RVGE0i67mNp+XlrvKHSfoapav9B1WnKLZWL3AMHN+ptqyrTDIt2aWE1n1LQZYB6OuKdl
         8MedN25DOow//d2pgDBJ1LoP1iU/NUVKmLXFNZYtQnehtWQLKpfCwGGcNUtJ7PkBnTBx
         LiUhLEKldXx/nCwa/j1uDQ8dQ1/+rrxWSryFtAXrHhFI5CtN3nBncKftUKD0tCkFo5wb
         vZ9zUPLjG9dciEdyWz46HUj/zEEVrficJyUHruyIS9JeydPhuU1IFkOhkI5gI95Ij11V
         nqpA==
X-Forwarded-Encrypted: i=1; AJvYcCXI48q2ZZt7m8aVsDr1sPcPaXDF3copTvqoZU0gLvx9vMkKc6R4ZQlwenEMscXk4sN3HwzBDDwI9igj66UxszT0LT5Fruqtfx83csqJ
X-Gm-Message-State: AOJu0Yy+wpwDS6cHvm7Z4fQIh88h/TGOGCbHb6MZyVFwkLQfUTbjfHKe
	9C3tStxWvRjcQLNXjc8I5hq/0+zZfAzf/Y0mpjMV5lNJDYRg4ItnrnN88/RJ0pUmghvr+HEZPax
	iyttpNtbiBq7HQIGRJw==
X-Google-Smtp-Source: AGHT+IEq/wR5+VeC8A5+fxYk+p1J3dHwGgRcpRCuVIqTPzMyO+vneMFxBdM5MYtCfrduY0GmcBLkw8kc8I7DT8vj
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:138d:b0:e02:c84e:61a3 with
 SMTP id 3f1490d57ef6-e041b05317bmr12250276.6.1720631209022; Wed, 10 Jul 2024
 10:06:49 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:06:43 +0000
In-Reply-To: <20240710170448.1399967-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710170643.1401358-1-ericchancf@google.com>
Subject: [PATCH 2/3] kunit: Rename KUNIT_ASSERT_FAILURE to KUNIT_ASSERT for readability
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Both KUNIT_FAIL and KUNIT_ASSERT_FAILURE defined to KUNIT_FAIL_ASSERTION
with different tpye of kunit_assert_type. The current naming of
KUNIT_ASSERT_FAILURE and KUNIT_FAIL_ASSERTION is confusing due to their
similarities. To improve readability and symmetry, renames
KUNIT_ASSERT_FAILURE to KUNIT_ASSERT. Makes the naming consistent,
with KUNIT_FAIL and KUNIT_ASSERT being symmetrical.
Additionally, an explanation for KUNIT_ASSERT has been added to clarify
its usage.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 drivers/input/tests/input_test.c |  2 +-
 include/kunit/assert.h           |  2 +-
 include/kunit/test.h             | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tests/input_test.c b/drivers/input/tests/input_test.c
index 2fa5b725ae0a..cbab24a265fa 100644
--- a/drivers/input/tests/input_test.c
+++ b/drivers/input/tests/input_test.c
@@ -31,7 +31,7 @@ static int input_test_init(struct kunit *test)
 	ret = input_register_device(input_dev);
 	if (ret) {
 		input_free_device(input_dev);
-		KUNIT_ASSERT_FAILURE(test, "Register device failed: %d", ret);
+		KUNIT_ASSERT(test, "Register device failed: %d", ret);
 	}
 
 	test->priv = input_dev;
diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index 24c2b9fa61e8..02c6f7bb1d26 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -60,7 +60,7 @@ void kunit_assert_prologue(const struct kunit_loc *loc,
  * struct kunit_fail_assert - Represents a plain fail expectation/assertion.
  * @assert: The parent of this type.
  *
- * Represents a simple KUNIT_FAIL/KUNIT_ASSERT_FAILURE that always fails.
+ * Represents a simple KUNIT_FAIL/KUNIT_ASSERT that always fails.
  */
 struct kunit_fail_assert {
 	struct kunit_assert assert;
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87a232421089..d1b085fd5dc3 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1193,7 +1193,18 @@ do {									       \
 						fmt,			       \
 						##__VA_ARGS__)
 
-#define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
+/**
+ * KUNIT_ASSERT() - Always causes a test to assert when evaluated.
+ * @test: The test context object.
+ * @fmt: an informational message to be printed when the assertion is made.
+ * @...: string format arguments.
+ *
+ * The opposite of KUNIT_SUCCEED(), it is an assertion that always fails. In
+ * other words, it always results in a failed assertion, and consequently
+ * always causes the test case to assert when evaluated. See KUNIT_ASSERT_TRUE()
+ * for more information.
+ */
+#define KUNIT_ASSERT(test, fmt, ...) \
 	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
 
 /**
-- 
2.45.2.803.g4e1b14247a-goog


