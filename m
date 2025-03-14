Return-Path: <linux-kernel+bounces-562216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F9A61F45
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7127A7249
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B7C229B28;
	Fri, 14 Mar 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka9QUfzg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39790225404
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988520; cv=none; b=rs9wWinW+20vTocBPgBTvzj989ZiJUViJMJeX59F4dqhdHTJOOU/dkPhONOMLNmh+wYRRa7p5tb8LUzePDuXj1O5IlE75X/Iic3AWgde+4sd6d0JS4xQ8NjbxSdDMAoZeg/wrhibWEwkzCw6NtK2BBXv6u7OSF2ZWKaVfxncIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988520; c=relaxed/simple;
	bh=0kn0S4ccqzhgBAKRunMO8Nv5aGRcCEGvj6oTNQnlhOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw5JozhferIHfE2V0k25/LhyILnsLThcEjc6j1XZv+iZXsQWgI19ty7B8LK5Gvm9kaHXeSdvsRJZaxQZFvTWJAmifWg6ALEo/CHVHYBdWuJJp9EpotRptnrl9dAbRhhHyT8kBq81GmoUaU/K6NgEgDWeGnCPkLQ2D1eIRa31qCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka9QUfzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F59C4CEE3;
	Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988519;
	bh=0kn0S4ccqzhgBAKRunMO8Nv5aGRcCEGvj6oTNQnlhOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ka9QUfzgNzBiId7jTkdJI6w0XRIMkukM4XH83qejB4ktuAb73KG0QP7Dy0EJBD0Ns
	 KVHpQvmqfnz8W6jTdSi+zBQ6CeGmXzZKgN70/11Vq5RMSPlBRO7y29MikDcOYqIlh+
	 5lcuT9gTZjeMtKD4M+e0U4N4mDJwSJC9M9OZTTRmldSMfBeEKw1xTxI0kECH4SiqHC
	 rY2oWRzdqPjmOrw3nIXE8sg5K/dsz3r/s7n5XxbJTAgnfxRfGXbWm9ayp+aNuM0YYw
	 XQIHmPCa+8tLikbnMPv9tYnTJ/7+lX93g53MSlQgb/NgOD2UQB+/SHxPxlFRyvSfjl
	 uOp4BLlrGqCEg==
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
Subject: [PATCH 10/20] x86/alternative: Add alternative_2_io()
Date: Fri, 14 Mar 2025 14:41:23 -0700
Message-ID: <f7de31883141bae5b555acbccf5bd5b4457d3734.1741988314.git.jpoimboe@kernel.org>
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

Make an ALTERNATIVE_2() version of alternative_io().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 870b1633e1e0..0acbb013e7ae 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -231,6 +231,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
 			    : input							\
 			    : "memory", ## clobbers)
 
+#define alternative_2_io(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2,		\
+			 output, input, clobbers...)					\
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1,		\
+					  newinstr2, ft_flags2)				\
+			    : output							\
+			    : input							\
+			    : "memory", ## clobbers)
+
 /*
  * Like alternative_io, but for replacing a direct call with another one.
  *
-- 
2.48.1


