Return-Path: <linux-kernel+bounces-196795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EA8D61E3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327CC1C23E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43954172BA2;
	Fri, 31 May 2024 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ZhDjsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8102A16F282
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158927; cv=none; b=myPJ5Gc3PlUQqAWbCS+iX8hoiXpKePJ3G+4q8UW9Hc0ZuNX31NwvP5Gk5itjREe/rXC6kou5NNJB8g8+oCNAQ9QKnln7OiE1sGfmj7KqXWT8JX3UygGWuZOFyFzp0xNj00VJvSqbAH0/pqd4nLGrycEkOQKSGcFXYBtMNgMyS5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158927; c=relaxed/simple;
	bh=oaM4gPS6c2Nwk34PW367bO82k88VoCS8rWqPUvkNmV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1rZzDKg712gTZ0oqMxEuOWPTwJURbWZl1Sx9OkSZagsq1cocGzrzqnDS7Hsrvun80JKVgkhCDI3KndAykRWj4VOpkcZ2egHMijmT8WJN7xl500sP2BDPyk/bcKl0IA4l+xEKYqLna+u3re3aIXcm5hcpgu3nVvvrqPoOWEBE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7ZhDjsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2F8C116B1;
	Fri, 31 May 2024 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158927;
	bh=oaM4gPS6c2Nwk34PW367bO82k88VoCS8rWqPUvkNmV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7ZhDjsE0FvoznvJBgINAFKkO67JXsg0YiHRNBb2NKOuTRD2425e1wfiLO+hQUJyu
	 3HKNwX2UQM0Fghfvu+AA7vUXPC0TmK2QRtnyo3+Mpb2OOWhzJwVSzmT6l68gXfS7TO
	 HxBkKNcwK/OVzrnX6LStI8hQTp8a5pjI+OXiD5WJ2T7f7yzJRoAfaGqBfNKjoA13j/
	 1WTQYgy9q28C69mZFBMCdA10bVFJPht2Y8wKd9N1posNezDsvxQGFC23l0QPUx4Y56
	 vuJt2YIFJENUjQbQ81l40ppaau9wB9L0Vkrqu7NTPVxV7NqJvRV29sU6RJbLwt2mmJ
	 SnBOqyPKCknGA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 09/14] x86/alternative: Convert ALTERNATIVE_TERNARY()
Date: Fri, 31 May 2024 14:35:06 +0200
Message-ID: <20240531123512.21427-10-bp@kernel.org>
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

The C macro.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index bad1558d6382..73ee18705ef1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -274,15 +274,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, ft_flags)
-
-/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
-#define N_ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
-
 #define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
 			newinsn3, ft_flags3)				\
 	OLDINSTR_3(oldinsn, 1, 2, 3)					\
-- 
2.43.0


