Return-Path: <linux-kernel+bounces-402580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB509C2952
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 02:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BECA11C2296F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496E1EB44;
	Sat,  9 Nov 2024 01:46:38 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99619186A
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 01:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731116798; cv=none; b=XZgZ9p0JQNCK6j5Gkr/ZRAVZurc7s+mzHGDq0r+omE8LYRd8MBzzQjXRpHrRILRM2eLyVcB2imrvAwDFc5LDg5cddbT6kaF/vorcn036riSR5KNNcb+HcZN8OMSzyMaBPzHCUqAIvMaEn8Fg+PNAPiuN3b4L6pFL0roz+qASYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731116798; c=relaxed/simple;
	bh=bzOwFRjK704wz1CuYTvTd+UgRG96nVH4pqudmaNwhC4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dH5R0Q4zfqC5++RDfFoTGalvNsfanv2RJ6Enat3jjTQhh1ugL2nCBM0ltkLxMzCPazl+V9lL3CytsMCrI+510HiO7zUR+OPc8yrTIO11gs7XbfHZS9LyiBFRte6NIP4Tlbl2mLQbvRsrjdh2UkNzPzL4wiO2FYLgS6QaI6i+VNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XldsP6c6Mz2Fbqh;
	Sat,  9 Nov 2024 09:44:41 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 56DAA1400CB;
	Sat,  9 Nov 2024 09:46:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 9 Nov
 2024 09:46:25 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<alexghiti@rivosinc.com>, <puranjay@kernel.org>, <zhangchunyan@iscas.ac.cn>,
	<cuiyunhui@bytedance.com>, <ruanjinjie@huawei.com>, <guoren@kernel.org>,
	<bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] riscv: Remove unused TASK_TI_FLAGS
Date: Sat, 9 Nov 2024 09:46:05 +0800
Message-ID: <20241109014605.2801492-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Since commit f0bddf50586d ("riscv: entry: Convert to generic
entry"), TASK_TI_FLAGS is not used any more, so remove it.

Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/riscv/kernel/asm-offsets.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index c2f3129a8e5c..d3ad87fcf1ef 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -36,7 +36,6 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
 
 	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
-	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
-- 
2.34.1


