Return-Path: <linux-kernel+bounces-368907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44F9A165E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAA91C21771
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD981D5168;
	Wed, 16 Oct 2024 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="iAEKfIz8"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B21D517A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123115; cv=none; b=rMakvVAd36I2nX7ODOwGbAKRkiAx65lboiHTfNqpe9x62cMMbTBHMgxGen1EMZfLHGdxmp4SeDy3JGhbjyrCKV2NorJkYj6y9kDKHqSxMrTnjyPdCVOVS872Di6LtdUMSHlEV1YN4pMIdrZhuQjoF8iYn4jYGvFlDaE7a2vnv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123115; c=relaxed/simple;
	bh=6GlrRasXkgggJDU5M8kuorXKCx+Dss6wjSj3jcDAxRQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=o6An/leIsMl1GctSFkuNqBXxX+ihLLGWJ6/OHcHe/76azpRAvUO6DRJakSqrW0lH8ASuPGgYA3EbcbOUN3u6Xk6MXRPj+bXipkG/Q6lGyfmMaq5mO1adIG7NWpLcTSn/yYc95lbsNghVwzNhiG/4eauxHQAoNW0khgKYzxKQm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=iAEKfIz8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca96a155cso2795185ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729123112; x=1729727912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWOcAUhy/aqpDz553u2L9UKjBpofwGpehOSYl8woQYo=;
        b=iAEKfIz8zpIA+UOR6r3OQSgvNdeD6RSm0gzB/+QaV8ZPNaKZDraLVa9G9RFnwxSUMw
         pQo8Md9oQIvQv0gf9mNw6BqXEus/UF47LZffjlE8h9z9mAdLbECF1XbdQTiwvlQv4nEs
         CSYWISeqQBVYY7zTtNbCKNoc4qURl56/KTgVC88iO2YwQQj0WRgPQ54J3uFlp5X7pmKr
         AQ8rSXV+P2mawEZ0jutrL2OkxjaNM99eqy0KITi+ov2p6ORnvP2Ph5UnQTQm99/gaUNB
         UrFelAoZ69qOx8jqT+Y5/QGhyM3OCtPcU+i7w/0SR67+GWGhePn2QFuHm+fiw10RhaE4
         Smig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729123112; x=1729727912;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWOcAUhy/aqpDz553u2L9UKjBpofwGpehOSYl8woQYo=;
        b=PSnsBM1jUVu8TFGx0lQMBUimzsMqzjFr9zAw45Xu6ULiLVZ+2QZnNr5yK3UzuB8jCm
         j/5q/yJIR5Q6nXNojxaRfLk25e+rhUWEhDcVyTyUHsrzlMo4pyjWYS2OSaVHkWwQC6YD
         tGCfz4NXYkSozcft7L22GdFpK9Oa8COeqZcmfqkSbEWKSfG0JlR2KwHFrHjqDWjZ2dJs
         tK9NupeEnIof4J0WiXfyHTSfaKYvsI9rv5lP3x4cGQsuC0hsSXnxmxkhKGwQ0iQw0wur
         9iOFpkipsTXKVuX+YCEVLDOvoWYyIcyAtAQwKtNFF7FOzGhIfRJWZNL8C3mafwwOi5i7
         WVfg==
X-Forwarded-Encrypted: i=1; AJvYcCWSsTKgn29XbL0SXRmr1cbRix5wj0M0sy/teGy6K10xFi2Ic6U+fjV0Muo5QwSlBBVc91resbIJPoqEnc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhkLCRQOhmbjL6bNcccYU3UIhGkeIr6x6NF3otzbJO8X9mrX0
	DHRG+OhDR9+h/LISnEOQBUBCHYQMjAiEZ8SlTP9XMNSrZ6uDIsYUJqrpWZV0B7M=
X-Google-Smtp-Source: AGHT+IHKYKyt9hGNbG2NwFr4zrQbPdHWuysp67AwdzLwlH9R+yyQs6J1fjS1SLIc3JC6hBrMbrmZMg==
X-Received: by 2002:a05:6a21:3511:b0:1d8:ae07:c02 with SMTP id adf61e73a8af0-1d8bcfc38cbmr28048215637.47.1729123111761;
        Wed, 16 Oct 2024 16:58:31 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6d2af7sm3345158a12.40.2024.10.16.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:58:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:58:30 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Oct 2024 16:58:28 PDT (-0700)
Subject:     Re: [PATCH v10 0/7] Linux RISC-V IOMMU Support
In-Reply-To: <cover.1729059707.git.tjeznach@rivosinc.com>
CC: joro@8bytes.org, Will Deacon <will@kernel.org>, robin.murphy@arm.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, apatel@ventanamicro.com,
  Sunil V L <sunilvl@ventanamicro.com>, mick@ics.forth.gr, seb@rivosinc.com, robh+dt@kernel.org, krzk+dt@kernel.org,
  conor+dt@kernel.org, devicetree@vger.kernel.org, iommu@lists.linux.dev,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux@rivosinc.com, tjeznach@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: tjeznach@rivosinc.com
Message-ID: <mhng-31f89051-f430-4d85-ab27-23e5e77e008f@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 23:52:12 PDT (-0700), tjeznach@rivosinc.com wrote:
> This patch series introduces support for RISC-V IOMMU architected
> hardware into the Linux kernel.
>
> The RISC-V IOMMU specification, which this series is based on, is
> ratified and available at GitHub/riscv-non-isa [1].
>
> At a high level, the RISC-V IOMMU specification defines:
>
> 1) Data structures:
>   - Device-context: Associates devices with address spaces and holds
>     per-device parameters for address translations.
>   - Process-contexts: Associates different virtual address spaces based
>     on device-provided process identification numbers.
>   - MSI page table configuration used to direct an MSI to a guest
>     interrupt file in an IMSIC.
> 2) In-memory queue interface:
>   - Command-queue for issuing commands to the IOMMU.
>   - Fault/event queue for reporting faults and events.
>   - Page-request queue for reporting "Page Request" messages received
>     from PCIe devices.
>   - Message-signaled and wire-signaled interrupt mechanisms.
> 3) Memory-mapped programming interface:
>   - Mandatory and optional register layout and description.
>   - Software guidelines for device initialization and capabilities discovery.
>
>
> This series introduces RISC-V IOMMU hardware initialization and complete
> single-stage translation with paging domain support.
>
> The patches are organized as follows:
>
> Patch 1: Introduces minimal required device tree bindings for the driver.
> Patch 2: Defines RISC-V IOMMU data structures, hardware programming interface
>          registers layout, and minimal initialization code for enabling global
>          pass-through for all connected masters.
> Patch 3: Implements the device driver for PCIe implementation of RISC-V IOMMU
>          architected hardware.
> Patch 4: Introduces IOMMU interfaces to the kernel subsystem.
> Patch 5: Implements device directory management with discovery sequences for
>          I/O mapped or in-memory device directory table location, hardware
>          capabilities discovery, and device to domain attach implementation.
> Patch 6: Implements command and fault queue, and introduces directory cache
>          invalidation sequences.
> Patch 7: Implements paging domain, using highest page-table mode advertised
>          by the hardware. This series enables only 4K mappings; complete support
>          for large page mappings will be introduced in follow-up patch series.
>
> Follow-up patch series providing MSI interrupt remapping, complete ATS/PRI/SVA
> and VFIO/IOMMUFD support are available at the GitHub [2], and has been tested
> with published QEMU RISC-V IOMMU device model [3].
>
> Changes from v9:
> - rebase on v6.12-rc3
> - #6 Memory ordering fix and updated commentary, based on Will’s suggestions.
> - #7 Remove riscv_iommu_device_domain_type() and use head-less kfree_rcu in
>      riscv_iommu_release_device(), based on Jason's suggestions.
>
> Best regards,
>  Tomasz Jeznach
>
> [1] link: https://github.com/riscv-non-isa/riscv-iommu
> [2] link: https://github.com/tjeznach/linux/riscv_iommu.next
> [3] link: https://lore.kernel.org/qemu-devel/20241004155721.2154626-1-dbarboza@ventanamicro.com/
> v9 link:  https://lore.kernel.org/linux-iommu/cover.1728579958.git.tjeznach@rivosinc.com/
> v8 link:  https://lore.kernel.org/linux-iommu/cover.1718388908.git.tjeznach@rivosinc.com/
> v7 link:  https://lore.kernel.org/linux-iommu/cover.1717612298.git.tjeznach@rivosinc.com/
> v6 link:  https://lore.kernel.org/linux-iommu/cover.1716578450.git.tjeznach@rivosinc.com/
> v5 link:  https://lore.kernel.org/linux-iommu/cover.1715708679.git.tjeznach@rivosinc.com/
> v4 link:  https://lore.kernel.org/linux-iommu/cover.1714752293.git.tjeznach@rivosinc.com/
> v3 link:  https://lore.kernel.org/linux-iommu/cover.1714494653.git.tjeznach@rivosinc.com/
> v2 link:  https://lore.kernel.org/linux-iommu/cover.1713456597.git.tjeznach@rivosinc.com/
> v1 link:  https://lore.kernel.org/linux-iommu/cover.1689792825.git.tjeznach@rivosinc.com/
>
> Tomasz Jeznach (7):
>   dt-bindings: iommu: riscv: Add bindings for RISC-V IOMMU
>   iommu/riscv: Add RISC-V IOMMU platform device driver
>   iommu/riscv: Add RISC-V IOMMU PCIe device driver
>   iommu/riscv: Enable IOMMU registration and device probe.
>   iommu/riscv: Device directory management.
>   iommu/riscv: Command and fault queue support
>   iommu/riscv: Paging domain support
>
>  .../bindings/iommu/riscv,iommu.yaml           |  147 ++
>  MAINTAINERS                                   |    9 +
>  drivers/iommu/Kconfig                         |    1 +
>  drivers/iommu/Makefile                        |    2 +-
>  drivers/iommu/riscv/Kconfig                   |   20 +
>  drivers/iommu/riscv/Makefile                  |    3 +
>  drivers/iommu/riscv/iommu-bits.h              |  784 ++++++++
>  drivers/iommu/riscv/iommu-pci.c               |  120 ++
>  drivers/iommu/riscv/iommu-platform.c          |   92 +
>  drivers/iommu/riscv/iommu.c                   | 1661 +++++++++++++++++
>  drivers/iommu/riscv/iommu.h                   |   88 +
>  11 files changed, 2926 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>  create mode 100644 drivers/iommu/riscv/Kconfig
>  create mode 100644 drivers/iommu/riscv/Makefile
>  create mode 100644 drivers/iommu/riscv/iommu-bits.h
>  create mode 100644 drivers/iommu/riscv/iommu-pci.c
>  create mode 100644 drivers/iommu/riscv/iommu-platform.c
>  create mode 100644 drivers/iommu/riscv/iommu.c
>  create mode 100644 drivers/iommu/riscv/iommu.h
>
>
> base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

if anyone was waiting on me.  IIUC the plan here was to aim this at the 
IOMMU tree, but I'm happy to look closer and take it through the RISC-V 
tree if people want.  Just LMK, for now I'm  going to do nothing ;)

