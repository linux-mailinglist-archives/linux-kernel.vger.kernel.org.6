Return-Path: <linux-kernel+bounces-236866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638E91E7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A74F1C21C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A016F0DE;
	Mon,  1 Jul 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Dl5izcVn"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C529CEC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859909; cv=none; b=UpYxFQa6TRn967SDWsU/+bfnt+kY9cy1mul4Khcgj25j4g8V0Vb+P0/xSBe1CKQLFRCPXYuuYudzr5CPAd05jryFSeHW7u7fLhWH+IQ9zhIox67dIY5WGpkQKYRWlxgjDaWxBpEbJCGlFmvAPM0ZofpJw0CfqqE7EBqm6RyPPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859909; c=relaxed/simple;
	bh=ooGpiLMdOUHx9iLz4koldab/tmycHJSpp5+5KE1OqLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxN3NP4Y43nSiP6gtbcYkj2Z5UQMSPHY6zk4wNvwtvFLSJdXnRsfFCiiVr8N4ipd3JJ1BW3G49AnfkoyRfARj23hSvmwsTEVbSzwZY9YpUudGn4THrblM+18HBj3iaxZsA1MDQgH7/YdI3bGmKmgjR9042C0o/WpKKpajqRP6Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Dl5izcVn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fab50496f0so18916275ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719859907; x=1720464707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9BR+n8cp6lBjZjGDk+mYOf3wt+diD2m02XG7xJApEuY=;
        b=Dl5izcVnDoOofILfIfzuztaFjTKa2+2yjLyifSKdZdTxF/HJYkjYRy7HTxMVIC05rb
         VTxHikKirEYlsHOrg4kOlqfV7sFKfSkr5XuaNeXIT2GkwXr5YptdH+n27ciJQPh+dEX8
         2e8awAf4EnJxFSxFytvX8JdU4lVix+cEhq1XCm8LyxDLcBEi4RFwBL41kmIZDWf/vIkl
         +qNookGKhMCmv+WSrQ+mJIxwTM8g2+9mfHwGo8Ya3HKSys54/3Cb9F5eXLVeFZuSQeOG
         rRKs+xr9Oer6pAn2qopMBGjxU6mRFMY4zyoaBn15O0vOCf/Pjf8R7M6bZcwLHeAQWezG
         ZhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719859907; x=1720464707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9BR+n8cp6lBjZjGDk+mYOf3wt+diD2m02XG7xJApEuY=;
        b=pr+OzmiQpHL5dKw5FNparNjsXCbl8uJdWVqgwoG17vD9GBKaYa4nQwl6uW2OMiQFut
         tJqVmJBaGBguWxWikHyU5UIj1dZchgcUmiyPNXWhL6c3JWW22vmZZRXzg7fLHXASLLeq
         2vnQ7fVsiUviZlBblG85T9COFOk9JAAj/Rak01L+O3ZWpKs0wHKuVSEZMlzWIasj9dnr
         XD0wA6UFxgQZCKhmf/4AYRmSgVj7ZVFwLswrTfxQlAc6TDhgbENrns4uekzqmSaIXEiX
         jB+QAObs0K7TZsff0ceOvxvX8imZ76kMG6x502FxjhjdOHYjUAHzB9Is/YbOZ1Dydixw
         hk+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0cFIFnU1fH66/f8kuJIygGl5nXBuMqZbZ4P03ec7ucCZyn9F6bEOPOD1GIt6fekleN0zoZlZlsMSXHGfGf7KHJ48ItBNUlTCos04g
X-Gm-Message-State: AOJu0Yzc1PP88NDUSjZme3fxlzeLcOdzRVmf83A425bvh70zwXS91Tj2
	bN+DKRzogbIzulHpGx07Dt/c0NRAp6XdxjC28CmQQzelX18dqYV0nSiaIIB135A=
X-Google-Smtp-Source: AGHT+IGIhR4q2ffdDOA70LUc/qAQrNnvQG1rQn60lll7aXKMs5f7a9ja1/d5Jnpik/LL3vg+/X9cqg==
X-Received: by 2002:a17:902:ccd2:b0:1f6:1780:f7b1 with SMTP id d9443c01a7336-1fadbc73cdfmr44672915ad.17.1719859907340;
        Mon, 01 Jul 2024 11:51:47 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1ccesm69883375ad.20.2024.07.01.11.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:51:47 -0700 (PDT)
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
Subject: [PATCH v3 0/4] RISC-V: Parse DT for Zkr to seed KASLR
Date: Mon,  1 Jul 2024 14:51:28 -0400
Message-ID: <20240701185132.319995-1-jesse@rivosinc.com>
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

 arch/riscv/kernel/pi/Makefile           |   3 +-
 arch/riscv/kernel/pi/archrandom_early.c |  30 +++++
 arch/riscv/kernel/pi/cmdline_early.c    |  10 +-
 arch/riscv/kernel/pi/fdt_early.c        | 167 +++++++++++++++++++++++-
 arch/riscv/kernel/pi/pi.h               |  20 +++
 arch/riscv/lib/memset.S                 |   2 +
 arch/riscv/lib/strcmp.S                 |   1 +
 arch/riscv/lib/strncmp.S                |   1 +
 arch/riscv/mm/init.c                    |   5 +-
 9 files changed, 223 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/kernel/pi/archrandom_early.c
 create mode 100644 arch/riscv/kernel/pi/pi.h

-- 
2.45.2


