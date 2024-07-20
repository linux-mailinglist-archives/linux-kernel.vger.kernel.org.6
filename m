Return-Path: <linux-kernel+bounces-258024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BB938245
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8EB1C209B1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF231487F6;
	Sat, 20 Jul 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvlTkTWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62781487C5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496412; cv=none; b=sxRKX3T23zD4/REN8bgCSKbyrWTT4+KyIvdv4GywaKHTj/Yq6pOw30u7WY694s2ki6dJ2MCywRDM7l46RDEc8yybwlKhv0ExGovhU/Mnn9cBHQoAhQb97xdqVdnng58MHXLqKTjYHsbXMmseOSBsCf/NYMhx7GcKuEOqPYCztpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496412; c=relaxed/simple;
	bh=NCFdc/pkut4LwN+MrcPmxA5eUoeddsannScPQZtdY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6Xu9AY0j3YF8Q0qVuqMQrz5swEbgyX/KBFjTUJKf0QJ4KfIzZ9XVakpuq7kGussmWtekQHmoPrneE1MzILLN2mPPhgnLXGvSLUD9i5lSmFZoc0/mFYQ0ngyyY3RPAmV0nPBhus6nCdoxkGLhgjSRYmbmH/yQ+RwbZl3ClzQIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvlTkTWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E95C4AF09;
	Sat, 20 Jul 2024 17:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496411;
	bh=NCFdc/pkut4LwN+MrcPmxA5eUoeddsannScPQZtdY/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvlTkTWXkGaIxigUYa1gwQar5xanhbF93SHCip2ilWq5sLv5uxDeIy8BPjMTDtNRO
	 80D+AfczK9MoaU8hayhUVOcKkecYo114IlB7xBsFuQj1f1uc2UJwjZeYGFu5Rt6ycV
	 1yzyTb8oUNS8Tr1PYk8LjNALSCij22dli9rSGZGa6E/0qS0DjYzKTLdf7iUm4TPqBZ
	 lhxdComq3ce51D2+v9CZUsbaLcLLkXWqlUu11XOlhN5siC3kcPRVhCk8FoA0SJluuJ
	 Us5Hc+/eSm3qupIEKSBT3LkHnvKe3u+eamNdnwE7Lwjd7oSdMV5OxSOqMYUPos5aY1
	 toGQ3Pzc5Ca1A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] riscv: traps: staticalize handle_break()
Date: Sun, 21 Jul 2024 01:12:26 +0800
Message-ID: <20240720171232.1753-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720171232.1753-1-jszhang@kernel.org>
References: <20240720171232.1753-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_break() is only called in traps.c, make it static.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/entry-common.h | 1 -
 arch/riscv/kernel/traps.c             | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 2293e535f865..1458a41c6536 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -23,7 +23,6 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
 void handle_page_fault(struct pt_regs *regs);
-void handle_break(struct pt_regs *regs);
 
 #ifdef CONFIG_RISCV_MISALIGNED
 int handle_misaligned_load(struct pt_regs *regs);
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..84dff89f435d 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -270,7 +270,7 @@ static bool probe_breakpoint_handler(struct pt_regs *regs)
 	return user ? uprobe_breakpoint_handler(regs) : kprobe_breakpoint_handler(regs);
 }
 
-void handle_break(struct pt_regs *regs)
+static void handle_break(struct pt_regs *regs)
 {
 	if (probe_single_step_handler(regs))
 		return;
-- 
2.43.0


