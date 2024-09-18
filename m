Return-Path: <linux-kernel+bounces-332555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604897BB28
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B83B1C2121B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40E17B401;
	Wed, 18 Sep 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONE1nniF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A3817D8A2
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657027; cv=none; b=KHEG2h5tdgbU+EXE6iNoc5H7mtjVFYRSX/+3BsE2x1RXxD8sgjOl16SM2IM5vGepFP7p+giwv5Y9tG7bXMDZ6IahTKonbcmqLkiLDTuHf8nfAmG+oU4I2AEfJQN5tmZdi9KqVhKR7R7vawD2uj2TVYPLZREOnA8sRulVixFaHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657027; c=relaxed/simple;
	bh=niaeE9Rn5X7JdhgpOZtui0nrNt6tp7yBYVmg5MhzU6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXne1T3Qe0gGHU+BT2AF3IM7U+dQ273MemDXRArNUjLpJ3vY5ByqDU4BhBxqzIib8PZO6bxbzwIX1UamwPmAZw9kvZNrbaEzD1G8ZyFcqxYw7d7PGME/mJ2AnODXGmhkeeVhj9uyOYn3IixyNqvm0Gj8sMCwesheiinbIJt1QrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONE1nniF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5356ab89665so7542962e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726657024; x=1727261824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIjQBepkmzGZvnIkQy1K5zVrOzJD//KUcFSCnlgygqs=;
        b=ONE1nniFV03YwjSyj88fzMkEoWAVctFQZ+EFlU62sJ6HFjUix1wI0sXEe80fsRr1cz
         g40l7PrDpURUhB+8u2Qi6pgbxXDZwhkio++Pmyz+Ag0EO8BVynXzOFztMH275i0wTu5B
         7uvivzDIbqKcQI/oZkDHysWBLZCXCWqsyEcKbjiiRluHiWXes1i1qdxcwam7KXMcgfX/
         20ghSgPQo/W7EP/ND1rIUezl0umLRKUd70tG8Oj5zgjwifF1BE34zJzORrYB6kqCY2UU
         UljyWX0aAHRBUx9zYgz0Ol3wN3NOH1njkUCLBxQYUd8dFhz//1S/W53/h5P9f3EMRs5l
         a9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726657024; x=1727261824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIjQBepkmzGZvnIkQy1K5zVrOzJD//KUcFSCnlgygqs=;
        b=htgnS/Z9oAn56/Cru5nfEV0StNIN3FENYu/8xwUDEeTKeLdlcbuTR/+rQCLBa202+v
         S3CdmkEIqr0fNpC96WVPucBtRzRI2VE2hk8P1gm1EYKLcX8fNevlvqNZD8q+h54WA+aH
         gXMfC1JRED44H//US03UBum/QuSG7uqQ0mWLT4zB17TfwZzus3V9GlfeN5roOjwRLNWl
         C/pwPYzuGt6YKlqRCFbXt0DdxW40IPkH/zUM+S8i1TLXG5hN8h5MfUH5hkusSdoak7eX
         Dw9hajwSkUq/gH19xAqUdmsKS6AXRh0mg/iMUZTArVhcTYLRYeSbkim48+k5eUjBizVo
         QU6w==
X-Forwarded-Encrypted: i=1; AJvYcCXsYUt120K/UVI8KfOzBnOveeW8nZhQZ7ZcmFFjzjQTW4AGpTuRxhQw0LYAg4MnQtFZ62TUuwW1AAojm/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMMwtRd6kzaDexvO0bY+G18pC7D5ECSUczsLuLq/7rychXxZ4
	ZU+Q8gB0iuaY8xM89t13fBGKzBDqrccR/393eDBwcFgJ2vHAGK0+
X-Google-Smtp-Source: AGHT+IFqz7ENiL4wqkVZ3XAOWG7V3zHOrWYfWGz0gDIRzRURqETvAt5X2vKD5/78LXvNLLBNtfDRBQ==
X-Received: by 2002:a05:6512:ea2:b0:535:6ba7:7725 with SMTP id 2adb3069b0e04-53678fb1cd4mr12757113e87.3.1726657023314;
        Wed, 18 Sep 2024 03:57:03 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8d6fsm1472524e87.291.2024.09.18.03.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:57:02 -0700 (PDT)
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
Subject: [PATCH v2] mm: x86: instrument __get/__put_kernel_nofault
Date: Wed, 18 Sep 2024 15:56:41 +0500
Message-Id: <20240918105641.704070-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZeorA7ptz6YY6=KEmJ+Bvo=9MQmUeBvzYNobtNmBM4L-A@mail.gmail.com>
References: <CA+fCnZeorA7ptz6YY6=KEmJ+Bvo=9MQmUeBvzYNobtNmBM4L-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instrument copy_from_kernel_nofault(), copy_to_kernel_nofault(),
strncpy_from_kernel_nofault() where __put_kernel_nofault, __get_kernel_nofault
macros are used.

__get_kernel_nofault needs instrument_memcpy_before() which handles
KASAN, KCSAN checks for src, dst address, whereas for __put_kernel_nofault
macro, instrument_write() check should be enough as it's validated via
kmsan_copy_to_user() in instrument_put_user().

__get_user_size was appended with instrument_get_user() for KMSAN check in
commit 888f84a6da4d("x86: asm: instrument usercopy in get_user() and
put_user()") but only for CONFIG_CC_HAS_ASM_GOTO_OUTPUT.

copy_from_to_kernel_nofault() kunit test triggers 4 KASAN bug reports as
expected per each copy_from/to_kernel_nofault call.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v2: added 2 tests for src, dst check and enhanced instrument check in macros

On Wed, Sep 18, 2024 at 3:51 AM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Sep 17, 2024 at 10:18 PM Sabyrzhan Tasbolatov
> <snovitoll@gmail.com> wrote:
> >
> I think the easiest fix would be to allocate e.g. 128 -
> KASAN_GRANULE_SIZE bytes and do an out-of-bounds up to 128 bytes via
> copy_to/from_kernel_nofault. This will only corrupt the in-object
> kmalloc redzone, which is not harmful.

Hi Andrey,

Thanks for the comments. I've changed the target UAF buffer size to
KASAN_GRANULE_SIZE and added other test cases from bugzilla.
---
 arch/x86/include/asm/uaccess.h |  4 ++++
 mm/kasan/kasan_test.c          | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..bd1ee79238a2 100644
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
+	instrument_write(dst, sizeof(type));		\
 	__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
 			sizeof(type), err_label)
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 7b32be2a3cf0..9a3c4ad91d59 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1899,6 +1899,26 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+static void copy_from_to_kernel_nofault(struct kunit *test)
+{
+	char *ptr;
+	char buf[KASAN_GRANULE_SIZE];
+	size_t size = sizeof(buf);
+
+	ptr = kmalloc(size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	kfree(ptr);
+
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_from_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_from_kernel_nofault(ptr, &buf[0], size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(&buf[0], ptr, size));
+	KUNIT_EXPECT_KASAN_FAIL(test,
+		copy_to_kernel_nofault(ptr, &buf[0], size));
+}
+
 static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
@@ -1971,6 +1991,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_from_to_kernel_nofault),
 	{}
 };
 
-- 
2.34.1


