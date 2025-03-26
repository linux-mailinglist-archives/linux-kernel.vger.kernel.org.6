Return-Path: <linux-kernel+bounces-577221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4328A71A11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DB6188D902
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845A1F426F;
	Wed, 26 Mar 2025 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/9yXMM6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B51F4195
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001938; cv=none; b=X/GNUC5jpDIt1J+QCdhpHSABAmW8eQvQcsOOcyfcFTnpG+anU36rKTMNRfay71n3fRy+nGSzlnEos096T5jtVek4/gHBBU1gRz98vAAlF+KHFRgDbNlhDHycchHq9/yhpvw9mItACB+6XUMayTQ5L+xv6f29FFVj9F0nJdNeapA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001938; c=relaxed/simple;
	bh=4TyOAkV/asFeWDnvfwSBEs2wwVovEdefZTWbQE3PUDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1bQ67IkILoH4Oj0eq1d356wjWm+M7lgRjNc7RKZ2mvtec+3eCSmNTioSHfrpwPfscu/pAAMo0528zyzM+QR9MepVPXWmpBStabg7OGN7apK4qbYgEsD0tDlZcrucLAN5ZZMmoPSVe+xJs/cjnNiRpLDS5G77cm8KUboIym4PNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/9yXMM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84351C4CEE8;
	Wed, 26 Mar 2025 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001937;
	bh=4TyOAkV/asFeWDnvfwSBEs2wwVovEdefZTWbQE3PUDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/9yXMM69DsOEWwzDOByqNUz9caRAVeeSER0UArvgUKRklQPcOB7m4mw8qIxj0v4s
	 ++++JSk+BARfeYRaEAPs2GGkmMQfu3toFfzlK3JfUqRGWayg/iotQguElJD6gZTy2n
	 ZYOiHtbbBK+4sFs8VeRfszvKI58b0bYDcjDiymL2J+V/73mNo2w5loJyuXEBpqMAok
	 9z51cAzNWi9OaR+3RkgruvAjtrc08RA40LsPjqkmtjlaDvE/vcUJmSEA4loSogt6sl
	 VlfgaLUrHymjh9YOu7MSrH2aOcVsr2YMfTqzZeGR9VdNr8MNQIbz+ImYe/pO5//Gxy
	 O6gWJzaHZ1dcg==
From: carlos.bilbao@kernel.org
To: tglx@linutronix.de
Cc: bilbao@vt.edu,
	pmladek@suse.com,
	akpm@linux-foundation.org,
	jan.glauber@gmail.com,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	takakura@valinux.co.jp,
	john.ogness@linutronix.de,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 2/2] x86/panic: Use safe_halt() for CPU halt after panic
Date: Wed, 26 Mar 2025 10:12:04 -0500
Message-ID: <20250326151204.67898-3-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250326151204.67898-1-carlos.bilbao@kernel.org>
References: <20250326151204.67898-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Include an arch/x86-specific function to halt CPU once the kernel has
finished handling a panic, by defining the weak function
cpu_halt_after_panic().

Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
Reviewed-by: Jan Glauber (DigitalOcean) <jan.glauber@gmail.com>
---
 arch/x86/kernel/Makefile | 1 +
 arch/x86/kernel/panic.c  | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/x86/kernel/panic.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f7918980667a..0e4d87596f5d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -85,6 +85,7 @@ obj-y				+= stacktrace.o
 obj-y				+= cpu/
 obj-y				+= acpi/
 obj-y				+= reboot.o
+obj-y				+= panic.o
 obj-$(CONFIG_X86_MSR)		+= msr.o
 obj-$(CONFIG_X86_CPUID)		+= cpuid.o
 obj-$(CONFIG_PCI)		+= early-quirks.o
diff --git a/arch/x86/kernel/panic.c b/arch/x86/kernel/panic.c
new file mode 100644
index 000000000000..0838bb7cf9a9
--- /dev/null
+++ b/arch/x86/kernel/panic.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Author Carlos Bilbao <carlos.bilbao@kernel.org>
+#include <linux/kernel.h>
+#include <asm/processor.h>
+
+void cpu_halt_after_panic(void)
+{
+	safe_halt();
+}
-- 
2.47.1


