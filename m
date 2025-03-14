Return-Path: <linux-kernel+bounces-562208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66872A61F38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B808017EC37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47134205E0E;
	Fri, 14 Mar 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwCJdiDD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB181DE8A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988515; cv=none; b=j/oHFY1DINu8QF/MQv9oiN16Sqp0uwJFN5rcsMutVdDGbiGXaMSxBq/OJZDReqSPUH4NRc+/ak7HubYMat2kU7cxgCKH9zChVp9Gc57eNNuZpk3rQ/vjHWhdc7mDjH5HwZGhxwfHzaHU57/Ar85MLmFUkeVcXiGWl+s6z7O12Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988515; c=relaxed/simple;
	bh=uBNtxIShQAc4QePM1z8bdXhYlOosBUvYjbVq/jJ+iq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhhjMFoJsd2rGSNZM3etcz9JED0Xva1LnCtsw3B0lBR9ovpQTtKQ2OJ7Ao36EGELwhzJLwfoAnsegSjii+6w4EpZKi1Aco2C+bhZlPfxltgBn9vljyt3gxS3LFak2SLrPDI+Uf8AzacDMvvIWc0cNifjiJsuXAN9xVdqaxLKRt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwCJdiDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E530CC4CEEF;
	Fri, 14 Mar 2025 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988515;
	bh=uBNtxIShQAc4QePM1z8bdXhYlOosBUvYjbVq/jJ+iq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwCJdiDDUrADDBCaDGpEDz0WWAhTMgx7wEuFzWv+Ds/XGMRPTyi598H4cBQXSqdWe
	 HA6fYSAAhGhQYwK/n4hFoit6G0r/KgvGP7+qgEKieY3gdLdJvALdqz/7pHQrLtbbCv
	 n/hBDPpv2A06n+Sfz1cAp6gFf9xnOpeQIMvsuJNei5JN8GTjQ9BbIH6zSCa76LVGUO
	 4nSgMhm/BKfk4sOxb2gIcNxd1DjlFYjSYKTokcGC7B3oGKG+vbf7joIeQlryNmuSGB
	 U9x+ozAExF6+fH9F/okZSn+uEVRDMJihLi8bhoKZ4g0pynHMdZ7HHzQcJYhPll+ZIw
	 /IRLqrOpu626Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 02/20] x86/apic: Use named asm operands in native_apic_mem_write()
Date: Fri, 14 Mar 2025 14:41:15 -0700
Message-ID: <397c12e48369bc6aa30094fbc8f795c642cee214.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741988314.git.jpoimboe@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use named operands in preparation for removing the operand numbering
restrictions in alternative_io().

Note this includes removing the "0" input constraint and converting its
corresponding output constraint from "=r" to "+r".  While at it, do the
same for the memory constraint.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/apic.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c903d358405d..ecf1b229f09b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -98,9 +98,9 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 {
 	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
 
-	alternative_io("movl %0, %1", "xchgl %0, %1", X86_BUG_11AP,
-		       ASM_OUTPUT("=r" (v), "=m" (*addr)),
-		       ASM_INPUT("0" (v), "m" (*addr)));
+	alternative_io("movl %[val], %[mem]",
+		       "xchgl %[val], %[mem]", X86_BUG_11AP,
+		       ASM_OUTPUT([val] "+r" (v), [mem] "+m" (*addr)));
 }
 
 static inline u32 native_apic_mem_read(u32 reg)
-- 
2.48.1


