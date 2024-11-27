Return-Path: <linux-kernel+bounces-423764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E239DAC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 18:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C941671C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBB201020;
	Wed, 27 Nov 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfzbH5WF"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8153E201015
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728590; cv=none; b=fEo5dSUb1tFjLGCH91C7ySr50qN1j2DzW8Yd6wwVzJWG4houtSzEAXTX9vUolQ94bd9Pj0Necs2EKZU/E82N2MZSxBHyVpRJnNnkybolkQN5ZKGFmVwSYM8IouBm92UriQkxM+7VBhxW7/Cwg66DpnvTzE/Mpd2F1TUCs3aCZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728590; c=relaxed/simple;
	bh=AgCMaMeAnASpx9ADAFEofuxtrTW5t6AuJNoMsODv+90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IR7yyi4hzmrtbgGx2w+MM2jfT6VGF/hWwQ6JQDxfp9i6x4GqmhbV+B9jxCb9YjE4d4oCaQPiQEwMQ5e5DVeNvJnmeDGuhgCK2KFC53MFZIwl6m/NRC6Y+q5pLM4DPvYUz4MzTCmfV6Grjo9xFJ1O0EcP2yfFI+9oNiPKPDz145A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfzbH5WF; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so5826860a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728589; x=1733333389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4sIOmxt+6E3SUjl0OKh9ltYG/Wh+OnpptrG+2+4Agg=;
        b=nfzbH5WF0S6QvTFYZLlf+vQXMM+FkwfAFMMt/XWuQa+TXqs8zK7iO2nQL0G1/9fFd2
         6oJg0J2wriWvlLGONtIfoHclVpk4G4cmZu5nJSiHE1JNqjbs+dPoXpccJSPhug2N9xMe
         2IUfOdpJKCdDWKGUNL4snflGPdBOOqSTpfeQnc4ys6qElY0zoLk9QJYgzBX1jqw3Ng/2
         H5+nVujsYit5r17RjTrPP1bViCx3OMQVM7eosOTPagkNsWaVnfRXWEWa7Abq1kxvoZ1P
         5wzEu6rksE8v5O9QSsyOooNI/lJZFx/fyioCvoHLe3GNsvite3aWEpxIhsLoZ5hZctf9
         aWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728589; x=1733333389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4sIOmxt+6E3SUjl0OKh9ltYG/Wh+OnpptrG+2+4Agg=;
        b=xP0n7UryOXR2dv9D5trE3BkGtbZaO41ohSHV6nmZfux7rZhSpMs/V8LA2AfrB9J5UB
         fE3BMVNXu1ved9GzmszMppLvp1cCRmlfdAl0kvfsADxqtgzcYUI6wLuQ3a/i6NBHT5Nv
         YrKo1gUzhXH4vMLaB8Q+8orKgI/Ta5PQis/Zo6FGafCzBsYXtxxhVq+tNjTm7U34471V
         pLJAAjsGa62l2GQoO9MJzSQ/Bwbec7M+Jbj8bwE82yiLFULl45szaA4o3An89Q0FOlW6
         0jenGvrw5L5uw6IhhGrh/PRGrRnbFOyOK1ZLNeCuP8aO7xo4YRq807r52XoD+H9lhPTv
         8DiA==
X-Gm-Message-State: AOJu0YxYUp7tSEY/BWhHZ7Sx7bBW18lpQ5+/HJWweSLM3FYDe/2itaGI
	LNnFCf7d6tQQEtYW9otAtEP1zUhVcAtwzE/5yQi6c3EeNNQue6zZ
X-Gm-Gg: ASbGncsCI9iqkyyaEVkO92P3XqhtXFwmbduk7RAMlja3IWATxwOxpEcYCalMXtQkKnX
	HbpLw6My/pyrowf1YxeDKJX4Dvm1bPObGag7iRw+vYQWF6ykTdiNOHS5//pXQJWurDvRPY0HAVm
	mnTxlMrkwBQKe1w90yJOJRRc27FJOvzxk6Al9kQd+SBennaLvFJgknPiaomiY9Q/E6nv5p0Wyib
	azTNd/6F2OX+ZCTZA+IxgSBU7/PVam+exe2ZPDLmHocRNvkm0ncx3RIdo4EZ652IFqn9cswYdNO
	kdwcQtOLUEWU+1d+bBciaALQBAMh
X-Google-Smtp-Source: AGHT+IEQBpzMXh5yXkAktk+B4Le1RfAy/+Rf/KVUrppFxoUQ2qNw97WYZSZiNYXgYFn+fzg6vo950g==
X-Received: by 2002:a05:6a21:2d84:b0:1d9:c6e8:60fc with SMTP id adf61e73a8af0-1e0e0ab4692mr5782140637.6.1732728588569;
        Wed, 27 Nov 2024 09:29:48 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.29.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:29:47 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt improvements
Date: Thu, 28 Nov 2024 01:29:01 +0800
Message-Id: <20241127172908.17149-1-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

An ongoing fix:

Since there is no room for marking *kernel_text_address as notrace[1] at
source code level, there is a significant performance regression when
using function_graph with TRACE_IRQFLAGS enabled. There can be as much as
8 graph handler being called in each function-entry. The current
workaround requires us echo "*kernel_text_address" into
set_ftrace_notrace before starting the trace. However, we observed that
the kernel still enables the patch site in some cases even with
*kernel_text_address properly added in the file While the root cause is
still under investagtion, we consider that it should not be the reason
for holding back the code patching, in order to unblock the call_ops
part.

[1]: https://lore.kernel.org/linux-riscv/20240613093233.0b349ed0@rorschach.local.home/

Changes in v3:
- Add a fix tag for patch 1
- Add a data fence before sending out remote fence.i (6)
- Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com/

Changes in v2:
- Drop patch 1 as it is merged through fixes.
- Drop patch 2, which converts kernel_text_address into notrace. As
  users can prevent tracing it by configuring the tracefs.
- Use a more generic way in kconfig to align functions.
- Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com


Andy Chiu (7):
  riscv: ftrace: support fastcc in Clang for WITH_ARGS
  riscv: ftrace: align patchable functions to 4 Byte boundary
  riscv: ftrace: prepare ftrace for atomic code patching
  riscv: ftrace: do not use stop_machine to update code
  riscv: vector: Support calling schedule() for preemptible Vector
  riscv: add a data fence for CMODX in the kernel mode
  riscv: ftrace: support PREEMPT

 arch/riscv/Kconfig                 |   4 +-
 arch/riscv/include/asm/ftrace.h    |  11 +++
 arch/riscv/include/asm/processor.h |   5 ++
 arch/riscv/include/asm/vector.h    |  22 ++++-
 arch/riscv/kernel/asm-offsets.c    |   7 ++
 arch/riscv/kernel/ftrace.c         | 133 ++++++++++++-----------------
 arch/riscv/kernel/mcount-dyn.S     |  25 ++++--
 arch/riscv/mm/cacheflush.c         |  15 +++-
 8 files changed, 135 insertions(+), 87 deletions(-)
---
base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
-- 
2.39.3 (Apple Git-145)


