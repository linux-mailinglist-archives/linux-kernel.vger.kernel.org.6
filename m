Return-Path: <linux-kernel+bounces-576590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42926A71178
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF383B6797
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E319D892;
	Wed, 26 Mar 2025 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Tr/3aKcQ"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AA19CC28
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742974546; cv=none; b=HcAN3/LIa/OjjA+iYER1635mopO6iOanEMOpOLyc7OMC5fPPHme/c5OaUPy2K8xeGF9YY0oPXY9YKuV0Hhl8F6sMJMqDQ4KiJd9MHQAgDi/pc1qFl3D7nW1804ElD/92uLbLlCC6P0GR3+iGf2FXKIG1chPlCexZJ0QbGJW+hjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742974546; c=relaxed/simple;
	bh=8N7TAnjHhbKKV3hx15Gcf+pRqRaCeWje8X3aqvBWj0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwWXgOB9D7k52Udw+JZDK+jpG1ZsAl1nK/is5rekogL5X+zZ7RAF+u2io9LvtJCIQdnxjos9d0pRBdo9AQx0m4jaG+3RKpxTcxhINQUmhodU4WmewkMLycjizhjRma1cRReSMie6E/qVhhDCKB0AXFKbvTbJLP2/lRUKuqRjbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Tr/3aKcQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4C65F259E3;
	Wed, 26 Mar 2025 08:35:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cd6IB-_Ad6AY; Wed, 26 Mar 2025 08:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1742974540; bh=8N7TAnjHhbKKV3hx15Gcf+pRqRaCeWje8X3aqvBWj0E=;
	h=From:To:Cc:Subject:Date;
	b=Tr/3aKcQ+8CotaUqVINbH7EOqQDZhkNXJiE+n1Sj2dx2Ec8bEY0b7i4wr5+J2KxjP
	 ziT3cs+zBIRqLYoeCCTZynbflqX3QvZcYFzavAURptAug+YejH40kxrcgz0ne5K8JU
	 N4/AMevpQPUKDsqRURH8dX5SrY8rwJWbMjdOZGxSC1JrGhCH4Eq+gz4y9v2plzkyAK
	 0tsB3ubi+1ZqsFNCbh0ISe0hIRNfXblrqvF71P+4/ACOABCCzyw3kil8GKDfiHyqrO
	 wvUjLVQKIkF82EjpqYpjtp50V3XI4NqK5FEKUFNiY2kjhOUJa9mXuRY1aTNiqhK0c9
	 T054nxgv6CxlA==
From: Yao Zi <ziyao@disroot.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ying Sun <sunying@isrc.iscas.ac.cn>,
	Arnd Bergmann <arnd@arndb.de>,
	Yao Zi <ziyao@disroot.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Li Zhengyu <lizhengyu3@huawei.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv/kexec_file: Fix comment in purgatory relocator
Date: Wed, 26 Mar 2025 07:34:51 +0000
Message-ID: <20250326073450.57648-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently sec_base doesn't mean relocated symbol value, which seems a
copy-pasting error in the comment. Assigned with the address of section
indexed by sym->st_shndx, it should represent base address of the
relevant section. Let's fix the comment to avoid possible confusion.

Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/kernel/elf_kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
index 3c37661801f9..9b8ff87630f6 100644
--- a/arch/riscv/kernel/elf_kexec.c
+++ b/arch/riscv/kernel/elf_kexec.c
@@ -390,7 +390,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		const Elf_Sym *sym;	/* symbol to relocate */
 		unsigned long addr;	/* final location after relocation */
 		unsigned long val;	/* relocated symbol value */
-		unsigned long sec_base;	/* relocated symbol value */
+		unsigned long sec_base;	/* relocated section base address */
 		void *loc;		/* tmp location to modify */
 
 		sym = (void *)pi->ehdr + symtab->sh_offset;
-- 
2.49.0


