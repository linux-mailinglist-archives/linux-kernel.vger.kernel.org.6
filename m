Return-Path: <linux-kernel+bounces-448826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050099F4617
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E47163BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164541DDC35;
	Tue, 17 Dec 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJKMhf43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171E1DDC27
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734424266; cv=none; b=IYDlYT5z1glyzJewkKSyz7PAgn74/awrXgDkCBznIzWwRxukQZCMWNRob5I8b4qWrJDthja4Knc5olghHDRgwrr8ARZ0/DHcIQCJjWErbNNWQwn0bjZORSpEcBNhg2AT60sieaEYOoEuaU0vVKfBSl08/5eXuN7N4XI03oTQTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734424266; c=relaxed/simple;
	bh=NeyOgW/HjJNx3GR9ziJgW16jwf+b7bR+td04VCgLl8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXvd2K+kSNvzPNQl+wrnkIM3EyhKxI84jNyLn5J7lWfdMi7GPhdW+/OJbZrgNxksS+Uin10mjZdjkGghrggLKXynMTe0JnwPh7OOhjawnHUIAZXtzYA5i8XNzu548jGK6cmVmYzG5XsnplJCGvNv31pmKau8ujAiQJ3u5r8PTPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJKMhf43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DB3C4CEDE;
	Tue, 17 Dec 2024 08:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734424265;
	bh=NeyOgW/HjJNx3GR9ziJgW16jwf+b7bR+td04VCgLl8g=;
	h=From:To:Cc:Subject:Date:From;
	b=NJKMhf43NcEZeDty9pMRBT5xfLnGnO77umSulCjdJfLmtxr8zqk2M97q9bqiKsu6Q
	 346VDQ7pi2QVb/ajqYSbQcP9mm2LL9SIP9twg0kGGHn3YzLkwp82Roal+HBs6V4Mfx
	 nHYFt/LReEVlVyOGaMTJM0HhU2iP5vPnXAhyi07dMfOK0afVFgZq6qSZM5PVU4AzEU
	 hHps+OmThiQkjrvXaYQx8UrrA6/Vk5G39NIbVxHgr+/zXK46YXQ3saOGBEh4HVelE/
	 aE8HuDlmT0e1o154aqJld+aL8HZmlGpZ8YYNh2FAh9SnRq1DNsGv4ey+cT2fM+wNMi
	 3vxuTp/NazJZg==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: avoid false-positive objtool warning in page_fault_oops()
Date: Tue, 17 Dec 2024 09:30:41 +0100
Message-Id: <20241217083059.1124426-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When printing the oops for a VMAP_STACK overflow, the final call
frompage_fault_oops() does not return to the original stack, which
confuses gcc, and the unreachable() annotation leads to the end
of the function just continuing on in the next one:

arch/x86/mm/fault.o: warning: objtool: page_fault_oops() falls through to next function kernelmode_fixup_or_oops.constprop.0()

To work around the warning, add an explicit endless loop here that
objtool can detect.

Fixes: 6271cfdfc0e4 ("x86/mm: Improve stack-overflow #PF handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not sure about this one, maybe there is a way for objtool to
detect this and not warn?
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..0ef6e3cc54d2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -678,7 +678,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
 
-		unreachable();
+		do { } while (1); /* unreachable */
 	}
 #endif
 
-- 
2.39.5


