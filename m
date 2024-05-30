Return-Path: <linux-kernel+bounces-194796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC48D423E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B161F22701
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2520228FC;
	Thu, 30 May 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kPCTzTiW"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAB36B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028257; cv=none; b=lnFuiloTlRqNoaKU/e2pga8Y9Qbs/vS4wvABshFEeLdQuzjl6/VDAjVm477hJQEt1iJ/E07RTUyfPkHMWD5N+TTfpBth/iZjGMeAwIvivTOAQW9yXAjJ11yYOFMxG/JysMBY9PdELtJ2QLKVEmcknjvQWwlZ+rVO9dEmzFAOpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028257; c=relaxed/simple;
	bh=N0smt2++7ScOhXPh6M+r1d4lJInmP2zBUg5+ve1Db4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTpz2Hht+zgMWzhmIWT0prv8kzKKbvuLDRawnnC20FHthlcojsvL8cAhiEyEbhFDK1nU9A8xvDJmWcT/QXO5c9wXeYNr0/LRFd0kkIsKaT8SD3vXU1Ntcb1jDf0CZX5FSLjS0BTlt5muutMYiyjqm2S3cWUwsWu3YB24d4nbcW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kPCTzTiW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6570bd6c3d7so220526a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717028255; x=1717633055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfeW8EqYXxaySwYF/8C+JSagNvnC45TM4Hz+nm+CSRI=;
        b=kPCTzTiWknIFzJS4uThEwxGxwQeyRR16VqvjS9RaggepPk/v5aAg7ePEFH0jYnDHzS
         lUbWg0nX30ULRmh4lwQvbLWDU3LIJtidi3v1JM5kCXqOa2CrmzuAX6Pnu0rsybHBiZ7P
         uxgtaLfo95dA8MCwFudmpLcQ/pKb+cMEdEseuq7/rOAk9tImwJaC7x95gtEcaYQiDXLV
         ks/EwVRSMzpfnwjhaGMbfipG7SwLQ8eodF8Q7DobvSfdRJddUbzgGxG004dRODTI0u+Z
         TBfTYsq7BbtaOR6zwgoxGxa2fJb/yWPcvEuQC0XN0JoBO9xBvnTGa3/xhUSDgydluV5i
         tYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028255; x=1717633055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfeW8EqYXxaySwYF/8C+JSagNvnC45TM4Hz+nm+CSRI=;
        b=AwHT5SQ7G7e8A6uRL6uOsUWEBCMZFPWdqmeztj6/4e75cWiiav1pXBFM2ePTNFBbbo
         PupTf4s4IosW70qO+S3AoQ2ycUJZLMd9VcZp9zWf/h84r+qy1SDPw5QNjuiowstg0kFv
         LR7faqrFuhVPiiiqzyk5AGv0VxkLXo/Xu7nyn9cZablIKDDrX71+wu1nJtE2KhT7b4+n
         bxj3UibdZPb9D2wPVk6CZ3wQzxwQIlWoqY05Ep72c/mxu+PAZ/SlV31nhOJGgwibNZ4X
         uA2G6KPZrTC8R+JyeWwsEnKFq3DlQIhJDmSiYUVrQXkuKYyaXJrsoZdr898vBM4oB0Us
         Nayg==
X-Gm-Message-State: AOJu0YxUqMEFmnkU37obtEiYN+d0ZZB897yR2wtv2gKnIQGAHQN1N4oQ
	juuFu27CYIxbpdP7DXNtRpJt2I6UVTV4781EyGr8uaXfI6EXGnldsiMqW2j4Qog=
X-Google-Smtp-Source: AGHT+IGxn82BdppJsiKdAmg7jIowsQcKelUH6a4zwXXajGsUSnB466N/dzB9HNnLA6+BW7yCPV+EYg==
X-Received: by 2002:a17:90b:3709:b0:2c0:29d5:3515 with SMTP id 98e67ed59e1d1-2c1abc12514mr663413a91.3.1717028254983;
        Wed, 29 May 2024 17:17:34 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776e206sm432171a91.20.2024.05.29.17.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 17:17:34 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org,
	Matthew Bystrin <dev.mbstr@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/4] riscv: Frame pointer fixes and enhancements
Date: Wed, 29 May 2024 17:15:55 -0700
Message-ID: <20240530001733.1407654-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves frame pointer support in the RISC-V kernel. Patch 1
fixes a bug in 32-bit kernels. Patch 2 prepares for patch 3, which fixes
several places where the kernel clobbers the frame pointer. Patch 4
saves a frame record in the exception entry assembly so the kernel can
unwind past exceptions. Here's an example of what the result looks like:

  [  150.315343] sysrq: Show backtrace of all active CPUs
  [  150.319827] sysrq: CPU0:
  [  150.322063] Call Trace:
  [  150.324684] [<ffffffff800059fa>] show_stack+0x2c/0x38
  [  150.329757] [<ffffffff803e0228>] sysrq_handle_showallcpus+0x78/0xbc
  [  150.336014] [<ffffffff803dfc52>] __handle_sysrq+0x152/0x15e
  [  150.341601] [<ffffffff803e0a88>] write_sysrq_trigger+0xa4/0xba
  [  150.347221] [<ffffffff80182638>] proc_reg_write+0x3e/0x80
  [  150.352787] [<ffffffff8012885e>] vfs_write+0xd8/0x302
  [  150.357625] [<ffffffff80128ba8>] ksys_write+0x58/0xaa
  [  150.362856] [<ffffffff80128c10>] __riscv_sys_write+0x16/0x1e
  [  150.368317] [<ffffffff80005650>] syscall_handler+0x1c/0x28
  [  150.373986] [<ffffffff807372c8>] do_trap_ecall_u+0x64/0xb0
  [  150.379431] [<ffffffff8073e91c>] ret_from_exception+0x0/0x70
  [  150.385207] sysrq: CPU1: backtrace skipped as idling
  [  150.385210] sysrq: CPU2: backtrace skipped as idling
  [  150.385213] sysrq: CPU3:
  [  150.397294] Call Trace:
  [  150.399717] [<ffffffff800059fa>] show_stack+0x2c/0x38
  [  150.404756] [<ffffffff803e02e6>] showacpu+0x56/0x84
  [  150.409620] [<ffffffff8009959e>] __flush_smp_call_function_queue+0x13a/0x1d2
  [  150.416657] [<ffffffff8009968c>] generic_smp_call_function_single_interrupt+0xe/0x16
  [  150.424390] [<ffffffff8000886c>] handle_IPI+0x38/0x74
  [  150.429424] [<ffffffff800659ce>] handle_percpu_devid_irq+0x82/0x106
  [  150.435678] [<ffffffff80060b72>] generic_handle_domain_irq+0x1c/0x2a
  [  150.442019] [<ffffffff8006b9de>] ipi_mux_process+0x6e/0xd6
  [  150.447490] [<ffffffff8000af48>] sbi_ipi_handle+0x30/0x46
  [  150.452876] [<ffffffff80060b72>] generic_handle_domain_irq+0x1c/0x2a
  [  150.459217] [<ffffffff80341936>] riscv_intc_irq+0x22/0x60
  [  150.464602] [<ffffffff807373b0>] handle_riscv_irq+0x30/0x4e
  [  150.470161] [<ffffffff8073736a>] do_irq+0x1a/0x30
  [  150.474851] [<ffffffff8073e91c>] ret_from_exception+0x0/0x70
  [  150.480497] [<ffffffff8033c5a0>] __percpu_counter_sum+0xbe/0xd0
  [  150.486403] [<ffffffff8033c5a0>] __percpu_counter_sum+0xbe/0xd0
  [  150.492310] [<ffffffff8000eac0>] __mmdrop+0xc8/0x208
  [  150.497260] [<ffffffff80038922>] finish_task_switch+0x120/0x198
  [  150.503167] [<ffffffff80739668>] __schedule+0x444/0x6c8
  [  150.508378] [<ffffffff80739a16>] preempt_schedule_common+0x18/0x32
  [  150.514546] [<ffffffff80739222>] preempt_schedule+0x22/0x24
  [  150.520105] [<ffffffff803e026a>] sysrq_handle_showallcpus+0xba/0xbc
  [  150.526359] [<ffffffff803dfc52>] __handle_sysrq+0x152/0x15e
  [  150.531917] [<ffffffff803e0a88>] write_sysrq_trigger+0xa4/0xba
  [  150.537737] [<ffffffff80182638>] proc_reg_write+0x3e/0x80
  [  150.543122] [<ffffffff8012885e>] vfs_write+0xd8/0x302
  [  150.548160] [<ffffffff80128ba8>] ksys_write+0x58/0xaa
  [  150.553197] [<ffffffff80128c10>] __riscv_sys_write+0x16/0x1e
  [  150.558847] [<ffffffff80005650>] syscall_handler+0x1c/0x28
  [  150.564316] [<ffffffff807372c8>] do_trap_ecall_u+0x64/0xb0
  [  150.569788] [<ffffffff8073e91c>] ret_from_exception+0x0/0x70


Samuel Holland (4):
  riscv: Fix 32-bit call_on_irq_stack() frame pointer ABI
  riscv: entry: Balance vector context nesting
  riscv: entry: Do not clobber the frame pointer
  riscv: entry: Save a frame record for exceptions

 arch/riscv/include/asm/processor.h  |  9 ++++-
 arch/riscv/include/asm/ptrace.h     |  5 +++
 arch/riscv/include/asm/stacktrace.h |  5 ---
 arch/riscv/kernel/asm-offsets.c     | 10 ++---
 arch/riscv/kernel/entry.S           | 60 +++++++++++++++--------------
 arch/riscv/kernel/head.S            |  6 +--
 arch/riscv/kernel/process.c         |  5 +--
 arch/riscv/kernel/stacktrace.c      |  9 -----
 8 files changed, 53 insertions(+), 56 deletions(-)

-- 
2.44.1


