Return-Path: <linux-kernel+bounces-204882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64928FF4A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AE928DF53
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA782199E97;
	Thu,  6 Jun 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dhtQaJzU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4FD1993A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698494; cv=none; b=nI3IKgQulJkcxro6aK8TDc3NrbfjJMplu3h+S0kd/uVzEiUmuwWRTTLBxcjqTZPGB1yY9TWQqLuLM13FavQ7aX2vaYEOzVNl9auCaOhsUOKgeZQUf3mIXS3gPJkvmH8i6E0fAXOsBVzwv85bElOHvc1PaltevUsv0jMOtINZ5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698494; c=relaxed/simple;
	bh=aTSKYAeFIGVbtIPWzw+4bQaxD1QfN0rDOpLJpEnq6jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdmPSmxA+3RPKxbdLLpvoQpHYY4fKQ1AMYEFmULknkFgDuQr44l73Axt2Z1zS8kQFKwZG2nf1FnMkzXLhTlOma/9wHH0gaF7L8b5Ku/kakCsCipK3Hd9jszVy7bEzKu+fMcvfbo9aqgryUYN3t3Prw8o/pEMXtVKhpYijUg0MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dhtQaJzU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f64ecb1766so11257445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717698491; x=1718303291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnjrltBnoDUBuMjYPvFD9/BtWTyCCjyld10aySgsRYQ=;
        b=dhtQaJzUEHPnJr62kpm12UjLnKgpbrdVfi4oawnWa6lw5mv78dmwRa44UtIFvMwg44
         OjkoVldMFZDxTr/IjoxiF9u9Ew8d1J656kOvJ8eyMXP/0OrkZbP1Pklg+peyLzxEg23A
         rDjbQEdQb1H9Hh3pCVojyj+W/rUGKa1gWyQergWWkZW8RAcDpNMioNiXCOa7BoHPllOa
         chdufgz7R7IEZaktwW+T3U4wnO8/l62i1ZAbTl7p9T7NPHITMsd1faglLw+uM+NxNQtZ
         eu5+Tgae8FO4J1rtvHLUOQWRcogPMu+h5keoHiABXBx6fM7ff24P1wvcRU2ljoOhA4w2
         BQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698491; x=1718303291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnjrltBnoDUBuMjYPvFD9/BtWTyCCjyld10aySgsRYQ=;
        b=AUqqFni6oU9fbcaRqN7E4fw7tS6R6P103IQu71CZgia4UguoUIMhEmmK7NONdEL3yO
         6IOuudwzOYKY4AdO1tIU35k+bGD83kBLpgaizTvZY6iHpBRYgJj3YCveNKS15e5H2QF/
         PORFN7g/nugONL29lthqwSprvpIIV1AhUcMcrRnOB/YSIlEIFiigu5VCYoo6mcvFyVlX
         iPSoHnKYHp2Zc4Q/eTzRGr0kcDuclAhDV76gN2euek4uCJF5Cr76XMw31Z79RSGEAstB
         /CW9tr1HjbIqlhDMJq0zEx/XYtktJd+94QSMYtU7sb9MpZgf/DwTMNzID6aaG/pk4jk4
         BUhw==
X-Forwarded-Encrypted: i=1; AJvYcCX93Zd4zLTWZ6a8YSdBm0wrlO4TGhbDY5GK3FXDOUF3owN4y9ASrm7jrrEiMRNeK33eOz8VTiAaXee1EzShBv7hXESsJWlqWmAm+eZT
X-Gm-Message-State: AOJu0YyPvwB+tjM5CDFkS9ueay5/V5F10Mgm4mv9XPbGPQuu7iWrAnGZ
	8bN6yocWrnsF+8oyIvJAviiw0I/6qTHaxDFgPcLrU2CA3Quxauw4rURhTDX1+T0=
X-Google-Smtp-Source: AGHT+IHFogoDpFoL0fyeOw09KtRwYuvv9EThx7HSbC93vFGnNu+pzJGBVR3kjG3MFGlDR4iCZSXrkw==
X-Received: by 2002:a17:902:db0e:b0:1f6:6407:cf85 with SMTP id d9443c01a7336-1f6d0395b10mr4076855ad.53.1717698491085;
        Thu, 06 Jun 2024 11:28:11 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7ccfd3sm18400835ad.132.2024.06.06.11.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:28:10 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Nam Cao <namcaov@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Jesse Taube <jesse@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: fix vector insn load/store width mask
Date: Thu,  6 Jun 2024 14:28:00 -0400
Message-ID: <20240606182800.415831-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RVFDQ_FL_FS_WIDTH_MASK should be 3 bits [14-12], shifted down by 12 bits.
Replace GENMASK(3, 0) with GENMASK(2, 0).

Fixes: cd054837243b ("riscv: Allocate user's vector context in the first-use trap")
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/include/asm/insn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index 06e439eeef9a..09fde95a5e8f 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -145,7 +145,7 @@
 
 /* parts of opcode for RVF, RVD and RVQ */
 #define RVFDQ_FL_FS_WIDTH_OFF	12
-#define RVFDQ_FL_FS_WIDTH_MASK	GENMASK(3, 0)
+#define RVFDQ_FL_FS_WIDTH_MASK	GENMASK(2, 0)
 #define RVFDQ_FL_FS_WIDTH_W	2
 #define RVFDQ_FL_FS_WIDTH_D	3
 #define RVFDQ_LS_FS_WIDTH_Q	4
-- 
2.43.0


