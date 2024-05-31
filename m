Return-Path: <linux-kernel+bounces-196789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6558D61DB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5711C24650
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94A158DA3;
	Fri, 31 May 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWZoEgU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248D158D90
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158920; cv=none; b=ZDtcApOlvebUluBQmlliJFMuV+38XCqkJHF/7r2oSYfHUW+l94xxlPFO4IyJBsSyHKW1Cvg7NQOlPuS69lD+C3qDrNliMLTZ6Fkmt0sY8yNk884EGf8/ABGiY2GkBK6MeT2CQM3/EIJEUWH7Y6EAvbYlvYwbdfmJ7P6L5GiRNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158920; c=relaxed/simple;
	bh=wqYNbMnNKnYTuOhIAZEDLwWTDb3cK6kIfqvEGugdDBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvH0/q3DLSnzB2bU5FW3lBcr2IVzsUBv8zNtpKt12rKgW2zXIxJsVPtQJfQmeuml/CRgivKDJycr57ntvTqjDSP3MU0FTP7VEmrXwDPPBvNFh4Z4AwoEIGZINgBtFx+8NQy6SXfWe1YlZ2sm4blvsvr8ngQdC3hnnd0zei/3R3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWZoEgU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02479C32781;
	Fri, 31 May 2024 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158919;
	bh=wqYNbMnNKnYTuOhIAZEDLwWTDb3cK6kIfqvEGugdDBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWZoEgU4Xc0WVJuCLJ+6Hs6q4NpYSC10UkRGFzsiFumy7spbDFeCWjkrRybOA69Lx
	 t12Pdcof10CDEDBY9JSOa5lHSkekKFVgYUQghHE/RfsQw20VQhHdH144HsewFyBbyP
	 OkT73cy7BKoBZ/E4EteUrNzUfIls6+VXPggxKvXN7sxcU89EFD9aB6d4jrPjw32UjR
	 nud6bhkWf6Y+jXnQAYEsex7N6da3frywY4+VokVYqNxiquO5QJpq4kydPw0r1yusU4
	 wAV4NA9p12tlnhrwvFNBIDCRINm1U+dc6wjw4ixHxk7XeT2t2TigXC29W1bbKcvLxl
	 21GUYz/sFR4Tg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 03/14] x86/alternative: Convert alternative()
Date: Fri, 31 May 2024 14:35:00 +0200
Message-ID: <20240531123512.21427-4-bp@kernel.org>
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

Split conversion deliberately into minimal pieces to ease bisection
because debugging alternatives is a nightmare.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 8554c2c339ff..c622ec7c4462 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -316,14 +316,11 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-#define n_alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
-
 #define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
-- 
2.43.0


