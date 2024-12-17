Return-Path: <linux-kernel+bounces-448771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343F9F4545
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80176169557
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE31DA313;
	Tue, 17 Dec 2024 07:39:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874421D5179
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421168; cv=none; b=UkejVjAFCuIE29RHbcyJ22q/bV+xeiqVaykw5svTwcTOhnqMfbuD2Y+18Nxg6apzPajdE8VW/NR4+QOxUwI/YPeTa2HPVHF4t7U5MkBr+57TPuez5hAh6q/Q3TroKsHlfZEcPDG8Zl7K1+pEnncEWMf3S5LdIz8zMxlCfpWRXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421168; c=relaxed/simple;
	bh=FF0k0pW14USJyXZVa625InLmts54SM6uhXD/5HffYxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oT4Eqf8ycMQ4qyC/LMOWR04QFIzxqggKhtP9WR36RVwkrmGk5txp6SEtcMqFYv+6Ed89K/iEfm8XkO7TyLGYHuMHVtJlMqJJKp5fc1WmFkqC4dQJi2pr7W7rOQv7XMlav+Q/31/Lebip3wdwrl4E2Zga1fkYmY/HPmtYUCs4+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.7])
	by gateway (Coremail) with SMTP id _____8DxQK+sKmFn5bFXAA--.16143S3;
	Tue, 17 Dec 2024 15:39:24 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.7])
	by front1 (Coremail) with SMTP id qMiowMAxz8eoKmFn0gUAAA--.24S2;
	Tue, 17 Dec 2024 15:39:22 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add pgprot_nx() implementation
Date: Tue, 17 Dec 2024 15:39:08 +0800
Message-ID: <20241217073908.3347287-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxz8eoKmFn0gUAAA--.24S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFy3trWxuFy7ZFW5tF1xtFc_yoWDAFX_A3
	W7Xaykuw48Ja9rAw1ayF93Jr13Gw48C3ZYqF1ktw47tw1qqws8GFy7W3y3Zr4a9FZ7Zrs0
	9rs5tw4rCF13tosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Commit cca98e9f8b5ebcd964 ("mm: enforce that vmap can't map pages
executable") enforces the W^X protection by not allowing remapping
existing pages as executable. Add LoongArch bits so that LoongArch
can benefit the same protection.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/pgtable-bits.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 82cd3a9f094b..45bfc65a0c9f 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -96,6 +96,13 @@
 
 #define _PAGE_IOREMAP		pgprot_val(PAGE_KERNEL_SUC)
 
+#define pgprot_nx pgprot_nx
+
+static inline pgprot_t pgprot_nx(pgprot_t _prot)
+{
+	return __pgprot(pgprot_val(_prot) | _PAGE_NO_EXEC);
+}
+
 #define pgprot_noncached pgprot_noncached
 
 static inline pgprot_t pgprot_noncached(pgprot_t _prot)
-- 
2.43.5


