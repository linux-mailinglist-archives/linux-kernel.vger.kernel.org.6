Return-Path: <linux-kernel+bounces-362825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD02B99B9A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023C51C20A30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E503813D52C;
	Sun, 13 Oct 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T32xBRYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D74D36B
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728826832; cv=none; b=Ityht2WnqxuJ1ncUBysbgwviqHlf89GTb9tenGnFkevZGMW2UU2W2xZZqimI5NZuO61V4Z5NFQfF7LHWQtHCqh/dmlOE1JlO7o1TCi73Fu0Sg9l4b+0R4WV5t5jL3aBJYThrkMLFzSzRix4FnrJoqGeO5S5IWpBnAWLAcKCx+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728826832; c=relaxed/simple;
	bh=J9IpKZ04hrcgz+cG1LHCaociYi/oUK7qDAOHHUpwG9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQjxYCNIaz4E766Eyk84NGOBl1tNFqQqa2tn5dbnR429duM282ivyB4xAiUtN14Ql2eQIxp+Wbv8cH9zbdC8hz1j9RqP1NwfqgJe8n12cOj6B45wg4Ww/jRuootWyJYRpfkn13xI94yMOmJpcr7Vo4hdxnRTJYwtgAhCdq3zII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T32xBRYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3609C4CEC5;
	Sun, 13 Oct 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728826831;
	bh=J9IpKZ04hrcgz+cG1LHCaociYi/oUK7qDAOHHUpwG9A=;
	h=From:To:Cc:Subject:Date:From;
	b=T32xBRYwNuMxLQYDzr76eGdiFM0yq0+OPS2Xxs4ItUh9Aed+uyhCFaHSmUgMOrSob
	 DNo3unkDjYPNlrwf4tkPxX12fHVRBoM+h67+lCYJn7Vy7IX38n09gtAymTzLj/aSxA
	 7zc8+Ntd1O02I+xgZdMpWC84eEglTdM/IUzqwui6Y20YXeGH7ZMvtQieGJF6XPH7GD
	 cPJSoufVGOj0pDKNvKUatiKiFlpC/dmKtbHNPSRFI9gaPq/Q2slMqMhR0OhnE8seXp
	 Hhi7KCWcOqx2Fa3ixzT201y3EGwAh+0a/8ZJGcBSm/HZiF1EdWz1KttRRdF3uu1oeo
	 YjW9/Z/qeRtfA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Vladimir Murzin <vladimir.murzin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: NOMMU: Fix exc_ret for stack frame type
Date: Sun, 13 Oct 2024 21:25:20 +0800
Message-ID: <20241013132520.2848-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 72cd4064fcca ("ARM: 8830/1: NOMMU: Toggle only bits in
EXC_RETURN we are really care of") only sets BIT[3] for Thread mode
and BIT[2] for PSP, it leaves BIT[4] untouched. But there's such a
case: the pre-linux env makes use of FPU then the BIT[4] in 'lr' is
cleared, this brings an umatch issue since the NOMMU kernel doesn't
support FPU yet. Before the above commit, we hardcode the exc_ret
as 0xfffffffd, so the flow works fine.

Fix this issue by explicitly set BIT[4] which means using standard
stack frame.

Fixes: 72cd4064fcca ("ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care of")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm/include/asm/v7m.h | 1 +
 arch/arm/mm/proc-v7m.S     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 4512f7e1918f..3aea6d3c97ee 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -51,6 +51,7 @@
  */
 #define EXC_RET_STACK_MASK			0x00000004
 #define EXC_RET_THREADMODE_PROCESSSTACK		(3 << 2)
+#define EXC_RET_FTYPE				(1 << 4)
 
 /* Cache related definitions */
 
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index ed7781c84341..fdae077d2654 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -138,6 +138,7 @@ __v7m_setup_cont:
 1:	cpsid	i
 	/* Calculate exc_ret */
 	orr	r10, lr, #EXC_RET_THREADMODE_PROCESSSTACK
+	orr	r10, #EXC_RET_FTYPE
 	ldmia	sp, {r0-r3, r12}
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
-- 
2.45.2


