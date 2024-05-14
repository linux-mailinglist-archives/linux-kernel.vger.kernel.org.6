Return-Path: <linux-kernel+bounces-178784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367F18C579F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD51C22371
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68714146D7E;
	Tue, 14 May 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnRBLrwi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11EA145322
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695526; cv=none; b=YkFM7AL93+T8xDzQnfbP2mCs4Co8vylxibV820iD7+cyUie7o5+QaRp102ztrTSVOeIgmwSF1sBHcGjEXGyy2HLjpte0qfxW3GVb7MVi1eN+lO7dIPgYpazSXWuAf7MVTiLEuKWFCa2H1vMn5kX6wVKp9zSG95WyeUVPjLCbbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695526; c=relaxed/simple;
	bh=KbKqzNvXWA/Za9nd3AYnat1xf+LOO0b3PgRZV0HvyKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCxAQBXHYzI9PJzNORWjYQ3w7+ZJoRroNT0s7kkP0jFWj8gcim3EAw6V3xfW65I4TsukivRDsVw+XTEZrCqkZzLwl/bV7bPkBkwRMF1TH7ssRAzmE5sTTygTuLfuSEyW2epNVaPCh4CbtIyAEYcFnVvIFrSrXzirI9DbLYaLD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnRBLrwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3894C32781;
	Tue, 14 May 2024 14:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715695526;
	bh=KbKqzNvXWA/Za9nd3AYnat1xf+LOO0b3PgRZV0HvyKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnRBLrwiGydV55YKVxP1C2hTU/+iQo4dd8w0faa4jtVHR4jHZ5anUbKb5yZ5ye3XS
	 ys1kla9pYrDzdZbLunoTrtdPNqqAUbKtu1CJ//68MFbQyh5y7aZhC46YK55JtaUZA5
	 ra5G2sERmBqf/UFx2SPaMVXfoiGS2kPxfZFkZNOUlVD19QOqS/SUV5MZU/mFGOVgDv
	 IXn6OG9dtirrJO/Dh3vnNlqnjzdI4qDmljqWq0kBU+c0CiDbOdoWE/pFltLXqLokVT
	 r19LtiBw6rEEkbg+nNadg08rNjWgfdZZVOpJ69iuykQqloruiT2sEewRtB7kCuWmPz
	 qDl5PWv830HDA==
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
Subject: [PATCH v2 5/8] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Tue, 14 May 2024 16:04:43 +0200
Message-Id: <20240514140446.538622-6-bjorn@kernel.org>
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

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

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
2.40.1


