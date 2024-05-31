Return-Path: <linux-kernel+bounces-196791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9FE8D61DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE71F26239
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FD159568;
	Fri, 31 May 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L83qQ9Yt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC903158DD0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158922; cv=none; b=i+RqQjgfcjelHpbtUOwH2E4/OLrVqtbJ3Hl6EA8iJVRK6rdalhIVAf0Mg49D19X5EV5H8vHlRa5yjg8Osv3txHG+ToHtUGRAyRtC17FyLB1dnaxV5LrZIuDWWXfcedk4gu4gW0fUrFjNTp1UW7IPDz729zpWCHtEvYO6l7JN7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158922; c=relaxed/simple;
	bh=cPNrNecxxrCgayY/BH4V35moVx5yb8yY03jdA/pam2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtFadKbiFMUTWPy5tutUZB0ATJ2RaRyAIj+ACEhwro0D390n9rz2oInLWoL3VHhE6Hda9NSVoAydLWTypETtVbxml7QfbkSJ5bb/A6O4nj/G8k1X3WJSl1P0jpTCx9l/QkdAc9vsF4qcO08TtTOoXBtBZYpbeexjfuSMuOaBfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L83qQ9Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81549C32781;
	Fri, 31 May 2024 12:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158922;
	bh=cPNrNecxxrCgayY/BH4V35moVx5yb8yY03jdA/pam2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L83qQ9YtDW9iL923oeMqVEjdUdofCz6Ge8O5JRm3tHTls5mIcbW2dmsReaGntWtLl
	 BRGyCId/d/qi8pHT18CNmXI9N3hKurKf7xgBuA4l+69RGAuZVSe7IseS6D8Q+PFGuB
	 EDd2SiKzA8a+UbCKTyLNPk7x4mvZtzNdF1V83TSo2iBKAfpYrLYXDrX6JLG9Oa4mvv
	 2N/6/bcYAw/8zv6UozON/42gp+D2zajxfSl02wAtCiNyy51CDCod2KiH9z95mKumhf
	 CiC9oeOiwSTjz+tqdo4P3FVQH+PNyOOBrhufmNdVQaOI4akeS9zFF9dVbu+MvwkHRF
	 mLRtJzPPskmEA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 05/14] x86/alternative: Convert alternative_input()
Date: Fri, 31 May 2024 14:35:02 +0200
Message-ID: <20240531123512.21427-6-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531123512.21427-1-bp@kernel.org>
References: <20240531123512.21427-1-bp@kernel.org>
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
index 1dd445c6e2e1..7f5f26fc42a9 100644
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
@@ -348,10 +348,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
-#define n_alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
-		: : "i" (0), ## input)
-
 #define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile (N_ALTERNATIVE("call %P[old]", "call %P[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
-- 
2.43.0


