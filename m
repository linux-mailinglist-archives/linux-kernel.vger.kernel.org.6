Return-Path: <linux-kernel+bounces-241956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A5D9281BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FEB1F234E1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1035813F42D;
	Fri,  5 Jul 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rId0vQOX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67033C7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159871; cv=none; b=kMpiyZjTv5+ZGJ2d9+MhYObO4mM+QPTKkXD2Olk9MD+YUoS3gZZMzCOTrW85fHZcgUxXTxy5aAd6xpVI6P4MRlORB3Z5vDKaqjJ3wJFQNaK7bCaQ0afBrt8ydkEntRCKEGlUHoRQGFGHiMMd+UAKSQ9LsAdNNuPEZ4O+1BDYvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159871; c=relaxed/simple;
	bh=5Y1VF2DsIyZIsAYkOQ/CH3Ph6m1nG4HQkTV4KqMjdWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThoLEt7EK8XhyuEmJP4sjy/e9/oa/gTJJOqGbbdH/nZpEOmXIO/WUcl6D6hu87wq445L+V/CdTPO/NCsvh95p7lXKaot8eV/TXD9eFPvTRmra2LKfuUHorMoo0VUMBCZ80ZgWm0qY3CjSqYT/c6HMQOr6LSKKzZYVChfZq/b9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rId0vQOX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ea79e6979so79438e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720159867; x=1720764667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QeNckosVxjolkEFvOsh5sX+5l80S9ypJGm7bOhl6bY=;
        b=rId0vQOX7mHv8wexP1aysKp21EJ6hNWYVaRMoUDNmzOZrvL56oolw1ehgHW5f7Wkp8
         y1dc+inSa0ncuJouiiWy3Pb38/IWZ0i6Fv5wVeuG/pH5GZkSwuVLH+hAWmqvXS54Rmcw
         nQiZRpAGioor5ShodOitEkbMc5tfAQEqs6X0RLpvuwtkhELdbfMWBcQ7ANmRmdm/Pf/U
         E1wxnROHvkze1Bcfts8nC0gtdUm1ZDBF0N7cuvY7dOrUhNv1ZnQ8O5U6Nmd5O9Ty+TWQ
         l6FWOtGBVouNyGZwrOsHZunuxEV3dlezu3QKJRfZJMgOejmvNZoZZWxEMYOLygqpcaIJ
         99Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159867; x=1720764667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QeNckosVxjolkEFvOsh5sX+5l80S9ypJGm7bOhl6bY=;
        b=oktkVs0Q8Rf+uCjr1rFeAJkXfMz4lmD+dIw4NlpXw/eJV8Bbi54N2NrvYp2gcS0vg+
         r1TNnzfeC6jhH4YwRDBpwt5BnLUGm9llwl9eK8Foou2dYaLNUla44MzYvIUXO+MMDI/+
         DdJyA/NY/Tr7kZiksBPRDszy42pDH2gHGEip+m0tujBy2qm+R+arBCcAwym4vBnJ5Jsi
         XP9grCaOpq41wDI9nV6foHpFEdt0XpJ43cFAP8CZNIi9FNFFuAyTrf97xDZezA9d4U4R
         0C99k5ikwYd42FnVHvJAx9k+YgOlvA17pAnn2OXtI4t7I7iPQZWFZZ/Pu0uNpppAeHHc
         +OFA==
X-Forwarded-Encrypted: i=1; AJvYcCWgQPA8/A1biS5QwwQ8LbdlvGZGCu9NLzmoqQBTjImsCctHANLbUKkdLkjL63muJvcyfWqtaEE+Z2Dj1GY8un7lDcspiBavq4JGvvh1
X-Gm-Message-State: AOJu0Yz1+g4pDShzlASm1GDf2IT0gN+u14nQSy+hyfYwxSBbG+x3fXXy
	i3OIoTT1FWghB50AY32khF4BBjeZEcIVenSrznNr5LtKMRu5ld6Z0Nk7wiW9yA4=
X-Google-Smtp-Source: AGHT+IHjkb8qjpcNsRKkVyx2hr2qJJKQ78xjRcgB3qu4zXgwtDuMcYcJHWND0BLXH2C/nnodAxjlzQ==
X-Received: by 2002:a19:8c48:0:b0:52c:e180:4eba with SMTP id 2adb3069b0e04-52ea06f7cbbmr2294130e87.62.1720159867137;
        Thu, 04 Jul 2024 23:11:07 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm47050405e9.7.2024.07.04.23.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:11:06 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Vladimir Isaev <vladimir.isaev@syntacore.com>,
	Roman Artemev <roman.artemev@syntacore.com>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 2/2] riscv: Check that vdso does not contain any dynamic relocations
Date: Fri,  5 Jul 2024 08:09:02 +0200
Message-Id: <20240705060902.113294-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705060902.113294-1-alexghiti@rivosinc.com>
References: <20240705060902.113294-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other architectures, use the common cmd_vdso_check to make sure of
that.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/vdso/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index c7e40bf36371..b5c73084e554 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -45,7 +45,7 @@ $(obj)/vdso.o: $(obj)/vdso.so
 
 # link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
+	$(call if_changed,vdsold_and_check)
 LDFLAGS_vdso.so.dbg = -shared -S -soname=linux-vdso.so.1 \
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


