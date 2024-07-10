Return-Path: <linux-kernel+bounces-247998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F892D72B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E4891C20F43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB60196C6C;
	Wed, 10 Jul 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pe4Ux1HZ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A3194C6A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631227; cv=none; b=rNBlMG3IrVVZAhqonl7gxwRx3nq0XZ9/Q+tu7K2aqQXiQ79mSwEi37mdr+kaHPZ/2blNVSwm9w/EFZ5GXPA5JSZxRcXN7ovqeEkc6aKPPc/ImEhur6YW+C+pNHfKaTMHG/+7+gADqlti+w9MvwitCf4erIFGaajySkSMHjSbR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631227; c=relaxed/simple;
	bh=i5uDpxJn8lGXZBfDUqgPSGzmiwpXROrGnB6v1/kDFNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cztc3ug+otj2Hd2zr7yyXtw7IxenVkW3XUgM7iHo1SWSEqRF79E3MZ9lO1FJdW0piZJTlGzs/Dd5Wv5ANBbI6t2wWIyC8T4WpsvwwtyAavQPrCHMeAdI/0Y89UWwySUoAWQhPXAFN+u2eHyFiYgHP4qqctCwyUDUr4sRLMMA3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pe4Ux1HZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65026e6285eso106999867b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631225; x=1721236025; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rdXM5tSTVLgVD6pOaOrVugKKH4Crf9pI4FNGQGLq9Pw=;
        b=pe4Ux1HZBQKM9wRYlkAlqdgeBXGgDTYdGez68NrR/dLcPmDA253Qb1juYj7wrXVIsd
         xymBVjO5Si1YGXLyDfYCbTzKnZUcK166TOnXze9WUO5SZ6EWi7v6WZ9gGkVM+UzQStD4
         C0lzCblSgdGJnzglwKFoPRY2uVRbs/Ocg0FS5lB0pjWoJodszoC8/P1AtRQLxVsbKIa6
         gOStv+b9m813ESurN7FpjGrVAYQGMOqyfkK+PITmAltG7MTYhKy0I1ymt4fTIeJLpYn5
         C3KJtrvGd79mg90hlP2DsHUPSUgsiWkXgFDwECt72IupH5j+W8HHKJ8KZQqc/tMXfubV
         3uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631225; x=1721236025;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdXM5tSTVLgVD6pOaOrVugKKH4Crf9pI4FNGQGLq9Pw=;
        b=uRbr2N8oN8oXBx7mC49vGmKKJXBoMPd1wMvyUMsE5Sv2q9tmvbHcLRo7+7AS1UXN6S
         HrzJ1sfqjnWSbx1IJI96b1p8+RHy69EQAjr6zytTxmt6gvht6/XReddT7bWCeXvswENz
         5D4ELAj04VYiFJk560bIR5oaDkPQ9BfYPX0+NasSQ07Jt59ij6tEk1yVN4XoCwpIv+TT
         d4g/RWbUY+SO9cisNIxCfZ+/6pjKdYheGZe61F/etptnFr7G2tXjIG4skwnKoEpyToM+
         6LavQP3vzw41hTQOztHOlAT0wtZyTZVtIzvLvVVK8EawvBptR6sd8CUkyuBz+tZCXhn7
         tYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKg4DbxSBRnJdovj0Y5mcks+NSZEUQZGdyScrax8fy8CL0r03Dciw0ZpE+xX+0KlAMee5g8bbXLp19IFYCfOlXBLnnrMjhsOwkXjlJ
X-Gm-Message-State: AOJu0YzD60syNZZuuZ2OV4uwMxtEh7ZyYQ0MaKpXZI0h8b4zJy+JxAgr
	eXPHQuM3M0eXlfS8q+mlHSTnftGnVx/Fzs1UjOoNfDuokSCqoUhAtjqPDI/ZtZtOX0K47xD2QHU
	KM2MM08XhJuMhXiWLcw==
X-Google-Smtp-Source: AGHT+IGgxHOkY64Jyi/bUvq82+S3Z45vzDAUlZ7FDf3Cmd4kyTEHEwajQRskDY6gPPrkHYUSfcHrOOeL6zQ8nFfq
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:3cfa:1aa9 with
 SMTP id 3f1490d57ef6-e041b1134afmr14166276.8.1720631225297; Wed, 10 Jul 2024
 10:07:05 -0700 (PDT)
Date: Wed, 10 Jul 2024 17:06:59 +0000
In-Reply-To: <20240710170448.1399967-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710170448.1399967-1-ericchancf@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710170659.1402746-1-ericchancf@google.com>
Subject: [PATCH 3/3] kunit: Introduce KUNIT_ASSERT_MEMEQ and
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
index d1b085fd5dc3..52bd50d2b150 100644
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
2.45.2.803.g4e1b14247a-goog

