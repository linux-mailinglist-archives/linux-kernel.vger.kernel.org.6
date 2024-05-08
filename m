Return-Path: <linux-kernel+bounces-172624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F08BF481
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76E11C23446
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC7B666;
	Wed,  8 May 2024 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cyYxd4qc"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD22563
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135126; cv=none; b=QM4h3EQ+RWEom0QRQ1RyyQIHdTXmTcLTcXQbYh1cjuuROeYw9FY022M+1xNSO3Q35U7vsvk9DLzyjY3b6TCxEPUDIQbsEr8NDOLJ8PIBrpetS+DJoejz7ZKv5D2leuyUho32S551fnOulia1NxbiZktwz7xoz2Q1pM/7D4VfrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135126; c=relaxed/simple;
	bh=5tbyX3SwS8frmzkccOkqaaboGO9PBxBAh4KHyxVjCy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VoATPedW+s0x55pBPNpUDbf/NNnmCkC26m5kkTnO9wXFpPQJfMbFbrE1L06By+XlUe0yTaJ7YyxP4uGg6eTU1aTyPOdRIKu1PZ1aK1H9H1Hn/wEiICeFeSKl73t8dK541Eu/M09FWOq/mrhGXeoiUAyXk/h+pf9xU2lbmsXpqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cyYxd4qc; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4TOJO
	2TgucOnMCTJMIJIVkCaQ27EmlhBbO24n6BSyEY=; b=cyYxd4qczRY2DMXCTUuED
	DstPL1FZwcaLt35xBsPQC7/6FnUMjArlvGXj4TiXKOGPmuNmzO+g1nBVQWgxfUB0
	RZOHQqoKb+srWepZys0lXKmAczGABdk9l/tdXec5nzpWpfyF9ASAKJLbRmNoTvHe
	q71ghjvKTSKLMUlvOligqs=
Received: from yangzhang2020.localdomain (unknown [60.27.227.220])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3v+Nv4jpm+z+lDg--.23507S2;
	Wed, 08 May 2024 10:24:47 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: alexghiti@rivosinc.com
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH V3] riscv: set trap vector earlier
Date: Wed,  8 May 2024 10:24:45 +0800
Message-Id: <20240508022445.6131-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+Nv4jpm+z+lDg--.23507S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wr1DJFW3Kw1rWF4ktr4xZwb_yoW8Jr1kpr
	4fKw18CryFkrWxWa43AFsY939xt3WDXa1fWa98Cay5GFWDXa4fJ3s2qw4DWw1a9r4UC395
	tF12grySyw1UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdHUDUUUUU=
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiNwbX8mXAlHQD7QADs8

From: "yang.zhang" <yang.zhang@hexintek.com>

The exception vector of the booting hart is not set before enabling
the mmu and then still points to the value of the previous firmware,
typically _start. That makes it hard to debug setup_vm() when bad
things happen. So fix that by setting the exception vector earlier.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

---
V2 -> v3:
- Fix commit message

v1 -> v2:
- As Alex commented, remove the patch for supporting hugesize kernek image
- Add the omissive logic of set trap vector earlier
https://lore.kernel.org/lkml/20240506022239.6817-1-gaoshanliukou@163.com
---
 arch/riscv/kernel/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4236a69c35cb..03dc440e643e 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -300,6 +300,9 @@ SYM_CODE_START(_start_kernel)
 #else
 	mv a0, a1
 #endif /* CONFIG_BUILTIN_DTB */
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
-- 
2.25.1


