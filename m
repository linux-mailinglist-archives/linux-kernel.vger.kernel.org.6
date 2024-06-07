Return-Path: <linux-kernel+bounces-205892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B6F9001E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0711F2143C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C831194A7F;
	Fri,  7 Jun 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0tNkTZ7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED3194A66
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759041; cv=none; b=f6ec+Z0vG7sXmtA55lMbkbQj/pYgkDY0+Jj+LM0AN2fLw3AZlqVkjwbWZKHGRswVbs0t784RnihaIxpGqYxJLfm9s+Fz0L7bist+GxLpmqZCimSbWgRioYhfM2wQp7Lg2ODlZOFL/ba1UPwl17icHrDH01rPjnrlJvp35c0thV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759041; c=relaxed/simple;
	bh=oymOvMLk8fkLJdktfsSVSNeV3MCBYDn9eT/+zmcMkd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JE3468yoH/+DcN2j6q+NklHUYptIKbEwpje8HAm20sTBzYB7DA+MTIAnLxOluJFmZObkDiAKbF7d59QOOq7LxryLrAiK7wTXJcXJZh9jePZW1jWW8iGTuM0q4wpZpVioDY8u2S5ZdP9VUw10XpNPhd6kQfm9E22z4xQjodt+w60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0tNkTZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA41C32786;
	Fri,  7 Jun 2024 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759041;
	bh=oymOvMLk8fkLJdktfsSVSNeV3MCBYDn9eT/+zmcMkd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0tNkTZ7XozcsyWrqWqZqtNrsfPEsBCCzIfKyMYNGODHCB1XD/XGDKn8ks6dRXEne
	 ZjQDNb8roBZsoK9ch2KI+dnYwdUBiHnFxpwb5r0ZWL2Xns5GNFZdlOYIEJYHHeyKYE
	 L2e3xTewGEAUDLOyUaYgA2VzTca0BFNPMsGwQj0N2ZbtmNqacA2YRsCY7OqUGWtwG6
	 dZigM2VwRoiqM7PwIXKRGZrJIDTBiA6OQ0+ztbqk9BU2P0wLzpacgiR1Vb10B5aGVe
	 5WOdJcRyKchaPBAtYrNID00K/8SelYMB2OVNoY/PDy36ofdJuC55mEN85g4szQCp9h
	 qiZTxkd7QkZQA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 11/14] x86/alternative: Convert the asm ALTERNATIVE() macro
Date: Fri,  7 Jun 2024 13:16:58 +0200
Message-ID: <20240607111701.8366-12-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fba12ad237e2..31b9a47b9df9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -422,24 +422,6 @@ void nop_func(void);
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-.macro ALTERNATIVE oldinstr, newinstr, ft_flags
-140:
-	\oldinstr
-141:
-	.skip -(((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags,142b-140b,144f-143f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr
-144:
-	.popsection
-.endm
-
 #define __N_ALTERNATIVE(oldinst, newinst, flag)				\
 740:									\
 	oldinst	;							\
@@ -455,12 +437,10 @@ void nop_func(void);
 744:									\
 	.popsection ;
 
-
-.macro N_ALTERNATIVE oldinstr, newinstr, ft_flags
+.macro ALTERNATIVE oldinstr, newinstr, ft_flags
 	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
-
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
-- 
2.43.0


