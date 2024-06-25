Return-Path: <linux-kernel+bounces-228116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72915915B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E841283E76
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5EC8FE;
	Tue, 25 Jun 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WKraHZPP"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ED217557
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719276622; cv=none; b=NKN4I6WGcd0ezCxEeUHuZZ/33YLMqnxYTpfPZCBt4mpoOYnlREc098YR4eRMgqeR4GC5ubXmdChhgnBPXow8HqBGqq9fLNVcA70FV9hzahOTnP6kLlPSk6nXQABKTaq83VWOcoLJQo2PUwxjMicYCVSckKJNsSmMNMwej07x694=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719276622; c=relaxed/simple;
	bh=xfavRhkPnZCS2POrDvsuNxPZ2zYbwjnwZ52u+3fooG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVDu2hxhO0e+Mkv5RClvU0rpQIrvnyj0gou+RNpLPTFbnMzxtrM1meXNSj5Yu8g1eMFkl4Q9SjVQlHqHxlus33JYrTlGczmamZoC8SpvghfRePIdIvQBEz6ysAEaOeqGv+aHdU2ktk8Nt7XtaTDUdLBGjz5T/cOjExXqlIEl6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WKraHZPP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f47f07acd3so40644255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719276620; x=1719881420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nnSgK6fY+iLtRTDSAhrszcxAOUvzG0XuSCnjEWrisjQ=;
        b=WKraHZPPG+oSj9CXeLmi9tF45NEC1AX6yOW4PvX2n0K0IiJnOSmDYmVDRLxXKF23mr
         bkTGqSgeKa5QrqbI3a5BvQuuOvN5POduzJHrz+0oSPLrOlfJfkBc75QXqV1ywDT56W96
         1aS6wEaCPGmAdV+OQ9aeO09KrW3BTzFfuf7xOdYoNGAVcV6ZBcglnKiNanh7TN+6vGJI
         OszpTVNaTwa5qkH44nSTTPh4u7vzDUgmXbMhoh/3E5q6Mf+aGjOeNG/YfN/pOYzRWCPf
         t6TrZg4s+j686bPEEfKk63bXc0CH3m0qy4mygA8/CttvLXul0Y9TNnLXhfW4AJsPxFG2
         pS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719276620; x=1719881420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nnSgK6fY+iLtRTDSAhrszcxAOUvzG0XuSCnjEWrisjQ=;
        b=vquydEs9s7as2UG+ZNtXg4ixcSjAx/YaNg7+ilHap0V/+YNf2MutviMY0c5v8Og4ea
         R7b+aNUPWlhIR1KzafTn8W3qv7kEEABi3WaT7dAJC+vBqZ0o4eZUhoV6bDkkiJXzMCVB
         ZUIsKHKjAbGf9D6ezGzFE29diAy+Xw3aT0F/k+OPKaJ1iFZGoZonF4MxwUYHuA8loGQI
         8bURPRMxvJGdDyzV8k/hkI19irWXNzxFU+DCrx+UtvfSqZ8Z+Rdoyv9p+rqxBkTwSWx+
         xLImA4UyymHom90Uo3q9zu6afQEmUxq1uvX4teSkTNWGVtpLdLFLkCTWq/MAV+ELmZdD
         BUPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsYhdB2TwuHbuUZfpz+APiEFnNEMc4lIXjMgqRKeUA8iNmiKyryiCOEh9CR8zegvemYVSKFkAvC9GGiaQesHGubpijvQDMEuaY6DZb
X-Gm-Message-State: AOJu0YxY6TrgHi8tgh8+cUJB59jaMUxciTG1ScMS8esn4LGp8ygCOLfs
	s63uRTHzfSuplQvglUyqY0MuTuWEDmb7AdElS7owM9zc8gkLGDqCKSDdICv8/h4=
X-Google-Smtp-Source: AGHT+IHApu4tSWv9QAY/GKACS90i6vXuL/EeTsIFIOOg7FuFkA0Ybzt8e0yLcPcwfLJUGW/EmQK7pQ==
X-Received: by 2002:a17:902:dac7:b0:1f8:6bae:28f with SMTP id d9443c01a7336-1fa1d3e00bdmr81145035ad.9.1719276619768;
        Mon, 24 Jun 2024 17:50:19 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm68150235ad.256.2024.06.24.17.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 17:50:19 -0700 (PDT)
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
Subject: [PATCH v3 0/8] RISC-V: Detect and report speed of unaligned vector accesses
Date: Mon, 24 Jun 2024 20:49:53 -0400
Message-ID: <20240625005001.37901-1-jesse@rivosinc.com>
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

If Zicclsm is present, the kernel will set both scalar and vector unaligned access speed to FAST.

This patch requires the following patche to be applied first:
RISC-V: fix vector insn load/store width mask
https://lore.kernel.org/all/20240606182800.415831-1-jesse@rivosinc.com/

Jesse Taube (8):
  RISC-V: Add Zicclsm to cpufeature and hwprobe
  dt-bindings: riscv: Add Zicclsm ISA extension description.
  RISC-V: Check scalar unaligned access on all CPUs
  RISC-V: Check Zicclsm to set unaligned access speed
  RISC-V: Replace RISCV_MISALIGNED with RISCV_SCALAR_MISALIGNED
  RISC-V: Detect unaligned vector accesses supported
  RISC-V: Report vector unaligned access speed hwprobe
  RISC-V: hwprobe: Document unaligned vector perf key

 Documentation/arch/riscv/hwprobe.rst          |  19 +++
 .../devicetree/bindings/riscv/extensions.yaml |   7 +
 arch/riscv/Kconfig                            |  57 ++++++-
 arch/riscv/include/asm/cpufeature.h           |   7 +-
 arch/riscv/include/asm/entry-common.h         |  11 --
 arch/riscv/include/asm/hwcap.h                |   1 +
 arch/riscv/include/asm/hwprobe.h              |   2 +-
 arch/riscv/include/asm/vector.h               |   1 +
 arch/riscv/include/uapi/asm/hwprobe.h         |   6 +
 arch/riscv/kernel/Makefile                    |   3 +-
 arch/riscv/kernel/copy-unaligned.h            |   5 +
 arch/riscv/kernel/cpufeature.c                |   1 +
 arch/riscv/kernel/fpu.S                       |   4 +-
 arch/riscv/kernel/sys_hwprobe.c               |  42 +++++
 arch/riscv/kernel/traps_misaligned.c          | 143 +++++++++++++---
 arch/riscv/kernel/unaligned_access_speed.c    | 159 +++++++++++++++++-
 arch/riscv/kernel/vec-copy-unaligned.S        |  58 +++++++
 arch/riscv/kernel/vector.c                    |   2 +-
 18 files changed, 480 insertions(+), 48 deletions(-)
 create mode 100644 arch/riscv/kernel/vec-copy-unaligned.S

-- 
2.45.2


