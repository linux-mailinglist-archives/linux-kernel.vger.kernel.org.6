Return-Path: <linux-kernel+bounces-334768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36A97DBED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000522838F0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE2149E06;
	Sat, 21 Sep 2024 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPgRjyqJ"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B7829A1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726902573; cv=none; b=BPFmcCtxKQGHvOMb4oi3PBNFqaX4LP3P+irZwU9k0d3aNas6oHg3Q+H4JB00W4J0vkZxlh1B9kiwRedvshAjHchfaJX/WWTtsi+aayiY9kiJ5iZgVZQZxdWTBznGUADuh76c/64weVK8ektyRBe4ipWlVys/djCIIswd5mQWjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726902573; c=relaxed/simple;
	bh=lLM9rTyJIZVxYyET/bifShwBhcfjxtmKINiC8QCTMUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QERO4Gw8n5NAO1gp8u4EFJkoUlk5enFlpM0phS2msF+gxlxmyA7QtpZULzv+BYa/auVqcgSpEKYep57tjOvlCxEP29klWCVK0gek6QAmLud2OhZKot9B3j0qT3lWT5RAkwQc4LV9gCaD5eKV6hd8yRtFqfYiH7LGwG/+kpEWHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPgRjyqJ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f7502f09fdso22011181fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726902570; x=1727507370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ohAzvebGtlWdpIGNEivr1Zt3bErXvsBaqlk21HjfVY=;
        b=CPgRjyqJCDA+Nd2ahPZnrHfUabceEHSZpmSbZJA+gre7XvKsnMf1SQLzIsZGnLL+uP
         RreEsImVtCYlLv1h0IqMoS38tHkSavGrK8szmeXNjnA6omdSM9VmChP0TZtlmg95EdrF
         qkAU4hxIn4BxFgMUV5i96j3HO8ErNpZQDv77YlIzNxee5/P8Xo5mRde373vlAnKpouRj
         AOFQxVGORr05l78LmeyOahoBl94asARtBO8WPsPctaoRTBUz6I0stlRNhftIPSPzmGF7
         iW6eKUCcyXzhpkNIuUFfl71fkmJ3hT8Ps8/UPhEvg6pnv/VPQJd0geS6djpwYnEjwxkD
         0A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726902570; x=1727507370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ohAzvebGtlWdpIGNEivr1Zt3bErXvsBaqlk21HjfVY=;
        b=oLjpx+9j5jZfhc5uNL3YlzB+bd3B66uw2U0fYq6QlbeUseTgOobSMesXoUocYN/gYD
         O0r+l7YdwSZEJwUuvQO5b1QPXb1tv7iBsgIqlIHvZW63wlf8ZTJmhEzIUlPGtzUShm9t
         tAKK1NDax5U9MlSakUfi1iWvHiyWYZBhxDNBOjdNIGiNEJDBb/U7kIP4Q4OAkdxrtiVD
         /DenI0F/I+lXctmXSjp3L+I+vdM5ko0sfsgu90sIt1vkOLFPxw8IFUYlWOBhM1lQDtKw
         vJSiQXGPJESwvWcmKMTgG7PWraXa6i8ujz8P7Xdg5e6DR9DNV/zI1naS5YX5y/eS00je
         H7FA==
X-Forwarded-Encrypted: i=1; AJvYcCW3xdhqjKwIz+gYJogIaHua1xWMZYQ2ri6cOvxaTYClUD+BygTNBNF0lUiexEggeg1RfmhFYMgd3JxA33k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyivOjmtUpopct6n9X/c6cd/gXAsGU1G2ypY9DwOUpLwV2/txZ1
	ZtlyNOruFoek4a7eSx4JS14rsE+8ANUecsAWNkombpBXVMSYdlQi
X-Google-Smtp-Source: AGHT+IGwsiVPhNv7avWF4x04Wx0XxQzDDJ/r0u3N/C/vOWSYOIyZiQngXhgni063oll3giK30MdWWw==
X-Received: by 2002:a05:651c:199f:b0:2f5:375:c1da with SMTP id 38308e7fff4ca-2f7c3d09a2fmr31608841fa.1.1726902569682;
        Sat, 21 Sep 2024 00:09:29 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d485f2csm22082221fa.115.2024.09.21.00.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 00:09:28 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	brauner@kernel.org,
	dave.hansen@linux.intel.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	glider@google.com,
	hpa@zytor.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mingo@redhat.com,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	tglx@linutronix.de,
	vincenzo.frascino@arm.com,
	x86@kernel.org
Subject: [PATCH v4] mm: x86: instrument __get/__put_kernel_nofault
Date: Sat, 21 Sep 2024 12:10:05 +0500
Message-Id: <20240921071005.909660-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
References: <CA+fCnZeiVRiO76h+RR+uKkWNNGGNsVt_yRGGod+fmC8O519T+g@mail.gmail.com>
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

__get_kernel_nofault needs instrument_memcpy_before() which handles
KASAN, KCSAN checks for src, dst address, whereas for __put_kernel_nofault
macro, instrument_write() check should be enough as it's validated via
kmsan_copy_to_user() in instrument_put_user().

__get_user_size was appended with instrument_get_user() for KMSAN check in
commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.

copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB
bug reports as expected, one for each copy_from/to_kernel_nofault call.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v3: changed kunit test from UAF to OOB case and git commit message.
v4: updated a grammar in git commit message.
---
 arch/x86/include/asm/uaccess.h |  4 ++++
 mm/kasan/kasan_test.c          | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..87fb59071e8c 100644
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
+	instrument_memcpy_before(dst, src, sizeof(type));		\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), err_label)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
@@ -627,6 +629,7 @@ do {									\
 do {									\
 	int __kr_err;							\
 									\
+	instrument_memcpy_before(dst, src, sizeof(type));		\
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
index 7b32be2a3cf0..d13f1a514750 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1899,6 +1899,26 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+{
+	char *ptr;
+	char buf[128];
+	size_t size = sizeof(buf);
+
+	ptr = kmalloc(size - KASAN_GRANULE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
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
@@ -1971,6 +1991,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_from_to_kernel_nofault_oob),
 	{}
 };
 
-- 
2.34.1


