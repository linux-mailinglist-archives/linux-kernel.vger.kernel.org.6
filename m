Return-Path: <linux-kernel+bounces-383094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9429B1748
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195121F2279F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AF81D2F6F;
	Sat, 26 Oct 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z8u7GMtJ"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B41D1F5B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729940905; cv=none; b=bWR/sZ4ghJIQoB9s0hw5PErepNSN3WDo+j78Ecs0VDD3itnKtpOsci2CdJDE0OZK7qeL2pxOmqiXANACgcRDK/jEcSwu3zMEEFanByTQrIODFPVhK2ozmHMIaHyg/QLzUziZ2NOh5aUYeUQijcqCVseW1Hyw90qDN4tgDs0SuRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729940905; c=relaxed/simple;
	bh=Z1EgtH3POWpxTMufaRQ0P0zytPAxexCEVz0Y5BREvA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwSgZv9lMBTQdUWB7JniQjN2BEYptK+cqRWJccNlamYfHF444sHLmb47eL1sKH6VKWR680U3JoOhNWvp1sj6Cj4bn3MxwKGq9YOsxgN84TKOISezCf+3h6IglyB1JOv4k4UISLW6y3c9pk38TAQI3M3a5wVw6NmOE7vW8lxtBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z8u7GMtJ; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729940900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D6WmR0Vrvsk0z1xRaZASUwGnn+vKUqUmpNkKJpeL+EQ=;
	b=Z8u7GMtJD5epajEEwoWWPxCuPq6zv3pnCTxgZrmaczz2ydW7yaUzc09VmX1qpDT0AoOLu0
	gqYxmUihHfWmmYq89IR4M2jcbXVqrv6UmXZVtL6dKf8Ocgfq1+Y9RKIPUwUp3RgSk1Qp2u
	NbW66glUtTlyP8jwK8eZ8Q02pp2LucA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Use str_yes_no() helper in show_cpuinfo_misc()
Date: Sat, 26 Oct 2024 13:08:06 +0200
Message-ID: <20241026110808.78074-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/cpu/proc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index e65fae63660e..41ed01f46bd9 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -41,11 +41,11 @@ static void show_cpuinfo_misc(struct seq_file *m, struct cpuinfo_x86 *c)
 		   "fpu_exception\t: %s\n"
 		   "cpuid level\t: %d\n"
 		   "wp\t\t: yes\n",
-		   boot_cpu_has_bug(X86_BUG_FDIV) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_F00F) ? "yes" : "no",
-		   boot_cpu_has_bug(X86_BUG_COMA) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
-		   boot_cpu_has(X86_FEATURE_FPU) ? "yes" : "no",
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_FDIV)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_F00F)),
+		   str_yes_no(boot_cpu_has_bug(X86_BUG_COMA)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
+		   str_yes_no(boot_cpu_has(X86_FEATURE_FPU)),
 		   c->cpuid_level);
 }
 #else
-- 
2.47.0


