Return-Path: <linux-kernel+bounces-265938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C71C93F7E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9053DB22E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAE156C5E;
	Mon, 29 Jul 2024 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bHhTjYEC"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0820015623B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262979; cv=none; b=cp0GR9GqJpVFSucCTo7KDyBZUe8hH4CM+XIwdMs8znvLqZXQjMPz9H0+ASMZd5h/B6yW5ibO7hwqQzW5A5pBf7GmiEhPUf0iITLs8PQREOudNRRkcKail2sdGsOiZu8bZsqh64KQf+dgoUADo6VIMJwKTltflxg4KLbe8AQHMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262979; c=relaxed/simple;
	bh=sScopXmovudAsqbJyMC7yH2ky9uniiyX1LDFRrxkAUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mc1ZQceQEDyu61Bip7wWEkHzkVxL+YoUOOPHr2Oy1DMHGk8vihUts4Em0Ll1AMHGY6fgAhS5r/AKD16QCiMPT0pqo6bLv7KkyyrSO2NklHXRmDpqDassupDt8sHLuBWWIHv936k3OE26kM+fLIPEfbSdrbSXU5EGIR/X5NePD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bHhTjYEC; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fd66cddd4dso27975295ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722262976; x=1722867776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkI/YPwu8wJ5PNbwGGR4w+MjTmxGUFvSH5JbVG/VQcY=;
        b=bHhTjYEC2NDVoo7hlGkZiBgYYm28yxj3vQ6BlnV0gOQHfewPaZki7aPCTlt23A4LEr
         jme+4C0w1Ke7vOFRVy+w00tKfzahh0epoU0ydwtiLDI1TqZjfKTMsm6p+eJSHWNAMmYe
         g9Iy6GiWHxti3MjWNibRNURhYc4nu+Ml3z1hlNKESpTQknLVb62z4WpmvUKyZBliPGJ3
         nsq56L2sDhP4p0itjkh4tVnT2ZEr1xw8csXcRRZCfbufefsGSY8hPn2qelc9uk9+WRap
         hEJ0I8UyW6JCWQxNDStEkPC+moCQsXc3tTQl19gzglpbHIg9GNIIbm85EnicBroRWAlT
         EgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722262976; x=1722867776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkI/YPwu8wJ5PNbwGGR4w+MjTmxGUFvSH5JbVG/VQcY=;
        b=I8dIfZLtx24YZqnFgGbD9CFpbvk9bN9PAblZJu2W3FunKhdC/8yBO6PHQTeE9YiJ4i
         0i8dmPb0jN/cnmgk/iDx1CJQXUzzYNbLxwgewPtbqJQWMnA0PnTcSWVN0fUzEtR357Vp
         FXsW4SUFAqu7mBtp6xAS1g9xvu6RUA+YPZzFCxtzQIWOZFweb3RczBgTV5hp6/cz6E8R
         1xPifDkwhhsJ9g0/lb0IuSre3cIst9CCP//g8U2+DuiezIwAaQgsb0mpNRiJAPBWjwV6
         cQK7ur88SNtYzkGBhgQAjx2LSArgdb+isPSCdW8P1afK6QuXCPPZNJLmq7YvWlgbxTom
         MjYw==
X-Gm-Message-State: AOJu0Yw2iqJIz/ysF4qjapUzOhAIl2iF3XT3kBb5O1kaPD1bvevlC+Qy
	sO/QKoIhCr5HcoeAZTpAOAHda3/wSbo7JaN1nqCYtrp8izzfnVaaBceR3RjvzLZOQXAo4TCk6dX
	HjYESNwwl
X-Google-Smtp-Source: AGHT+IFu2pJ5dNieAOu9bMlgY9EggxA9WocXkTcmCBi8QE4Nvs+9akNp4MJeZafUd/u17WLDS+4BCg==
X-Received: by 2002:a17:903:190:b0:1fd:9420:1044 with SMTP id d9443c01a7336-1ff04817e13mr87916955ad.16.1722262975263;
        Mon, 29 Jul 2024 07:22:55 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm83512965ad.263.2024.07.29.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:22:54 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v7 00/17] RISC-V: ACPI: Add external interrupt controller support
Date: Mon, 29 Jul 2024 19:52:22 +0530
Message-ID: <20240729142241.733357-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

The series can be broadly categorized like below. 

1) PCI ACPI related functions are migrated from arm64 to common file so
that we don't need to duplicate them for RISC-V.

2) Added support for re-ordering the probe of interrupt controllers when
IRQCHIP_ACPI_DECLARE is used.

3) To ensure probe order between interrupt controllers and devices,
implicit dependency is created similar to when _DEP is present.

4) ACPI support added in RISC-V interrupt controller drivers.

Changes since v6:
	1) Update to commit message/code comments as per feedback from Bjorn.
	2) Rebased to 6.11-rc1.

Changes since v5:
	1) Addressed feedback from Thomas.
	2) Created separate patch for refactoring DT code in IMSIC
	3) Separated a fix in riscv-intc irqchip driver and sent
	   separately. This series depends on that patch [1].
	4) Dropped serial driver patch since it depends on Andy's
	   refactoring series [2]. RISC-V patches will be sent
	   separately later once Andy series get accepted.
	5) Rebased to v6.10-rc1 which has AIA DT patches.
	6) Updated tags.

Changes since RFC v4:
	1) Removed RFC tag as the RFCv4 design looked reasonable.
	2) Dropped PCI patch needed to avoid warning when there is no MSI
	   controller. This will be sent later separately after the
	   current series.
	3) Dropped PNP handling of _DEP since there is new ACPI ID for
	   generic 16550 UART. Added the serial driver patch instead.
	4) Rebased to latest linux-next.
	5) Reordered/squashed patches in the series

Changes since RFC v3:
	1) Moved to _DEP method instead of fw_devlink.
	2) PLIC/APLIC driver probe using namespace devices.
	3) Handling PNP devices as part of clearing dependency.
	4) Rebased to latest linux-next to get AIA DT drivers.

Changes since RFC v2:
	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
	2) Dropped patches in drivers which are not required due to
	   fw_devlink support.
	3) Dropped pci_set_msi() patch and added a patch in
	   pci_create_root_bus().
	4) Updated pnp_irq() patch so that none of the actual PNP
	   drivers need to change.

Changes since RFC v1:
	1) Abandoned swnode approach as per Marc's feedback.
	2) To cope up with AIA series changes which changed irqchip driver
	   probe from core_initcall() to platform_driver, added patches
	   to support deferred probing.
	3) Rebased on top of Anup's AIA v11 and added tags.

To test the series,

1) qemu should be built using the latest master branch.

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

NOTE: One should be able to use u-boot as well as per instructions from Björn.
https://lore.kernel.org/lkml/87a5lqsrvh.fsf@all.your.base.are.belong.to.us/

3) Build Linux using this series.
Since serial driver patch is dropped, SBI_HVC console needs to be
used. Enable below configs while building the linux.
CONFIG_NONPORTABLE=y
CONFIG_HVC_RISCV_SBI=y

Run Qemu:
qemu-system-riscv64 \
 -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
 -m 2G -smp 8 \
 -serial mon:stdio \
 -device virtio-gpu-pci -full-screen \
 -device qemu-xhci \
 -device usb-kbd \
 -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
 -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
 -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
 -kernel arch/riscv/boot/Image \
 -initrd rootfs.cpio \
 -append "root=/dev/ram ro console=hvc0 rootwait earlycon=sbi"

To boot with APLIC only, use aia=aplic.
To boot with PLIC, remove aia= option.

This series is also available in acpi_b2_v7 branch at
https://github.com/vlsunil/linux.git

[2] - https://lore.kernel.org/lkml/20240506140308.4040735-1-andriy.shevchenko@linux.intel.com/


Sunil V L (17):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  ACPI: scan: Add a weak function to reorder the IRQCHIP probe
  ACPI: bus: Add acpi_riscv_init function
  ACPI: scan: Refactor dependency creation
  ACPI: scan: Add RISC-V interrupt controllers to honor list
  ACPI: scan: Define weak function to populate dependencies
  ACPI: bus: Add RINTC IRQ model for RISC-V
  ACPI: pci_link: Clear the dependencies after probe
  ACPI: RISC-V: Implement PCI related functionality
  ACPI: RISC-V: Implement function to reorder irqchip probe entries
  ACPI: RISC-V: Initialize GSI mapping structures
  ACPI: RISC-V: Implement function to add implicit dependencies
  irqchip/riscv-intc: Add ACPI support for AIA
  irqchip/riscv-imsic-state: Create separate function for DT
  irqchip/riscv-imsic: Add ACPI support
  irqchip/riscv-aplic: Add ACPI support
  irqchip/sifive-plic: Add ACPI support

 arch/arm64/kernel/pci.c                    | 191 ------------
 arch/riscv/Kconfig                         |   2 +
 arch/riscv/include/asm/irq.h               |  55 ++++
 arch/riscv/kernel/acpi.c                   |  33 +-
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/pci_link.c                    |   2 +
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  14 +
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 335 +++++++++++++++++++++
 drivers/acpi/scan.c                        | 103 ++++---
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  69 +++--
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  64 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 160 +++++-----
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           |  90 ++++++
 drivers/irqchip/irq-sifive-plic.c          |  94 ++++--
 drivers/pci/pci-acpi.c                     | 182 +++++++++++
 include/acpi/acpi_bus.h                    |   2 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |   9 +
 25 files changed, 1113 insertions(+), 377 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.43.0


