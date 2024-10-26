Return-Path: <linux-kernel+bounces-383314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DEB9B19FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E1A1C212D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72871D61A4;
	Sat, 26 Oct 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MBD0bBv4"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7C1D040B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962889; cv=none; b=sZtR9faDKmzpKXpdVrj8M56vgQXa3sTwrCtodDgRutdTZ7FIw+Js6hHtLJwKgLZLNn/D1Jv6aQEPxhE7AZpBWn15i9D9A+iJz8grg3IBNkulx/dpCgWACsUyK/tZqi8Hzw0DpJgNS6nt4uwhE4VH3gBfYrkZ+66eQ1npaREdPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962889; c=relaxed/simple;
	bh=iUX1BixGjkb0dNnZh+RA4SlDagbvHXtMA0l5ZKdixJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZvt7q+TJ67MSSMWWORVL8rmtlwT9Rj6Rf6RfnNcO0cHqi42j30KArXCdavQWnchw8d+isVZ1tBffBtvjZV/tSWnFIS6FVPzfYINK8mXrJdmzd/U+yXlEl8p2tAQQDd+tsJWf/X/f5FMH4kArSXGaQMiX3KnmhLP5f7qWoRVeag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MBD0bBv4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso2444765a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729962886; x=1730567686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyKlYhyoQTsAn4L5ymM1gqMGEqmqMMy28NtniO4HhLo=;
        b=MBD0bBv4gGLLKX6iF4wGtqmfrJcTBQRh+RKIurUDC7BylmTLXJk5mEeudno4Ox/X9z
         VhVgaAjDt3R1KxQ+NBfhvmBU/qkhuyBU1MtTmKQ+hva0vJk1j+nEqMCWtI0KsoytHR2n
         cNnUye+uFStonojRwY+4MK1vKiFR7BKZVwozqR9YXR6LAUK0mGOaiDiU8V88JRzqtfxh
         4lvgZ5SEdIQcr2WGPn6X7PhLiys0anP7pT/5IF6jlslKyf5KIM+ZgqcMQaTYPfrwKwdC
         fUtfpjPSe2bqAhF3nsykXkA1qKaC8PbCD2+XNOO3fH5+z5kfRykBmMbzYrvWHJbFmy6G
         XRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729962886; x=1730567686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyKlYhyoQTsAn4L5ymM1gqMGEqmqMMy28NtniO4HhLo=;
        b=STzmIuqUXaqYUXy6rwctNwAGYnp5ufpjJ/+WYDNQ6FPEE4o966EgSSaPnaYdGmnFWl
         QJ3MS+l2u93Rdv367ddz88kw/j+Gz6sfHm043HZqGWtloMCKE+/YaUYtyaWmG+cIeGns
         4V97xbkIZHKj/Ns5qofY1T3VL7RucunfWx0/jSlvuQsv1M2eiqgrao6NWETvsZt7pdMq
         +P9fVzhfTXr1IQcB2N0uQrXGHR1I/JjwOoU8W5boB3Yn0IQppgvYUonxtFrmeMi2kpoL
         E/l1AiBg+bNlyRe9qUSiqx/xYaZ16nDN9/z/MECAHMJwYQgvBtRelbSuCDAJhF/5R4q7
         y0lw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZWNRUiAld4oFN5FboQdm8shU3qzxrfUbcZ0RHyxKHUMALkTUGGrBB6nKMFWXimPB3y7i+rhbual+XCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Djy/dNYQnb7yvXgsn6AZP3VPQWHFvUCQT7ReNdokzRiAHwbX
	UszykXLiN18lm6Wg5bEQ1fcE3AyvhwYkbRhUF6GdvgsWrkfb7AI5mGjnvhwMTjs=
X-Google-Smtp-Source: AGHT+IGjNDukwViDngFMKYKbWwFFp9ljp4jqD+5ryDjxC8VoVYiX7cXbg3yZQRK0W4GSuzVMjeVSBQ==
X-Received: by 2002:a17:90a:7847:b0:2e2:c69b:669 with SMTP id 98e67ed59e1d1-2e8f10a6f5bmr4102476a91.27.1729962886541;
        Sat, 26 Oct 2024 10:14:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e558114sm5663762a91.36.2024.10.26.10.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 10:14:46 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 2/6] riscv: Allow NOMMU kernels to access all of RAM
Date: Sat, 26 Oct 2024 10:13:54 -0700
Message-ID: <20241026171441.3047904-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241026171441.3047904-1-samuel.holland@sifive.com>
References: <20241026171441.3047904-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NOMMU kernels currently cannot access memory below the kernel link
address. Remove this restriction by setting PAGE_OFFSET to the actual
start of RAM, as determined from the devicetree. The kernel link address
must be a constant, so keep using CONFIG_PAGE_OFFSET for that purpose.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/page.h    | 12 ++++--------
 arch/riscv/include/asm/pgtable.h |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 32d308a3355f..24d1ac052609 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -26,12 +26,9 @@
  * When not using MMU this corresponds to the first free page in
  * physical memory (aligned on a page boundary).
  */
-#ifdef CONFIG_64BIT
 #ifdef CONFIG_MMU
+#ifdef CONFIG_64BIT
 #define PAGE_OFFSET		kernel_map.page_offset
-#else
-#define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
-#endif
 /*
  * By default, CONFIG_PAGE_OFFSET value corresponds to SV57 address space so
  * define the PAGE_OFFSET value for SV48 and SV39.
@@ -41,6 +38,9 @@
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
+#else
+#define PAGE_OFFSET		((unsigned long)phys_ram_base)
+#endif /* CONFIG_MMU */
 
 #ifndef __ASSEMBLY__
 
@@ -97,11 +97,7 @@ typedef struct page *pgtable_t;
 #define MIN_MEMBLOCK_ADDR      0
 #endif
 
-#ifdef CONFIG_MMU
 #define ARCH_PFN_OFFSET		(PFN_DOWN((unsigned long)phys_ram_base))
-#else
-#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
-#endif /* CONFIG_MMU */
 
 struct kernel_mapping {
 	unsigned long page_offset;
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e79f15293492..e224ac66e635 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -12,7 +12,7 @@
 #include <asm/pgtable-bits.h>
 
 #ifndef CONFIG_MMU
-#define KERNEL_LINK_ADDR	PAGE_OFFSET
+#define KERNEL_LINK_ADDR	_AC(CONFIG_PAGE_OFFSET, UL)
 #define KERN_VIRT_SIZE		(UL(-1))
 #else
 
-- 
2.45.1


