Return-Path: <linux-kernel+bounces-258955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8C938F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85A71C2124E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135416CD16;
	Mon, 22 Jul 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ajPCYfFe"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B6D3A8D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651621; cv=none; b=M5+uMfKXTxwrfFWtaYwXl9InRcvDN1FozMDGOGMV4Z4bEgDJRMJ7AcURlO0bUKsivUjIg94YQQdUG4SrNW5Gy50I8X9VsqEkU/ZXmVOMH0FJyL2IqSQsbdddgBThNhGu0n9MRwZwUdgNhrZygijMz3uF6KYy08WGHht54iJyYxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651621; c=relaxed/simple;
	bh=UVxnc1rcxu3BzUjKxD6Elxpz395U590fU6TZg9xEaiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EHbg38ArpSD844UynP1Bycg8k3HU2YvPaYW51/o7bPF/Tq89sin8HWpEfAL012QU7EghG/pNp/lhjM5jozV15AEMJNkhahvGGCk+elyNcR99IYSbajdcLmXw/zgNEPLye0/BqKen6+Krs4B73GBfOXf47otYL94zZ8lqAqY0ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ajPCYfFe; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-26109c97728so1928071fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721651617; x=1722256417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVWwL5VO4q04b45BWmiVgKpzDu/7jE1+3wyYKYbandI=;
        b=ajPCYfFef0DTVg6GZvKdIp8LenUrqH7fNNJxj8J7ufB4psO44i/gJD0Eqjv2+oMOQN
         Uom6yW3Urg8Cg6G2CyIFgfOe8Lm2XiN0Rk/6EepflWyYoQI0kmGGqnLPX8IDabZvTp7o
         qswF6rzENGRhq9+EoNEB34sHLbchEAQUATZL7GTZJeHWt8U0ec0rtWGulkOR/erOq+kN
         kzWVkh3WhnWKC4E7sqDR1ClZw+/4gyTAyjXUYdF2TA1wRmuEUBMQYaRlQy9gdUZx9SsP
         kWfsCJUk29/BQKNmaamgn0yx71+DAr0OMaWIx9lR35DciLT+MMB3pNjDpElp/ImQyzRD
         wJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721651617; x=1722256417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVWwL5VO4q04b45BWmiVgKpzDu/7jE1+3wyYKYbandI=;
        b=BTWBxfDa3DBYMtUkJRydwlA0cjaym4NliHlolsBKd+6y1d3sjZa053RujB971dwNgh
         Wrpk0cBbGJVk9HZLki3lzcCtoRgJ2zIG49g7GnuJ1+JNsCWGUfG8HkOorHxdZJq7ulii
         RSt1X0GRZaPaN9Gd8ILAclorXsHCZu1GdJwsQDMmvQSbPICrSBdSJdy1teqBTFG4YQMD
         Ro/FNOZhN/85dYuJulut2Qbs+IyJnNh1r7v+Eo5qFwB0BET/ubTu0f6K5YjJCLRdcGfn
         /qzfJRndzAPchFpii28jF0NSGCQ+LuqUdBYL4gGY1vAW1M6qOVwkuUe4MrMOWYWPMiWr
         U5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUsvVI+U2qi5XeHeBqD2eijNoUV+7AGuYQdchDCXPCb6RuWrXQiBmjbPEr/51wPQ0JeLj2XPBXEYm2i8IqTypFIUylHe6LQZAbOnO6X
X-Gm-Message-State: AOJu0YybsNV70qrhxOEEwDOoqBjrQEO5WxsRcm56d84gs68ShCyIv2/0
	/eTldAY1kIVG9yaGopagOdAA5EC8YSClHy/my46KfkmqiMLVRECHb1XqXFTNoz8=
X-Google-Smtp-Source: AGHT+IEdgVG9XJ+pUl9SRJ1Ab1oscuqPq6XDBYqsC81riN+r66R19akgikYx2rlNAaK0kbgS9WOekw==
X-Received: by 2002:a05:6871:551:b0:254:c617:a9a0 with SMTP id 586e51a60fabf-26121652e01mr7197994fac.50.1721651617511;
        Mon, 22 Jul 2024 05:33:37 -0700 (PDT)
Received: from n37-034-248.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a0eeec2bf0sm3191229a12.10.2024.07.22.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 05:33:36 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: peterz@infradead.org,
	mgorman@suse.de,
	ying.huang@intel.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm/numa_balancing: Fix the memory thrashing problem in the single-threaded process
Date: Mon, 22 Jul 2024 20:33:20 +0800
Message-Id: <20240722123320.2382992-1-hezhongkun.hzk@bytedance.com>
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

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
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


