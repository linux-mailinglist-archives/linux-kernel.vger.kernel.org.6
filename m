Return-Path: <linux-kernel+bounces-291218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20462955F26
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 23:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC0DB20D5F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 21:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D11509B3;
	Sun, 18 Aug 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAvKtK+a"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401C433C1
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724014970; cv=none; b=cCpbpdAb0bU+6M/iwsQwakuRziw+jN92dJZItomVC/jmt2oyVWqpWY309/+BGbBcLw1/ubCACMWapbNBBT9zp1cYzn7TCZxOxUnG12HWvO0TUkaKX1xfqy+gcsCa7fpP/4GAAAd8OmWaEIFBPnThKW7z4MJP3AE7c1GOZnUbwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724014970; c=relaxed/simple;
	bh=7sixzc+CtJw9qOgbJh513ylzis5lnaBhZOMM+YKw0mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T9p6Sjtd2U57hasJEgp/fLybkJIrmU7QHqzOxxmsh95m52wxToXQny6K+4aI5snC17aw9Yd1xTHddWZwDIkrUuk9/e2nsRfsfxuuBDZcViG9p7FDezFXiajYXvj8FIUJZTS3J/N0H6BvIiE+Wc6N2SvtDCa116hM7FSF+Ka8So8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAvKtK+a; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83869373b6so356088666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724014966; x=1724619766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33O1tYB6ZBAM92pkyxt8k+zeN401oztTnBh5GARjIPw=;
        b=VAvKtK+aZtkDxjL3Dqeoq9ebQq4TG9Amer4tX8BOetHB2w63kojMB41YTt45ODB2IF
         BSM3+EXkDZQh/aRj4MWPXhLINe6uLVRPwyUVw9TNUyPGLqorlhFg5tHmiv/dALGSgdE3
         D04ejK+E82TjR7bBIfKqixNM6eBxrBE5u7mkkZsAyu+OrBUoDID2Qj2lLWjcHMyTN7Wt
         o82nrTEojkA2LK1LfnZHTrjbKTaM4A8pPLWH5XJdb+OlKfF4dRuXHHCVAl1DSguKkqPi
         TbHWJ5CYaV/6fobYUMiyfcAcNehWEoA9EPX0YQzGBcyH9F5cNZD3+uxOMmWdt4IUFg59
         k/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724014966; x=1724619766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33O1tYB6ZBAM92pkyxt8k+zeN401oztTnBh5GARjIPw=;
        b=PoprN//Ut47+Zr3AiNoU5FHWaQ/RZcTAVKsgYK4YwxIQz4fUUPiyBJ/ayRsbS/UR4h
         UUzJg/QgHCI30Ual4Z2p36iVgAwTsV+UxZr6hnwWIluChHzTik9Q6HdyaDLtVnRrymwP
         GEEyeCakLCEg7dW23ONxXSveFziAUvW6uUC8sDJu6uoSTIvOa0WKjJJ2hpwhVZ5gc8me
         MzrY/xFGuSFGHNRSRvYtgNDrjsPcrEt2Tr2fTeqCBRKvfZwHqZE/Qp8dEIg9wJytTxtz
         N5oyfWJ0gk1eHFK3lhJbIyqR+eB6+E4T0LjIlP29S/wmOb0yT8MDuEet4FVkLd326K2N
         UglQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLpqZL2sELXhFLG80S0JldOpzkmkIFjiHSk3E1ggYMXp9K4pfz+X0mE4dP/oIc5WkEd4036os4FbxM8CtLjO9Gtv/QQMPfvZ0tgPrm
X-Gm-Message-State: AOJu0Ywd9Hj7EkxVHXHQQBz/ZwiXVCihGf22TRILn6um5wln3V9aYaW+
	kFXXViuO552XQYfJEyM8lrObYgrzlTkV7MFQX1WWGaaoyP+nnQEF
X-Google-Smtp-Source: AGHT+IF37pvsOxU6lEpKmW36ULokTE+MkxkHNYwoC/m53vY0l2IHld/cLjp0yLPclo9BZHAmqKxmKQ==
X-Received: by 2002:a17:907:3fa9:b0:a6f:4804:d41a with SMTP id a640c23a62f3a-a8392a03a86mr642953766b.55.1724014965736;
        Sun, 18 Aug 2024 14:02:45 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd5esm552895466b.78.2024.08.18.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 14:02:45 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/2] err.h: Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() macros
Date: Sun, 18 Aug 2024 23:01:51 +0200
Message-ID: <20240818210235.33481-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ERR_PTR_PCPU(), PTR_ERR_PCPU() and IS_ERR_PCPU() macros that
operate on pointers in the percpu address space.

These macros remove the need for (__force void *) function
argument casts (to avoid sparse -Wcast-from-as warnings).

The patch will also avoid future build errors due to pointer address
space mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: Implement as macros to avoid powerpc build failure
---
 include/linux/err.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index b5d9bb2a2349..a4dacd745fcf 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -41,6 +41,9 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/* Return the pointer in the percpu address space. */
+#define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
+
 /**
  * PTR_ERR - Extract the error code from an error pointer.
  * @ptr: An error pointer.
@@ -51,6 +54,9 @@ static inline long __must_check PTR_ERR(__force const void *ptr)
 	return (long) ptr;
 }
 
+/* Read an error pointer from the percpu address space. */
+#define PTR_ERR_PCPU(ptr) (PTR_ERR((const void *)(__force const unsigned long)(ptr)))
+
 /**
  * IS_ERR - Detect an error pointer.
  * @ptr: The pointer to check.
@@ -61,6 +67,9 @@ static inline bool __must_check IS_ERR(__force const void *ptr)
 	return IS_ERR_VALUE((unsigned long)ptr);
 }
 
+/* Read an error pointer from the percpu address space. */
+#define IS_ERR_PCPU(ptr) (IS_ERR((const void *)(__force const unsigned long)(ptr)))
+
 /**
  * IS_ERR_OR_NULL - Detect an error pointer or a null pointer.
  * @ptr: The pointer to check.
-- 
2.42.0


