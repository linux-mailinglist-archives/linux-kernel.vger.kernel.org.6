Return-Path: <linux-kernel+bounces-250423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EC592F7B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BAE1F244A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB114E2E1;
	Fri, 12 Jul 2024 09:15:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F961442F7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775712; cv=none; b=mVjPP2gGa5maQd4GTbcEJfqtsDuRcis7jjHEDrIalHzHu/xqWEs62scFxIHlvKb9Oe4NIiysf8V0QvGbw0Ndg8G5hTSF523UmDscfluZ6BXxpnh0/nvJVUly0ylL4Mop/qP3Gjt9L9s9mqBRVsoUrmgdjrV3RufVFDvdeSEn3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775712; c=relaxed/simple;
	bh=gDAtlrQb7pwC0IsoMxHtpOR67LxVHX2NBX/p2+oALsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDAm0roMwtQs389QeePicD4yq4EaBjZ2rR06Ayn8gFW3CKkG8ibwDf2wizhGxqAdYB2iaMYy0hjc36YuaxSMvqxgZY5z4FL8OX9NVsiUYLuCA0lmthnB2uC0TloZmXRqMdG1xrgfUe9gG4QG7jFV9uhnsO8zkTbnBKM3rPYsSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxo+kc9JBmIqEDAA--.1236S3;
	Fri, 12 Jul 2024 17:15:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXcca9JBmW65FAA--.28188S2;
	Fri, 12 Jul 2024 17:15:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Add jump table support for objtool on LoongArch
Date: Fri, 12 Jul 2024 17:15:02 +0800
Message-ID: <20240712091506.28140-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxXcca9JBmW65FAA--.28188S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFy8GF17ZF1rGFWUZF1DJwc_yoWkJFg_Wr
	92g34kG3yrZFyjgFy0qr1fXryUKFWkJrn8GFyDXr1xtr15Arn8uFZrJ34YvF1Fg3yFqFs8
	JrW0yry8C3s2yosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

This RFC version is based on Linux 6.10-rc7, there are no detailed
commit messages for each patch for now and the code are relatively
clear and simple.

This series is tested with the latest upstream gcc applied with patch
"LoongArch: Add support to annotate tablejump" [1] which adds a new
section discard.tablejump_annotate to record the jump info, it makes
life much easier, special thanks to Ruoyao.

I will address all the review comments and update the commit messages
after the merge window.

[1] https://inbox.sourceware.org/gcc-patches/20240711114415.4420-1-xry111@xry111.site/

Tiezhu Yang (4):
  objtool: Check local label in find_jump_table()
  objtool: Check various types in add_jump_table()
  objtool/LoongArch: Add support for jump table
  LoongArch: Remove -fno-jump-tables for objtool

 arch/loongarch/Kconfig                 |  8 +++-
 arch/loongarch/Makefile                |  6 +--
 tools/objtool/arch/loongarch/special.c | 54 +++++++++++++++++++++++++-
 tools/objtool/check.c                  | 36 +++++++++++++++--
 4 files changed, 94 insertions(+), 10 deletions(-)

-- 
2.42.0


