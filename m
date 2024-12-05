Return-Path: <linux-kernel+bounces-433747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756D09E5C83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EE82853AC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917CD225775;
	Thu,  5 Dec 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qcib04EA"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84448221477
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418355; cv=none; b=mS/+ufK/ynKy+FHlNI20+8s9sdnXOAUikwR5+b17LUSpzd1ygKRSsNdffo/kNEZApSkfhbrNX7JLJxSe3Gmo7LwGO+XQCNczPn8zX+4lfDbNFtqVXWkB83aOAgMBjDc/H5FiwaLSbXtmOUwS0W4YPL1MOaTf/Tw8VEzjapXL9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418355; c=relaxed/simple;
	bh=A6c4QABXiyL7inv/ysnldOUOjrdga7qDI+X9Cm5iwzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MVnbBlyPKDXRjLXhIgOVeUdAiMi8lacMEXE9qmMNRt5ODa/S1HoSr7VhVnooJ9O+sS38YuLlQ6huchpCWL4C//G0oIZivKQu7Bjw7fykljqvVscum+c1dYaokPv7Oa3fwlNrX5wJ9rN3jNuIRcOTm1+HCdqjiPeAglZXqFT35wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qcib04EA; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733418350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwsmvYHNmo6qtxFQ5P7SXeQn3VEcbQIjYoq50ZRaOUg=;
	b=Qcib04EAhlmqGZaoKdQnoAuNK5IFCIpZt2O6VvFV/1O+mI8YunnKtZPk2YVM/BlwU1WMh3
	V0mAh5HnZ04HOWyRN8KF4/MvjL6hL1CkwQGDUKZh/I26k5HLSfujjzaDM+18W7zN2h6yqM
	WnQEEytyqvn5OMcyZn8Kjk17MNKidxQ=
From: Hao Ge <hao.ge@linux.dev>
To: surenb@google.com,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v3] mm/alloc_tag: fix vm_module_tags_populate's KASAN poisoning logic
Date: Fri,  6 Dec 2024 01:05:28 +0800
Message-Id: <20241205170528.81000-1-hao.ge@linux.dev>
In-Reply-To: <43bf216e-18f7-680c-ae75-773b03c8dc00@linux.dev>
References: <43bf216e-18f7-680c-ae75-773b03c8dc00@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

After merge commit 233e89322cbe ("alloc_tag:
fix module allocation tags populated area calculation"),
We still encountered a KASAN bug.

This is because we have only actually performed
page allocation and address mapping here.
we need to unpoisoned portions of underlying memory.

Here is the log for KASAN:

[    5.041171][    T1] ==================================================================
[    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in move_module+0x2c0/0x708
[    5.042723][    T1] Write of size 240 at addr ffff80007e510000 by task systemd/1
[    5.043412][    T1]
[    5.043523][   T72] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:00:01.1/0000:02:001
[    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0-rc1+ #28
[    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[    5.046328][    T1] Call trace:
[    5.046670][    T1]  show_stack+0x20/0x38 (C)
[    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
[    5.047533][    T1]  print_address_description.constprop.0+0x58/0x358
[    5.048092][   T72] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Mouse [QEMU 0
[    5.048126][    T1]  print_report+0xb0/0x280
[    5.049682][    T1]  kasan_report+0xb8/0x108
[    5.050170][    T1]  kasan_check_range+0xe8/0x190
[    5.050685][    T1]  memcpy+0x58/0xa0
[    5.051135][    T1]  move_module+0x2c0/0x708
[    5.051586][    T1]  layout_and_allocate.constprop.0+0x308/0x5b8
[    5.052219][    T1]  load_module+0x134/0x16c8
[    5.052671][    T1]  init_module_from_file+0xdc/0x138
[    5.053193][    T1]  idempotent_init_module+0x344/0x600
[    5.053742][    T1]  __arm64_sys_finit_module+0xbc/0x150
[    5.054289][    T1]  invoke_syscall+0xd4/0x258
[    5.054749][    T1]  el0_svc_common.constprop.0+0xb4/0x240
[    5.055319][    T1]  do_el0_svc+0x48/0x68
[    5.055743][    T1]  el0_svc+0x40/0xe0
[    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
[    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0

Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated area calculation")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v3: Based on Suren's suggestion, I modified the code,Thank you for Suren.
    I realized that the 'poisoned' is actually not needed, so I removed it
    Due to these changes, update the commit message.

v2: Add comments to kasan_unpoison_vmalloc like other places.

commit 233e89322cbe ("alloc_tag: fix module allocation
tags populated area calculation") is currently in the
mm-hotfixes-unstable branch, so this patch is
developed based on the mm-hotfixes-unstable branch.
---
 lib/alloc_tag.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 4ee6caa6d2da..f942408b53ef 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -424,6 +424,15 @@ static int vm_module_tags_populate(void)
 		vm_module_tags->nr_pages += nr;
 	}
 
+	/*
+	 * Mark the pages as accessible, now that they are mapped.
+	 * With hardware tag-based KASAN, marking is skipped for
+	 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
+	 */
+	kasan_unpoison_vmalloc((void *)module_tags.start_addr,
+				new_end - module_tags.start_addr,
+				KASAN_VMALLOC_PROT_NORMAL);
+
 	return 0;
 }
 
-- 
2.25.1


