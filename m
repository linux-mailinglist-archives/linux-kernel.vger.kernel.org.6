Return-Path: <linux-kernel+bounces-259598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA98939930
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9401F22890
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DBB13C3D5;
	Tue, 23 Jul 2024 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GFB0ENLn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892B038DD9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721712780; cv=none; b=tQpCOMV7u8rokEdFfR3KwjtqiCLtvp0ovgxSc/fqnDDawvccAAtyKnvTKL6F6AXvmrA2xMhq8jZF8hErc1PhE3CcxhiOHe8jOdFA0afVo+MLEPTcfM+owA/eC36A4iEfh8srK2O7T98UrVxZ+XOn6nIlMmz6XKwfhRV53pLUoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721712780; c=relaxed/simple;
	bh=e423d805rBa/tHan+NvMCUzmLFMGfz6zeuj3OdbupqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oO+dNxHr+edz+LI5ePMwbYU1B02rwFZdXlMe6CljxFQgv3JNlZqG2/gsEHksHeM4y+VZa8I6vOMU3PNkF8FqBbW+GavqY7lJQZ41kvuwQjuqavP6YFXVFB6/HubkuTiA3CunV8iBQEAL8UW68Yu3hewYDXoxUy1+c4G6eI7UerY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GFB0ENLn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d333d5890so1002254b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721712778; x=1722317578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqm4X639ZFYeCs5mii36JFRBpr/ZwEyolKIyZQLv3Ys=;
        b=GFB0ENLntGigZp/CMP0eOnRPRejqAdtNECEURDV0Ghbiy7Z8dayWFUnGfLwcTl+YrD
         MEPwwBNgGX3DWufJD22UqJk44TxywYFXNwdtAgJtMPjrCr9/cUit94lkbB5L5rXku0eB
         /eDuzsnPq03KPo2rbPkCL/qGSm0Zc5V3R9Pn6ebTw4vxVjFPG9lZgdzMoceiIxGPSL9g
         6niJgsXmXlACTOQEBL6eBeMxQ8G5QpQohsQ7dk8f4DDku/2JEm/Gvs6NnnKX7mq1BiIm
         6vnzkDlF+BHKTNUF82VrDgz750s6TQH982V0AbGJ7d/J3UvRw6aAwZYaaGqCWJAk+L1V
         Ulvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721712778; x=1722317578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cqm4X639ZFYeCs5mii36JFRBpr/ZwEyolKIyZQLv3Ys=;
        b=dI9uVKoevkL4UQVYiO+eeldApFSHC5kvAve308V06mVAH/0nkXcElGBVO8jp3XoxxD
         QZ1qHfe41Chf4xlLEwRNkc2XcAnYBbfUhk3CWBjHSOHGbvvfeGB4bkzWO+tOT7x+Mddf
         0BGY1QYXURSS58Vi1SvzmjCe4FqdGSV2lCY/xiKFc440eTEtm4hhhtTLNbUw6uzTooyq
         5SO66KAGgxP6mdtBeOclO/iyagiPxUhnkZ0Xt4oUPUwi+I6vHLgIm/5J/PyukC0+VmAz
         5tQ0OFRK26sV7DpXXhUXllr0sxu9a/BKq9Unffr1ASWQzsLcPSKm+ngQ9TTLJOcLGYL2
         eAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX2e+KKhdf8nl0RDlwjJmPwbNtw1dJ97WYUePY15RInVIkCPdfcyHtWgZMQLA2btu9U9pPRr3RztbD+G9KIlUbwnLMVYrr+ANin1AI
X-Gm-Message-State: AOJu0YxOF97kbcjrMxE2E/IT4FxCuYbb9siUHmZRL1BobUSV0ZhjXxMi
	+n+kOSxk/g+D8WfV1bP5aN7o4499ZfnAf8AZwpOfzU4zdSkjk9oqa8lIp12EWRQ=
X-Google-Smtp-Source: AGHT+IHNqy6pg7LGEZQrXaEIRE/t9RTseUau7Uceq6CgFL8SQxztBHDWTUnCUnkLgaDqri8xQQ8N5g==
X-Received: by 2002:a05:6a00:3991:b0:706:750c:8dda with SMTP id d2e1a72fcca58-70d0847c8e3mr13022202b3a.6.1721712777817;
        Mon, 22 Jul 2024 22:32:57 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d26d98169sm2854523b3a.76.2024.07.22.22.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:32:57 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: peterz@infradead.org,
	mgorman@suse.de,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH v1] mm/numa_balancing: Fix the memory thrashing problem in the single-threaded process
Date: Tue, 23 Jul 2024 13:32:50 +0800
Message-Id: <20240723053250.3263125-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I found a problem in my test machine that the memory of a process is
repeatedly migrated between two nodes and does not stop.

1.Test step and the machines.
------------
VM machine: 4 numa nodes and 10GB per node.

stress --vm 1 --vm-bytes 12g --vm-keep

The info of numa stat:
while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
anon N0=98304 N1=0 N2=10250747904 N3=2634334208
anon N0=98304 N1=0 N2=10250747904 N3=2634334208
anon N0=98304 N1=0 N2=9937256448 N3=2947825664
anon N0=98304 N1=0 N2=8863514624 N3=4021567488
anon N0=98304 N1=0 N2=7789772800 N3=5095309312
anon N0=98304 N1=0 N2=6716030976 N3=6169051136
anon N0=98304 N1=0 N2=5642289152 N3=7242792960
anon N0=98304 N1=0 N2=5105442816 N3=7779639296
anon N0=98304 N1=0 N2=5105442816 N3=7779639296
anon N0=98304 N1=0 N2=4837007360 N3=8048074752
anon N0=98304 N1=0 N2=3763265536 N3=9121816576
anon N0=98304 N1=0 N2=2689523712 N3=10195558400
anon N0=98304 N1=0 N2=2515148800 N3=10369933312
anon N0=98304 N1=0 N2=2515148800 N3=10369933312
anon N0=98304 N1=0 N2=2515148800 N3=10369933312
anon N0=98304 N1=0 N2=3320455168 N3=9564626944
anon N0=98304 N1=0 N2=4394196992 N3=8490885120
anon N0=98304 N1=0 N2=5105442816 N3=7779639296
anon N0=98304 N1=0 N2=6174195712 N3=6710886400
anon N0=98304 N1=0 N2=7247937536 N3=5637144576
anon N0=98304 N1=0 N2=8321679360 N3=4563402752
anon N0=98304 N1=0 N2=9395421184 N3=3489660928
anon N0=98304 N1=0 N2=10247872512 N3=2637209600
anon N0=98304 N1=0 N2=10247872512 N3=2637209600

2. Root cause:
Since commit 3e32158767b0 ("mm/mprotect.c: don't touch single threaded
PTEs which are on the right node")the PTE of local pages will not be
changed in change_pte_range() for single-threaded process, so no
page_faults information will be generated in do_numa_page(). If a
single-threaded process has memory on another node, it will
unconditionally migrate all of it's local memory to that node,
even if the remote node has only one page.

So, let's fix it. The memory of single-threaded process should follow
the cpu, not the numa faults info in order to avoid memory thrashing.

After a long time of testing, there is no memory thrashing
from the beginning.

while :;do cat memory.numa_stat | grep -w anon;sleep 5;done
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0
anon N0=2548117504 N1=10336903168 N2=139264 N3=0

V1:
-- Add the test results (numa stats) from Ying's feedback

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Acked-by: "Huang, Ying" <ying.huang@intel.com>
---
 kernel/sched/fair.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 24dda708b699..d7cbbda568fb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2898,6 +2898,12 @@ static void task_numa_placement(struct task_struct *p)
 		numa_group_count_active_nodes(ng);
 		spin_unlock_irq(group_lock);
 		max_nid = preferred_group_nid(p, max_nid);
+	} else if (atomic_read(&p->mm->mm_users) == 1) {
+		/*
+		 * The memory of a single-threaded process should
+		 * follow the CPU in order to avoid memory thrashing.
+		 */
+		max_nid = numa_node_id();
 	}
 
 	if (max_faults) {
-- 
2.20.1


