Return-Path: <linux-kernel+bounces-236869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448B91E7FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC0FC282D44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627316F0F9;
	Mon,  1 Jul 2024 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U6INx+Nz"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F86710F9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859930; cv=none; b=Fei/8BdFtWdY4/WyNTp2RoikdKqwLwngWXfrVdaS8/4PV9FDHwpFhHeDSrW/ZjwqMU/HwRVr4ObtiACBh32efxeQm7XVXVA1nYerpD1WiziJeTqXvaR6nK/KezxNgF24HX4NfjuVSPqnJXtWlsVuDGidM4oVlcq08pRRrxerlKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859930; c=relaxed/simple;
	bh=q1vCMlpyvueGwlO+m60gcYRBt/B42mbcvrDQZVWRBUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0bzezmYgvdt1HoQUDzxDT8wyllqWRiK6YXj/UaicungnmnTfSeX+3BUuIo3L99L5t887yVUcsX35wU0isWtLxKovUoPc1YgmaiGr2ynD82HXFMfihuGDLV3WqcN74N7a1LY38J/HfQBePv4Q5WD4RuyhWy0deHlbmgkzLHS3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U6INx+Nz; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70670188420so2184153b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719859928; x=1720464728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS9GYxuXw7/qz6F0Huo3Gpz70QhA7niN6kxlAksoOL8=;
        b=U6INx+NzVlYvV8/tnuS339PszPiIMX0rjXcusXkklKe8DXJc/sBryXig5p6V3Ox3bt
         KApAdMSrciwmvqPUYF+0T+TlrN/ZFMTUhUYrszc18kO2V3fRJ6sDJEHgCv3ifw0kXDb2
         v3NqwQT1Ia+4lEXVzrSv8OAloCKqzQ8kzPdE0VDMai9Ca7GTQyzNfpci3mU2frIJ93ke
         D3q3vRAVP7F6IiD8mrMSbFWQAUgUZ9pe3Qy12laGI0YRXC9ahisrLvz2Y31CgyVe2NUA
         1J8AtUb36FN4lLCTnBcsqAEcaIlQBAnZfolqr/Yd9x2uWyqp/uchVwYDz390z1r+gVfA
         hWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719859928; x=1720464728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS9GYxuXw7/qz6F0Huo3Gpz70QhA7niN6kxlAksoOL8=;
        b=Lf3XJm3+U4qbQUtPb4xmX8KgVWzz+uQMVe+/z+ipeqUU1pCmxyMf9r7iS90G9xoSqn
         pDe4eqrhPIK3Sf2om4R93E3ZFk06c+uSt25QWynLyNsL1IrLFaXqiuNR0xVUjMmTB1pq
         m08LE5IRykI1S9qmrFhJ33pwH3bBFjt6wS7YzCWhNmCcR3dHKBfE57+gUSkCguql+LEt
         MBPfiJY4tvBfzsGjnjtIQORsHUxV7fUY+ONyL7TJz+wsN0MR62eU0DXIw6NoTcsiA3bP
         fMejHyRCzCg5xUT4BTS3KwSSctZXKJc2XbWTvTwBCaEeLKGyS6I10vxv9iFqNar4poiA
         Nkjg==
X-Forwarded-Encrypted: i=1; AJvYcCWj+L/bRw4RwVB1G/5VtdpRcob8hqXPrnCAewy8jqIsnLk+fn6keN4FflAebkBe05oWgushGTceUZ2i58BVvhnz9VICDqf6/Ybzodyv
X-Gm-Message-State: AOJu0YwaOcMKFxvy1HKBTyPht05fwq/dJNJIfP+nbOt+ot1Yx/C9VqCt
	3/sNrVw+lQdG+DGUrP3BXhhdouBjMpJ5Cm2w9DDTud869qvoEmzvAkooZk18k64=
X-Google-Smtp-Source: AGHT+IG4RGDVsfQVAXbtDLxsNorbihdnFaeyKDYqlytZdtsd3sF4TSa+MDTMQVNkNGIHeIsWv6QxPQ==
X-Received: by 2002:a05:6a21:7885:b0:1be:e4dd:17a1 with SMTP id adf61e73a8af0-1bef611ba18mr5678163637.5.1719859928442;
        Mon, 01 Jul 2024 11:52:08 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1ccesm69883375ad.20.2024.07.01.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:52:08 -0700 (PDT)
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
	llvm@lists.linux.dev,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 2/4] RISC-V: lib: Add pi aliases for string functions
Date: Mon,  1 Jul 2024 14:51:30 -0400
Message-ID: <20240701185132.319995-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701185132.319995-1-jesse@rivosinc.com>
References: <20240701185132.319995-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memset, strcmp, and strncmp are all used in the the __pi_ section.
add SYM_FUNC_ALIAS for them.

When KASAN is enabled in <asm/string.h> __pi___memset is also needed.

Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
V2 -> V3:
 - New patch
---
 arch/riscv/lib/memset.S  | 2 ++
 arch/riscv/lib/strcmp.S  | 1 +
 arch/riscv/lib/strncmp.S | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/riscv/lib/memset.S b/arch/riscv/lib/memset.S
index 35f358e70bdb..da23b8347e2d 100644
--- a/arch/riscv/lib/memset.S
+++ b/arch/riscv/lib/memset.S
@@ -111,3 +111,5 @@ SYM_FUNC_START(__memset)
 	ret
 SYM_FUNC_END(__memset)
 SYM_FUNC_ALIAS_WEAK(memset, __memset)
+SYM_FUNC_ALIAS(__pi_memset, __memset)
+SYM_FUNC_ALIAS(__pi___memset, __memset)
diff --git a/arch/riscv/lib/strcmp.S b/arch/riscv/lib/strcmp.S
index 687b2bea5c43..bc73325b2fd1 100644
--- a/arch/riscv/lib/strcmp.S
+++ b/arch/riscv/lib/strcmp.S
@@ -120,3 +120,4 @@ strcmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strcmp)
+SYM_FUNC_ALIAS(__pi_strcmp, strcmp)
diff --git a/arch/riscv/lib/strncmp.S b/arch/riscv/lib/strncmp.S
index aba5b3148621..b36325a57f6a 100644
--- a/arch/riscv/lib/strncmp.S
+++ b/arch/riscv/lib/strncmp.S
@@ -136,3 +136,4 @@ strncmp_zbb:
 .option pop
 #endif
 SYM_FUNC_END(strncmp)
+SYM_FUNC_ALIAS(__pi_strncmp, strncmp)
-- 
2.45.2


