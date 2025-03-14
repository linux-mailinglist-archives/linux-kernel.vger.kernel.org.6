Return-Path: <linux-kernel+bounces-562221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44ADA61F60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D3C3AD2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B7233132;
	Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1NUnK7r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A722FF2E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988522; cv=none; b=ofep+c1yPJ1HW44q1HX/jVONEQpTQB5o/leireQeCzkBhgg1iTOrg/+r2dssWkYio95SAghmtwScHxcMN69VK1Bm3qXJGJH2l/Qq0eajPqGCsFKUwD1/HOf64LvXz2cnThbWIu5GqCxgj1nlsc9fvqudICZhL90cLGhmFru7MLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988522; c=relaxed/simple;
	bh=qqzesLOe3X4Ltjb88hOoCiAxYvll/tl7oXQIyXa17jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a00wDewpTy5PvLYqpt+fvjFlHtDRkgyDaC0mNAyRJY9/vOW8BYdCYdQ2gDFPK5FtwKkegJSmtJATAX9zFOxsYKlF9PDAdwyUN7NFGEDz3VRQY6RI7wXS5g3PBMsgQ2OC7AJT53AkVDlcEElIqeCGtUMHVaa6A43FhgtkVCGU3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1NUnK7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348E2C4CEED;
	Fri, 14 Mar 2025 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988522;
	bh=qqzesLOe3X4Ltjb88hOoCiAxYvll/tl7oXQIyXa17jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1NUnK7rMoAPxCxOQNcWSKoO1CT39JrAMBbv2wUFC//iVYB/AxuXk5bO6wRb5AicJ
	 zFZiu3qQ3PycpRFqFERi4KqLP+Fm3Sc8H0dkxWOoJhgDSWVhOIVWbf1qWBZb2TYK+V
	 KCnkGiaVkQf0SSNrxddfpmJ00TtC+W5rWzhKVoFms4klIKHVziG+98c30Io4EZjlak
	 Cdy1dsHyYHqdFkT9/FcH7dGGdoU0pI85qINNKW5B2zhDicH8/u/WHwBMEHbd5V/ZiG
	 Vlz5H1MN/RQl2z/G5pG7ViLDCS0hhb5tPUvC12siksmDD7AjwoKLmrG48clb0kyabX
	 +QVyuLuS6N6hw==
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
Subject: [PATCH 15/20] x86/cpu/amd: Use named asm operands in asm_clear_divider()
Date: Fri, 14 Mar 2025 14:41:28 -0700
Message-ID: <ced9352a854e896e00f57ab2b062526d688a5b8a.1741988314.git.jpoimboe@kernel.org>
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

Use named inline asm operands in preparation for using alternative_io().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a1baf2fc5f9b..b458ff0e4c79 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -709,8 +709,8 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
  */
 static __always_inline void amd_clear_divider(void)
 {
-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), "r" (1));
+	asm volatile(ALTERNATIVE("", "div %[one]\n\t", X86_BUG_DIV0)
+		     :: "a" (0), "d" (0), [one] "r" (1));
 }
 
 extern void amd_check_microcode(void);
-- 
2.48.1


