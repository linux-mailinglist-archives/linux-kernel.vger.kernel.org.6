Return-Path: <linux-kernel+bounces-392409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F299B93CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB0FB21166
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160301A7ADD;
	Fri,  1 Nov 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2fWTET5d"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C919D080
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472932; cv=none; b=j9iWgWuwoZ8ilHS45Dx2fVRt8ksDDYkgAvklhoRD3AG46d1pQGbepu4WfaZ8A/eLh49Q66v9sq51bx63VtEyTTavM97WG2vCwj58mKWzPE4CSY266yETNk003XMkduLRr/K1K0iwfIP7iuWZDLEMfPek08gQQMgQyDDcEH3L/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472932; c=relaxed/simple;
	bh=WFKrBtdsnLk47Bj7XAFZ/yjyO+94HwmT+YT+LIJhduM=;
	h=Date:Subject:CC:From:To:Message-ID; b=kWumG8fb+RWrUAR2jMRPBsiNJJFKvWaPQSf99Qq4EGTaHbRQARMDA8+k2uJvvFgjcR1CD1w4yr9+ZJcvO5Fo6rgDmrR6zHkOVhlRpEzA46oWsjuv1bZSX8PUZ6FV6jKoKhCnQrZfF8xx/7cqU0wnTHsqb4QrSRlfxCFO6ANpqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2fWTET5d; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so7748715ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730472928; x=1731077728; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt4swa51EyBN4N5PTpyvNVZrsawgvt64yABO9gRAyRQ=;
        b=2fWTET5d8amCtKfU0FqZxl54FzxxLVaj977yMQbsrggo2PMRl8KLD38mL8EFVX77Fr
         QgSIxMfOa47t1BqGqkMyiGaAFaC7AKx0gMowHHbRRDNf4vq+/FcgZnKpXsC96ioWOeUg
         /dQr4WN9YiL9hR1o8EWqT94F9jm1IdNgcEc/zKIpQU2crrXs+Crv3XgVA034n7jJrTij
         9AyEmnMv2Ia53+ufn8lfNqog813bqiU9scOTrwpPkNoVW8njRoLq1ApKd7Px4ui5sIvG
         HJ8vRQR0XmMhHnHa8W80Wuhbs/9jrggl1dYg7C6UZHJm1zgtRsqxkBd9iFPosRr9POr8
         HqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730472928; x=1731077728;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bt4swa51EyBN4N5PTpyvNVZrsawgvt64yABO9gRAyRQ=;
        b=jivMJ/RoDawW0JjrdPw+M3Le0AZI3zsJAssxLpqzRUU+BmeC5M7XoU0g5iUm7qD00l
         ICz2ArjHV/g8+Twnq3sXY7ySPsKDB/rl7fhy6LlezUGJhKpZ/UGoVcTEMOLHiMz1zRLW
         zV0b4M3kyS/lCSCMzVQGVmqLw7DU3moStZGZc5Of2899ob/ke8c+HpVId5/793kSytR1
         VoofKt/9YvMZIRv0i19ekwwf/mJx6dEP8ECiJDdxZvYlM7IIJJyqXNDwb9+tnYnr/C7M
         7J8rnUX+qALCqz2cy/GvHiEGBg5l4cEloKdUKa5TLaK0lbErGDmKo4Uxc/TZ2Uv03943
         JgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmrGHJPdF/9SMfG2kqO++NrQoiXUb8/5vnkDfSk1Gztcv7khEk02TtuqAPfJTvvdWd8NHrBOavaGq5RdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb738cvg/xsLueZ9KaKQeFGxc4vY8rOW3YtZAPjsPL4F9Vn5HN
	C++tZ6K2yjdn3LruDNLVeyp8aegPDSgcXQMrxsCLskDeYs6Tr/PFInHEImW/7lsaUXIc/Lz8DdY
	u
X-Google-Smtp-Source: AGHT+IF6j94hRrP4ekrDIjKXWPXH4NsjnW7rLmSJyhM+Ymq1LEGaizXtUkSqACmK3j6DTgKj58BezA==
X-Received: by 2002:a92:3645:0:b0:3a5:e57c:58d4 with SMTP id e9e14a558f8ab-3a5e57c5987mr77149225ab.20.1730472928397;
        Fri, 01 Nov 2024 07:55:28 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45297636sm2550019a12.12.2024.11.01.07.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 07:55:27 -0700 (PDT)
Date: Fri, 01 Nov 2024 07:55:27 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Nov 2024 07:55:08 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.11-rc6
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-26039e8c-5759-4214-aaaa-765d5736b6a4@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit cfb10de18538e383dbc4f3ce7f477ce49287ff3d:

  riscv: Fix kernel stack size when KASAN is enabled (2024-10-01 13:08:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc6

for you to fetch changes up to 5f153a692bacc295f213e2c632ca557979fad7be:

  Merge commit 'bf40167d54d5' into fixes (2024-10-25 06:18:43 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.11-rc6

* A fix that avoids accessing the early boot ACPI tables via unsafe
  memory attributes, which can result in incorrect ACPI table data
  appearing.  This can cause all sorts of bad behavior.
* A fix to avoid compiler-insert library calls in the VDSO.
* GCC+Rust builds have been disabled, to avoid issues related to ISA
  string mismatched between the GCC and LLVM Rust implementations.
* The NX flag is now set in the EFI PE/COFF headers, which is necessary
  for some distro GRUB versions to boot images.
* A fix to avoid leaking DT node reference counts on ACPI systems during
  cache info parsing.
* CPU numbers are now printed as unsigned values during hotplug.
* A pair of build fixes for usused macros, which can trigger warnings on
  some configurations.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: vdso: Prevent the compiler from inserting calls to memset()
      riscv: Do not use fortify in early code

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Conor Dooley (1):
      RISC-V: disallow gcc + rust builds

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Miquel Sabaté Solà (1):
      riscv: Prevent a bad reference count on CPU nodes

Palmer Dabbelt (1):
      Merge commit 'bf40167d54d5' into fixes

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Yunhui Cui (1):
      RISC-V: ACPI: fix early_ioremap to early_memremap

 Documentation/rust/arch-support.rst  | 2 +-
 arch/riscv/Kconfig                   | 2 +-
 arch/riscv/errata/Makefile           | 6 ++++++
 arch/riscv/kernel/Makefile           | 5 +++++
 arch/riscv/kernel/acpi.c             | 4 ++--
 arch/riscv/kernel/asm-offsets.c      | 2 --
 arch/riscv/kernel/cacheinfo.c        | 7 +++++--
 arch/riscv/kernel/cpu-hotplug.c      | 2 +-
 arch/riscv/kernel/efi-header.S       | 2 +-
 arch/riscv/kernel/pi/Makefile        | 6 +++++-
 arch/riscv/kernel/traps_misaligned.c | 2 --
 arch/riscv/kernel/vdso/Makefile      | 1 +
 12 files changed, 28 insertions(+), 13 deletions(-)

