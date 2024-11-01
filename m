Return-Path: <linux-kernel+bounces-392758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBB9B97CC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128DE1C2031F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB21CEEA1;
	Fri,  1 Nov 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6pQLTUq"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D861CEE82
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486424; cv=none; b=MqXdEIgYRRjn2y4DkBN5XmVvgqCvmskcGq8Xk6mRcd6+BxB0/aQQvDD7ClT76hSMtv31hYxNGt5hsSFpr6hDIy9Z9p4LVPAvUKBg/a4jlw763/zDyT5EjaZ3/yGB22xpWCJnQLVPfkzXv3nAIcBypNQ1LHXgUiP1XrUtBSLcoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486424; c=relaxed/simple;
	bh=vtf97JfxjX82lzzJ2ayrvX+aZhQw6cMjibQNpU85lkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Au/NzweakT2vT5AtJm15L+BFcMwRnhSVfgZiKgJpm3bmvG+rJ5+Bf1UC7DO7EFjRsmUAdLDCt3jh/LWXxAgzHUm8e0Fj3rhYMHfjGn5Z1rDAoTEF+n3QjFbOt2UrVuuJKjO7TVF4vL3LvlWiNH4VcI6SfaowdWGOAONGHhPudxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6pQLTUq; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so3786384e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730486421; x=1731091221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=325HZLula7jSoNoGXlC+vhYpf/xwBEOPgui+U1ZAOR4=;
        b=Y6pQLTUqXvus24b8u1CrJHA4s1jj8HKXfipIm3QPMTn8wK19CdVp/r2V6XJMm1EmWK
         4gsEiyEd1i5q2sbDaQyXS0NQkxr9Lpxy0a859/xiqYTNpTQ8s9TiNkwRMPTdOaos++FM
         /r9vvepIMjgpcd9TM1rVj7N5q35TwQXhXRiqmKehHH5gBbjTiHiAFOq0Kq4RGolStoMr
         gy1ZUbYGt2c2n7PELlzgnkiE2+DtxXks5YO2aJh35IOR2fIGICpHwYMo12RcPllC+nCg
         SHoRR63AFx6OAteB8ZylCui9P1GqCxp6ORJCQXP0lNiENd+T1Po1IDUVzUijFU9KeMfm
         LShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486421; x=1731091221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=325HZLula7jSoNoGXlC+vhYpf/xwBEOPgui+U1ZAOR4=;
        b=XKY/Qp9picP1wZzP/oFIhZbvolqDqj5AgQpksFBEQfPOd9/YFpKvGJR8rxqXV8op2b
         7EnGvrBqpOOzAUVddRBXQO2sFF6Ir8GYbsI+Vo0TYGwWFsohBrOqnygsHbICTC72vN7c
         hOH3P84YwHweOhtDwpzlnB33B390mIhe1bFEi35UasRRlNC9Zlexc9NXHYdUJSQWOCvu
         VK4Izoj7jXaQNo3/cEUliooX7JDpR7Mkkn6VbThgePrYDRiwyn7fcsfPAoB6mNPItjt7
         PMREDS2W0O+0ZtvLqbvB7KsbNmpMg98/DjxnK3zv4DrhBQGvoZMGF96da5GqDX0il00b
         y64Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnML9vTyK++uWI7VaZGXsi5+Gy4/ESRw9diwyYq6/I2D5d8OUPvGkFwjXz/N9tmxj2kuEZ2EvNkdmMSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YnAH+K7Bqjv5eqZ5VKUplBxvHWD1oez7PNmDYenv85z0VSB8
	20ileqKDxyiwTMGVlc5XaLIjSxYw77TyV1/M//LX6qlDhA4+Mdtm
X-Google-Smtp-Source: AGHT+IFJs6WKOoZ+dQPXZdy5J0yt3B7+wP/Od81xCXCJNl3ABlWzNAHthdTYNFEexLKPL7ABxshCLw==
X-Received: by 2002:a05:6512:3a8b:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53d65de5298mr4080862e87.23.1730486420555;
        Fri, 01 Nov 2024 11:40:20 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc957cbsm646821e87.60.2024.11.01.11.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 11:40:19 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	elver@google.com
Cc: arnd@kernel.org,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	snovitoll@gmail.com
Subject: [PATCH 1/2] kasan: use EXPORT_SYMBOL_IF_KUNIT to export symbols
Date: Fri,  1 Nov 2024 23:40:10 +0500
Message-Id: <20241101184011.3369247-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101184011.3369247-1-snovitoll@gmail.com>
References: <20241101184011.3369247-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace EXPORT_SYMBOL_GPL with EXPORT_SYMBOL_IF_KUNIT to mark the
symbols as visible only if CONFIG_KUNIT is enabled.

KASAN Kunit test should import the namespace EXPORTED_FOR_KUNIT_TESTING
to use these marked symbols.

Reported-by: Andrey Konovalov <andreyknvl@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 mm/kasan/hw_tags.c      |  7 ++++---
 mm/kasan/kasan_test_c.c |  2 ++
 mm/kasan/report.c       | 17 +++++++++--------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9958ebc15d38..ccd66c7a4081 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "kasan: " fmt
 
+#include <kunit/visibility.h>
 #include <linux/init.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -394,12 +395,12 @@ void kasan_enable_hw_tags(void)
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
-EXPORT_SYMBOL_GPL(kasan_enable_hw_tags);
+EXPORT_SYMBOL_IF_KUNIT(kasan_enable_hw_tags);
 
-void kasan_force_async_fault(void)
+VISIBLE_IF_KUNIT void kasan_force_async_fault(void)
 {
 	hw_force_async_tag_fault();
 }
-EXPORT_SYMBOL_GPL(kasan_force_async_fault);
+EXPORT_SYMBOL_IF_KUNIT(kasan_force_async_fault);
 
 #endif
diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..3e495c09342e 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -33,6 +33,8 @@
 
 #define OOB_TAG_OFF (IS_ENABLED(CONFIG_KASAN_GENERIC) ? 0 : KASAN_GRANULE_SIZE)
 
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
 static bool multishot;
 
 /* Fields set based on lines observed in the console. */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc84..e5bc4e3ee198 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -10,6 +10,7 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/visibility.h>
 #include <linux/bitops.h>
 #include <linux/ftrace.h>
 #include <linux/init.h>
@@ -134,18 +135,18 @@ static bool report_enabled(void)
 
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
 
-bool kasan_save_enable_multi_shot(void)
+VISIBLE_IF_KUNIT bool kasan_save_enable_multi_shot(void)
 {
 	return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
 }
-EXPORT_SYMBOL_GPL(kasan_save_enable_multi_shot);
+EXPORT_SYMBOL_IF_KUNIT(kasan_save_enable_multi_shot);
 
-void kasan_restore_multi_shot(bool enabled)
+VISIBLE_IF_KUNIT void kasan_restore_multi_shot(bool enabled)
 {
 	if (!enabled)
 		clear_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
 }
-EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
+EXPORT_SYMBOL_IF_KUNIT(kasan_restore_multi_shot);
 
 #endif
 
@@ -157,17 +158,17 @@ EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
  */
 static bool kasan_kunit_executing;
 
-void kasan_kunit_test_suite_start(void)
+VISIBLE_IF_KUNIT void kasan_kunit_test_suite_start(void)
 {
 	WRITE_ONCE(kasan_kunit_executing, true);
 }
-EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_start);
+EXPORT_SYMBOL_IF_KUNIT(kasan_kunit_test_suite_start);
 
-void kasan_kunit_test_suite_end(void)
+VISIBLE_IF_KUNIT void kasan_kunit_test_suite_end(void)
 {
 	WRITE_ONCE(kasan_kunit_executing, false);
 }
-EXPORT_SYMBOL_GPL(kasan_kunit_test_suite_end);
+EXPORT_SYMBOL_IF_KUNIT(kasan_kunit_test_suite_end);
 
 static bool kasan_kunit_test_suite_executing(void)
 {
-- 
2.34.1


