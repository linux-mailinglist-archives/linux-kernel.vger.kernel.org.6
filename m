Return-Path: <linux-kernel+bounces-333414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79297C845
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF9286DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B319C57B;
	Thu, 19 Sep 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hf/oqjAk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBA019B3C0
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726743446; cv=none; b=tzCSFAFZ3H9CQ4U68eN84ZM7EChDU3BEDedseVZis7j9OHDUq++i42C2Ein/xAe4CSEN7xB9qa/fvK/NfX5wdh2efxMDz1GrMdu0pryJhgVdp1uvH2ahWRk7U5ohB5BCfyuCvxN9N5cZuZSsXl0si/7pqBvcaI71wXQk5x3vQuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726743446; c=relaxed/simple;
	bh=KD9skxBbBj46lFQMazJKOb033r2fcd/rcGThZLlO35U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liFtE1PZljsJXJADMeqFMS+plTHibL9wpz1pVAIdPxAY+/DM7ysWuyDaCrlz/LaZkPm3m7nrC6wjdBP+NFoq1LpDVd9H1j0bD5k79PjJipik/NnMdy68H+OS6HqSydf4tX7km9EoxBkwqSZf49wiqiiKdg++HGyIhHb39lhoAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hf/oqjAk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f78b28ddb6so6593461fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726743443; x=1727348243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ9HZHJD0QLNFkZHIpeJlyi0Ek76HYhPtHMe5HLX1eo=;
        b=Hf/oqjAkqkc/Pbz6vg5l9BaHxo6guLcMgun8nz1t6QZ9MvuYweyHf8K84I4BYuEVUD
         xjwAaUMSO/UVZBArehw6puaMMQxQyy7Art1gLlYptsr2zBqlWfoVEWvsUbVlvkSwxVPl
         +eP0DiQr4fXHiuvQjF6TDfDh93caAObDFYqv9O4R/4EDtFhaGlBavPyyU5bLejmyh7V3
         D55Ert55MMH1deL0S1RtBSbWipuXBsJsovQQYVh7fgIxWXdRBeiF1C5hClppbKYQoa/p
         5R2zx3YM2Qx6IpzlW5K8aMLcQpaGIZj9FvDpi+IhkhOp03tXny0yIhBxtlYwAz2B1v2j
         gZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726743443; x=1727348243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ9HZHJD0QLNFkZHIpeJlyi0Ek76HYhPtHMe5HLX1eo=;
        b=VDXaUc58RCTR9kj8x0R8RElO237Z5IA+I810ed6fQ3ytZXVNAHQTJTR9eT4yNwUPpU
         J/W8mQrlteBERRuDlcolGaxSYEcF/ejR0xWsTIac7OUrJDPndAzW5Mc3xD1CRCdgMLML
         XyLX22vuJvAbhHj9ZXgPDPL8pNMPpIF2/iuteBjGxj/tmzBR0z3WmszsWXVeTRyn/I4N
         ysnt/+SPN3xT+QNSa6i9hBUwqlExFrGY0jTORrMga2cVMWIO0Z6Qg2vpttRisYaNYgDk
         zFoBHdXwsOwegKJeFBgSrq4nnnz7JVouck/afEdYlIVLdq1Mn/XKcRpZv2aXUYheAl0z
         RiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMMRaPvqH3Cbs/e8sPEaEC9k+2C5Jv5nieqowPSYbOGQfrNciUBfptc1Yi0x3ov05mmwgX8Kq3ykRuBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNn5GdXyF06iz9fvOq4BQTQ/8zuyvq0QhtV0+lbgUniHXzX4j
	v/dm3OXngd6t/Rfgg/VgvGaTcwWOd+gD5rTCsglo8fkdjARuz2pH
X-Google-Smtp-Source: AGHT+IFCefsOZr/jmfhZfRtwZLYLHEqhbkYUuHJUtLH/v8E7pnynNcbVdgR2uDruY5y8SnFBAzqllA==
X-Received: by 2002:a05:651c:154a:b0:2f6:4aed:9973 with SMTP id 38308e7fff4ca-2f787f5833dmr156325931fa.44.1726743442445;
        Thu, 19 Sep 2024 03:57:22 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1d8csm16223341fa.21.2024.09.19.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 03:57:21 -0700 (PDT)
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
Subject: [PATCH v3] mm: x86: instrument __get/__put_kernel_nofault
Date: Thu, 19 Sep 2024 15:57:50 +0500
Message-Id: <20240919105750.901303-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZfg2E7Hk2Sc-=Z4XnENm9KUtmAZ6378YgeJg6xriMQXpA@mail.gmail.com>
References: <CA+fCnZfg2E7Hk2Sc-=Z4XnENm9KUtmAZ6378YgeJg6xriMQXpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 18, 2024 at 8:15 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> You still have the same problem here.
>
> What I meant is:
>
> char *ptr;
> char buf[128 - KASAN_GRANULE_SIZE];
> size_t size = sizeof(buf);
>
> ptr = kmalloc(size, GFP_KERNEL);
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>
> KUNIT_EXPECT_KASAN_FAIL(...);
> ...
>
> kfree(ptr);

Thanks for catching this! I've turned kunit test into OOB instead of UAF.
---
v3: changed kunit test from UAF to OOB case and git commit message.
---
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

copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB bug reports
as expected for each copy_from/to_kernel_nofault call.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
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


