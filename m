Return-Path: <linux-kernel+bounces-202287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8BF8FCABE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2333BB21D03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B66621C183;
	Wed,  5 Jun 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P49tYTr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E814D435
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587727; cv=none; b=QmoQd7aap5e+9XyBGD1sDQdLlafIF4mpzQL1SXQsygzVNzC4AXDcb6uUbFwVApW3PbbUONXzENWLfKehZeQiyJNrqr9o8VvWY+kK2EcCiqiVWnwrPAYGsQSWzG6kMwOfC1tXrvyKzs/jwvl9bPRDuESZw3I/KqZITqJCSFEofgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587727; c=relaxed/simple;
	bh=cXaL8X5xkqjru4qZvhtnJBNQd1jrCsGud/RraJezK+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+wDtC8nUsOoW1BdIMTtOEvPDHYwQpdNyVt+i7lvvzRs1Z14EYlj7Leq8waK+N/2kUE2P/u2lw7430ScuWAhEpTFi+vqf64vPgtspdwJaARgbZdrBWT5bzY8OkvZsjumhPryo9DYMlkNo1fIv21RoL8xr4nJJ3R7povJW0o3+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P49tYTr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C49EC3277B;
	Wed,  5 Jun 2024 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587727;
	bh=cXaL8X5xkqjru4qZvhtnJBNQd1jrCsGud/RraJezK+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P49tYTr8ENggo5fZvyKqZ4PxM1peSbHLq3cEfJefvxO26qq3VgrbD44w7SPHT1HkT
	 yLZk4KJTmkXb4xi7nmVa9vtoQcspd+KSp86VRVE/N0ToZjrv8UmR3sqged4GllPn5h
	 5GvPvVSfGAeMGH24F5yZwuJ5PcsphzNqUIcASKCOtwEetL+b7w0teYBp/8DvVDy4KI
	 evrzh5rO0PqNeq9Kf+oHWL+Lp3xUwlwdEzkfvR/QO6nuFAWCLeW2D2MUCFok7kI/s0
	 /y+gLAedifYQI5N+imnHHGNoDFCQrHDR/jrIIAKKecSFW6RBDuu4j+4/Tyl4w1ABwV
	 fsHibJ697J1KA==
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
Subject: [PATCH v4 11/11] riscv: Enable DAX VMEMMAP optimization
Date: Wed,  5 Jun 2024 13:40:54 +0200
Message-ID: <20240605114100.315918-12-bjorn@kernel.org>
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

Now that DAX is usable, enable the DAX VMEMMAP optimization as well.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8a49b5f4c017..1631bf568158 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -73,6 +73,7 @@ config RISCV
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
+	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
-- 
2.43.0


