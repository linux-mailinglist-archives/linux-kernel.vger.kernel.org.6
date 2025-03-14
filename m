Return-Path: <linux-kernel+bounces-562219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC2A61F52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CC2178DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB88D230272;
	Fri, 14 Mar 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLMNILXX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763222DFBA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988522; cv=none; b=KDhK6rRjcNY+KnTs7YP6WM8rcIls7VqJQdSD69/6S/DCvFUauLZUDO3tfCMAv81/P8ZpeE2B2zuA2NuJY4G3PaCFD4hBgQ4A1Kdejd9Wf78szgZ6wUQulIW1in5aH+9n0QD66y3pVgeMO0PtuD+PUGLsbAPBc2un0I+hFLWUTpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988522; c=relaxed/simple;
	bh=A805OiY9btBk4//88dQ5YMB5VpAijiLaiFUnG8VaH9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSMBlHLdFbHKsdc6b+Ixa5LAS9c+TIxsaEzi0rpGPgw+oKBHbytmbTq36tsXxGUmab3VdoqGn7BITac463EnvfvBD11DLPjwgDxFcoQqMMuOeWmYpt/+9NfnYPomTCwR8P0v4TjflHGKCmVB9iir4Fysmn4mvFiCnVrsHgZB+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLMNILXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22707C4CEED;
	Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988521;
	bh=A805OiY9btBk4//88dQ5YMB5VpAijiLaiFUnG8VaH9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLMNILXXGEzLxnKu99vgSnPmkMldW47dZvWXRdv/agAWmg3IwPoedrtRqq/v6EV3Q
	 Oi3ZHGmxpeoSmssxFTPPlr9s7A1QMrkO0W0um9f46crfygA7JL3lK3IITVUQVrxT07
	 nwM25Act/XFn9EdiCiIErVWrrUz85rkQvx/wYWNbfgUPIUqqmXTinbdVXUmobaVWTu
	 fgUebWzTfaXBYHUOJBcPY42nsk/utR1SMB0g1FcT0FvS7R9TzaH39rl/KVAXIJRTZ3
	 rwelTxH+05HM/JRG5HzBFY7srkmOON9fJnoXkbhvbKcBG7KVrhPpZwDL8ha/wsppZL
	 HFqmgiseHBwAw==
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
Subject: [PATCH 13/20] x86/alternative: Remove alternative_input()
Date: Fri, 14 Mar 2025 14:41:26 -0700
Message-ID: <3f74d48fd784507e1a68d7f43c381ca6e0b40122.1741988314.git.jpoimboe@kernel.org>
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

alternative_input() is redundant with alternative_io(), and has no more
users.  Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 92014d56e3aa..119c24329ef1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -209,16 +209,6 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	alternatve_2_io(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2,,)
 
-/*
- * Alternative inline assembly with input.
- *
- * Peculiarities:
- * No memory clobber here.
- */
-#define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
-		: : input)
-
 /*
  * Alternative inline assembly with input, output and clobbers.
  *
-- 
2.48.1


