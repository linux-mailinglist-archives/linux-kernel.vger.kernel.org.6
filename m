Return-Path: <linux-kernel+bounces-411999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ECA9D0226
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D31B23057
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332F47F69;
	Sun, 17 Nov 2024 05:40:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8C047F53
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731822046; cv=none; b=EhfZ/n5obMqOT27obY0OuwK8ZaLrv9MHTT11CW1dTmrr19gamZ9mLfMPcpmZ1w68GqdzbESTxXJTxE20nhC/B+ERecFGf45rKP04ANExmeydgdxldxsfoD+Fmbf/pyanbvCV1MbU3lAZOo3X9ybx3mNa2rqTJ932UAgd/vWHqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731822046; c=relaxed/simple;
	bh=4sP5Q0ptJmvb0V9YzLLo20RFuwkSOnEAC3NQB/TDvt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny2BoH+e9rfCTSF+iEH+m/Dem8Ln7ASE9RjY5tkP/UmGXdmuVdYibrYjUAwZmDCRX5TRNLSSdpjeD4qk8xORDM9ESL2EyQXAhbWHe4ErKGygYMSa3Euj3Wg+CAH/9HECqB5Plcg/9FPzXcSORTSlBjU0n9HfcjyQVUKzVPz++mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8AxbeLbgTlnKwxAAA--.60384S3;
	Sun, 17 Nov 2024 13:40:43 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBxO+DDgTlnJ4NZAA--.10317S4;
	Sun, 17 Nov 2024 13:40:42 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: loongarch@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 3/4] LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Date: Sun, 17 Nov 2024 13:40:16 +0800
Message-ID: <20241117054017.3938700-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241117054017.3938700-1-chenhuacai@loongson.cn>
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxO+DDgTlnJ4NZAA--.10317S4
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFWfJr4DCr45JFWrGFyxtFc_yoW3GFb_G3
	W7Jw48GF1rAw42934qvF4Fgr13Za1kuFZxCrZFvr43WrnxXw15Jr48Jw15Zr1Sg3yqgFs5
	Z3ykXF95Cr12yosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

Move POSIX CPU timer expiry and signal delivery into task context to
allow PREEMPT_RT setups to coexist with KVM.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d9fce0fd475a..2443d5a80e0d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -155,6 +155,7 @@ config LOONGARCH
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE if UNWINDER_ORC
-- 
2.43.5


