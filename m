Return-Path: <linux-kernel+bounces-534996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CEEA46DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE051884A39
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47A266EFA;
	Wed, 26 Feb 2025 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4W21VhZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD825A659
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605880; cv=none; b=O8c0Jbx4z4+S+sWi6F8NirUpYRkSJAWJ+JGu7tjyDI3eihVNdI+sHwUZe2sEgcehch0xw2jSC7ZPCWgb9MmeSpcfOl6XYJDlqp0NvP09S5Pv8BGskrwax/sYLjk1bWaJyMvMDuY4TRUyQoUj9CUQvieP50fw99qbMxEKj0c1538=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605880; c=relaxed/simple;
	bh=IOxQVnALRKR6nwmNlhLbcO8Dis1BaEtI2yIqJXyBP5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d22EFgs+apX4KJ5mVahBzJIONo0HgblieA8vVdssUVBTL6UYh38fP72wJacNydmD1TKAZgs7aHpXSKkAOTu3xgUpmwg3rcDaksSeOImNBW9TP/GnEQhVzOfIpLMQLmF5moqh5R6YPcXYnBUWoOlZ4eLoggVBIIiLcVSZD18Hrms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4W21VhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF84C4CEED;
	Wed, 26 Feb 2025 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605880;
	bh=IOxQVnALRKR6nwmNlhLbcO8Dis1BaEtI2yIqJXyBP5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4W21VhZgJrYaxE9alE/r5v6cKrWD3ezLnm/9XG+b/JWPbuh2K3TY7kHWArOmOHDO
	 PivTHoOVgvG2yxddAR0LeVTY+xxROJFcSNoX77hymIDip58Gu8QpBE1pqabo9NA4gI
	 a2gF7ss47BQT/4+NupWT2VgL9UuHhVncDGp++VaxoF87tGY4yhWVrnRXaqtDejIoxJ
	 xHWaUe6SuPNtel33DgB3QQWz6KB5qNynOWK0PtilP3VtaZdzHn6QGyCA6QMlNx72R0
	 n39A9D9++Tao/W1NktnnhfiqhSjWoXMGxy/OUU7m4NTvHGNbYP0613MxNq036ntfBH
	 rB59TBQd4E1ew==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v3 10/10] x86: only allow EISA for 32-bit
Date: Wed, 26 Feb 2025 22:37:14 +0100
Message-Id: <20250226213714.4040853-11-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The CONFIG_EISA menu was cleaned up in 2018, but this inadvertently
brought the option back on 64-bit machines: ISA remains guarded by
a CONFIG_X86_32 check, but EISA no longer depends on ISA.

The last Intel machines ith EISA support used a 82375EB PCI/EISA bridge
from 1993 that could be paired with the 440FX chipset on early Pentium-II
CPUs, long before the first x86-64 products.

Fixes: 6630a8e50105 ("eisa: consolidate EISA Kconfig entry in drivers/eisa")
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 14dd7b5abd5d..f84a9e5dda20 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -232,7 +232,7 @@ config X86
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select HAVE_EISA
+	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
-- 
2.39.5


