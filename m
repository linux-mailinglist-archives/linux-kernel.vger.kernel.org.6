Return-Path: <linux-kernel+bounces-335163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09F97E218
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6E0B20F25
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AABE68;
	Sun, 22 Sep 2024 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhvSd1j+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E8428F1
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017043; cv=none; b=eLqoDPESuakzcQ3f8LDo4IDRLdusU/S0Uozc8Mfj4DIulWzqIqlU6lVwQo7nmCmpgdnbgYWqblA9XuIXpZ8mMOx6F//sx9wbDawgDWABaiwOi+aiAlr7P/XjGkbbvl8BvwtTuxQsAU6mEIIilOE7nmR1lA2VaRbyzLW4eQMrXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017043; c=relaxed/simple;
	bh=tvnkYDpJzIuVg/CyHV9ooID3SPbTCbxoLYYJRCLv5Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvjUfBKRnG1TbWpl31eOTgUFSUGBY+9DCZsMPBoH+aTy8C/pNXsiTLBDzUGZoHo09Ax9bISbE9qWn/ydRGOBO01KK/evdY/L5nfplId3NG6hrrN6LvjwMGasgpb7WpjWILQueZpQUzZcxNgxDvz6W8CBrBswKKx3ns4azBizhfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhvSd1j+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53654e2ed93so4004704e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727017040; x=1727621840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSsoTcyLR4PNClY5/YmWaWnU/WLJii7j4C/vMtkK7Zc=;
        b=EhvSd1j+K0E2GK9ch/nH6v8e8WwAIZmT2c9WoB9mdX8MRlkCszNzV1tM6LpgDw4rtx
         TpLS820Igr4hiKy1XdcbfkrVHLaEQjBeQ500pMEX6CJO1Gel9A0lHMzSarCwmScGawG9
         ZH25OJA/hRJG9AAiO/CbLD3dpxRNEM1RBMQdmeJ/xos6bYDZAYwfYNf5hf62x3IYYaJ2
         xdHt1LMIpTirp2Fkef02MPWjRkIuOrRgSM5vPbSJ0I77BaN+dMVnBm+42Uv5HmoXnjCa
         Is8zB8hmb5hacjONKdmocoInVrbkAWnZR6DixSHq2FxpiOJHjP9Io1b2VyOpb+RFDhRG
         QeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727017040; x=1727621840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSsoTcyLR4PNClY5/YmWaWnU/WLJii7j4C/vMtkK7Zc=;
        b=GW6yu/cYWYZ0LpyNBYEJzXqvHqBTHvBMpuLz+LpajO6Ryx/8Po5Gft7Fbc2a8L7Lz2
         RGvyR8Ii4rJBNWy1VTaeHJr9J9adfX96a7lpRg/e8/nwE4iZcjA5cOah6DElkBlGLPys
         nHLp4u0hXGznBSIewtIBqj4kS4d83pIDoxrK/pbReFHBvttmm/3yDbaPC25c4Sd0k3GI
         8LxJTECm0RJgu/qmGYME1IBpQz4X8nS5oA79+W5s/vF244/mdWJFIsGo2FdKAzVQQMge
         ndaoto6fh1pD7epMaw0CJSr72I7mV/s1jeJJ7wlPc6ynHXvXrt0SHJCVcX1xSY+CI7i5
         feYg==
X-Forwarded-Encrypted: i=1; AJvYcCUo1jtiKXlQ1+9ddrQVK5xWUdveEFwg+nX6vuhdQb6gKdXJZ207QnHH6decT+XoCidLa4tNFJqwujdybq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVJXSRXNbBd2GQiG+BcT6OWidPFekj1tj28kz2zTZo95sBIzz
	EcICqu3Ao189c44u5L6zAB79TcFFjLaZyToP5S5j8ImlsfrRQryP
X-Google-Smtp-Source: AGHT+IHqiI1fBzujD85oTu2M/fwbwiMRTYRKDhGgNK+Uzgpel5CxDnekag+DjuMbx5NIvxqNrHspGA==
X-Received: by 2002:a05:6512:1107:b0:52c:dd3d:85af with SMTP id 2adb3069b0e04-536ad17d3ecmr3752178e87.25.1727017039468;
        Sun, 22 Sep 2024 07:57:19 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968f3sm2960765e87.126.2024.09.22.07.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:57:18 -0700 (PDT)
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
Subject: [PATCH v5] mm: x86: instrument __get/__put_kernel_nofault
Date: Sun, 22 Sep 2024 19:57:57 +0500
Message-Id: <20240922145757.986887-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZfaZGowWPE8kMeTY60n7BCFT2q4+Z2EJ92YB_+7+OUo7Q@mail.gmail.com>
References: <CA+fCnZfaZGowWPE8kMeTY60n7BCFT2q4+Z2EJ92YB_+7+OUo7Q@mail.gmail.com>
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

copy_from_to_kernel_nofault_oob() kunit test triggers 4 KASAN OOB
bug reports as expected, one for each copy_from/to_kernel_nofault call.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210505
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
v3: changed kunit test from UAF to OOB case and git commit message.
v4: updated a grammar in git commit message.
v5: copy_from_to_kernel_nofault_oob() works only for x86 arch,
	remove instrument_get_user() from __get_user_size on
	!CONFIG_CC_HAS_ASM_GOTO_OUTPUT
---
 arch/x86/include/asm/uaccess.h |  3 +++
 mm/kasan/kasan_test.c          | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..e8e5185dd65c 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -620,6 +620,7 @@ do {									\
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 #define __get_kernel_nofault(dst, src, type, err_label)			\
+	instrument_memcpy_before(dst, src, sizeof(type));		\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), err_label)
 #else // !CONFIG_CC_HAS_ASM_GOTO_OUTPUT
@@ -627,6 +628,7 @@ do {									\
 do {									\
 	int __kr_err;							\
 									\
+	instrument_memcpy_before(dst, src, sizeof(type));		\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
 			sizeof(type), __kr_err);			\
 	if (unlikely(__kr_err))						\
@@ -635,6 +637,7 @@ do {									\
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 #define __put_kernel_nofault(dst, src, type, err_label)			\
+	instrument_write(dst, sizeof(type));				\
 	__put_user_size(*((type *)(src)), (__force type __user *)(dst),	\
 			sizeof(type), err_label)
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 567d33b493e2..c369a5b1c6a7 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1944,6 +1944,28 @@ static void match_all_mem_tag(struct kunit *test)
 	kfree(ptr);
 }
 
+static void copy_from_to_kernel_nofault_oob(struct kunit *test)
+{
+	char *ptr;
+	char buf[128];
+	size_t size = sizeof(buf);
+
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_X86);
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
@@ -2017,6 +2039,7 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
+	KUNIT_CASE(copy_from_to_kernel_nofault_oob),
 	{}
 };
 
-- 
2.34.1


