Return-Path: <linux-kernel+bounces-196799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 283878D61E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB3841F27404
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477DC17C9E1;
	Fri, 31 May 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b82ZdiRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9015117C7A3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158932; cv=none; b=aWwPJvSFGYCkrvfE1YzKsZHmiYnI0m8k8Eh7hTijg1k43bklg5uBEJ9L8XghxdTHg9kNa6fb+Gz1roUvp8fubsesbQ98wcw+8RTbZ+eo3hGs/2TPYp5nYQUKxlZwB7r7FQyY9sBeKhEd8Dg/+1r1Gu9O+oFy9AklJ5rMtDoJrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158932; c=relaxed/simple;
	bh=/qlLGNymXFpWMsOYIm3n/ty8t96hW2L/4Kjnjwv0hN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTC0koQdAY4IDCfyjKlKnrc5kfy0jxHfiOIk5nvGxG9HUkzS/pIj3Yr9vnEuHiPkdxFIww81A42lQX6zc4OaMfbCkNg0oXNcEoU3tkZ1mwhxFXcuMPKJyvFwdH4RMCkOvxtanMXWFRa1ggx2J0qwqQ+Y0g8d03X/498IM3I3Dmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b82ZdiRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9420FC32789;
	Fri, 31 May 2024 12:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158932;
	bh=/qlLGNymXFpWMsOYIm3n/ty8t96hW2L/4Kjnjwv0hN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b82ZdiRbM5pH74g0M+NV0dSfQg8bfyn+67a8MkQx03D5WjNKtcMdPdgy1rxyx7cED
	 OUUii0bxajdVRTKeJvFiTwgvJkmNgIwvAdnUeQ6IVeVdurmG0nZaSxrPS6+fAdOaX3
	 PBi9mObhWXJtetbdkefrp4thbn5wlPEugOPgxPByo9D+wRCypzIphqBdp4PnUTfR0d
	 gSjoddIQJcZlSbmlmZ/opfOlAoanhg7R5sUzR/VUMDCmzcRfYn1D4RcpjMKlHHUEIr
	 qjeD6BMP7P9g9b010lRcjuCDvUp6JzThS4qF2LALzZLGUQ61soyO/YrkVNg7OBIHy4
	 kcbgYwRpLTlNw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 13/14] x86/alternative: Convert the asm ALTERNATIVE_3() macro
Date: Fri, 31 May 2024 14:35:10 +0200
Message-ID: <20240531123512.21427-14-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 82a79e17e952..19b574331ffd 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -457,31 +457,6 @@ void nop_func(void);
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-140:
-	\oldinstr
-141:
-	.skip -((alt_max_3(new_len1, new_len2, new_len3) - (old_len)) > 0) * \
-		(alt_max_3(new_len1, new_len2, new_len3) - (old_len)),0x90
-142:
-
-	.pushsection .altinstructions,"a"
-	altinstr_entry 140b,143f,\ft_flags1,142b-140b,144f-143f
-	altinstr_entry 140b,144f,\ft_flags2,142b-140b,145f-144f
-	altinstr_entry 140b,145f,\ft_flags3,142b-140b,146f-145f
-	.popsection
-
-	.pushsection .altinstr_replacement,"ax"
-143:
-	\newinstr1
-144:
-	\newinstr2
-145:
-	\newinstr3
-146:
-	.popsection
-.endm
-
-.macro N_ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
 	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
 		      \newinstr3, \ft_flags3)
 .endm
-- 
2.43.0


