Return-Path: <linux-kernel+bounces-332035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B997B48C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E43FB24A18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBC41898E5;
	Tue, 17 Sep 2024 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzQ6Lkrs"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49213777E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604308; cv=none; b=TBb32TGandFe6o9CCgavwyW4IBf3rzEhM5WroK4ZSXnif1H6NzaiR3vAx3Oqbb3vHHwvAoxgmAbqEJtLgM0Jm8ZLtKiWH7PmvJTJmEd13bkGHlnGvY6b54k3A4pOgG9h1c7PbFPh83slsGw+ZpzgZ2muKKWI4YRT/gVL7orQd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604308; c=relaxed/simple;
	bh=NjE8Sv0r1KTqiB+toGEtVBR7W0Lm0ydZnC5yQVDy4eM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCnUx60akaeDAPSx4dK6g7C3ez0ROsM0aX9lwGw0ar298wZZ6CmsUlH90CskxrFLKUNdd2M+We6/SEmplcnzw0d+1cmaqaOSYaxpb/RuDHXYV4AA1qStAsNgTurPkZFdUi1/k2Rs0WHih9jDBxgdKAlD72EQjNIfbU3fRxZ/aF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzQ6Lkrs; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f7ba97ebaaso4898841fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726604304; x=1727209104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KPVK8WDP2lu8d6Rf2OpDhu2yQ4Y7AWH6O/hGAY3qvM=;
        b=fzQ6LkrsASW54T678mEMDPOaeweRdebpZQ7VPa+VJ4Z3/6XTlvEo8SKXd20hMHwcj1
         SPePU/Oihlhf8B63MZytpffX29hSD6kJsPdEK3XI7QrEkI4WUwZ/mmSvli4dq9GVs6Lz
         DMNX/SWKtZwcVGOTgtTAcZ0y0D1M1rCK7S2bc55ES7ppasL1OLKjjhBYU1yy+pVnd3y9
         BInbFRowZtt7s97NMJr5km7LHsb7Lj36SqEN9yODRM3xoQ3yVdzLNhqjy6sZ07Rqwk3e
         +pIOLIrUcYM6xhXO5Z8qiHmG7ShCx/fHfRY1c5w+GRgStfHDC5h52VHZnecrzUefrSB8
         M7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726604304; x=1727209104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KPVK8WDP2lu8d6Rf2OpDhu2yQ4Y7AWH6O/hGAY3qvM=;
        b=XGgs8mx88D9CXAr5WQ5Xfs3/g02RVqA/FLBffAI5WGH3S1pJLPIVwg1VvOjUEE0vIR
         WFwL0hXMfHV8qR8DJaC4fjwh4SHCrFolxAQKRDNsxJZWTkOYwOBu5KTTaabUECybamCs
         7kyLc1Dy1RDfkixd0fQwz/LrsUiWd2jhSkXQLbcRu97fa0cXliVt3EPMGSzm1OWlAJSJ
         XM58q2ZZmQ61AUGJRVPuryQQjGGG49tOETAYawAlRXY/Gz66JL89mFW95uK9lih2eCHA
         5Vhn2tEdFxwa9zdQwrACLrWyUydAUKR92Y1rqTehDOKenLMo4jakoPfWz+W03CMck0MB
         d6zw==
X-Forwarded-Encrypted: i=1; AJvYcCXP4uzsM/dhxvMXLPG+uf8KT0zy3CwLfQuXAbaduNN0aJSP0FZdCp3S7WAKkrZIGySrQKSon4zocFhHE7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrpl5eyAgnngD5CMyBRd9V+Tvrxx7rh1vOT3eV5X317ahiHUx
	sJFyATSBz0W4yaHKOegsTWLORa6t5OYj1M7et0uVZjD/UeMfUeSx
X-Google-Smtp-Source: AGHT+IE/VaOX6ysUN/MJb+7iEx7h2yL96iWAaz8lQ1zGBWntmQNzrmXsLhnEwB1lXy+RwG+r2chGOw==
X-Received: by 2002:a2e:611a:0:b0:2f7:4c31:acae with SMTP id 38308e7fff4ca-2f787da5004mr82814691fa.2.1726604304078;
        Tue, 17 Sep 2024 13:18:24 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d59b99bsm11668051fa.130.2024.09.17.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:18:23 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	glider@google.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org
Cc: mingo@redhat.com,
	dave.hansen@linux.intel.com,
	ryabinin.a.a@gmail.com,
	x86@kernel.org,
	hpa@zytor.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	brauner@kernel.org,
	dhowells@redhat.com,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH] mm: x86: instrument __get/__put_kernel_nofault
Date: Wed, 18 Sep 2024 01:18:17 +0500
Message-Id: <20240917201817.657490-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
strncpy_from_kernel_nofault() where __put_kernel_nofault,
__get_kernel_nofault macros are used.

Regular instrument_read() and instrument_write() handles KASAN, KCSAN
checks for the access address, though instrument_memcpy_before() might
be considered as well for both src and dst address validation.

__get_user_size was appended with instrument_get_user() for KMSAN check in
commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/x86/include/asm/uaccess.h |  4 ++++
 mm/kasan/kasan_test.c          | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..bed84d3f7245 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -353,6 +353,7 @@ do {									\
 	default:							\
 		(x) = __get_user_bad();					\
 	}								\
+	instrument_get_user(x);						\
 } while (0)
 
 #define __get_user_asm(x, addr, err, itype)				\
@@ -620,6 +621,7 @@ do {									\
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 #define __get_kernel_nofault(dst, src, type, err_label)			\
+	instrument_read(src, sizeof(type));				\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), err_label)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
@@ -627,6 +629,7 @@ do {									\
 do {									\
 	int __kr_err;							\
 									\
+	instrument_read(src, sizeof(type));				\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), __kr_err);			\
 	if (unlikely(__kr_err))						\
@@ -635,6 +638,7 @@ do {									\
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
+	instrument_write(dst, sizeof(type));				\
 	__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
 			sizeof(type), err_label)
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7b32be2a3cf0..f5086c86e0bd 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1899,6 +1899,22 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+static void copy_from_to_kernel_nofault(struct kunit *test)
+{
+	char *ptr;
+	char buf[16];
+	size_t size = sizeof(buf);
+
+	ptr = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	kfree(ptr);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_from_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(ptr, &buf[0], size));
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -1971,6 +1987,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_from_to_kernel_nofault),
 	{}
 };
 
-- 
2.34.1


