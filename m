Return-Path: <linux-kernel+bounces-184903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B048CAD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A9A283091
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D1487BC;
	Tue, 21 May 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QP7xHTIr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F547A74
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292152; cv=none; b=fSRbJNjZMjdBRu05Ggq1tAowdiU5vJQrseQOPfoAuCu3n/zg/MSMkbrAzpgAXdrZSsoDd7GH6gGdUDRtHn6VDgXdyCwXmBF2G2vhDKmiIx9WvVgJ98TZ4c3gqKVKz3cenyYoFXD4YufUCplLcHibc0QWkic3rq4BXja5nKlS9Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292152; c=relaxed/simple;
	bh=zdSV3EpJ/CKXjaWQ8/cD0+JOT+VH5rhvpIEde4YPaWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI2JSIm+aronf0LB6G2SqFg3rPxv0Wyi3kre5rMfMQzZpeg2sJgP860LDjbjMb7WOAo7Ki0RidR/o7KoCRoTNTks2gDpOv+WENPJ3CqzUVabZD9tm50wKVur1E66pa1QVOvD0lQTbI4Vut4h+Jqz41UnBevyJ3uIgCXebjLD16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QP7xHTIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C0EC4AF09;
	Tue, 21 May 2024 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292151;
	bh=zdSV3EpJ/CKXjaWQ8/cD0+JOT+VH5rhvpIEde4YPaWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QP7xHTIroKWAL1koAwZ6jjCgJLvRHG023RGth9xuUk2aAr6xVwWVLbscARU+Pv1ub
	 rE7DpLmED0b0CVDykMK6Zx+Q7jnCMVy2PLYf754MVZMJIdV0GVpwGIlm3I3gUCQ0Q6
	 2H95BXA0It8CFEHUA2Cu/eAEMYUpIeaDtiemAskbUWoLdUlQdP1W1YSYtVV7ha1mAp
	 T00CEcLQ7pEpSb3jAdqZceJbTnCXDIJ0KCDyF2nAHBRoyXITau6AkUfMqaNoMFbKQN
	 QACCVo7OV9T3gy3HBJuXXKgSubA2i3XC1J2EvODkvPbaXRZ/G6/pdAH3MvgRE1voV6
	 WqhaCAyjmm6LQ==
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
Subject: [PATCH v3 6/9] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Tue, 21 May 2024 13:48:27 +0200
Message-Id: <20240521114830.841660-7-bjorn@kernel.org>
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
2.40.1


