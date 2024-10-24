Return-Path: <linux-kernel+bounces-379696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F32C99AE25F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62802B226FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE8F1C4A15;
	Thu, 24 Oct 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mglViwfR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548C1C2327
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765202; cv=none; b=j/cc1jb8lR6jG3YBubzld4XmvJ5NYBXXz2Snb/lKSjkzr6N9stiIvYVSKfD7DlOAX4VmIvGQjJ7WwUyoowtxhVQ1CaBi8NrrdPxy00agR6K1qCeasYGEpXot/7jPVO6MvqYz2M/qii8tmshfVxoGgdFkck4Y5gQzkqpDdiT2kH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765202; c=relaxed/simple;
	bh=t6qXY29CzwvkAmigVfocrRJlQh3OdqhWqzaw1QZS3PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edPmTbW4kl5p+Tc/x+377GVphgMLNnI3drDN8cHuB8Yur2U+/6Vi7XtRqJaR6BoctIoa0meeUI0iXAnLhd5FcHt3ESp0t38UpLfMjVl3HdtRzGvNaCO2zzB2NZwPyqfsplcK00nlpXYZNdgIrvQ/R0Mb8NU1rdu3E4tYqqMjq1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mglViwfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB15C4CEE6;
	Thu, 24 Oct 2024 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729765201;
	bh=t6qXY29CzwvkAmigVfocrRJlQh3OdqhWqzaw1QZS3PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mglViwfR08zIxTBNHSBGANTzSzSLOklLiFt+ib2SyPLimzW/akAflTjOMstZ24hX7
	 xqAgDMPdXQcmGDl8jraoSE1vt7Q12TQauI7H5HHCfZhil0T338Vd0OLOVspku+cdi3
	 mEcJWCtNYg1JAuojw3SDJSezseLtcwzUxZ0/3vzZkEwhYwSyXVLbw7ko4EQdRIFrBV
	 Q3sHtRLkYFnhfNbzQxYy0bZbyoosEJuod0NsgGYz3PLEYE3ieIK04up/wUcskcXmGD
	 g3yVMcAUOWYF3zrMfpNSUeSB1hOM0rzKkLF2zHIt+e5ZZuk1bdT7V68syqMZPehhxI
	 ZNCozRMwswWuw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	xiao.w.wang@intel.com,
	Andrew Jones <ajones@ventanamicro.com>,
	pulehui@huawei.com,
	Charlie Jenkins <charlie@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH v4 1/2] RISC-V: clarify what some RISCV_ISA* config options do
Date: Thu, 24 Oct 2024 11:19:40 +0100
Message-ID: <20241024-overdue-slogan-0b0f69d3da91@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024-aspire-rectify-9982da6943e5@spud>
References: <20241024-aspire-rectify-9982da6943e5@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4816; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=3yJLValW/VoFMfVO6YI87JTMWn+8zsqnfBmwuqlkS34=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOlS8vaz7gQ+u150x9Rz57YzdVwPp65L8It0ba9scrcr7 7EN+z+vo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABOZe4vhr0Rsw8+MR4qlS38k hHzYtmnnhvAfxQWn38yR3NzP2Kjt9p6RYeOh/985Xu+60p+XsHRGh6D2dOmSR7e71ljYcIgvnbp /FS8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

During some discussion on IRC yesterday and on Pu's bpf patch [1]
I noticed that these RISCV_ISA* Kconfig options are not really clear
about their implications. Many of these options have no impact on what
userspace is allowed to do, for example an application can use Zbb
regardless of whether or not the kernel does. Change the help text to
try and clarify whether or not an option affects just the kernel, or
also userspace. None of these options actually control whether or not an
extension is detected dynamically as that's done regardless of Kconfig
options, so drop any text that implies the option is required for
dynamic detection, rewording them as "do x when y is detected".

Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 62545946ecf43..278a38c94c5a6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -527,7 +527,8 @@ config RISCV_ISA_C
 	help
 	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
 	  when building Linux, which results in compressed instructions in the
-	  Linux binary.
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support compressed instructions.
 
 	  If you don't know what to do here, say Y.
 
@@ -537,8 +538,8 @@ config RISCV_ISA_SVNAPOT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
-	  time and enable its usage.
+	  Enable support for the Svnapot ISA-extension when it is detected
+	  at boot.
 
 	  The Svnapot extension is used to mark contiguous PTEs as a range
 	  of contiguous virtual-to-physical translations for a naturally
@@ -556,9 +557,8 @@ config RISCV_ISA_SVPBMT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the Svpbmt
-	   ISA-extension (Supervisor-mode: page-based memory types) and
-	   enable its usage.
+	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
+	   page-based memory types) in the kernel when it is detected at boot.
 
 	   The memory type for a page contains a combination of attributes
 	   that indicate the cacheability, idempotency, and ordering
@@ -577,14 +577,15 @@ config TOOLCHAIN_HAS_V
 	depends on AS_HAS_OPTION_ARCH
 
 config RISCV_ISA_V
-	bool "VECTOR extension support"
+	bool "Vector extension support"
 	depends on TOOLCHAIN_HAS_V
 	depends on FPU
 	select DYNAMIC_SIGFRAME
 	default y
 	help
-	  Say N here if you want to disable all vector related procedure
-	  in the kernel.
+	  Add support for the Vector extension when it is detected at boot.
+	  When this option is disabled, neither the kernel nor userspace may
+	  use vector procedures.
 
 	  If you don't know what to do here, say Y.
 
@@ -667,8 +668,8 @@ config RISCV_ISA_ZBB
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the ZBB
-	   extension (basic bit manipulation) and enable its usage.
+	   Add support for enabling optimisations in the kernel when the
+	   Zbb extension is detected at boot.
 
 	   The Zbb extension provides instructions to accelerate a number
 	   of bit-specific operations (count bit population, sign extending,
@@ -707,9 +708,9 @@ config RISCV_ISA_ZICBOM
 	select RISCV_DMA_NONCOHERENT
 	select DMA_DIRECT_REMAP
 	help
-	   Adds support to dynamically detect the presence of the ZICBOM
-	   extension (Cache Block Management Operations) and enable its
-	   usage.
+	   Add support for the Zicbom extension (Cache Block Management
+	   Operations) and enable its use in the kernel when it is detected
+	   at boot.
 
 	   The Zicbom extension can be used to handle for example
 	   non-coherent DMA support on devices that need it.
@@ -722,7 +723,7 @@ config RISCV_ISA_ZICBOZ
 	default y
 	help
 	   Enable the use of the Zicboz extension (cbo.zero instruction)
-	   when available.
+	   in the kernel when it is detected at boot.
 
 	   The Zicboz extension is used for faster zeroing of memory.
 
@@ -760,8 +761,9 @@ config FPU
 	bool "FPU support"
 	default y
 	help
-	  Say N here if you want to disable all floating-point related procedure
-	  in the kernel.
+	  Add support for floating point operations when an FPU is detected at
+	  boot. When this option is disabled, neither the kernel nor userspace
+	  may use the floating point unit.
 
 	  If you don't know what to do here, say Y.
 
-- 
2.45.2


