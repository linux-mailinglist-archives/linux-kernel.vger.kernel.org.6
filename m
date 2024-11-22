Return-Path: <linux-kernel+bounces-417772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE29D58EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76434B20DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 04:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885E1166F1B;
	Fri, 22 Nov 2024 04:50:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9B1527A7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251029; cv=none; b=mYN2Kiqn85ZHiEALuInYOhQ2npCU3taJu04v0pKJ4slKsX9W7/7c3cnysuAm7tnMgFf/b7FyGYbLT7NTWImGuX6NoWXlbN5BoC/jmTuiB8jQ/c19eUGfFmj+Lfr9ckaTZIPqCOue0EVJOfQU1zEA99iIAvmMf6afP2OVoHHbQSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251029; c=relaxed/simple;
	bh=JD5fhBPzeT0CyzSwrSAsbW9I9WzcrYZsAKX3gGjoAbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mXPN1mdAqC10H2YAo9PWTC/8/RIts/ZqhkC0cq1Lj52AAfmUI7BUXqqDVveod85q1mU6/h+9pc8K9YkzsnecP9g7i70KzO2Z8Cq6M2UhDD4OFTHxIpkIhiqx5Xnglnd/gP8AlvMgHhYl5Z+1outvx/7SxY76gnP6OxqkuiO36+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxQK+JDUBn77xFAA--.46942S3;
	Fri, 22 Nov 2024 12:50:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxdcCIDUBnIJJiAA--.33733S2;
	Fri, 22 Nov 2024 12:50:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/10] Add jump table support for objtool on LoongArch
Date: Fri, 22 Nov 2024 12:49:55 +0800
Message-ID: <20241122045005.14617-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxdcCIDUBnIJJiAA--.33733S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr48uFWUWF1rWF4DGr48uFX_yoWkKrc_ZF
	yxWF95Gr4rXa45ta4xtas5urWjkFs5Jr45JFykXr12vF15Jr15WF42vr1DZrZ5Kry5ZFs8
	tF4vkryxCwnrWosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

This series is based on 6.12-rc7, tested with the latest upstream
mainline Binutils, GCC and Clang, most of the patches are aim to
handle the special cases compiled with Clang on LoongArch.

v4:
  -- Avoid EM_LOONGARCH and R_LARCH_32_PCREL undeclared error
     for various compiling environments.

  -- Remove the check condition "dest_insn->type == INSN_NOP"
     for unreachable entry of rodata.

Tiezhu Yang (10):
  objtool: Handle various symbol types of rodata
  objtool: Handle special cases of dead end insn
  objtool: Handle different entry size of rodata
  objtool: Handle PC relative relocation type
  objtool: Handle unreachable entry of rodata
  objtool: Handle unsorted table offset of rodata
  objtool/LoongArch: Get each table size of rodata
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table for objtool

 arch/loongarch/Kconfig                 |   3 +
 arch/loongarch/Makefile                |   4 +
 tools/objtool/arch/loongarch/special.c | 156 ++++++++++++++++++++++++-
 tools/objtool/check.c                  |  75 +++++++++++-
 tools/objtool/include/objtool/check.h  |   1 +
 5 files changed, 233 insertions(+), 6 deletions(-)

-- 
2.42.0


