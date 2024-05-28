Return-Path: <linux-kernel+bounces-191828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEC8D14C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC481C221A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120C16EB7D;
	Tue, 28 May 2024 06:55:02 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09D5339B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879301; cv=none; b=UdPdauH209Joii1xCXLb/jUS6gTZp/FW8ky77MacSmhode3eta7R832adZpXKLn6qfYfjsUSDCpA1XhJyKxwWOuA7TuT+I9xrsdrsYoZS3pYPXZtbGdSiPcRBeg1ISsTxxoErlUgsOKQKaRmEFOGD+IaXmCgmLU30PeDNZUvQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879301; c=relaxed/simple;
	bh=k/kiyNBZ/CQQZm9441hQ2gzjm+HeVypZQxq7MFeGzuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChBeZg8nA7mqRDZ1KvfII0JPwTMs3xRvWb6KF0BxNzGUYnQf8jTdaF2im2CxvuR/GBfTK9NN58moytahw/q1P3gkSUT/H6MMuojApv6RgQM0uHZ+qKkud/KmUJNddryWz/5Lh9xVeHORrV2Jg+7MP07eRvCg+i1M6TgVo7UXIUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1716878322-1eb14e15750e370001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id gd8N2tgmRDCGMwi7 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 28 May 2024 14:38:42 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 May
 2024 14:38:41 +0800
Received: from localhost.localdomain (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 May
 2024 14:38:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
	<mat.jonczyk@o2.pl>, <rdunlap@infradead.org>,
	<alexandre.belloni@bootlin.com>, <mario.limonciello@amd.com>,
	<TonyWWang-oc@zhaoxin.com>, <yaolu@kylinos.cn>, <bhelgaas@google.com>,
	<justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] x86/hpet: Read HPET directly if panic in progress
Date: Tue, 28 May 2024 14:38:36 +0800
X-ASG-Orig-Subj: [PATCH] x86/hpet: Read HPET directly if panic in progress
Message-ID: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1716878322
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1321
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125447
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

When the clocksource of the system is HPET，a CPU executing read_hpet
might be interrupted by exceptions to executing the panic，this may
lead to read_hpet dead loops:

CPU x				    CPU x
----                                ----
read_hpet()
  arch_spin_trylock(&hpet.lock)
  [CPU x got the hpet.lock]         #MCE happened
				    do_machine_check()
				      mce_panic()
				        panic()
					  kmsg_dump()
					    pstore_dump()
					      pstore_record_init()
						ktime_get_real_fast_ns()
						  read_hpet()
						  [dead loops]

To avoid this dead loops, read HPET directly if panic in progress.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/hpet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c96ae8fee95e..ecadd0698d6a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -804,6 +804,12 @@ static u64 read_hpet(struct clocksource *cs)
 	if (in_nmi())
 		return (u64)hpet_readl(HPET_COUNTER);
 
+	/*
+	 * Read HPET directly if panic in progress.
+	 */
+	if (unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID))
+		return (u64)hpet_readl(HPET_COUNTER);
+
 	/*
 	 * Read the current state of the lock and HPET value atomically.
 	 */
-- 
2.25.1


