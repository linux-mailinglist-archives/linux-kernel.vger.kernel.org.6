Return-Path: <linux-kernel+bounces-375430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A49A95DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61023B22D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0A7141987;
	Tue, 22 Oct 2024 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UI5I0Rrq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8313B58F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562365; cv=none; b=HeJj79uNMq1l8p307yWUE4nYLkn5Pu0fX8CjDTBtN5GtysRqUE559fRRUn+doc5K8vN+at/bALSne4eD1JIMxiKpPf2VGb/lFJj5KD2RdSFE1mCoPTMHrROYJQyJ05JvNnnB3wBsdy5vqPkR2hd7nsoh1K7meT04OopNqfOAMfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562365; c=relaxed/simple;
	bh=+Dz1zDTNnnZFiDnTHeWJveL/m1srA4iD5OZPoMtZUFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxlNWOsqxGFFAOvZw04x17U53YwhOYzeDOt4VbwZMT05+gLmNSx6pvKLzGU4piKM5kng6Yimsqx7Ne71DoGsovognZmhj27h1T6iDagP9esxqcBL3UdnSbRw87/q7wlsZxcY7XuyH4e3Ss0kGelvv5x6gy3h/pjVa0j/Rsx7/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UI5I0Rrq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so3571321b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562363; x=1730167163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/iY9Y4RpcnWjc25xyItwxMbRygrVUaVLlWUhwxh2UQ=;
        b=UI5I0RrqGaEWrCGzQYomPYtJqW+YwmoNmfEg7d7d0ZNbOlc0uVQtxM4NBqH+71ndAQ
         D4hHYmD1GM9jQK85jASF7BFv/nDPQvE9td9ObOeHZXijP06TI6Aae5rFG8MRC5c1b938
         1MQN+oiv8rMWTnkVRD/qF5r7zQbhTlSZ2VkmB6q554/A48XVilA2kvnahXYMcf8u53/o
         278gbNhJQKB6QYCUrFj0YOQ4UExgjVD5Z6X1paJb+XdzaIlVPQVGAI86bFPu2Mgk72cK
         sZ3ZgGHbXYbrhZp0mKHEh/BtDNfioNSE1nNyiXim87vXn+OtqzfWzO8BhXhS3MUgXlVp
         tPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562363; x=1730167163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/iY9Y4RpcnWjc25xyItwxMbRygrVUaVLlWUhwxh2UQ=;
        b=bjBS7FJqPsKLMpvxjGd8XmmU5B3VTLXjnZl0wVTmAkMPevMKxDF1su133HI4fQ5Y4o
         ggIb4Ame1eUHxJxp0vQOeTKNXBjdB/kLevtL/OEIJ+iA4cL4ptJ3Ln5WyDSRe6vabVVU
         5aDmsyvbqWxwG6nrXJcXohi6GsY6fkBLhnVREHZhuoaf7CsuFUMJGXqEyuy/m+hZFsXU
         RVYntJ2MERN07GcHHQr0lWSw/tPY8yuaIrgjnOcomZyogZh+JVovjULd6gX/lF92FusI
         aHZQZ+X/QtdSLC6KMzilTKwJTnU6LfkdWHF6Y9kOS/ji0YAeErWuJttZHLvsjLL+Zlxb
         Ls8A==
X-Forwarded-Encrypted: i=1; AJvYcCXBrkAlMROqD3AJ9VcBwG9o9GIU/97wsJ86AQr9TVt55/COXa3QZsPofE8Iv6cVIFxY8nuQbOtvcXBZvio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2E0U5pGggmqOivT3gkgOyKPDzzxmz5HxeUNrA2keB8v8B2gSw
	du2bRl8HpRlygF8sRJKrSOpDASSjm3ByZ7Bz91/80WGMKX6xlokcXYr26H9CixA=
X-Google-Smtp-Source: AGHT+IFB0AudxwQCUfX+B+Q1Nd/kKdWsIXk3CQ+Qmrq1W4iGhp3wWHffFzDvMvs7eDfgOIFmgokQfg==
X-Received: by 2002:a05:6a00:9298:b0:71e:5de:ad6d with SMTP id d2e1a72fcca58-71ea323b91dmr19028480b3a.24.1729562363415;
        Mon, 21 Oct 2024 18:59:23 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:23 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 4/9] kasan: sw_tags: Support tag widths less than 8 bits
Date: Mon, 21 Oct 2024 18:57:12 -0700
Message-ID: <20241022015913.3524425-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241022015913.3524425-1-samuel.holland@sifive.com>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow architectures to override KASAN_TAG_KERNEL in asm/kasan.h. This
is needed on RISC-V, which supports 57-bit virtual addresses and 7-bit
pointer tags. For consistency, move the arm64 MTE definition of
KASAN_TAG_MIN to asm/kasan.h, since it is also architecture-dependent;
RISC-V's equivalent extension is expected to support 7-bit hardware
memory tags.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/arm64/include/asm/kasan.h   |  6 ++++--
 arch/arm64/include/asm/uaccess.h |  1 +
 include/linux/kasan-tags.h       | 13 ++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index e1b57c13f8a4..4ab419df8b93 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -6,8 +6,10 @@
 
 #include <linux/linkage.h>
 #include <asm/memory.h>
-#include <asm/mte-kasan.h>
-#include <asm/pgtable-types.h>
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define KASAN_TAG_MIN			0xF0 /* minimum value for random tags */
+#endif
 
 #define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
 #define arch_kasan_reset_tag(addr)	__tag_reset(addr)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 1aa4ecb73429..8f700a7dd2cd 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -22,6 +22,7 @@
 #include <asm/cpufeature.h>
 #include <asm/mmu.h>
 #include <asm/mte.h>
+#include <asm/mte-kasan.h>
 #include <asm/ptrace.h>
 #include <asm/memory.h>
 #include <asm/extable.h>
diff --git a/include/linux/kasan-tags.h b/include/linux/kasan-tags.h
index 4f85f562512c..e07c896f95d3 100644
--- a/include/linux/kasan-tags.h
+++ b/include/linux/kasan-tags.h
@@ -2,13 +2,16 @@
 #ifndef _LINUX_KASAN_TAGS_H
 #define _LINUX_KASAN_TAGS_H
 
+#include <asm/kasan.h>
+
+#ifndef KASAN_TAG_KERNEL
 #define KASAN_TAG_KERNEL	0xFF /* native kernel pointers tag */
-#define KASAN_TAG_INVALID	0xFE /* inaccessible memory tag */
-#define KASAN_TAG_MAX		0xFD /* maximum value for random tags */
+#endif
+
+#define KASAN_TAG_INVALID	(KASAN_TAG_KERNEL - 1) /* inaccessible memory tag */
+#define KASAN_TAG_MAX		(KASAN_TAG_KERNEL - 2) /* maximum value for random tags */
 
-#ifdef CONFIG_KASAN_HW_TAGS
-#define KASAN_TAG_MIN		0xF0 /* minimum value for random tags */
-#else
+#ifndef KASAN_TAG_MIN
 #define KASAN_TAG_MIN		0x00 /* minimum value for random tags */
 #endif
 
-- 
2.45.1


