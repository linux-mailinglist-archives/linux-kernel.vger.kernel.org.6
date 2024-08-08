Return-Path: <linux-kernel+bounces-279295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1DB94BB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4BF1F23552
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11218A6CC;
	Thu,  8 Aug 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiH/krAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB718756D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113681; cv=none; b=mGSYP9jjvAEQ1EZ+xVMgN4e9/A3/WSwCexihOGxiIjrPHDaollSxU1xnjIYJmZZNknAQ0goHgA52R4xRqSZ9S9uULX2fdy/g2l76HPGCd/ouPD2dTVUfk1X1W4CtWUCF8zyWKEs93zIXqMeD3IkszM3G0+Tr1wtZ5O5KsYO50sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113681; c=relaxed/simple;
	bh=/mKn6DBIVkCOgDdC2lQ9Xnmw9VgNM2rmgsM6Q57B0u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRBBE67MqDzUokD570znTU3QfnBwUjlQ2OPfJOb0/hoHhzBAc0ynEEGN6R6ioUsMeC9F+s7SeENbR8coKxZS+am87rUJ+S7Gmm0aOacrG2uPEhsBTy0bELc2OKFVueKFWpPneErKZLW4j+yrq92p+WiS3vSrZbVN0rvZ5ArBDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiH/krAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB10C32782;
	Thu,  8 Aug 2024 10:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113681;
	bh=/mKn6DBIVkCOgDdC2lQ9Xnmw9VgNM2rmgsM6Q57B0u8=;
	h=From:To:Cc:Subject:Date:From;
	b=BiH/krAW1x6AANXnAc2SNTCloZnQBdLqdThmbmjUt50sJn0+2ABPSwbXEaLX83EpV
	 UTUZirOshk/YsnDjZpaXRlSWnZJQLGjp5e88nTC4+ggLTfeveXJ3FhrWtyptDZYZq3
	 eBc2QMK1vjPEADbM1+HfrSO4gWe/XVkGPnxBot2BWSIU5lZ0XL4TUNDLteIy/6lpsp
	 vobVWkQ8/nwRKrhFBI2apMvPe9at4TU/iPicDfmWPoeJHESQ7RMTu4SvsEPps0IHM2
	 PwA9VGTRuCZCrEpTd+EwEQkLvTkVbalhkOf4j6cc6J0BW1sBY2EVbH7gnCaj5Sdm7A
	 YP7lVX/CYpXPw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/3] genirq/irq_sim: Remove unused irq_sim_work_ctx::irq_base
Date: Thu,  8 Aug 2024 12:41:16 +0200
Message-ID: <20240808104118.430670-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 337cbeb2c13e ("genirq/irq_sim: Simplify the API"),
irq_sim_work_ctx::irq_base is unused. Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 3d4036db15ac..1a3d483548e2 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -13,7 +13,6 @@
 
 struct irq_sim_work_ctx {
 	struct irq_work		work;
-	int			irq_base;
 	unsigned int		irq_count;
 	unsigned long		*pending;
 	struct irq_domain	*domain;
-- 
2.46.0


