Return-Path: <linux-kernel+bounces-562226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6B6A61F61
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5CE7AFA5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575C2376F2;
	Fri, 14 Mar 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krr+bTIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5622236A84
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988526; cv=none; b=S95e0h44dWZQzDMpX3PAe+FtG+Ix1RzxiEXTgL0PzRqnhTl+xJ6NbhjdI8bPdYWGiasTb4l6v4jc+krG3VEflv4abuYEIsAraCddvTyXteWGxsOAk7f+0Vf6RUASe9SvvAiqKMW+J+sVEjDxaaz3W8Z/Wn79WFGzawffLfafe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988526; c=relaxed/simple;
	bh=QEu/+JYx8qH0znXupo+H8I159zjwFZQNXDvmmFhC/iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoER1v7Ad0yq1Wm0ahvW/1VuATyJVZCd+VfR01vkogqSa+xmE6L7EyQw0n1BnAtz82kwLnlcrB58J5UMn4Gl702kN7P6HCLhm2OumB18xRN2v3n3DncJM9bWbjpbdp5PKlWoPaKZHRKOGrk0ajN05o5wnBg8rZyN8F1GwiDI8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krr+bTIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C99C4CEE3;
	Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988525;
	bh=QEu/+JYx8qH0znXupo+H8I159zjwFZQNXDvmmFhC/iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Krr+bTIyxkdmvcoK1uPAfAZqbgqdA1gRsg+CV8sTJlO8qSNWgVIXa0fbrL8wwgmhG
	 O5rmx5cWCdVcMjrKa1DA63ryr8ZLoKRwgj+W8uxJGP12ayeOKz1bhPDjWRPCUHsIha
	 kjFiyevm2WWUE/P58N0f+e0dY2ujUFmmqMgVg0qqXsa28DpflQ6QoOR4zKxPQWDsCS
	 exFzJnKdjWIPNNic+DzZ6l4GXd0foRGDUQxrgChHbCe7JeEQkBwnfQ7FSIyZY6d+R8
	 XW/nx9AK0BOKmnmI1zjrVHNW8lw30Pbnc1Q+rfofmEIfjNaEPGAHoeUJ8a+luK/13E
	 XiP1unRmUuFKg==
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
Subject: [PATCH 20/20] x86/msr: Use alternative_2_io() in rdtsc_ordered()
Date: Fri, 14 Mar 2025 14:41:33 -0700
Message-ID: <acc41322fdb01204f365b6b7342bed403a99773a.1741988314.git.jpoimboe@kernel.org>
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

Use the standard alternative_2_io() interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/msr.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 001853541f1e..996e3b5857c6 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -214,12 +214,13 @@ static __always_inline unsigned long long rdtsc_ordered(void)
 	 * Thus, use the preferred barrier on the respective CPU, aiming for
 	 * RDTSCP as the default.
 	 */
-	asm volatile(ALTERNATIVE_2("rdtsc",
-				   "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
-				   "rdtscp", X86_FEATURE_RDTSCP)
-			: EAX_EDX_RET(val, low, high)
-			/* RDTSCP clobbers ECX with MSR_TSC_AUX. */
-			:: "ecx");
+	alternative_2_io("rdtsc",
+			 "lfence; rdtsc", X86_FEATURE_LFENCE_RDTSC,
+			 "rdtscp", X86_FEATURE_RDTSCP,
+			 ARG(EAX_EDX_RET(val, low, high)),
+			 ARG(),
+			 /* RDTSCP clobbers ECX with MSR_TSC_AUX. */
+			 ARG("ecx"));
 
 	return EAX_EDX_VAL(val, low, high);
 }
-- 
2.48.1


