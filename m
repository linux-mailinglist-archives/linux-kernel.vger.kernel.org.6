Return-Path: <linux-kernel+bounces-215706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23406909620
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AA31C214F8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E55512B71;
	Sat, 15 Jun 2024 05:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PNUY0Cd5"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFA101DE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718429271; cv=none; b=G28ypFHyYHp6mBPHhAQajBBhQWNxcVvS8aBkEx+z7+narF1owzxLjKYecbEuIYn7b7xNAi9P+gf7N9rK9OMAXi4fagRssWAx91Zhp1c+NYEge9AOFf0TIDzmgA1ioHBiHa2h7KSWN462RCyU1VgF9qdukq3l11xPE10pE5VnFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718429271; c=relaxed/simple;
	bh=mA3Hhmq6fqwvMPCKWI5U2Cg2yOiBjniZrh4w8wHC9P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hYSj4mrPPelh08K+xAf2ej3XT/KLzNfC5SGkvJg70OBvJ+hOSag155A+nDrk1zfHODdiDTJ7jA26EBT0OewW1fdzLTJnFzchOqZYRoLvX4oqWu1A9LpDODhOza+eMF8IvIHMqCQKswmVbRQGM0nqj8Zz2aBfz5gTWxDHuUvGevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PNUY0Cd5; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8d0a00a35so2289221a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 22:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718429267; x=1719034067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HWY3DwYhS1DC6ssfyK/mGNM91IszoPLT/Xd+boZpqg=;
        b=PNUY0Cd5UfDzcalS+tgMf32XcyZgLQ0J4EWuBTR4uiyEbwMA5V/k3qmUWx5rc4hC5j
         aq5tUkU+RM176UuXUEt6JnlTd9Voqlhr+SHWo1b8dp44FjJ3KYSM0i7M3tqW5K02NSgA
         cjfNewfrR3UXKsvi9MmWmeKLVhPFuTNabcd1TDNADA0Aly9OCUPQoxXJSVjuhB2ciKXb
         PxFUOosUVpQtbS9HioXipFfrl5bUtaOmm7L0CkzB+t4zrR6SgZtjxKCArvH0tCoctdLG
         FrvsjMI/eDGPwaTzZiC+Uu0J3wtCs5+YdJltekow+hPnmf1jx4xjI10YBvs3SYh4jpbV
         A54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718429267; x=1719034067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4HWY3DwYhS1DC6ssfyK/mGNM91IszoPLT/Xd+boZpqg=;
        b=ZbiggJO6awiNas0lIgX1v9+uzxkYhKCeqkmZrJRDcT+Rrt7VKwOzTS5ykEIqyC7yBA
         F53FfqQI/nB6ur54DnhWwyrELK+GajnHYv46mAJVCsz4IJY5x1WuDsf7YDQ+n/w1bLgA
         zVkFfPocguW4yIDFEFJhecaH5ZbdffeF6w3pfkFlmBSd7Z13e+g5N1Nn8QxOMOtPDY25
         pbYXzpfx3bnv3Jmpk9Zu7RekPiXOkZplKaRaEyP0nesTE0gKq3oQaTC1rcYtXwRits0Q
         fLsrBdRpUvbispPvW7LH8NSfpSaxep0qje4Zerhoz14bJc9fQd3tUW0gkmfbUXrzVrhZ
         5xNA==
X-Forwarded-Encrypted: i=1; AJvYcCWO8x7jHdycxZK/eP+fFKW1J97Pg4zxeXF2+FYP5ZW46rvdqcb7MBzGF02maX+ooBgDw1izHZLa89dPQc5FP1SxgZYrA8K+ywTH0t2m
X-Gm-Message-State: AOJu0YzqaiGHdj2GMUIUL64G2XYMIzFXzjUuGBCGEA+sKNS++5ghuAdV
	sUMPZCQsm5DeXkPmuUq0KgDUGLvBFa9OzAscY77kQi5I0t1TGlerQiQlI5f+vIS8uwYtDpbZEWA
	W
X-Google-Smtp-Source: AGHT+IEkw9bzoLUdXSiey6gWd/rfVSdgAg0oVru00fWS+E2CLByqzysRddxec15KuDMJ9oecqX3IyA==
X-Received: by 2002:a05:6830:3443:b0:6fb:8193:85dc with SMTP id 46e09a7af769-6fb93b07c46mr4566313a34.30.1718429267234;
        Fri, 14 Jun 2024 22:27:47 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b99bsm4081578b3a.143.2024.06.14.22.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:27:46 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v8 0/7] Linux RISC-V IOMMU Support
Date: Fri, 14 Jun 2024 22:27:30 -0700
Message-Id: <cover.1718388908.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces support for RISC-V IOMMU architected
hardware into the Linux kernel.

The RISC-V IOMMU specification, which this series is based on, is
ratified and available at GitHub/riscv-non-isa [1].

At a high level, the RISC-V IOMMU specification defines:

1) Data structures:
  - Device-context: Associates devices with address spaces and holds
    per-device parameters for address translations.
  - Process-contexts: Associates different virtual address spaces based
    on device-provided process identification numbers.
  - MSI page table configuration used to direct an MSI to a guest
    interrupt file in an IMSIC.
2) In-memory queue interface:
  - Command-queue for issuing commands to the IOMMU.
  - Fault/event queue for reporting faults and events.
  - Page-request queue for reporting "Page Request" messages received
    from PCIe devices.
  - Message-signaled and wire-signaled interrupt mechanisms.
3) Memory-mapped programming interface:
  - Mandatory and optional register layout and description.
  - Software guidelines for device initialization and capabilities discovery.


This series introduces RISC-V IOMMU hardware initialization and complete
single-stage translation with paging domain support.

The patches are organized as follows:

Patch 1: Introduces minimal required device tree bindings for the driver.
Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
         registers layout, and minimal initialization code for enabling global
         pass-through for all connected masters.
Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
         architected hardware.
Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
Patch 5: Implements device directory management with discovery sequences for
         I/O mapped or in-memory device directory table location, hardware
         capabilities discovery, and device to domain attach implementation.
Patch 6: Implements command and fault queue, and introduces directory cache
         invalidation sequences.
Patch 7: Implements paging domain, using highest page-table mode advertised
         by the hardware. This series enables only 4K mappings; complete support
         for large page mappings will be introduced in follow-up patch series.

Follow-up patch series, providing large page support and updated walk cache
management based on the revised specification, and complete ATS/PRI/SVA support,
will be posted to GitHub [2].

Changes from v7:
- rebase on v6.10-rc3
- fix address shift (ppn -> pfn) for queue base register read
- add invalidation after DDTE update

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux
v7 link:  https://lore.kernel.org/linux-iommu/cover.1717612298.git.tjeznach@rivosinc.com/
v6 link:  https://lore.kernel.org/linux-iommu/cover.1716578450.git.tjeznach@rivosinc.com/
v5 link:  https://lore.kernel.org/linux-iommu/cover.1715708679.git.tjeznach@rivosinc.com/
v4 link:  https://lore.kernel.org/linux-iommu/cover.1714752293.git.tjeznach@rivosinc.com/
v3 link:  https://lore.kernel.org/linux-iommu/cover.1714494653.git.tjeznach@rivosinc.com/
v2 link:  https://lore.kernel.org/linux-iommu/cover.1713456597.git.tjeznach@rivosinc.com/
v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/

Tomasz Jeznach (7):
  dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
  iommu/riscv: Add RISC-V IOMMU platform device driver
  iommu/riscv: Add RISC-V IOMMU PCIe device driver
  iommu/riscv: Enable IOMMU registration and device probe.
  iommu/riscv: Device directory management.
  iommu/riscv: Command and fault queue support
  iommu/riscv: Paging domain support

 .../bindings/iommu/riscv,iommu.yaml           |  147 ++
 MAINTAINERS                                   |    8 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  119 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1684 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2947 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1


