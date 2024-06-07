Return-Path: <linux-kernel+bounces-205893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E5F9001E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6249B21B13
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940818735D;
	Fri,  7 Jun 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0dr1a/z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5DD194ACE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759043; cv=none; b=RwHoGA4S1EuQjnXv6wfQLem2TolBUP9B9LgExtc5lZgXT+Lext4fIWn3SNemxbaXSNyxCdisd5xG7Cuq+eXDSjg8U/HcchbzStALYrFOXJg/R6Emm5FMlwb3tbyPc83aqgbgbgjB67wFlfF10rn2UgvS3KqBu18K/LwS7+87o/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759043; c=relaxed/simple;
	bh=mpY13cDkkhjPXE7HFQg9dp0vJygGBsKGCPtYHRFiDNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDMrcGYgVsCOQ/t/K4T5OO/cxP+OBk7ZoPwhTMAlSw6aWVXbkqFvqXP0C6y7J+qj0nLbcxhR4+usDYoP0QFkYwoO0zZQmxSF4nDEHQ7Wjos0KRQHiXrvSFfRU6hkqtf7W/qbL7apussyNuYpieyYKn3QllOgymtB7qjeE5HE2Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0dr1a/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11108C32781;
	Fri,  7 Jun 2024 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759042;
	bh=mpY13cDkkhjPXE7HFQg9dp0vJygGBsKGCPtYHRFiDNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N0dr1a/zUT0YJDJx7FZ8xtqt506EpZ5LgYMjavemuBY96qINCnQ1lYCnNtplv9pt+
	 FARGAMMCoAIb8o/Ei8LZ4KxSlZZqkYYvvY1ytzuadGr28pWygQ/yrzkKHUf5liDPPC
	 S7Sm0H73qxqpA1lmtUWytKZnq3reKrlPVsVRhxSDLNGgL3WnjY5ED4NXifaXq1z9aA
	 4122btdhG1ig+qm4EpWZPP+FcR0Io1DHoDrYrBtnAVZ/rbiqpnkXs79IRNdYgaWhQP
	 Nfk8HAa6fNm5YWKdW7pRvw8KbpBZ1ssQ6/pq/JOEuQ55UyJ00dMLv6bON0LQees03e
	 hX1afN9dYZ+4w==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 12/14] x86/alternative: Convert the asm ALTERNATIVE_2() macro
Date: Fri,  7 Jun 2024 13:16:59 +0200
Message-ID: <20240607111701.8366-13-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 31b9a47b9df9..28e07a038964 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -461,28 +461,6 @@ void nop_func(void);
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


