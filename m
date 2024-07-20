Return-Path: <linux-kernel+bounces-258030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C293824B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A56281CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED49149E00;
	Sat, 20 Jul 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re7GD1nJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A63149DE3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496423; cv=none; b=bOqTEKh3ginlksFMMRqqXIoHzNN9g5+bI4BJ7+XQIOIFnPctV61AZa5Sp5YXZSmNQB6U3DTKmkXtXkMcdz0ZLztShh9tN9x8lR979CFrznG0woN4qFiHBYPsgkkulCdSvxjhak3YX30TxhSlMZyXgF2oDa3FPDMW93k2PzUzcZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496423; c=relaxed/simple;
	bh=8YWEf7rK4+5tGsSPanUmb4XQE9I8vrOKfPCp7u9NCeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb2066Le2Kne+Fdu1RivPyfRMTc4/TBU7lOBk/4wjURmrd3OyLwXOxjOMj7dXiQpG9t6xcLy19teyGpT8dHI8EB44AEF6hnV7Lg6QPn/vLVejJSY3DinZOYxKMHTbHAd74SCtdGK5lpDgE+aY20pKXWDcSBPdelOafVB9YI1gSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re7GD1nJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCEFC2BD10;
	Sat, 20 Jul 2024 17:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496422;
	bh=8YWEf7rK4+5tGsSPanUmb4XQE9I8vrOKfPCp7u9NCeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re7GD1nJZkP6/TKDh5zaK6UJbwlRjD13WrXU+U/uWsoCTIPCz+KkS+FWe8qzlMP59
	 wlaMSl5RD1er1zJPgMqSYWPvsRLTM2wGkplZ1jJf3w9Yv4HlMpoV9jdkNRSlb1bdiS
	 W0Z/iKOvCHmdepNmvdU10tVh0iDJuzMb4asXBIb36F+00MK6omqL5EqD3KHJ3eG9M6
	 Ib8eUV8z3NHnirkWteJ6P3BCBfD2UasMSk6lEjEzNX/qKJYolpbyxvDk1QsCPgq1jX
	 WZx2mswB0I3ykRY//D+kMEiNz+QxYkm6s7EEKaloqxysN9SlVnZ8impwwvBZnQAzL2
	 yz5VoNN3s1ktw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] riscv: traps: mark do_irq() as __always_inline
Date: Sun, 21 Jul 2024 01:12:32 +0800
Message-ID: <20240720171232.1753-8-jszhang@kernel.org>
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

Since do_irq() is only called in traps.c, so mark it as __always_inline
this will allow the compiler to get rid of the stack setup/tear down
code and eliminate a handful of instructions.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index dc1bc84cfe15..030c50cb4e78 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -378,7 +378,7 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 	irq_exit_rcu();
 }
 
-static void noinstr do_irq(struct pt_regs *regs)
+static __always_inline void do_irq(struct pt_regs *regs)
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
-- 
2.43.0


