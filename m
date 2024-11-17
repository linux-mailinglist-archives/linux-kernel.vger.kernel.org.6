Return-Path: <linux-kernel+bounces-411996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34969D0223
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 06:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14E51F23B63
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC53AC2B;
	Sun, 17 Nov 2024 05:38:04 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C39F2FB2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821884; cv=none; b=R6+2dAXv7v1yMC/P4gHkj+9+6GTw1nW4Nr4LcdjMJ6wz+lcZCakAvS05CjeKtQoV542aN6bCx+hwbzbUeBQbBFFzyp/IZ/GQRd0IsjCq4gMv5Mgla+zJ7KLG0dGbz/fSSveYCaWrq/nu/5+vajCZFb7bjHWAq0MeU2axRv/t9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821884; c=relaxed/simple;
	bh=EeVrEIUZXLaSoNuWD/hKzgiAhS1Gq82yDFfoKF77bmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWvum5Z1AqMWkVUsQQ4vYBoi0xtchL+HaN+GWlwdFLPmBvqozxh0wjLyrfVdzd7AsgefHROdTt4Pr9KO39Uu7m5tzJyO8IONgiYSEwGCY6fJPeCOyEXerxYSvGkhsNZzjNFMcp5tZe9iKFm5aPKKXGSXRXQrshy+0FVhdTQMkvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.202])
	by gateway (Coremail) with SMTP id _____8AxquA1gTlnwwtAAA--.61130S3;
	Sun, 17 Nov 2024 13:37:57 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.202])
	by front1 (Coremail) with SMTP id qMiowMBx68EwgTlnnIJZAA--.6029S2;
	Sun, 17 Nov 2024 13:37:56 +0800 (CST)
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
Subject: [PATCH V2 0/4] LoongArch: Add PREEMPT_RT support
Date: Sun, 17 Nov 2024 13:37:36 +0800
Message-ID: <20241117053740.3938646-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx68EwgTlnnIJZAA--.6029S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr1kCFWDAw18Zr4rXrWDtrc_yoWfuFc_Ga
	yfGw1Uur18G3y7Zwn3tw1rJ3srCa10gr43u3s7XF43XryFkrs5trs5GF48Arn0gFW7Xrsx
	JayDAr15ur9IvosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jeq2NUUUUU=

This series add PREEMPT_RT support for LoongArch.

With the recent printk changes, the last known road block has been
addressed. The main architectural preparation we need is selecting
HAVE_POSIX_CPU_TIMERS_TASK_WORK to allow PREEMPT_RT coexist with KVM.
Then we can also enable PREEMPT_RT as X86, ARM64 and RISC-V.

V1 -> V2:
1. Fix sleeping in atomic context for PREEMPT_RT.
2. Reduce min_delta to 100 for PREEMPT_RT and update commit messages.

Huacai Chen(4):
 LoongArch: Reduce min_delta for the arch clockevent device.
 LoongArch: Fix sleeping in atomic context for PREEMPT_RT.
 LoongArch: Select HAVE_POSIX_CPU_TIMERS_TASK_WORK.
 LoongArch: Allow to enable PREEMPT_RT.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig       | 2 ++
 arch/loongarch/kernel/time.c | 6 +++++-
 arch/loongarch/mm/tlb.c      | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)
---
2.27.0


