Return-Path: <linux-kernel+bounces-245224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF992AFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 08:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD0B21BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B1137775;
	Tue,  9 Jul 2024 06:17:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027D313D880
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505862; cv=none; b=ps8lKbKdC8w45WOC5KzlylmoUvjpFdD3pryJn49pjETjECBPLjSahcW5JFvs6OxcX8OgC0/uVTVbiRSnqSKzfzRvSbSX7j+Tjv8PygfSCEruuMZekhVG7/NZubki4AzsPs6GXhNomU2Tc5QVW9IP7J+T25ac+cD3MgXBsAzggZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505862; c=relaxed/simple;
	bh=djPFSd+2sRP2JUUUvQgwbkO4FgL8QqFF2RjxsyowKYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgDlWym9PibNtioydjA0cH19Y1z3ESQD3sCYy0WtMFhGWYA0byv+JTPMDYxYh68lenGuwTHVAjAwmjvolIXp50oD+HGjgsgReFQXLDNYYtL6BIEtGALqp/zz8/FoZWCvV7KDsZ/r2pqmn0CeWBRo6UC0GSARJiIGzy4PTshsk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxHOv_1Yxm50wCAA--.6956S3;
	Tue, 09 Jul 2024 14:17:35 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxlsX+1Yxm3qJAAA--.6942S2;
	Tue, 09 Jul 2024 14:17:34 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Check TIF_LOAD_WATCH to enable user space watchpoint
Date: Tue,  9 Jul 2024 14:17:31 +0800
Message-ID: <20240709061731.11025-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxlsX+1Yxm3qJAAA--.6942S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWruw45Kryftr1Duw13KFX_yoW8urWkpr
	y7AFyktrWUJrWkGasxtw1DZrW3JrnF93y7uw1fC3yYywn8XFW3Xrn7Cr9rXF4Ykw1fJ34F
	vrna9ryYqF4UXabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU

Currently, there are some places to set CSR_PRMD_PWE, the first one is in
hw_breakpoint_thread_switch() to enable user space singlestep via checking
TIF_SINGLESTEP, the second one is in hw_breakpoint_control() to enable user
space watchpoint. For the latter case, it should also check TIF_LOAD_WATCH
to make the logic correct and clear.

Fixes: c8e57ab0995c ("LoongArch: Trigger user-space watchpoints correctly")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/hw_breakpoint.c | 2 +-
 arch/loongarch/kernel/ptrace.c        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/hw_breakpoint.c b/arch/loongarch/kernel/hw_breakpoint.c
index 621ad7634df7..a6e4b605bfa8 100644
--- a/arch/loongarch/kernel/hw_breakpoint.c
+++ b/arch/loongarch/kernel/hw_breakpoint.c
@@ -221,7 +221,7 @@ static int hw_breakpoint_control(struct perf_event *bp,
 		}
 		enable = csr_read64(LOONGARCH_CSR_CRMD);
 		csr_write64(CSR_CRMD_WE | enable, LOONGARCH_CSR_CRMD);
-		if (bp->hw.target)
+		if (bp->hw.target && test_tsk_thread_flag(bp->hw.target, TIF_LOAD_WATCH))
 			regs->csr_prmd |= CSR_PRMD_PWE;
 		break;
 	case HW_BREAKPOINT_UNINSTALL:
diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrace.c
index 200109de1971..19dc6eff45cc 100644
--- a/arch/loongarch/kernel/ptrace.c
+++ b/arch/loongarch/kernel/ptrace.c
@@ -589,6 +589,7 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 	struct perf_event *bp;
 	struct perf_event_attr attr;
 	struct arch_hw_breakpoint_ctrl ctrl;
+	struct thread_info *ti = task_thread_info(tsk);
 
 	bp = ptrace_hbp_get_initialised_bp(note_type, tsk, idx);
 	if (IS_ERR(bp))
@@ -613,8 +614,10 @@ static int ptrace_hbp_set_ctrl(unsigned int note_type,
 		if (err)
 			return err;
 		attr.disabled = 0;
+		set_ti_thread_flag(ti, TIF_LOAD_WATCH);
 	} else {
 		attr.disabled = 1;
+		clear_ti_thread_flag(ti, TIF_LOAD_WATCH);
 	}
 
 	return modify_user_hw_breakpoint(bp, &attr);
-- 
2.42.0


