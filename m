Return-Path: <linux-kernel+bounces-197109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3068D664C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61ECA28C891
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AF158D78;
	Fri, 31 May 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X2iXABms"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6ED225DA
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717171612; cv=none; b=HQpj7UEP9eBNxyjSllY/NLdadx86r/p/j0YEnUJI8cwNxkRzNAlI1dJPpXameMkpxe73b4Titvvl0+Yis7bpP/hM3vPdhAXcRnmFcB4Oq5B/wvMTJXEhBuwhIoVmnTfJfRdvfnXl7opfAD8j5ZcMtqDu1djriV0ssKpZSXxkT9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717171612; c=relaxed/simple;
	bh=7mwVVurPzUNChHUh1iMgSK0YI+J7pOF0uwbRcRDKm6E=;
	h=Date:Subject:CC:From:To:Message-ID; b=gBEmwdoAf/DfJK6VAjrcEEBInKDTNy8M8vc0pIamX7GtuGldHhB8YHu8U9c4XGZydb6kYtV+UUl2jPNAle53U7d8oklMCPUcw6MzIufoViGeNSQwAJYuF4365BcdVBiOpbFtuYqwGQ9qwBrzuRg9el4Papb42lziBy7tzfOiqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X2iXABms; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c19baaf564so1716817a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717171609; x=1717776409; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59bPOkit/bk/X5CUNpKpOBEpf+FwqR7nda+qLGURm8M=;
        b=X2iXABmstgQMbta4/lnXBKKLEROTnHb2NErMyj+ChHqqcGam1fFJIftVnrgpjDEPi6
         3k82+tKXFDXgZqXtSpJzuw5ZIx5MLxLZMPGWtFvzLwa16g9KYLtwD70OrR2csp9PwjC7
         TdKEds6QDwwK0Dp0MSbU9aSa4wGzcwNsoLpLXUFKcgLAYmeP4yRVju23QKxxwiNPGlAB
         J68A0om4DqFgCgewIuO1zHuAC/J4DqTs/tCJBoF2ewEq+gfBnl9VZ2o4kfSiuly2ey6b
         6nRE5S0O5P9/foRGhpYiPDDGCFmq5ouaJUhe2VbriAEclGXDyM4mL939Hecd2Sx1s3Cb
         wfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717171609; x=1717776409;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59bPOkit/bk/X5CUNpKpOBEpf+FwqR7nda+qLGURm8M=;
        b=PvlYTL+mtP1M5SoTD6eQiJq0d9oKF5DNkGQJ44PlAJEk3ItTWAQp31abSlnDIDwwGx
         luTXCt6m/Ee+QoYcn3KENLAnU73ozWGmM74Uwf0NXPtybP28p5Rfzqje7f13svoMmQP9
         z+LQKv64g9/iIELRK8BR2bmq+TriAzxCUyR+O/3glTfvwdEGneo5qsHBQiRYpXbULSeI
         WXkhq6MMtUUVa2PruMgmjZLUsNu+62XRq+hxERLuMHWGRVbSRUT8tqW9OnksiwH6s/En
         oSEWZxjnR+x//YY56f66cihV27bb3i6ZjM6U0ekLnHr416Ui1isaxNIVHBQ0aMJKuNdF
         IRKw==
X-Forwarded-Encrypted: i=1; AJvYcCUfG1AlE65FKkO+xQ5fKt3/np2JZqIJ8ppVsHxWkDOZmNXpJU0iIJ7W1UCP6MuoD8rynav5nP4lhi9rEQCdu69rtG6SGnQVXyMpfGqJ
X-Gm-Message-State: AOJu0YwidVMZDNpb0JLOVyU6XYNIGO32T2iTIG3cckaXugcI1TD4VkLU
	7YOFN+QhM1YXE4fkMKH4yBcjjv4XrHUbSSYOaNs5jFpGlsDNiDeQOCGdf18IXmA=
X-Google-Smtp-Source: AGHT+IEMigNfn1r6huzicsFKt2kn2Nt7nxSoyfkxZfZCNNTaNpu9jKUKM5YvL/KwFqdKX7px3NAhtg==
X-Received: by 2002:a17:90a:d593:b0:2ab:eff6:e2ce with SMTP id 98e67ed59e1d1-2c1dc4b3f75mr2568823a91.0.1717171609109;
        Fri, 31 May 2024 09:06:49 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c28450d4sm1651552a91.55.2024.05.31.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 09:06:48 -0700 (PDT)
Date: Fri, 31 May 2024 09:06:48 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2024 09:06:37 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.10-rc2
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d5ff54e8-e0e4-4b50-8461-c23eeb95b31d@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.10-rc2

for you to fetch changes up to 1d84afaf02524d2558e8ca3ca169be2ef720380b:

  riscv: Fix fully ordered LR/SC xchg[8|16]() implementations (2024-05-30 09:43:14 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.10-rc2

* A fix to avoid pt_regs aliasing with idle thread stacks on secondary
  harts.
* HAVE_ARCH_HUGE_VMAP is enabled on XIP kernels, which fixes boot issues
  on XIP systems with huge pages.
* An update to the uABI documentation clarifying that only scalar
  misaligned accesses were grandfathered in as supported, as the vector
  extension did not exist at the time the uABI was frozen.
* A fix for the recently-added byte/half atomics to avoid losing the
  fully ordered decorations.

----------------------------------------------------------------
Alexandre Ghiti (1):
      riscv: Fix fully ordered LR/SC xchg[8|16]() implementations

Nam Cao (1):
      riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel

Palmer Dabbelt (1):
      Documentation: RISC-V: uabi: Only scalar misaligned loads are supported

Sergey Matyukevich (1):
      riscv: prevent pt_regs corruption for secondary idle threads

 Documentation/arch/riscv/uabi.rst    |  4 +++-
 arch/riscv/Kconfig                   |  2 +-
 arch/riscv/include/asm/cmpxchg.h     | 22 ++++++++++++----------
 arch/riscv/kernel/cpu_ops_sbi.c      |  2 +-
 arch/riscv/kernel/cpu_ops_spinwait.c |  3 +--
 5 files changed, 18 insertions(+), 15 deletions(-)

