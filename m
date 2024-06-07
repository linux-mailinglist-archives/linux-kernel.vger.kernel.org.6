Return-Path: <linux-kernel+bounces-206700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E83900CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714561C21037
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C57715572A;
	Fri,  7 Jun 2024 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mEqcFoqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDBFKNnG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D8F15381B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791741; cv=none; b=MWVCZoH0bIqgc19MUeOvUClzyALNh4attIZIaQYG5leertZPrZ01jVq6sPdUlj6gKF0zUPJTVLYJ+yNftio7TG7wBnogEj8++kNGZyvl4qaXR/IrrgCodteMz3wde/w5Ku1oGXA2QXNkG175S1RU2X7fphSPOrFYDQUUFAg1Q/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791741; c=relaxed/simple;
	bh=S3LKBRdYZ76UR5mU6mhYfYh8IKB/KBkG8xCM3TgV+vY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDgG89/VOoQdsgfK4jwDrSg/0vuKprR6Oin+ZyYg1jk2XgqhdD42TQD2JS3o3FwvrPlwJCDQi4pBT65JRYBnfozbvPkvGSwLt+Nwv786j4alCsm0PBKyeJawrZiSK5QpxWnc7ZLVbFp721LQT5hfs9Q3O6VoovXGNTsBzh+1TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mEqcFoqV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDBFKNnG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbsnZTi3yzYGcTgPSKaSRSUxnZfcrNRyLlLmKPFRcq8=;
	b=mEqcFoqVjpXHIvQJzHnpy33A6eYLASQS9rK4xkGen/LQ6fhZnv+Ap785wROp0YvwD8FHU7
	niKGv8x9Tk6bjiBkbMqWHx7aTIejL0Q/v+67iX5EsW6Nr8SNLpiDRAKoDnsc823a6WxVYk
	uxqWB1BI7+OZ9N2AJ+qdfCIgjWFsuZQya0s6/DqRY3F5sIGmwmBQytg9ToasdWeP33Cmt6
	Td8LxG0z+CU/rjNEd7//nkHBh+g8CuYp9a5AAhRulQWmX32QDCA52nJsFgAtcluFleaDyn
	cFBOfrJWPcssBbXUtmJgPwLAqiwyBUF+y452lk5Iz7hETS57gUaAITAPT8zB1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbsnZTi3yzYGcTgPSKaSRSUxnZfcrNRyLlLmKPFRcq8=;
	b=gDBFKNnGRevOYtiAVL7cWyH6dsm6ymR4UCm6nKm+VDXdqgBs8BzfgFefTbtv2zd6af76QU
	n80+Z688v6fHDwAw==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET
Date: Fri,  7 Jun 2024 22:22:10 +0200
Message-Id: <7b3319657edd1822f3457e7e7c07aaa326cc2f87.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded macro XIP_OFFSET entirely, stop
using XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET. Instead, use __data_loc and
_sdata to do the same thing.

While at it, also add a description for XIP_FIXUP_FLASH_OFFSET.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/xip_fixup.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index 9ed2cfae09e0..f3d56299bc22 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -24,13 +24,21 @@
 	sub \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
+	/* In linker script, at the transition from read-only section to
+	 * writable section, the VMA is increased while LMA remains the same.
+	 * (See in linker script how _sdata, __data_loc and LOAD_OFFSET is
+	 * changed)
+	 *
+	 * Consequently, early during boot before MMU is up, the generated code
+	 * reads the "writable" section at wrong addresses, because VMA is used
+	 * by compiler to generate code, but the data is located in Flash using
+	 * LMA.
+	 */
+	la t0, _sdata
+	sub \reg, \reg, t0
 	la t0, __data_loc
-	REG_L t1, _xip_phys_offset
-	sub \reg, \reg, t1
 	add \reg, \reg, t0
 .endm
-
-_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
 #else
 .macro XIP_FIXUP_OFFSET reg
 .endm
-- 
2.39.2


