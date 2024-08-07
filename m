Return-Path: <linux-kernel+bounces-277596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A594A37D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D07DB22391
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34EA1CCB57;
	Wed,  7 Aug 2024 08:59:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A01C9ED8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021154; cv=none; b=VbG9Qb2HY5qkyDWyoZ6Wy/kUREk1t4fBnRyNASuA8QUBSNH5xxEaNjjAGISJ9eZHqV6P5x2gUTf42S2STb29Bo9Ee2mc2SDQUJRLqlGCRKp5GF3RlInZrQa3xM5wHnZNtni9pUGl38F7u7mQEn540rCOmoXvNVNPC7QApTIng3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021154; c=relaxed/simple;
	bh=4UqoD2C8ejEzeLdGcdsKe4S3vgLCd94uWhSCWSnLiTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3JvaRH71K8cCRiL9lL6PNGbDbPPiXcfpVSLuRvm4CzFXEqp0C6C2rRPBNetJkKgFUA0ocRo2iQavTSlYDSDwwaUCnvojIVxQejz6ZhvO4UDtGMWStIFD5DUPMsIRdOuHpRmafdEaSplmyPIJsZhS2m3EWvZ7hT7Pti8oGwIrTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxjptfN7Nm2y8KAA--.5490S3;
	Wed, 07 Aug 2024 16:59:11 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxvmdaN7NmO8EHAA--.24061S6;
	Wed, 07 Aug 2024 16:59:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] LoongArch: Enable objtool for Clang
Date: Wed,  7 Aug 2024 16:59:06 +0800
Message-ID: <20240807085906.27397-5-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240807085906.27397-1-yangtiezhu@loongson.cn>
References: <20240807085906.27397-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxvmdaN7NmO8EHAA--.24061S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruFyrtw47AFyUuF48tr48Zrc_yoW3Zwb_W3
	W2v3WkWF1rA3y2v34qvr4FgF13Za1vkF45CFZ2vr4rWr90vwn8Jr4UJw18Zrn2gw4jgFWr
	GrW8tr9Ykr10kosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

For now, it can enable objtool for Clang, just remove !CC_IS_CLANG
for HAVE_OBJTOOL in arch/loongarch/Kconfig.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e1b6cb306d4d..c53f8953d46c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -146,7 +146,7 @@ config LOONGARCH
 	select HAVE_LIVEPATCH
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
-	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB && !CC_IS_CLANG
+	select HAVE_OBJTOOL if AS_HAS_EXPLICIT_RELOCS && AS_HAS_THIN_ADD_SUB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
-- 
2.42.0


