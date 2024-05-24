Return-Path: <linux-kernel+bounces-188569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95C8CE3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8381F216EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D88085279;
	Fri, 24 May 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="j5W9IJfz"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A58C85277
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543787; cv=none; b=FD2+Q90+vuvdJ2Ram6zefZXgFvAB0TiypEMdM3YJJrwvqv/fpXKaql23FaJI2JnioBkRvnQD1KicQr+2Ec2nCqsK/GwnbUV4zG6/ACeqvl6IVaN1UdHqsKVvfkPiPN6mcJc0m/Ogyvov5Bm7zTuxsLiPng0IcwFBOVZ9wA/wSxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543787; c=relaxed/simple;
	bh=GkLKm0oj1HpLHw4ns0Tw1JfVm2d5iaPgURXutHnx9EY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgD8taz+iPQeI/hAEh9EBV+u+KSJUyJkSL2Qgv2mPIauN2lWjXsprvX+WWYLYMZbr9d5MnB6NHC6UM27uexOLF8R7Bx0gMj03Kn6oYaEdrmvBC7o/dEVAlGJAQ1A64NCI46p1AAHR8HIqe8pntivq5sXvdIm7nbCRId9hOnG3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=j5W9IJfz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f333c7e702so20206685ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1716543786; x=1717148586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvVFUGPKt/a8n9rluYwNaVtttO9sxZ+ITXVXwBC3J7o=;
        b=j5W9IJfziHGBBRAnS6AMfMVvu0v5rNT6fKIdXYIFR9ntxlKDQHJoiFk5J/6n7j0hxg
         XL997UZ1+J5zIE2UCiuXyAkezTJLv2fpPyRpasJaaztvCfsc6mzSmgthMovFpjBbeq3v
         +WGa0GXpAYD3Zaj0+1hiGVZ8z3vd4QLfP3KO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543786; x=1717148586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvVFUGPKt/a8n9rluYwNaVtttO9sxZ+ITXVXwBC3J7o=;
        b=wjBrSyYt6NjvwoQ+fobC/C6J4AkwX9MM+CTqq25vuBS5egnydW/LWjOIcGhAsGnjXS
         VT63odtCS0ccZut2ZePQkfbu5udESngtV+6TKq902QvvwsOJdVWI9JybtCEjSuUzRZtc
         2/HviEVW01XW7Jp3Q8d2JqjASMuJo+N/eWJosJaGDRGmEMQBRotzuE4utkukdKWWMhjG
         kpBtbLzHYCbaZUT1Fb2mf//NWGb+tfcDvOZNrON/CKF0b5fYWqCLboaDiIpYbArbB6JL
         hfcSkaQ8Wb32sOk1Xyx0aOL1rHVR5mvcgTLvbbqQV8qMeB1gNXEijV2UkDBeMuPPixNX
         29AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSnlrmVEtozaqkr7NLbzb4MV3+Ona3hyqPNK8zO3kfK+/tIDbhSexIOlZlnp9hwtA/eAIRGQjjmPuvbNjqP8+ZzoHGhZ9orjuQ+T15
X-Gm-Message-State: AOJu0Yx9X5soT/Go09IP1P/anx9UTg3uMteCh9WKn83gh9Kcp1qarePG
	4Wu8nH9/ii2z4qRtYThipMGG5mtxJ9L732v4xVuSpO9jGLF5cBSxkEcKHTnT4A4=
X-Google-Smtp-Source: AGHT+IGXGCqoPutDXzuzz6RKBCtI2gGhcCn9izfE255s9KQUodLb37wS+/DcoGph2y40IgqmV2WjrQ==
X-Received: by 2002:a17:902:d492:b0:1f3:2f88:a158 with SMTP id d9443c01a7336-1f44873db5bmr21658705ad.25.1716543785848;
        Fri, 24 May 2024 02:43:05 -0700 (PDT)
Received: from localhost.localdomain ([103.14.255.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7c402asm9873935ad.101.2024.05.24.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:43:05 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix kdump kernel cannot find ACPI RSDP
Date: Fri, 24 May 2024 09:41:49 +0000
Message-Id: <20240524094149.189329-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kexec/kdump must pass acpi_rsdp (physical address of ACPI RSDP table) to the
crash kernel, especially in EFI case, otherwise, the crash kernel fails to
locate ACPI RSDP table. Consequently, ACPI init runs into error, and APIC
mmio read page fault happens, finally crash kernel gets stuck.

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f725813d0cce..39474468dba1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -174,7 +174,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
 #endif
 }
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 static unsigned long acpi_rsdp;
 static int __init setup_acpi_rsdp(char *arg)
 {
@@ -187,7 +187,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
 	acpi_physical_address pa;
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * We may have been provided with an RSDP on the command line,
 	 * but if a malicious user has done so they may be pointing us
-- 
2.34.1


