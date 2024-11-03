Return-Path: <linux-kernel+bounces-394044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C829BA99C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F81C281A02
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B7218C326;
	Sun,  3 Nov 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N+3+qozj"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ADB189B95
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677360; cv=none; b=nFdEXRnYFqLxQiJHtR1A04gnseydbsEE58GFVamK3aqZwcmWP8chA/OPctCwMUBM3kWMqgol0+Msvh0zxalcV0dIYwxhhUnXaOqpmwGmz31aRREmyp+dHZ3mP0PGjW/39UKFuOGFNtwF4qAiEHdhwmu+Zwj1Pqpj/LU7d5xaxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677360; c=relaxed/simple;
	bh=WhLdeIds1wS0OngDEx9iIrmQofTtrBBGKlu6GqYnUas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNd/0TM+BOSAbgnOAsGxt5KRuEHEzA6ZWEbNT+UFe1K8O+wN0ckDdeodkhanlmG22lMt9dC6u8SAJ1KnINdE2npcWZX/K77bIe84qTSqH98JNdsi/ib9ghHfJu4963tYasz9HzEVSzBzjgvuPGDjuzl/kXfrUK8HQlYayncIisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N+3+qozj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730677355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wO9F05OjFTEM/HcQCrt4botr5JYhab2ML8z74ip7l5A=;
	b=N+3+qozjVdsl1wDd+yLCd/KUZv8YJzPR088pGpuhUtQaLuEuTFrKDFZkRaU0Erq/+j9e7y
	tGyoO9US6hmQgMateHisEd7q8wBA+9toHwhoU/rMXVxuOSfWV6/am9pqOV0JNNjjWKvtzg
	DiHMbBGEKXg15taTq98oHW7nswIqSUM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: Use str_disabled_enabled() helper in print_ipi_mode()
Date: Mon,  4 Nov 2024 00:42:13 +0100
Message-ID: <20241103234216.2373-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_disabled_enabled() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/apic/ipi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5da693d633b7..942168da7195 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -3,6 +3,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/string_choices.h>
 
 #include <asm/io_apic.h>
 
@@ -23,7 +24,7 @@ __setup("no_ipi_broadcast=", apic_ipi_shorthand);
 static int __init print_ipi_mode(void)
 {
 	pr_info("IPI shorthand broadcast: %s\n",
-		apic_ipi_shorthand_off ? "disabled" : "enabled");
+		str_disabled_enabled(apic_ipi_shorthand_off));
 	return 0;
 }
 late_initcall(print_ipi_mode);
-- 
2.47.0


