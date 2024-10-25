Return-Path: <linux-kernel+bounces-381020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EC9AF931
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365C22834F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6618E054;
	Fri, 25 Oct 2024 05:40:28 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AA176AAD
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729834828; cv=none; b=GNviFA5NtQXIkqq1w0OU/X5Q5iUu1WMtX6cMEOIAUxLWZM3gaY4rK4coiTsN2o+DQ1s+yp+yfXGjc964kq5TB1Xl2dxxvfBxnIVlvwgF4vjOMce+uNv2tAk3/N0nxlqQX2Rv4TVffpsi1zhVvbFTb8o2Llnl/jP0gcoZbtlmhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729834828; c=relaxed/simple;
	bh=ChJakSHDpVS6fy2IZZqY44CO6t/FAzraBj6pS8iCWKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdc8x7TWfmyPvu1w4B61VA2R2PQHwrDLLkhpsug7AV1f/g1ykrKqTEK3veJccQCYPJl59V238NUVUT2T0mivf4I0LUEenVMMV4tyWVd59LdLxOmCiEp5hUc0pPeRnzGfJCIAGlO6/1yH5m5eHi0hlV3+qPDNKrRFrhqcCgKOPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso6756435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 22:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729834825; x=1730439625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDncTFkr5L0djCj0Eja5jQSh6ZITvK7aIFJkjuCNtls=;
        b=HSzwYZ5Zl/s7ZT2Gv7sRdQ2zhVYaw7cale5XQ0ovTF51vnsa5p9F5TiGakKjWYiQ7s
         y6H/IKvMzRx0ii7RQzhcDM+JecAYWDNsf+AU23UQZ4CkDjPUxqBu8rg8KiI0lqndtKTg
         A9dDRCGIBLcaYrfy/eMlkUZf39e8IUca+dxafpf5ZQoeZKfMFLR5SJ/5h8gTo95hpL5Y
         TwNp0GJeGgDjNa+oY9zsp8ib0rstdWcEL05bMaZJhpkBzt9mLS4R/DGyaml+pvPJVj7N
         udNVELKSe1putgzBUpZaIGFVkrHgqH8ePxuf27Caq7F6JGKR0Wt2Cy7c0ir0IB+/38N3
         oE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6rtc4I00+buHdXgTfArtNoS2JeruSwODuwsvcOj24H/NsVZvmnqbaywmAFsNJrSPFMVcnMoAEf9Dst2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrBRlBkTLjHZFBdCbe/QthdezSNXsml7xdwPkrl5dARHS65KO
	rUjjZj96+CPLbA/fIWvnComyjJxg13KD+mNX5R1pPbPcvFcndYL6
X-Google-Smtp-Source: AGHT+IEqxPzK2sjzBI/pa1VGEeKPM7iu9rMqpSIiQdkwsAKjXJblzO0sJmuJjKyf9gIFdIjUVc39ew==
X-Received: by 2002:a05:6e02:19cc:b0:3a0:8c68:7705 with SMTP id e9e14a558f8ab-3a4d59fccf1mr88183685ab.21.1729834825150;
        Thu, 24 Oct 2024 22:40:25 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6de0923sm1178085ab.27.2024.10.24.22.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 22:40:24 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: sched-ext@meta.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scx: Fix exit selftest to use custom DSQ
Date: Fri, 25 Oct 2024 00:40:13 -0500
Message-ID: <20241025054014.66631-1-void@manifault.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 63fb3ec80516 ("sched_ext: Allow only user DSQs for
scx_bpf_consume(), scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()"), we
updated the consume path to only accept user DSQs, thus making it invalid
to consume SCX_DSQ_GLOBAL. This selftest was doing that, so let's create a
custom DSQ and use that instead.  The test now passes:

[root@virtme-ng sched_ext]# ./runner -t exit
===== START =====
TEST: exit
DESCRIPTION: Verify we can cleanly exit a scheduler in multiple places
OUTPUT:
[   12.387229] sched_ext: BPF scheduler "exit" enabled
[   12.406064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   12.453325] sched_ext: BPF scheduler "exit" enabled
[   12.474064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   12.515241] sched_ext: BPF scheduler "exit" enabled
[   12.532064] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   12.592063] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   12.654063] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
[   12.715062] sched_ext: BPF scheduler "exit" disabled (unregistered from BPF)
ok 1 exit #
=====  END  =====

Signed-off-by: David Vernet <void@manifault.com>
---

Applied on top of 4f7f417042b242c1e5a9ed03741acb5d900e0871 on the
for-6.12-fixes branch

 tools/testing/selftests/sched_ext/exit.bpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index bf79ccd55f8f..d75d4faf07f6 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -15,6 +15,8 @@ UEI_DEFINE(uei);
 
 #define EXIT_CLEANLY() scx_bpf_exit(exit_point, "%d", exit_point)
 
+#define DSQ_ID 0
+
 s32 BPF_STRUCT_OPS(exit_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -31,7 +33,7 @@ void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
 	if (exit_point == EXIT_ENQUEUE)
 		EXIT_CLEANLY();
 
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dispatch(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
@@ -39,7 +41,7 @@ void BPF_STRUCT_OPS(exit_dispatch, s32 cpu, struct task_struct *p)
 	if (exit_point == EXIT_DISPATCH)
 		EXIT_CLEANLY();
 
-	scx_bpf_consume(SCX_DSQ_GLOBAL);
+	scx_bpf_consume(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(exit_enable, struct task_struct *p)
@@ -67,7 +69,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(exit_init)
 	if (exit_point == EXIT_INIT)
 		EXIT_CLEANLY();
 
-	return 0;
+	return scx_bpf_create_dsq(DSQ_ID, -1);
 }
 
 SEC(".struct_ops.link")
-- 
2.46.1


