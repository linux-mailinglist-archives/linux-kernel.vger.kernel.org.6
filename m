Return-Path: <linux-kernel+bounces-267398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E09410FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FD9B254B6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6619B3F9;
	Tue, 30 Jul 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7/icNJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3612DD88
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339876; cv=none; b=pcfR5TtYFWrR5ZQ/jN77Rp9wiXCujZEGzZLyX6AwNJSMXhmTY3XZegrbfTZtUR1y4Knyu8lPt42BBYhVQXMueAwdYtbJ3t8XGRFmL8GCNdSJohtWFbNxQ2BFCIvSMmCxlyPliJMIsoQejtLf19N51dCuyhRCehSinQM/rhR16pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339876; c=relaxed/simple;
	bh=J6l5W49n9iB+uwt8CQ5AwWNy3Kxlt/FstVprC/06sNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PeCLtNz1M9O6dvU4OEvnJS1JOTR8Zjeu6OyJ7CYS0cmIvpA9kXGOcKx7VV0vk2Vva5r6CAB2ERXwj99J7YrrDoT0ozfYz4HgNNWwO2UL8S9CYISRQtKVx/Vi9mE1cFVlS+e5EHUabhBqwLncgozZHUwVuN4PQk/olxNiJJs75e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7/icNJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5FDC32782;
	Tue, 30 Jul 2024 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722339875;
	bh=J6l5W49n9iB+uwt8CQ5AwWNy3Kxlt/FstVprC/06sNs=;
	h=From:To:Cc:Subject:Date:From;
	b=p7/icNJOorkHw2oyyid0QdM7u2sShTPcn/oid4wg/yX7l3KOB7qv9gIYedc6s3OEA
	 5frJ+dO+wtno+AtyLQgO23wT3ofFWtEU2GJ8wHErrr5RL7Y1+TNqvNPGBIkSEt4Xv5
	 SGbFH1AtHRKhJtXRAtYlkIYD0ZWeO/96aiuV36rYU6lnUGWd372xSjizDALcr7k8ry
	 qOx5VqVxlMgb7QE03nskbeQMf4MWaTIeq9U2e4Y3xIY7bgCYDE+PnMkHTsSXFW7Q1h
	 GlCZU/MBKBqC/puNpPHR6i1+r4plFC9OlHRYHJBi+C+akm57DkU8DPgNO0kHbOK6L5
	 4M7yVBA5kvPeg==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Fix UBSAN 'subtraction overflow' error in shift_and_mask()
Date: Tue, 30 Jul 2024 12:44:31 +0100
Message-Id: <20240730114431.1119-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBSAN reports the following 'subtraction overflow' error when booting
in a virtual machine on Android:

 | Internal error: UBSAN: integer subtraction overflow: 00000000f2005515 [#1] PREEMPT SMP
 | Modules linked in:
 | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-00006-g3cbe9e5abd46-dirty #4
 | Hardware name: linux,dummy-virt (DT)
 | pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 | pc : cancel_delayed_work+0x34/0x44
 | lr : cancel_delayed_work+0x2c/0x44
 | sp : ffff80008002ba60
 | x29: ffff80008002ba60 x28: 0000000000000000 x27: 0000000000000000
 | x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
 | x23: 0000000000000000 x22: 0000000000000000 x21: ffff1f65014cd3c0
 | x20: ffffc0e84c9d0da0 x19: ffffc0e84cab3558 x18: ffff800080009058
 | x17: 00000000247ee1f8 x16: 00000000247ee1f8 x15: 00000000bdcb279d
 | x14: 0000000000000001 x13: 0000000000000075 x12: 00000a0000000000
 | x11: ffff1f6501499018 x10: 00984901651fffff x9 : ffff5e7cc35af000
 | x8 : 0000000000000001 x7 : 3d4d455453595342 x6 : 000000004e514553
 | x5 : ffff1f6501499265 x4 : ffff1f650ff60b10 x3 : 0000000000000620
 | x2 : ffff80008002ba78 x1 : 0000000000000000 x0 : 0000000000000000
 | Call trace:
 |  cancel_delayed_work+0x34/0x44
 |  deferred_probe_extend_timeout+0x20/0x70
 |  driver_register+0xa8/0x110
 |  __platform_driver_register+0x28/0x3c
 |  syscon_init+0x24/0x38
 |  do_one_initcall+0xe4/0x338
 |  do_initcall_level+0xac/0x178
 |  do_initcalls+0x5c/0xa0
 |  do_basic_setup+0x20/0x30
 |  kernel_init_freeable+0x8c/0xf8
 |  kernel_init+0x28/0x1b4
 |  ret_from_fork+0x10/0x20
 | Code: f9000fbf 97fffa2f 39400268 37100048 (d42aa2a0)
 | ---[ end trace 0000000000000000 ]---
 | Kernel panic - not syncing: UBSAN: integer subtraction overflow: Fatal exception

This is due to shift_and_mask() using a signed immediate to construct
the mask and being called with a shift of 31 (WORK_OFFQ_POOL_SHIFT) so
that it ends up decrementing from INT_MIN.

Use an unsigned constant '1U' to generate the mask in shift_and_mask().

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Fixes: 1211f3b21c2a ("workqueue: Preserve OFFQ bits in cancel[_sync] paths")
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1745ca788ede..b35f8ce80bc7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -897,7 +897,7 @@ static struct worker_pool *get_work_pool(struct work_struct *work)
 
 static unsigned long shift_and_mask(unsigned long v, u32 shift, u32 bits)
 {
-	return (v >> shift) & ((1 << bits) - 1);
+	return (v >> shift) & ((1U << bits) - 1);
 }
 
 static void work_offqd_unpack(struct work_offq_data *offqd, unsigned long data)
-- 
2.46.0.rc1.232.g9752f9e123-goog


