Return-Path: <linux-kernel+bounces-185487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6F8CB56C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829DD1C20AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 21:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D953149E04;
	Tue, 21 May 2024 21:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRRWV2mz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF81494D6
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716327505; cv=none; b=iMZq27DO0J4lzx+oxmwRjVK9h0w5gK401FI+c35Cqbg83wgVSmMUbfvlxK0cLZ8EbIxXuGWgXKd1T8JXmFgmthvlAgLaYFbxUzqWajjG9OabHc64T1CEOekMbgYEgSKD+1Kz2CI7n0Vt/z3UWstPiEGZ0N2+dPJU1BZ/hxq/gmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716327505; c=relaxed/simple;
	bh=oR5loQ/i/Rsx1Ierj/b9bxTyVCpBalS4Ej8gyPm7Brc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jli7Vn1nC+xTnHEKJ7YJMuY61gMp81NR4xwcFzrC9373S+Tnsq9PMNIc2L4DJggqdnh1YLY04MAzUyz4ZWXjpDGAa7iO3qovE3l7HIGj6O0aJ6MQnAlEDR5ajTwti8EFxSHvotF726XUs3QursPfBnyzR1voQcp9tNPaeQMeSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRRWV2mz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2885C2BD11;
	Tue, 21 May 2024 21:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716327504;
	bh=oR5loQ/i/Rsx1Ierj/b9bxTyVCpBalS4Ej8gyPm7Brc=;
	h=From:To:Cc:Subject:Date:From;
	b=aRRWV2mzamYq+493uTYGefAmM60IvfIRY1mQoBMKUKToegUyImYWhjdjer739pp6V
	 rnLAeZBEOgI5p2RLFhbROQW0e5xW/WU5AaADkrJrktemwNy1Gd42o38uGS7RNGotFk
	 9LojW1/7Wm12ZCDj3gcxlh2CtkxtA8D3RDiG85ZKh5qI9GKvnIOh+vRTlygAg9AaAQ
	 sFJMKb+79MAZIrCjgplDdCda8GA7IwNPi0177W8UabsDqgB5++qC2ME5GlmlKZBWCt
	 4ZmPJFej36azxQctCBZuHO3OGBxdTKnJehAx7dBwX3Wu+wFoLvVm56zmrtXIe7iObm
	 88JpRliRgktbg==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Klara Modin <klarasmodin@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: patching: fix handling of execmem addresses
Date: Wed, 22 May 2024 00:38:13 +0300
Message-ID: <20240521213813.703309-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

Klara Modin reported warnings for a kernel configured with BPF_JIT but
without MODULES:

[   44.131296] Trying to vfree() bad address (000000004a17c299)
[   44.138024] WARNING: CPU: 1 PID: 193 at mm/vmalloc.c:3189 remove_vm_area (mm/vmalloc.c:3189 (discriminator 1))
[   44.146675] CPU: 1 PID: 193 Comm: kworker/1:2 Tainted: G      D W          6.9.0-01786-g2c9e5d4a0082 #25
[   44.158229] Hardware name: Raspberry Pi 3 Model B (DT)
[   44.164433] Workqueue: events bpf_prog_free_deferred
[   44.170492] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   44.178601] pc : remove_vm_area (mm/vmalloc.c:3189 (discriminator 1))
[   44.183705] lr : remove_vm_area (mm/vmalloc.c:3189 (discriminator 1))
[   44.188772] sp : ffff800082a13c70
[   44.193112] x29: ffff800082a13c70 x28: 0000000000000000 x27: 0000000000000000
[   44.201384] x26: 0000000000000000 x25: ffff00003a44efa0 x24: 00000000d4202000
[   44.209658] x23: ffff800081223dd0 x22: ffff00003a198a40 x21: ffff8000814dd880
[   44.217924] x20: 00000000d4202000 x19: ffff8000814dd880 x18: 0000000000000006
[   44.226206] x17: 0000000000000000 x16: 0000000000000020 x15: 0000000000000002
[   44.234460] x14: ffff8000811a6370 x13: 0000000020000000 x12: 0000000000000000
[   44.242710] x11: ffff8000811a6370 x10: 0000000000000144 x9 : ffff8000811fe370
[   44.250959] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000811fe370
[   44.259206] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   44.267457] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000002203240
[   44.275703] Call trace:
[   44.279158] remove_vm_area (mm/vmalloc.c:3189 (discriminator 1))
[   44.283858] vfree (mm/vmalloc.c:3322)
[   44.287835] execmem_free (mm/execmem.c:70)
[   44.292347] bpf_jit_free_exec+0x10/0x1c
[   44.297283] bpf_prog_pack_free (kernel/bpf/core.c:1006)
[   44.302457] bpf_jit_binary_pack_free (kernel/bpf/core.c:1195)
[   44.307951] bpf_jit_free (include/linux/filter.h:1083 arch/arm64/net/bpf_jit_comp.c:2474)
[   44.312342] bpf_prog_free_deferred (kernel/bpf/core.c:2785)
[   44.317785] process_one_work (kernel/workqueue.c:3273)
[   44.322684] worker_thread (kernel/workqueue.c:3342 (discriminator 2) kernel/workqueue.c:3429 (discriminator 2))
[   44.327292] kthread (kernel/kthread.c:388)
[   44.331342] ret_from_fork (arch/arm64/kernel/entry.S:861)

The problem is because bpf_arch_text_copy() silently fails
to write to the read-only area as a result of patch_map() faulting and
the resulting -EFAULT being chucked away.

Update patch_map() to use CONFIG_EXECMEM instead of
CONFIG_STRICT_MODULE_RWX to check for vmalloc addresses.

Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Closes: https://lore.kernel.org/all/7983fbbf-0127-457c-9394-8d6e4299c685@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Tested-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---

Andrew, if you can pick this up before -rc1 it won't need to wait for
arm64 tree rebase

 arch/arm64/kernel/patching.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
index 255534930368..945df74005c7 100644
--- a/arch/arm64/kernel/patching.c
+++ b/arch/arm64/kernel/patching.c
@@ -36,7 +36,7 @@ static void __kprobes *patch_map(void *addr, int fixmap)
 
 	if (image)
 		page = phys_to_page(__pa_symbol(addr));
-	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+	else if (IS_ENABLED(CONFIG_EXECMEM))
 		page = vmalloc_to_page(addr);
 	else
 		return addr;

base-commit: 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6
-- 
2.43.0


