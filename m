Return-Path: <linux-kernel+bounces-246492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49892C2A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5251F236D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6554D17B02F;
	Tue,  9 Jul 2024 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TCHG0rGJ"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35351B86CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546781; cv=none; b=pjIbFNasMIqpwV5fgP8O/nwz2IbBPfijFyrM9iA378JVyY6n+6yiQwKAkiTlKt6IXSX71zvWpzM66/ptmbzC0VUX8Al44hZRLXAc36NFwxiV7DBfNvlkP/y5pHIYBUfAwHbke46FAzb7zduFpbIexmer18ojAxN9VFrHjZKwQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546781; c=relaxed/simple;
	bh=d0K/xZYfkfM7LYdV9v3IX6Evpj3aZ/O5jBSxXMFfgHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U9QNYxFrN8uSJ0S1Wh74fua8CX2912GW+K+qiDrlEiSk7XbLwx8y1xShcSy35UNHrr8pM0tKsQJdILtnwgJ0Z31J+H7kNTRW2JWs/eBgP4jfO1Zwl9r6XnQoLyFXBXA2F0CIJPFmiiiJSl1ABiNIEvUaqwfOhgWjlEh9jP59bJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TCHG0rGJ; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79ef8e0c294so275823485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720546779; x=1721151579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MkRq9pJZdtUmCqu5iT1gqMbhpvrDb9DS4nLumIGatQ=;
        b=TCHG0rGJfDqeKZxNyccPMAs8IxqWG+JsO8JVI4z0ZZHYwXc8U6mv6R6zDwbTAncPj1
         nd7tzqbeye82B6J3clHdLuLgiHeiRkfMKSbHM/M0tP2lD1Mm495tegy7ssNUmUtE0ZUx
         B0/BQnD6tBp6rvp9HEtvUNztHxUVEGUz1Jyybr7E8tuEmnteQkSdE1XDPbPy5j057LVR
         y7x+WfnWL/qED0E1G6zYp24AtpraU7MJbbBwCmEBKYic4sDjkEbkIwRKR4e9ETAcaHZY
         O+cgvdjdXLLhjsa41KdkvaP7GBtJIB0pubbuX4vQJq2h++MHvZy+3nJffROrjgwdRHLc
         v0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546779; x=1721151579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MkRq9pJZdtUmCqu5iT1gqMbhpvrDb9DS4nLumIGatQ=;
        b=RmNzE3yheWQ2s0zDMfzKdE+e+BgUd5lLwWUZToOgGPg161whdr6awWemAMuGXMzZPB
         A3dFvIQjZ7AU09KzKuy+uz6FC2VsXn1/77Jf1FjaZL9nohlf3bN4uPo+rqZkOUv6doe2
         /YK73VYTAftWGZcn6wjJtp6TN+iATCLC5dKKXl8JQ+kg7EeMunLdXccw8gcgA9NflWM+
         WePEFm9YyBDqRcp1z21dNLkOGoM5obmhZPbcX1gBgMdTs2J0FUudydlyw2F+gAKaTM8J
         DII4YAijIQeJxX/y4mii3VVIT8cSpNEr7N3+z45f7eGgPZ4WXXk3u8qeUJd6eCVxxDK9
         uMjg==
X-Forwarded-Encrypted: i=1; AJvYcCUdoBlw7DvZL/JWRQj920HMK12nA4xL/iWEL+pTKF/kQiAk+xx0jjS7ynpyos31E253rU7+uqdToZwdkl8PviKrsyD/6iXtZlIHo6qK
X-Gm-Message-State: AOJu0YwnM4kJ0X/CUPSkwMeQlyH2tFzDPz7VwhnPdBOiYAAWUeHr7get
	zEvGp3M76yXosbsJNAQRsx6eRkyZPKE9RZZdVxF5yQihicQaK997xS+Z6kGdIXE=
X-Google-Smtp-Source: AGHT+IGVttz6ocCRARNPeKFY4qZPLhSqhYKVAK3N9nGYjiO1emaTxC7eUVnojkoDW25ZMQuH4lzesw==
X-Received: by 2002:a05:620a:816:b0:79e:fec7:d6e9 with SMTP id af79cd13be357-79f1b5da34amr487803585a.32.1720546778885;
        Tue, 09 Jul 2024 10:39:38 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6762sm117547785a.10.2024.07.09.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:39:38 -0700 (PDT)
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
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 0/4] RISC-V: Parse DT for Zkr to seed KASLR
Date: Tue,  9 Jul 2024 13:39:33 -0400
Message-ID: <20240709173937.510084-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to pi/fdt_early.c to help parse the FDT to check if
the isa string has the Zkr extension. Then use the Zkr extension to
seed the KASLR base address.

The first two patches fix the visibility of symbols.

V1 -> V2:
 - Add RISC-V: pi: Force hidden visibility for all symbol references
 - Add RISC-V: pi: Add kernel/pi/pi.h
 - Rewrite archrandom_early.c to parse DT over checking the csr
V2 -> V3:
 - Add RISC-V: lib: Add pi aliases for string functions
 - Rewrite isa_string_contains in third patch

Jesse Taube (4):
  RISC-V: pi: Force hidden visibility for all symbol references
  RISC-V: lib: Add pi aliases for string functions
  RISC-V: pi: Add kernel/pi/pi.h
  RISC-V: Use Zkr to seed KASLR base address

 arch/riscv/kernel/pi/Makefile           |   4 +-
 arch/riscv/kernel/pi/archrandom_early.c |  30 +++++
 arch/riscv/kernel/pi/cmdline_early.c    |  10 +-
 arch/riscv/kernel/pi/fdt_early.c        | 167 +++++++++++++++++++++++-
 arch/riscv/kernel/pi/pi.h               |  20 +++
 arch/riscv/lib/memset.S                 |   2 +
 arch/riscv/lib/strcmp.S                 |   1 +
 arch/riscv/lib/strncmp.S                |   1 +
 arch/riscv/mm/init.c                    |   5 +-
 9 files changed, 224 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
 create mode 100644 arch/riscv/kernel/pi/pi.h

-- 
2.45.2


