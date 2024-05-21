Return-Path: <linux-kernel+bounces-184904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CC8CAD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200C01F234E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB207B3FE;
	Tue, 21 May 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEzghIrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E717B3E1
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292156; cv=none; b=m5qH6BR1ih1Xd3OX/ujvGA9C2L4ASw7XX39EfHZWklYbuqPhmkPaq9Cg9pqGevIBj7KO2p+a2suC+gFZt9a1zESMY8xjkgZg/Hwjku7LMCH727Mz4BWNp2rNwFXMVpzcJxZuTY9xvmhPPrBkMAIYDokwA/fLVeNOxmgKcOdOXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292156; c=relaxed/simple;
	bh=i0Ih+w27uGb8ApwJcyy8K/wXBEe5AomGLiW94Z7779U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPkL0gn2F2hqPELW2sTHqbpFwfT66i/q4cRzOuFlfTk+aJRID66k+eDnpaEXCj2ak0jAmLeeq6crZF0sJgJHr/O7p3wTOvKnAWrJOn+LeeOZgGsG+hJW7T343v6SsDcPLWDxxNKowBm8wvNFzPB9bnXSkOwz9RSgvZwQL4iOnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEzghIrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3296AC4AF0E;
	Tue, 21 May 2024 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292155;
	bh=i0Ih+w27uGb8ApwJcyy8K/wXBEe5AomGLiW94Z7779U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEzghIrA4Xj8E+KJcv5rV4Fg3OTCWpAUwdbjYoPWT7gVOSRV6SQWe8m/tqWm/Z9j5
	 LOq8iVVDdA9rPeFRqn06kyALX/Y+uzSJpXu3xND6BGYItuRbp/7eyMzvWoJ0sru44g
	 x4d1w6d0UF1SDAapeQK/4zR5j4SC+2FuKlwzMgObcR/47F8hL81htaSV4Rnu0ZDg4e
	 fEo46pfirWJf5acsZojEOXkrupLGS8O0Hsh4ukXb9lgUJXlztR8hWESUBNwCG8lIb8
	 KgEaYeUmtF8QkqoLyQKmF8kJUAICzjbt8epkz2evCCZ1IFxRnNAHVmemOu17uDk2yJ
	 LmoRZmxGAxPhQ==
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
Subject: [PATCH v3 7/9] riscv: Enable memory hotplugging for RISC-V
Date: Tue, 21 May 2024 13:48:28 +0200
Message-Id: <20240521114830.841660-8-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
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

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fe5281398543..2724dc2af29f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM_VMEMMAP && 64BIT && MMU
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
-- 
2.40.1


