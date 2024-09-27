Return-Path: <linux-kernel+bounces-341900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5C988809
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9CBB22A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2FD1C1722;
	Fri, 27 Sep 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqwgumhK"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A561465A9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450037; cv=none; b=qDm8JA7vfBCBApFJNcTeQBvaMCNX1GkXe4Gx3q9hxvPwrTwymaQs+H5TU95UFXzJhQ+bA5pGOIMt3PuT0uB6YZvcyuuGAJQIyuD0dn/0Kxws1r8kpt+zNGL1QVGY3mDqul6hakQ7FziynfJYB/i6lQC8wrZiu0bFiZ5pHgsp2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450037; c=relaxed/simple;
	bh=E53WrYsITHBm778nj0fWz5wmQCR5VYGcnozS/8Dc5+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=judCuW15eAt65W8vYpjQHP9IqvYskyc68u5EFVavdGVEK9jaiYeohMoaX+2EhfjL939tW4UlwZP5xQGiIX4/3tRxDXptvUMrAxAoV8q3pfPwyLVhOe/tF0zatP6tvdGABTbM90T3xbuBAho11H/RraCguH+yvYzx0QfRS48jOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqwgumhK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398b589032so355203e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727450033; x=1728054833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C2yd0eA80h4rdtqxp/kh9iCrWOEyI0g4hsGihttS/Wc=;
        b=SqwgumhKov/2gtjTW8vId/udVyQS9txzw5msF+S/zL0VnA3eDDM7Ji8eweNbOBd0N3
         sLhnIXdurt45Uy61Nz4zhqog1kWSNW7+Ws93oYoSuAb1R9LtyCnu6zlDdTCKrfKDMlxO
         6/pjOecMNROwG+J8iHPp5WLpBJjOaIRvXYPn+GfDDNCISUHeegqKpeoWK++xKKt7fRVp
         3XCdYeUEapT8AduVofks5tvctcXpFPrLdQTpwdkc940huWL1sMAamb4tnINXA9Uoul1I
         iE22Iy0SojPL1KIPDbGBy1XwdYmrZJB7Az0qB3je9ZbL7YZuBzezo7NQRCGEcIJ1XKW8
         8zgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727450033; x=1728054833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2yd0eA80h4rdtqxp/kh9iCrWOEyI0g4hsGihttS/Wc=;
        b=cHSzHKc1iDe40R+p2s/+JZ66WPDyhJgjKHl/UFuZRGAwTOJyxwRnc3aNnmu10OBliF
         puY8aPXsvbDYI3nlEzSpEIod+eefFKcySq6etLYWZKYGNRvG5anBElj8EXHkw6v91rhb
         fttCIWHncUpHJmCMNmOOwZE82YkI3FkrjcP8orFF5UwBx8/TeM0MtQe7zOrsnnHjvAzE
         Eo4ot8AFa694YC03gzt6BVwXwe7jCrzy+OJjLtyVCLbp0hQVIjwGe7EOJJBry5mw+OvI
         sVZbSTkAYyNL0aQjxvqRHoiTq/T8sUpr+/csY3N8zcYvSoyNv/h3LUGb0yI8CVRTK36M
         6Y0A==
X-Forwarded-Encrypted: i=1; AJvYcCXovPEnPy46uu+45zNkQnWK7831d44WYM5n+2awELC5JGpG290Rfs561YOVvZWdftKFm7oYvlh/Wqh6h2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpmp22l2rxDL4C3CBTz/5Bx5fs9+Gjyf7eBmi3MhRZf3HihFWR
	rdrVEMNlzz6r+V9hpbuUzER22rjfa61iZVQWA6KEY9egKnpGOlDFOpSPMOo3bTw=
X-Google-Smtp-Source: AGHT+IEjyfmt6pFAwEcM9NxXtldfiXXSEydABqji67UTTHosRYP72Gqr3CCMuHJxC/aC30wzCh2APA==
X-Received: by 2002:a05:6512:3343:b0:531:8f2f:8ae7 with SMTP id 2adb3069b0e04-5389fc46b2dmr3479365e87.25.1727450033114;
        Fri, 27 Sep 2024 08:13:53 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53979921f54sm268143e87.152.2024.09.27.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 08:13:52 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH] mm: instrument copy_from/to_kernel_nofault
Date: Fri, 27 Sep 2024 20:14:38 +0500
Message-Id: <20240927151438.2143936-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault()
with instrument_memcpy_before() for KASAN, KCSAN checks and
instrument_memcpy_after() for KMSAN.

Tested on x86_64 and arm64 with CONFIG_KASAN_SW_TAGS.
On arm64 with CONFIG_KASAN_HW_TAGS, kunit test currently fails.
Need more clarification on it - currently, disabled in kunit test.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/kasan_test.c | 31 +++++++++++++++++++++++++++++++
 mm/maccess.c          |  8 ++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 567d33b49..329d81518 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1944,6 +1944,36 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+{
+	char *ptr;
+	char buf[128];
+	size_t size = sizeof(buf);
+
+	/* Not detecting fails currently with HW_TAGS */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_KASAN_HW_TAGS);
+
+	ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
+
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS)) {
+		/* Check that the returned pointer is tagged. */
+		KUNIT_EXPECT_GE(test, (u8)get_tag(ptr), (u8)KASAN_TAG_MIN);
+		KUNIT_EXPECT_LT(test, (u8)get_tag(ptr), (u8)KASAN_TAG_KERNEL);
+	}
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_from_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_from_kernel_nofault(ptr, &buf[0], size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(ptr, &buf[0], size));
+	kfree(ptr);
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -2017,6 +2047,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_from_to_kernel_nofault_oob),
 	{}
 };
 
diff --git a/mm/maccess.c b/mm/maccess.c
index 518a25667..2c4251df4 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -15,7 +15,7 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__get_kernel_nofault(dst, src, type, err_label);		\
+		__get_kernel_nofault(dst, src, type, err_label);	\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -32,6 +32,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 		return -ERANGE;
 
 	pagefault_disable();
+	instrument_memcpy_before(dst, src, size);
 	if (!(align & 7))
 		copy_from_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
@@ -39,6 +40,7 @@ long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!(align & 1))
 		copy_from_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_from_kernel_nofault_loop(dst, src, size, u8, Efault);
+	instrument_memcpy_after(dst, src, size, 0);
 	pagefault_enable();
 	return 0;
 Efault:
@@ -49,7 +51,7 @@ EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
 
 #define copy_to_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
-		__put_kernel_nofault(dst, src, type, err_label);		\
+		__put_kernel_nofault(dst, src, type, err_label);	\
 		dst += sizeof(type);					\
 		src += sizeof(type);					\
 		len -= sizeof(type);					\
@@ -63,6 +65,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 		align = (unsigned long)dst | (unsigned long)src;
 
 	pagefault_disable();
+	instrument_memcpy_before(dst, src, size);
 	if (!(align & 7))
 		copy_to_kernel_nofault_loop(dst, src, size, u64, Efault);
 	if (!(align & 3))
@@ -70,6 +73,7 @@ long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
 	if (!(align & 1))
 		copy_to_kernel_nofault_loop(dst, src, size, u16, Efault);
 	copy_to_kernel_nofault_loop(dst, src, size, u8, Efault);
+	instrument_memcpy_after(dst, src, size, 0);
 	pagefault_enable();
 	return 0;
 Efault:
-- 
2.34.1


