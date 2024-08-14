Return-Path: <linux-kernel+bounces-286144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D350E95172D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047C11C21B35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949F149E03;
	Wed, 14 Aug 2024 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jLWu6JZ9"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07500149DEE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625791; cv=none; b=CTy2y2nzGZBcgoIds23TKnrc9gwkSqwKRYr2dv6sR6NMN4v3FhRv9BvuRn/uA/B4JyqgokM/1FSevjfwT00pg/69EA1HagJjseuAsBWCRcwzZhDYi+Mj6e9gDF6ZWfkVmNorluW6gX83jKk8V/8sQVRF7a9yVHTOaTv1di+LUTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625791; c=relaxed/simple;
	bh=Jwqj+kFZYI0WjOz3quIwyH3tnTx1KhxDrMuycqhBqy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQnR6asA67R6iz9LI4k49KTzxS6G+mYOthAwHHLJ8HXDhIwdNvtaAH0SYL1zdVc73FSL0fr2CcfGcUGqcYwQpFrzsTDknUZWES3zFFaVcWvMLNChQa+02zWZfaTDQeEd8hxviB/kit8/q1M5v5n/mbaQPdPg3YshWCsC0SeQVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jLWu6JZ9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1627487a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723625789; x=1724230589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtxoKtjWvRqhjS0z2DQnl5gBuyvoRF+9CVzVIMvmZ6E=;
        b=jLWu6JZ9EiT8yz681VOj1gdvMUb+AIdK3r++Idd8DrwlwCf9dnf0PxOXOVuXgwCuEx
         rOwgbR1/FfdFYL9U75OyUZjPmR11n16PEmSwvIJCvneOjitJg9x+q3gEy5fzmv0A1c3K
         v/kp/UqJZyHvOhFTF63zPkgPr6T4NEi9BoHNdCsswlaqS97dJaesRPh5Yqt4UBgWy4HT
         2HrcgAd+GLAAN0cpliWL/PpZmdTX8bM5QZCgAr9RkO4x3zfPYpCcHJiGMmyFI/3ei9OI
         R/KDRo2X2Ebvt8HNIf9TyoNmxnda8yL6IfCy+NWhyoMvOnqdtCBVRwIRQtPyPlPeKYRf
         oOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625789; x=1724230589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtxoKtjWvRqhjS0z2DQnl5gBuyvoRF+9CVzVIMvmZ6E=;
        b=ec8N6hM0e4su0F34zIBpURtl/ngUFouEJLkPsezHSjRxuewccuHyfNXQ/UcvThg9gI
         f6RDQ1/HBSS2mdaTuCLJz3y/4IghR60rjrBnFrhnMaQ7NDqRwp/YyUa2yheIp4wB/pnd
         c5Ng2TjskHm4ClR/8+zkbcciR2J66G221yajl+U1l+36FA/01L38RxVOZp9sPhup2paL
         /JvHYrgX8xshU29VM2yaEC4M2gTRmP6qv0d2oWFm7tHHJuX13j8aIkMzPm5Itn/6HT3g
         q3TtbVyrozRcIZtZi4TQCVhb7cagcrJWJKDjPUBmed4qC7epola2NFf8uk31QaiSU+3A
         HJeg==
X-Forwarded-Encrypted: i=1; AJvYcCXdiQ8EAKZ4VH3Hp3gw76GUiXvlGNyp3eVBj284m13pkQ9zzO6Yx833Kwjb60EzTZW9QnlNtEMR7GVzfrOpoFfwmx6uBeLsFwJvmfQR
X-Gm-Message-State: AOJu0YySbpRhe7JtJEne/A0+iq0HY2R31M8OgWGQZSFyIYJM0GebXRFU
	HIs+O5GhJKsB4PIozfi5pItl99PuyJwSyIax2ibmYkZ4MX6LPfCZaHECURsjqIQ=
X-Google-Smtp-Source: AGHT+IGKwvtrSq7d8JlTCA95HrODYZub/jNh1CadsEDvmYgd02vgRRSnG6ohafRUbcvHgfRX7yetxA==
X-Received: by 2002:a05:6a20:4f25:b0:1c8:edba:b9ca with SMTP id adf61e73a8af0-1c8edbabc7fmr1261808637.1.1723625789313;
        Wed, 14 Aug 2024 01:56:29 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a7b8sm25439615ad.100.2024.08.14.01.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:28 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 5/7] riscv: Align the sv39 linear map to 16 GiB
Date: Wed, 14 Aug 2024 01:55:33 -0700
Message-ID: <20240814085618.968833-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814085618.968833-1-samuel.holland@sifive.com>
References: <20240814085618.968833-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KASAN implementation on RISC-V requires the shadow memory for the
vmemmap and linear map regions to be aligned to a PMD boundary (1 GiB).
For KASAN_GENERIC (KASAN_SHADOW_SCALE_SHIFT == 3), this enforces 8 GiB
alignment for the memory regions themselves. KASAN_SW_TAGS uses 16-byte
granules (KASAN_SHADOW_SCALE_SHIFT == 4), so now the memory regions must
be aligned to a 16 GiB boundary.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Documentation/arch/riscv/vm-layout.rst | 10 +++++-----
 arch/riscv/include/asm/page.h          |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index 077b968dcc81..ed71b3b1b784 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -47,11 +47,11 @@ RISC-V Linux Kernel SV39
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ffffffc4fea00000 | -236    GB | ffffffc4feffffff |    6 MB | fixmap
-   ffffffc4ff000000 | -236    GB | ffffffc4ffffffff |   16 MB | PCI io
-   ffffffc500000000 | -236    GB | ffffffc5ffffffff |    4 GB | vmemmap
-   ffffffc600000000 | -232    GB | ffffffd5ffffffff |   64 GB | vmalloc/ioremap space
-   ffffffd600000000 | -168    GB | fffffff5ffffffff |  128 GB | direct mapping of all physical memory
+   ffffffc2fea00000 | -244    GB | ffffffc2feffffff |    6 MB | fixmap
+   ffffffc2ff000000 | -244    GB | ffffffc2ffffffff |   16 MB | PCI io
+   ffffffc300000000 | -244    GB | ffffffc3ffffffff |    4 GB | vmemmap
+   ffffffc400000000 | -240    GB | ffffffd3ffffffff |   64 GB | vmalloc/ioremap space
+   ffffffd400000000 | -176    GB | fffffff3ffffffff |  128 GB | direct mapping of all physical memory
                     |            |                  |         |
    fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
   __________________|____________|__________________|_________|____________________________________________________________
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 7ede2111c591..09d15567b0b8 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,7 +37,7 @@
  * define the PAGE_OFFSET value for SV48 and SV39.
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
-#define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
+#define PAGE_OFFSET_L3		_AC(0xffffffd400000000, UL)
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
-- 
2.45.1


