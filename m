Return-Path: <linux-kernel+bounces-241915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1C192812C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BA8B23F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2F61FD6;
	Fri,  5 Jul 2024 04:08:37 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id ACA542B9A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720152516; cv=none; b=N1ENR1iEk6FYRfhtxfp6K5h5VrBbUWIBdZM8A2yKP0edwFnamqm1cRRu00PFd9hkBZqII6hpzE0VbRBHzr35i3vFMolwZEbLXB4WbcP/xKpsBmxfv4rKSFiqiT6WGCursgUwn1L0hiXt6pO6YUEOyM9rblurcIvYdhLnlgO46Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720152516; c=relaxed/simple;
	bh=T89Y7awl0ypfijhZi0bGYCFBoFeV3XlW47jm4Za9Jlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mxIPz5zgxo8GRPOzDMtnIJ7HF58Ofw2swPrTmBUFU/URQi9pXOCx7dnt6nMWn9gTFuZr/GbQdSC85p2nMao+lDkBGCrlX7eS4lDPj6Q3yQV3UbtwDrrYnJvyhMUqmWr3l7PBASw4Me17nvCnqIpRdmN4kE6FnqyC36kkbu8bdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id C527160830CC2;
	Fri,  5 Jul 2024 12:08:20 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: mark.rutland@arm.com,
	maz@kernel.org,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?clocksource:=20arm=5Farch=5Ftimer:=20Remove=20u?= =?UTF-8?q?nnecessary=20=E2=80=980=E2=80=99=20values=20from=20irq?=
Date: Fri,  5 Jul 2024 12:07:29 +0800
Message-Id: <20240705040729.21961-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5bb43cc1a8df..aeafc74181f0 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1556,7 +1556,7 @@ static int __init
 arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 {
 	void __iomem *base;
-	int ret, irq = 0;
+	int ret, irq;
 
 	if (arch_timer_mem_use_virtual)
 		irq = frame->virt_irq;
-- 
2.18.2


