Return-Path: <linux-kernel+bounces-562222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99689A61F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7086D175B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64097235375;
	Fri, 14 Mar 2025 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+hTN2RE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5323315F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988523; cv=none; b=rEsh+5fS3WTBRKMnvG+WWpRG6RUmzwYbDYFn6BP+MLJRSwigbGt1klZMBLa2gOlYL2pJAqswO5mdv5yf2d8roIFVevh5h4LaoXOAV1bqp7cnHVKPqi7W8zvC+tDFDJjUa037UticzzxQyUF+s3xVuGiitBUbo2vG5Jm+nPqddbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988523; c=relaxed/simple;
	bh=5oIhQA2G6MXNN4S57DSQBoNUOOzJU2afmZyfUSBH/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSfn+Q/GRDGpPSeYbF+9GOYgJ889NbFfmhUJ+Lv/mYu2W89WXuU3hH7j1BSJck/sSG0Yb42L2ZZcb+7p9VrU73FredkXSYKPrDeJbBl7A/lfk2I0M1wvCZzd+YNuKXlMCk/+twAAi66uv67kxwNNa/40PhoIS6BXKc2eQMY3DT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+hTN2RE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB96EC4CEE3;
	Fri, 14 Mar 2025 21:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988523;
	bh=5oIhQA2G6MXNN4S57DSQBoNUOOzJU2afmZyfUSBH/Tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a+hTN2REe48/StivX0ehUohMA48AU908BP1fNGMUhWC52WwsfVoph1qEYg6j5O8qK
	 0Y8w5dUOOe2B1BTble2AlPsdeqqasj8r/u84uYLSEyuDtSuBPZaGguxofNp6jWqYjN
	 DRXCeNlSwTVbt6YWFhqyMfCfDnFoxspwxvyrkZ7QEmgITnqCHiHU5gvQ3II1Cfwmh5
	 Dp0IRT8Qy94T7emcUTK8wwZTlzJwPhnK9FioADXozeFiFpZHI3+ak/IocYpclWpqXL
	 FGpzvN1h+ynDjEVGu88mAno4q/OxG352qHAbKQpCWpilHCK2e4MdAvTFFWIx4j4BfP
	 Y5LZrpyJp2Mmg==
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
Subject: [PATCH 16/20] x86/cpu: Use alternative_io() in amd_clear_divider()
Date: Fri, 14 Mar 2025 14:41:29 -0700
Message-ID: <5f79d7213503c426cf4abc8292ae6d240cacb712.1741988314.git.jpoimboe@kernel.org>
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

Use the standard alternative_io() interface.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/processor.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b458ff0e4c79..d7f3f03594a2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -709,8 +709,10 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
  */
 static __always_inline void amd_clear_divider(void)
 {
-	asm volatile(ALTERNATIVE("", "div %[one]\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), [one] "r" (1));
+	alternative_io("",
+		       "div %[one]\n\t", X86_BUG_DIV0,
+		       ARG(),
+		       ARG("a" (0), "d" (0), [one] "r" (1)));
 }
 
 extern void amd_check_microcode(void);
-- 
2.48.1


