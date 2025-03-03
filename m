Return-Path: <linux-kernel+bounces-542371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A8A4C914
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4B916A760
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F51E25DCE4;
	Mon,  3 Mar 2025 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwrkEWOT"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDD25DCE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020793; cv=none; b=ubg9c9x4swcpAleRoFoXRx49OL37frUor8t+KR/RZibsoawjZsksCcPO11mOPfBBHY2BMyB+1OPDYMuUgUod6kRVGMCMJuWTny+qOQz7cTJAqQmshfZAp5Z/rEhUz+jhzle6Ijko/6QxhcNcW0hp7esf9sBCOULS7JgEglLHNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020793; c=relaxed/simple;
	bh=nh7jbE8u6LWbKN97HqpSqJtJmYm/xnEKtr4eKp/8D9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNMPhrZQm2/c9CLu9g7c7C342y4XMIrGJeW7DNgCY5+mB0vr3QrQnE4Hj5IKpm52hVb+a6ixZsL2WSoMfxDrxkk36yg1bNsnkxGH96nCY8qzf4aU1JkudpP47gNB1sd/4GFiCirjV0atlwm9n/Cyxg3sGdGk8m8qyxlb455LKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwrkEWOT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07cd527e4so426895885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741020789; x=1741625589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXZMOjTfHdSZ0Fo7cW/JpFxM3Ukm8A0bcRpa5UuF7HY=;
        b=VwrkEWOTCXCekuPtL5petw2iRCubK96IR0cqtmAlCL2/RU/B1Glqug697hJDLwvPw6
         JnL9wGfUE0KsjOsizMXlJ3Wbt2a7F7rvinJfF19tYX9mc44v4+Fwvlz5AQaORcEqMSG9
         Esv9QPnowRPfcWz1mZuCclZNb5kNejqKHdYISFHxJtS6C41Uvq5DZ7UROISjA0f2CXxz
         P8FGWBd+mdJ1dMO2HtdFU34m02zzdNz8u3rMQ7shLTDfqC0W9MI+Sd7Qf4QSLGIcLhEs
         ogyWhk5OdCYEBcGBPOeWqSm6y2/IwhZD1iMzJukssnhHVm6GggjmSs8Y4kE/KcullZXE
         7MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020789; x=1741625589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXZMOjTfHdSZ0Fo7cW/JpFxM3Ukm8A0bcRpa5UuF7HY=;
        b=r+npmdb5YM72BI+241KI1ZKRd/vSC68BxYmc6wr97nDxK3+yyA9w/euz35ONUfWl31
         mwaXWZPWpaFhGVkoJlxfhnmXVd612NjU7RcszHH6jCOFnDdSGB2VIG2dbxQQiUl+kmSH
         wIIZ09foifim6xvvSfMJ52D13JLp6tc1OvZIOo7xLACJZkU4BMXC4H9vMSUdkMpzimvP
         TLZFN4+CbOEyKDxtaVL83qJvlgmOuntIUnEnlokkNk+I2PPhvHF9azPL5m3RSkztCi8s
         gSs69x1n3qv6rgR2Nu6Bz6axwGPBH2wMEE25jj7w+YMYKkXi/O9furguKFEQBwxyuEKN
         QGJw==
X-Gm-Message-State: AOJu0YzPL0E2rGOZ4VkWcXSLllVFg1xmonRLMCJ8JRr9m1dyS9qGWz+A
	97RfnndTZrFvgaCI5JhdsB741qFFOKym+4Rjz7OFdVZJG1fQbMlqWNSU
X-Gm-Gg: ASbGnctYdsCstWBuuqrtDCzQEMS8ic1/YdCVsrGzZMwMz+GHYLd2bScZLHynTZbppG2
	xxu5C+f1pFkGE0bLDXNnpn67VqMxbLusqKDNTGP+8Kc1XHHJh18P1llBJ7VMwTp7GwXcYMupCX9
	KXiHaea6W3nV5afQaeiHyUKnmyW6SpyEXdypANRTDDAODxlzNzwv9/GrYPufQtbs7e0CdoZi2mQ
	sHn7KHZwDSe/LG2ZfthZw2dK4X08GWKUH6UJCTys8ONvKbu/+wWfqlEbniRwnYJLgclq5HFCRXO
	SrpZS6RDEIGyjnYCjDvaQKfSgw==
X-Google-Smtp-Source: AGHT+IHdrIXD6GHVaxbVyWpx/LAhFdATy0P2gAkCesSMqLmABu+o5LX5YPzeXQ7qI7aPziLPcOkHcw==
X-Received: by 2002:a05:620a:c4a:b0:7c0:c00e:5913 with SMTP id af79cd13be357-7c39c677155mr2300119485a.48.1741020789597;
        Mon, 03 Mar 2025 08:53:09 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc9cdsm54730936d6.88.2025.03.03.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:53:08 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 00/11] Add a percpu subsection for cache hot data
Date: Mon,  3 Mar 2025 11:52:35 -0500
Message-ID: <20250303165246.2175811-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new percpu subsection for data that is frequently accessed and
exclusive to each processor.  This replaces the pcpu_hot struct on x86,
and is available to all architectures and the core kernel.

ffffffff834f5000 D __per_cpu_hot_start
ffffffff834f5000 D hardirq_stack_ptr
ffffffff834f5008 D __ref_stack_chk_guard
ffffffff834f5008 D __stack_chk_guard
ffffffff834f5010 D const_cpu_current_top_of_stack
ffffffff834f5010 D cpu_current_top_of_stack
ffffffff834f5018 D const_current_task
ffffffff834f5018 D current_task
ffffffff834f5020 D __x86_call_depth
ffffffff834f5028 D this_cpu_off
ffffffff834f5030 D __preempt_count
ffffffff834f5034 D cpu_number
ffffffff834f5038 D __softirq_pending
ffffffff834f503a D hardirq_stack_inuse
ffffffff834f503b D __per_cpu_hot_pad
ffffffff834f5040 D __per_cpu_hot_end

This applies to the tip/x86/asm branch.

Changes in v3:
- Fix typo of CACHE_HOT_DATA()
- Move hardirq_stack_inuse to irq_64.c
- Add __per_cpu_hot_pad to show the end of the actual data

Brian Gerst (11):
  percpu: Introduce percpu hot section
  x86/percpu: Move pcpu_hot to percpu hot section
  x86/preempt: Move preempt count to percpu hot section
  x86/smp: Move cpu number to percpu hot section
  x86/retbleed: Move call depth to percpu hot section
  x86/softirq: Move softirq_pending to percpu hot section
  x86/irq: Move irq stacks to percpu hot section
  x86/percpu: Move top_of_stack to percpu hot section
  x86/percpu: Move current_task to percpu hot section
  x86/stackprotector: Move __stack_chk_guard to percpu hot section
  x86/smp: Move this_cpu_off to percpu hot section

 arch/x86/entry/entry_32.S             |  4 +--
 arch/x86/entry/entry_64.S             |  6 ++---
 arch/x86/entry/entry_64_compat.S      |  4 +--
 arch/x86/include/asm/current.h        | 36 +++++----------------------
 arch/x86/include/asm/hardirq.h        |  4 +--
 arch/x86/include/asm/irq_stack.h      | 12 ++++-----
 arch/x86/include/asm/nospec-branch.h  | 11 ++++----
 arch/x86/include/asm/percpu.h         |  4 +--
 arch/x86/include/asm/preempt.h        | 25 ++++++++++---------
 arch/x86/include/asm/processor.h      | 16 ++++++++++--
 arch/x86/include/asm/smp.h            |  7 +++---
 arch/x86/include/asm/stackprotector.h |  2 +-
 arch/x86/kernel/asm-offsets.c         |  5 ----
 arch/x86/kernel/cpu/common.c          | 25 +++++++++++++------
 arch/x86/kernel/dumpstack_32.c        |  4 +--
 arch/x86/kernel/dumpstack_64.c        |  2 +-
 arch/x86/kernel/head_64.S             |  4 +--
 arch/x86/kernel/irq.c                 |  5 ++++
 arch/x86/kernel/irq_32.c              | 12 +++++----
 arch/x86/kernel/irq_64.c              |  7 +++---
 arch/x86/kernel/process_32.c          |  6 ++---
 arch/x86/kernel/process_64.c          |  6 ++---
 arch/x86/kernel/setup_percpu.c        |  7 ++++--
 arch/x86/kernel/smpboot.c             |  4 +--
 arch/x86/kernel/vmlinux.lds.S         |  6 ++++-
 arch/x86/lib/retpoline.S              |  2 +-
 include/asm-generic/vmlinux.lds.h     | 11 ++++++++
 include/linux/percpu-defs.h           | 13 ++++++++++
 include/linux/preempt.h               |  1 +
 kernel/bpf/verifier.c                 |  4 +--
 scripts/gdb/linux/cpus.py             |  2 +-
 31 files changed, 146 insertions(+), 111 deletions(-)


base-commit: 693c8502970a533363e9ece482c80bb6db0c12a5
-- 
2.48.1


