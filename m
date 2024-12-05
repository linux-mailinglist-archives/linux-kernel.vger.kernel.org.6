Return-Path: <linux-kernel+bounces-432969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD99E5283
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820E1165979
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D641D3566;
	Thu,  5 Dec 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PXVINP7Q"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665B61D8A10
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395065; cv=none; b=De1Jq5UQ2059kv5+qYPBLwsm7bdGw+6TbTCbJyfBFWKP+mernff9w3n2Y1/5nYqVKwyOdKRLmuTnpynrDikNjAy+pAK2Jcn7n6bkv3WAqqv44F3TIZebIo44z3bxaJi6igVS/4c9IIZYpR73cK+Vox+btNc7k86HI+1ukihxWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395065; c=relaxed/simple;
	bh=VRSm+emlI6QfoAPRbJgRjmp46JAY59uZbRFEaBrLwsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lyAxWDG1WfBRi0i0NguzgIH/2aRlCsW5zJ6Ir1EFPv+dMk6CTfFDrgwpuIKkmVl4q/6wjx7ayrOSJcQHlx7p0A+BQzW0dqsSCxhKFVdzOmjSKkMu5aGvBxOYLHt+2Ai3owynqzYm+KibcTKFuIt1/0jruubHIY8El84sGgfe+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PXVINP7Q; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso622037b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395063; x=1733999863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWkBqx6Qlg0tee9JR/yzxG5KwDs2r7O63kRKnpevvpY=;
        b=PXVINP7Qut5lCZhkp2VINt6enIOWgvXal2F9nHzo4vw3BGZTN5nzjlHTB3/6TLQqEX
         q413nYYF8pWXIkLBKeOHemN3mjn7tsUH1/6lHU49NRjwDfGopkX14TiRK7omHgLM2aHr
         5sW2lAO9h5itmGudrmCjv+K0u/lVTX4b4ksvUKU4CxY0b2LLDU0oJwt/Uv13SxCzu7t+
         8wbtvSy8BiKZoe3ZteS1KhTpoJKxGXM7Nmnwk+TdzIkmVZHYzaU24JjNG2YjiC2/9vYZ
         sXqz1EDqod2zRl/Oj+Tqk+96Djibuelbg2mrF0i7LmTBWeIxlWUU1UnoBb+9YgSR/HD3
         fy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395063; x=1733999863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWkBqx6Qlg0tee9JR/yzxG5KwDs2r7O63kRKnpevvpY=;
        b=FtjN+ivlnj6ofey1WP5B5KKhMl5t2c54REeM3UexyRZf0nV1is+E6iUaAqqQh0Qnyx
         U6fzHeUm1o8/Lu5uq2zTOaRqTkUM25aCXBqhyiRM5s5fokmHfK1K+a0sgQOGR/oLaooi
         2//qAiiOBA8znscEDPjReGDw6MWEPwnUhtHVX0EWBcapFxs4KHFRvuEWDH696VySnG2/
         wD57cjNQXv/+JPBKSo5CC1qOSlS6/rPlLoTFAvIpRaGsPaXyZmrKhev4EybXS09tirOL
         LmRpxosa5lrQnrTNt0eZVQ+ftLI/hcITTn7cxJDHAgIC6am/xTrBM6aTATirebpTnI2I
         Fpuw==
X-Forwarded-Encrypted: i=1; AJvYcCWfsCR4zbNKLbuconWnFsiWAKAttg7NxNzYEaHlS5OqdmTrzEYlgAAzeH9xsmvKvBwi7N38m94PTlzsP8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63rY9KJ4WhnYx7b+neh5eqGouwrgjC5Y/1AgC3qxPHg0MvX2+
	I38PG6TXoVNJ2xK9IsylK1W7Ixc4FBCCId2Jm7eSQisAKKWXiGau9tUXLLFxJ0o=
X-Gm-Gg: ASbGncsTfKgjyP+kN61EPsHFRxpmejqWo5H295sClvZkRDr2SvLJxa1k4Ac1/kAVmSt
	+GHfDWK1gfZZ9aHdJGOv+sTwpYwTw3URb771HgBMfNtKDrgBVU9kv5f84O3ssfDlMJWNbuNVTmA
	+XvTzjvUuAWWN7T1tGo53rP/AAio6navOGAlXTMbtIdF63UKVgF2WJHYyfCMFtu0VoG9blhU2+9
	fyIbaSSUUw8GkA+Dyk7V5dfe1tE+sCJwB+MOcs7fxzmWIpqQJFEMyJ9eHDtQMvALbJFm+/8YL2M
	/vMdks/SM7KE7Xn4WzAtUHA0tNQS0tul
X-Google-Smtp-Source: AGHT+IEvp+5QW/iv1/V1tpDVHfeo0s8LNYsKCxdjWx85NP0irBg++mJLHUVM5oudhxdOyXEvXSVVbg==
X-Received: by 2002:a17:902:e00c:b0:215:7136:f7e3 with SMTP id d9443c01a7336-215f3ce4f83mr33803375ad.19.1733395062764;
        Thu, 05 Dec 2024 02:37:42 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.37.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:37:42 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 01/21] riscv: mm: Distinguish hardware base page and software base page
Date: Thu,  5 Dec 2024 18:37:09 +0800
Message-Id: <20241205103729.14798-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The key idea to implement larger base page based on MMU that only
supports 4K page is to decouple the MMU page from the software page in
view of kernel mm. In contrary to software page, we denote the MMU page
as hardware page.

To decouple these two kinds of pages, we should manage, allocate and map
memory at a granularity of software page, which is exactly what existing
mm code does. The page table operations, however, should configure page
table entries at a granularity of hardware page, which is the
responsibility of arch code.

This commit introduces the concept of hardware base page for RISCV.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/Kconfig                    | 10 ++++++++++
 arch/riscv/include/asm/page.h         |  7 +++++++
 arch/riscv/include/asm/pgtable-32.h   |  5 +++--
 arch/riscv/include/asm/pgtable-64.h   |  5 +++--
 arch/riscv/include/asm/pgtable-bits.h |  3 ++-
 arch/riscv/include/asm/pgtable.h      |  1 +
 6 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa8f2da87a0a..2c0cb175a92a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -289,6 +289,16 @@ config PAGE_OFFSET
 	default 0xc0000000 if 32BIT
 	default 0xff60000000000000 if 64BIT
 
+config RISCV_HW_PAGE_SHIFT
+	int
+	default 12
+
+config RISCV_USE_SW_PAGE
+	bool
+	depends on 64BIT
+	depends on RISCV_HW_PAGE_SHIFT != PAGE_SHIFT
+	default n
+
 config KASAN_SHADOW_OFFSET
 	hex
 	depends on KASAN_GENERIC
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 32d308a3355f..7c581a3e057b 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -12,6 +12,10 @@
 #include <linux/pfn.h>
 #include <linux/const.h>
 
+#define HW_PAGE_SHIFT	CONFIG_RISCV_HW_PAGE_SHIFT
+#define HW_PAGE_SIZE	(_AC(1, UL) << HW_PAGE_SHIFT)
+#define HW_PAGE_MASK	(~(HW_PAGE_SIZE - 1))
+
 #define PAGE_SHIFT	CONFIG_PAGE_SHIFT
 #define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE - 1))
@@ -185,6 +189,9 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define __pa(x)		__virt_to_phys((unsigned long)(x))
 #define __va(x)		((void *)__pa_to_va_nodebug((phys_addr_t)(x)))
 
+#define pfn_to_hwpfn(pfn)	(pfn << (PAGE_SHIFT - HW_PAGE_SHIFT))
+#define hwpfn_to_pfn(hwpfn)	(hwpfn >> (PAGE_SHIFT - HW_PAGE_SHIFT))
+
 #define phys_to_pfn(phys)	(PFN_DOWN(phys))
 #define pfn_to_phys(pfn)	(PFN_PHYS(pfn))
 
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index 00f3369570a8..159a668c3dd8 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -20,9 +20,10 @@
 /*
  * rv32 PTE format:
  * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *       PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *     HW_PFN     reserved for SW   D   A   G   U   X   W   R   V
  */
-#define _PAGE_PFN_MASK  GENMASK(31, 10)
+#define _PAGE_HW_PFN_MASK	GENMASK(31, 10)
+#define _PAGE_PFN_MASK		GENMASK(31, (10 + PAGE_SHIFT - HW_PAGE_SHIFT))
 
 #define _PAGE_NOCACHE		0
 #define _PAGE_IO		0
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd99ab8d..963aa4be9eed 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -72,9 +72,10 @@ typedef struct {
 /*
  * rv64 PTE format:
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
- *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
+ *   N      MT     RSV    HW_PFN   reserved for SW   D   A   G   U   X   W   R   V
  */
-#define _PAGE_PFN_MASK  GENMASK(53, 10)
+#define _PAGE_HW_PFN_MASK	GENMASK(53, 10)
+#define _PAGE_PFN_MASK		GENMASK(53, (10 + PAGE_SHIFT - HW_PAGE_SHIFT))
 
 /*
  * [63] Svnapot definitions:
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index a8f5205cea54..e5bb6a805505 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -31,7 +31,8 @@
 /* Used for swap PTEs only. */
 #define _PAGE_SWP_EXCLUSIVE _PAGE_ACCESSED
 
-#define _PAGE_PFN_SHIFT 10
+#define _PAGE_HWPFN_SHIFT	10
+#define _PAGE_PFN_SHIFT		(_PAGE_HWPFN_SHIFT + (PAGE_SHIFT - HW_PAGE_SHIFT))
 
 /*
  * when all of R/W/X are zero, the PTE is a pointer to the next level
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e79f15293492..9d6d0ff86c76 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -114,6 +114,7 @@
 #include <linux/mm_types.h>
 #include <asm/compat.h>
 
+#define __page_val_to_hwpfn(_val)  (((_val) & _PAGE_HW_PFN_MASK) >> _PAGE_HWPFN_SHIFT)
 #define __page_val_to_pfn(_val)  (((_val) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT)
 
 #ifdef CONFIG_64BIT
-- 
2.20.1


