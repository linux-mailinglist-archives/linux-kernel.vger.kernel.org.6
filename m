Return-Path: <linux-kernel+bounces-437920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7100D9E9A82
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A4A1619F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AB01C5CAD;
	Mon,  9 Dec 2024 15:29:29 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56AB23312A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758169; cv=none; b=Vh6UiFIPvq5YUOGLY/Ms9Wxb/ha79YSpaJQRxnZfzzTkchl89u4lk0H0otG4YJDeh/h96ivKiOzWggRI3YHcK8IfnMtzNdbNjPUryGvrXQo9J/7XVL5UWpciovw50hbvfVsKR4s6AP4fTqmh1w+pPF2dazxm/HV3GvmEwmzqUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758169; c=relaxed/simple;
	bh=BqB7fexmA89ufdowKgGS+OHz82BOtnI/RrKbRBbcHwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msuzVPEJ+AUjX90CcyHvj6u1AgFULR9cKqEYrn+wpiAQNMGRynNRuIhqD2x6QQqH4yuOTOi87G0fVGls8Iv8ryQ2e3ne8jTcDOFtlperGyDR4Y2zMsydPuFb0YzsmDJv45x9ag3/WhOm15SboIjhTLSOe/Uh4IzxlZ0ZcHEuFSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-84197b4e61aso323687639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733758167; x=1734362967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkbIaZTygxve/onGiLCYwKEJP0Y/R8tApF8GF+oaQgY=;
        b=PYZNfLVVh7uKnL4Jc9If2ImoI+e3uuHFwR4AYESO/90C2wyPKBn6OUDYf2/e/31/Q3
         NhwykEUNMsH1N3fbvcLcGMDoXsQE80kawseiDmrI+o71rHxjvZaMSp+JggZayT6Qj8nz
         /3q9kd4lnOu5OeRfF0rlDus9UhMiJ+ZsRrHWMSeIbmK7FM9++r9uhSjzWFIhcFmZnNAR
         prGQ9TvRZoEaSvSqPNdAI3QZXPcnuMDCfcmK6Pt/Riu0SmXUFNI8xF8MGsKlof6JnYBQ
         KvHDa90cehW/sWsm2Q4o92XS5ueJaLR9038XSUUqPp2nH9c2CvAHNj4ndAJonumVVmKT
         v+Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUGxKe5UkMjnWnirX84jIHpRNhtOFoM/WrdX9wq+xWRpOw45ByEpXk8oTswqReaCWW/a5MAnm2Q9Ol01Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySd4BsY4zGD+7k3LUBb8VSNcfe3QsozNyzp8dxicM4LvXAN+tF
	vRv8HF/wGWF3HMpBFtcXbToTu5IPgRVi1u5BcVjA/MabJ1hsJW6x
X-Gm-Gg: ASbGncui0q4lC6t1HpzMV/Rs1pGQFdcH2fOXmmQ3NZJ3D5MXz7odyPXuUPGzCprOZb0
	JnvgpG9nB7Hqe4BIBI1kJxqSv5kv9y7kVY5hrZLG/RQlxG1/ytnxTzjMc2/OI3g0monTZJVghkX
	JOJPhqcdyuFEULEkY8GyLEENV2uOi+fjSHykYEIZtFCmMyDMRvs+rzYjyZMmVsbGbiXmkaYFp0R
	TizF6RHzvj1+GhpX3wb4KAD14ephBTYRINfEFwciDvXvWTmCRBNAwtGUtwesd7EtHN3pht11vKf
	IICxjH9F74O4rnHAsDemUbuKKq1nylmcWdNx84rH3Blu3IBPLHE=
X-Google-Smtp-Source: AGHT+IEIRGRpO+vWGhV1CCBRbo++UmRwtlMFWBz96kI+Jnfb44tI67Z/xSBppUPFJ8wiUhVl/CKfFQ==
X-Received: by 2002:a05:6602:2b01:b0:841:8d66:8aea with SMTP id ca18e2360f4ac-844b510d818mr136788439f.2.1733758166860;
        Mon, 09 Dec 2024 07:29:26 -0800 (PST)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e28611e848sm2365575173.61.2024.12.09.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:29:25 -0800 (PST)
From: David Vernet <void@manifault.com>
To: tj@kernel.org
Cc: sched-ext@meta.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	ihor.solodrai@pm.me
Subject: [PATCH] scx: Fix maximal BPF selftest prog
Date: Mon,  9 Dec 2024 09:29:24 -0600
Message-ID: <20241209152924.4508-1-void@manifault.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maximal.bpf.c is still dispatching to and consuming from SCX_DSQ_GLOBAL.
Let's have it use its own DSQ to avoid any runtime errors.

Signed-off-by: David Vernet <void@manifault.com>
---
 tools/testing/selftests/sched_ext/maximal.bpf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 4c005fa71810..430f5e13bf55 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -12,6 +12,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+#define DSQ_ID 0
+
 s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 		   u64 wake_flags)
 {
@@ -20,7 +22,7 @@ s32 BPF_STRUCT_OPS(maximal_select_cpu, struct task_struct *p, s32 prev_cpu,
 
 void BPF_STRUCT_OPS(maximal_enqueue, struct task_struct *p, u64 enq_flags)
 {
-	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
 }
 
 void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
@@ -28,7 +30,7 @@ void BPF_STRUCT_OPS(maximal_dequeue, struct task_struct *p, u64 deq_flags)
 
 void BPF_STRUCT_OPS(maximal_dispatch, s32 cpu, struct task_struct *prev)
 {
-	scx_bpf_dsq_move_to_local(SCX_DSQ_GLOBAL);
+	scx_bpf_dsq_move_to_local(DSQ_ID);
 }
 
 void BPF_STRUCT_OPS(maximal_runnable, struct task_struct *p, u64 enq_flags)
@@ -123,7 +125,7 @@ void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
 
 s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 {
-	return 0;
+	return scx_bpf_create_dsq(DSQ_ID, -1);
 }
 
 void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
-- 
2.46.1


