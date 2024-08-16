Return-Path: <linux-kernel+bounces-289756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464C5954B59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7075E1C242A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614601BD015;
	Fri, 16 Aug 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHud0r+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CED1BD016;
	Fri, 16 Aug 2024 13:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723815922; cv=none; b=uezrNj4ui/8TQS6e1E+yGYbMa2koTf2MMfWO7a6n0R9o8ESmR75lFx3WI5t6aoxuX058VvPPTKb5lizXQI8j3cXsffftkp1QyWIgz4VSkxLs6VebC9Az7oXSZ0aG+qVFHa8KZTkcNzoJpFmn41ZZ2USQzsgX1plG2/YJyDMEPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723815922; c=relaxed/simple;
	bh=Ts5tF9pWXXxmeyRHAlmbZkS/2Bgc9tMgGvi92mLtYz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGjuPll2D0+oaosZ53HU+dKiVEdXI+ZE/ClnlcKM6mVhTYBixksTt1SdCKBfxW/T9phxYH6znMZ47rguL9f4+fGtWxh2ifJ9H7Fr9bYGrPl7dWN/pMyCjAFav9m7yJKdkLSF/HsaOxLvj4MqH4ekCn/x9Q1Ik4RMVUDy9aeqtm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHud0r+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB2FC4AF0C;
	Fri, 16 Aug 2024 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723815922;
	bh=Ts5tF9pWXXxmeyRHAlmbZkS/2Bgc9tMgGvi92mLtYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHud0r+okm3N6FjkCgg/XwzOemV7DxbyOQXvcaQ86HbygRd13vVeAVkzMaUE26uq2
	 onckVAxD3tGdSKBh89EFmLOuzIapFX+kXZhuTC1EPsuDn8irjLWazBrunkjNpNdcQk
	 zq7XHRzz/9rNtIzl4AbT6xhsAiZGzVjHhxA54MSJ6vvD2wBM/ojNNicBh52s5W786a
	 1mORVj2CQ/yC7XGYeAVUWrv9HyF/AlPnNmRvtlMWsSt7vTqCnEobK+TzPGV0TSR6kT
	 l/lhsem30/0kIKqg4m8cTdikbKrPg68oQxRnPuGqWzqR7xMUtkyj3RVw8C5fn7U/T9
	 0k3ItHB92eKHA==
From: Alexey Gladkov <legion@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	cho@microsoft.com,
	decui@microsoft.com,
	John.Starks@microsoft.com
Subject: [PATCH v3 07/10] x86/umip: Avoid crossing the page boundary
Date: Fri, 16 Aug 2024 15:43:57 +0200
Message-ID: <5bb84bce0c798a76a318a38e1bb827af10ecaefd.1723807851.git.legion@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723807851.git.legion@kernel.org>
References: <cover.1722862355.git.legion@kernel.org> <cover.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Try to avoid crossing the page boundary to avoid side effects if the
next page belongs to another VMA.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 arch/x86/kernel/umip.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..e85c3cafc258 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -338,7 +338,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	int nr_copied, reg_offset, dummy_data_size, umip_inst;
 	/* 10 bytes is the maximum size of the result of UMIP instructions */
 	unsigned char dummy_data[10] = { 0 };
-	unsigned char buf[MAX_INSN_SIZE];
 	unsigned long *reg_addr;
 	void __user *uaddr;
 	struct insn insn;
@@ -350,11 +349,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	 * Give up on emulation if fetching the instruction failed. Should a
 	 * page fault or a #GP be issued?
 	 */
-	nr_copied = insn_fetch_from_user(regs, buf);
-	if (nr_copied <= 0)
-		return false;
-
-	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
+	if (insn_fetch_decode_from_user(&insn, regs))
 		return false;
 
 	umip_inst = identify_insn(&insn);
-- 
2.45.2


