Return-Path: <linux-kernel+bounces-562213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC12A61F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCF1892BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A19207A33;
	Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQm6Iw24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F85206F21
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988518; cv=none; b=nOHkGmbXsrbHBj6fWBIRKqwGNHj4NDl5u7qKTuiowaNX4a2A3WYHN1GdT+P1GwXg+ur3he5i4oSvO0fpNZefMY0iY7nOm7fuMGhXawOK0UTIRxdmQNRQv/hi4mL4Q/FeOiXZLDHFxfu95Kdw5M41VywtnSO0y+Pg56Z4gBaKq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988518; c=relaxed/simple;
	bh=yOdRu7Fcxv19X60rh949WLYqt0bzYdV5JlS82PVB8vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEqn0zd5JDtra5vyog3VGKHKmgksnvGI2sBv9TmTdC4zRFsCve2KXJJOMLNZ+zol2CyCVPGIq4o6napRQIasVNxia+r/BX4UL1T/dHTGTIma2cYdK1YjUaPrv4Mxs0f1+4YmBGl+xKRwwvtS1rT9dmCCMQEuujJK2vudp34a27Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQm6Iw24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E386C4CEED;
	Fri, 14 Mar 2025 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988518;
	bh=yOdRu7Fcxv19X60rh949WLYqt0bzYdV5JlS82PVB8vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQm6Iw24PHbIExUGvoTW+2mLwJGDJoJlxHjmW6cZU8Kd0ZnHNbAbcSJ+2wmkRQP7Q
	 iiPSLokbVJ/fM+mjFhF7eRkcS9Meor05L3LBy+xyVv90SjedQK8nde+7foBLGjU8U9
	 S7thg/Pn4zMs3xYOZiRDzFmwlRuXK212czSe9Igh5UNrm4crsSANR+vTZnYekyAVhu
	 Lvu1Ay6yOXH0GrbGx7DJ50SZP+geLdkfb2yuLqc+BFi4EL0SCerVECcm+GOyGIgFbo
	 FNJ+x5KZh+WM6hIYoZy4vdJKrLsuj8Cpf9hpb7DloVx9uD8zfUJH5uB1ze5iJWMAts
	 HHQ4qeAB80/Vw==
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
Subject: [PATCH 07/20] x86/alternative: Remove operand numbering restrictions
Date: Fri, 14 Mar 2025 14:41:20 -0700
Message-ID: <3a2c1e24ebc72d6c32294b094fc3fefd9c2afdc2.1741988314.git.jpoimboe@kernel.org>
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

alternative_input() and alternative_io() arbitrarily require input
constraint operand numbering to start at index 1.  No more callers rely
on that.  Simplify the interfaces by removing that restriction.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 484dfea35aaa..3804b82cb03c 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -214,17 +214,15 @@ static inline int alternatives_text_reserved(void *start, void *end)
  *
  * Peculiarities:
  * No memory clobber here.
- * Argument numbers start with 1.
- * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
 	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
-		: : "i" (0), ## input)
+		: : input)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
 	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-		: output : "i" (0), ## input)
+		: output : input)
 
 /*
  * Like alternative_io, but for replacing a direct call with another one.
-- 
2.48.1


