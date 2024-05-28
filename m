Return-Path: <linux-kernel+bounces-192118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC138D189D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90EF28936E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B47B16B72D;
	Tue, 28 May 2024 10:30:34 +0000 (UTC)
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA44D59B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892233; cv=none; b=IDHCuIilhuC0OfaesFCC1mNDXTBoHmbvbVxlffw/WcZ3hc5KBGkKm33bUldLO5N9BAGWIZIqPe4YwObbQmyphJt7u6HClFj7kVf53fK6myaHuGU5RtYdDNZCo40R2U3HOuAoJ1+JO/tC2Hn0QXVCW95r1SL93JGuJ/AD46hhFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892233; c=relaxed/simple;
	bh=m2xLQ4LCjpYiulwHCl7+pHf3KWKMiBRwWIdPLUxEUno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OngCQYAjt2gVGCzBKy0ce3W9xuLcK+7YOz475pzHDvL9Su8+jlM1OsXQ3ubcWFMQXoj0oX14dd1ZwR0cE2T8G3cjOUyWfMEko39Zn9h0za0dj+mrwyIxhRu3MfV1QFf8ApPfhygmKQ+oco+DiWg1PAJ6Y1ayEkr8t3Emnh9Fuh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1716891601-086e23110611970001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id CCGBquudrnAo6hvN (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 28 May 2024 18:20:01 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 May
 2024 18:20:00 +0800
Received: from localhost.localdomain (10.32.65.162) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 May
 2024 18:19:59 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
	<x86@kernel.org>, <jpoimboe@kernel.org>, <vlovejoy@redhat.com>,
	<gregkh@linuxfoundation.org>, <oleg@redhat.com>, <TonyWWang-oc@zhaoxin.com>,
	<linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] linux-4.19.y/printk: Avoid logbuf_lock deadlock in oops_end()
Date: Tue, 28 May 2024 18:19:57 +0800
X-ASG-Orig-Subj: [PATCH] linux-4.19.y/printk: Avoid logbuf_lock deadlock in oops_end()
Message-ID: <20240528101957.7277-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1716891601
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1555
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125455
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

A CPU executing vprintk_emit might be interrupted by #PF exception,
this may leads to logbuf_lock deadlock:

CPU x:                            CPU x:
----                              ----
vprintk_emit()
  logbuf_lock_irqsave()
    printk_safe_enter_irqsave()
A:  raw_spin_lock(&logbuf_lock)
  vprintk_store()                 #PF
                                  do_page_fault
                                    ...
                                    oops_end
                                      bust_spinlocks(0)
                                        console_unlock()
                                          ...
                                          printk_safe_enter_irqsave()
B:                                        raw_spin_lock(&logbuf_lock)

logbuf_lock is taken at A and the deadlock happends at B.

Pass 1 to bust_spinlocks() in the oops_end() to avoid this deadlock.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/dumpstack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 7e698c45760c..b4c145ee9536 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -336,7 +336,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
 
-	bust_spinlocks(0);
+	bust_spinlocks(1);
 	die_owner = -1;
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
 	die_nest_count--;
-- 
2.25.1


