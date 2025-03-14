Return-Path: <linux-kernel+bounces-562211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E76A61F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB3E189D1B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9D2066F6;
	Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhC3Jete"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5082066C1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988517; cv=none; b=JRlnm87KdMe2nIhhCbT0uJWvL3/r2kJn/yFT8epRsOHKtomgVwWHdFyBp4imh+37kwnszcbi5ByxBA+2JZtA9ZpBs6Wg92sC/+30/2s7c3nMBjMrtz0Ip8hFLelJIyaYx8Uc4Qv6GgCGaylb49EzoSvgKQw6HNxDePX1QdSIl9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988517; c=relaxed/simple;
	bh=E3hR7r2iMC1tiZQQhuyNJ1KYebMDQRIzygmPhbaGeWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucrUcwO9wWlb8HrLoGag35hV7U8LNJdsL2nDzW/awit3XlVUsRi6LhKQ8nKlaKH+orrlkYM1jamOxyxlEjyc/e/IDEvIFSGW5yaEoBkd4UGY7ejNPuSH34n7zHWUvXY8mP1e7b/gC6oNJw/k9vAux5FEne4iDVdpDa9f8JPqPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhC3Jete; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75398C4AF0C;
	Fri, 14 Mar 2025 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988515;
	bh=E3hR7r2iMC1tiZQQhuyNJ1KYebMDQRIzygmPhbaGeWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhC3Jete99t0ASSDJup2YypbIYeuAb+kqyfnsbHhjXi0ch51+7yyrwegnzK0k3u8H
	 zM/FPwVvU9qQUz1I4GiWRQC183J+SQV6J0te2wjsaRbB3wBFK5HrHkWITBlDzrZGdV
	 0xs52uPxR3i+T9DZKb7BmL8o9yckvnvp7i6c7BKbKyL5i4ovNqWPrrtolAeej3ZKgb
	 dOk7JGejsm1kbbRF+LMKHkIoZGV3dbOuAK/Y6kKsibwJxkuTtHfE5yO5btIDpf1BP6
	 R+zzWujRfYo2RMViZfD/tYcOdydiCZwC+3vzp6nbUcGbJVsKvDnV/b4EYhzo0Fvnpj
	 eklJ/7ic33Dyg==
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
Subject: [PATCH 03/20] x86/mm: Use named asm operands in task_size_max()
Date: Fri, 14 Mar 2025 14:41:16 -0700
Message-ID: <1dfdda41e63f0eefe39ab3982e917d9c3ef3a499.1741988314.git.jpoimboe@kernel.org>
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

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/page_64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index b5279f5d5601..db3003acd41e 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -85,9 +85,9 @@ static __always_inline unsigned long task_size_max(void)
 {
 	unsigned long ret;
 
-	alternative_io("movq %[small],%0","movq %[large],%0",
-			X86_FEATURE_LA57,
-			"=r" (ret),
+	alternative_io("movq %[small], %[ret]",
+		       "movq %[large], %[ret]", X86_FEATURE_LA57,
+			[ret] "=r" (ret),
 			[small] "i" ((1ul << 47)-PAGE_SIZE),
 			[large] "i" ((1ul << 56)-PAGE_SIZE));
 
-- 
2.48.1


