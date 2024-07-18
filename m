Return-Path: <linux-kernel+bounces-256432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472D934E79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AE4281C77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769213DDCE;
	Thu, 18 Jul 2024 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DAYenlJc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onVoMKfr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB0140E37
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310495; cv=none; b=kaEj5PbhbktD8SpZnUQS8VEtLK5wBR9s/RcrC4dQhz6njasg0y1RCMdkCgRja4KZIlk9Zj5fh3kY//pMmoj3o3tTybMyxga/axPIAAmPlYA+lybP3h/TiHU2WnkNcl2PDhIXZ8Pv1JAE6Qtjs9eg90HARRHb85fWSjhWBNTpEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310495; c=relaxed/simple;
	bh=BGGsL3a5xjiuuIDamsAibYynkz0WjXbniB4VwvZ52b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=celqRWC89wfG6xM3d2fY981QL8pfOjsGn0ccGufQuj1ybvD5CZ9bPRBbZccqC0YXIrXH/jXSG34O6Av/5XUaDg9MCVrOd46Ua6/UR0DzBceifjwdzQ2LtJLyaPjrdPcc01+GmtyLgSQeMcpfy642ygcIOId0IQgb0Bgte5XJjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DAYenlJc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onVoMKfr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721310492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Umcf2zmF9IhfYteUxUaw3o2Qql3nqUK1ghOyWeUxCc=;
	b=DAYenlJcfPZj2ref++6hNSl4di3+nEIXIn+SVlBVh5x1KFa/Hs5aMClhJov2aKAmCFhs2q
	cHGmSyl8r9JPiyYiXyny71hz7uZCQoWDS4x6veG/iQuNpLptW0qCtC/O5fWwJNJR2Awcj/
	/3p5oVwjftohnMpLcZ1j4x0tzv4kzvgXnIo1KZPCMUWHJwRt31OyzuM6WSP4ABuIXU7WJ4
	eKlPf816yJzcL8LjazUfY2k9F9weuMZ20ycUjJOzBbW69t65I9y49GCSzxB6nGvjcKiQS4
	I58GBGVWrPykmvncRfuRcbtFQ4OjhbXg1wcrJxyCM7FJVxDSp3U/Kr5s6awAog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721310492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Umcf2zmF9IhfYteUxUaw3o2Qql3nqUK1ghOyWeUxCc=;
	b=onVoMKfr5nAYPOhobyB1ZdHEBZL5emA1sIX0nN2yFXQqjN6lPfkDOFNNbGG5m6nCYAZcu4
	jHfjfAAjkuovPQAQ==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 2/9] tools/x86/kcpuid: Properly align long-description columns
Date: Thu, 18 Jul 2024 15:47:42 +0200
Message-ID: <20240718134755.378115-3-darwi@linutronix.de>
In-Reply-To: <20240718134755.378115-1-darwi@linutronix.de>
References: <ZpkckA2SHa1r3Bor@lx-t490>
 <20240718134755.378115-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kcpuid is invoked with "--all --details", the detailed description
column is not properly aligned for all bitfield rows:

CPUID_0x4_ECX[0x0]:
	 cache_level        	: 0x1       	- Cache Level ...
	 cache_self_init     - Cache Self Initialization

This is due to differences in output handling between boolean single-bit
"bitflags" and multi-bit bitfields.  For the former, the bitfield's value
is not outputted as it is implied to be true by just outputting the
bitflag's name in its respective line.

If long descriptions were requested through the --all parameter, properly
align the bitflag's description columns through extra tabs.  With that,
the sample output above becomes:

CPUID_0x4_ECX[0x0]:
	 cache_level        	: 0x1       	- Cache Level ...
	 cache_self_init     			- Cache Self Initialization

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index e1973d8b322e..08f64d9ecb40 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -449,8 +449,9 @@ static void decode_bits(u32 value, struct reg_desc *rdesc, enum cpuid_reg reg)
 		if (start == end) {
 			/* single bit flag */
 			if (value & (1 << start))
-				printf("\t%-20s %s%s\n",
+				printf("\t%-20s %s%s%s\n",
 					bdesc->simp,
+				        show_flags_only ? "" : "\t\t\t",
 					show_details ? "-" : "",
 					show_details ? bdesc->detail : ""
 					);
-- 
2.45.2


