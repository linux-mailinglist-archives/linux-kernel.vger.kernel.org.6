Return-Path: <linux-kernel+bounces-241927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C7928166
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5B41F22DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 05:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090D76050;
	Fri,  5 Jul 2024 05:22:15 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A3A721C6A0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720156935; cv=none; b=LuBn2C8S9uWdbDMlGfeb2UGkLjlDcANOY2UyK9BoNL/u5OkEtNJRGOtqVQjmWJAHm5DJCGNSVckZqFumwJkUFqx4EEkZmFpFzH0JHleLLFJAWSSaEOgxDq3mMK/n9iFpUoaG4bIoFMMEYoTTDUcKFPln5KEEd/ldVUnOaQu0oKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720156935; c=relaxed/simple;
	bh=Q6bzmLjWnyiMuXjFUbrr8eOnSuD0cTMggs0QkMlcBB0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XIHsEE3NG/kicAFTPkoxtfV+GI4WaJ3H5b1NlHo1EMlb/GN2Q+HjOOUwRbz84oXRpe9H1mCU7y0XsOsM/jdHknYl/HHSvQe2B4RWPDtGruVxAaWyvgTakZTfysTQWRaeXmmQmU1ftUcTo9tl+y3z5TnJ/Q7V8XYxOun6CGRQub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPA id BC83E609F0C68;
	Fri,  5 Jul 2024 13:22:06 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: patrice.chotard@foss.st.com,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?clocksource:=20arm=5Fglobal=5Ftimer:=20Remove?= =?UTF-8?q?=20unnecessary=20=E2=80=980=E2=80=99=20values=20from=20err?=
Date: Fri,  5 Jul 2024 13:21:59 +0800
Message-Id: <20240705052159.22235-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

err is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index ab1c8c2b66b8..a05cfaab5f84 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -343,7 +343,7 @@ static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
-	int err = 0;
+	int err;
 
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer
-- 
2.18.2


