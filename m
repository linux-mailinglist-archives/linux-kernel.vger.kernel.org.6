Return-Path: <linux-kernel+bounces-446116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDB09F200F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E516F1887F24
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0E119340B;
	Sat, 14 Dec 2024 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="X2Hs/zJQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748002033A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734197170; cv=none; b=PFKFmBiUtgd7fKvoZHNM2ns3PyKrA0K4ODmRJfNFSiLjAeoCcmns9MGxgwksGfIoa2+akoEVgakZWGQRTumEOBx2qvY5tHKqjCLfgYc4olHuJjL/L7KUFGc1+/zlqK1tWvB/jzdsOpoTF6j84E2svSFqrsoMkOZgMuKpAg3AE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734197170; c=relaxed/simple;
	bh=SQ9uVWQAhuntKlTS20JZafFZ98N5NOWQNg/95pFKO4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jWrsM3TzxBYF+K60WI/g8Gsx5UZQjE4rLdzcxjhawC/j9Sy1ggw2RwXR0uRaarWy6ZB+GTzb6lJyFIntIko2jbAOOuKI7L44+0J9gC7vX3G2hMoiCnSu18lmjqdGg8fNu03In2Lh0b563g1UYu6F7KIzde9gitFIPUBVrCHdusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=X2Hs/zJQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so1679088a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1734197166; x=1734801966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mv0bHKD8tx/knjsXKIIRgI9/G/KQE3L8kp8HO/illC0=;
        b=X2Hs/zJQ3isc05UGh/quBj9OYxceob49D4Xr7ENagSvsKhIMKbvMwfB4W9lUSg3oCN
         Jdsz1OZeVKrZAHWHAd53odc3EclrEuAq7RbvEw7/hQywcHZbRCRumQwU8yFh5aPZcyIe
         9JKgz9Oc65YhmsqjGb8LZ7S9OT2QRktj2v/fq9esHdwsA8q0MENjFJ4wfHkps1mE4dCE
         8N653srWdVMETZAmuLVbM/x+1VgCSix5LmXNuDnkq5cR7rmUENUJmKRdRCwNNdMFGyTO
         zd5sICOtsyvRZ7R954QLionGXNDAu9HfNoRsVmAXYCu+tHxv+w7hwwEto2+dRNjdCwcw
         bEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734197166; x=1734801966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mv0bHKD8tx/knjsXKIIRgI9/G/KQE3L8kp8HO/illC0=;
        b=o17RjRVDWHd5WZM5Fwco9Bi/c9bphbXp+K2mT7dPP0F2ysrIdWHju7KEjMSa0QVwhD
         kAmr18P3A1p08p0kmhrocXa21BivtbXdIRzyJkSRhlvHqUrFkb29EDr3PxXrvJKNgYh+
         TD9pjz4D5/WVv3NvkxajrHvHuIe6CKDNAwObw6miY6wxvcLkwAdGxY5Auv2ZDEUHAPIQ
         1rQi+EioMCX8yVi4ifgLi9QDrjHEfUJ8nC/rpaamjHUkvLe/rwTYwgHBMncBnJNvYqNx
         JWh95HLCeM4+u20+nEfwTCjub5nOB56qTYbRzjeRwyY8fFdOB/sPc9Fgm5qZfQJHENKO
         4Dcw==
X-Forwarded-Encrypted: i=1; AJvYcCVpiw39PeLSBcmg2+Zb37xgc3vnlJIieKofG6JNrXAtCz9Gtj/+Jz3eusFq4BRglp5gxN0F081CikHm0qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypqYyk34EUpM8QkuYtUP/Rb6W1SXLrctf7NlI6de4En6vK30AT
	RVkJgdPw3MQj82p73cVNj1dn+KHg2H2w2hx4G8/oUTOThA1SDwk4/pEopMf2ttU=
X-Gm-Gg: ASbGncuwf3BjZN01SNMh5ukinGNe3vRZ4mDsHOFGUDxSkY8s5wCPJnxyFpthVclpfQf
	ia0r04mcfHOkidKj6zqFML54DrSwodafELt6ugecrMwsY8xZ8UpLWvkChG7YQEjZ3yr23S52m7c
	Zg8Ucl5bOSEEy6G8ZRFPSiyHBTIUEgrjzHjBmQzaIGceudGEKcNYqtvG+IKQPa4gazvjI75171p
	CeupNN62mbU5Byesmt6vhxsWNN/tM6QqnpEJjkcyGKpZj/8YbkjVnVOmF6qvEeKSPW6ewajgtS5
	OYC+dNbgGanSbSE=
X-Google-Smtp-Source: AGHT+IHyKbANKEj4g4KxocXm4yHOhpiEBiGMph5JPaoKcbo6rZ1/8zvn09yNoAs/k0KDXpN10M7D5g==
X-Received: by 2002:a17:90b:4c43:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2f28fa5beacmr9746521a91.4.1734197165633;
        Sat, 14 Dec 2024 09:26:05 -0800 (PST)
Received: from localhost.localdomain ([223.185.132.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm5049811a91.41.2024.12.14.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 09:26:05 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>,
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
Subject: [PATCH v2 00/11] RISC-V IMSIC driver improvements
Date: Sat, 14 Dec 2024 22:55:38 +0530
Message-ID: <20241214172549.8842-1-apatel@ventanamicro.com>
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

PATCH1: Fix for handling non-atomic MSI updates
PATCH2 & PATCH3: Preparatory patches
PATCH4: Main patch which updates IMSIC driver to use MSI lib
PATCH5 & PATCH6: Preparatory patches for moving to GENERIC_PENDING_IRQ
PATCH7 to PATCH11: Patches use GENERIC_PENDING_IRQ in IMSIC driver

These patches can also be found in the riscv_imsic_imp_v2 branch at:
https://github.com/avpatel/linux.git

Changes since v1:
 - Changed series subject
 - Expand this series to use GENERIC_PENDING_IRQ in IMSIC driver

Andrew Jones (1):
  irqchip/riscv-imsic: Set irq_set_affinity for IMSIC base

Anup Patel (7):
  irqchip/riscv-imsic: Handle non-atomic MSI updates for device
  genirq: Introduce common irq_force_complete_move() implementation
  RISC-V: Enable GENERIC_PENDING_IRQ and GENERIC_PENDING_IRQ_CHIPFLAGS
  irqchip/riscv-imsic: Separate next and previous pointers in IMSIC
    vector
  irqchip/riscv-imsic: Implement irq_force_complete_move() for IMSIC
  irqchip/riscv-imsic: Replace hwirq with irq in the IMSIC vector
  irqchip/riscv-imsic: Use IRQCHIP_MOVE_DEFERRED flag for PCI devices

Thomas Gleixner (3):
  irqchip/irq-msi-lib: Optionally set default irq_eoi/irq_ack
  irqchip/riscv-imsic: Move to common MSI lib
  genirq: Introduce kconfig option GENERIC_PENDING_IRQ_CHIPFLAGS

 arch/riscv/Kconfig                         |   2 +
 drivers/irqchip/Kconfig                    |   8 +-
 drivers/irqchip/irq-gic-v2m.c              |   1 +
 drivers/irqchip/irq-imx-mu-msi.c           |   1 +
 drivers/irqchip/irq-msi-lib.c              |  11 +-
 drivers/irqchip/irq-mvebu-gicp.c           |   1 +
 drivers/irqchip/irq-mvebu-odmi.c           |   1 +
 drivers/irqchip/irq-mvebu-sei.c            |   1 +
 drivers/irqchip/irq-riscv-imsic-early.c    |  14 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 177 +++++++++------------
 drivers/irqchip/irq-riscv-imsic-state.c    | 110 +++++++++----
 drivers/irqchip/irq-riscv-imsic-state.h    |  12 +-
 include/linux/irq.h                        |  15 ++
 include/linux/msi.h                        |  11 ++
 kernel/irq/Kconfig                         |   4 +
 kernel/irq/chip.c                          |  39 ++++-
 kernel/irq/irqdomain.c                     |   1 +
 kernel/irq/migration.c                     |   9 ++
 18 files changed, 262 insertions(+), 156 deletions(-)

-- 
2.43.0


