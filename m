Return-Path: <linux-kernel+bounces-202275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021888FCAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945AA1F24561
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A61A193081;
	Wed,  5 Jun 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1Ioy0ma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF63719307A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587679; cv=none; b=G81YTPuXWklTGeFiJCLL++lYF/xiDuOejS9EYOCRER+F3gG+07bk1/X8izd10Wlf3xuaHXqV3pMhqMmyWIMimO8BWV/wOQ5MBqH+vYF5bSoO/zm96yE0kFLbtaMQ6IHMh5jwaOo0ZdlUArnTSOIPCLvnQ4E9P0pHAvJytuoD4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587679; c=relaxed/simple;
	bh=DeWhhyy/Pd+ZMACSRHJGzJta3bvo66kmrO80PItBsh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD1GM3XByXneqRosEaZhTscxZQ5Ii7C0SKLc9x6kO7sly3h7hw4LWAcrwi1+kkFPc/aRavbCR4sOZUX1sRrmzzgipdx1ER62f2mda53jQHt09lNl4Ok9UnAh711S9WiafLRD5r9RYZ6H0wiuFb7B33y75R/efAvmMQkh6VGCfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1Ioy0ma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3803C32781;
	Wed,  5 Jun 2024 11:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587679;
	bh=DeWhhyy/Pd+ZMACSRHJGzJta3bvo66kmrO80PItBsh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1Ioy0maA5AwRckov58PI1dPUHyyGGgTWfzppxKvOJ5vKG4OYfFjGk9LswC/lA67g
	 AiIlfX+S+u9KX+idcOdeOFgkILKcjRmMy3P2mRnigjBzo6o8YhsVcdGLtPS1U5tG25
	 tAl6eEfOl+uJ0lnDHnB9krao18oZMsRfj3bVMcQ8Hhec/AU5okt/9ANWoqlsbg/v9B
	 6XAEJYTzUpZ4AMmjN82aSGoJ09nWwo5+Iq8Uc98aESGuk1kqIDdE25dT0Ew5lBYyMI
	 tbHq6/DNAi6bsnOYdF3D68Me1apb1caKmDIAUghJSJNQu3/1DH/vbtfVidTyA9KTpx
	 4/ZFTWv4bC1MQ==
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
Subject: [PATCH v4 01/11] riscv: mm: Properly forward vmemmap_populate() altmap parameter
Date: Wed,  5 Jun 2024 13:40:44 +0200
Message-ID: <20240605114100.315918-2-bjorn@kernel.org>
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

Make sure that the altmap parameter is properly passed on to
vmemmap_populate_hugepages().

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e3405e4b99af..fe5072f66c8c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1439,7 +1439,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif
 
-- 
2.43.0


