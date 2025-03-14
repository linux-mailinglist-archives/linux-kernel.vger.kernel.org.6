Return-Path: <linux-kernel+bounces-562218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83CA61F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF593161C44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7C22D782;
	Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOIhAFzT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E9722A7F6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988521; cv=none; b=NOIVv+PnvFpAGc6Cs0biAjbDtNRiHGhO1wpZX763EUqqUkq9q2wqxUoTMIHds/Zo6+ax7ZV2FBA2uMNJaMVgMI5LqIgWMkdBPAlCjzOdWGeDmgDgATDD21sorRNXR/QJTen52ci1KftReDuiHsqJZGc7gpXEkzsYqTZHAFBIRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988521; c=relaxed/simple;
	bh=01H/k3p6kVZSNvrRq7ER5zQJCpyXMltkJxnFQU591jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkX937K339OaEwM6mO3VUDAF7AhzUlc+4Gz8+ZBejO0ZEdqgzrgEiJtLYJjB0dRTbUbc73TF8gHZdWIXDWxZdkphIZe9E7w+xRb73URXc0GJ5RO4c1kCNKs5aKGe5wTFPUZfwNewafk9paINNDFcAOrUUlwnf6zK+TaMx2CuyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOIhAFzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DF6C4CEF0;
	Fri, 14 Mar 2025 21:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988521;
	bh=01H/k3p6kVZSNvrRq7ER5zQJCpyXMltkJxnFQU591jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOIhAFzTGaP+bzKAzhCh8wCpPpvYWab3o+Jh6wyzpWQabPrnpV0e6ItoBF2+BaaPf
	 mcns93oyqJ2xJASrJJrroJv6kgCshBG+2YbxaD/E//3/C1EMGPMCYrdFeXQ6RxyZ3q
	 BGTdEjLrvOsitFbOepPnAC8IcD3u116gOeB6lGnFOQM7rvUppivzoHcG1hGSDdDso9
	 BCV8MsDwHffjvg/AGRzF8+qOCH9fq3lHTT6DflD/ikID2GzaNOuONuDsYtyHqEXxWk
	 5YZITCHiV3x17V9pEmm4ErDeofMECI5iYkKX6md6fOutkzdOJIyPS63RSXH+yDNUk3
	 lywgcLy3KmKaA==
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
Subject: [PATCH 12/20] x86/cpu: Use alternative_io() in prefetch[w]()
Date: Fri, 14 Mar 2025 14:41:25 -0700
Message-ID: <60361f50751e6a8e38463d1cb47687f027042321.1741988314.git.jpoimboe@kernel.org>
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

Use the new alternative_io() interface in preparation for removing
alternative_input().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/processor.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2e9566134949..a1baf2fc5f9b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -624,9 +624,10 @@ extern char			ignore_fpu_irq;
  */
 static inline void prefetch(const void *x)
 {
-	alternative_input(BASE_PREFETCH,
-			  "prefetchnta %[val]", X86_FEATURE_XMM,
-			  [val] "m" (*(const char *)x));
+	alternative_io(BASE_PREFETCH,
+		       "prefetchnta %[val]", X86_FEATURE_XMM,
+		       ARG(),
+		       ARG([val] "m" (*(const char *)x)));
 }
 
 /*
@@ -636,9 +637,10 @@ static inline void prefetch(const void *x)
  */
 static __always_inline void prefetchw(const void *x)
 {
-	alternative_input(BASE_PREFETCH,
-			  "prefetchw %[val]", X86_FEATURE_3DNOWPREFETCH,
-			  [val] "m" (*(const char *)x));
+	alternative_io(BASE_PREFETCH,
+		       "prefetchw %[val]", X86_FEATURE_3DNOWPREFETCH,
+		       ARG(),
+		       ARG([val] "m" (*(const char *)x)));
 }
 
 #define TOP_OF_INIT_STACK ((unsigned long)&init_stack + sizeof(init_stack) - \
-- 
2.48.1


