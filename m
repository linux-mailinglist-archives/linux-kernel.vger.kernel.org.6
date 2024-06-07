Return-Path: <linux-kernel+bounces-205886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B040A9001DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2AB28337F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E4193063;
	Fri,  7 Jun 2024 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixcC4Ay+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F009519146B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759034; cv=none; b=eBwCku0rq5vSUWvyqju8g7+dlZYpRD3w9TyAxXqTHWhxgiCQooQstrfy5BkrQ4e6xJ3AnpZlc8fJ0pbMPxmeclRP4yk+CL09JYYyboOG5dzv9AGwSKozcGOB9b8MhLeTA8VuI408mHR1piQGeBPQJcIrml5mYIny0zL/izEi84M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759034; c=relaxed/simple;
	bh=jzhujQuJXGlLkVBXPJVMy7/GVgi305oTlkYSmvQWPSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfJy3+dxGkvGk9bWuamUJGhNhlWFUWAgb0yWFosIZyk3H2c2LR08dN+hLsrHeDhncBbOoQdEFTL3DqabiKCg8sd3reSrvzqXeDhaJF+1+AS1au9rgvfOOFnz70CsQ1SvLbsJ7mmMcniED6s0LudJnEniwC3pG/tof/8MbbSgG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixcC4Ay+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038E8C32781;
	Fri,  7 Jun 2024 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759033;
	bh=jzhujQuJXGlLkVBXPJVMy7/GVgi305oTlkYSmvQWPSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixcC4Ay+mySyaHhLRSmQ3DYtgRjZenrqrtGQld+I6dDbX7+sJvGJOifTfTLZuZCCO
	 oJiOiCu3WDZdJaQr1/N6HVSwCZ3e2EcKaITf+ykV8nB0lU+svDH9VwCWBJNnOcPhG7
	 fdfAbBHnCx6pLoU3xlY4gTdPh72vTHGcoflESECeRjnRBqZxb6hR43VnkLBa4w9+T1
	 bqk+2cmYxzyTIFioqZxoQMHc34ykpZuISTti7J5PpVV850sIgk4y2zyXDRpDH9Cw3u
	 2wGMV1yl4dhaGoZlTDfhY1Glx2BhVgP1KgeS1dFUTzfhveLD99w9Hi7qs0iBv3mc2M
	 phf5kWSqwcwPw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 05/14] x86/alternative: Convert alternative_input()
Date: Fri,  7 Jun 2024 13:16:52 +0200
Message-ID: <20240607111701.8366-6-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607111701.8366-1-bp@kernel.org>
References: <20240607111701.8366-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 21ead5dea15a..428d6efeb333 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -330,7 +330,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
@@ -356,10 +356,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
-#define n_alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
-		: : "i" (0), ## input)
-
 #define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile (N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
-- 
2.43.0


