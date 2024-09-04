Return-Path: <linux-kernel+bounces-315897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE996C84F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19DEB235BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958C1482E9;
	Wed,  4 Sep 2024 20:23:50 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817F1EBFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481429; cv=none; b=Zoyh2VoBP7jvGpaQcFFtfQIXdFvz0xeyIRJSDVFI8VRdPyI1tbfFq12XugqKPBGazH+1tILqYl5jHgVXacTD21h91gaR39M2YsNw+CaVftIaxNmycYScQC/l2HgAFWsodPLUFaJZQlBqMGjFoNbxqduawIIui6++29A0lm1PfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481429; c=relaxed/simple;
	bh=wKk/zE0Sb4SE2AGgHTidyMD2usxJ1Xnf0OQrvSb3FGM=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=QkzjulGhBrFHN+YGFb9wfrEHNsoSpsx07a1hSH67OtoI3L1jjA4cumd6HesDj0zh+zTZMyXdLKFUMGafPtUHr3zfOBhRnBQud6FeIjcEQL673Dv0UEtD8mzqu2ccSdaGhQAnXDAEn2VKFTads7UzWtGiJ1BRrBYCQyPifm6tmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.83.151) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 4 Sep
 2024 23:23:33 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] irqchip/gic: prevent buffer overflow in gic_ipi_send_mask()
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, Marc
 Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Organization: Open Mobile Platform
Message-ID: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
Date: Wed, 4 Sep 2024 23:23:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/04/2024 19:59:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187541 [Sep 04 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;31.173.83.151:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.151
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/04/2024 20:02:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/4/2024 6:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

ARM GIC arch v2 spec claims support for just 8 CPU interfaces.  However,
looking at the GIC driver's irq_set_affinity() method, it seems that the
passed CPU mask may contain the logical CPU #s beyond 8, and that method
filters them out before reading gic_cpu_map[], bailing out with -EINVAL.
Such check should also be performed in the ipi_send_mask() method where
it uses for_each_cpu(), in order to prevent accessing beyond the end of
gic_cpu_map[] there as well...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 384a290283fd ("ARM: gic: use a private mapping for CPU target interfaces")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
The patch is against the irq/core branch of the tip.git repo...

 drivers/irqchip/irq-gic.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: tip/drivers/irqchip/irq-gic.c
===================================================================
--- tip.orig/drivers/irqchip/irq-gic.c
+++ tip/drivers/irqchip/irq-gic.c
@@ -832,8 +832,11 @@ static void gic_ipi_send_mask(struct irq
 	gic_lock_irqsave(flags);
 
 	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
+	for_each_cpu(cpu, mask) {
+		if (cpu >= NR_GIC_CPU_IF)
+			break;
 		map |= gic_cpu_map[cpu];
+	}
 
 	/*
 	 * Ensure that stores to Normal memory are visible to the

