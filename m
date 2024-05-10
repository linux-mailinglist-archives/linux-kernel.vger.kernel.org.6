Return-Path: <linux-kernel+bounces-175327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86738C1E16
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163911C20D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4434161309;
	Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlKiMcip";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2loGTuDo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2921527BE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322536; cv=none; b=mpbvr3ugWO4qgwQWfuTVlMcfQWfxRKrnrv5Sf4XBaG/91oxuQSRnncutTYN8bHjC35n7uvsdLgE8SnMmbCaGXgVg8z0apJU0IXa3NmH1QP8HoCB/bXZVVGN+8FTL9mQQW6SmQigEptARAV94eHG/SkTCixV90Yy4313Xwk7H4Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322536; c=relaxed/simple;
	bh=Oj78+m6G1YczrGzCR+l3AduE2j6RkVKd1tsAt/vLqbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIT84YOdn5huY2fGmNOs6KacB2iZKuteGLR4OIkCm5m8EkEAqm/7aqXR4t7ecqePEZsKrn0Qu2inSwE5DL3hONtBNrJyRL0hFyTPhwnyU2HDuahsf3yclxRrFK3b0vc3Ivubg3sAzYgcCH0P7bpT8abuq0BKNz2EYmlo3kpY7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlKiMcip; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2loGTuDo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEdNR+tmiFh46glcNjBAzC77FOgymIT0T+/PVLfSL7s=;
	b=KlKiMcipyRc94KL8iUYbRAzqDlI4zs8Xq0+0noofqJFZ6+Z03rsQ/tF4lJiwSmnNfts+sU
	8VgiEbilBeb7VrQ1a4GLCg4nvx71oFzY60FJ8tiGoXdIc93bIDWulindNSZnSJfMQ+tkCh
	NQz+rdc35AIjljgR/yO2l6Uw9QVhAQtXnGKob3ZV28kguARX9tRT5SZL2dL1Qjk9Ub7Cde
	S1Enlqs49Y3EIlnKR+RdNQMFOvnxm6jsNl+Iq0ixzJR6X6bAOLH1khk5XuANTCRhWf9jJm
	ZPvasPVrCo//Ei8sYPI684zb2CwJPnUb/w+mqTkhMpuRZQT6Knf+kVjHztz/Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pEdNR+tmiFh46glcNjBAzC77FOgymIT0T+/PVLfSL7s=;
	b=2loGTuDozASFvZvntEdkPWBdOcoOTNEpZ1di8OoSUp64VqGnYUJCfO7Qaj0Z0rr2ckLMSB
	JV/o/a3JJ/+/jPBQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 3/7] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
Date: Fri, 10 May 2024 08:28:41 +0200
Message-Id: <e18d9e8e3540098617d8f5b14859158a63b78594.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
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
using XIP_OFFSET in XIP_FIXUP_OFFSET. Instead, use CONFIG_PHYS_RAM_BASE and
_sdata to do the same thing.

While at it, also add a description for XIP_FIXUP_OFFSET.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/xip_fixup.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
index b65bf6306f69..9ed2cfae09e0 100644
--- a/arch/riscv/include/asm/xip_fixup.h
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -9,8 +9,19 @@
 
 #ifdef CONFIG_XIP_KERNEL
 .macro XIP_FIXUP_OFFSET reg
-        REG_L t0, _xip_fixup
+	/* Fix-up address in Flash into address in RAM early during boot before
+	 * MMU is up. Because generated code "thinks" data is in Flash, but it
+	 * is actually in RAM (actually data is also in Flash, but Flash is
+	 * read-only, thus we need to use the data residing in RAM).
+	 *
+	 * The start of data in Flash is _sdata and the start of data in RAM is
+	 * CONFIG_PHYS_RAM_BASE. So this fix-up essentially does this:
+	 * reg += CONFIG_PHYS_RAM_BASE - _start
+	 */
+	li t0, CONFIG_PHYS_RAM_BASE
         add \reg, \reg, t0
+	la t0, _sdata
+	sub \reg, \reg, t0
 .endm
 .macro XIP_FIXUP_FLASH_OFFSET reg
 	la t0, __data_loc
@@ -19,7 +30,6 @@
 	add \reg, \reg, t0
 .endm
 
-_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
 _xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
 #else
 .macro XIP_FIXUP_OFFSET reg
-- 
2.39.2


