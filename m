Return-Path: <linux-kernel+bounces-210189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9681990409A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6F1F24BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7BF3D966;
	Tue, 11 Jun 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/bexRTm"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF23BBFB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121329; cv=none; b=QEDMCjM2v8mHQKTT85NaLJSZN1OWN30CALZJw8guMgv2Vdz2kw9ZVTM5dtIvLvHCsYiBL6RZwRughsDCoN/h0DGLy9TCrjvM7JQN/VmsqcHWgaEfTQsCYajreWQFJ8IKbgGMcgwbP9GdSW5yL5eXNAiVRWc+jDDan1Gaw/9HnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121329; c=relaxed/simple;
	bh=/l/lGVzyJia5S8Qob5oQWTcV7qMYZ+3qrzD8xKpFipI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grmKfVIbgR4j+TjETgWa4nIFxbdiGtm+JMWmNVJ3YtkIEN9UiJ0Er6bRqdBZl+r9aArWQLJfhlRbUJIZss9HDEgkBXJL2QQtHotBc9eRZoXC8Vr8dRBDtbk/R1PqljmUPw7Uh1E8488G2WdaF18WiivWTcmfaMruA/MKhuoMJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/bexRTm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7046211e455so1854400b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718121327; x=1718726127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6/yKIT3D21cjP1dIHfaMNqAEhb07pPSEccrWwTAbps=;
        b=N/bexRTm+KP6jiRkObFjs5j1SQ5JTWMoLWBS+t1BqLleXciIWezCX0jxk+sh2+VNq9
         WaPuyBqLoKOKR4jDKn49BsZPpVe+pXkDZDvwGEbxQrKDXvyFUOLXTUDaN39gsRrOn0hQ
         ae/n+cTUKVJGJG33zeX0mkXWHFU5RJfB85d7PGLSS8fc1tNNRHRKs4qgvyrhNcEkv6XD
         1ob4G/TPn3eEoxOc1Onb2lWJNd+SYJxMXnlGUKaP84IC9f814flqS5vr0uBcPmQxvYUn
         npaxCgpM0Q2C0paqNDyO6Ho+EYnLuHbNiyIywsuqSeZr9Jyd2sa0+bwxRJ4Ejz6quKe2
         GCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121327; x=1718726127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6/yKIT3D21cjP1dIHfaMNqAEhb07pPSEccrWwTAbps=;
        b=s0zlww/RwL38ZK6Kc1KFYbzIB+cBEr86/wi5Ubw+HxBM5wZMRb7ePusOno5YSjybq7
         vsId9OCiGcqhfl0LMzI3ZfjO18AlZ/MtvH4oWTCvcLaPDwXCYSLDrLB3vl9oAedwk49M
         KMo/dY6YSTeDq9YOPBeHLKe+dtvG2U3+dGlxZO64oAHq8+oVdQ1IQWoZjM23iiy44/42
         4ZsFHSxSVOu1u8VJ7FZS335rw5mPv2JfzzotA73H99KjwWeyMzMhO44/ibbNflo3r6Ys
         UB0jhWKkhzProVIcI2h2dMHXkHhBebMRGyiKaNDrF0+otWymBuH8kazQWp60OVn7R5xQ
         +QBg==
X-Forwarded-Encrypted: i=1; AJvYcCUakPKJo+dUtkhyQMGmV0m7KqUx0fi56Ip+sTlyBqAJXoAb9zfx8SpbOB5JqfgFYI3N0wuiJJiawBcgMyP38+Y61ZBj75QG0Wc7PhnA
X-Gm-Message-State: AOJu0YyfTEhewITEus2xMzeE17eoH8eSoOiTSER5Uxmn3tW96GqQvlbf
	yJPTb38x7cmOoSBW1W4ZElCWQip2o8af4jg9bTYhaHDzbhTfAOJa+zmyWHxN
X-Google-Smtp-Source: AGHT+IFaMPlZhD6/hccIGceajjpUYUXgpkdw77IRhd3SIwdPYe0aB91OpwEdhllgeaMpLXpIV6RgIg==
X-Received: by 2002:a05:6a20:7349:b0:1b6:23ae:b294 with SMTP id adf61e73a8af0-1b623af0b7emr7684660637.34.1718121326727;
        Tue, 11 Jun 2024 08:55:26 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-177-77.dynamic-ip.hinet.net. [220.143.177.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704338ca12fsm4846345b3a.173.2024.06.11.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:55:26 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Dimitri Sivanich <sivanich@hpe.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] iommu/amd: Fix "execute NX-protected page" when running CPU hotplug
Date: Tue, 11 Jun 2024 23:54:44 +0800
Message-Id: <20240611155444.860-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When running the following command (cpu hotplug test case of LTP),
the "execute NX-protected page" exception is triggered.

  # /opt/ltp/testcases/bin/cpuhotplug02.sh -c 1 -l 1

Here is the call trace:

  process 14301 (cpuhotplug_do_s) no longer affine to cpu1
  smpboot: CPU 1 is now offline
  smpboot: Booting Node 0 Processor 1 APIC 0x2
  LVT offset 0 assigned for vector 0x400
  kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
  BUG: unable to handle page fault for address: ffffffffbb559170
  #PF: supervisor instruction fetch in kernel mode
  #PF: error_code(0x0011) - permissions violation
  PGD 1ae25067 P4D 1ae25067 PUD 1ae26063 PMD 134abd063 PTE 80000000
  Oops: Oops: 0011 [#1] PREEMPT SMP NOPTI
  CPU: 1 PID: 24 Comm: cpuhp/1 Kdump: loaded Not tainted 6.10.0-rc3
  Hardware name: Lenovo ThinkSystem SR665 MB/7D2WRCZ000, BIOS D8E121K-2.20 08/12/2021
  RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
  Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
   cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc <cc> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
  RSP: 0018:ffffb4e243fafe48 EFLAGS: 00010202
  RAX: 00000000000003c0 RBX: ffff90f4baea0820 RCX: 0000000000000000
  RDX: 00000000000000ec RSI: 00000000000000c0 RDI: 0000000000000001
  RBP: 0000000000000001 R08: ffff90f4baea0848 R09: ffff90f184a90d00
  R10: ffff90f184a90ce0 R11: ffff90f1834ebaf8 R12: 00000000000000c0
  R13: ffffffffbb559170 R14: ffffffffbaa4bd00 R15: ffff90f4baea0848
  FS:  0000000000000000(0000) GS:ffff90f4bae80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffbb559170 CR3: 000000001ae20000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   ? __die+0x20/0x70
   ? __pfx_amd_iommu_enable_faulting+0x10/0x10
   ? page_fault_oops+0x75/0x170
   ? __pfx_amd_iommu_enable_faulting+0x10/0x10
   ? exc_page_fault+0xaa/0x140
   ? asm_exc_page_fault+0x22/0x30
   ? __pfx_amd_iommu_enable_faulting+0x10/0x10
   ? __pfx_amd_iommu_enable_faulting+0x10/0x10
   ? __pfx_amd_iommu_enable_faulting+0x10/0x10
   cpuhp_invoke_callback+0x2cc/0x470
   ? __pfx_blk_mq_hctx_notify_online+0x10/0x10
   ? __pfx_smpboot_thread_fn+0x10/0x10
   cpuhp_thread_fun+0x8b/0x140
   smpboot_thread_fn+0xd9/0x1d0
   kthread+0xcf/0x100
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x30/0x50
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

The address '0xffffffffbb559170' is the function address of
'amd_iommu_enable_faulting()'. However, this function is declared with
'__init' keyword and will be freed in free_initmem().

Fix the issue by removing '__init' keyword since this function is still
needed for the up-and-running kernel.

Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 27e293727095..161248067776 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3362,7 +3362,7 @@ int amd_iommu_reenable(int mode)
 	return 0;
 }
 
-int __init amd_iommu_enable_faulting(unsigned int cpu)
+int amd_iommu_enable_faulting(unsigned int cpu)
 {
 	/* We enable MSI later when PCI is initialized */
 	return 0;
-- 
2.25.1


