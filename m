Return-Path: <linux-kernel+bounces-246493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DEA92C2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787EF282B47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CE917B04E;
	Tue,  9 Jul 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZfasdOr4"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516D158874
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546782; cv=none; b=KOTVB7kAyPg7VG463R4tNxVUcBmIrspWQ3SuwUIYzMppNyVXc7Fa2UfsUma1ETlJGcL4Fc485aaVn5sX3oA+mhIZnBxXKwVe+M2vG6qdBsE9hUMIdJmKQYQBIzngOzjk6tiKNc5nygX+IF0L8l45YLCVR2FY25QJ0+y8uXBGomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546782; c=relaxed/simple;
	bh=IeOtPKogez48r2P3oAafPf7mWpdrIEUVTbXKWkBu+s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pauIwZ8MaDIylhZvEbu3xYUsGpsctvgatu1Kz4YvZF+0k1Qko7FQnzy10aKygxVrO92beX2Vpj+nKLe/VH3h2+xgSqKEMO/CNI5gQFrZ90S6X3dwyXfieuvgTfegYmnyolFqiNn8QXKWq/Os9OK5XR4bjZ4K9ExDeOLph8UiNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZfasdOr4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79f0e7faafcso206833085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720546780; x=1721151580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIkiZ+EC0cy3qQspr3kP3SqSJopsA9NQAjKMM+c2r1A=;
        b=ZfasdOr4pOW9t5cYBOffk1hv5rM24nFULpEP4HNS+5QsCq1rsojn0M8dNqzjBRdwPu
         VUUQrTsKE6Z6VFiTGldSZjWjd0b2kUsXeALUDb7E7B/n/HdgtAtWiOIHKzmlwfo4ZPth
         bTECBNbpgPJhFPaCOjH8Vhopd9ME9SGec3RiapZ4rI0aznfwdyOs0at6VwDS/bIiW5bX
         qlC/h3naI+qXkKFjG/fbrAbyPisIYPRA2/RJ3AeDLWDJcW8592z/MO7hOwtyOH6/UrEC
         Auyy+5Wf+m8EG6u8MgIy5oHDqAzs52LVYEpwUVIZNPYXCjNP8WDEgcM1i+IrsfWNvoqG
         vTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546780; x=1721151580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIkiZ+EC0cy3qQspr3kP3SqSJopsA9NQAjKMM+c2r1A=;
        b=lxVlPIZXzoGfO+66mU1BN1KVp2c7mBKFHDpDhAPk7Rn76UbyA5ZzBCgxYCdaELi1Uf
         KQekGTNnt+Q1+9+rGoraU45k7MIuFNJq2mHSyNPxEpJtPiY+X14YSNUh3NLxBHuIuZAX
         jqmfJjxS0qyum1LZgSKOsk2uGVqyShtl2hO9Xmy97xYkplrD+zSthcTKfT+RG7qOuOgt
         qdAs8waTx7yBZd1BRTQVGHwCCpXEpT9A7Y42dFR9lE1xoS301lMVMF2wMUYWdqteVCBS
         9t2NAn42Z3sB7SIzUZk7AEt6zc6eLrnNwoytpLpsM68zNIg6dNITthSWxB9DOe6RvqTC
         pfMg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUljxUpGmzoki97H5PLu+Gs58Bu2U67mjkXL2eSg/R6SEjyCmfTbtQ/tO32h9as2Tq31aUrq5p5DDl4McpV7qEK839Rlyo+tuYtuH
X-Gm-Message-State: AOJu0YzkHURQp2qA93dpPUhzwZTS0O4dWDdvujx3tbbjQ5oCitfgTQM5
	fQh4xpiXt8Ih4/iDcEhsEDH/OT+SUGUUbEqBSgzzdbSlUwISpalaUcagjK76Cpc=
X-Google-Smtp-Source: AGHT+IFqf9MGCcfZzUZn5e2OPi31BYIsZtdOvyOYSAfI80AmjeHPmXW5Hh4FPbdEJB+RjrwEI5CSIg==
X-Received: by 2002:ae9:e017:0:b0:79c:f0e:f7ac with SMTP id af79cd13be357-79f19a1f8a5mr329303185a.28.1720546779837;
        Tue, 09 Jul 2024 10:39:39 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6762sm117547785a.10.2024.07.09.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:39:39 -0700 (PDT)
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
Subject: [PATCH v4 1/4] RISC-V: pi: Force hidden visibility for all symbol references
Date: Tue,  9 Jul 2024 13:39:34 -0400
Message-ID: <20240709173937.510084-2-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709173937.510084-1-jesse@rivosinc.com>
References: <20240709173937.510084-1-jesse@rivosinc.com>
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
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
V1 -> V2:
 - New patch
V2 -> V3:
 - No changes
V3 -> V4:
 - No changes
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


