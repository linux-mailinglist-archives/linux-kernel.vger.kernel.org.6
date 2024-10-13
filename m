Return-Path: <linux-kernel+bounces-362890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9FD99BAC1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEA81C20B53
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFD148FE6;
	Sun, 13 Oct 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcd2bShN"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC313AD22;
	Sun, 13 Oct 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843621; cv=none; b=c8aVPT0wM8dlV/Z/PguZsYkAc/FhXK5WyAS25q2CPJgSyF1y0QPVKy0EujDy9c2L6cJXwn8lZODiqlncsmOL0mcfHuAtpVjbk5ZEFT0IcCwuDstzE4JQnSydKhxcih7xPyG3DrVKBDusuCrJovEqqWfPloJb8jm4y7tQhoPz9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843621; c=relaxed/simple;
	bh=kdNeW+tfRF5cskP5DB3OFPlRrvJiDUwfTPdjfOiSPyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujt3K71ofKkm8qy26jdyjh5kziwVL7VVsDQRC8PDUXplWOjx7NknyJfB6DZ3muJKvtPGSwaGVs7gexeqtqoyzlRQ6xMkVO6OQzggcKsrKE66CvQUtUD2W89UwcbOhlOhVY35UG0zuRtgyAH2OlLMGkhJbDoCsQD25a04s1lFxNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcd2bShN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99d1b7b5f5so238614166b.0;
        Sun, 13 Oct 2024 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728843618; x=1729448418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VgeQWb7V5/+9wCZWeTdyxdjveQfvOSR+bqrKttB7Oo=;
        b=lcd2bShNlYge+CNFPOCFoGASV6FuttwNpE+mHEqpt7HH5572KX9MiXQcDWQU4mt/dx
         F2z0ntQifb4AlbRXq1gtu7iGzZxdGW5t3Ff44KMQcgv9j/wbZPC/6sW3xkSPIIBeL4cf
         bJ4bZrH9gwKXg4NdbbLvpEijy9jbLxNvHNK7m/f9xhmm2QAcwetfhfesmvXf5daeDyaN
         qZj+uNRKPbC0narODnF26gKt59M40EM3w2GVuPZBViIfKLCEMYX6KacwookGNokuqhhg
         2CISc5EWp7XfZNUTDkdn9wfdUvwnaEocDw8K360wBKjUuIroTPWqYixZ6uf7YbXSj0G7
         ts0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728843618; x=1729448418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VgeQWb7V5/+9wCZWeTdyxdjveQfvOSR+bqrKttB7Oo=;
        b=kksxu4LxOyHTqLA5cyKMuoMfH3KvMSum8xQtmM9p+PxWBzdrghtNmEvJIOngJx9RLr
         PE2zcwmzG5tCkdH/IQ6KxsgbEYB4J1IMWDGOCYm8TGMyDf7gKz+5kDs/+IAPTS3Mye6c
         mOBPZIJeiZRS60pD9hHqbhqiaCYKG0GzOQLX/U7L3TKeSkg7MB+YU01sWsaPwncr10Sa
         1Fpeb9zodTcm9xLj1K1YIaDKzfFFoHZz4oo+28xQxNJDfuzHSNCIHsxWlCpUr4Jki7zg
         ysNg55cozHItTnnNHwTaLFSwowcFPAvDU68NxDvk5OTPBEv3j4+tVKMy3vEPt6YuHyvP
         rEQA==
X-Forwarded-Encrypted: i=1; AJvYcCWlWKWtIfIG8hpmQccs2Dqv8THDJMlz6bJE17A0sJlA7Pzzs/vbK5onTmCgN/zlMIWj3nJwK/mI2XPWwTOx@vger.kernel.org, AJvYcCX5031dOHQcu9lAARASwGaXKwDdqlRLcvUs63Anjt9d+ERpYceL7rUVCUYeobdl8Gb1S5FML1lgrzw=@vger.kernel.org, AJvYcCXgrOYrfotdJuK+1ixKTOV2PkXjLIOtFY/rrRq1Gl0/QDTCH0wIrM9jXD4D0ACU+bUGoIIUNdZ6w0iR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/W9RMwThBV8JzwiaMn/jXfFAGdTJ1X7sX3ZRIP0HRtQvj8FpN
	J8xEJolSaVoWbGkevRwFfjdb6xFO4jnVgzSheqz2Z/9deKjSiKygLs2Q0/du
X-Google-Smtp-Source: AGHT+IF7pbjTDROzH2KHhlOJsp9KJeCOny31b0St94NeP+vXq9zHLg+SS19H/V8aHcAArf6zKioehA==
X-Received: by 2002:a17:906:7950:b0:a99:fe8c:5c6b with SMTP id a640c23a62f3a-a99fe8c889dmr280898466b.23.1728843617673;
        Sun, 13 Oct 2024 11:20:17 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372ae701sm3992930a12.85.2024.10.13.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 11:20:17 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: 2023002089@link.tyut.edu.cn,
	akpm@linux-foundation.org,
	alexs@kernel.org,
	corbet@lwn.net,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	siyanteng@loongson.cn,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	workflows@vger.kernel.org
Subject: [PATCH v3 3/3] kasan: delete CONFIG_KASAN_MODULE_TEST
Date: Sun, 13 Oct 2024 23:21:17 +0500
Message-Id: <20241013182117.3074894-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CA+fCnZdakHrmky_-4weoP=_rHb4cQ9Z=1RkZnmZcumL9AXeo1Q@mail.gmail.com>
References: <CA+fCnZdakHrmky_-4weoP=_rHb4cQ9Z=1RkZnmZcumL9AXeo1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since we've migrated all tests to the KUnit framework,
we can delete CONFIG_KASAN_MODULE_TEST and mentioning of it in the
documentation as well.

I've used the online translator to modify the non-English documentation.

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes v2 -> v3:
- applied Andrey's patch to modify further kasan.rst.
---
 Documentation/dev-tools/kasan.rst             | 23 ++++++++-----------
 .../translations/zh_CN/dev-tools/kasan.rst    | 20 +++++++---------
 .../translations/zh_TW/dev-tools/kasan.rst    | 21 ++++++++---------
 lib/Kconfig.kasan                             |  7 ------
 mm/kasan/kasan.h                              |  2 +-
 mm/kasan/report.c                             |  2 +-
 6 files changed, 28 insertions(+), 47 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index d7de44f5339..0a1418ab72f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -511,19 +511,14 @@ Tests
 ~~~~~
 
 There are KASAN tests that allow verifying that KASAN works and can detect
-certain types of memory corruptions. The tests consist of two parts:
+certain types of memory corruptions.
 
-1. Tests that are integrated with the KUnit Test Framework. Enabled with
-``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
+All KASAN tests are integrated with the KUnit Test Framework and can be enabled
+via ``CONFIG_KASAN_KUNIT_TEST``. The tests can be run and partially verified
 automatically in a few different ways; see the instructions below.
 
-2. Tests that are currently incompatible with KUnit. Enabled with
-``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
-only be verified manually by loading the kernel module and inspecting the
-kernel log for KASAN reports.
-
-Each KUnit-compatible KASAN test prints one of multiple KASAN reports if an
-error is detected. Then the test prints its number and status.
+Each KASAN test prints one of multiple KASAN reports if an error is detected.
+Then the test prints its number and status.
 
 When a test passes::
 
@@ -550,16 +545,16 @@ Or, if one of the tests failed::
 
         not ok 1 - kasan
 
-There are a few ways to run KUnit-compatible KASAN tests.
+There are a few ways to run the KASAN tests.
 
 1. Loadable module
 
-   With ``CONFIG_KUNIT`` enabled, KASAN-KUnit tests can be built as a loadable
-   module and run by loading ``kasan_test.ko`` with ``insmod`` or ``modprobe``.
+   With ``CONFIG_KUNIT`` enabled, the tests can be built as a loadable module
+   and run by loading ``kasan_test.ko`` with ``insmod`` or ``modprobe``.
 
 2. Built-In
 
-   With ``CONFIG_KUNIT`` built-in, KASAN-KUnit tests can be built-in as well.
+   With ``CONFIG_KUNIT`` built-in, the tests can be built-in as well.
    In this case, the tests will run at boot as a late-init call.
 
 3. Using kunit_tool
diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
index 4491ad2830e..fd2e3afbdfa 100644
--- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
@@ -422,16 +422,12 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 ~~~~
 
 有一些KASAN测试可以验证KASAN是否正常工作并可以检测某些类型的内存损坏。
-测试由两部分组成:
 
-1. 与KUnit测试框架集成的测试。使用 ``CONFIG_KASAN_KUNIT_TEST`` 启用。
-这些测试可以通过几种不同的方式自动运行和部分验证；请参阅下面的说明。
+所有 KASAN 测试都与 KUnit 测试框架集成，可通过 ``CONFIG_KASAN_KUNIT_TEST`` 启用。
+测试可以通过几种不同的方式自动运行和部分验证；请参阅以下说明。
 
-2. 与KUnit不兼容的测试。使用 ``CONFIG_KASAN_MODULE_TEST`` 启用并且只能作为模块
-运行。这些测试只能通过加载内核模块并检查内核日志以获取KASAN报告来手动验证。
-
-如果检测到错误，每个KUnit兼容的KASAN测试都会打印多个KASAN报告之一，然后测试打印
-其编号和状态。
+如果检测到错误，每个 KASAN 测试都会打印多份 KASAN 报告中的一份。
+然后测试会打印其编号和状态。
 
 当测试通过::
 
@@ -458,16 +454,16 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 
         not ok 1 - kasan
 
-有几种方法可以运行与KUnit兼容的KASAN测试。
+有几种方法可以运行 KASAN 测试。
 
 1. 可加载模块
 
-   启用 ``CONFIG_KUNIT`` 后，KASAN-KUnit测试可以构建为可加载模块，并通过使用
-   ``insmod`` 或 ``modprobe`` 加载 ``kasan_test.ko`` 来运行。
+   启用 ``CONFIG_KUNIT`` 后，可以将测试构建为可加载模块
+   并通过使用 ``insmod`` 或 ``modprobe`` 加载 ``kasan_test.ko`` 来运行。
 
 2. 内置
 
-   通过内置 ``CONFIG_KUNIT`` ，也可以内置KASAN-KUnit测试。在这种情况下，
+   通过内置 ``CONFIG_KUNIT``，测试也可以内置。
    测试将在启动时作为后期初始化调用运行。
 
 3. 使用kunit_tool
diff --git a/Documentation/translations/zh_TW/dev-tools/kasan.rst b/Documentation/translations/zh_TW/dev-tools/kasan.rst
index ed342e67d8e..35b7fd18aa4 100644
--- a/Documentation/translations/zh_TW/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_TW/dev-tools/kasan.rst
@@ -404,16 +404,13 @@ KASAN連接到vmap基礎架構以懶清理未使用的影子內存。
 ~~~~
 
 有一些KASAN測試可以驗證KASAN是否正常工作並可以檢測某些類型的內存損壞。
-測試由兩部分組成:
 
-1. 與KUnit測試框架集成的測試。使用 ``CONFIG_KASAN_KUNIT_TEST`` 啓用。
-這些測試可以通過幾種不同的方式自動運行和部分驗證；請參閱下面的說明。
+所有 KASAN 測試均與 KUnit 測試框架集成，並且可以啟用
+透過 ``CONFIG_KASAN_KUNIT_TEST``。可以運行測試並進行部分驗證
+ 以幾種不同的方式自動進行；請參閱下面的說明。
 
-2. 與KUnit不兼容的測試。使用 ``CONFIG_KASAN_MODULE_TEST`` 啓用並且只能作爲模塊
-運行。這些測試只能通過加載內核模塊並檢查內核日誌以獲取KASAN報告來手動驗證。
-
-如果檢測到錯誤，每個KUnit兼容的KASAN測試都會打印多個KASAN報告之一，然後測試打印
-其編號和狀態。
+如果偵測到錯誤，每個 KASAN 測試都會列印多個 KASAN 報告之一。
+然後測試列印其編號和狀態。
 
 當測試通過::
 
@@ -440,16 +437,16 @@ KASAN連接到vmap基礎架構以懶清理未使用的影子內存。
 
         not ok 1 - kasan
 
-有幾種方法可以運行與KUnit兼容的KASAN測試。
+有幾種方法可以執行 KASAN 測試。
 
 1. 可加載模塊
 
-   啓用 ``CONFIG_KUNIT`` 後，KASAN-KUnit測試可以構建爲可加載模塊，並通過使用
-   ``insmod`` 或 ``modprobe`` 加載 ``kasan_test.ko`` 來運行。
+   啟用 ``CONFIG_KUNIT`` 後，測試可以建置為可載入模組
+   並且透過使用 ``insmod`` 或 ``modprobe`` 來載入 ``kasan_test.ko`` 來運作。
 
 2. 內置
 
-   通過內置 ``CONFIG_KUNIT`` ，也可以內置KASAN-KUnit測試。在這種情況下，
+   透過內建 ``CONFIG_KUNIT``，測試也可以內建。
    測試將在啓動時作爲後期初始化調用運行。
 
 3. 使用kunit_tool
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 98016e137b7..f82889a830f 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -195,13 +195,6 @@ config KASAN_KUNIT_TEST
 	  For more information on KUnit and unit tests in general, please refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
-config KASAN_MODULE_TEST
-	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
-	depends on m && KASAN && !KASAN_HW_TAGS
-	help
-	  A part of the KASAN test suite that is not integrated with KUnit.
-	  Incompatible with Hardware Tag-Based KASAN.
-
 config KASAN_EXTRA_INFO
 	bool "Record and report more information"
 	depends on KASAN
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index f438a6cdc96..b7e4b81421b 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -568,7 +568,7 @@ static inline void kasan_kunit_test_suite_end(void) { }
 
 #endif /* CONFIG_KASAN_KUNIT_TEST */
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 bool kasan_save_enable_multi_shot(void);
 void kasan_restore_multi_shot(bool enabled);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b48c768acc8..3e48668c3e4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -132,7 +132,7 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
-#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 bool kasan_save_enable_multi_shot(void)
 {
-- 
2.34.1


