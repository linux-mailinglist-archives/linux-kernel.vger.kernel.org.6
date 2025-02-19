Return-Path: <linux-kernel+bounces-521446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F139A3BD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94755188BB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B611DED70;
	Wed, 19 Feb 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ludXcErk"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FA1DE4F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965813; cv=none; b=gf679KPCDIoEYME90eTyxqpJP6vMH5xRXRXWKj/bq+wJ2i2a0b3asoDAQG9BIFoUswebF/QUr4CKJ4LMeOJYn9ewmdyzJ3MrBYbBMqeXt6/6cYHJRIffgRi7UG2Jmvjp0ZvZlN9kPaKI8le+yaPx7O9ykzg0mxuLD6WnBInT44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965813; c=relaxed/simple;
	bh=TvRUawDi4w8CeIv4dHx+hf68F3bNv2Wbk8avGWQx5JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAB67tw3TlMVw1PI8GB5f6nzZTgIxXy7hdcB/JcRTwGad4AlYL+r0PFpBpUFfAsNE8XU0M6fytHUyI5/cN6CVk9BoqtXNE1jJ32VcRcoMR84vI2iEd8dW9/OmfPW/wNRbxdYb/vxqeTUZvQAoxa0OoNUPnrCLfeUnvHhQBixdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ludXcErk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739965805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0xV/vlsAbN80ay6l5yC3cLNknN3pOTSgBbepFSskVcU=;
	b=ludXcErkUQE+tYHyHG1pgKwbVb7lSopWVt55Hk3YRzFNUMSAVUC4SmjCPl9V7LyJ5PBtnc
	Aa4gjmA7YZ14Uu6WaJ/25f1JuVvwHc86L2fFIS0dKgDOVI5aBn3pFoRk7qd7QKoJuHlmHu
	vjvqZBxAteY8Sm01KcV4cbn+g4XIEY8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Oleg Nesterov <oleg@redhat.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: ptrace: Remove zero-length alignment array
Date: Wed, 19 Feb 2025 12:48:00 +0100
Message-ID: <20250219114759.20110-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use a compiler attribute to align the areg field to 16 bytes instead of
using a zero-length alignment array.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/xtensa/include/asm/ptrace.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
index 86c70117371b..4871e5a4d6fb 100644
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -72,13 +72,10 @@ struct pt_regs {
 	/* Additional configurable registers that are used by the compiler. */
 	xtregs_opt_t xtregs_opt;
 
-	/* Make sure the areg field is 16 bytes aligned. */
-	int align[0] __attribute__ ((aligned(16)));
-
 	/* current register frame.
 	 * Note: The ESF for kernel exceptions ends after 16 registers!
 	 */
-	unsigned long areg[XCHAL_NUM_AREGS];
+	unsigned long areg[XCHAL_NUM_AREGS] __aligned(16);
 };
 
 # define arch_has_single_step()	(1)
-- 
2.48.1


