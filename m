Return-Path: <linux-kernel+bounces-375433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0619A95DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DFAB213CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27301474C9;
	Tue, 22 Oct 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jIz09CJj"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802F135A79
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562371; cv=none; b=GX1bOgU70Dx18A1dgWsLEzl8G5zAxlp5ZjeosMlSa7nHhcfvtshbT34K5JAOnfVasGVpImXmBPOqoTPPUUdIdvD88gVrYGbtsg86NHMu6NUeO4kMKrqUVAhi7uEIRymXtlqxD/u+AYJ9b/mmGJNpEi+V0fnyALMq/rEBHccjkyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562371; c=relaxed/simple;
	bh=O5lWqpDcFOKaIADUL30wY0OO26drBl/ty+OTgNOwqp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLKH/DilY3ZNjinUvXFKMTRT7IIOvClxrGG50GRRzTS85C/UP7OIV3kA+zSAyo8c+Eta6n46k1pKgb4l5hq9p1+t9E3y/JOTF4e77QgH6Rcr8E/ExKAuUCnWUDF717u7TzWAgJsALE8WKErvztb9KRZne7nn+Jm5MM8QeSYUfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jIz09CJj; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27beb2496f4so1718436fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562368; x=1730167168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=559wueV0PG6xFm1m5EmJll56/fKSQJhn2CptHQFJIX4=;
        b=jIz09CJjmBGgHWwc/y/JluvpOwQ6Mfu+kjeGGF/pNNt2j9z+JRu0xVLi0zN94klDa6
         SYjBrTRGFhbai2CFh6Bz/1zsU8fhZRqT7y7aHHqXS1HnZDVqHuRm4Inrt5x7PuiFEKEX
         cifzwnG1Qx7Pv1Xle7MveQtnOI3j+XFTzyAJzdDuGxjW6LWzmZu3D/XiwHVUsJPCRKAf
         NkZe6j0/9nNiIDzuPAbBoEwbv17+BZV0mrJIJ+SCP0BchBTeu07Q1olW7WJ2GnGDuq4A
         eQr3Hwl9/x+ZA1NafqKKsX1zYZTS1Zf6qGJgPBpVI32LyTFT+X1aFIbGJizMw0nM5fr6
         L0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562368; x=1730167168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=559wueV0PG6xFm1m5EmJll56/fKSQJhn2CptHQFJIX4=;
        b=wNQvFPSpHcmVrfx9zus7cf/fedtwpIzrxZLfgnpoqHiCyTKalpiu0sYYhohKtYcZSh
         r3cho0HS1DmyBvy9WjL/MpUMvuWvd5ZIS0dVeoqzVoNhK9KXixm34/qdEM6CbbVOkwnu
         R4UwkmkPpqDGhk7gqB7kwhWfKNdXArGNBpwQUmXQx1HiDx30Uvbomauf5oxUNoFbuE50
         h+5LGeNLs1lXzF9ZsHMU5R5HebKujsPLVN3WAe8WzM30nT7d6kfag0sSvdlFJdLUrKDd
         redxoj9RrxHWUqhlbeQ33YdV1Wsp3+OkZhoj900MdB7bRfFo9X4HE8zTPDZKP/WdVtNI
         5cgw==
X-Forwarded-Encrypted: i=1; AJvYcCXe9ek5eb9kyVKF6O1rx5eqXAjrq8nJB159Jb8TaLVQY6C7tdgliHuIGKeEakwrWzUQoEc6Ojos5BT7pgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmknFM8Je5yMMIGORlgtNscd0H88t4TTz4kqd4vZgvcFDsoC9
	081GoYfem/0o4M3SdudmkK62ouA3xgQI97VOwwTHtxG/jHmSawWXwGJ6XNp9JqE=
X-Google-Smtp-Source: AGHT+IEp2UA/bF+2FyY3t++ENshpm/xo2VESMIC3hEEwlJcPqi8vvi8Dyd6MCRyyBM+qcOZbinhyoQ==
X-Received: by 2002:a05:6870:95aa:b0:277:a43a:dac2 with SMTP id 586e51a60fabf-2892c2df34amr10113787fac.17.1729562368580;
        Mon, 21 Oct 2024 18:59:28 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:28 -0700 (PDT)
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
Subject: [PATCH v2 7/9] riscv: Align the sv39 linear map to 16 GiB
Date: Mon, 21 Oct 2024 18:57:15 -0700
Message-ID: <20241022015913.3524425-8-samuel.holland@sifive.com>
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

The KASAN implementation on RISC-V requires the shadow memory for the
vmemmap and linear map regions to be aligned to a PMD boundary (1 GiB).
For KASAN_GENERIC (KASAN_SHADOW_SCALE_SHIFT == 3), this enforces 8 GiB
alignment for the memory regions themselves. KASAN_SW_TAGS uses 16-byte
granules (KASAN_SHADOW_SCALE_SHIFT == 4), so now the memory regions must
be aligned to a 16 GiB boundary.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 Documentation/arch/riscv/vm-layout.rst | 10 +++++-----
 arch/riscv/include/asm/page.h          |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index eabec99b5852..c0778c421b34 100644
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
index 32d308a3355f..6e2f79cf77c5 100644
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


