Return-Path: <linux-kernel+bounces-231259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8469189F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8E2BB2171D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA30318A945;
	Wed, 26 Jun 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VMU3PUH2"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C416F0DC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719422230; cv=none; b=nSnjvyqd7uuxm5mGL3ecptjzAJZ5qdiJpi6C1POpmoLOUbnGbcu6bxZuhz4yKrE6MCUbrO2KsucotX+igH10yJbZAMmQGhHoe80VqiZ4lfnR9N+tvRNz4PN9F20H6QswTqlQ3oXnBCPZH4s1FdDbkUd/jZyEZyvcxhEFkJm8OxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719422230; c=relaxed/simple;
	bh=RYtqPNzmP2LS2A3MM+323p7B2fymwB8mip9tfprdIks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEvJSdF418/iWhNsW9nmi0v9S1U/Qx2RgLNj027xtrZA3RtrmGMjxSLmaJaW96uArsYp8b1BdNYiFYDI8wGdbERM6xNyHrGcnrY0t3kyIh920YCPZsykXZGXi7QfwmYnkkJzAxk1K5CJoIXydrsHyoqDT3zSf17Xbno9Cf+IB+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VMU3PUH2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c825f0b381so4065205a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719422228; x=1720027028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfc+bItioWOLi2TuWFqieQ4WdP0MPgrB+J5zxVf671w=;
        b=VMU3PUH2A+LlDWzCVT7M55+S3S8AKyO6+gOAurgBe8gvChjafdmvpRq23fmX3qECUu
         GtWmsMU0/9bKRSGYy+LOpJnItCDpm3ZO2x/06YOBAxVogi3mo09Bb+wHPDyUd21PJRdo
         rpDO5BUijhMLiAjq/Zh9b+fEjY42HK4mvQ0FScNYlSQ6E17t8IhvuhKg6wsA23WgOnvY
         t/jDsaJsB7R19c6imzwlPC8uhxemMl54zdt1rtlfl9Xvau/IJvQh74w2VtHFvE0MDNFy
         TYalodumO6vWzWApezs01Vipi8PkfmfME2U3H6hkiHKhbxB8K0+NoJHRV6NTUoswKFoR
         347g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719422228; x=1720027028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfc+bItioWOLi2TuWFqieQ4WdP0MPgrB+J5zxVf671w=;
        b=ncE+xBDgqK/OlS6UsKuj1Un/IimREkNcQI6uxFKALHp/KO5CWuAjw8vzVRJd8qLseE
         M0krUSfoPEH1UUNJl21lM4MW0slDVklYdlhA2+lr2TftxyMgkgAIrIHY1GFscqQ3aur4
         4IA9+8rzC9VWU01OI8XT5t8adOY5YT+XUluWbtaS6O1uuFeJ8HqA7rZTGvb9J0nwshei
         pkYOouUnc1J5ABxZBAfBx9PfCjOE/Rn+/pRPE88lRKX3Njyho26eU0EhoKDtDjB6IbaN
         xpGlck+45y3MP+VUnQsUoTKS+ER2fbW0QtAAHMzYOWf5RPbJbazed6p2ZXCM+zRTN6HI
         adRw==
X-Forwarded-Encrypted: i=1; AJvYcCV115Qz7bzxVHKKjmHBb5ZQQMrWvyjxYxmXgICPudfdK6LheSuAj4A+SfbIUAWoPeoQOz4uelZWOmhiHCSGF71i+tuAOqq4FyrJb1D0
X-Gm-Message-State: AOJu0YyaweoNS5sdVFFWP/QGIYGACNPaoYS3CH+G/NcFI5O3uApZI4DW
	bKyMDHom5k7csqJnAcbnEXj0f2jjTrvWt90w5Sh+KAKD9u3FW8pC3Omr0tJqnTU=
X-Google-Smtp-Source: AGHT+IFRRYAJqPRgI7bs8MXpEZG6vyONCJH7c7jAbKBR0F7SXl7y1eqCXlLYI6Wy4OsF9R8wyxyQng==
X-Received: by 2002:a17:90b:b0b:b0:2c8:53be:fa21 with SMTP id 98e67ed59e1d1-2c853befb16mr11452942a91.34.1719422227952;
        Wed, 26 Jun 2024 10:17:07 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8f3b5ad36sm83217a91.26.2024.06.26.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:17:07 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Wende Tan <twd2.me@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sami Tolvanen <samitolvanen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 1/3] RISC-V: pi: Force hidden visibility for all symbol references
Date: Wed, 26 Jun 2024 13:16:50 -0400
Message-ID: <20240626171652.366415-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate all GOT entries in the .pi section, by forcing hidden
visibility for all symbol references, which informs the compiler that
such references will be resolved at link time without the need for
allocating GOT entries.

Include linux/hidden.h in Makefile, like arm64, for the
hidden visibility attribute.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/kernel/pi/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
index 50bc5ef7dd2f..1ef7584be0c3 100644
--- a/arch/riscv/kernel/pi/Makefile
+++ b/arch/riscv/kernel/pi/Makefile
@@ -5,6 +5,7 @@ KBUILD_CFLAGS	:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) -fpie \
 		   -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
 		   $(call cc-option,-mbranch-protection=none) \
 		   -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
+		   -include $(srctree)/include/linux/hidden.h \
 		   -D__DISABLE_EXPORTS -ffreestanding \
 		   -fno-asynchronous-unwind-tables -fno-unwind-tables \
 		   $(call cc-option,-fno-addrsig)
-- 
2.45.2


