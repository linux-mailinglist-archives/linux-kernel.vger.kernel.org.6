Return-Path: <linux-kernel+bounces-352169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B770991B31
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 00:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17586B21F3D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048C16087B;
	Sat,  5 Oct 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYBqpI1a"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F338DFC
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728166948; cv=none; b=NWDp1HMQZ6WKAMv6hGM5xQ8RttAn1JEa83I9ok3lOPTXTPIUQIky7OHC+JOp3KKvxTBzt70SjIgeBGNzdOvWe5fs34tp3d1KM9PY0Efv/rDICgyeiFqy8eqHoXYoZoex9TK+dVQpaLqb0dWcwab6PIqgFAIJi640hqyMLObux8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728166948; c=relaxed/simple;
	bh=IDv3dH4aktZ/qHou9bz6b0MbbSSPj32h0Z4aAaDkjfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpIwjRKVlyK2kjx7kMgRffjY0R1pDzLonCs2SkxShEP0f0sHlscnPlXH/spsIKeFVx6WLCxu0+GvL52uaDrpWlv+J8YeJJRi/6XS+D2VA34rOdYj9JMMD7XJPZYt6mbpjMtHCyU9X2ckDqVTL/K7Wpjk3YT11DKDwp0cSB7fYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYBqpI1a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71df0dbee46so674430b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 15:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728166946; x=1728771746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hI8xu876z+ZEOUnI3E+caSCk9ZZTgdVJhOkCrXwPsfU=;
        b=CYBqpI1adwZk8eiF9vxofWVJDBJxo0iP9G6z0ptlRpqVNB8G+RORJTZ9hq9dYO7d6C
         1607nSUqNDZsmDJs1YMv5dyoXUf5+y/COXEwPam0TkYqlI8r5b4RmBoNVYC8fue6ljfK
         N07rZSXeMiap8r8h63NcCpGyjfjtGRxAVXMGNbuuXi7ne/iO/oqBf35AQFIuaoJ90Zrs
         ww/pXUh45MZzrAnQ94NdRP1uDYuZPbXzdbi3+ZKt3jsK+2INs2mxBhKDnv3E4/O+y7x2
         CGWyn9ZK29r+RfWkIMsc2wxfgWBZLkwmVWKKLRdDioNQenGacGHgSChYiUnQ0J0bho8m
         nRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728166946; x=1728771746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI8xu876z+ZEOUnI3E+caSCk9ZZTgdVJhOkCrXwPsfU=;
        b=G9x+w2fOL/cKR2BpVRgNawFEnC1VJr9Jg/0BYCPfsSa02O42BmLj6YNdBG+TgfX0z1
         ERqkft7dGCD96XGBbJiejUI+tB3rpLrSQ7ECCweH7SjgKuTUAI8uX0BK0z1NCWehY9r/
         l40L7kQjFxG8zTw1fZTlGq1a8BHh9YQSMxYfSt3jZiMmvHlVIkqkSylVrs+TmnhIrSBO
         BKMrrSAgl5fe223w511N741wGuwYFQ4E4nl3IHKKD2Rnjs8bbXHP6WkV0qglH70MD2sU
         9gn8Mng/g2gUAPZ8wGDPKX4hPXN7RPFlL7I8JvgmlWZD4zor1seRXDZKzUZuc3orgJWN
         kdPw==
X-Forwarded-Encrypted: i=1; AJvYcCWPim0RZNZsPXvePXo2ntfW/Zdmd6fpfmQIkPsQ+kpzJZN5CUa3EgOWKyG7Op+9Qhkb4F5ts/UzCMwDKkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0LLitjY5gBvBmUBL9Q7+FbQyeaDZNiRm9/1fYnRg6Zw+UIUvu
	NZxh/ozmRHWupXe6SlOioJYV+d5zIPLklj/dpvuy6NYj+/IDqJcwrrw4yQ==
X-Google-Smtp-Source: AGHT+IFbtlotV+i3BviKivTVwkjxlQBTYaew0eyRNp5pBVrLSoHN3fXUbNQZsf+SMkrO87Pi4THlyw==
X-Received: by 2002:a05:6a00:4fd3:b0:713:e3f9:b58e with SMTP id d2e1a72fcca58-71de2445359mr12218014b3a.17.1728166946586;
        Sat, 05 Oct 2024 15:22:26 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4539esm1913807b3a.131.2024.10.05.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 15:22:26 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	luis.hernandez093@gmail.com,
	skhan@linuxfoundation.org
Cc: davidgow@google.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] lib/Kconfig.debug: Move int_pow test option to runtime testing section
Date: Sun,  6 Oct 2024 06:22:21 +0800
Message-Id: <20241005222221.2154393-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing 'make menuconfig' with KUNIT enabled, the int_pow test
option appears on the first page of the main menu instead of under the
runtime testing section. Relocate the int_pow test configuration to the
appropriate runtime testing submenu, ensuring a more organized and
logical structure in the menu configuration.

Fixes: 7fcc9b53216c ("lib/math: Add int_pow test suite")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/Kconfig.debug | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..856bc9f9c069 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2993,6 +2993,22 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config INT_POW_TEST
+	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the int_pow function,
+	  which performs integer exponentiation. The test suite is designed to
+	  verify that the implementation of int_pow correctly computes the power
+	  of a given base raised to a given exponent.
+
+	  Enabling this option will include tests that check various scenarios
+	  and edge cases to ensure the accuracy and reliability of the exponentiation
+	  function.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
@@ -3088,19 +3104,3 @@ config RUST_KERNEL_DOCTESTS
 endmenu # "Rust"
 
 endmenu # Kernel hacking
-
-config INT_POW_TEST
-	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-	help
-	  This option enables the KUnit test suite for the int_pow function,
-	  which performs integer exponentiation. The test suite is designed to
-	  verify that the implementation of int_pow correctly computes the power
-	  of a given base raised to a given exponent.
-
-	  Enabling this option will include tests that check various scenarios
-	  and edge cases to ensure the accuracy and reliability of the exponentiation
-	  function.
-
-	  If unsure, say N
-- 
2.34.1


