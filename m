Return-Path: <linux-kernel+bounces-196798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206108D61E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFD72827CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915417BB0D;
	Fri, 31 May 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4EUF29H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3C178360
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158931; cv=none; b=G3MKjCMSxyKd7Y/Wc/JzIfscwBE6IUJb3iBNYoxnt2vw/1O9GtgkyxZ4ww280dRdNYufsHgR36OjlGww6Y75TH9z4l9eRGb3qwSs5c3mqc6qwHdBmDZa8bfsiCRWsZ5EjuVVZ8gWrsPSyc/Z+69VOZE9gTKgjtVD1SBBWP7kIwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158931; c=relaxed/simple;
	bh=7NxE+QUoLbZ8CDIeAmX8OcSwhoxtLVNGR18li4xQTuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgwhDvymtVInYH8VvlkIHACrBTOjsZhmpUaK07jOFdQ8l9Q76V+G63IeHvioQ60RLHhjQj4DutXwmS9QROAvmppolvH3jFPh+RA+cazLIb1qQrh+jmSgn/rDFvq27EFP6l7Ttgcs8A9emQiUc8q7RZzV7BvhvZxaX+oBS0mSVHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4EUF29H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FA6C116B1;
	Fri, 31 May 2024 12:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158931;
	bh=7NxE+QUoLbZ8CDIeAmX8OcSwhoxtLVNGR18li4xQTuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4EUF29Hs2lsZEdvfsXQK9VFUJlOvrjEGJ77A4XkRQ1kfiEIP+W9c0umx70+V7sOn
	 hZeni+vTxTNkxDjsayxljDu9yrIeCIQ8IJvBGGFZ8nyJsC38cU0LQnI/Y1EynmlBwr
	 c0jzrMx2QDk7e+4kucMws8BWeE/8GfqD2a72tt0uyDZkH2xMvNoWobfCgLeffv9po6
	 PK9s9s9Hyu8Pzw6A0p6pPPPPx/vIQ6oNoS7QV94N1EBeJ4r9OcNmFU9NiNMVB+K+sg
	 gveEZRVIAPZ+4cIRr6gYkn3ke5Rl+WFF7mdeY2d95dl3yUlwYrrtQWiub/l1upEoWV
	 vxGxXY+KU4KuA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 12/14] x86/alternative: Convert the asm ALTERNATIVE_2() macro
Date: Fri, 31 May 2024 14:35:09 +0200
Message-ID: <20240531123512.21427-13-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 4b17267f3f2f..82a79e17e952 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -452,28 +452,6 @@ void nop_func(void);
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_2(new_len1, new_len2) - (old_len)) > 0) * \
-		(alt_max_2(new_len1, new_len2) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	.popsection
-.endm
-
-.macro N_ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
 	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
 		      \newinstr2, \ft_flags2)
 .endm
-- 
2.43.0


