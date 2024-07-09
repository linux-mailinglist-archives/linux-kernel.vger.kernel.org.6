Return-Path: <linux-kernel+bounces-246494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333E92C2A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB6282C27
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F0180024;
	Tue,  9 Jul 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eVKB5Lbb"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027A17B03C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546783; cv=none; b=u3OH/4tPEDoDBgXZ/VMMXHWsKlbdZPiUIrNzd440v6BxtohzPGURFBEAlmTRM7TTaUJiHQyWcXeZNPZjAXGOOX9+/Yu8kialWD29HqQF/IFSWxMkekEPi0O8pPCAdX897NYrLi6kNmLD5jj6bXXDOVG30S2NKsbNn7+B4lzUr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546783; c=relaxed/simple;
	bh=MjG0wx0U38uUII74AFjua/T8NeFZTe9VZSo8JReQo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kpt9j/7MZMBBapijLeRWuIEa8ogvI4iepQdGjYkYRiRaZcHGW3oewbjgpp4JUkJrsYsZTuZRpKei5fS4Mj9cmKJl3M/qBIr06ollzOmDZRANdi+lOphJyDYZNCabDK7Ujo+7JllGFxybTcROneSQAio/XoVbKbB71w0RrLb7z6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eVKB5Lbb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79f1828ed64so103346185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1720546781; x=1721151581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs+9F/AX0q+LBs1CELfWwb/nqSLPDtCG32+ZAsR7dQo=;
        b=eVKB5LbbsrdICHv1BIXW/dxP1oT135IacCcWrqjbqlPrJ0znktR7tT9O/c/jraUX0I
         qSXwlD0C3jjlQxwivSF3XYHT91YlxWApyILuZerq9w3iuS4b0wZJRUVUY2BEsCIAIoM2
         Tl376b/qEaHlR7gfRVIAb3evG3WGTRpXGRQmMtJtWXjCCNwbdm+9GUA99tAqXRP6WyO7
         RuarDMP7FKO+RAE4KrznWzE0wPWaIzGjaJRJVjuz/Cf2QS2RPkdGeGsWhsLZA0N/rMhM
         Igbs0gzN6Z7HkXSSGxPcaAHjZ9bOiwA7LnjFMUyD2yWqR6sW9m19K5N2rgJykhIn998f
         ZBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546781; x=1721151581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs+9F/AX0q+LBs1CELfWwb/nqSLPDtCG32+ZAsR7dQo=;
        b=ierbyHjw8c+Qyd2z+wpzfz8fm7VvLB+p4vY4Tf7aLbax7nVpIOkxysuBH7f1DD0o7g
         fU6v1J8vKbrDKGrKxgUHO7Fq1XeSW+WahRd+q2JXBPz3ARFxWbjgz62WR1MsgRQueX8Q
         v2PdRyLN42bxFDS9Gw0pncFP/5tMhq6wdRSgjCQNr79yxyh0vxXjwUA3EXXpqEn8MX9M
         9bLGgNcjMskvG0hhRJiC8YmT2kmcSOtN0uBA8OC2M6v8r8HV8mdoKOSxyr5tLP8LX+SA
         AN4BUQNEkHZTLLDrdOip+hICwxPIkv5u5qT14qeFwD+KvOlA7mrffkaqfJ0Xjv/uvkMj
         8PLA==
X-Forwarded-Encrypted: i=1; AJvYcCWNI+dshPHcHjyFDWTbBIBwe/yu9nzGOv7aZZclT784K30KpXcp62vOF/P4GYGXGzZAESXrJCDVOBFwmvMNnDNblmkyJiEgCxHUpTWE
X-Gm-Message-State: AOJu0YxIhIB8m5yaewnRJh5Xd2VGxEujyg4ucdHnqleVbfaqctqgggVG
	WYY4dGDDQXnf0oCRk/Ql9KC7z6w3de98+sGDfNuX+TqVmcZomI7sQUTtCxZkuQs=
X-Google-Smtp-Source: AGHT+IF5vRwH3MAJLaUEo4+iqmQHIG8YR3UCz6IbvA0rf0+v0uyHD1q0n/vo2ks9owSgX2DYVwobqQ==
X-Received: by 2002:a05:620a:3b89:b0:79e:f7ea:2df4 with SMTP id af79cd13be357-79f19a5fd69mr325013085a.19.1720546780865;
        Tue, 09 Jul 2024 10:39:40 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6762sm117547785a.10.2024.07.09.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:39:40 -0700 (PDT)
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
Subject: [PATCH v4 2/4] RISC-V: lib: Add pi aliases for string functions
Date: Tue,  9 Jul 2024 13:39:35 -0400
Message-ID: <20240709173937.510084-3-jesse@rivosinc.com>
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

memset, strcmp, and strncmp are all used in the __pi_ section,
add SYM_FUNC_ALIAS for them.

When KASAN is enabled in <asm/string.h> __pi___memset is also needed.

Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
V2 -> V3:
 - New patch
V3 -> V4:
 - Fix duplicate the in commit message
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


