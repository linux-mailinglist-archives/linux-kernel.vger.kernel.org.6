Return-Path: <linux-kernel+bounces-205894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC79001E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E70289294
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CF194C91;
	Fri,  7 Jun 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svmy+BAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56151194C6A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759044; cv=none; b=Lla6q9WbEugznDPGcjQfPGPTKZ0diD0f2vNlUTQ8ju8RuId3L6LkNmyGTV6kFYmGmom/tRxVNjuijnwpZLCIPhIPCXZbeF+3T59xkXK0H9PWEMzxUCtS3M80utZf9kioEwP9PNQ7GSLRxtDWUoOMIHmnr0lKikrW+mOGKkhtdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759044; c=relaxed/simple;
	bh=BOkJs2FsO7d8uNtY+3OezgdrS5yyqUklsYRb9p4/cHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqHFCKiR1o0QNiVtxG88Ktk8QA0wdeNRuLxUqaVq/26v3rx0jcS8jA0jhWA/tOGE842fHGm7q7qGu8xevNwll0PTsY8w0oOcqdMtUFA1lPgjloyp20w84pm/7bGZSGrjPVdMXhPD7Dz69ojhTTXp6c7Lui4GcSoCE5I/povQZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svmy+BAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C048C4AF0B;
	Fri,  7 Jun 2024 11:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759044;
	bh=BOkJs2FsO7d8uNtY+3OezgdrS5yyqUklsYRb9p4/cHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Svmy+BAae22V871Em27Q07St8n3Zp45mP38pOHn2sdeGOp+aegDS9xThazfLNUBLp
	 4n0aelZx370IJyIESbYe1hZ9t0MaDiRsVnNPChLQ9bSAf3U41/CCTTQkQpavrzIMV2
	 Rubx1i005loSncmH69UMt0V9LUotZmMtbXG5DfZNiJKuX0uk1S2p7aCOXoJuAQ/tMr
	 0bFbzCYlVvQ3sFYV26fi2aLYAqNFduHhBOxN5+yAVwgFy52xmuKmpTo89INm6x8EEW
	 Yja5UWa6uMwr/UPL1lYKQBuoEMwf069HsxTNNxU+qX1PvCLarnYvOi1y6OgiSTeHfP
	 4kIgrsW+7HCFA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 13/14] x86/alternative: Convert the asm ALTERNATIVE_3() macro
Date: Fri,  7 Jun 2024 13:17:00 +0200
Message-ID: <20240607111701.8366-14-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 28e07a038964..5278cfb1f745 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -466,31 +466,6 @@ void nop_func(void);
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


