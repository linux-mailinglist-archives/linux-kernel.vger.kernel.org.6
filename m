Return-Path: <linux-kernel+bounces-530858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F5EA4395C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BCD167598
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39C525A2DB;
	Tue, 25 Feb 2025 09:24:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEF9214203
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475475; cv=none; b=M3QMmeThDJsbvkuWz0QIiBqZaAmfAQ1Ze46bQMJmNobbsCn5SE0jlqbPP28w3wPhVEGwf4WY6sKq2LbPGmM+PbJGnMHBC1eGDrh7a7/FVKNjkeaKdXmtuOM3QahwyjXoEOuGNLpDvGf0b6hNA3Oz2IIIcLozDzVaQjIxBJjE58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475475; c=relaxed/simple;
	bh=n2Qf5WYaFq5+lNRpuF5nb58Lk7LHfH+cqSlkKcUmzmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BqCR/TEBVgcfXADLAT0PDtnQ/7wny1WfkPAagbR7N8XBjWV1dzXJtW7h6tgpnwc4vkQNaQl7vLWqP/5f9aS7gn2yRkR6ZfB2QF7u8i1WNT8yAdLk7ZjI2S4Iv4Z8to4hHOnLe2GHxhI6fwPv+f56KqTrIdTSEE4eKFYH5S0pw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxeXFHjL1n9fmBAA--.26376S3;
	Tue, 25 Feb 2025 17:24:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxPcVEjL1nTrEnAA--.14425S2;
	Tue, 25 Feb 2025 17:24:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Select HAVE_VIRT_CPU_ACCOUNTING_GEN always
Date: Tue, 25 Feb 2025 17:24:20 +0800
Message-Id: <20250225092420.1599954-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPcVEjL1nTrEnAA--.14425S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Option HAVE_VIRT_CPU_ACCOUNTING_GEN is selected by default for 64bit
system in kconfig file arch/Kconfig. There is another selection in file
arch/loongarch/Kconfig if SMP is not selected, it brings out some
misunderstanding for non-SMP case. Here always select option
HAVE_VIRT_CPU_ACCOUNTING_GEN for future possible 32bit system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Select HAVE_VIRT_CPU_ACCOUNTING_GEN always for possible 32bit system.
---
 arch/loongarch/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27a852f..8d0885b165a2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -175,7 +175,7 @@ config LOONGARCH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select LOCK_MM_AND_FIND_VMA

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.39.3


