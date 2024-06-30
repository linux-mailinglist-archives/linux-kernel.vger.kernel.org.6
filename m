Return-Path: <linux-kernel+bounces-235191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DD91D15B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2857282936
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008613BC30;
	Sun, 30 Jun 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="hD9h/I2k"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE731386B4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719745582; cv=none; b=tMCk7zrCbJL/2/wu5FZ+pdl7xjwaLX9Rmt/14LsPthmwN85F1SfsgtkvZhpOtwCW+keUhEF373RbUzlZ3/eD5CzXD6Oy1jG9X2M+1fJwuBd8mYU7Jlc9bk2hNGnpMBM/REE5206zUkn1XAcC7CZe9veycT0Y6Ww7yEnznp0sTdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719745582; c=relaxed/simple;
	bh=zQ4dYj5/jyd9de0aK8+xJ72ZgjXm+/bM/SAlhqzL9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBoTf0PHbLHb398lJcFXASivuqKvEAm6X83sTxdBn8CneS3yt5MStR8Yi/C/GVxMXSC7UKPS3lmH34WjRKhrTH/T6Gpd9eUAHORz5LKmVhylMMWUWjQNnpdoyPLRQQN299ZCetMmANz3ZyUtjuVF6bASEbct3LX+r8LRY/nIU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=hD9h/I2k; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-425809eef0eso914875e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 04:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1719745579; x=1720350379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjW7qbBBooXO2YCGv7moaJ34uYcCR+XgnWB+1lWKJdE=;
        b=hD9h/I2ko95j60xonJk76re3Bwn+b+V2CaN4+OslSmpmJ25X28b23uQaEXJAViObLd
         /LVpj0T0BNx3pc2VMSepECOSEGfRo6sNsuwm336vtz8WPRPBf11JymkPhIUljrqexcw1
         lwsEkrkuDkOSQc3gop9joXRWyHpqTRtIaz4F/9DZw5Lx1QXe1j9nRwyxeOaqTvOGEXal
         DgvsDT/e6vX25EeHs8AgfGI+kMEVIhNOn/u86LceQ+WHZXUTQS7wMhRkVAqTJMIC/mFO
         hslysxxj7klqoUznVjvpobmo43wS4uWpbhG7HB6cdM6CWyLBT51WNcRJJYSfoszTB8Mj
         8UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719745579; x=1720350379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjW7qbBBooXO2YCGv7moaJ34uYcCR+XgnWB+1lWKJdE=;
        b=I7ZnMrcrNOL+rE3x6DlI3FPTDZKyu3kc4y6VaECVlU9QlblQqVCRhPgxN8iY2azUb3
         JasTpYhpuj3eeMY4keLGN0JlmdwLbdFIj2q5OxZxxC6Uhh+C9PZk6KGniRQfpFBQ91R8
         QbzZIph844nqYUvT6EM1ATcb2DgmZ7JVfYgsiL6DwgrvhLRH8zbqwJJ7BsjdODBKK7H6
         uO1QW7dp+eGJ0brCu2A+qLKvLh2JR22g65wKIbQ80HiAn+uoozspIyMKHBFU/Oyt3z2u
         8d9ykJfFrW9oUtfiVGUzf/4JhRfVVLdni6HuKobkWJdZlwrAEz1yiJYmysP7zC1fcNIw
         kkhw==
X-Forwarded-Encrypted: i=1; AJvYcCUAGqutFTjG3RND9flqoVjIoqdcutEtaabTf3vsHPJPsiXiUhq64g/41KpExy+pToDSvXrNWn934GOQv939dSMYxTn4c3gEi0t41SG0
X-Gm-Message-State: AOJu0YyVTLv6h1o8jm4Ibky9CUJB5d3+PTx252OEIBZwKP512XaI9Dkk
	tajDQgg5/b5epiJ41AWoGA4DiZcgSXbgdiLI2gWz19URMQ+7zNsGC3g9V4Lg9K8=
X-Google-Smtp-Source: AGHT+IEvGYJuscPCEUzw0BBrWd4sYa5asBO8etIxeRFC+suVG1W50JfPw2PlqeU2vd+9krcjevMglw==
X-Received: by 2002:a05:6000:1e92:b0:366:e8ac:50b2 with SMTP id ffacd0b85a97d-3677569952cmr2084407f8f.7.1719745578699;
        Sun, 30 Jun 2024 04:06:18 -0700 (PDT)
Received: from nb152.user.codasip.com ([2a00:23c6:2008:8201:ed43:a615:7f98:da0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0da004sm7159415f8f.45.2024.06.30.04.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 04:06:18 -0700 (PDT)
From: Stuart Menefy <stuart.menefy@codasip.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Stuart Menefy <stuart.menefy@codasip.com>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] riscv: Extend sv39 linear mapping max size to 128G
Date: Sun, 30 Jun 2024 12:05:49 +0100
Message-ID: <20240630110550.1731929-1-stuart.menefy@codasip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This harmonizes all virtual addressing modes which can now all map
(PGDIR_SIZE * PTRS_PER_PGD) / 4 of physical memory.

The RISCV implementation of KASAN requires that the boundary between
shallow mappings are aligned on an 8G boundary. In this case we need
VMALLOC_START to be 8G aligned. So although we only need to move the
start of the linear mapping down by 4GiB to allow 128GiB to be mapped,
we actually move it down by 8GiB (creating a 4GiB hole between the
linear mapping and KASAN shadow space) to maintain the alignment
requirement.

Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
---

Changes since V1:
This is a modified version of the patch posted by Alexandre Ghiti
<alexghiti@rivosinc.com> [1]. That version moved the start of the
liner mapping by 4GiB, but was subsequently found to trigger a problem
in the KASAN code [2]. By moving the start address by 8GiB alignment
requiremenents are maintained.

[1] https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivosinc.com/
[2] https://lore.kernel.org/linux-riscv/4011b34a-1b86-42c7-aaf6-3bd297149f06@ghiti.fr/

---
 Documentation/arch/riscv/vm-layout.rst | 11 ++++++-----
 arch/riscv/include/asm/page.h          |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index e476b4386bd9..077b968dcc81 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -47,11 +47,12 @@ RISC-V Linux Kernel SV39
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ffffffc6fea00000 | -228    GB | ffffffc6feffffff |    6 MB | fixmap
-   ffffffc6ff000000 | -228    GB | ffffffc6ffffffff |   16 MB | PCI io
-   ffffffc700000000 | -228    GB | ffffffc7ffffffff |    4 GB | vmemmap
-   ffffffc800000000 | -224    GB | ffffffd7ffffffff |   64 GB | vmalloc/ioremap space
-   ffffffd800000000 | -160    GB | fffffff6ffffffff |  124 GB | direct mapping of all physical memory
+   ffffffc4fea00000 | -236    GB | ffffffc4feffffff |    6 MB | fixmap
+   ffffffc4ff000000 | -236    GB | ffffffc4ffffffff |   16 MB | PCI io
+   ffffffc500000000 | -236    GB | ffffffc5ffffffff |    4 GB | vmemmap
+   ffffffc600000000 | -232    GB | ffffffd5ffffffff |   64 GB | vmalloc/ioremap space
+   ffffffd600000000 | -168    GB | fffffff5ffffffff |  128 GB | direct mapping of all physical memory
+                    |            |                  |         |
    fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
   __________________|____________|__________________|_________|____________________________________________________________
                                                               |
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..81d47fbbd927 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,7 +37,7 @@
  * define the PAGE_OFFSET value for SV48 and SV39.
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
-#define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
+#define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
-- 
2.43.0


