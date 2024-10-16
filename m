Return-Path: <linux-kernel+bounces-367400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A22B9A01C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B088B23188
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A8199935;
	Wed, 16 Oct 2024 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RQICcHxu"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824C18CC17
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061549; cv=none; b=mF92ioYHZyWCKz9afrMfA16D4ILhxASHq4x9eMrO34V6hyhSaDFjkh1bGgi3h6Uw4F0FUm4GDMkIrvb7mVZr8PC6cylEXaEJ3UceH00MDyqxrTgSNj5RcS1ODa2/grX33tg2pXVwHjx+tCXTWCqvcnPdS2S8vUjXflElz3xjvVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061549; c=relaxed/simple;
	bh=MkWfXMUGA1Oq5dX8D1nuLXWEyvxOfaGw034/IAEqVdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YLtTJISL8OXsLaivCXs0APQzV29wXTcfEQuhPkujzN79ecoFmp1vHILKKcrNrPG6BW2wwCeI35rTEFSHqFmnEldgnoQ0Y9/S2iAMrFXpbwwoombe4Ut9nEvmUlHzF7l1OUb8QxmY5DzbziuDCMDcHK333tvThovmx+wDHi1OfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RQICcHxu; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7d509e61so1399514a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061547; x=1729666347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edrP7O7a6NncjkyeVVAJ0jiJhAYB2+mktJx+SnmTMmo=;
        b=RQICcHxuQWoFbtYVkNk9vz9tn8qLd1ZHxQmcv76TrDSdyH9owoE4uCvD81LMntceiD
         tAlgtUrtp//Nwjtmhw1UJcWgtiKIyka4orUhNu9MzHvqEn3H+JYBWgCPckv1yeKLp8dp
         erHsxErlHhvAecFpEB3U4yJ/7MMNzXDvjME0OoukCNs0PrCxJBkpRBfNo7KWazka0QQY
         /IvmSgzugn10kkww2TpypWx0+70VdFBEHFuQUch/vaiyp2TF/sjsBrPD9CQbukUIRXLP
         UkKGEwIJpNRh8ks6f5HuQtoPinq5tFstSjdnwlWJ7uew/TUBXmWaiv6LTPLixOb+OOz7
         kHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061547; x=1729666347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edrP7O7a6NncjkyeVVAJ0jiJhAYB2+mktJx+SnmTMmo=;
        b=BBwitj0O7nBSkrWs6CeT4fiYKmqCtgKQYC6NRVYv4NEa1ptDX478XmG7sRqcCODBrT
         2Ja4ypZlHFzgoMMwgCe8w8umSNn1uLv60RPRHQ6zCSFlpk9jwS+5jwHJh9ISxsYvSLs1
         XvdY1bBtxbZqlxLVlA+nvb2tzQXoxVFXVavOQ/BSkM+meJfIs6HhvmSRGwJ/5peA7vNh
         s0gk/lYQti3OXMrRje4QdUGi8yTCoOlrjujXF1HNbrFC87Nc60Stz3kz5Lp89xp1HXu4
         pvmQwUpYdQbEG8lDhG06fE2gJemM7EUzCeTgZwIw7DqFy/QLEXkUAN4sVeE4mmYu4sXt
         8qLw==
X-Forwarded-Encrypted: i=1; AJvYcCVdunL9oucZ+wjauJJl+PVLkeXdToQ4jLreLDSw4OC0/f2jqARhu8c+dJUN0bMXBgr/4MpHQyCwwM0PZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDq/4Gx7htOk2WX5IDdBOrju8iLpL66LzSMtyyS9+xxPnptgU
	ZJv+mmLN/Jhcpl5I91k+2vLV2dCDdZPhFMKieUkkbP2unzVw0RScq2cmtPQmfbE=
X-Google-Smtp-Source: AGHT+IHFpMiQBbiEBTkmPNQuDjgrwQrsX5LcLAK0wa6OKlIr/7npj2NUGYvuYiUcx/vU1hhIAlG0YA==
X-Received: by 2002:a05:6a20:c888:b0:1d0:3a32:c3f8 with SMTP id adf61e73a8af0-1d8bcfaa0ffmr23847001637.39.1729061546751;
        Tue, 15 Oct 2024 23:52:26 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77370a83sm2410762b3a.5.2024.10.15.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 23:52:26 -0700 (PDT)
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
Subject: [PATCH v10 0/7] Linux RISC-V IOMMU Support
Date: Tue, 15 Oct 2024 23:52:12 -0700
Message-Id: <cover.1729059707.git.tjeznach@rivosinc.com>
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

Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
with published QEMU RISC-V IOMMU device model [3].

Changes from v9:
- rebase on v6.12-rc3
- #6 Memory ordering fix and updated commentary, based on Will’s suggestions.
- #7 Remove riscv_iommu_device_domain_type() and use head-less kfree_rcu in
     riscv_iommu_release_device(), based on Jason's suggestions.

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux/riscv_iommu.next
[3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
v9 link:  https://lore.kernel.org/linux-iommu/cover.1728579958.git.tjeznach@rivosinc.com/
v8 link:  https://lore.kernel.org/linux-iommu/cover.1718388908.git.tjeznach@rivosinc.com/
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
 MAINTAINERS                                   |    9 +
 drivers/iommu/Kconfig                         |    1 +
 drivers/iommu/Makefile                        |    2 +-
 drivers/iommu/riscv/Kconfig                   |   20 +
 drivers/iommu/riscv/Makefile                  |    3 +
 drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
 drivers/iommu/riscv/iommu-pci.c               |  120 ++
 drivers/iommu/riscv/iommu-platform.c          |   92 +
 drivers/iommu/riscv/iommu.c                   | 1661 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2926 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
-- 
2.34.1


