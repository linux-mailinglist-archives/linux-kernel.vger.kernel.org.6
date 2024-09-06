Return-Path: <linux-kernel+bounces-319198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C921F96F92B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D442864C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E991D3653;
	Fri,  6 Sep 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DrgJYsKT"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2C6130E57
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639694; cv=none; b=liDGnkMkTn1jZSn8xnvuhhOEYsyAfz2DoXcgFmNoNs35sonii0BZtKS0LkcP2wpKIacm67Ei4yfVmrchOqR5efloN4yzShLSBTlGwklpdHscn1o07zL8tnurxf3AkZWyXVkmpEp7Hf9hEuaK8oxYZ+89Au3R90Xkj9qRvai571M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639694; c=relaxed/simple;
	bh=XUiFl+NfhcoFhDvs/sSprEsyUo8jhiqXMXbejPCwIeg=;
	h=Date:Subject:CC:From:To:Message-ID; b=uTWkqW3s0zJAzpxnUPmjf+JMmqZ4uh+9FmGQGyBiHSyouOXL3nM+f22c84ZyKlG6fDp6W6me39XM6s9rzF+cmQjhUUx3lUYq7LTVD9M+CPbTGfkPdJ4kbKnsd5jl21V5q4Ay8uewTqmZUiui98JX9LrP841W8unmPcCblxF3jFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DrgJYsKT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2068bee21d8so23787185ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725639691; x=1726244491; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eYtctJfTJlMWL5l2Lu9nbkftuipcA6blBFQEhlLdB8=;
        b=DrgJYsKT1hRFYiW1OpXCSl4o241IlbRce6M1ddDFi3c1m9dcKX1XwMeez9Mr1zvNIn
         xz+a9KufMl+KDueVHdJ9yWr3KVRjw7ibhQ+x9HIVQBzqdvOzN+vxmDTcytacjv6ux7QP
         u2GVes6GfTXr9N2BIYXA8poUZlGj4gsh65jOT4atfC1GPppSftYF1y+Z5fJI6wTldvZE
         lnWQJTf6sqlTDnwD4VGmlmSXHt8lYu+n+C9mWIfjhAC6S0LgxeKTv9BZJJOgBgevTdbQ
         T6lFFYiB6JXm1yUYBEDC/jf56rJHZsj8754RwOndslvdmdbzkGEd6/skrH5lONGwZ1tS
         SBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639691; x=1726244491;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eYtctJfTJlMWL5l2Lu9nbkftuipcA6blBFQEhlLdB8=;
        b=wA1wjmQhixDmUFbMEzqSxVJJU6w1asPkiUD0rJv/NWnCyCL3hMeA6BuR145MqVaxph
         nSyTkzR5ijjQnguhckNEDdGrdN78se1tmYZ+3spb0tlF0ScqofNFqyja3cMiTRr3KNVR
         aqnvSk8q3ZxIYV/3g83JMREl8ZJ3+Nwgt3CmSjLqugk06TqbcAEqft/5oax6CHVu4J64
         pTGbtCT8DVTLtkvo1o+vg6qltDFXNoWh9BOlqoWscVqdvVZ5S2v1p+meaKM6s7aKKWcb
         3rD5kg1b2+3b8Yx4ee/0PsZ/jmrNg1x5vBy2Q4p5cFGPkBQ5aYJO5YJbOUcRawScBmU4
         XIpw==
X-Forwarded-Encrypted: i=1; AJvYcCXf6pzjR5Bv6gtZJoqCqZQajJsR2DMegjm2dkP7paFsdeuDcj5rwMaBO3bci4nLVwlj+IVplh6u7L3lkzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweSOADrqDvuVChIYWYTHMkN+TlteM/WyLkfBGx3OYMn8XqjBp
	ODtQXkQ/0+eTmi0XBKY3Pjz1AMk3bZJslWr6P5ajtHFwJU7anVnKj07wlTjLLVd5RD688xynkA/
	F
X-Google-Smtp-Source: AGHT+IFrxyzqMcF2UeehBPT3CymEL6yHGMozxetkTEC0Q2e1Ixf8Bdnmqn+Nx69DjJsy2v2toYrq+A==
X-Received: by 2002:a17:902:e749:b0:206:aafb:4a91 with SMTP id d9443c01a7336-206aafb4aeamr114695635ad.50.1725639690771;
        Fri, 06 Sep 2024 09:21:30 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9505b7sm44789525ad.89.2024.09.06.09.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:21:30 -0700 (PDT)
Date: Fri, 06 Sep 2024 09:21:30 -0700 (PDT)
X-Google-Original-Date: Fri, 06 Sep 2024 09:21:27 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.11-rc7
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-43509d97-4d3a-449f-b4d7-74f1041daefc@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 32d5f7add080a936e28ab4142bfeea6b06999789:

  Merge patch series "RISC-V: hwprobe: Misaligned scalar perf fix and rename" (2024-08-15 13:12:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc7

for you to fetch changes up to 1ff95eb2bebda50c4c5406caaf201e0fcb24cc8f:

  riscv: Fix RISCV_ALTERNATIVE_EARLY (2024-09-03 07:57:55 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.11-rc7

* A revert for the mmap() change that ties the allocation range to the
  hint adress, as what we tried to do ended up regressing on other
  userspace workloads.
* A fix to avoid a kernel memory leak when emulating misaligned accesses
  from userspace.
* A Kconfig fix for toolchain vector detection, which now correctly
  detects vector support on toolchains where the V extension depends on
  the M extension.
* A fix to avoid failing the linear mapping bootmem bounds check on
  NOMMU systems.
* A fix for early alternatives on relocatable kernels.

----------------------------------------------------------------
That mmap() one is particuarly embarassing, as it didn't even fix the sv39
compatibility issue we set out to fix in the first place.  We'll have a better
fix for this, but I figured it would be best to get the revert out as it'll
need to be backported and it breaks real workloads.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Do not restrict memory size because of linear mapping on nommu
      riscv: Fix RISCV_ALTERNATIVE_EARLY

Anton Blanchard (1):
      riscv: Fix toolchain vector detection

Charlie Jenkins (3):
      Revert "RISC-V: mm: Document mmap changes"
      riscv: selftests: Remove mmap hint address checks
      riscv: mm: Do not restrict mmap address based on hint

Palmer Dabbelt (1):
      Merge patch series "riscv: mm: Do not restrict mmap address based on hint"

Samuel Holland (1):
      riscv: misaligned: Restrict user access to kernel memory

 Documentation/arch/riscv/vm-layout.rst           | 16 ------
 arch/riscv/Kconfig                               |  4 +-
 arch/riscv/include/asm/processor.h               | 26 +--------
 arch/riscv/include/asm/sbi.h                     | 20 ++++++-
 arch/riscv/kernel/Makefile                       |  6 ++-
 arch/riscv/kernel/sbi.c                          | 63 ----------------------
 arch/riscv/kernel/sbi_ecall.c                    | 48 +++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c             |  4 +-
 arch/riscv/mm/init.c                             |  2 +-
 tools/testing/selftests/riscv/mm/mmap_bottomup.c |  2 -
 tools/testing/selftests/riscv/mm/mmap_default.c  |  2 -
 tools/testing/selftests/riscv/mm/mmap_test.h     | 67 ------------------------
 12 files changed, 79 insertions(+), 181 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi_ecall.c

