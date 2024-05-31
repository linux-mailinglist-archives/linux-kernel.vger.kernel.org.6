Return-Path: <linux-kernel+bounces-196794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC28D61E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A95F1C246FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDB16D9AC;
	Fri, 31 May 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUAMAFaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484DC161B4D
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158926; cv=none; b=SiGOuGdPBQEAGY9ooZF+UoxcgrNHJfu4hE1bZGRssAkSJxkp8Wp5orImlSN/N8KhIMRN6pGVLHZk5ygvRHfD0k9f5inZeUT9IDyA/zQSKqnDoHVuaGz+hMOJtpjZNmftd9XMRo/uRFcpgBpiJCc/rjiyLn2pdmcUYgucJvTKVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158926; c=relaxed/simple;
	bh=g+G19NKQbd6Xtqc8HQIhzpIDmFN7DdYjK8JTK7amgwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpXyP/QZN8c6LhdGBUxXZimOxP07z/hcbinyZtjc6aIGtfdcKb7lK/ZVb8ixCh9WEG1GjGhh7RjAx4HlIqNOfRcOx77YCX1Wh+3bCB5A/DfL22KlmMlPZP+JM1tJLfRBS4yZcKQXRAeA03zajcKfQLhNHZ6JHicsPl9pmz43H0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUAMAFaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0A0C32786;
	Fri, 31 May 2024 12:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158926;
	bh=g+G19NKQbd6Xtqc8HQIhzpIDmFN7DdYjK8JTK7amgwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUAMAFaT69xFtXeJ2GAUZn/DDtnT/opTJjnFLesIch99rPRQ0d5IMRLf6AmQ1ALXk
	 G367ehtdFqXYEc5zRDTjANbnxHSMKwgaPdQGlWJLIboRuYHFkROtTPYquGUAqgD4PW
	 H7gOk/Jcr01Xe7cIh1XTCHEvexiRWwuy0cqLiMiUaH5RPzlXvMITQj/j96ppjQrUxI
	 sjUnAC7nQlHhzZBOJPpu/qe5Co2cxCfZouCvzDOozy31u9AqxNlcPetW3VRtxYZVq/
	 ovK0yEpYe0w+M/lzMQr5avxBQMVmHtKKlM98Tx76z9/2kMym6i9xD24ejF6/Bbma2D
	 mOHdn7X7zMnQg==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 08/14] x86/alternative: Convert alternative_call_2()
Date: Fri, 31 May 2024 14:35:05 +0200
Message-ID: <20240531123512.21427-9-bp@kernel.org>
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
 arch/x86/include/asm/alternative.h | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index bc696c60848d..bad1558d6382 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -349,23 +349,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, if CPU has feature1, function1 is used.
  * Otherwise, old function is used.
  */
-#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2, \
-			   output, input...)				\
-	asm_inline volatile (ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1, \
-		"call %c[new2]", ft_flags2)				\
-		: output, ASM_CALL_CONSTRAINT				\
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
+#define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
+			   output, input...)						\
+	asm_inline volatile(N_ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,	\
+		"call %P[new2]", ft_flags2)						\
+		: output, ASM_CALL_CONSTRAINT						\
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)
 
-#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
-			   output, input...)				      \
-	asm_inline volatile (N_ALTERNATIVE_2("call %P[old]", "call %P[new1]", ft_flags1,\
-		"call %P[new2]", ft_flags2)				      \
-		: output, ASM_CALL_CONSTRAINT				      \
-		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
-		  [new2] "i" (newfunc2), ## input)
-
-
 /*
  * use this macro(s) if you need more than one output parameter
  * in alternative_io
-- 
2.43.0


