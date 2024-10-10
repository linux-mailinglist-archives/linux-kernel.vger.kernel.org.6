Return-Path: <linux-kernel+bounces-359966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF877999318
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8491C24CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09F1E7C2A;
	Thu, 10 Oct 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V9yNE7Y8"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC661E7666
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589710; cv=none; b=qMXVWrKIO2wuV/+BrNmfk1SUbk9YiSvZRLpC5k5FLJRM7Y8kGYhMhXVdDh9pzgaQZuIfi30cdmryDDm8a10GmMcgoqxl0N6wAIQGT2d1/0IuMT+rQtdf9k/gG6gxkeg48dFTNnpuYF/9AlixExZ9IPKgG1oiw/NRBd268HqhxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589710; c=relaxed/simple;
	bh=2sM7o6LGBO7ap0Z5O50Lq1X46/SGK9tk5/PV2obuWvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mq9J1ykJ7UHc94ojrh7iD0tCiqmcwzZC9a8J1NoJvzy+krNnTKTSSyTLYGNRGEoqf3rTjtXbMFuPw8zbmBN1L7vY2usRU7NNqfzvH5kYHpaWrQx7yH7oSH63+oZ9tVqNk6A+ewuejISJFMICP/gCLmRWkZxE8SZi0faI20RX8LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V9yNE7Y8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso959570a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728589708; x=1729194508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B61VLO+BRSEyfmIsrGmAx21/fZCaGHpfFXaCOhd6vL8=;
        b=V9yNE7Y8WI9Q/LLEd93RSLfOEaDeCnfqyxx+izw0WDlj0TB1ZA8CLUqB3TdxnLslXg
         QgxqaWy0xs/6LxAJNA9j1KiigChFuMUngmoHJDxmnWG6BsGvKLlmJUdl4QBR94TshGaF
         371JeB0H/kZq28sIrQgTmARFvtjCXYCSs3xqLNx2Dd9TgkyyL6FNokEMGvH+m3NKWgfA
         9jIuMmrOwBLvDWhSbJvnYkYJXeYo8+LlxNPqR1XHY+AhJVtGrJ08dC2K2XDljUT5EgUN
         /dOQLgrf4z2NaZwQxZQxDZfeQ8IDCcjAMUAxVTFtd/A8RxjffDCZ6gw96NhbEZ3ompyp
         U7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728589708; x=1729194508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B61VLO+BRSEyfmIsrGmAx21/fZCaGHpfFXaCOhd6vL8=;
        b=Kkp4oeJe60frMfVUkEDhF+DL7iyne2tmAU18oTM1z5IzyuItd6X9hT+D0Xs8yafpKA
         m3Tlp/qRRTmyca5b6DxdZpddlJeuPEtvgkp3DtUkynGex9actvQXjMyw1Z4jJBJcQJMX
         W54kfY5G3Mwt+NvYTQdJzzvpamA4Ni5+Q4lRjLC/37hVRI2oj1OrL0fdTOTCZj2zPqBr
         6K9xem54tyik+ZsfuAOIv3EnDe90NFYHR7AUIaRI/P5n2dXE11gm0ZPuWGIn7pzqqnlc
         IuREWrJ85/1uT4T3Jzos2ND7tDzSXWzoFJNlj5U/R4hvb0/Rdd4doahK0IVrRO1cB3E+
         oq7w==
X-Forwarded-Encrypted: i=1; AJvYcCUfALzGoMpoJKqlDCcIJdERS+dHKj7at6gQ1bc7I6+J8a6GP0SglCYRnMub9MaB4boviblQL2yewqK+Xuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcluRjXE1IIdLUWDjG70KRb/Sv7kgU4HxwHAJtBI0fYsv71kk
	5KGN4TBYlGkokOoQI/eLMHqkgj2+9+mi4/A+do4ItjttbOloXTqafqFDf58zuDs=
X-Google-Smtp-Source: AGHT+IGhMyUe9CQbTggLp54HZtGSVOanaEnnb26ySY+CMmJkiGcpjx4Ar0dmYh7j+BEdl/j0GACsgA==
X-Received: by 2002:a17:90a:eb01:b0:2e2:8d33:f79d with SMTP id 98e67ed59e1d1-2e2f0ae8d45mr332736a91.19.1728589707698;
        Thu, 10 Oct 2024 12:48:27 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2e6ef1ad0sm749135a91.49.2024.10.10.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:48:27 -0700 (PDT)
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
Subject: [PATCH v9 0/7] Linux RISC-V IOMMU Support
Date: Thu, 10 Oct 2024 12:48:03 -0700
Message-Id: <cover.1728579958.git.tjeznach@rivosinc.com>
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

Changes from v8:
- rebase on v6.12-rc2
- #1 MAINTAINERS file updated to point out IOMMU subsystem source repository location.
- #3 Update PCIe device IDs, use Red-Hat assigned VID:DID for QEMU RISC-V IOMMU model,
     Update Rivos PCIe IOMMU hardware VID:DID.
- #7 Fix incorrect pgsize calculation in riscv_iommu_map_pages().
     Fix supported page size reporting for paging domain.
     Fix boolean type for riscv_iommu_domain.amo_enabled.
     Remove workaround for dev == NULL in ops->domain_alloc_paging, no longer needed
     with domain allocation interface refactoring patches [4].

Best regards,
 Tomasz Jeznach

[1] link: https://github.com/riscv-non-isa/riscv-iommu
[2] link: https://github.com/tjeznach/linux/riscv_iommu.next
[3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
[4] link: https://lore.kernel.org/linux-iommu/20241009041147.28391-1-baolu.lu@linux.intel.com/
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
 drivers/iommu/riscv/iommu.c                   | 1656 +++++++++++++++++
 drivers/iommu/riscv/iommu.h                   |   88 +
 11 files changed, 2921 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 create mode 100644 drivers/iommu/riscv/Kconfig
 create mode 100644 drivers/iommu/riscv/Makefile
 create mode 100644 drivers/iommu/riscv/iommu-bits.h
 create mode 100644 drivers/iommu/riscv/iommu-pci.c
 create mode 100644 drivers/iommu/riscv/iommu-platform.c
 create mode 100644 drivers/iommu/riscv/iommu.c
 create mode 100644 drivers/iommu/riscv/iommu.h


base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.34.1


