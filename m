Return-Path: <linux-kernel+bounces-272769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17C49460C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE001F20FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCEA1537C0;
	Fri,  2 Aug 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jrl/ePhw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92428175D28
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613493; cv=none; b=Q9rj/3iJQD1tLmhCHrUt/bZlvU6uX11zANXB/xSnEOdJonDTiQARTiy3krWJrNkQ1B7v1yieQDfotcWzg+BSWX9v/D78h/YfS+kP3Y0LhJl6Rat2u3Ow1tDkJscnJb7OuhDj67orNBuDzhDok8rGgaghToio5agQiwD9M66VBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613493; c=relaxed/simple;
	bh=7FCqDFM7XgTHwKknjOtaGybhrqujIzXmd7w5vT886mA=;
	h=Date:Subject:CC:From:To:Message-ID; b=EGDAgLnvd0UDPsmnoWcZ/ELlu1FM6PWAhBMPSheDK0ABQgS2Dwgjk9FvnHesqHyaM6dW036DcjQck+D+hi9985jntiVh3aDxBQquFpSbci/AYK1a3Af0A++Ct/psu68o5DA4YrHGyh47JaZHEUMj+hV5+UdKdhof15YexIujGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jrl/ePhw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fed72d23a7so64745445ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722613491; x=1723218291; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0U1KOccehzmg9c81F1T02tHdqMUqqEFdlWexUs39Wg=;
        b=Jrl/ePhwZMeCtUBhazU03TRWlowm67lUlaFVwEmgv2ZSUqIVB+eO+aM6/Dwe7dSIH6
         4kzKF09tA7qMVZSaT9IK24DmlFor3+1sPxPdB1RfQtzOO2TzphEcrgoc5rVVjkkd2+kw
         /9jY6URx0LKpv81yBn/PW5ZXLpfw8zXhuKgI1kvtA40e9qMe3duCuJgOjzLt3Vajv/HR
         wwL//dmHU4gRW9UGsTWLPN0iQoodOfQUzP/e1hefRu9mz07AuTlNWCA8Mi4KmSxvzKfy
         GqpIPvkurka3nkN/2fnCbK8CNbJxNH193781v6ufQUhxg489LMKim24cmppUpK3qHFvK
         wpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613491; x=1723218291;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0U1KOccehzmg9c81F1T02tHdqMUqqEFdlWexUs39Wg=;
        b=kdNPihsxqkCVFQ6fmNTUJr7qI3TPTa76ZqMVnHBzlW2dVv2yy2OC5itCPrvDztiUC+
         f6QTXxZa+VLR0iqEQLr2zeV8L8N+3lNeeqV12+oOUqXMtHB34OATVpfcUdZJrRm+u4Aw
         oW8B9sYZiwWEgMMKaNgALq0wHcgUR04plUl8Qw9n5bb6QEj28gZrr/O/uDWINQoB3uu8
         hWeebRG4YV8/6Qd1aTx+I16kAF1dbLhzC9bDYtNlq5IMtwCbxDrAtwbR9P6EMvF/ccR2
         UcnEK9zP2WPlKQ3qxcthnwuBE8BkOePlEZ8sNdfpB4bqiSNqgdIi7S9Dxz2/FGI7GdSw
         hdVA==
X-Forwarded-Encrypted: i=1; AJvYcCV68rCQ1jAh93T2D4/C/0MLFaiARl9RaAqJ6PHk1McStAcjpkNZ7mlvm3rIvM1WhCEEWZiZlE3Rjp+c61Uh+CQ7uFHZRI57cAg7GAq4
X-Gm-Message-State: AOJu0Yy8RALJD6d5B8acYGmES5p/F+CO5684O2VBDDLcSniz694OjhbU
	GjXkQKXjshTBf62WpBKBR6sdE1NWHS7BkpvN2X8cT4E/xSHa96ScmeiZqRpXuPUz967sTkEZsVc
	z
X-Google-Smtp-Source: AGHT+IFctPtOfBeOT+7DbRwz3VPOEeBuaua5STZcnvm6v4ibpnesppc5XHD7NFFzRv80ZWXrE5jXvw==
X-Received: by 2002:a17:902:ceca:b0:1ff:629e:221a with SMTP id d9443c01a7336-1ff629e24f2mr14018755ad.4.1722613490688;
        Fri, 02 Aug 2024 08:44:50 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f19d0csm18750255ad.2.2024.08.02.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:44:50 -0700 (PDT)
Date: Fri, 02 Aug 2024 08:44:50 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Aug 2024 08:44:38 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.11-rc2
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-43770bb1-d5ee-499f-8925-ade7d59c6f38@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc2

for you to fetch changes up to 3b6564427aea83b7a35a15ca278291d50a1edcfc:

  riscv: Fix linear mapping checks for non-contiguous memory regions (2024-08-01 11:46:09 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.11-rc2

* A fix to avoid dropping some of the internal pseudo-extensions, which
  breaks *envcfg dependency parsing.
* The kernel entry address is now aligned in purgatory, which avoids a
  misaligned load that can lead to crash on systems that don't support
  misaligned accesses early in boot.
* The FW_SFENCE_VMA_RECEIVED perf event was duplicated in a handful of
  perf JSON configurations, one of them been updated to
  FW_SFENCE_VMA_ASID_SENT.
* The starfive cache driver is now restricted to 64-bit systems, as it
  isn't 32-bit clean.
* A fix for to avoid aliasing legacy-mode perf counters with software
  perf counters.
* VM_FAULT_SIGSEGV is now handled in the page fault code.
* A fix for stalls during CPU hotplug due to IPIs being disabled.
* A fix for memblock bounds checking.  This manifests as a crash on
  systems with discontinuous memory maps that have regions that don't
  fit in the linear map.

----------------------------------------------------------------
Daniel Maslowski (1):
      riscv/purgatory: align riscv_kernel_entry

Eric Lin (1):
      perf arch events: Fix duplicate RISC-V SBI firmware event name

Nick Hu (1):
      RISC-V: Enable the IPI before workqueue_online_cpu()

Palmer Dabbelt (1):
      cache: StarFive: Require a 64-bit system

Samuel Holland (1):
      riscv: cpufeature: Do not drop Linux-internal extensions

Shifrin Dmitry (1):
      perf: riscv: Fix selecting counters in legacy mode

Stuart Menefy (1):
      riscv: Fix linear mapping checks for non-contiguous memory regions

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

 arch/riscv/kernel/cpufeature.c                          | 14 ++++++--------
 arch/riscv/kernel/sbi-ipi.c                             |  2 +-
 arch/riscv/mm/fault.c                                   | 17 +++++++++--------
 arch/riscv/mm/init.c                                    | 15 +++++++++++----
 arch/riscv/purgatory/entry.S                            |  2 ++
 drivers/cache/Kconfig                                   |  1 +
 drivers/perf/riscv_pmu_sbi.c                            |  2 +-
 include/linux/cpuhotplug.h                              |  1 +
 .../perf/pmu-events/arch/riscv/andes/ax45/firmware.json |  2 +-
 .../perf/pmu-events/arch/riscv/riscv-sbi-firmware.json  |  2 +-
 .../perf/pmu-events/arch/riscv/sifive/u74/firmware.json |  2 +-
 .../arch/riscv/starfive/dubhe-80/firmware.json          |  2 +-
 .../arch/riscv/thead/c900-legacy/firmware.json          |  2 +-
 13 files changed, 37 insertions(+), 27 deletions(-)

