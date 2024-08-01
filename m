Return-Path: <linux-kernel+bounces-271779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18F2945326
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B231F23E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB91494C1;
	Thu,  1 Aug 2024 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EY52c/Na"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A23182D8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722539652; cv=none; b=CXLI7MthJSOAltQK4KTpYb9e4doVrJstUiLIqYRzsUhIHvzd0w8KMnZNSEJJRn+D0VWgt6J1Gy83Azc3uLUFLeAS/+LhOyLj8P5QmYJWwmF91uMgcItyKUi84Bzqn09fJHo4cbuY5NDZ/Lyky7yipgQIwsTBWzytmznnkksWz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722539652; c=relaxed/simple;
	bh=BOhFOy9+GOXKvjIq4BCizTxww1cpZZhK0CEG8U53v9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lT9APu8lVgHXiHQ/TfbIzmg4InCiidEs6gsVXMdA2ncevJLu7zEIcDp06BkCIqrKZ+7SiAUfNpw4oqzh7+QeFgIs4EjT2w+x2iPbYhXklU4RB7KzYL2VfNa4C9mMVNlTvV1qnvdxjuZhnKMV6s/0MB/VHSpGL+VRG3iD44O3WOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EY52c/Na; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso56888866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722539649; x=1723144449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5W/erGbpS/c/dCYxji+flg5DFVPLeWzz/dF8Zch7oc=;
        b=EY52c/NaaTKWTGCvC41f6g8EbLTqIImij3Plb8O5vbZqPmTGynaPXULcBd+g5fedbz
         K9l9ySx7/07ejTNUdkqxUnXNvT/Kx2H1sc+U8zG7tgno6ZM95MmG7cQtahy7JZg/l49x
         RcIraBAIcaJTI5zAnzMjPRgmVuQf61gJrtdgNlqCCvMsUrjVFgEva73qIhI8gY3mfr6A
         BQS6kzx6AugDDdKW4WTRRXoFOcVmVlWD40Yz41aY7YjrUqLWd4f7zUOlUYEQuT+6V7VO
         04p+nlhADaJLoklu+etrzg8m+gpuxuz8PM8DyIXKSsu9l8igEilc4gEE3nMqHuzbt+PT
         StDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722539649; x=1723144449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5W/erGbpS/c/dCYxji+flg5DFVPLeWzz/dF8Zch7oc=;
        b=Z1Wf46wWuiXRCZ8O0w4Mee2WTkOt/XUSCBy09QuzoAUMJ2dasUXP4Yd++0EDenzHX9
         j12FNY6jx2CNHN3rWiaZjh9zQsKZgZNjg6xeG6LECsRT94uHYlWB1477e/9761Z/D6go
         rvnyI5DR1k5hUn4zB76SPlh9llmaVDIF9qeD2XCpXXCubEjJn0Xmow4ZbbVAKDAygm/X
         Ifne1sXVZ7UknrNQjPDtlVcY+L8ga/iMJZJEZsFQe0KN/YaGUmZKWqQQXEA5IcGjUOJJ
         qdqDMgUhPuIiWRPweAf4Nes2g6LSEWygxp2+EpViEFS0ZIVvtaiOxWCC3QHwPn3fO0QX
         mCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGW0IKuwQcy/9p7Av0O9Nmtkb7ZtzbpZ4BGlXc5eNhn3Hu0zSlZqlycAMfhNN0XV5OQHtTgAg6pvGH6ozygv+9DMCd6grQHhSnEioS
X-Gm-Message-State: AOJu0YwFqB9GTQl8pAO4DT50nkNeEuP4UF/XwpEO72NOjMNClXOHNlQY
	zzbLi/Glj/b+DOviB5mlGZL6RJ5QCd9gfquc5VOcRgB3jgXzkS6P4To5OtffuwU=
X-Google-Smtp-Source: AGHT+IG8O3kQpR7r7WjhGrPvYxFCXhMe0ennTGPr3kqsOdEaQ/t/mw+lODrb+tGcnkgB2Hb9Zd4gYA==
X-Received: by 2002:a17:907:7204:b0:a7a:b070:92d1 with SMTP id a640c23a62f3a-a7dc517b48dmr80884366b.46.1722539648600;
        Thu, 01 Aug 2024 12:14:08 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (2a02-8440-5341-1d05-87a7-5395-756f-4b41.rev.sfr.net. [2a02:8440:5341:1d05:87a7:5395:756f:4b41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc4fsm12991366b.77.2024.08.01.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:14:08 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH -fixes v2] riscv: Re-introduce global icache flush in patch_text_XXX()
Date: Thu,  1 Aug 2024 21:14:04 +0200
Message-Id: <20240801191404.55181-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
patching to avoid illegal insns") mistakenly removed the global icache
flush in patch_text_nosync() and patch_text_set_nosync() functions, so
reintroduce them.

Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
Reported-by: Samuel Holland <samuel.holland@sifive.com>
Closes: https://lore.kernel.org/linux-riscv/a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 69e5796fc51f..34ef522f07a8 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -205,6 +205,8 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 	int ret;
 
 	ret = patch_insn_set(addr, c, len);
+	if (!ret)
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
@@ -239,6 +241,8 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
 	int ret;
 
 	ret = patch_insn_write(addr, insns, len);
+	if (!ret)
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
-- 
2.39.2


