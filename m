Return-Path: <linux-kernel+bounces-178785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB198C57A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A178B2258E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7E1474D9;
	Tue, 14 May 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0t8ZY/k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED40145340
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695531; cv=none; b=SjfwkgelxU0suxkL1/5MVmGVUElwxkEux32cH/BngGZU2e/s+NDBGkjPGkT0biYw5T6XefUei9nlzWASWRXUAyRq1boXZza4saS0JSfljV+DDcmVl2+pZJSw01FVudil3/1KkDFvtEX4Krqv36f3XgNHW0JMafH1LleIJKHY+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695531; c=relaxed/simple;
	bh=0+IP68HpeOuix87ttHx6QCBPaROV37lTjVVbI88agM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpAV/aMnGMm+WG5rlGL7Nosbt7MIUSXbt3Xvu8IXjSx19+t7WKlWoO9P+hUVyM+gMbDJEmyhbF9P1Gh8lNYonFbtCQM/F6f2SU6Euhb6WCvvTKI1lIxCO49dlQJnU9uy2ZodXj4lV+F0HZJYgov96hhGwBmT6k38tDtYFD3oEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0t8ZY/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D16C32781;
	Tue, 14 May 2024 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695531;
	bh=0+IP68HpeOuix87ttHx6QCBPaROV37lTjVVbI88agM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0t8ZY/krMImQEE1pbX37Lqd9otojKaCNU52Jdf+6IsnQPuwbjYf/17i4Dfm9wU/N
	 cG8ZVIKuEChYfl+ArN6nlpcBLN94ethBeWZaRLHF2O26wOR/YjsM4iypPJlep2EOIs
	 WnQduiMtRTX6HihYJYNGu+Zvx4ZfY6kifpj7mrb3c0qzOXrMObRZ+pyv1Di+53Y4BR
	 yVzogJGugSULHDBgRoPYVq0AQf3NMvV11V+DCtVicxdz9nCIPrBc3BZjkQibvEOlkP
	 LsDeyAlUKQ2u6jbtG/qyTzE50IDMatmyZSG5pDBfnCFVFZOhVoq3W+Su/3lVcXaMJx
	 OvCy8N0USQs3Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 6/8] riscv: Enable memory hotplugging for RISC-V
Date: Tue, 14 May 2024 16:04:44 +0200
Message-Id: <20240514140446.538622-7-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240514140446.538622-1-bjorn@kernel.org>
References: <20240514140446.538622-1-bjorn@kernel.org>
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
index 6bec1bce6586..b9398b64bb69 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,8 @@ config RISCV
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
+	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && 64BIT && MMU
+	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
-- 
2.40.1


