Return-Path: <linux-kernel+bounces-409627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FCD9C8F85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391B81F22439
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CAF175D4A;
	Thu, 14 Nov 2024 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cNKTYuXK"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873E157465
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601130; cv=none; b=D22GI7KLlp9SzFxnP4B+yFroHp3X/9+Qv9c/Ccj3cmrS9bPjsLkMQwRaMw8QpzN6W7nv7KHRht0OWsaSGMHfCIAfs0oKTLaeJ8TJMsbyzKqwVx3FJnyoyuYrdlSFEmK15qxGG5rGCrJdtuPYVTHM2DIV+uDzYiglCkHtCajVQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601130; c=relaxed/simple;
	bh=lyZC4By9Ar4lY6HLPHxQpNiCLgIv0jeWjlSxPE9suGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovfTAZGeOkuWHgxhkKoixlyW4Wfn8lM91jzbBi/Ezse1+nNU6FAwPagz3d9NtgAJ5RG9KWJPb/HrS5AP3qkJJ+3mwqW+zMhr5uoJRBfPn9miotveu+7g4RGE5NohvSmp0Lh8Eu0HlYgXx6P4248y/3b851qdin5yvUbGhbpW93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cNKTYuXK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso7179135e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1731601127; x=1732205927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7BJqdeVq7UVKuF/HMX90zKjA2XSvBJJooO0qYOgVYo=;
        b=cNKTYuXKtXFcjOBPRnJIe5JEdaB8nMTdu2gcZu4Z89SKXsd3VhtZobgrFLZ649oWsK
         d6zo/GDvvxvpnkgsyBcraFTMogz3K9QctpIzhElYC9G2Ln+IdCvwCfDQfS4A7r53BO6s
         32zL54xRan91QAkTppZjOLyk1os5NSG1ISqykLjnHy/DrYlnckf2icQQQw/gE3ntfJZ+
         W4FcHVMzo8PXw4PwoKzgrLuPeVgbO/UANpi4naPB49BJHE09s99hUw5dF/ZLRWdZz7i7
         Jx8zEh5SP/qkN7h4U0/7X/LOLmC7yryzJTRmBVq3PYuIPLSxIJWVoTE1SrFQHLOaXEmS
         zhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601127; x=1732205927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7BJqdeVq7UVKuF/HMX90zKjA2XSvBJJooO0qYOgVYo=;
        b=KNyXHR3aAv+XTe+EOjZumHG7wtBRLfO2z5kqw5+W4IR4NGTfcHHK05Hmj6y3kMcYK6
         oLzzQ6JjCO3l1vt6dXMMJXBiR7pqCxdcj+YEmJTXxkdIN7ueusD+EU/Iwtp/W5KD/UXT
         WaCAmXV9mL1lUYBGlmrWcRvevSewN7ZxR/JxunuWE8wgeFNUhjdjMKK2HPopWRbmlgp9
         vPNHeS2gbsG0i69AaTJ+htIC33d/f9LD0/K+oAdf1IujhafjSjlYRLFQlL0TMaYvsuW1
         RCwrQ/T8SGhdSd3xs3n5eYg7uGhUpT+q2CjjfQhepbGLqB1eYS7k4ugi/heTYDzVR0rb
         d4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSM4t0BkFq234qG2c6/enrxXh3MjuWj8bCK3zh/yZQVOEOMggN2yYRODneihl9gP5hRFyQNTzXytgyzOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztpZ3DTBs+lGHHKWgKEEx2/gBQiTVa7Ug0a0DXO6RGw5p6OA2n
	UVGkmWhI5BrjNh7IdTLoeFGnYzVdrxXjW4Twt6QN5OyzeLBYZlMvnVs4fYL1be8=
X-Google-Smtp-Source: AGHT+IGmsJWy6Z+mGpYkwKc89nKAhzRkstEPPTX+iWcGxi/SAriHdno919nTAwdEP/fS42LcKsW+QA==
X-Received: by 2002:a05:600c:1d88:b0:431:5a27:839c with SMTP id 5b1f17b1804b1-432d4a98364mr70171705e9.5.1731601126807;
        Thu, 14 Nov 2024 08:18:46 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265f28sm28998355e9.17.2024.11.14.08.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:18:46 -0800 (PST)
From: Andrew Jones <ajones@ventanamicro.com>
To: iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: tjeznach@rivosinc.com,
	zong.li@sifive.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	tglx@linutronix.de,
	alex.williamson@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 00/15] iommu/riscv: Add irqbypass support
Date: Thu, 14 Nov 2024 17:18:45 +0100
Message-ID: <20241114161845.502027-17-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms with implementations of the RISC-V IOMMU and AIA support
directly delivering MSIs of devices assigned to guests to the VCPUs.
VFIO and KVM have a framework to enable such support, which is called
irqbypass. This series enables irqbypass for devices assigned to KVM
guests when all VCPUs are allocated guest interrupt files. The RISC-V
IOMMU and AIA also support MRIFs (memory-resident interrupt files),
but support for those will be posted as a follow-on to this series.

The patches are organized as follows:
  1-3:  Prepare to create an MSI remapping irqdomain parented by the IMSIC
  4-6:  Prepare the IOMMU driver for VFIO domains which will use a single
        stage of translation, but G-stage instead of the first stage
  7-8:  Add support to the IOMMU driver for creating irqdomains
  9-10: Prepare KVM to enable irqbypass
 11-13: Add irqbypass support to the IOMMU driver and KVM
 14-15: Enable VFIO by default

This series is also available here [1] and may be tested with QEMU recent
enough to have the IOMMU model.

Based on linux-next commit 28955f4fa282 ("Add linux-next specific files for 20241112")

[1] https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v1/

Thanks,
drew


Andrew Jones (10):
  irqchip/riscv-imsic: Use hierarchy to reach irq_set_affinity
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  irqchip/riscv-imsic: Add support for DOMAIN_BUS_MSI_REMAP
  iommu/riscv: Move definitions to iommu.h
  iommu/riscv: Add IRQ domain for interrupt remapping
  RISC-V: KVM: Add irqbypass skeleton
  RISC-V: Define irqbypass vcpu_info
  iommu/riscv: Add guest file irqbypass support
  RISC-V: KVM: Add guest file irqbypass support
  RISC-V: defconfig: Add VFIO modules

Tomasz Jeznach (3):
  iommu/riscv: report iommu capabilities
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
  vfio: enable IOMMU_TYPE1 for RISC-V

Zong Li (2):
  iommu/riscv: use data structure instead of individual values
  iommu/riscv: support GSCID and GVMA invalidation command

 arch/riscv/configs/defconfig               |   2 +
 arch/riscv/include/asm/irq.h               |   9 +
 arch/riscv/include/asm/kvm_host.h          |   3 +
 arch/riscv/kvm/Kconfig                     |   3 +
 arch/riscv/kvm/aia_imsic.c                 | 136 +++++++-
 arch/riscv/kvm/vm.c                        |  60 ++++
 drivers/iommu/riscv/Makefile               |   2 +-
 drivers/iommu/riscv/iommu-bits.h           |  11 +
 drivers/iommu/riscv/iommu-ir.c             | 360 +++++++++++++++++++++
 drivers/iommu/riscv/iommu.c                | 183 ++++++-----
 drivers/iommu/riscv/iommu.h                |  78 +++++
 drivers/irqchip/irq-riscv-imsic-platform.c |  18 +-
 drivers/vfio/Kconfig                       |   2 +-
 include/linux/irqdomain_defs.h             |   1 +
 14 files changed, 776 insertions(+), 92 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.47.0


