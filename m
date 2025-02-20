Return-Path: <linux-kernel+bounces-524833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6CA3E7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDD9189D62B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D8B264634;
	Thu, 20 Feb 2025 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="f//Vi9u/"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE91E9B35
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740091188; cv=none; b=awyrnhJcCXXDpZ5hdKUYIXHO319t8Z2wObxbSXzLteHaME+3GC4ZvB450JqoDJK8ue613rfG6qxTw5tLwyhjgLN3xwsaLGSIai6ig45tg4efmt3Gq9nSnJFgEzB0o6MwEGF6/iXbpYtufNG3VrpPNjF/Jh0i0GPxiWMhKCZQA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740091188; c=relaxed/simple;
	bh=J57RcTCyWAxFm2umO0g+4bB4ISjq2IYkSSr7ajlq/gA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=etcvexuwI/bjdktbbjjiE7sCpM5KT5RBJV6u7EqM3N7v53rRJdfxcY6+5qhqPzI+ZrHa7e7s54qNgz4Zg357HeQZn1A86mXtcnKmt61kX9B4+TqICiAR/pwMxjm5frZzn8UckWJH1sQa1AVKY/NXSH19OZDCHq1ZIxnoGqgSQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=f//Vi9u/; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YzSqz1hl1z9tDy;
	Thu, 20 Feb 2025 23:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1740091183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DA3uhlCDI1A8BDotF0N5GRp5MWr0V4pEHmnZHzSGNPE=;
	b=f//Vi9u/xq6akrnJWV4SMJm4ueQB4UZlcbQa3xbXHzlyKLZEGAQz5GOx0W1xoDwPY4Kk9y
	Tph0I7lxGu6YAlY4Vky1I5k5LOBTMSgQ8U4TGn1al2n6TyvnEvfmKxgZSdxnb7RTsNDjzn
	Ac0QP0q6IfRwjP7l1+QJ/v/aF1Le6BxR/b3NX587g4vCT4JOlImK7mozPKp4GzKiEOHS04
	UqvPjGGcFFastPKxjSK7p437yw6nru/GBcOyd3sZIdAt2l8hO9cRtxHVVYX0f+/iE13K7G
	97jNVI5sqImx72rfBRgG8HdI9BSGFUwJ54gU9x5gP2E7rqOgtUCL7AZXYkmeLQ==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Thu, 20 Feb 2025 17:39:40 -0500
Subject: [PATCH] um: use str_yes_no() to remove hardcoded "yes" and "no"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-um_yes_no-v1-1-2a355ed2d225@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIACuvt2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3dLc+MrU4vi8fF2T1DRDgyRTo1SzVAMloPqCotS0zAqwWdGxtbU
 ATLVp01sAAAA=
X-Change-ID: 20250220-um_yes_no-4ef10b52e6e0
To: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=J57RcTCyWAxFm2umO0g+4bB4ISjq2IYkSSr7ajlq/gA=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBHOWZyMk1TS3JEb0FVdjA4cTZkOVVlVU4ycFZjMisrCnVsUDExbzBzaGJ0ZTkvS2tH
 bWQybExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNLZlN4a1o
 zaWpXQ1p4amY5disvdmxXRGIxTmlSZFRxczRkL2ErWjl6V3ZVTXQrOWRVZGhnei9ETTkva1BmYg
 pOZjJVeDlhcG9WNXZ1TitGUFpqbXhiRHhpRm1tMXFUNVJSYXJXUUdwQ2s3Rwo9QTFqbAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4YzSqz1hl1z9tDy

Remove hard-coded strings by using the str_yes_no() helper function
provided by <linux/string_choices.h>.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 arch/um/kernel/um_arch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 79ea97d4797ecc9c157ee948ae0505bcdef84da5..7f050783885a0faed0a4f334716d2532b982bb91 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -12,6 +12,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
@@ -78,7 +79,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "model name\t: UML\n");
 	seq_printf(m, "mode\t\t: skas\n");
 	seq_printf(m, "host\t\t: %s\n", host_info);
-	seq_printf(m, "fpu\t\t: %s\n", cpu_has(&boot_cpu_data, X86_FEATURE_FPU) ? "yes" : "no");
+	seq_printf(m, "fpu\t\t: %s\n", str_yes_no(cpu_has(&boot_cpu_data, X86_FEATURE_FPU)));
 	seq_printf(m, "flags\t\t:");
 	for (i = 0; i < 32*NCAPINTS; i++)
 		if (cpu_has(&boot_cpu_data, i) && (x86_cap_flags[i] != NULL))

---
base-commit: 27eddbf3449026a73d6ed52d55b192bfcf526a03
change-id: 20250220-um_yes_no-4ef10b52e6e0

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


