Return-Path: <linux-kernel+bounces-233818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4341991BDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE025285F16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964B156984;
	Fri, 28 Jun 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ICVHBBCf"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299B154433
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575296; cv=none; b=qv6gQLR7K3sJS9n8ecbvVqtkMaz74cYPapIbD40yDfChOrj1mfpo8QDtR0uvYvlQcJq6zh+McnRiFJT1lcjqm9z3Rhp0NRL/hy1BgWZA5L1zLTf880ffHbfKvLTrEocGYPWBTuuNzMgaDn/xIyy1enfgtrFzHTaLgHu2xhLj3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575296; c=relaxed/simple;
	bh=nMicCFqOOSqXWHUG6+RMyPjEXy9o5YSjEOcCsaIXIMI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jjXO9LwnnNtBKXpIyNkT0lokhbFwfes0uCF4Di0pO+CP87/FYhQS4nyXRAbU2Kl/JMyNCBNkqY3OGkxkjlHYO/y/pPqlyzd+fXQcX3CLmUC/67Ieijpui5GYa+R/VV8eTlMMP0KToXnzfl6AKpRFNF/gpfny2MdE347r3afrO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ICVHBBCf; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c9f630e51so241486fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575293; x=1720180093; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Go8tsPI3JHaqc+IarHpTHOFjcdklbUr4X/cGV00jz4=;
        b=ICVHBBCffdyo1DjayEb/GFmDzptLm6xJ6c2M4soIbVHFKH/0z9z3pQvl4jqJDvQcqm
         eXLzIB5pq0VeuxfnU/+KiEtOIuyZVl8xMmweqfO7SCC/SwmPgK9tjiaFHK/V9/UO8Q0M
         18AaWzKDFzphjuX2KEMINBK6Pkl+b/57vPXXLir2g4Fd6HZBB/dkG0qxB/6wkXVowA8d
         cximUFNbcONH1hZswhzKxMu33xvVZwHcMAFtLhvS93b9nOWu1TznHznvTi0V1YaBOs4T
         6Zkx6Lyzob16Suc1PBHUivPpZlSGmvy4LMr+Is0N8HLTd9fqn51xG2UHRWxNv7W2h+fW
         MV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575293; x=1720180093;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Go8tsPI3JHaqc+IarHpTHOFjcdklbUr4X/cGV00jz4=;
        b=f9EdwMd9r6cS1xpaMy7BL6fBG7bQxtFUvqlZ6H+1A4ghhwY5lQo80WhLQXZyiyU7zH
         AF+D0hxk1ft9JiS8P4z9vlzWhxf31WZm29/W/StbUFXl79Pa8M643sOur+dFjS0nB4Pr
         SEy6lHEX74N6nVSYxr1xMXQhuzO0DDAPCUAzKbqywWl1QB3LX7ZPQ9dlCnzajcATIKe7
         70w61wpJjp9WfqTGwEytrNAL74/8zi5vi81H3DhQK/F9SVqAthdzQeAikE5/paDt3ebb
         zYVW1ZuphMc/GpMrS4X0SYmnlGkA5HiIHBkqv9nSX6ii37K8SciuRP9PaHI2Fj48GS8L
         SfKA==
X-Forwarded-Encrypted: i=1; AJvYcCVPBsDlpCuDDGCxgwFcJFHlvGuS0+mCq7e6hcH1AfP2WzXt0ZVTnk2KQCxP/Ap3q48tLWQ/ta/XjUGwb8eq7lnBLmQG/d8K0osEHeeH
X-Gm-Message-State: AOJu0Yz+kbZ58M1iTXUL1zd4uMR3YWQdfZic0v/hAaABM3M+t10jqqok
	qPxJ/kPchzknqSn3ev+V8QhTzYO/68qYVrfEZfH+VppUCaNR1ssZpwvU6tlnXsM=
X-Google-Smtp-Source: AGHT+IGxaDreBVCsSLdh9PoJI0Hihs2g42vWKzBlr7lrYPNGCbC+Og4f9H83lvBVMVl6OYqO7WNyog==
X-Received: by 2002:a05:6870:d891:b0:254:7348:9071 with SMTP id 586e51a60fabf-25d0170cec9mr17765030fac.26.1719575292823;
        Fri, 28 Jun 2024 04:48:12 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:12 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Subject: [PATCH v2 0/6] riscv: ftrace: atmoic patching and preempt
 improvements
Date: Fri, 28 Jun 2024 19:47:43 +0800
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN+ifmYC/4WNQQ7CIBBFr9LM2jEMRWNd9R6mCwJTOwvBQEMkT
 e8u9gIu30v++xtkTsIZ7t0GiYtkiaGBPnXgFhuejOIbg1baqCv16LmgDb469DXgvCbrGIvBwZA
 3Vim2NEBbvxPP8jnKj6nxInmNqR5HhX72f7MQKiR76W9M2iniMcsshc8uvmDa9/0L/OJ01L8AA
 AA=
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
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, 
 Andy Chiu <andy.chiu@sifive.com>
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

The series is composed by three parts. The first part cleans up the
existing issues when the kernel is compiled with clang.The second part
modifies the ftrace code patching mechanism (2-4) as mentioned above.
Then prepare ftrace to be able to run with kernel preemption (5,6)

This series is tested after applying the following ftrace/patching in
the fixes branch:

- commit 57a369b6f2ee ("riscv: patch: Flush the icache right after
                        patching to avoid illegal insns")
- commit a2bd3a5b4b63 ("riscv: stacktrace: convert arch_stack_walk() to
                        noinstr")

Changes in v2:
- Drop patch 1 as it is merged through fixes.
- Drop patch 2, which converts kernel_text_address into notrace. As
  users can prevent tracing it by configuring the tracefs.
- Use a more generic way in kconfig to align functions.
- Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com

---
Andy Chiu (6):
      riscv: ftrace: support fastcc in Clang for WITH_ARGS
      riscv: ftrace: align patchable functions to 4 Byte boundary
      riscv: ftrace: prepare ftrace for atomic code patching
      riscv: ftrace: do not use stop_machine to update code
      riscv: vector: Support calling schedule() for preemptible Vector
      riscv: ftrace: support PREEMPT

 arch/riscv/Kconfig                 |   4 +-
 arch/riscv/include/asm/ftrace.h    |  11 +++
 arch/riscv/include/asm/processor.h |   5 ++
 arch/riscv/include/asm/vector.h    |  22 +++++-
 arch/riscv/kernel/asm-offsets.c    |   7 ++
 arch/riscv/kernel/ftrace.c         | 133 ++++++++++++++++---------------------
 arch/riscv/kernel/mcount-dyn.S     |  25 +++++--
 7 files changed, 121 insertions(+), 86 deletions(-)
---
base-commit: a2bd3a5b4b63b95aea7dbf61d9395cd6696a2bc0
change-id: 20240613-dev-andyc-dyn-ftrace-v4-941d4a00ea19

Best regards,
-- 
Andy Chiu <andy.chiu@sifive.com>


