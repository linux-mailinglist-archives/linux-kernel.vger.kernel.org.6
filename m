Return-Path: <linux-kernel+bounces-274142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93299473E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD8D1C20EB9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C413E020;
	Mon,  5 Aug 2024 03:27:07 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2495047F5D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828427; cv=none; b=GoWdsoNsLC8/Hxub1/W7p9KcZ5Gwpe+VtqELlZcIgeTtoGQ9XyrzRAeyIV3DVI4CXfkAXaW9TYInkAF2MdRSJieAPtRiJQBa92y95JoaMWeViMfWXHp2YEFHSP/pcvx+mqlKPW68QAMTFh3Aw5hYzKeo6TvV1v3UFqVOkFF0SfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828427; c=relaxed/simple;
	bh=Fj5glKpLUPovg55I8s6uj5ukZ+uVKWN2zwwveLmbcHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0hk3eiUK43mjsgtiaiy0BsVYQ2SvDrb35fWCYkOLPeZgCkpOlQVnHSpXBKlLGlCmnX/Bu5kpd0sl7a/QkpnfyzTkw2bu4Nc2qnQpr2IZ5nb6Ac8A4glX3Be3WAOWEoY1AHXrzxkzLlToBrZB9xwq5o1Gycx8QPsNyyYnVmcgVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxe+qGRrBmF9AHAA--.26823S3;
	Mon, 05 Aug 2024 11:27:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxkeGFRrBmgeADAA--.20473S2;
	Mon, 05 Aug 2024 11:27:01 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix objtool warning about do_syscall() on LoongArch
Date: Mon,  5 Aug 2024 11:26:57 +0800
Message-ID: <20240805032700.16038-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeGFRrBmgeADAA--.20473S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtryxXFW3uF4kJw15Jr1DJwc_yoWDGFc_GF
	yI9FyUCr1rXFZrta4Dtw1rWr97CFW8Jrn5GF1vqry2gryayF4DJFW5A34DC3Z8KryrWFZ8
	urW8Ja4rAr9I9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb78YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==

With this series, there is no objtool warning about do_syscall() and
there is handle_syscall() which is the previous frame of do_syscall()
in the call trace when running "echo l > /proc/sysrq-trigger", tested
with the following two configs:

(1) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
    CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=n
(2) CONFIG_RANDOMIZE_KSTACK_OFFSET=y &&
    CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y

Tiezhu Yang (3):
  objtool/LoongArch: Decode secondary stack instruction
  objtool: Handle secondary stack related instructions
  LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)

 arch/loongarch/kernel/syscall.c         |  4 ----
 tools/arch/loongarch/include/asm/inst.h | 12 ++++++++++
 tools/objtool/arch/loongarch/decode.c   | 29 ++++++++++++++++++++++++-
 tools/objtool/check.c                   | 22 +++++++++++++++++++
 tools/objtool/include/objtool/elf.h     |  1 +
 5 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.42.0


