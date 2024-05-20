Return-Path: <linux-kernel+bounces-183479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37518C99A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C19BB21B89
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA01C2A3;
	Mon, 20 May 2024 08:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiHK+ZQQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C241BC3F
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716192598; cv=none; b=uVi4TM8jyNBCq3qjNpQe3CA0tQx2sNC93pRH6Xf9XJL05XbboUvRHPPUr9EtZje9qRcZhy414PBCgpKnTg7NAUPR3z9FVXNmSG6IEfnXqgvohVIR9eh2fPvsEZFtfAtCENjulKCgsvqdmWpAQAsCa6I8VNwsbFU2DIFWTYuiwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716192598; c=relaxed/simple;
	bh=z8NthXkMFgdIbl0krCEF+Y+L/RbyZV7sLRHmjvGb+Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tL94qQW7hZfhnsACs2B7PhLFtU4mPqIGNoSit+gOLRDJ533jGaXsVt719LoPclEUWlX/xxynth+XwQVxzOted3lldGGsrL4QboJF+No7Wu2+YQDlycsjf1IKieEFASsCpK3Y8zQXon/F5/yhOp2PWiwXcKaufQftTJh4dA1oPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiHK+ZQQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354c5b7fafaso812946f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716192594; x=1716797394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsL9bQ0y9pX/2lyTMYaTOUIKY6XWDRYJxwuWOVCpsyw=;
        b=RiHK+ZQQiygHT9xW9FGf+q90GHAb1qdiO/fYScSWskCPIRSrdelpaXijnZFQC0oE7g
         8e9HB352o6jFDMkcGyMr/+XtepLixlJ002GyltiLwhbARWu4wrgtMpTyQ2SC4pSAgcLt
         r45OT9tLzE+r71w/nq9WKC3bOv2KehfF0VINxevepu/Oktq2092/VSQZeSDDPPqUZ0zz
         28mH/QmL3tc9k69RRRfaqb5gK9aeaKKQiD0E7MmyyzJwHUv4I4rq9664/ZcUtGjRyRJ6
         k/Vlq5CclgKkcZrLhQBKlFr3qiwL5fBjxBRhCYJ/mo72DNpOSPE51gXajkbwcpCeuTPd
         AjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716192594; x=1716797394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsL9bQ0y9pX/2lyTMYaTOUIKY6XWDRYJxwuWOVCpsyw=;
        b=giw3av/U6PbZxPGh71SdBEziITf17XQfxsSdE4gtgwKbXreKI0P3q2QyMwciioUSyO
         GAJeGjWOdUF65eRDDuv3UsK7BOEfwiFTQtXwECxHtKSgxecuSZ3lY3TcDEYHqkh8CDCi
         lwBkuHb8O+wKXeCBDj5OPAW4HoaYVx8eyT1wNI4nNgvlL1hJbNyXfiqGrejby2954c7r
         8pgpgq5UvJfDiwtNdrEtql2uOn3W5s+ct91DXT/wxwvp7rVKm3no3bNaIRHfFVEjYTJ+
         AmCT2ehGppFhSJCBvpCQuohFszGaQK1fnhlaaeIpUmQMxRhOwsPDXCZxPmA2SPskrlYr
         +78A==
X-Gm-Message-State: AOJu0YwlOz1GUSSbPElOB6PvkqfVNleqtOqz1J3LmfR/jM8e1cUqQlXK
	jsumwrMjlXYDca+KZ17UedM9x6/OOlHY2VvmFUij1gu0mv0j3qIDEyzwA265
X-Google-Smtp-Source: AGHT+IHW68v5wA0Iacn17DpWa1mXifpjKOYqaoESiIqJA6aj55de3EZNfvM+dJCkOIq8dKeAjiFVnQ==
X-Received: by 2002:a05:6000:114c:b0:34d:b549:9465 with SMTP id ffacd0b85a97d-3504a737635mr20536526f8f.32.1716192594289;
        Mon, 20 May 2024 01:09:54 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3518d817ee2sm24784776f8f.2.2024.05.20.01.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:09:53 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/percpu: Move some percpu accessors around to reduce ifdeffery
Date: Mon, 20 May 2024 10:09:25 +0200
Message-ID: <20240520080951.121049-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520080951.121049-1-ubizjak@gmail.com>
References: <20240520080951.121049-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move some percpu accessors around, mainly to reduce ifdeffery
and improve readabilty by following dependencies between
accessors.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/percpu.h | 40 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 39762fcfe328..0f0d8973f8df 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -445,17 +445,6 @@ do {									\
 #define this_cpu_try_cmpxchg128(pcp, ovalp, nval)	percpu_try_cmpxchg128_op(16, volatile, pcp, ovalp, nval)
 #endif
 
-/*
- * this_cpu_read() makes gcc load the percpu variable every time it is
- * accessed while this_cpu_read_stable() allows the value to be cached.
- * this_cpu_read_stable() is more efficient and can be used if its value
- * is guaranteed to be valid across cpus.  The current users include
- * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
- * actually per-thread variables implemented as per-CPU variables and
- * thus stable for the duration of the respective task.
- */
-#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
-
 #define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
 #define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
 #define raw_cpu_read_4(pcp)		__raw_cpu_read(4, , pcp)
@@ -470,16 +459,6 @@ do {									\
 #define this_cpu_write_2(pcp, val)	__raw_cpu_write(2, volatile, pcp, val)
 #define this_cpu_write_4(pcp, val)	__raw_cpu_write(4, volatile, pcp, val)
 
-#ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
-#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
-
-#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
-#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
-#endif
-
-#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
-
 #define this_cpu_read_stable_1(pcp)	__raw_cpu_read_stable(1, pcp)
 #define this_cpu_read_stable_2(pcp)	__raw_cpu_read_stable(2, pcp)
 #define this_cpu_read_stable_4(pcp)	__raw_cpu_read_stable(4, pcp)
@@ -535,6 +514,12 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
+
+#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
+
 #define this_cpu_read_stable_8(pcp)	__raw_cpu_read_stable(8, pcp)
 
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
@@ -561,6 +546,19 @@ do {									\
 #define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
 #endif
 
+#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
+
+/*
+ * this_cpu_read() makes gcc load the percpu variable every time it is
+ * accessed while this_cpu_read_stable() allows the value to be cached.
+ * this_cpu_read_stable() is more efficient and can be used if its value
+ * is guaranteed to be valid across cpus.  The current users include
+ * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * actually per-thread variables implemented as per-CPU variables and
+ * thus stable for the duration of the respective task.
+ */
+#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
+
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
 ({									\
 	unsigned long __percpu *addr__ =				\
-- 
2.45.1


