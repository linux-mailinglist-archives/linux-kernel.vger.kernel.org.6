Return-Path: <linux-kernel+bounces-306943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4599645CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CBE1F269A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E882C1A2C3C;
	Thu, 29 Aug 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R37nrGdQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837721946CA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936836; cv=none; b=ENwScnsjzvaYgPWHUi4sXAbv9DWNPXFz7gimTsU4aC+1EPcD6cRxWRVK3UVTGcLT+VWDKrLhKUJmtJ3Ebi9UrTkeRR0iKpMiJl4VsbSIAnLtMCPUgLDbuVJGnd1K8iND5nodQU57Jti674gKuxAihMfIEGNH8o6bG02ShOm8Y1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936836; c=relaxed/simple;
	bh=7kWmOY3MrSUNCzjk4tLYcKFMWcIyfSwicDbMcNx3P+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Inbwp6YSPXlmxo/ftDU2VOGVjghj/hYqZCWvDgDlkHHf9B8SrPP1YFIQaZc4CmtoIxM+Lrkt8RbSApSn9mheND2wvw8Pq7vRj32npkcLyxy9Ru8BVL8q/+3g0QlhLf4iaYQQMQjVnsJe1VXKFZTMmxbOZw/XXURKzE0RPWzVqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R37nrGdQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7148912a1ebso357506b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724936834; x=1725541634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y9EpLMOMAJaE68hMt3i4/fVjXUl7E1TUy6E8jHMwuaU=;
        b=R37nrGdQ6O5vv6marSsdB1GQB27xe6h5/6ZiwlfFoVZ3uixWxK3ATRCLkWEi5FZfcv
         cqmcSHYxS7oggsv2cRTIVYxR7HMZ1JQINAEC2xygMvzQsefXAtfQjMWq+RhHjzYEnKrx
         91M91CxsCRPC1t4BVEN6zOr51LAzY/6/oaIisGN8CufdRTtWiwZHP5lbllYtTvQdX0y3
         uXsk5HYJpnX7Fb8RCfB43/83X8Q/Sw5N3FV01F+jB+o3i8m04NCO/Q/RhA4nQm3Z1aII
         3S1NAwm6jmChc/T+KokworNC7H3wS9tDlc6+MGcJrdT12bQ4VBoOfIjNxBn+KBeOvY7T
         EVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724936834; x=1725541634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y9EpLMOMAJaE68hMt3i4/fVjXUl7E1TUy6E8jHMwuaU=;
        b=AbjmMnUkHJY06ev3NuZtFICcoHszXwt0EIpTgEPG/v84kwykkmDLZqJ/75i915kIBr
         0H2A0qr/NHmpQFLosku7XAop+PIp9ECmU6v1uR+enMdCtCh+c+NFSpFphkyW/2Qlpo5w
         7Oi1Mh2ynRTM24ecVfIAEdPnETZe7QOiXuuQeXyKCmlt1JO3k9VsJNwNtBpzUEsq6bKj
         Hjm78EGkNKUZ3Pzx8BdaXe4u+495f38cw8ZyglKDiFwUwyfjAH6BB6/hCnDBhX8igaN+
         SEcxDXJodbQtRdo2eqvY+VFOpgHEVQy0zKxhASmb1WsySNRh480usaR9XRP/ADXcXhO/
         fa0A==
X-Forwarded-Encrypted: i=1; AJvYcCWV2zSjJLWywL3sqBMoWvsNsbHMbuRv/d2nLUsSJADsMF55qIjmcgKBEnIsbkhqMLhrXnK/5RWwKGOscE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVlifOpXOM9wpYShyxJ5VXiHbiA4jR9s6vpN15ZYIrdVDXPuP
	5gldiiYiS5nRLfeSTqNoJeDgO+zuv05s4B+sO5/nDETNE8G1phBY
X-Google-Smtp-Source: AGHT+IH1IKaqlZuFByO2CwywveQwPI/BFTTibIrS0gNBtRbDctRYoyh+p7lqK61u4EjetDco+Zk0Ww==
X-Received: by 2002:a17:902:e80d:b0:1fc:568d:5f05 with SMTP id d9443c01a7336-2050c34f7efmr34708975ad.8.1724936833073;
        Thu, 29 Aug 2024 06:07:13 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-217-49.dynamic-ip.hinet.net. [220.143.217.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b13c9sm10909145ad.62.2024.08.29.06.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 06:07:12 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when purging each vmap_area
Date: Thu, 29 Aug 2024 21:06:33 +0800
Message-Id: <20240829130633.2184-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

When running the vmalloc stress on a 448-core system, observe the average
latency of purge_vmap_node() is about 2 seconds by using the eBPF/bcc
'funclatency.py' tool [1].

  # /your-git-repo/bcc/tools/funclatency.py -u purge_vmap_node & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1

     usecs             : count    distribution
        0 -> 1         : 0       |                                        |
        2 -> 3         : 29      |                                        |
        4 -> 7         : 19      |                                        |
        8 -> 15        : 56      |                                        |
       16 -> 31        : 483     |****                                    |
       32 -> 63        : 1548    |************                            |
       64 -> 127       : 2634    |*********************                   |
      128 -> 255       : 2535    |*********************                   |
      256 -> 511       : 1776    |**************                          |
      512 -> 1023      : 1015    |********                                |
     1024 -> 2047      : 573     |****                                    |
     2048 -> 4095      : 488     |****                                    |
     4096 -> 8191      : 1091    |*********                               |
     8192 -> 16383     : 3078    |*************************               |
    16384 -> 32767     : 4821    |****************************************|
    32768 -> 65535     : 3318    |***************************             |
    65536 -> 131071    : 1718    |**************                          |
   131072 -> 262143    : 2220    |******************                      |
   262144 -> 524287    : 1147    |*********                               |
   524288 -> 1048575   : 1179    |*********                               |
  1048576 -> 2097151   : 822     |******                                  |
  2097152 -> 4194303   : 906     |*******                                 |
  4194304 -> 8388607   : 2148    |*****************                       |
  8388608 -> 16777215  : 4497    |*************************************   |
 16777216 -> 33554431  : 289     |**                                      |

  avg = 2041714 usecs, total: 78381401772 usecs, count: 38390

  The worst case is over 16-33 seconds, so soft lockup is triggered [2].

[Root Cause]
1) Each purge_list has the long list. The following shows the number of
   vmap_area is purged.

   crash> p vmap_nodes
   vmap_nodes = $27 = (struct vmap_node *) 0xff2de5a900100000
   crash> vmap_node 0xff2de5a900100000 128 | grep nr_purged
     nr_purged = 663070
     ...
     nr_purged = 821670
     nr_purged = 692214
     nr_purged = 726808
     ...

2) atomic_long_sub() employs the 'lock' prefix to ensure the atomic
   operation when purging each vmap_area. However, the iteration is over
   600000 vmap_area (See 'nr_purged' above).

   Here is objdump output:

     $ objdump -D vmlinux
     ffffffff813e8c80 <purge_vmap_node>:
     ...
     ffffffff813e8d70:  f0 48 29 2d 68 0c bb  lock sub %rbp,0x2bb0c68(%rip)
     ...

   Quote from "Instruction tables" pdf file [3]:
     Instructions with a LOCK prefix have a long latency that depends on
     cache organization and possibly RAM speed. If there are multiple
     processors or cores or direct memory access (DMA) devices, then all
     locked instructions will lock a cache line for exclusive access,
     which may involve RAM access. A LOCK prefix typically costs more
     than a hundred clock cycles, even on single-processor systems.

   That's why the latency of purge_vmap_node() dramatically increases
   on a many-core system: One core is busy on purging each vmap_area of
   the *long* purge_list and executing atomic_long_sub() for each
   vmap_area, while other cores free vmalloc allocations and execute
   atomic_long_add_return() in free_vmap_area_noflush().

[Solution]
Employ a local variable to record the total purged pages, and execute
atomic_long_sub() after the traversal of the purge_list is done. The
experiment result shows the latency improvement is 99%.

[Experiment Result]
1) System Configuration: Three servers (with HT-enabled) are tested.
     * 72-core server: 3rd Gen Intel Xeon Scalable Processor*1
     * 192-core server: 5th Gen Intel Xeon Scalable Processor*2
     * 448-core server: AMD Zen 4 Processor*2

2) Kernel Config
     * CONFIG_KASAN is disabled

3) The data in column "w/o patch" and "w/ patch"
     * Unit: micro seconds (us)
     * Each data is the average of 3-time measurements

         System        w/o patch (us)   w/ patch (us)    Improvement (%)
     ---------------   --------------   -------------    -------------
     72-core server          2194              14            99.36%
     192-core server       143799            1139            99.21%
     448-core server      1992122            6883            99.65%

[1] https://github.com/iovisor/bcc/blob/master/tools/funclatency.py
[2] https://gist.github.com/AdrianHuang/37c15f67b45407b83c2d32f918656c12 
[3] https://www.agner.org/optimize/instruction_tables.pdf

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 mm/vmalloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3f9b6bd707d2..607697c81e60 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2210,6 +2210,7 @@ static void purge_vmap_node(struct work_struct *work)
 {
 	struct vmap_node *vn = container_of(work,
 		struct vmap_node, purge_work);
+	unsigned long nr_purged_pages = 0;
 	struct vmap_area *va, *n_va;
 	LIST_HEAD(local_list);
 
@@ -2224,7 +2225,7 @@ static void purge_vmap_node(struct work_struct *work)
 
 		list_del_init(&va->list);
 
-		atomic_long_sub(nr, &vmap_lazy_nr);
+		nr_purged_pages += nr;
 		vn->nr_purged++;
 
 		if (is_vn_id_valid(vn_id) && !vn->skip_populate)
@@ -2235,6 +2236,8 @@ static void purge_vmap_node(struct work_struct *work)
 		list_add(&va->list, &local_list);
 	}
 
+	atomic_long_sub(nr_purged_pages, &vmap_lazy_nr);
+
 	reclaim_list_global(&local_list);
 }
 
-- 
2.34.1


