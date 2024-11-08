Return-Path: <linux-kernel+bounces-401330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69DB9C18E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EA38B24A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2551E0DDB;
	Fri,  8 Nov 2024 09:16:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410365473E;
	Fri,  8 Nov 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057400; cv=none; b=gFx5klkVw3yPBSVNbUBS4zURiw6UmUAqrexE97iJBzlk37rWIUfDEH58vUijn4cUEEoWe12gGYClwKnU9/dPAexz5Sv3mF7u0zGtkExpuq2EOZtJBvMnL6cuPPyAOTRecIbtiDdh6mlm2lbRTqq35OgSq777KB/ILtgYNnpDh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057400; c=relaxed/simple;
	bh=xh6P2cgEcFDwQtyiWnMsHhk3bmNyrDfk2v0HwaVb07M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaPXlrbKbyb6B3SOKfbNw2bYtC978pOWsJEv9jz/c3Y9Br7pZxcZ/mjJL4PUxM0H8lRntSspTGksbFpFzLDAIZdP26cx7H4n6sdb5LgcrOIJ0nYoHEy9SEe8qQYZFio76GRxjERe/UIkrGOedN2KSAOjMpW010Wv5NEWosTOSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC87C4CECD;
	Fri,  8 Nov 2024 09:16:37 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent device
Date: Fri,  8 Nov 2024 17:15:43 +0800
Message-ID: <20241108091545.4182229-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108091545.4182229-1-chenhuacai@loongson.cn>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
device. For a 100MHz hardware timer this means ~15us. This is a little
big, especially for PREEMPT_RT enabled kernels. So reduce it to 1000
(we don't want too small values to affect performance).

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index 46d7d40c87e3..e914b27a7c89 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -127,7 +127,7 @@ void sync_counter(void)
 int constant_clockevent_init(void)
 {
 	unsigned int cpu = smp_processor_id();
-	unsigned long min_delta = 0x600;
+	unsigned long min_delta = 1000;
 	unsigned long max_delta = (1UL << 48) - 1;
 	struct clock_event_device *cd;
 	static int irq = 0, timer_irq_installed = 0;
-- 
2.43.5


