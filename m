Return-Path: <linux-kernel+bounces-534587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D8A468DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457C1188901B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70F22A4EE;
	Wed, 26 Feb 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEhDvmH3"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBF15C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593146; cv=none; b=LuwR6EHq5AJ86KdNzwompgnZsWOeR/qkWovXQ36uNWkj3tyqBbTMJwJFwBskoGz5dOPjqPpTfbkh07DCBKMBaDPRC3Vd3OJoQG1gtJruZ6DfM+mRmsu7tITIIyT2dwahLP3QQmGc0bLtIXhwA3VbU3C+aZCxYeNpaSQS1QgXG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593146; c=relaxed/simple;
	bh=ngoCWJX4CUA0JSDhJwkmDaUULzz7vYiJM8kke5KaMCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4LJX4CqAqT8BX8y9BiTN+53YFCjpyv+AcDPjwGcy29SKsrzSRjJwuT8FtYQFqp/8TWVhvu3m2GC+KIGmtd7a5MBblRhCxF357RrHW7tYVcQPsByVQxDjRYNpW3DHiu4sl3VAU6pVPNajOsQNsQ/88pazObt2z1HW/8ciDtPcyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEhDvmH3; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fe944a4243so17710eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593143; x=1741197943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YsKWU3mUHpcYwy8+vNE0NIZ0U7OB9SGdvrVAuNSLuaY=;
        b=QEhDvmH3VbOELhLxEyI7uZUcMa+OTW1U6bokHoYgjmugnlTAnVL+89NkQwuL/wsyCS
         OsECjTXAAC+UHr2Ji0mgZITuJTmE+Rq2d/ViaovPc4mG2sLeEw4EDMe8xt/KwkXQ9Ju8
         ZMEtUbsx10jNDsUUVRfA5zORQ0Us/oRl+Cu5za8jgXINaK4LdwLhZtBYeOnSEooroDpR
         jXzB0XsAZXQt32QMbof17DhAr8THmeoGDsux7LFHGciClDFndD50YmcjJQkm6/p6hvgD
         syyd3+B9UKLuNC3h7O0wUHKnAtlYRw8oWGqBAEYee2t9hJmeQzB/flD8GBuMrFld9URU
         Uh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593143; x=1741197943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YsKWU3mUHpcYwy8+vNE0NIZ0U7OB9SGdvrVAuNSLuaY=;
        b=gNFBZG7dVPjJ4sEIZKS6ePvkkqBGivfiH9Ddt8923N06Etse3sAU9nceKfpnGxJXP9
         XnL3asVdzbSlasRSQTxvtmdKmQ+Go4dnkESGKVRSs9uEzR5bqnsylu8bSNv9E2MPo7tJ
         9YdMT55e66nhG2Urkv+g+UJPcp19sOYkR7gNWyok5Nd84MI5RIP3jWVST/O78KyAMnyR
         XUPX4oIexo45a6fvY7av19Zx4FkTI1lkBrZa2ujBjiBbDRAn3hR545jrU4ojNJCrfW1x
         JueNxh0BzCB1mx1nC+nOKBIkHuEpEPOjhOXK+MgLl7hZiT4yGWVEbuOUD0sEIBvkQIWV
         Mngw==
X-Gm-Message-State: AOJu0Yx8miSb1N/aUDPcyxfUGn1McPA8Hu4O8TP9bJ1QRtuXEbf5e8RX
	1cPoWkfN51wC8WJGbV4/mkbKE8IHIVJeDHveUfbH10dYXj3vX23u70iP
X-Gm-Gg: ASbGncvxFbLu4i1liYCCEkpGp8bzOtE1RJlGcHlrxux9zyK1K+j05lleU3AdiS3Ip1X
	OXFGerozqL1u0IQCJXgJ+bT7WoMimnhZa/1K2931jA1N80xqPGgwI1Gbp4YCLugAxWS6dqfIKxk
	wjmD5mVZ2nAm3S1QyF+rxzszx1Eaae84HtkTesM4kPc1zSul5TmUQnZDyC/4PyA7VqoNYco9j9F
	4vhhdWb2DrZ6N2AzZx3+lRt2WNq9/qeO+9AgT5KIJc9Q4KJ3gNr6VEo9elnFgFEgDy5GGD0xFG/
	IU1elGE=
X-Google-Smtp-Source: AGHT+IHG68qmAtC9E9LEE2jD/xT3yR5pNModwoVZOUMScDAABq4J7BD70cWJwddVZFtQ70M1I3E1ZQ==
X-Received: by 2002:a05:6820:168d:b0:5fd:1401:7d32 with SMTP id 006d021491bc7-5fe93817a02mr3425256eaf.8.1740593141588;
        Wed, 26 Feb 2025 10:05:41 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fe9428c8b3sm755069eaf.39.2025.02.26.10.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:05:41 -0800 (PST)
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
Subject: [PATCH v2 00/11] Add a percpu subsection for cache hot data
Date: Wed, 26 Feb 2025 13:05:19 -0500
Message-ID: <20250226180531.1242429-1-brgerst@gmail.com>
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

ffffffff842fa000 D __per_cpu_hot_start
ffffffff842fa000 D hardirq_stack_ptr
ffffffff842fa008 D __ref_stack_chk_guard
ffffffff842fa008 D __stack_chk_guard
ffffffff842fa010 D const_cpu_current_top_of_stack
ffffffff842fa010 D cpu_current_top_of_stack
ffffffff842fa018 D const_current_task
ffffffff842fa018 D current_task
ffffffff842fa020 D __x86_call_depth
ffffffff842fa028 D this_cpu_off
ffffffff842fa030 D __preempt_count
ffffffff842fa034 D cpu_number
ffffffff842fa038 D __softirq_pending
ffffffff842fa03a D hardirq_stack_inuse
ffffffff842fa040 D __per_cpu_hot_end

This applies to the tip/x86/asm branch.

Changes in V2:
- Renamed macros to *_PER_CPU_CACHE_HOT()
- Restored 64-byte limit.
- Added note that this is only to be used by arch and core code.
- Reserve call depth space even when the mitigaion is disabled.
- Use SORT_BY_ALIGNMENT() for dense data packing.
- Remove now unnecessary includes of current.h, fixing up some indirect
  includes.

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
 arch/x86/include/asm/processor.h      | 15 +++++++++--
 arch/x86/include/asm/smp.h            |  7 +++---
 arch/x86/include/asm/stackprotector.h |  2 +-
 arch/x86/kernel/asm-offsets.c         |  5 ----
 arch/x86/kernel/cpu/common.c          | 25 +++++++++++++------
 arch/x86/kernel/dumpstack_32.c        |  4 +--
 arch/x86/kernel/dumpstack_64.c        |  2 +-
 arch/x86/kernel/head_64.S             |  4 +--
 arch/x86/kernel/irq.c                 |  8 ++++++
 arch/x86/kernel/irq_32.c              | 12 +++++----
 arch/x86/kernel/irq_64.c              |  6 ++---
 arch/x86/kernel/process_32.c          |  6 ++---
 arch/x86/kernel/process_64.c          |  6 ++---
 arch/x86/kernel/setup_percpu.c        |  7 ++++--
 arch/x86/kernel/smpboot.c             |  4 +--
 arch/x86/kernel/vmlinux.lds.S         |  6 ++++-
 arch/x86/lib/retpoline.S              |  2 +-
 include/asm-generic/vmlinux.lds.h     | 10 ++++++++
 include/linux/percpu-defs.h           | 12 +++++++++
 include/linux/preempt.h               |  1 +
 kernel/bpf/verifier.c                 |  4 +--
 scripts/gdb/linux/cpus.py             |  2 +-
 31 files changed, 145 insertions(+), 111 deletions(-)


base-commit: 79165720f31868d9a9f7e5a50a09d5fe510d1822
-- 
2.48.1


