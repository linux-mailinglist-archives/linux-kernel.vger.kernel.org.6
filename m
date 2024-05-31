Return-Path: <linux-kernel+bounces-196792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46A8D61DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7660BB24A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92E15D5AA;
	Fri, 31 May 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac6XCjqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC815B96C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158925; cv=none; b=two4HPPXkgzUCiTB7E6zYuLgi2MItmdY5JZmDQ9uk1FLGFxyPgxV8qGkrTMn+3+7XjgElF5yeJfK5IfNwL9N09E451j8osdyD4TtqaidShZRlK2j11lrkOkap/vLCy3GrfYWuXmRjb71m7UnfdX3tIkAfS2u5BY6Zb5gVxbvxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158925; c=relaxed/simple;
	bh=dN5HiwWgdZsCjkAa5Gu71vLMtjXHrncFvZfcWHAJ8xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfY/uUDaEtqj6LAlctrv9Eaa/+Hj9C2J8bxPLdXiK+NfiLF25DVHYR0k9Q/rJv1iMih+aV5QwlAYJSsHmGQ99hfRqoPziwhWrPhZNzqUHm4ktuFfFSlovC38ouB/ZXz2owmfQtUXMVVy5hKlYthtJHHHrmVwPaZheVtan9pfSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac6XCjqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C266CC116B1;
	Fri, 31 May 2024 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158923;
	bh=dN5HiwWgdZsCjkAa5Gu71vLMtjXHrncFvZfcWHAJ8xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ac6XCjqXy6vpdVp8dQaboG/+NmqFCXFQKzFnyIU3ScL046HCJ4PsyeTBllR4AGei1
	 HV6U/tPHWY9IXtXBTJasqbT62LeB/ugX1VQ5ovfxKHh0Pe24xDfz7LdzcMFEGYJOGq
	 BeYbeaL0GNPuE/FpzhmxwlhV0jpnbOaA36pqqt4gasc0T+iGtYT4wYcTxZ6/PGSRdS
	 WlO2Gn0QuKqwETXzMVGlIXRxJF6csiT0kx9xAiQaPPHlXMyYxP8LxH5VzC+unUPz3M
	 BtVRgAuUDK/QJiZoOM49PTy9Txil5wqSpq5fctUFX5k8wvRpn+ogjtOiHyp3ZMls/x
	 V5pUopQugPFUg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 06/14] x86/alternative: Convert alternative_io()
Date: Fri, 31 May 2024 14:35:03 +0200
Message-ID: <20240531123512.21427-7-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 7f5f26fc42a9..8a0a6ba4b741 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -335,14 +335,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
-#define n_alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
-		: output : "i" (0), ## input)
-
-
 /* Like alternative_io, but for replacing a direct call with another one. */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-- 
2.43.0


