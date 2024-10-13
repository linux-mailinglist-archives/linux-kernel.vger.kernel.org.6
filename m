Return-Path: <linux-kernel+bounces-362806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166E399B97D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C927E2818FD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707F5145B0B;
	Sun, 13 Oct 2024 13:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/BUkZK4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D721459FD;
	Sun, 13 Oct 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728824549; cv=none; b=JVHsmL1pGwAAMQbYf7mGW20d6ekuKTM+JDP5mL+Xj6ih8UUOMeY1ZVtMqYwt5LOnf6DXlUxf3QCsEzgoRB4ltEQoilOxLFw3BZc1IJUjH7XeR/+LhXHnIpz7V0QjLUoBrAGNsPaO7rONDQzEuUNW4DT3WJdS7boE5xlBTFWjmb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728824549; c=relaxed/simple;
	bh=lDXbQwkkaPxMIXDbVLFhS8GkBnxi0Gxz701uf9q5oR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PV41K+BSggQHJlvIayy5mhYW/oLP5bH121xkEVDMppT1m0CcOQRYEK26Y3sGUqnw8cK7jqJL0ZhK6lfoHoa7uHITgAl17ZZEmUE9uarw+Id1e41zKe/pDKCS3d1kzALLs5DZMa52QytCwpRraERicE9UgpO9lgHZyZDRWGqJoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/BUkZK4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99d1b7b5f5so215858466b.0;
        Sun, 13 Oct 2024 06:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728824545; x=1729429345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqumvoIyJhkt9W5HwjJwb/i/n9g4P9IeX/TAEyTfGvM=;
        b=b/BUkZK48/1tjKmhKbxa3pf2eFusTmWi+/ggr+ycX3LrgBu5Dmez48b6LAEQj7qp6O
         s66bw+GtXZcjypAfcSPMy5aF0rPMybEDAsNs0tkcnT6ZT06096JBAPo033mmv4XRncru
         xNok1Ido4Y1Jo4+zxGKfo+EuOH2TFJuMB7r4sGpqzZJ+S8VL0LftVsHllFFh0UDgcWQ2
         ow2H0dVN8OHtxl7EPxkEM/UJOaZwEDogTpYPO4H0vzntWu3WF/4FCu8hqr4Z+p8/urxS
         eFYqUyfBK72oN6WYhek0G1yiDYbnUtIBzJNTfzCO+Mm4peAOepq456PKiJw8y0X67LYH
         m9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728824545; x=1729429345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqumvoIyJhkt9W5HwjJwb/i/n9g4P9IeX/TAEyTfGvM=;
        b=CsU01Pqup+EIexYF7pZxtpYUjcosfXFSbC7PMgaOLfj2HareUj3O5Nv/WtWbX4gvt9
         0FXO3AZGACQVz2a2uuRhK+CzXPw9zBsg6aL4vkC6biMJUKMcyDbmiY12E41QVXfk25l8
         8Ek5PGaPGa0QkJcnK3N0SFlnPJ7kxWfJmXm+vqNT6JYp8qPYeJ1JrMzPGPmqLk+Scr/J
         1FNpl0jgaqVGNS2sqJa+d2JjP3VhyLC0pgVWjhMChuMYEd9M8KzzTssi519Ujev6GJcE
         bssxs/Rls+t5m2tPEUhF0wNuZ+4TTjdhbO6Fxx9qC2rwcolnBXemHsw1U6neifwuMZL9
         49Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUbSRbx04pAJgztGNlicNhbTxTCXnTdQSpxFamgIw5T4RhEtz5Z+8J+JQXD4pgz7kv0j9CmondNHma5a1ll@vger.kernel.org, AJvYcCUmVcay2c84AsBh+QIGLTWS0HyN6737xnMZecBKHKzHFljBeYYChScKS21GF3ub8jZpcg3OF3RZAN/X@vger.kernel.org, AJvYcCWpfOADCvWzSCA7EBvNyJhnGnsUCMPQmSLvxl76d6LXPr+Bmg9xWnovLhuFk4/50EfL9ifaeltrHnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPrILH2PVYCqKVoeeJ4Cru70nwdg2+cJ5zHvGxdc3q9QvhUeS
	ML2rCDggdHtNvFNHY3bc+ssi8FiQxULHZZh9LRVaDw+/ImX29N8S
X-Google-Smtp-Source: AGHT+IH3hBQZELCO27froLhmQMniGAn0bBg1HgfDg+xB1ADD1RL5C7wQdwmHKKqPnxl1b745khWtcw==
X-Received: by 2002:a17:907:9723:b0:a99:ef41:33db with SMTP id a640c23a62f3a-a99ef4137ebmr460504966b.19.1728824544896;
        Sun, 13 Oct 2024 06:02:24 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0d9de967sm19209666b.139.2024.10.13.06.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 06:02:24 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com
Cc: akpm@linux-foundation.org,
	dvyukov@google.com,
	glider@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryabinin.a.a@gmail.com,
	snovitoll@gmail.com,
	vincenzo.frascino@arm.com,
	elver@google.com,
	corbet@lwn.net,
	alexs@kernel.org,
	siyanteng@loongson.cn,
	2023002089@link.tyut.edu.cn,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] kasan: delete CONFIG_KASAN_MODULE_TEST
Date: Sun, 13 Oct 2024 18:02:11 +0500
Message-Id: <20241013130211.3067196-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013130211.3067196-1-snovitoll@gmail.com>
References: <CA+fCnZdeuNxTmGaYniiRMhS-TtNhiwj_MwW53K73a5Wiui+8RQ@mail.gmail.com>
 <20241013130211.3067196-1-snovitoll@gmail.com>
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
 Documentation/dev-tools/kasan.rst                    | 9 ++-------
 Documentation/translations/zh_CN/dev-tools/kasan.rst | 6 +-----
 Documentation/translations/zh_TW/dev-tools/kasan.rst | 6 +-----
 lib/Kconfig.kasan                                    | 7 -------
 mm/kasan/kasan.h                                     | 2 +-
 mm/kasan/report.c                                    | 2 +-
 6 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index d7de44f5339..52fdd6b5ef6 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -511,17 +511,12 @@ Tests
 ~~~~~
 
 There are KASAN tests that allow verifying that KASAN works and can detect
-certain types of memory corruptions. The tests consist of two parts:
+certain types of memory corruptions.
 
-1. Tests that are integrated with the KUnit Test Framework. Enabled with
+Tests that are integrated with the KUnit Test Framework. Enabled with
 ``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
 automatically in a few different ways; see the instructions below.
 
-2. Tests that are currently incompatible with KUnit. Enabled with
-``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
-only be verified manually by loading the kernel module and inspecting the
-kernel log for KASAN reports.
-
 Each KUnit-compatible KASAN test prints one of multiple KASAN reports if an
 error is detected. Then the test prints its number and status.
 
diff --git a/Documentation/translations/zh_CN/dev-tools/kasan.rst b/Documentation/translations/zh_CN/dev-tools/kasan.rst
index 4491ad2830e..f968d262be1 100644
--- a/Documentation/translations/zh_CN/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_CN/dev-tools/kasan.rst
@@ -422,14 +422,10 @@ KASAN连接到vmap基础架构以懒清理未使用的影子内存。
 ~~~~
 
 有一些KASAN测试可以验证KASAN是否正常工作并可以检测某些类型的内存损坏。
-测试由两部分组成:
 
-1. 与KUnit测试框架集成的测试。使用 ``CONFIG_KASAN_KUNIT_TEST`` 启用。
+与KUnit测试框架集成的测试。使用 ``CONFIG_KASAN_KUNIT_TEST`` 启用。
 这些测试可以通过几种不同的方式自动运行和部分验证；请参阅下面的说明。
 
-2. 与KUnit不兼容的测试。使用 ``CONFIG_KASAN_MODULE_TEST`` 启用并且只能作为模块
-运行。这些测试只能通过加载内核模块并检查内核日志以获取KASAN报告来手动验证。
-
 如果检测到错误，每个KUnit兼容的KASAN测试都会打印多个KASAN报告之一，然后测试打印
 其编号和状态。
 
diff --git a/Documentation/translations/zh_TW/dev-tools/kasan.rst b/Documentation/translations/zh_TW/dev-tools/kasan.rst
index ed342e67d8e..19457860486 100644
--- a/Documentation/translations/zh_TW/dev-tools/kasan.rst
+++ b/Documentation/translations/zh_TW/dev-tools/kasan.rst
@@ -404,14 +404,10 @@ KASAN連接到vmap基礎架構以懶清理未使用的影子內存。
 ~~~~
 
 有一些KASAN測試可以驗證KASAN是否正常工作並可以檢測某些類型的內存損壞。
-測試由兩部分組成:
 
-1. 與KUnit測試框架集成的測試。使用 ``CONFIG_KASAN_KUNIT_TEST`` 啓用。
+與KUnit測試框架集成的測試。使用 ``CONFIG_KASAN_KUNIT_TEST`` 啓用。
 這些測試可以通過幾種不同的方式自動運行和部分驗證；請參閱下面的說明。
 
-2. 與KUnit不兼容的測試。使用 ``CONFIG_KASAN_MODULE_TEST`` 啓用並且只能作爲模塊
-運行。這些測試只能通過加載內核模塊並檢查內核日誌以獲取KASAN報告來手動驗證。
-
 如果檢測到錯誤，每個KUnit兼容的KASAN測試都會打印多個KASAN報告之一，然後測試打印
 其編號和狀態。
 
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


