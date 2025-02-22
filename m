Return-Path: <linux-kernel+bounces-527423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8AAA40B17
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546EA70040F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE1920B213;
	Sat, 22 Feb 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su8c9AvE"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913751CBEAA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740251198; cv=none; b=Ug7t2XjF29TMAWI6EE35EdTOuZQpfHzf27sHftwn3kjUOfVXLbxX9FZCVqraowBn8ay8jmzeh0gW3j8LYr4o+hOk95gHcRKK0DVnM9oUZjLlUW9LrtPTS6ptA9ii2flszzqIyZuNH6Fk3zocBWCNDSxl6ioP7If9aXgZMTaHkDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740251198; c=relaxed/simple;
	bh=wNNGL42KaRimbUYjIPol1fhsRgsVdv8kh4Fp/2KhCw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EIcVq2GX+NhtJJ7XFUiSsHYrVK5J26ehSgA0Rt0I6d6bsZOW5EXiBxDNTsbMljWBt/TCrLseqUg2OqSyH0eB3EwMLtoF/RyGnlmI77LgSgwpoBBLxAAQ7krSUX+qjW+DtKx/tz2Pht98UyjVTRLMVtWARX4tHtWABeSI4cn84ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su8c9AvE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c0a1677aebso309337585a.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740251194; x=1740855994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DiabidSOAyQsf+B3XgHW1kyRRESYAYqsI/IhtP+orBs=;
        b=Su8c9AvEsHtdMrF/GaMONzS4rk3eU3ZOQVd+97HVYm9LJHzfTkRL8KakRhRr4vg+u+
         w8yj5j6RvWDM/zMlB4YdAXKk/crMZdLp42YIeGCj10I+UWuE/8BfGax+pDm0MFYETLEW
         4olTfmjfEQZfQn0h9Gg7H0JDgVgrIQXOn/9NGsM0qpgiWHxaN1vY4iPHOwyduv+ywetY
         QAW36qZxZnU/IhdqDPq9eE8xMTi5z5Bm52JMamEDg6Zfev5nRoN2rI49lS+HLYZhvPwy
         QS8gs5O0dgnuTeh/nXSEZniTLxIwKF0xTg5gEnrZ7eQzr6bAYG9KOoaaYEfOSItvqegU
         Niuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740251194; x=1740855994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiabidSOAyQsf+B3XgHW1kyRRESYAYqsI/IhtP+orBs=;
        b=dAvlRs8Rgb6AXrfv7peNsElCL9o/djyqohevi/LZbmt+D5sqlC0qnBAdL/10Ae+LPm
         N+dQluk3Zjo/wdt87zkIvmKrymrVP5KZDmi5m6FXxkhc9i29fc0X1DhTrKajmdVKlJtr
         kBFARzGEuPO0hqBwCKn1g9wXCZ/77EJIMZQ8k/f8JWxOse3w14TkFBNDb+lGzMwkMqfC
         i2dfhg0oPlpOAV0zc8lqkcUc5HkjJECtqmPOHTa3TO9jH+T0l7LU+8SDARcpcpsQmveb
         CciJDWfBpHT04ThklujoAxoyht5W3i3QKMHOPHZDDPJznnmHWx3jYHEdVJ+CWTQbSrbi
         /91A==
X-Gm-Message-State: AOJu0Yxe0gjTIOkfU/8/dScruC+alL37y+Z7G6rVFefy3rf3g7UGRORB
	1hKRhLI9NMn626AaOP6eJKrEI3wNLVgzktvJW7cSFjsaDXEE9b+Gv8K5
X-Gm-Gg: ASbGncuqCBSTzIZsAnKFf15wLbh/OQzXjffBhRcmLMhjDrPJmkBDIeX+XGdXMiDqTfI
	UuDJ3BBbwc8SygBcjOUHVxCAZLpBw9qy7oJjfppCvsvUGbGn9O0gKyi1IqO09GwsbAU4MXi/Ll9
	pk7gbYhovIkG8V6MUwXVFGwWzTiJAFlSVIlw5XrugiXCHNLGVbFON6u5G46T6/V7PeVVD46ZuCQ
	WsKZO7vrbDzXNjrlucAKYVOuQDXoAA7Pf4bEfrAIe5qX7oVVj+A3bby8Uq0pOVPUjEcWvb6Yl0E
	gxVS4h4=
X-Google-Smtp-Source: AGHT+IGZZVN1cBwmGXraB8fdsm1Rz3PDOoeLjcCnTk9CoLTDIbyFoXsI9zHTAyRT5vjdDJAkXqJDPQ==
X-Received: by 2002:a05:620a:19a4:b0:7c0:b9f3:bd1e with SMTP id af79cd13be357-7c0cf96f1a3mr996524185a.49.1740251194397;
        Sat, 22 Feb 2025 11:06:34 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b1ef73b8sm550185285a.65.2025.02.22.11.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 11:06:32 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [RFC PATCH 00/11] Add a percpu subsection for hot data
Date: Sat, 22 Feb 2025 14:06:12 -0500
Message-ID: <20250222190623.262689-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new percpu subsection for data that is frequently accessed and
exclusive to each processor.  This is intended to replace the pcpu_hot
struct on X86, and is available to all architectures.

The one caveat with this approach is that it depends on the linker to
effeciently pack data that is smaller than machine word size.  The
binutils linker does this properly:

ffffffff842f6000 D __per_cpu_hot_start
ffffffff842f6000 D softirq_pending
ffffffff842f6002 D hardirq_stack_inuse
ffffffff842f6008 D hardirq_stack_ptr
ffffffff842f6010 D __ref_stack_chk_guard
ffffffff842f6010 D __stack_chk_guard
ffffffff842f6018 D const_cpu_current_top_of_stack
ffffffff842f6018 D cpu_current_top_of_stack
ffffffff842f6020 D const_current_task
ffffffff842f6020 D current_task
ffffffff842f6028 D __preempt_count
ffffffff842f602c D cpu_number
ffffffff842f6030 D this_cpu_off
ffffffff842f6038 D __x86_call_depth
ffffffff842f6040 D __per_cpu_hot_end

The LLVM linker doesn't do as well with packing smaller data objects,
causing it to spill over into a second cacheline.

Brian Gerst (11):
  percpu: Introduce percpu hot section
  x86/preempt: Move preempt count to percpu hot section
  x86/smp: Move cpu number to percpu hot section
  x86/retbleed: Move call depth to percpu hot section
  x86/percpu: Move top_of_stack to percpu hot section
  x86/percpu: Move current_task to percpu hot section
  x86/softirq: Move softirq_pending to percpu hot section
  x86/irq: Move irq stacks to percpu hot section
  x86/percpu: Remove pcpu_hot
  x86/stackprotector: Move __stack_chk_guard to percpu hot section
  x86/smp: Move this_cpu_off to percpu hot section

 arch/x86/entry/entry_32.S             |  4 +--
 arch/x86/entry/entry_64.S             |  6 ++---
 arch/x86/entry/entry_64_compat.S      |  4 +--
 arch/x86/include/asm/current.h        | 35 ++++-----------------------
 arch/x86/include/asm/hardirq.h        |  3 ++-
 arch/x86/include/asm/irq_stack.h      | 12 ++++-----
 arch/x86/include/asm/nospec-branch.h  | 10 +++++---
 arch/x86/include/asm/percpu.h         |  4 +--
 arch/x86/include/asm/preempt.h        | 25 ++++++++++---------
 arch/x86/include/asm/processor.h      | 15 ++++++++++--
 arch/x86/include/asm/smp.h            |  7 +++---
 arch/x86/include/asm/stackprotector.h |  2 +-
 arch/x86/kernel/asm-offsets.c         |  5 ----
 arch/x86/kernel/callthunks.c          |  3 +++
 arch/x86/kernel/cpu/common.c          | 17 +++++++------
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
 arch/x86/kernel/vmlinux.lds.S         |  5 +++-
 arch/x86/lib/retpoline.S              |  2 +-
 include/asm-generic/vmlinux.lds.h     | 10 ++++++++
 include/linux/percpu-defs.h           | 10 ++++++++
 kernel/bpf/verifier.c                 |  4 +--
 scripts/gdb/linux/cpus.py             |  2 +-
 31 files changed, 135 insertions(+), 109 deletions(-)


base-commit: 01157ddc58dc2fe428ec17dd5a18cc13f134639f
-- 
2.48.1


