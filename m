Return-Path: <linux-kernel+bounces-205885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C89001DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C0E1C233FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F77191483;
	Fri,  7 Jun 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXBczZUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8882190682
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759032; cv=none; b=hXFOVhOxT5e8YkVeuUMOSXReB/Wd4xF3JgmePFdakNroAMzziGa27Ekw6iGKeYFpOCfbN1g5VPnjGRsJd+RVgEeU8IVS4zIOk/5HIt6nb/n0cABlOiDDjw5Lsnc18JE755tR5BprgNuVj11LKRE96hDcv0xq0wrlnKT3T/XfCqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759032; c=relaxed/simple;
	bh=2DjrnYCMqznW+ee14tuQDAv3aZSnRa37n15txMb0Zbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoCaK6pJctyBAP/pVgpLVyghEMrLcbowTH5/nfm/CZXjlnrqc+um2PEX+PDb9HV1NNZW2a/MqzajAtSoBonFRW7tP6ZHWCYmFxqhXBelb7WJPvLzY+HYLqc+3ZLvD7knw1ISy6lz0148UwxKjQWAfBbtpW9DuWP7mMRjAkyE3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXBczZUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E9C32786;
	Fri,  7 Jun 2024 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759032;
	bh=2DjrnYCMqznW+ee14tuQDAv3aZSnRa37n15txMb0Zbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXBczZUWLuSgjM04SGEQayG3SxQ7dDGesv49NDsEu21QcbgK4KvOL6f83/SUkrlRv
	 gWfHcUbB68DCd6PmCHnmx+yz7K0CSB6kvffh+tzypCZLiXs1sZ4ct+3BZQ6DbEKE2T
	 tIebI1pgdWTWlj5/Et8lLq6pn/dtMpBVZPo3HWRGwrqI2lSpFFanbjAhhYTgz3xlUb
	 PrutTGZaLXTJoC6wfCpi33WsHnHKWsSPkTAY3mYjJ9L6mkG3IvbwyUaGVP0Oc7q31G
	 xDMgZjp98oCwrToFwcVtovqeA/mT9acijIvfcH1gqmVagGc+0+gilXH7u9TToiWNNS
	 VoIAdLgoIjBfQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 04/14] x86/alternative: Convert alternative_2()
Date: Fri,  7 Jun 2024 13:16:51 +0200
Message-ID: <20240607111701.8366-5-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index c05bff2e3626..21ead5dea15a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -319,9 +319,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
-
-#define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
 /*
-- 
2.43.0


