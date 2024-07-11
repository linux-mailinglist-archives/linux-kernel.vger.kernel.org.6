Return-Path: <linux-kernel+bounces-249793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68592EFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D2C1C22FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564CA187562;
	Thu, 11 Jul 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fg5YMIR3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA217CA01
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720726793; cv=none; b=Gm02XDFjOAKhO2vKEbyVCH7J5wtmhDM9vBdOlKSn+8K+aCs4iPLnIQM5PxO3Yu2KMv5qbfrWwrQN4anglBBm/h2X7koxCXhE1LkGuVe9fc3oMTSmU1z83roz3w9rptOCY8unEZz/E4WYluEvoPlYv42Boy22oxpau3xu2olBnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720726793; c=relaxed/simple;
	bh=6c9enNd5xXF7GHrH/1e8o7hHuPbsJhlGShC4QQsotxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m4RSUBh1xQCAN/WQ1iR/zjh5+/EVc48BVC4+Ps74ht732pHgfgR0tthFBDslBnWGrY/ylUJEmPeBEOQqqe6dnjvOAn3OVBeDTXnONjwU2zarNJQ2jrHoVFkxXh3KQD+CK+lVfqAx+imn8NUJ/mV1ARUC8/5HgFAqr8AMTU9z8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fg5YMIR3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6513899bbdcso19067427b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720726791; x=1721331591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGX/U2MB6y0a+maZqAk3LokToAOteYrURf5ZQXwr7AQ=;
        b=Fg5YMIR3GvpHP4P6Lt0HMN9UZC3r7a5H0HJxlnaFY3V4fdXnehM/MrSyvTzermS98z
         /skwh3mZCEVMPk4+IU9fVmbD5uxxG5yLr1nndkxHf8ouRGgg973sSRIfOKwtOD/eAM20
         KLv8lCG0mXCzZ4bwinxqkfIhP84iUk69hCR3qHv6sdYFXEXyimPQnIKYM0uqdPfFcF1a
         xykB4i7LaQnti8aDzbBb7dE8jAU0j+2YZbfljlwVMrLF2XrJBIkLjhiOegYHkC3CG537
         AfZ9ly8pxMf1h7rLnZ693n5Mo3B+gqs0ahKM2Yg0FWvjxAbBsqRW6KumW00tACmIuZZn
         CP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720726791; x=1721331591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGX/U2MB6y0a+maZqAk3LokToAOteYrURf5ZQXwr7AQ=;
        b=bLD/P3eEPQ9Rom79h+fr5S/kP6vNjhJOBXSV1QmVGq1bdTYWS3OjAhH36DN3E6gHyw
         ii6/q023cVm5fkxd02YhL/QESstXLbISFXm4scKQHbvxaIOuL+a9RrPVbI8AL2Mb6ax+
         h0nDgnF19nAkh5sCUzP/vylLau3uXxfh9arfQPwvO3tvMJUy+knLQdeTUcHe49IoWabV
         DcwKMpllDq8Vmnc8KTlQ0p+KrACKGOYfELDrC50aCQfjNiVQhYKD8AbKVMiftf0YyrpA
         ueWz2oDIZG912pLKsZ1euTG+/+yK5JbK5qnEWIAElHYQckr/YjlKGEhqU5YKjuMfE0LP
         CL+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZaE++dAoejV7SgTCyAWQghjFQIlpRZ4gDioLLXqM+dP44tzx74jjrtsBqX7icqfwIYzvqu8eBmH09DTW8xvYH6v9Yt/fSvqI0P0xt
X-Gm-Message-State: AOJu0YzMAltGwCO2O2bIljQwyJ27mnx0T+vdh+OR3NlUOpKjJZONlAnY
	qFF7NzvyBxX+0WCR0HCW+wyLnA8WU9Wo5dSQZoYM0/g7qCzs8fZ+s1aJ1OxV4IRaf6dCUX8HcQI
	00E7YcbwYAy179j1ZKw==
X-Google-Smtp-Source: AGHT+IFQhBj+gG4iTlqi9n6jzYom//iTBl4rGE2Zd1V1Jd14gBb2JQb/Ng5vfq+MIw6tBclm4kGizOa0PjvJNpJl
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:722:b0:e02:8473:82c4 with SMTP
 id 3f1490d57ef6-e041b17715amr17667276.11.1720726791048; Thu, 11 Jul 2024
 12:39:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 19:39:45 +0000
In-Reply-To: <20240711193729.108720-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711193729.108720-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711193945.110170-1-ericchancf@google.com>
Subject: [PATCH v2 3/3] kunit: Introduce KUNIT_ASSERT_MEMEQ and
 KUNIT_ASSERT_MEMNEQ macros
From: Eric Chan <ericchancf@google.com>
To: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduces KUNIT_ASSERT_MEMEQ and KUNIT_ASSERT_MEMNEQ macros
to provide assert-type equivalents for memory comparison.
While KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ are available for
expectations, the addition of these new macros ensures that assertions
can also be used for memory comparisons, enhancing the consistency and
completeness of the kunit framework.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
 include/kunit/test.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 774c42721412..67ad0e026bbf 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1451,6 +1451,60 @@ do {									       \
 				   fmt,					       \
 				   ##__VA_ARGS__)
 
+/**
+ * KUNIT_ASSERT_MEMEQ() - Asserts that the first @size bytes of @left and @right are equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, !memcmp((@left), (@right), (@size))). See
+ * KUNIT_ASSERT_TRUE() for more information.
+ *
+ * Although this assertion works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This assertion is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_ASSERT_MEMEQ(test, left, right, size) \
+	KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_ASSERT_MEMEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_ASSERTION,				       \
+			    left, ==, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
+/**
+ * KUNIT_ASSERT_MEMNEQ() - Asserts that the first @size bytes of @left and @right are not equal.
+ * @test: The test context object.
+ * @left: An arbitrary expression that evaluates to the specified size.
+ * @right: An arbitrary expression that evaluates to the specified size.
+ * @size: Number of bytes compared.
+ *
+ * Sets an assertion that the values that @left and @right evaluate to are
+ * not equal. This is semantically equivalent to
+ * KUNIT_ASSERT_TRUE(@test, memcmp((@left), (@right), (@size))). See
+ * KUNIT_ASSERT_TRUE() for more information.
+ *
+ * Although this assertion works for any memory block, it is not recommended
+ * for comparing more structured data, such as structs. This assertion is
+ * recommended for comparing, for example, data arrays.
+ */
+#define KUNIT_ASSERT_MEMNEQ(test, left, right, size) \
+	KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, NULL)
+
+#define KUNIT_ASSERT_MEMNEQ_MSG(test, left, right, size, fmt, ...)	       \
+	KUNIT_MEM_ASSERTION(test,					       \
+			    KUNIT_ASSERTION,				       \
+			    left, !=, right,				       \
+			    size,					       \
+			    fmt,					       \
+			    ##__VA_ARGS__)
+
 /**
  * KUNIT_ASSERT_NULL() - Asserts that pointers @ptr is null.
  * @test: The test context object.
-- 
2.45.2.993.g49e7a77208-goog


