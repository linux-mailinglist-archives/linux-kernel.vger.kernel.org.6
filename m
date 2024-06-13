Return-Path: <linux-kernel+bounces-212708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5DE906528
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E16B22DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4B13BC13;
	Thu, 13 Jun 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hdWF+JAS"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD513C3E2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263962; cv=none; b=aJnaW1KicGzEKt0I1i6LSo1jZAGq7A2kXwxLVva9kLL3ComC7mhgUj2n9cLDYFddL+ybGerBo7kXPybjC0e9duemOpV99ieNkNVxFEN6ZiQ9aXGnStMKQ7W27wKuAVzFwdlU8abxZjxcaEQccX5sgrtiDM2+azpgI4x6Sp1qX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263962; c=relaxed/simple;
	bh=vEH4B/nWb5j8tsvBXi0MDsuLT+abhB89bcABJJ3eO6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Py+XeLqj4NGWut0JOsbHpw+WN2Y3OvH7ga7xWRsqmUrjkQDcA3pclt0NCFDAy81NdzyOoL1cIWqZdIT4CBOW6STesErizs6NguGGUYntsfVhXA0Nx92MRbdS773jUetvX7t77wn/jbzuOF5rNDIwJe9rH7ZNoresi4WJAF0s0jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hdWF+JAS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254efc9ca45so446398fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263960; x=1718868760; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYkT3MY6oOMowcuPeCUIoQ2Ndwhv5Wfye8oIKBe0p2g=;
        b=hdWF+JASGzcCefhDgvhLcbGNNkwHsPGKbfEgtZNJofVNMWVhHUjr52gXyBYL9k00Mo
         /rDrfcT4nQy4W31cviA4yC7Xl2tFEjn94WdGmvfyQNAK+I0sJ0D2BIc8MFnoEUj/xdHj
         NgMLLpbRwqazmRo8ukQeoMjaNXGcKhbuS+Qu5s0eXg7SrEMAmvBCD4GV0xO/Du5Wu34n
         nRR//bPiJ/mrj46NhDP3mDFCg3EeEEVXtDQbJiKfbj+CSAtJ3e0e/9+pmu7kuLkzroOF
         cTfG9+jK6hEX9BRGS5hZsX4z/aV2j7gZ2s2mksSCnSsaQ9sQTT/5OTT7JkAdkw/+xxA4
         n2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263960; x=1718868760;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYkT3MY6oOMowcuPeCUIoQ2Ndwhv5Wfye8oIKBe0p2g=;
        b=Ywl1KHRPglWUddkYatC1RmllHthNrEDHTx9mq9V5ekcW+9Q30ijG1Z0pmppn3mw4IW
         upfynRxccw7VjcfXx3z4kvZdT+EuPijmh8xaoIFrcazcG8AyL23RiYxAX8/bJiaWhkQV
         baHc5ZjnPzK5t6VPttdjThLIpvq46wGkU0pfsKz6nMOAZ+VGHAB4fheFVpMFLsvH4Y0e
         LtUgqkUMfXjwNd4qTNZC2QpMR6PR6zkzJhSMlJ7uFG4cL3qoXc59DAZ75/FHUivDBzgt
         t6RedTFa0CNd7Y2fv76lx9XgFuTNRYaos75JrvFmCZpKjGUIaaiczGjoD86+nu803o8N
         Kp+g==
X-Forwarded-Encrypted: i=1; AJvYcCUUdMFsO9bhy7Szyw/Flj7kktLXhFPMr/UwVJxcQez0snNrr+Wcok3Gyq3psQJbAiDM1cRd5jgPXDI22z8ZrMATZCGx+rZxjXqFcCHR
X-Gm-Message-State: AOJu0YxdEQDZ2hmzaNeCF+Evo1QJxduKKEQbCwosbwXMEhi8LMSPKZ0O
	RvjCXUGSQ2PxlgRjA4jSAyyWDP5hGgy3EC686orAIMD0xT5dOL1sS7jcvMOx2xs=
X-Google-Smtp-Source: AGHT+IGmYhRnTeJ1bd7J2EL+xnsQNgi//5OJtSEKyWJEXOiAjofEj7fKYDnP/Ta8QspMsNmDQvrm/A==
X-Received: by 2002:a05:6870:392b:b0:254:8006:8e06 with SMTP id 586e51a60fabf-25514c94529mr4505658fac.31.1718263960249;
        Thu, 13 Jun 2024 00:32:40 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:39 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH 0/8] riscv: ftrace: atmoic patching and preempt
 improvements
Date: Thu, 13 Jun 2024 15:11:05 +0800
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAImbamYC/x3MMQqAMAxA0atIZgOtFkGvIg6hiZqlSitFkd7d4
 viG/19IElUSTM0LUbImPUKFbRvwO4VNULkaOtM5M9geWTJS4McjPwHXK5IXzA5HZ9mRMUJ2hFq
 fUVa9//O8lPIBP9tutWkAAAA=
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>, 
 Evgenii Shatokhin <e.shatokhin@yadro.com>
X-Mailer: b4 0.12.4

This series makes atmoic code patching possible in riscv ftrace. A
direct benefit of this is that we can get rid of stop_machine() when
patching function entries. This also makes it possible to run ftrace
with full kernel preemption. Before this series, the kernel initializes
patchable function entries to NOP4 + NOP4. To start tracing, it updates
entries to AUIPC + JALR while holding other cores in stop_machine.
stop_machine() is required because it is impossible to update 2
instructions, and be seen atomically. And preemption must have to be
prevented, as kernel preemption allows process to be scheduled out while
executing on one of these instruction pairs.

This series addresses the problem by initializing the first NOP4 to
AUIPC. So, atmoic patching is possible because the kernel only has to
update one instruction. As long as the instruction is naturally aligned,
then it is expected to be updated atomically.

However, the address range of the ftrace trampoline is limited to +-2K
from ftrace_caller after appplying this series. This issue is expected
to be solved by Puranjay's CALL_OPS, where it adds 8B naturally align
data in front of pacthable functions and can  use it to direct execution
out to any custom trampolines.

The series is composed by two parts. The first part (1-3) cleans up
existing issues that was found during testing of and not caused by the
implementation. The second part modifies the ftrace code patching
mechanism (4-6) as mentioned above. Then prepare ftrace to be able to
run with kernel preemption (7,8)

---
Andy Chiu (8):
      riscv: stacktrace: convert arch_stack_walk() to noinstr
      tracing: do not trace kernel_text_address()
      riscv: ftrace: support fastcc in Clang for WITH_ARGS
      riscv: ftrace: align patchable functions to 4 Byte boundary
      riscv: ftrace: prepare ftrace for atomic code patching
      riscv: ftrace: do not use stop_machine to update code
      riscv: vector: Support calling schedule() for preemptible Vector
      riscv: ftrace: support PREEMPT

 arch/riscv/Kconfig                 |   3 +-
 arch/riscv/Makefile                |   7 +-
 arch/riscv/include/asm/ftrace.h    |  11 +++
 arch/riscv/include/asm/processor.h |   5 ++
 arch/riscv/include/asm/vector.h    |  22 +++++-
 arch/riscv/kernel/asm-offsets.c    |   7 ++
 arch/riscv/kernel/ftrace.c         | 133 ++++++++++++++++---------------------
 arch/riscv/kernel/mcount-dyn.S     |  25 +++++--
 arch/riscv/kernel/stacktrace.c     |   2 +-
 kernel/extable.c                   |   4 +-
 10 files changed, 129 insertions(+), 90 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240613-dev-andyc-dyn-ftrace-v4-941d4a00ea19

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


