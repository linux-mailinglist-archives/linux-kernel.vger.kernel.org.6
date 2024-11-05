Return-Path: <linux-kernel+bounces-396416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271479BCCDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38161F24A19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC121D5AA5;
	Tue,  5 Nov 2024 12:39:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A261D54F7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810354; cv=none; b=h70KDq2OTJg8Y96a3vd9nx4266MsXtDHfbaedxcnMyFEp5uMuFnVbGKAn6qLK+81fTFD2mf2Cw+dAPx7vuN3dMEdxwwW0+Q9utlBZYPW7Ij9TUC5QpDEKEgZckfSAcXJOGKDP6UZS5Q7KroceAvmoMqeU/RlY7VcYNdSQ1FLMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810354; c=relaxed/simple;
	bh=sFqNT7sUzHWlwQ8/M8ZP+Q2MBkvEtN117vvn79XMsXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnyQMfTW/hdwoGqypfWw9x1rEqsSx0q3Orvz6t9iWoQzvobE+Z6HOgqI32yZrQPF/IV+qz0OYyLR0xT72sDTTIwpWDEHLsuFLUxcVokHhOoXsbCaONAkYszeSR2yk6kGweQq0n+W1LWot5dS/IzFqtpAPVRaDKMA2Puw5iC8MHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxYa_tESpnf7UxAA--.34496S3;
	Tue, 05 Nov 2024 20:39:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMBxrsLsESpnw4lCAA--.26454S2;
	Tue, 05 Nov 2024 20:39:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add jump table support for objtool on LoongArch
Date: Tue,  5 Nov 2024 20:39:01 +0800
Message-ID: <20241105123906.26072-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxrsLsESpnw4lCAA--.26454S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xw1fWF18ZFyfXr4rJr1rXwc_yoWDXFb_W3
	4xW3s5Gw45WayDta45trnY9ryjkF48Xr4fAFWqvr47Gry5Jrn8GFsF9a4UZr1DKFW5uFs8
	JrZ2qF1xCr429osvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVj
	vjDU0xZFpf9x07jeQ6JUUUUU=

This series is based on 6.12-rc6, tested with the upstream mainline
binutils, GCC and Clang, all the changes are under tools/objtool and
arch/loongarch.

It is time to remove the compiler option -fno-jump-tables to enable
jump table for objtool if the compiler is GCC and it has the compiler
option -mannotate-tablejump, the next work is to add the corresponding
support with Clang after addressing some corner issues due to different
compiler behaviors.

Tiezhu Yang (5):
  objtool: Handle various symbol types for rodata
  objtool: Handle special cases of discard.reachable
  objtool/LoongArch: Add support for switch table
  objtool/LoongArch: Add support for goto table
  LoongArch: Enable jump table with GCC for objtool

 arch/loongarch/Kconfig                 |  3 +
 arch/loongarch/Makefile                |  9 +++
 tools/objtool/arch/loongarch/special.c | 83 +++++++++++++++++++++++++-
 tools/objtool/check.c                  | 38 ++++++++++--
 4 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.42.0


