Return-Path: <linux-kernel+bounces-517205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA2A37DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD5A3B4304
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722321A4F12;
	Mon, 17 Feb 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZIahCw1J"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091A1A314C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782671; cv=none; b=IKI/MszEpKUiTkm4nVyTkjmKrJK//rK/tw2VOG10pZTENubunhtXjd5uupX3A2D2Q+u0ws6ZWYWFDmgDaiTpniBR0g21PzXqE+FnT4ISCqhJyaI2aFIpwFYUglIFG907gaNxoElIKaAezp/m0wuzOSmWnvesLMxn6TCDl3N+2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782671; c=relaxed/simple;
	bh=TOkbHcros14ROwgOg6vnJZdWVFcQKalF8GD+k0BJQN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PG4TldGNH3pArmxGSDb4KRJKj18hawkZgVh2Y9jgOnSVt0OCSxLucYGN2yREeA6Qbn6GsQuGaFUYJnXcG7YigpgjW79M5ByD+bAnnU4+8YJxF0y1byVv6IsmU5SpeGBri9W1itEbCp+fVeB4slqyHFXFGJuu1qjmVfnHXMjWCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZIahCw1J; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221206dbd7eso15636755ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1739782669; x=1740387469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f84RxVQSOLpB8f+3Kw6/tfkLcBysycUkVkvuR3ETJMc=;
        b=ZIahCw1JZv9WZdiwIBBma/GOTxWoezQXMU+xk7kOR021S6YxOlaPRkxrxughcxMhw3
         UmpgiRtSKMc/WHXtIhTPhun+wVbieLlLYEnPG6xJpz4F4m6HRujqVK0oPLV8SqF4McCV
         EG8L1t3OzfgSoHq8DBSAq5OQNZAsncx4L178vzdXqXSVjG0YFGiJThhEQpUJdTW2z2F/
         rZ8mAdH/sj6j0yWFqZ6xy0mxLvsCffNFMRor60FBprXQj3UfHLHFiKwRlQXmeq18jDZC
         Bhl7K8JlYghpWU3GszxnYQT1KzXGAov4OBNvJ3ndl+A5OJ5xlRr4JiwmYPs8xwTVCW11
         yDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739782669; x=1740387469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f84RxVQSOLpB8f+3Kw6/tfkLcBysycUkVkvuR3ETJMc=;
        b=aoHnrlsg/3D2LtTQDcLCYsdJ/6g7v9GP+p7CTQVbK08hKAO8HuJzld9/g6LwnZupTj
         uBUcUUrQOcknezLWirX2V6Ob2nzAGFC1smiBIFFCnw/0ApGiGzd0mztbtuPAl5c1p6Yd
         7+CFUtyW2WM2idp+B0YRQ7zRpVIRkSCT+s/FKcHnGCY4jHWh3zfmTA0eEbMeaTB+atnl
         Wu2oZQgx/I8xlLm2QemhxqbhonkP3zmO75v+5Q+yFOPPhWxrW9Ua2M82jSoUFhqsMIN0
         NABi1HJazRiMRN8n/AKiOhuGyqXpe4pWKcM5A8XYdHtLQ3lsgsjSfQKenXSiRLu0GcM4
         DnOg==
X-Forwarded-Encrypted: i=1; AJvYcCXIoYi6/RlcslgINu7hf01TMTPwjJvmCmyuSFZJnr48mNU45SGKFA2tYS1CuqKPpDnHoTfuFEXBce3/lcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHp3fkMayQzBAnOd003NRnifwPLmjbJHXFUPuIa4Adz5ktQXT
	5OFjmpTojSGBqxUGG+XTsViJZf7TKkfMW9FrXgq6XOWjr+/lScpM7ufeaWuFuuw=
X-Gm-Gg: ASbGncud6UkUxzcMkxd+ps8hvvY+MmVNfUj+lTEMA6HhuDB7G+tI18H1iVl4ADs0MdJ
	vOcBo/E6dmcLp4lue4L4zaBu5osX33BbqrBo0oFKfNT2Pe6RgSuGGvAL1l6+/Y3XHjSEmpKmui+
	EqKlNFx4t9djxCLxOyFWUgPxE/ZxWyZNx6Y+fasgU+I6Yi4Qkjfe4fuXfXpIZwHq9V74s5h9/in
	MJbUm+6i5cvgIVVu4cmrgKVTrk7CUpn4bZb9lxoJObKj9g9CkFnBNmjPZBOdDblfvpdhgBcOgDM
	JG2YbG5pC2qTWwNWU6pOurdj3sVcv5fRf105RjqEBKTV3xBjFqifvXk=
X-Google-Smtp-Source: AGHT+IF82L3fcPzRQrN7o7ULHVaO9xfwesocSc13p9Vkcov8kHTq/Q8PStQAxAacABCzFd34cRy1kw==
X-Received: by 2002:a05:6a21:e8d:b0:1ee:7ddf:f40c with SMTP id adf61e73a8af0-1ee8cb499ccmr13555954637.11.1739782669344;
        Mon, 17 Feb 2025 00:57:49 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([122.171.22.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242546867sm7632018b3a.24.2025.02.17.00.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 00:57:48 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: hpa@zytor.com,
	Marc Zyngier <maz@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v6 00/10] RISC-V IMSIC driver improvements
Date: Mon, 17 Feb 2025 14:26:46 +0530
Message-ID: <20250217085657.789309-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on recent discussion on LKML:
https://lore.kernel.org/lkml/20241114161845.502027-18-ajones@ventanamicro.com/

It primarily focuses on moving to RISC-V IMSIC driver use common MSI
lib and GENERIC_PENDING_IRQ.

PATCH1 & PATCH2: Preparatory patches
PATCH3: Updates IMSIC driver to use MSI lib
PATCH4 to PATCH5: Preparatory patches for moving to GENERIC_PENDING_IRQ
PATCH6 to PATCH10: Patches to use GENERIC_PENDING_IRQ in IMSIC driver

These patches can also be found in the riscv_imsic_imp_v6 branch at:
https://github.com/avpatel/linux.git

Changes since v5:
 - Rebased upon Linux-6.14-rc1
 - Drop PATCH6 since it is already merged
 - Update commit description of PATCH1

Changes since v4:
 - Updated PATCH4 with better irq_force_complete_move() implementation
   provided by Thomas.

Changes since v3:
 - Dropped PATCH1 of v3 series and updated last patch of this series
   to handle the intermediate state for non-atomic MSI update.
 - Added new PATCH6 in this series to remove stale kconfig option
   GENERIC_PENDING_IRQ_CHIPFLAGS.

Changes since v2:
 - Rebased upon Linux-6.14-rc1
 - Dropped PATCH5 of v2 series since that patch is already merged

Changes since v1:
 - Changed series subject
 - Expand this series to use GENERIC_PENDING_IRQ in IMSIC driver

Andrew Jones (1):
  irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base

Anup Patel (6):
  genirq: Introduce irq_can_move_in_process_context()
  RISC-V: Select GENERIC_PENDING_IRQ
  irqchip/riscv-imsic: Separate next and previous pointers in IMSIC
    vector
  irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC
  irqchip/riscv-imsic: Replace hwirq with irq in the IMSIC vector
  irqchip/riscv-imsic: Special handling for non-atomic device MSI update

Thomas Gleixner (3):
  irqchip/irq-msi-lib: Optionally set default irq_eoi/irq_ack
  irqchip/riscv-imsic: Move to common MSI lib
  genirq: Introduce common irq_force_complete_move() implementation

 arch/riscv/Kconfig                         |   1 +
 arch/x86/kernel/apic/vector.c              | 231 ++++++++++-----------
 drivers/irqchip/Kconfig                    |   8 +-
 drivers/irqchip/irq-gic-v2m.c              |   1 +
 drivers/irqchip/irq-imx-mu-msi.c           |   1 +
 drivers/irqchip/irq-msi-lib.c              |  11 +-
 drivers/irqchip/irq-mvebu-gicp.c           |   1 +
 drivers/irqchip/irq-mvebu-odmi.c           |   1 +
 drivers/irqchip/irq-mvebu-sei.c            |   1 +
 drivers/irqchip/irq-riscv-imsic-early.c    |  14 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 197 +++++++++---------
 drivers/irqchip/irq-riscv-imsic-state.c    | 152 ++++++++++----
 drivers/irqchip/irq-riscv-imsic-state.h    |  12 +-
 include/linux/irq.h                        |   7 +-
 include/linux/msi.h                        |  11 +
 kernel/irq/internals.h                     |   2 +
 kernel/irq/migration.c                     |  21 ++
 17 files changed, 389 insertions(+), 283 deletions(-)

-- 
2.43.0


