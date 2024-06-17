Return-Path: <linux-kernel+bounces-217192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5690ACBC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768DF284502
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0972194A6D;
	Mon, 17 Jun 2024 11:18:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17612194A52
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623129; cv=none; b=mt63j9JM0C9xlhlNTmzFYiWJrcXACFAuRgoaGrDMir6b4XMFg5hnvydqw6klFo3FeeAkgQWCq7dGPVxqqGqyij3rUbU72QMy8vpWD5ZFDv7FF6BJ3qX4VpxRRZ4mdoAld6jrNYvm5eCn3ScsQO2KOEluUMxbV8TDGz2PQUOT354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623129; c=relaxed/simple;
	bh=GfB2o//NDeKUCwcGN6k5eyEwptW13vIwPqXnCoaNIBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GgCSlREnSTxLM9MXTyiFR7/kvvy/rDO+n8TPkbyj5RaBwXHQem0QD0mbPO473H1RKMaErrPUOHlHTnONPdMPffraPlqIqW4NzFe2Wd8I1X+JZ6QhJthJ/57bgQJIpoqhRbwA2FauGhzn9kqTSNIz3P8O8V6tX9mg0x+87XL8tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 193ACDA7;
	Mon, 17 Jun 2024 04:19:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DCE43F6A8;
	Mon, 17 Jun 2024 04:18:45 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>
Cc: alexandru.elisei@arm.com,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org
Subject: [PATCH v2 0/5] arm64: irqchip/gic-v3: Use compiletime constant PMR values
Date: Mon, 17 Jun 2024 12:18:36 +0100
Message-Id: <20240617111841.2529370-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series optimizes the way regular IRQs are masked/unmasked when
GICv3 pseudo-NMIs are used, removing the need for a static key in fast
paths by using a priority value chosen dynamically at boot time.

Thomas, would you be happy for this series to go through the arm64 tree?
The key part of the series is the final patch which changes both arm64
and irqchip, and I expect merge conflicts or functional fallout to be
contained to arm64.

The GIC distributor and PMR/RPR can present different views of the
interrupt priority space dependent upon the values of GICD_CTLR.DS and
SCR_EL3.FIQ. Currently we treat the distributor's view of the priority
space as canonical, and when the two differ we change the way we handle
values in the PMR/RPR, using the `gic_nonsecure_priorities` static key
to decide what to do.

This approach works, but it's sub-optimal. When using pseudo-NMI we
manipulate the distributor rarely, and we manipulate the PMR/RPR
registers very frequently in code spread out throughout the kernel (e.g.
local_irq_{save,restore}()). It would be nicer if we could use fixed
values for the PMR/RPR, and dynamically choose the values programmed
into the distributor.

This series reworks the GIC code and arm64 architecture code to allow
the use of compiletime-constant PMR values. This simplifies the logic
for PMR management, and when using pseudo-NMI this results in smaller
and better generated code for saving/restoring the irqflags, saving ~4K
of text for defconfig + CONFIG_PSEUDO_NMI=y.

The first patch add a new REPEAT_BYTE_U32() helper which can be useful
for drivers. The second is a preparatory cleanup which I think makes sense
regardless of the rest of the series. The third and fourth patches
rework the GICv3 code to be able to choose priorities at boot time, and
the final patch makes the actual switch.

I've given this some light testing atop v6.10-rc1 with pseudo-NMI
enabled (with priority debugging), along with lockdep on the following
systems:

* M1SDP Morello board, bare metal
  Where GICD_CTRL.DS=0, SCR_EL3.FIQ=0
  Using shifted (NS) values in the distributor

* M1SDP Morello board, KVM guest
  Where GICD_CTRL.DS=1, SCR_EL3.FIQ=0
  Using unshifted values in the distributor

* ThunderX2, KVM guest
  Where GICD_CTRL.DS=1, SCR_EL3.FIQ=0
  Using unshifted values in the distributor

On ThunderX2 bare-metal there is an existing boot-time hang when using
pseudo-NMI which is not solved by this series. With this series applied,
the logging added in patch 3 reports that GICD_CTRL.DS=1, SCR_EL3.FIQ=0,
and so this should be using the same priorities which are seem to work
in a guest.

Since v1 [1]:
* Add REPEAT_BYTE_U32()
* Add MarcZ's Reviewed-by & Tested-by tags
* Cleanup commit titles
* Fix typos

[1] https://lore.kernel.org/linux-arm-kernel/20240529172116.1313498-1-mark.rutland@arm.com/

Mark.

Mark Rutland (5):
  wordpart.h: Add REPEAT_BYTE_U32()
  irqchip/gic-common: Remove sync_access callback
  irqchip/gic-v3: Make distributor priorities variables
  irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
  arm64: irqchip/gic-v3: Select priorities at boot time

 arch/arm64/include/asm/arch_gicv3.h     |  15 --
 arch/arm64/include/asm/ptrace.h         |  35 +---
 arch/arm64/kernel/image-vars.h          |   5 -
 drivers/irqchip/irq-gic-common.c        |  22 +--
 drivers/irqchip/irq-gic-common.h        |   7 +-
 drivers/irqchip/irq-gic-v3-its.c        |  11 +-
 drivers/irqchip/irq-gic-v3.c            | 225 ++++++++++++------------
 drivers/irqchip/irq-gic.c               |  10 +-
 drivers/irqchip/irq-hip04.c             |   6 +-
 include/linux/irqchip/arm-gic-common.h  |   4 -
 include/linux/irqchip/arm-gic-v3-prio.h |  52 ++++++
 include/linux/irqchip/arm-gic-v3.h      |   2 +-
 include/linux/wordpart.h                |   8 +
 13 files changed, 201 insertions(+), 201 deletions(-)
 create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h

-- 
2.30.2


