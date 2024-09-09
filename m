Return-Path: <linux-kernel+bounces-321116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38879714BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C381F2205B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE491B3F1B;
	Mon,  9 Sep 2024 10:03:55 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC21B3B2D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876234; cv=none; b=TNAt71PSP1umR3LF84CplMNz5gqqjXrQXwN2PyH4+aNVzeYHL4HWIfaWOWElKx95BxA/WIzRJXuxT2PSlNyfSjV+4pwpuY6GeQByhs4Ja/rRbo9d+Un48YL0mmn24Y4Ky6XzDCBYYV7YcJWVMMJ4Z1xbJii3ltjfMcTura99Wtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876234; c=relaxed/simple;
	bh=uoxKCIoyk4fzsfG0KuHW9qjzAbPMwtZRpVgkUd7yYhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LfgxGdq+Kc8Gu5xyM10kEwyOvTnxGquEH3CM95s8K2M+dH2qeypHJfkqUjjKyLIo998m0e41BMIqplR4OzVGLoz4KYOPS1YBfVaCMOzquAuAYQQDsSo8hC18/7M54gWjKZzmbZnzxUtjCNcvmJhnMvSBxkG0GJQ9DYHoGOvjUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-05 (Coremail) with SMTP id zQCowAAX_yE7xt5m6Lw1Ag--.2130S2;
	Mon, 09 Sep 2024 17:56:12 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] riscv: Remove duplicated GET_RM
Date: Mon,  9 Sep 2024 17:55:57 +0800
Message-Id: <20240909095557.446745-1-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAX_yE7xt5m6Lw1Ag--.2130S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur1kKr1UArW3ArW5ZF4UXFb_yoW3uwb_Ar
	1UG395Wrn3Ca1FvFyDGwsYkF1jy3yrtFyfC3WfWrW0kFyUtrWYkwnxK345Kwn8Gr4rGwn7
	uF97Xrn3Xw4jgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb2kYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
	1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
	x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8lD73UUUUU==
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwwPB2beo519lwAAsv

The macro GET_RM defined twice in this file, one can be removed.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/kernel/traps_misaligned.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index b62d5a2f4541..2a9b72dcd648 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -136,8 +136,6 @@
 #define REG_PTR(insn, pos, regs)	\
 	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
 
-#define GET_RM(insn)			(((insn) >> 12) & 7)
-
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
 #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))
-- 
2.34.1


