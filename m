Return-Path: <linux-kernel+bounces-277592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9205A94A378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E461F251C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AA1CB30D;
	Wed,  7 Aug 2024 08:59:13 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9C822334
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021152; cv=none; b=pJS3mW0z+zwoBlDLTaEoZik67WfdKgVMwLJMW9+Fn4DMnGzHqxL3WL6shoIfjfXIUj2OlPChL6oeCSEyFavZ4025FWzwB88l97QGuua+zOSm5rs/+ARjYrXnovS0wnfvRxtLIN8jzUTEyvn3QLJ50hQjdHwWbiqBfNLF5vxJQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021152; c=relaxed/simple;
	bh=ddMC6GuOu91dUFa8L1OCiIs3xpwVs976fbpbYf68F5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adgW/woHuiz1ooRSVIbQqdHdmVEeKpBLYSG3K6d8TWIbg2bwLecb4jtKvzImYwbeUowUDQteuONlsRiK1EX3j0HEUWrrEghiIB4g/Cjqqi8+YB9w5BTjt4FxH3YdIJoJ26MxzEwPGheyxF08OP3Eti6QHet9UYjNV5F6dS208lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Ax2elcN7NmyC8KAA--.31728S3;
	Wed, 07 Aug 2024 16:59:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvmdaN7NmO8EHAA--.24061S2;
	Wed, 07 Aug 2024 16:59:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Fix objtool issues about do_syscall() and Clang on LoongArch
Date: Wed,  7 Aug 2024 16:59:02 +0800
Message-ID: <20240807085906.27397-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvmdaN7NmO8EHAA--.24061S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtryxXFW3uF4kJw15Xr15ZFc_yoWDWrX_WF
	92gFyUCr4rXF9rta4DKw1ruas7AF48Grs3GF1vqrya9ry3AFn8GFyYk34DC3Z0grWrWFZ8
	urW8tFyFy34YkosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

With this series, there is no objtool warning about do_syscall() and
there is handle_syscall() which is the previous frame of do_syscall()
in the call trace when running "echo l > /proc/sysrq-trigger".

Compiled with GCC and Clang, tested with the following two configs:

(1) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
    CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=n
(2) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
    CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y

Tiezhu Yang (4):
  objtool: Handle frame pointer related instructions
  LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)
  LoongArch: Set AS_HAS_THIN_ADD_SUB as y if AS_IS_LLVM
  LoongArch: Enable objtool for Clang

 arch/loongarch/Kconfig                |  4 ++--
 arch/loongarch/kernel/syscall.c       |  4 ----
 tools/objtool/arch/loongarch/decode.c | 11 ++++++++++-
 tools/objtool/check.c                 | 23 ++++++++++++++++++++---
 tools/objtool/include/objtool/elf.h   |  1 +
 5 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.42.0


