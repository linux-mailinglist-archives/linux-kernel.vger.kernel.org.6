Return-Path: <linux-kernel+bounces-368104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC19A0B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417571F26B16
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50C20C006;
	Wed, 16 Oct 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8fmnS7X"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496B1209F48;
	Wed, 16 Oct 2024 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084706; cv=none; b=lmyHGwNXwoU3v1JqHqTTdahTb8+s6Y7Orye24G/RBCC/T48HzM61XmCZKJbFcdi1yz/U+E6/NTG3G3pXQWz+cZ85fTZJkDV3HLMjLLXGYDmYF/wiyf6amebv4mAsHcDgxpfC0fzrwlhiuUo6cgkuDVl/2AEoS3kcpHA0PyO4Cg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084706; c=relaxed/simple;
	bh=j4lwfqIfhg3o9c/qxDv63TOPSlOrzp7Cd7ov8oxJkXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNiduwbD943yAafM/f8aFHEeo3QLLewLLjllpYebKgGk3V5o2pDYeljdbqNHrQf4cQO3S9PQ0OKrqsJj7PGdoQ0lFf5xRddjI9uR1T9pldLVV0rnmNRtsnpwMZt/6cClPCxzigf7TgdILHRBSu7ehufLz5IAqM6CT7wB22tLOdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8fmnS7X; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so4287940f8f.0;
        Wed, 16 Oct 2024 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084702; x=1729689502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGMf0QveJLuqNVGuhCQVRHmO+zBayTHS2lF5VIrEUbY=;
        b=R8fmnS7XknkpD//IQLFeW5MACYzmuiF5nOWxid4BDY3YR3FEVKqDf0YJe0nYxaHgL9
         YjwdbaU/WilKdv0oDPrnuKFHoxyiT188Q5RguePMqGqEqeR409LEvLPCmsMQLpKeN5a3
         LniW1FdbwIedKJdbdnqKRFl3bueGy8fpudZwHwLYMkJ9hWM+uTC5yYe7gTWdd0dLVC1x
         4fRGisBDpp8Ql3//W3jlZu0n7CtB7aDYO9xE6gO66e7fs17JroSYvscWks8gHyv64+gr
         ao7ZD6qWZvtrYWdzo7kEjdJJ43PMIW7NQMM5yTx6ny+MCtpIXOj3Rpw6om46uVuDsf+w
         DvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084702; x=1729689502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGMf0QveJLuqNVGuhCQVRHmO+zBayTHS2lF5VIrEUbY=;
        b=PzMIgx2UzYePa+++HBSyRYGAe5Nt79FhM8/gIoer269h6UDMU5quqhdXKzo3gPmVqy
         +aBISR7gPs+L9TMdECt4MH6V3U1dNPLbYtwkv970BRboYRCFXg59ooQnm78N7kTps20N
         jd6D7OnbFkMQ6iWDe25Q3Arsi/DQMt7/s1pd6RYJtrzrnbSmQnjOl6H9U2a2lcmCJApm
         ql+F8LREnqlj4a2t0bDMDdL9b46n6bmMq5ZjnjM8qMl5uPTB85C8ENZz6wqKQlNbs0e2
         lDNt6Chbf9FVAfUKTLEQDcBHm6Aatr2mVbfBEobxE8lcMfJFbQ4OOz46oC+hd3szzPC+
         X8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJlhvu4nvnvMe38Fic1cXMUKJm0SrJBiDgEdYMODjqtlyZVHGf1dWb3PdY9SX7BB5TVdVqmNbu7zw=@vger.kernel.org, AJvYcCWq7J5CwYyn9Sievr/dH7HhwkFd4cLzTQfRR2/U6Sm80w+hxiCkWnefZtxPCmJkXuMP4gmypWsbc/Y+@vger.kernel.org, AJvYcCX4K78JgRKtcbhIt0GNLLhZrZMxsQ2xiEeJIQMopf08dgeQ//oPKGi4PKOc8ZoyU2AuQ5xlAtTCxmA5yLFS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xDRyck8vxKagVZjNNfhvPvO0OOgHwgj66XibZHnTc2+UkquK
	3rXKoi2hbim2kLwJW4pk2FDBWsi3BL6LFxFF0K5UfNURjwr1Gw5m
X-Google-Smtp-Source: AGHT+IEnqE33zAEZ4Osvb5YV0WmK6TiqgW5ppvcNvuX+PIESYEVsFYkFYZLCq1hdV0OqDyWWM/vbiw==
X-Received: by 2002:a5d:6109:0:b0:37d:3999:7b4 with SMTP id ffacd0b85a97d-37d5519cbb6mr11646512f8f.17.1729084702303;
        Wed, 16 Oct 2024 06:18:22 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f5698aesm49612825e9.11.2024.10.16.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:18:21 -0700 (PDT)
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
Subject: [PATCH v4 3/3] kasan: delete CONFIG_KASAN_MODULE_TEST
Date: Wed, 16 Oct 2024 18:18:02 +0500
Message-Id: <20241016131802.3115788-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016131802.3115788-1-snovitoll@gmail.com>
References: <CA+fCnZf8YRH=gkmwU8enMLnGi7hHfVP4DSE2TLrmmVsHT10wRQ@mail.gmail.com>
 <20241016131802.3115788-1-snovitoll@gmail.com>
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
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


