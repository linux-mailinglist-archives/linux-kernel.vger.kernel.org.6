Return-Path: <linux-kernel+bounces-202283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1668FCAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606281F2197E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175B19307A;
	Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nB+tpFCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E1193078
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587713; cv=none; b=u7sq86NVxFjRB4G/2vwIDl28zK1xO+sIE4UksPSu5JEwj4fk8pBkkrUmiD1oz1e+OIEw2mfW/i3ibMJPTGaNLxVsNEhpZejt52leYHeerQRE3hWeEp9hpnsuFmn1YAC9CwaVNOqA6WNJpiXd5FDGZArlBDvqR6cNT5R1wlA4GdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587713; c=relaxed/simple;
	bh=L6J14KqpfXLFzLpqo0wTWwklGSKZlK82ek5ghR0epQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJwKQwst7/dqYSLWSnxMU+iFUstIC5vkYCrTHbnD0hAfu+P79HZv6o5pnGhe4ghyW9j/D0XBW51FzX6FUbS6WjdoGSvVwmMtaWfJ8nuwdVQk7Ey6D3cTEOiSrxqJfhfPS0whXaWGw28QqKgbbkO1aTFGBCNVU5XvMu80VSA66wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nB+tpFCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B2C4AF09;
	Wed,  5 Jun 2024 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587713;
	bh=L6J14KqpfXLFzLpqo0wTWwklGSKZlK82ek5ghR0epQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nB+tpFCKWoin2Io1tYNh/CpS+b2KOE96Igf2M+PajeAiqjcAwFpQdkIQ1roxi2gFS
	 ybrJ6R3VNsPGfwYETuovRb8MmTUuzJYXMZkdk5PkklSmzl/mvUssCtdc8sq6Nn+608
	 Msnb1PAycmOOBfXZz9FDQCndMLunP+YGOi1F1+qIlP3WKOUwv5u+jFCiovPNw7bR/f
	 mDZYBsTyIzCYUGva5g5QSNHBpM7IOMr7msMbj2JmcxdV3QiHfU6VxtsKG0bPV/tDWi
	 hYQBxxJxkhebALDI+e5GZRgBFT6W8RxUwONIgOVjjb2cDwx5omNGuOKTPYICI4q2OY
	 63QpUaPxQzQfw==
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
Subject: [PATCH v4 08/11] riscv: Enable memory hotplugging for RISC-V
Date: Wed,  5 Jun 2024 13:40:51 +0200
Message-ID: <20240605114100.315918-9-bjorn@kernel.org>
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

Enable ARCH_ENABLE_MEMORY_HOTPLUG and ARCH_ENABLE_MEMORY_HOTREMOVE for
RISC-V.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..8d860ad3b171 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
@@ -46,6 +48,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
+	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
-- 
2.43.0


