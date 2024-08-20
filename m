Return-Path: <linux-kernel+bounces-294238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC7958B13
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F71282E55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181B193081;
	Tue, 20 Aug 2024 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OhR17+Gx"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFC6190667
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167473; cv=none; b=iSrU8dEhSLUfyK1cTJ18JBu+cIhGY1Ep9zCE5C9FOcHWc0FhUsWwFc+bGt752b76YYJV1+oI64ke5Ex1T/kdFkIz1sdcUuleByF54oGNbmCd18HycQZ2C6UHnlMTnMT2PWykQEfk1cP4oj3EvgVCtOFd+sEuhSKG5JujyzxU+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167473; c=relaxed/simple;
	bh=lHCuR+6j1zERFHSs+KvLhuwolO3WP77swGPzBPMSIJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aku5FRIlHRWU4EjTG0I5TapbczK+QDYFEc2sK+Ln68d+uopo3mhEW3dUHU3pKToeFGJWeUGrjTvBvgt0KetWlC7360tByTreYpLI20NWGfcEAlVi0yiMXXkveDekJyBaMnpkvzx3vpDYooIJThFWmYqHVgomZjPcdQk9i9JPA9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OhR17+Gx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a115c427f1so3448469a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724167470; x=1724772270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9HfCveIGD6wgO07CWK+R0yFcUzfSO61CbRgrTad0T8=;
        b=OhR17+GxmiQ+7WtH/9f14NpHEInGdO4rRM8XIprEZlboX6eUBf/rlCfydBnd37Kyxm
         DEx/UZZ9AHKGasCXohCF19xs06sFP8TwDC27uDIsxshhzffBdXJRB6KmeTTCUK8u4Wwi
         4yPc8Gsa8cAIpO/xHa/RDLWUORY4e+sdaltV1UzWTDokZHS7hMwDAvbBcGtEa8t5gcnE
         T8kxZjpMOcsIl/cEu6eT5LVdMZwNTFukIr/JxyCGU0W1/WQ/KGPD2sDtgZG1QFfx4sOJ
         pyOzxX3XnqeKR3M9ETbysKynmBUT792evxgNpSnMm5DG5EIuToHvDXzUhQgFso+wPa60
         fteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167470; x=1724772270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9HfCveIGD6wgO07CWK+R0yFcUzfSO61CbRgrTad0T8=;
        b=buq2zQ6KUm1+Hh6zPCPCGp3Q9O3tztqq+CTc836nCq6iqrUK7gOo3yJ2Vil4xLtkI9
         sT0J1uF4HbpTvrdzpW1vrJwU/MBXaYYi+QTjxHxNm2fUrvRLf5mpwI0059x7b1U9O2hA
         qtdrCB0ISJOXaGgSbc4rdPCUC0US1vRYo86CuO4zGo1ut5RD/HiX3Sz5sGD4lgyMKMwR
         H8ARUa8ndCtVx9WWoa+UGQYqaAzTb05gLL0ayHXrbwQ8zxhFhKzTYbxET6tflgqT/5g3
         56goyqdH75CHzWOCbFjuBVx5KfgFb/3AnPhJ9FFHAyQEfsYzxSo1YA6D6WJMY/188D6J
         qqZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFNk/yKceKWf04k5sSMhFDYsmFhL/ffckwgUimw+2eFL+ZJKLkVbqL27cfIthP8B+NYCFrAIvQsqtMVL6VCsFuhDVx+YhT39n2ft6K
X-Gm-Message-State: AOJu0YxiFG4M45q4ea2u0HCfARPnwxzenWIGWaIbN+3Et1YmSgXr62Cr
	5/ipOokMh9V16C0vAiAjqkalZ6YJSkK3HUUijURAttk8gYdf1D1OlRz/sH+VWzU=
X-Google-Smtp-Source: AGHT+IEFp8nNWtAhX07M+oXg7b8ZrLAlbIoqjPUVrUowEtxL+yOzQda+T9qdfMXpVJlBtO5ij749KQ==
X-Received: by 2002:a17:90a:d803:b0:2d3:bd32:fc7d with SMTP id 98e67ed59e1d1-2d3e0409749mr14730820a91.39.1724167469966;
        Tue, 20 Aug 2024 08:24:29 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d40bea7cb3sm7258157a91.25.2024.08.20.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:24:29 -0700 (PDT)
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
Subject: [PATCH v9 0/6] RISC-V: Detect and report speed of unaligned vector accesses
Date: Tue, 20 Aug 2024 11:24:18 -0400
Message-ID: <20240820152424.1973078-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
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

The Zicclsm is patches are no longer related to this set.

Changes in v6:
 Added ("RISC-V: Scalar unaligned access emulated on hotplug CPUs")

Changes in V8:
 Dropped Zicclsm
 s/RISCV_HWPROBE_VECTOR_MISALIGNED/RISCV_HWPROBE_MISALIGNED_VECTOR/g
  to match RISCV_HWPROBE_MISALIGNED_SCALAR_*
 Rebased onto palmer/fixes (32d5f7add080a936e28ab4142bfeea6b06999789)

Changes in V9:
 Missed a RISCV_HWPROBE_VECTOR_MISALIGNED...

Jesse Taube (6):
  RISC-V: Check scalar unaligned access on all CPUs
  RISC-V: Scalar unaligned access emulated on hotplug CPUs
  RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
  RISC-V: Detect unaligned vector accesses supported
  RISC-V: Report vector unaligned access speed hwprobe
  RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst       |  16 +++
 arch/riscv/Kconfig                         |  57 +++++++-
 arch/riscv/include/asm/cpufeature.h        |  10 +-
 arch/riscv/include/asm/entry-common.h      |  11 --
 arch/riscv/include/asm/hwprobe.h           |   2 +-
 arch/riscv/include/asm/vector.h            |   2 +
 arch/riscv/include/uapi/asm/hwprobe.h      |   5 +
 arch/riscv/kernel/Makefile                 |   3 +-
 arch/riscv/kernel/copy-unaligned.h         |   5 +
 arch/riscv/kernel/fpu.S                    |   4 +-
 arch/riscv/kernel/sys_hwprobe.c            |  41 ++++++
 arch/riscv/kernel/traps_misaligned.c       | 131 +++++++++++++++--
 arch/riscv/kernel/unaligned_access_speed.c | 156 +++++++++++++++++++--
 arch/riscv/kernel/vec-copy-unaligned.S     |  58 ++++++++
 arch/riscv/kernel/vector.c                 |   2 +-
 15 files changed, 465 insertions(+), 38 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

base-commit: 32d5f7add080a936e28ab4142bfeea6b06999789

-- 
2.45.2


