Return-Path: <linux-kernel+bounces-521392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED08A3BCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA771705EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082E1DEFCD;
	Wed, 19 Feb 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ELOE7ZeY"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF11BD9DB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964083; cv=none; b=mX8OO2YrzklI4ovRbggAScFf9hcF0tdB52BwRhR98y2ddDxOSMiHPBRnKKZHAZUC5s3TqGEaJ/so9v3MsUMRI6r4/nNoeWTR3c/D2HGmQhkklLlq52SlMeveZfL8QfZgJWuUG+2/+WhqBS2UrkRZt6qFr8JSTnXvKNt93F0jKR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964083; c=relaxed/simple;
	bh=0X8soow25xmSzoBM0xzKEe88bCQ3b2NQt9ZENzJ6HCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXQqBcoIRRpASI48kVF8szB5j9TVh1zJeLif7Pr9hQj/70E9IdbVfRkP6MoaOxM/sHfuBv2GV0vcMDGpOqzgvTrAWdWx/VCSgnlAb9bw5FCtOQfNvOtoNMJ16F+YvV0PPpcTAvFSD7thDoh7G8RyoWibB5ww+QEtCW3oYL/CiSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ELOE7ZeY; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739964079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VbnfYpgjWkRFEHyP0AjeLJC9trz2T52WuBKfYylRL1Q=;
	b=ELOE7ZeYVBe7n7GTsLUiWA+YpQPM0B19luO+whrKKrz/ZSizg3ZAkrD05CqAR1J/E7fiSx
	aNp9dJO3S8tyZ+R4/OFCMvox/ut6fRs7hq+jgOCn/6TGx9b7tiWRM5mZw2kbiObtZjp5V0
	SXCFFkX0523/vbML2Rq3ae9+sfeUdj0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <ricardo@marliere.net>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] powerpc: mpic: Use str_enabled_disabled() helper function
Date: Wed, 19 Feb 2025 12:20:52 +0100
Message-ID: <20250219112053.3352-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
warning.

Reviewed-by: Ricardo B. Marlière <ricardo@marliere.net>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/sysdev/mpic.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d94cf36b0f65..25fc4ac91814 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -27,6 +27,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/syscore_ops.h>
 #include <linux/ratelimit.h>
 #include <linux/pgtable.h>
@@ -474,9 +475,9 @@ static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
 		addr = addr | ((u64)readl(base + HT_MSI_ADDR_HI) << 32);
 	}
 
-	printk(KERN_DEBUG "mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%llx\n",
-		PCI_SLOT(devfn), PCI_FUNC(devfn),
-		flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);
+	pr_debug("mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%llx\n",
+		 PCI_SLOT(devfn), PCI_FUNC(devfn),
+		 str_enabled_disabled(flags & HT_MSI_FLAGS_ENABLE), addr);
 
 	if (!(flags & HT_MSI_FLAGS_ENABLE))
 		writeb(flags | HT_MSI_FLAGS_ENABLE, base + HT_MSI_FLAGS);
-- 
2.48.1


