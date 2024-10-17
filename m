Return-Path: <linux-kernel+bounces-370655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB6C9A3026
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180151F22B18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4287E1EE027;
	Thu, 17 Oct 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxSb0QpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314C1DE4ED
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202131; cv=none; b=htJkh0T61zjZPHH9tk9i2NAIpmUy18Sq4uRkPgrca7l42ivn7Ird+PgI57AB7BW/wYRxMGfoIN45RN0XwZWTztaendT/0nvqDj8FPLJuJ2ANBjPbu2EZka7iuXLn5CpBtdexZ4pkGpEc9CPQHkInQNyjiXMEbyN6DTEBt3d65X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202131; c=relaxed/simple;
	bh=opTfvoucneR4FnsToYqJIQ2vAsIrtZ9GVWhav979RCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfKc58HYePyCLcwYvqUObu1uRcvqf4eYtPCEaBuzp7b+DC/mEkf/nf/kpIS07hTuJut4DRVIGw/GbfF9ixRgnfN502xuxEq1mxUYAd5I6257w4PPuftM/ukCjgqtdQ5VJYweqmzvx2FD9H+REU+i15jAA0FCnIlgoYWeBeqng1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxSb0QpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17A8C4CEC3;
	Thu, 17 Oct 2024 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729202131;
	bh=opTfvoucneR4FnsToYqJIQ2vAsIrtZ9GVWhav979RCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxSb0QpAIMqiN4HI9o5K6GW+rkBMV2URDlO14dMxDoDJzEWfPvquUxVQ5hm8pQmkx
	 43qcYbZDzeLJqryctoK0nWFeX51ZT5JQwsA3zcUlKHjW/V3/WYXNA5dHkSBiMDmR7r
	 FNs/BZvZOhDnougKtZALz8ZZxadM48pBr24W2appoYcj7pUuIr1FDlDmmJO89CXqs6
	 6CuDXUronT/fSOE0ULA/lFjCU6Ot0QmXBgvr9vPWd+isX+b8RkNv6gPKtPgq6GKI8h
	 KiFV2651yGF27415Tjt3LZ2FXdVzMG11jflBg3CcVtQcyqZWDr3K2Lwl4y4ABsU9bV
	 VX+CnZpzvHY4A==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 6/6] x86/uaccess: Add user pointer masking to clear_user()
Date: Thu, 17 Oct 2024 14:55:25 -0700
Message-ID: <7db4ec5c9444e4b76d45a189fdd37f6483c06bef.1729201904.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729201904.git.jpoimboe@kernel.org>
References: <cover.1729201904.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add user pointer masking to clear_user() to mitigate Spectre v1.

A write in a mispredicted access_ok() branch to a user-controlled kernel
address can populate the rest of the affected cache line with kernel
data.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 0587830a47e1..8027db7f68c2 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -199,7 +199,7 @@ static __always_inline __must_check unsigned long __clear_user(void __user *addr
 static __always_inline unsigned long clear_user(void __user *to, unsigned long n)
 {
 	if (__access_ok(to, n))
-		return __clear_user(to, n);
+		return __clear_user(mask_user_address(to), n);
 	return n;
 }
 #endif /* _ASM_X86_UACCESS_64_H */
-- 
2.47.0


