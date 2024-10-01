Return-Path: <linux-kernel+bounces-345929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1625E98BD06
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1CC281BBF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E461E529;
	Tue,  1 Oct 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qskBIpNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlM1Urr+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qskBIpNw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wlM1Urr+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47175637
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787841; cv=none; b=DrA5cVbz/l+1UEckqAFcKdL16XxWFQ587thJfqqL+WigulcwFKUvNur4CKQC2JXjzzHCstTndEIw5WmGw/lzoyFBFH6ikNhQbILpKRLAEvxQX6jo9gsZjaRAPPEaE2Pz3rAT7Y0V1jHWOkLB3xxc6uyDcbC9M0nQ9x/bAcNoqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787841; c=relaxed/simple;
	bh=CPlyYqaItYtSa/l+0ge7Ka4UUYcebs8jiOEFNY3uULQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5wifOFttYh68Pxga/olPZm95a0eXttwJRYigS3RAg5EEGfernNStZc1WCYiH4A1qfwZs+TdYdNiax9YidOSCLXRa1tYxxiTcUlVsqBIHHd+IWyuBNePW7wZBpLVUcmpSNEPKuDLH+cXfGSV9JsucI8mLmC3QI9S1fYvbN3Req4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qskBIpNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlM1Urr+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qskBIpNw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wlM1Urr+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id 851B21F815;
	Tue,  1 Oct 2024 13:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAFrS2gtZ6vbfUdvA7+l7l6X2p/R1xo8REN2aL4rGOg=;
	b=qskBIpNwjF1rEfU5n9wZHWm/VGt3hUfaJb+CwTtDydeu479e4SxtsOEP5URgOOeNNqmFpf
	dW7ey8DxzPYObdXcxd4tl6ZZseXbras1cYEXxKVCpsZE9I0ETste5At6xste4kR/oUTmCB
	ZfZZQCAlSRe/LhaG3NEbRAOkcbRNUKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAFrS2gtZ6vbfUdvA7+l7l6X2p/R1xo8REN2aL4rGOg=;
	b=wlM1Urr+jARZVYXz9eiccINRWn8vkHC80it0EXwI3c1QrpcNlh3NTb1I21Caa7Td6P78oP
	Bx0geE+yD6J/ihDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727787838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAFrS2gtZ6vbfUdvA7+l7l6X2p/R1xo8REN2aL4rGOg=;
	b=qskBIpNwjF1rEfU5n9wZHWm/VGt3hUfaJb+CwTtDydeu479e4SxtsOEP5URgOOeNNqmFpf
	dW7ey8DxzPYObdXcxd4tl6ZZseXbras1cYEXxKVCpsZE9I0ETste5At6xste4kR/oUTmCB
	ZfZZQCAlSRe/LhaG3NEbRAOkcbRNUKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727787838;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAFrS2gtZ6vbfUdvA7+l7l6X2p/R1xo8REN2aL4rGOg=;
	b=wlM1Urr+jARZVYXz9eiccINRWn8vkHC80it0EXwI3c1QrpcNlh3NTb1I21Caa7Td6P78oP
	Bx0geE+yD6J/ihDA==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Mackerras <paulus@ozlabs.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/sstep: make emulate_vsx_load and emulate_vsx_store static
Date: Tue,  1 Oct 2024 15:03:49 +0200
Message-ID: <20241001130356.14664-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <ZvvrHpD-v4CuDqsm@cleo.paulus.ozlabs.org>
References: <ZvvrHpD-v4CuDqsm@cleo.paulus.ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,gmail.com,csgroup.eu,kernel.org,linux.ibm.com,ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

These functions are not used outside of sstep.c

Fixes: 350779a29f11 ("powerpc: Handle most loads and stores in instruction emulation code")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/sstep.h |  5 -----
 arch/powerpc/lib/sstep.c         | 12 ++++--------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/sstep.h b/arch/powerpc/include/asm/sstep.h
index 50950deedb87..e3d0e714ff28 100644
--- a/arch/powerpc/include/asm/sstep.h
+++ b/arch/powerpc/include/asm/sstep.h
@@ -173,9 +173,4 @@ int emulate_step(struct pt_regs *regs, ppc_inst_t instr);
  */
 extern int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op);
 
-extern void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-			     const void *mem, bool cross_endian);
-extern void emulate_vsx_store(struct instruction_op *op,
-			      const union vsx_reg *reg, void *mem,
-			      bool cross_endian);
 extern int emulate_dcbz(unsigned long ea, struct pt_regs *regs);
diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index e65f3fb68d06..ac3ee19531d8 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -780,8 +780,8 @@ static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
 #endif /* __powerpc64 */
 
 #ifdef CONFIG_VSX
-void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
-		      const void *mem, bool rev)
+static nokprobe_inline void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
+					     const void *mem, bool rev)
 {
 	int size, read_size;
 	int i, j;
@@ -863,11 +863,9 @@ void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_load);
-NOKPROBE_SYMBOL(emulate_vsx_load);
 
-void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
-		       void *mem, bool rev)
+static nokprobe_inline void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
+					      void *mem, bool rev)
 {
 	int size, write_size;
 	int i, j;
@@ -955,8 +953,6 @@ void emulate_vsx_store(struct instruction_op *op, const union vsx_reg *reg,
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(emulate_vsx_store);
-NOKPROBE_SYMBOL(emulate_vsx_store);
 
 static nokprobe_inline int do_vsx_load(struct instruction_op *op,
 				       unsigned long ea, struct pt_regs *regs,
-- 
2.46.1


