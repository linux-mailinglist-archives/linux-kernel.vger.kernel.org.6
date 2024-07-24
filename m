Return-Path: <linux-kernel+bounces-261143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C093B31F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A9828419E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9C415E5CB;
	Wed, 24 Jul 2024 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Byi9lpOJ"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4D15E5CE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832656; cv=none; b=kbAkLjz8oaPDpXojInI+33/OohALPXjF/R7dgE73UhBYO6LomUGknwjKjPJijSpUFyb7SCTN2C3RpHUlrBMULdyTxCIoSlKas5ErIBF5ZhZ3E5DvFrs1+X+Wa93E7xIiRu+2uIEuFNoN9DMcV8Q0ANq2LNB+FFu/sbb32BnJ52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832656; c=relaxed/simple;
	bh=aUoZfB2OLNb1ndGDLVdCqPDYnRzEzv9Rl90YVUVuQw0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=L2AIMDFnCGJa0XopIzzjzzFfkah5Jf3LmAlztrFWiMEGmiAC7t0Jo0cipag01ISaPmx1hYv8D8Jq7ohwh/8p0fbWJhgSY8ciqv+0kY/GjZmtaNv5t0lGntYRd1enJInvkgxX5cc7x7ZfH3J14O1Bm5P+48PfZGM7D5ndNzUa1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Byi9lpOJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1271469a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1721832653; x=1722437453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8JCIP5Ds15R5oJZff49alOWJJz0wPxAxfdpUe0KBfo=;
        b=Byi9lpOJ4Eqxsw0PkM8p9lXg12phKB1XAbyQXc58aituTSDEL6ipiS6L3QNQp3abEb
         6ESmuvLVnYIHLyKcOZJ+TxNLxMIkCYRZTXfDLEhb4nvhO+vuiAAgLvmiZ8VhA+pCR940
         ud4iDXx/iMlk5Annwx/VqtNFawYyJ3MQbs9wzO8yp9LuUxRFlW1NPrT8L4QSpI3OYFXa
         CUmXR0g8pCyg+O2WvE5XSBFHAI9bFP96D9+FY9Vxl5bV0w8bssobDAJ4jqE8C4ffZsCC
         69QkHoIgSiW+iieS+o3RADgdbOamJWdUBIX43B+dshB3YI2tvNUmh14hRuONLIvPIBk+
         Hqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832653; x=1722437453;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8JCIP5Ds15R5oJZff49alOWJJz0wPxAxfdpUe0KBfo=;
        b=jJGNlkZbfXyVMz0ku8DzdDmw2eeqb7Fo8Pq7HuzXvRSGmuY0Wo13jU8tYWQ2Ou1qHB
         MDm/SxatjGI8tBpdCek1Qm7QrTI2r+gzD5ilGKgHjHjeEeg77VZWmwZoO1r8P5zw7E6+
         mf+wy6/3Jo1ReY6+LhkTBSFYgSk2u5NT+fTLVckx35iyDbAufTcOnRFVW1EuR538XZ+x
         dtpDjMDXofgPkbkAn3eqmRiHr6INHLWFQ0zywTzcen/BsbCyCdGOu+uqMsZAd2HQxiWU
         3bVQ9EGgjrX/6a4SVK7DDJrgg0ivb6vuTxbztiJWe6Tra3D2+5zYRrh7rG5btYRw/et9
         pnOg==
X-Forwarded-Encrypted: i=1; AJvYcCXmoaFeWZeW8GUsG1zsLcbGbw2i5RP/ev3xouOZg66Fyuu8EORhuypaHtDR4/4V+fBc8vgzhrhJh6Jy4I6gqAXF4FLbhI9a0Uds1Czw
X-Gm-Message-State: AOJu0Yw9TQMaEaBj1fq9MEezC8Xx+WGe413/6VcBXG66Dbd6U9s7nnR1
	+qhj+hHxoFt0NoqzbmiguQnKoqYwmTzxYKlqekHxlIW3pmH6mPRzlD8pSr62TdY=
X-Google-Smtp-Source: AGHT+IECfRajUobkWhWFCa7iklKl/PXLaOhcJT32SDfViQUfkilyIhh463XW/PHn5oHsbvSSmbgDdw==
X-Received: by 2002:a05:6a20:7494:b0:1c0:bf35:ef4c with SMTP id adf61e73a8af0-1c4727aad83mr145198637.11.1721832653262;
        Wed, 24 Jul 2024 07:50:53 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-79f0ad73cc4sm8099359a12.29.2024.07.24.07.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 07:50:52 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:50:52 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Jul 2024 07:39:10 PDT (-0700)
Subject:     Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>
CC: Sunil V L <sunilvl@ventanamicro.com>, Arnd Bergmann <arnd@arndb.de>,
  xiaobo55x@gmail.com, ajones@ventanamicro.com, haibo1.xu@intel.com,
  Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, chenhuacai@kernel.org, kernel@xen0n.name,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, rafael@kernel.org, lenb@kernel.org,
  Greg KH <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, akpm@linux-foundation.org,
  Charlie Jenkins <charlie@rivosinc.com>, bhe@redhat.com, Evan Green <evan@rivosinc.com>, cleger@rivosinc.com,
  zong.li@sifive.com, samitolvanen@google.com, alexghiti@rivosinc.com, samuel.holland@sifive.com,
  chenjiahao16@huawei.com, rmk+kernel@armlinux.org.uk, jszhang@kernel.org, james.morse@arm.com,
  andy.chiu@sifive.com, Marc Zyngier <maz@kernel.org>, tglx@linutronix.de, tony.luck@intel.com,
  Ard Biesheuvel <ardb@kernel.org>, dan.j.williams@intel.com, alison.schofield@intel.com,
  Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com, dave.jiang@intel.com,
  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
  linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: haibo1.xu@intel.com
Message-ID: <mhng-e0773c11-559a-4f64-a1ad-4a234993ccfc@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 13 Jun 2024 01:54:32 PDT (-0700), haibo1.xu@intel.com wrote:
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
>
> Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 2/4 add the common SRAT RINTC affinity structure handler.
> Patch 3/4 change the ACPI_NUMA to a hidden option since it would be selected
> by default on all supported platform.
> Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.
>
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next

No big deal, but that's not actually my repo.  Looks like it's just 
mirroring something, I use the kernel.org git stuff these days.  I 
dropped it from the cover letter for the merge, it's not super useful 
anyway because it's a branch so nobody will know what it means later.

Aside from that things look good, I've got this queued up for the 
tester.

>
> [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/view?usp=sharing
>
> Testing:
> Since the ACPI AIA/PLIC support patch set is still under upstream review,
> hence it is tested using the poll based HVC SBI console and RAM disk.
> 1) Build latest Qemu with the following patch backported
>    https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406d8a1269b0
>
> 2) Build latest EDK-II
>    https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md
>
> 3) Build Linux with the following configs enabled
>    CONFIG_RISCV_SBI_V01=y
>    CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>    CONFIG_NONPORTABLE=y
>    CONFIG_HVC_RISCV_SBI=y
>    CONFIG_NUMA=y
>    CONFIG_ACPI_NUMA=y
>
> 4) Build buildroot rootfs.cpio
>
> 5) Launch the Qemu machine
>    qemu-system-riscv64 -nographic \
>    -machine virt,pflash0=pflash0,pflash1=pflash1 -smp 4 -m 8G \
>    -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
>    -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
>    -object memory-backend-ram,size=4G,id=m0 \
>    -object memory-backend-ram,size=4G,id=m1 \
>    -numa node,memdev=m0,cpus=0-1,nodeid=0 \
>    -numa node,memdev=m1,cpus=2-3,nodeid=1 \
>    -numa dist,src=0,dst=1,val=30 \
>    -kernel linux/arch/riscv/boot/Image \
>    -initrd buildroot/output/images/rootfs.cpio \
>    -append "root=/dev/ram ro console=hvc0 earlycon=sbi"
>
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
> [    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
> ...
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1
>
> ---
> Changes since v3
>   - Rebase to linux-riscv/for-next(Linux 6.10-rc1)
>   - Remove original patch 1/6 since it had been merged through
>     ACPICA pull(commit fe1c408d50604f)
>   - Remove original patch 4/6 since the related changes was
>     introduced in commit 3a785e19f43267
>
> Haibo Xu (4):
>   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
>   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
>   ACPI: NUMA: change the ACPI_NUMA to a hidden option
>   ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
>
>  arch/arm64/Kconfig            |   1 -
>  arch/loongarch/Kconfig        |   1 -
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  drivers/acpi/numa/Kconfig     |   5 +-
>  drivers/acpi/numa/srat.c      |  32 ++++++++-
>  drivers/base/arch_numa.c      |   2 +-
>  include/linux/acpi.h          |   6 ++
>  12 files changed, 187 insertions(+), 18 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c

