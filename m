Return-Path: <linux-kernel+bounces-367614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEB09A0476
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F94A1F245CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAF1FCC74;
	Wed, 16 Oct 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VX7Hsm19"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7961FCC6D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067913; cv=none; b=YNP3mGlOJB3+T7LJbP6cgVOY3fbaccLbMmKz+1CHA0Gsh8V0a8BFCAyIcojT7ozPQFXS7pFxVY/Ci3I3+S6sR6oCScpQeC1YDhiusG8v37jykpBKsGw1fkpoQXcGc2WFPuX8eUzMr97Li9D4JfBn85shsc9IIjeMcwIo/y3DnVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067913; c=relaxed/simple;
	bh=/rLgq3p4ObPxtfQzLO2A450swrlwKaY+mRcWaH3/8I4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxkk6ef1lHkn0sux1C4AHEtdNHLzphBGQiLPL9f87I//MeYNGR2otHLixn1bBHiTlsXb6zRFGAUhudKK509wq8Z5hwhyYSyiR5JUhfptpZIrHwG+X5PwpFRBW721f5yqe1PRepPfMbNwkQ7t3jzYUorpYmNsOkeAzxPvu5iT/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VX7Hsm19; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4305413aec9so60675235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729067910; x=1729672710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmChZIcn3ram5DrPXLsJi2oFdsO/Sp5E7s6oakOpriw=;
        b=VX7Hsm194/aTh/HY4TDAwZL0zr3F2ARxS3huGON+W9lFUUAl9eb5Hq5/UQdh+DV4Bi
         aBXYegFj4Vfu9ReBNr3uBr8SkuTeDNZC6WHH2x48VLyYF1gxeyU7PKKxAvQOUrpnLc6k
         5A7d/glMefeQxqkbyuKxJ6M5FhnSP7gJaWaZ4430ORW+QzQtXyn4bkh1gq01d1YLY4eo
         Fm8H1C4uzM1OK7i8tn1UkK4SROwCMlMhlsIdsRxaz2PdemBc/vwouXyzQA3vYjTJ4zch
         T9syz6j3dJKx61bbTopyd/ojIe3g6tMj4C0VKsWHr4ZJSm7nqIM2Q1Xkm1Vqxgxw+pNT
         7iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067910; x=1729672710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmChZIcn3ram5DrPXLsJi2oFdsO/Sp5E7s6oakOpriw=;
        b=c8KI7pRXY/TuPDvhWQ1g/NLAEfnfulxQRO1DAyRpAtQzJSPmNPC1HdLZJRwzEN5VtL
         hCgSDgYajOy/DBOpRgmGHUhDrkbBgnZRA8JMPrwFy3X7PHh0CQRsvvGlAlYt9ZnnKAhw
         qlk4KLIiLhL8dsdDA7GvylS5IgwymECyXE/qhJEPN1FVO70KwylZMVxAulWbn6t53ixI
         WlWacNZCZIfGcq+aunMHZs9lqdTR9NMRMLG80gIvJP8bKNTRHTWSU+mXAKjw785V1Kj2
         NH6X+dWh3a5L7feuW9HAhKuNIiKkQgbhGSk10CuVFYHi6pnQMAZezZzcMQnkXbyI2nb0
         Hrtg==
X-Forwarded-Encrypted: i=1; AJvYcCX16lmGMcwUK9l4PpNymqhNFu+q48v4zP563/0rEweM2IY1ENxO3saq+AGQzB0rjoegcrzcyWRjmDPgJS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2SlLUZFk/AYPpB7Pg1ttTEn5NJJ6SOFU4AhnuQmL396Lg4Bl
	u+SmMsNoPiPkxKgjNOQgLe/P/TfXvuoDOBJiNQTeaAwspCE8NoKxHmA15v4RcCA0E8zEYBiECon
	J
X-Google-Smtp-Source: AGHT+IGR0n+c7XSqnCHxTJU2G9C304U+ZAi49P3/9N45hFLnwx6sLPhF+8rNeg2KuWiIJB7D9B4i+g==
X-Received: by 2002:a05:600c:1906:b0:42c:b45d:4a7b with SMTP id 5b1f17b1804b1-4314a37bb99mr28526255e9.25.1729067910135;
        Wed, 16 Oct 2024 01:38:30 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b3c72sm42449965e9.35.2024.10.16.01.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:38:29 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v3 2/2] riscv: Check that vdso does not contain any dynamic relocations
Date: Wed, 16 Oct 2024 10:36:25 +0200
Message-Id: <20241016083625.136311-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241016083625.136311-1-alexghiti@rivosinc.com>
References: <20241016083625.136311-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Like other architectures, use the common cmd_vdso_check to make sure of
that.

Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 3f1c4b2d0b06..9a1b555e8733 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
+	$(call if_changed,vdsold_and_check)
 LDFLAGS_vdso.so.dbg = -shared -soname=linux-vdso.so.1 \
 	--build-id=sha1 --hash-style=both --eh-frame-hdr
 
@@ -65,7 +65,8 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 # actual build commands
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
-quiet_cmd_vdsold = VDSOLD  $@
-      cmd_vdsold = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+quiet_cmd_vdsold_and_check = VDSOLD  $@
+      cmd_vdsold_and_check = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
-                   rm $@.tmp
+                   rm $@.tmp && \
+                   $(cmd_vdso_check)
-- 
2.39.2


