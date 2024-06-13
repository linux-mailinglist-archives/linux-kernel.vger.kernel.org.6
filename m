Return-Path: <linux-kernel+bounces-213893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325B907C20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A03B22F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986E914C585;
	Thu, 13 Jun 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NCFslb8p"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F212F50
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306198; cv=none; b=TUaudZnfEfGp70xFlkF1KcgSvQ0+8B8Rmrg86tpq6IXb/6j7XnNxRCLdO8vWJuGkaep2fLlkifa5kTobUOa5fJQS/qaVZAdkFqRJvVxthQQr8Ifet1h2VDnFQVjfA0vNhEBBNK7YT7f/HStu9xQ1D/Pa7VJ55a4eACeVhDrssvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306198; c=relaxed/simple;
	bh=xwz2gGVasPLG4WICRlhAaUV6zxKEkVvjxfn+L/yOsK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6eerDq6v0hiI+iqmuXG9jkmBG8cs1Z+BM7Ea950SNtZbrPXziR80uC0LMtFesc7HfK2a6ONPLS6bVtClNgQ9TO64M5BoIKnlscjP+scJjtbqCth0VkUnL+uzVMbyju+Vd51pctOXjavp2wxDkOYG50aIFuWP90DBv+/FS9SMO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NCFslb8p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f64ecb1766so11601915ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718306195; x=1718910995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpOwinj0W1yetvQNtkELpr5Kiud2ruzeFCMoj01VdbY=;
        b=NCFslb8pBIwyyil2TGL5uUyQi3bwW3CfWqDmgEpcXozuF5NHnSAZLFDm7gOSY3yGhR
         VZeyg5FgRmFzK36fWdCinVqVftCeaDx3sPxSp0qMZrfCd+IIKdLZjpP6ig6igmNimKIG
         SzZ13IxlTAKAfTvspd/xAfe0GGedWsRNcG8W5DTH1VJ2TztylOTfVOp8hCFC/w8o112a
         PHKjQUzOVH5YranCPXjRcuv9MKTzSxXU3OhPlfNsgSXBh1Clei2uLnDgFwBhrds9bKTW
         T3TMOotDrNHH7Q1SqSfCzufuZ6lJb+EiLnawL/VMi3v6alVUwwM2z7hgNIOruqAOIOLK
         01sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306195; x=1718910995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpOwinj0W1yetvQNtkELpr5Kiud2ruzeFCMoj01VdbY=;
        b=gNSk5Hy1xN8sRx1XHNUlTIdvASkKmZMqPC7ToSojEBFUmrthNP6YylGqh1v70HFoHe
         56pN4rgePYhUMEV4zZAVA3SQcTNimmNzeGTH0uG3ZIkbnbCbrBYk8zvLPVhnsvulVMGL
         +kq6XTBtEYIYyVHYF+cfJh35y7TlXSiebny3FIabL92Xy1zd8NLnodT/0wJfoKIPstuR
         6Q7pQ5VScHY90xRooAiao90GDZ63JijgmaV6yJurg9oL4VWSFDuWgu63jlmYA8gVOMEk
         X+1rLst3MNYwba/Uxa1VCTcQMr0Sdc73rSOuUPe+qTQC0SRZAk03ltK7/Q+Nbu2X0shH
         fmDg==
X-Forwarded-Encrypted: i=1; AJvYcCUW8ME1qzhN3OtUmfMh3rA68WFlelxoLCVOVMaQsW6NZgOTku3elFD1lkRydgKoKX8yLQdlZQR1sZASBLAejxT2vUO4x4J13/um3WmH
X-Gm-Message-State: AOJu0Yx3yuE/L5kLF2r2n8tztFf3q7yTG3QC3YJ31wO17RlqkLdh5Y94
	Rk6V9E1L7s9UHo/6tslcyDM+B1nGkPDEQPHXz3FCuNwlthN4N2r8E11f9wq/KAE=
X-Google-Smtp-Source: AGHT+IHHy8Y/gbuqVUoKIBAHl3Kik8dEPGS63zG9zTuBzI8FXFYH9pTlmfj7DD0pHAJEd7bxMGtqFw==
X-Received: by 2002:a17:903:1249:b0:1f7:393c:fcdf with SMTP id d9443c01a7336-1f8625c0537mr7044225ad.6.1718306195179;
        Thu, 13 Jun 2024 12:16:35 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm17471015ad.106.2024.06.13.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:16:34 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Eric Biggers <ebiggers@google.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Zong Li <zong.li@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/6] RISC-V: Detect and report speed of unaligned vector accesses
Date: Thu, 13 Jun 2024 15:16:09 -0400
Message-ID: <20240613191616.2101821-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for detecting and reporting the speed of unaligned vector
accesses on RISC-V CPUs. Adds vec_misaligned_speed key to the hwprobe
adds Zicclsm to cpufeature and fixes the check for scalar unaligned
emulated all CPUs. The vec_misaligned_speed key keeps the same format
as the scalar unaligned access speed key.

This set does not emulate unaligned vector accesses on CPUs that do not
support them. Only reports if userspace can run them and speed of
unaligned vector accesses if supported.

If Zicclsm is present, the kernel will set both scalar and vector unaligned access speed to FAST.

This patch requires the following patche to be applied first:
RISC-V: fix vector insn load/store width mask
https://lore.kernel.org/all/20240606182800.415831-1-jesse@rivosinc.com/

Jesse Taube (6):
  RISC-V: Add Zicclsm to cpufeature and hwprobe
  dt-bindings: riscv: Add Zicclsm ISA extension description.
  RISC-V: Check scalar unaligned access on all CPUs
  RISC-V: Detect unaligned vector accesses supported.
  RISC-V: Report vector unaligned access speed hwprobe
  RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst          |  19 +++
 .../devicetree/bindings/riscv/extensions.yaml |   7 +
 arch/riscv/Kconfig                            |  59 +++++++
 arch/riscv/include/asm/cpufeature.h           |   7 +-
 arch/riscv/include/asm/entry-common.h         |  11 --
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/hwprobe.h              |   2 +-
 arch/riscv/include/asm/vector.h               |   1 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   6 +
 arch/riscv/kernel/Makefile                    |   7 +-
 arch/riscv/kernel/copy-unaligned.h            |   5 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/sys_hwprobe.c               |  48 ++++++
 arch/riscv/kernel/traps_misaligned.c          | 142 +++++++++++++---
 arch/riscv/kernel/unaligned_access_speed.c    | 154 +++++++++++++++++-
 arch/riscv/kernel/vec-copy-unaligned.S        |  58 +++++++
 arch/riscv/kernel/vector.c                    |   2 +-
 17 files changed, 484 insertions(+), 46 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

-- 
2.43.0


