Return-Path: <linux-kernel+bounces-573815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAE8A6DCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1215A188A858
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF925FA01;
	Mon, 24 Mar 2025 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VC+g/ui7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06qcgkSd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3725FA39
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826075; cv=none; b=qMogo+iJtsdxJudcDyMabZUqeOqzZE9pLCYARyyXtr29CfhoKv4mHpiw53YO6iw2v+jzdOG7y1jLT93qKMigZ0u0bq9BdTy3o1Yrwl7cVQmykQa2y2W00kJBuY/0HJryjzJ04hsPlIawm7Wx2yVLQGKh9MJLOQtCeGoW2CyxRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826075; c=relaxed/simple;
	bh=U3FmrnZ/4s402XkrjUkox44nIGjdsllUxaqR4EvG7sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkiZyaUVw0qyBU0FriYl0vMLT+lv5xCR0CrccCfOZCttkduzzCllQJcMTRnlv6XvSqHbJ4gmYRzDckSwXTwokg/MyrnjEurbgYh02bdbcxpcNKtM1mtvnysxSlyRYSlV+LJiKNBTTHv0wtCbiRjx9pv1bk14CdhcAVVwMFetaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VC+g/ui7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06qcgkSd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB5MGuGK6W7gcR2a2ltq4pCZnHfnzbng6Wl2oKZ1l8c=;
	b=VC+g/ui7AZ3linDPU3odBFvYzHFTWaJbiSE7/IC4j7rwSX9yoQ1G6mSERDR5gIXPrXkhuh
	CPniXs3eNoyPfO6ToWkSE4aouW1WJmiC84Sb1NZPWHyinZSkn715CA2yW7f+EyPeyFfXwH
	SmDYmIN8gLwGSE+AtSvKKV+lO3svOQiXqV5Nu4l6CgT+m5dHO0UMH3MTA3BtE5PNI5vW4T
	uLVpkPur1sWeHOQ17c4JQg/SPM7WFzTjHu6XmCDtBW91idhMHAkF+Af/SZK/GBoBdTOERf
	K2qymwa2iS5cUFg+X5sG6YGIXTknGv6RfoGMN79eGif7cACNJ4GMetR2gikZMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WB5MGuGK6W7gcR2a2ltq4pCZnHfnzbng6Wl2oKZ1l8c=;
	b=06qcgkSd6XeFQW54x+mSdvCXqHERVmrF/6WmvtvPeD6ePiGr7HuKTZiwvXoEMvl3fPiDrJ
	80EJl6UmoaQeTjAw==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 08/20] tools/x86/kcpuid: Set function return type to void
Date: Mon, 24 Mar 2025 15:20:29 +0100
Message-ID: <20250324142042.29010-9-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_line() returns an integer but its caller ignored it. Change the
function signature to return void.

While at it, adjust some of the "Skip line" comments for readability.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 908f0de2d4f0..1db2c8d7cf27 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -277,7 +277,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
  *	0,    0,  EAX,   31:0, max_basic_leafs,  Max input value for supported subleafs
  *	1,    0,  ECX,      0, sse3,  Streaming SIMD Extensions 3(SSE3)
  */
-static int parse_line(char *line)
+static void parse_line(char *line)
 {
 	char *str;
 	int i;
@@ -307,7 +307,7 @@ static int parse_line(char *line)
 
 	/* Skip comments and NULL line */
 	if (line[0] == '#' || line[0] == '\n')
-		return 0;
+		return;
 
 	strncpy(buffer, line, 511);
 	buffer[511] = 0;
@@ -330,16 +330,15 @@ static int parse_line(char *line)
 	else
 		range = leafs_basic;
 
-	index &= 0x7FFFFFFF;
 	/* Skip line parsing for non-existing indexes */
+	index &= 0x7FFFFFFF;
 	if ((int)index >= range->nr)
-		return -1;
+		return;
 
+	/* Skip line parsing if the index CPUID output is all zero */
 	func = &range->funcs[index];
-
-	/* Return if the index has no valid item on this platform */
 	if (!func->nr)
-		return 0;
+		return;
 
 	/* subleaf */
 	buf = tokens[1];
@@ -352,11 +351,11 @@ static int parse_line(char *line)
 		subleaf_start = strtoul(start, NULL, 0);
 		subleaf_end = min(subleaf_end, (u32)(func->nr - 1));
 		if (subleaf_start > subleaf_end)
-			return 0;
+			return;
 	} else {
 		subleaf_start = subleaf_end;
 		if (subleaf_start > (u32)(func->nr - 1))
-			return 0;
+			return;
 	}
 
 	/* register */
@@ -389,12 +388,11 @@ static int parse_line(char *line)
 		strcpy(bdesc->simp, strtok(tokens[4], " \t"));
 		strcpy(bdesc->detail, tokens[5]);
 	}
-	return 0;
+	return;
 
 err_exit:
 	warnx("Wrong line format:\n"
 	      "\tline[%d]: %s", flines, line);
-	return -1;
 }
 
 /* Parse csv file, and construct the array of all leafs and subleafs */
-- 
2.48.1


