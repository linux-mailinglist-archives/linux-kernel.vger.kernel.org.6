Return-Path: <linux-kernel+bounces-178758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF68C5740
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEC29B20D72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DAB1448CB;
	Tue, 14 May 2024 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cjQAaCNW"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7214431B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693781; cv=none; b=mdKRellryyfvlcZxrr3+aLyb9XhSOmcFQG3zloJ+b4UHyPKRn8hW5uIvaRUOHNKCs3pI196Vz6q3tS3W9nqRr6LLny+mZ1FmDYJY00X05boXEQXxrDrHH6LStYGlK7eMK9QVD8tgFIE/3KWERR2288kQmG+NPuf/UMowd3XLCrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693781; c=relaxed/simple;
	bh=Nyi+RCrf5Y+WqMKXmI2T5cOWnyBug0P72f6XYQ0uD+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dcR7wDDYxkCrz1Z1UfTtoWN8wytBOY4d+k4dIFqpKXIrFiBTRyBh/JymuLw/+tncuqAOejwRnypw4X6xRfkzHV4sSVNSefKDsjGGw6U9q110Mas4VFqIhXays4EHE7CItR02dZmmq5N6ZhxJSAWzKTiQc6JUoEsxASkVDlMx93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cjQAaCNW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so32780205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715693778; x=1716298578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ELhPDbgArQNQi6ZkTuNkJ3HaLG9b9s1A9lZNaSj8kas=;
        b=cjQAaCNWjw7QS+MgedkvCizu5HKRF47jei0ErJEd0ePdKLT2SQINUHQoDDXemBmidt
         Telb3uiSw13AzXQQVy69rJ3bStqmyd/DNklO2BwfM3OrJeQIkYAUE4c5M2Lm1fk5ZyB+
         aUB6UguHsioz5/FttR0JX2IV8AS9Yf3GpoZEzTiR6XoPuDYPVrtywguR6n4WZlojvrVj
         UO56fgXh49mHl4JiiQOo6REyzgIw7Y63GIM5b11SO6jQTw+NmzaXWjLMxXujFGwABtaq
         EcrDp3SP7sWy4SeryQzIkwfcNAHl9heP1IwvSshtvz5OAGCHu5DIVncse4/LHs8PTO+i
         QC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715693778; x=1716298578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELhPDbgArQNQi6ZkTuNkJ3HaLG9b9s1A9lZNaSj8kas=;
        b=Ow6RGY+GJcsrDn73qzw3IJ8cHFfeTWWvQgZd8CsqCMlbRi4txNjUM0mp0q4L7YXQWY
         44E3l+h1jB74oWKtQmAcNEXD4/LKXjRx7YuVFGgijjJs8ofulG8WEBfTqpMIJ77si0Sm
         nCfSUmlizHh/QfLknQlP1JgeeSE832UMTOegfEPKKioEPkMzs1woW4ucAmHmnthp3upZ
         NJkKDRr4adQaurzg8klE80GSOrwzHdW+8nrIXOyhwxV7E0PcTuUW0JikbnoZfKnHyu2X
         EgMS85+mv2MA4eFMI6urCQcwdi/ExQgOjG3jhFIxNAyzi+s0wFXKxOG4A5k2FyBPLnL3
         ep/g==
X-Forwarded-Encrypted: i=1; AJvYcCUWUuFGofZVUayWfW+8+xbMhlAr28RIkLi6R3cABGUtCevS5QZaelDH2/Aq3Suk+e03PGW06zKLAsruQVnJMy0wXCOYpFf5XKIGXaOR
X-Gm-Message-State: AOJu0YwmHAS/DgStmp6yrI1pGzeKyamd8ISTnBEn0c4+SwgAquq9lkcJ
	BAufJDSCo2NUrxSv1cM3p3zC6yp4icLkMqW2QgSXyBx24KV+rqrAj96CqEziON0=
X-Google-Smtp-Source: AGHT+IHfPx0KBY4rytS7KmSuQawsfE1ZSfpv7vPPScV5D9GsMRlZ30zNYZI5mhzzvMLWaliGYlVCAg==
X-Received: by 2002:a17:902:e5c2:b0:1eb:2fb3:f9fd with SMTP id d9443c01a7336-1ef43c0cecbmr165256165ad.14.1715693778566;
        Tue, 14 May 2024 06:36:18 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13699dsm97908565ad.239.2024.05.14.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:36:17 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Extend sv39 linear mapping max size to 128G
Date: Tue, 14 May 2024 15:36:14 +0200
Message-Id: <20240514133614.87813-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This harmonizes all virtual addressing modes which can now all map
(PGDIR_SIZE * PTRS_PER_PGD) / 4 of physical memory.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/arch/riscv/vm-layout.rst | 10 +++++-----
 arch/riscv/include/asm/page.h          |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
index e476b4386bd9..f37812863991 100644
--- a/Documentation/arch/riscv/vm-layout.rst
+++ b/Documentation/arch/riscv/vm-layout.rst
@@ -47,11 +47,11 @@ RISC-V Linux Kernel SV39
                                                               | Kernel-space virtual memory, shared between all processes:
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
-   ffffffc6fea00000 | -228    GB | ffffffc6feffffff |    6 MB | fixmap
-   ffffffc6ff000000 | -228    GB | ffffffc6ffffffff |   16 MB | PCI io
-   ffffffc700000000 | -228    GB | ffffffc7ffffffff |    4 GB | vmemmap
-   ffffffc800000000 | -224    GB | ffffffd7ffffffff |   64 GB | vmalloc/ioremap space
-   ffffffd800000000 | -160    GB | fffffff6ffffffff |  124 GB | direct mapping of all physical memory
+   ffffffc5fea00000 | -232    GB | ffffffc5feffffff |    6 MB | fixmap
+   ffffffc5ff000000 | -232    GB | ffffffc5ffffffff |   16 MB | PCI io
+   ffffffc600000000 | -232    GB | ffffffc6ffffffff |    4 GB | vmemmap
+   ffffffc700000000 | -228    GB | ffffffd6ffffffff |   64 GB | vmalloc/ioremap space
+   ffffffd700000000 | -164    GB | fffffff6ffffffff |  128 GB | direct mapping of all physical memory
    fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
   __________________|____________|__________________|_________|____________________________________________________________
                                                               |
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..727ed7887cab 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -37,7 +37,7 @@
  * define the PAGE_OFFSET value for SV48 and SV39.
  */
 #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
-#define PAGE_OFFSET_L3		_AC(0xffffffd800000000, UL)
+#define PAGE_OFFSET_L3		_AC(0xffffffd700000000, UL)
 #else
 #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
 #endif /* CONFIG_64BIT */
-- 
2.39.2


