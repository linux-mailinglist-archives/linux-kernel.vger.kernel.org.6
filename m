Return-Path: <linux-kernel+bounces-202282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41DF8FCAB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E8B2873DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E0195FC5;
	Wed,  5 Jun 2024 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="actIwcGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59904194A74
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587708; cv=none; b=cI2GaU8JqPjcd++XNq6hUYGYIKROQuDYRgCkFuSxclwL7J1zkE57iI54IKaeDkk1HZmiZ2xU7bWazBljrn5WYJteqfZ6fJE2117+JrMmdT+JeorPzRViQceyExKdfz4RrmyXPqr4qNvMEdNftVIBzZ0QwV6v7+L7pwsfJ9zo5wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587708; c=relaxed/simple;
	bh=tu3HoOPPrk12D/HHChqAMB+6RlcJ+H95I8FoF9tFiiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGwO1gmz6TyswVEKG1xfHnG/fO34dTnWfkSh2n4GvD3y3jXBraCKPqjQZPI+J5QqKIYTZ9tRPaPFTOE6WZBr2k5P1mnaJHlUI+D4mAnw6Ed3daR8Lwv7ZUfK+J/Sxj+5vIz02u+mKarC25kVmwiiqR1WDt1TPjEcW6FGMwp0WyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=actIwcGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA0FC32786;
	Wed,  5 Jun 2024 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717587708;
	bh=tu3HoOPPrk12D/HHChqAMB+6RlcJ+H95I8FoF9tFiiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=actIwcGKL7lMw7iHm/kYeLU0Im0MKA4ATYjc0eCD0iqFPQA3+RyZqVf1nydSeSUj0
	 gF9ZhAi8Cz89TfrWUuVf9dhYSzuUycsqYPT4dufEA7HfktKoCVWT5gVywjFH44bLxq
	 FNTCqSW9+FkXOpJ/wxpC8P41lR4dMjOqX+wX6c6+uyD4sHqI51jkPKWdIKeosTC0K2
	 WSBy6vQk9sC3vPE9M08ir3qL9i3FzdGxn8iAQdWQ8EjWNitOO9u8IfVkxzec9k0tt9
	 kNzLKT3wBJLZ8wQiEitzX09XtnmJ30P5wj/gY3ges2Va9UAhUDJXEgw+464CKsyQPH
	 ZFrpv32CPOuLg==
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
Subject: [PATCH v4 07/11] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed,  5 Jun 2024 13:40:50 +0200
Message-ID: <20240605114100.315918-8-bjorn@kernel.org>
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

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 1289cc6d3700..9d5f657a251b 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,6 +6,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -370,7 +371,9 @@ bool ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
+	get_online_mems();
 	ptdump_walk(m, m->private);
+	put_online_mems();
 
 	return 0;
 }
-- 
2.43.0


