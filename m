Return-Path: <linux-kernel+bounces-413906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6F9D207E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 07:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18DE2825EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 06:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F814F9E7;
	Tue, 19 Nov 2024 06:57:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AA414D6F6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999422; cv=none; b=F1ut/4OSmYQztDnEYHrlw5XktXmWMLGnLVcOGmKzpCZ0bAEeAFYdr2DjHZkFUmE7hM5HPgHt3AEJ2tJwQ5H7h8HQaSNXWWyoCxxioWGNztpHfHp2Br2/bYF8u6wmd2hBdUGQPCPV+u19ZztYcW7DWwSO6mklzgWwC1GNQ+N2MwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999422; c=relaxed/simple;
	bh=ebRZMPmXGKiaPpS5pNKT/Qy1wqQ6Awo19ORuU2KqlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uk2tzEBwgdckgpIZvyx0RoVwgmbWWHshGOJErTKDntKbNrT4DRZm333GEZXFw62LNTSUiOR0t+ZX76uwTLmEx5kPcvxH/5PH0pN0QTSh5JmiA/NPh2zgw9ZDhRnlsgR9Ka4070Pnifb+tzd7OD2LzO4ZUfC3q2/Y7TRR/yQ8MsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxPOK6NjxnUDZCAA--.64243S3;
	Tue, 19 Nov 2024 14:56:58 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMCxDuG4NjxnB_5cAA--.5437S2;
	Tue, 19 Nov 2024 14:56:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] Add jump table support for objtool on LoongArch
Date: Tue, 19 Nov 2024 14:56:45 +0800
Message-ID: <20241119065655.21123-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxDuG4NjxnB_5cAA--.5437S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr48uFWUWF1rWF4ftr45XFc_yoWDXrg_ur
	yxWF95Gr1rW3W5tayxtF95uFyjkFsYqr45JFykXr129r15Jr15WF42vr1DZrs5KrZ8ZFs8
	tF4vyryxCwnFgosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

This series is based on 6.12-rc7, tested with the latest upstream
mainline Binutils, GCC and Clang, most of the patches are aim to
handle the special cases compiled with Clang on LoongArch.

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
 tools/objtool/check.c                  |  68 ++++++++++-
 tools/objtool/include/objtool/check.h  |   1 +
 5 files changed, 226 insertions(+), 6 deletions(-)

-- 
2.42.0


