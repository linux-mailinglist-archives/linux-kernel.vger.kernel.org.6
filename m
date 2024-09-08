Return-Path: <linux-kernel+bounces-320239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEFA9707E3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A171C218A5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C00216FF25;
	Sun,  8 Sep 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo+jeOAb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04EC16D332
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725803548; cv=none; b=q8rUiSWKuNaejzq+gB58LKNDK3qT56YlOOY7roRoY3O/r13ilpymFlKUytzjTUje6NJ4pDDbNT4BLcf/rQRNaypfh9foktJfl3ng7VRLqUvD/CUPlGblEDNUU/0iwMgdjz9aG19ih3vbK43hb5tLqZ2v8WkUFua1ahuwS3CbEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725803548; c=relaxed/simple;
	bh=RZxaWx3mPbzMneeHv0NNqGykZ8/2+0daUW56bh781d0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YPs0Tix1J9/3nEtNG4U1zRtNTmWf3kR16Qmr+/4Z/y+HMNRp4bOzAeLsbvbwtVdBrChCtySGOCBwLC4Emo9Ktdrvlcy3htK2MxMDg+cjQcdZbkOUmelNS4BO3xX11+591d5CAnbbEznqrB9rQGuYnT9rNCcDr81MyD8LQbYnOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo+jeOAb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-206aee4073cso35333645ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725803546; x=1726408346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRtQePYubzq2zFYVdCNEp/e+db/4uKbZNZ9nWI93Mo0=;
        b=Jo+jeOAbVMRuqA5kL1LhL9m4003coFdbcQZbBf3BTfwhBOqENbL0NGoZ8XLxTmFO9W
         P8nNmlcyGj79f0k+PtY9oKUL+f/eiu2u7B6N0CTsmOeHhgWFeKh8I64ppUQ96nkaKp+6
         8B9Dbo93rYfusJl98EsJCp8LWiIO2rPkwaWj9vD8V343QvERhsfwNfS2IUUN4ZIxbKTf
         4xHfUaJvK/50syJsCANCbXaItSj3KPCtlJCXNYUjQlFIxSnxV2QdzIdp/ouUrMVgOE7B
         EpcfPrdM08qwU49D1TKP16Zon2N2MMQPp1MCidpsXz9IgcKvPQtCTyRu/OlXq9kJtXje
         P3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725803546; x=1726408346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRtQePYubzq2zFYVdCNEp/e+db/4uKbZNZ9nWI93Mo0=;
        b=fwlqCEFZbSLy1vFJDTuA+GyVReDQD4YFsY0PznmxuPOBehWwJbqnRi+Kh27YpuXmvu
         yWuwOxp6Lvu+Y5RZOaPm45d2+g3Q6Jrktue0JF3KWrEnnQj6a6F+OGZtF9n8JsqmuCZh
         UhXvq1AmRgicXj8OJYty9/mf51wK8f64K7zMaZTiq7wseo+FW5i805ZhSQ+8bqBZa8nO
         RRoRKMpVDt7LIIzgP5GbO3rdW40MlzoLlczZ5QtuKYusexZT/rqASDDqJ/JB/flWmTAH
         2fl9toL7uFeUQ4N44yQkZ4sfNWd5loSXOLelUeRAvEhBoxWKhM4elNX0Spopq2SnL9bt
         om+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3ylPmo5M/u0ZnnUWvUyjsJ9fUIPSzomrsA9l+IS7ik9IpsJHDgyBuDDl9m6vS0vF2af2qUCPgl2PueSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbyJ1u5DQ0W9WYnVe8KYsiI/XVCMIo8/c0cCTwtssgH8JzqYt
	AIp3Vg/79o9ae7rdZTYQUDNpAJq5A7oX7GaIZ1EI+8Zc1p7WY9Zz
X-Google-Smtp-Source: AGHT+IGIiT7c2oY2Doiyvu+I7gqM00x8umYv0eZPrV82EkJaCahBK/0KVXb0PSzKWbMjZwuY4mZE0Q==
X-Received: by 2002:a17:902:d488:b0:206:d6ac:85e1 with SMTP id d9443c01a7336-206f04c9a1fmr122855095ad.2.1725803545996;
        Sun, 08 Sep 2024 06:52:25 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f469sm20241105ad.223.2024.09.08.06.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 06:52:25 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] percpu: fix data race in pcpu_alloc_noprof() and extend spinlock protection area
Date: Sun,  8 Sep 2024 22:52:10 +0900
Message-Id: <20240908135209.15159-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got the following KCSAN report during syzbot testing:

==================================================================
BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_free_area

read-write to 0xffffffff883f872c of 4 bytes by task 3378 on cpu 0:
 pcpu_update_empty_pages mm/percpu.c:602 [inline]
 pcpu_block_update_hint_free mm/percpu.c:1044 [inline]
 pcpu_free_area+0x4dc/0x570 mm/percpu.c:1302
 free_percpu+0x1c6/0xb30 mm/percpu.c:2277
 xt_percpu_counter_free+0x63/0x80 net/netfilter/x_tables.c:1951
 cleanup_entry+0x195/0x1c0 net/ipv6/netfilter/ip6_tables.c:671
 __do_replace+0x470/0x580 net/ipv6/netfilter/ip6_tables.c:1099
 do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
 do_ip6t_set_ctl+0x820/0x8c0 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x126/0x140 net/ipv6/ipv6_sockglue.c:998
 tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
 sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
 do_sock_setsockopt net/socket.c:2324 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
 x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

read to 0xffffffff883f872c of 4 bytes by task 3374 on cpu 1:
 pcpu_alloc_noprof+0x9a5/0x10c0 mm/percpu.c:1894
 xt_percpu_counter_alloc+0x79/0x110 net/netfilter/x_tables.c:1931
 find_check_entry net/ipv4/netfilter/ip_tables.c:526 [inline]
 translate_table+0x921/0xf70 net/ipv4/netfilter/ip_tables.c:716
 do_replace net/ipv4/netfilter/ip_tables.c:1137 [inline]
 do_ipt_set_ctl+0x7bd/0x8b0 net/ipv4/netfilter/ip_tables.c:1635
 nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0xea/0x100 net/ipv4/ip_sockglue.c:1424
 tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
 sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
 do_sock_setsockopt net/socket.c:2324 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
 x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

value changed: 0x00000005 -> 0x00000006

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 3374 Comm: syz-executor.3 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================

The global variable pcpu_nr_empty_pop_pages can be protected by pcpu_lock, 
but since pcpu_alloc_noprof reads outside the spinlock protection section,
a data race may occur and the branch of the conditional statement may change.
Therefore, the reading of pcpu_nr_empty_pop_pages should be modified to be 
performed within the spinlock protection section.

However, the for_each_clear_bitrange_from loop requires and uses a spinlock, 
but it repeatedly locks and unlocks the spinlock unnecessarily. 

Therefore, I think it is appropriate to remove the repeated spin_lock and 
spin_unlock in for_each_clear_bitrange_from and perform the operation of 
reading pcpu_nr_empty_pop_pages and then perform spin_unlock to postpone 
the point in time when the spin_unlock is performed.

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: e04d320838f5 ("percpu: indent the population block in pcpu_alloc()")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 mm/percpu.c |  5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..5c958a54da51 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1864,7 +1864,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 area_found:
 	pcpu_stats_area_alloc(chunk, size);
-	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	/* populate if not all pages are already there */
 	if (!is_atomic) {
@@ -1878,14 +1877,12 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
 
-			spin_lock_irqsave(&pcpu_lock, flags);
 			if (ret) {
 				pcpu_free_area(chunk, off);
 				err = "failed to populate";
 				goto fail_unlock;
 			}
 			pcpu_chunk_populated(chunk, rs, re);
-			spin_unlock_irqrestore(&pcpu_lock, flags);
 		}
 
 		mutex_unlock(&pcpu_alloc_mutex);
@@ -1894,6 +1891,8 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
 		pcpu_schedule_balance_work();
 
+	spin_unlock_irqrestore(&pcpu_lock, flags);
+
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
--

