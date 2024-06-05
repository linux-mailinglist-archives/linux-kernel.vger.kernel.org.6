Return-Path: <linux-kernel+bounces-202279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479D8FCAAB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2DFAB23853
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAE19307B;
	Wed,  5 Jun 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yo0tPcOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6319307C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587699; cv=none; b=TUFASt/vQFb/ClwqwWGlZK3ywV07NjeaWVqnMJtG5WR3/eH49nhsQ0xVrURMDsKVLF8YEx/NgxTeDTfTlqrgvNePdCfeEnvTA8kFDLAGtlPAgGKat1i4nMdOvp0yM8KFZs/2V4NDcxd6eVi5WJpVCPhQsqY7F3+OrLz9zBjiLK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587699; c=relaxed/simple;
	bh=JhdeFloFX/xxhqkxVxMkwy3o8a+I7NU1Jr3K3J+2XHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3ZcO//gtwZ3OF5zyK46ilN36j7mzj6Cde6KRCeKUCl58GS6F4U9VupeyLR3lbD6eXMlBDB8YsHsNDlCsYEj1+K6BKHV3SzZc6421TsXKl/0HKpBkf+SAHMSjdXPpbbEYMzF+F5jQnjokymLYztTfX8AAevc86ihIhUI0fRCGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yo0tPcOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA3C3277B;
	Wed,  5 Jun 2024 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587698;
	bh=JhdeFloFX/xxhqkxVxMkwy3o8a+I7NU1Jr3K3J+2XHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yo0tPcOUDWbZKgAZCcnplN/Tpng+rYhahCirtGosu22vfbqUpPcHwDQA6k6SFhOAV
	 ZJqZbW2Hub+7wW8blIcchz+3RvICwE2f/9Ybv7CyKA+D07H53Ebb5i0DPEtvRVmP7+
	 +UJZgr4Sp39itexUAPNROpGAAJDUgk4oCvOQX909f0SpiDFFPHsojDG2bl1yDM6WIT
	 1SeA46LAIXR14O9bfozUPdydSqNyrw8nINXW38klf+p8XKmw4BCQ/CsmeOD9GOvQFi
	 hvRgm5Ntqz+0/jK4n1J/g/BIAKDgmEOtQ2+tEApA0MTtkbTxYZ4HxLyqMrMU4Yz12A
	 PHsFFb2fJFJpQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v4 05/11] riscv: mm: Add pfn_to_kaddr() implementation
Date: Wed,  5 Jun 2024 13:40:48 +0200
Message-ID: <20240605114100.315918-6-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114100.315918-1-bjorn@kernel.org>
References: <20240605114100.315918-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The pfn_to_kaddr() function is used by KASAN's memory hotplugging
path. Add the missing function to the RISC-V port, so that it can be
built with MHP and CONFIG_KASAN.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/include/asm/page.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 115ac98b8d72..235fd45d998d 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -188,6 +188,11 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 
 unsigned long kaslr_offset(void);
 
+static __always_inline void *pfn_to_kaddr(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #define virt_addr_valid(vaddr)	({						\
-- 
2.43.0


