Return-Path: <linux-kernel+bounces-187205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC698CCE91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1EB1C22396
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603ED13D29D;
	Thu, 23 May 2024 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmI1lbDD"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76DD13D28C
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453814; cv=none; b=qKrXsVYMAiulI6Q5Y7ZZdxXIcQLeEuJ32ZOFZ8+o76+voUxFFi+1jgHth10EGwWfJJC85cznkIcFh0Jti5c7iW0YpI3FJMcyswY5FouK1eJkjhZuryMaP28t0npb0pzCDqs7xPKoOI2Gy/ikUwp2zUqjp0ZULjlk01CEpZNhcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453814; c=relaxed/simple;
	bh=7Nx57xzjK255CGbSbs92Xr9PidgVaqywyNdpKJ9s3Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMJp5Y/+h52cfiXaB8lp4unq7Obni1Dl3Oi0tPpe7PKK63nsKX16Oi2cIOrU9gGnlh0YrJe/bsc3KpVpVE3JgF50nCaGmV27w1i6Who6ykEIaJrNlYb/1eZ2wNizcTLWr6bqRwFzK70GfCwuzFcbzvOBNLNcTsh8IcthC+Jtc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmI1lbDD; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3e18c240fso71353101fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716453811; x=1717058611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xm4aIfmcPgLaTdq2sWutAdQtLGIZwY55+PCwPzLdWE=;
        b=JmI1lbDDXeQkjTzOZ3FOej+YWVzO8Jnys196AFG7sKvOJNP20eXxKD9EgRiYkRVqlq
         ZUAxv2Z8HQxmSUAilUdH1m3hTujxbNGKuHfACIxyYPzAYN0ijbofGgCYMEcjEKTMmHAo
         x55BXhTh17Oc6c7fUy26QEXA+we21IAio3ymUdUwp+hRMxvqd6Ha0AE0KdyKEWYNvGit
         pR6BxdyZ5HbWBTxWXsXOv2qfyOAtsYjE2suME9pibJCVqRxP1YK5MMyyEukQCCr4T/zQ
         DrCP9AvmaPp/sXR9f/zPQ46xcqcGq+W79lqd3iY6M6BezpnJ036XuOwfDb7bva53PU3F
         xcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716453811; x=1717058611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xm4aIfmcPgLaTdq2sWutAdQtLGIZwY55+PCwPzLdWE=;
        b=kxYt3CVG99Sn4FYrkB8czhSMeT8S1WMTz93nasTZklBpfKBMj4aPwPLfUSsixkmkoI
         3NTzFlARCEpG8Sdf6ydV66xWYKWn/QcEPKvsL3bT2/vkJZ+TkjlCSNvh69nmoFwrXveK
         gqCjXL5QkzuCD+dYmKFewMlv57k+8rgPaPtv1ihKpQQf19ZozNNpMeTdLWCFLD+tgzfm
         APxIYwh1ljERpkt22MYgaVoosSgstfgXe7t7jrAAK5w6OojMq3NuKzKb/Fm6cwTBE353
         q/czzXy4keIut4h/k/kQPSosENXoP3qr4pv5Bm1z5AzsCYPaEGihFEpBvN51slNhSEyU
         6Yhg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+17qOfwtaj1B+lsd4y7sggPIDBtgflw1PNU1dJEiX7hge7Mr55iFYfilppTMcIMMzoP94lPExl70nbcSYlzQe7Ep5mHVUGYEq0eN
X-Gm-Message-State: AOJu0YwEgJEu1fzY3ziNG1euzjdJB2j4OyUbnFdM4XaBJyghLEYwJGLp
	7aOQVYwPLIid1LSxhnxS1qiaBZ6kxvv83ReQpOf4OUml8v7axWh5
X-Google-Smtp-Source: AGHT+IFuJT+Iycu4zUWyrnDMP2GPSB3ySw2LtbIA56wh9nYmdvR4vP/m7p0AEJR7txQa+azNtF7EjQ==
X-Received: by 2002:a2e:3609:0:b0:2e1:ae29:f28a with SMTP id 38308e7fff4ca-2e94959c736mr34882401fa.34.1716453810739;
        Thu, 23 May 2024 01:43:30 -0700 (PDT)
Received: from localhost.localdomain ([5.188.167.245])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm19233781fa.112.2024.05.23.01.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:43:29 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: [PATCH v2] riscv: prevent pt_regs corruption for secondary idle threads
Date: Thu, 23 May 2024 11:43:23 +0300
Message-ID: <20240523084327.2013211-1-geomatsi@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Top of the kernel thread stack should be reserved for pt_regs. However
this is not the case for the idle threads of the secondary boot harts.
Their stacks overlap with their pt_regs, so both may get corrupted.

Similar issue has been fixed for the primary hart, see c7cdd96eca28
("riscv: prevent stack corruption by reserving task_pt_regs(p) early").
However that fix was not propagated to the secondary harts. The problem
has been noticed in some CPU hotplug tests with V enabled. The function
smp_callin stored several registers on stack, corrupting top of pt_regs
structure including status field. As a result, kernel attempted to save
or restore inexistent V context.

Fixes: 9a2451f18663 ("RISC-V: Avoid using per cpu array for ordered booting")
Fixes: 2875fe056156 ("RISC-V: Add cpu_ops and modify default booting method")
Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes since v1 [1]:
- fixed git revisions in commit message

[1] https://lore.kernel.org/linux-riscv/20240424221927.900612-1-geomatsi@gmail.com/

---
 arch/riscv/kernel/cpu_ops_sbi.c      | 2 +-
 arch/riscv/kernel/cpu_ops_spinwait.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 1cc7df740edd..e6fbaaf54956 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -72,7 +72,7 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	/* Make sure tidle is updated */
 	smp_mb();
 	bdata->task_ptr = tidle;
-	bdata->stack_ptr = task_stack_page(tidle) + THREAD_SIZE;
+	bdata->stack_ptr = task_pt_regs(tidle);
 	/* Make sure boot data is updated */
 	smp_mb();
 	hsm_data = __pa(bdata);
diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index 613872b0a21a..24869eb88908 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -34,8 +34,7 @@ static void cpu_update_secondary_bootdata(unsigned int cpuid,
 
 	/* Make sure tidle is updated */
 	smp_mb();
-	WRITE_ONCE(__cpu_spinwait_stack_pointer[hartid],
-		   task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_spinwait_stack_pointer[hartid], task_pt_regs(tidle));
 	WRITE_ONCE(__cpu_spinwait_task_pointer[hartid], tidle);
 }
 
-- 
2.44.0


