Return-Path: <linux-kernel+bounces-236867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6491E7F9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D19282E74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4B16F0E7;
	Mon,  1 Jul 2024 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HM+RhpJJ"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BB29CEC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859919; cv=none; b=YwsaJLISIeDeYYQNlJ9sq0N/SXX+2w1rtkbVHYG886gS7q/g9V85GQIkOatYcCeU8g6mRv0sR0NjzlA/V7sDaChFFmA2YyaUREPl4hJlZ3/qUytPD/CmDNm0AlXZ9btBRnke1EY5ucACqWBuY5KMZT/IBHv9zs34bvHoDfV/IOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859919; c=relaxed/simple;
	bh=D1FfI80APT75GF2QjHis1jKlW0nJV+tood2WPBXp17g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3jK/+pSL2ZqtdAk2W/NCoFhVpVWm5Ygkca/7bdn0SVaJ9E26WdxMk7oklYdQZImxYM6K0YpmWHW3NA22TRpAegchnzAiQ8FvFE7ugEHQ21ms1ZPJYcXrGyBkNhHrYtIUXhvM3wATPxWrYx5Y+Nz2nFB2hNVzBxi8DOk/f39weI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HM+RhpJJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9b523a15cso22456065ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719859918; x=1720464718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anHX1DM3URGCkXrGn4JIrBeC+s/73VzKMiEIav89N4M=;
        b=HM+RhpJJXMPB9l2cK8I9vfOsK+Ki2jkBOw/lGuR+wu0ixlotFK5tNwxJrqyjWzGh2A
         7S+r/QLVuz/uzTR0erCIKZRt+FL+ym7xt+FB14rXphJhlav1yAr2x5/yuhmEpwHkdJmO
         7q6VdOWhWx021h+9oRv+geet+p7AAMNzkC5OzS5iKqx2tn2LLMrySAvdjd7Z+r35Xo04
         lOTETa3gqhnQcelGeQGY8htNFZG4rR9rHXpAdGIh9d9+j0zBNov73427cRiCeIiIuj2M
         CvY3lQSYsmlE7FEmlC3hd5iRkvkTlCIM6zxQpYNXGVq/oXKei8Vvc/UrHGYekTOmqY7M
         zCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719859918; x=1720464718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anHX1DM3URGCkXrGn4JIrBeC+s/73VzKMiEIav89N4M=;
        b=KLiFjP6RS6kfKJFQ9bxmHfBDII8LL8mutwurxuC/N68ykqmgZJuL2lnwdozuZSJkOR
         hCX368XczvJHo/sPbfZ82K3AZ0CVtEc5TzOJcfqba5uP2goRkhk+biRNww6xYS1yfyLY
         sIXh1DwCordNFDNig/OvvxVbtO68qlmJ6YgzjWOZx2lDrMMrVOGUga8nfwVRjphQilUX
         jS39WzYl7RFLGWFM8ZYSDs2J9tsyEFOqlR2SNR2OEq8HSiqlXhMiMknc7FYMYu3UNJI2
         65IfpD1gvHUgYtRwPbqlZp3pz2MyYe4O8qMIxztWVZWI28HL5x4AF0i2/L3UDamVr6px
         9MKA==
X-Forwarded-Encrypted: i=1; AJvYcCVoPVZPdf3/s95275BD5L7TflGhusWCVh3BcIEo6Orjm7K30DyagBnW5nnOgX4hb1jXXSCs+2YG+W7pVUf11eiZJaAFj9LRVewv2wiN
X-Gm-Message-State: AOJu0YxiRWRJG7UFWIQRUAFlpn8+Xi9q3zfdUDKkkny2VbUHhOjLcBbz
	keXeRwTKhg4h7pTQk6ZxRziVmqSM0UplKYDwwGm8lTGPQyXvtXtedFwYCQ+caD4=
X-Google-Smtp-Source: AGHT+IENBUzEg6ya4sq7aW1QaFBBcsao6oM/eWof/SzwO+QqO8+WPKu4MnxkOTanbSTh10xlJQnXDA==
X-Received: by 2002:a17:902:d4cd:b0:1f7:1d71:25aa with SMTP id d9443c01a7336-1fadb42d78bmr110124205ad.6.1719859917674;
        Mon, 01 Jul 2024 11:51:57 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1ccesm69883375ad.20.2024.07.01.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:51:57 -0700 (PDT)
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
Subject: [PATCH v3 1/4] RISC-V: pi: Force hidden visibility for all symbol references
Date: Mon,  1 Jul 2024 14:51:29 -0400
Message-ID: <20240701185132.319995-2-jesse@rivosinc.com>
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


