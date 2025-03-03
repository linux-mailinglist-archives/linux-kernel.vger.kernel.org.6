Return-Path: <linux-kernel+bounces-541026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451FA4B79D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC5718903E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCAC1E22FA;
	Mon,  3 Mar 2025 05:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNArZsJJ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BE23BE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 05:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980217; cv=none; b=E+8R/IQtD03sbInJkpsDlfMxBZ2xQhnvGOhrxud0oxeRuF+4U47f6sB/B4f1Cl8VIxmEJCIwaBroDfNsnbZhdBPdcOVhk+f6S4RvB6o9g8yNM1x7Gn0fDlq9qnVpy72fqzATxFs5O3+HJAF5NilWXcL9iqFH7oBkW3XZmKzxZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980217; c=relaxed/simple;
	bh=j66RYBsHvAMHvAY1d6zq6pvpDnNZ4xGRxqKEQChunB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Npi32TnMvvfbTL/pytHIqIIdRNtFbyOm3293shAErX9mUYveAd8F8NbWlE9GWGN9CHtu7SKLPDyfvIxjAL2TwSoq9IU0nXzaHZMoRM/8E9IeOji5AkVJl+jCMG/g9RPR6A0jgpZ6cR05HvXU7Z0oiEwtUH5U4SEf+iwBzgISbKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNArZsJJ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fec1f46678so8331276a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 21:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980215; x=1741585015; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9keALfR3MoLw+PD+al73HjvscKcrNY7AfZzPQJDJd+E=;
        b=yNArZsJJL1q9ySW8UaUCrBYG84nI3H8WypbPs20O1wofNZ7MoWSjZ+N+3nqeCqG0en
         BIQZuG4udxpK9HvxH4YUPqkGg1BoRqxjl+tWNXWf4ArkOr/7GfJAMdY83IhlK40HtYtb
         tqM4PRZc55/vAz8d6Gc9MYoI6nusooJZbqdvnGjZhjyRFsFnxCtlvHadMs6vhMQMD1FW
         ZfrjBQWGhQv1xLeGrPa1w3Mw3fuBCWXcC80K01sy/K6/OMoAu5dIEedzZyO3fe42Afud
         ULFa0EY+lAvaSKjKrr0mt9lfd/5mtJa6ZoG/5diUkP+uOhU/Cnnk39xyMoOwroF4Bg++
         wnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980215; x=1741585015;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9keALfR3MoLw+PD+al73HjvscKcrNY7AfZzPQJDJd+E=;
        b=P1pKQzklcOvKyNmWzeFeZZNat/i5j9t9Mw14MkbFj8DHeiMako42tMz01HcParAVR9
         w1isAGM9eNWskCRK2F8x/iPRPZ7jPKO00pnXG9KHSKrPerkXfXISvSP1/QaN5u8TE7K3
         97pEaRLfYt0rFVYKmaETbonvWDixGCd1rwoBJomLw6y4b+ISfdKhK7bWckomYBvohP18
         Mk8ixHXiZgEdclaQj10otsoT5NyVRkJ7wCIYmSC0iU+sii1EYX1HBnhMQarUkwgdTQsa
         AFH/NpALpp0o+FnxbdymY75Lak4HMIk0K8PXviaxeSa7bq87//LlXK6mKgspFk5923no
         34bw==
X-Forwarded-Encrypted: i=1; AJvYcCXJuVF53ipFQCjrIQolJdLL4eUmxIw2JZXauA22E0To+iyfGgjG/ZlJWH8jo7tKaHy/x+nDvgGcdkW56eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpA7thCrb4ZWP6/hRR5IZIl1HB9M8Z4Xiwlfkv1PnxaV732S1k
	e94uu4/x6gCkUn4K8o4hd6bvnJN2fIIM17EBr7Go/KhLMCV8pXnRyzvUROqpzd+qp9smPCybT05
	VwJjXrjqcLQ==
X-Google-Smtp-Source: AGHT+IFZCe6yoXZlFRFDi90+BsBsfmlxusZPCR0Zo+o0Z5eNaDi5okT5qbRGGVjCh8760/l6FnXw9H9iaMirUA==
X-Received: from pjbsu3.prod.google.com ([2002:a17:90b:5343:b0:2fa:284f:adb2])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3509:b0:2f9:9ddd:68b9 with SMTP id 98e67ed59e1d1-2febabd9c6bmr16920865a91.26.1740980214966;
 Sun, 02 Mar 2025 21:36:54 -0800 (PST)
Date: Mon,  3 Mar 2025 05:36:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <cover.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 00/10] Introduce load-acquire and store-release
 BPF instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all!

This patchset adds kernel support for BPF load-acquire and store-release
instructions (for background, please see [1]), including core/verifier,
arm64/x86-64 JIT compiler and Documentation/ changes, as well as
selftests.  riscv64 is also planned to be supported.  The corresponding
LLVM changes can be found at:

  https://github.com/llvm/llvm-project/pull/108636

Please refer to the LLVM PR and individual kernel patches for details.
Thanks!

v3: https://lore.kernel.org/bpf/cover.1740009184.git.yepeilin@google.com/
v3..v4 notable changes:

  o (Alexei) add x86-64 JIT support (including arena)
  o add Acked-by: tags from Xu

v2: https://lore.kernel.org/bpf/cover.1738888641.git.yepeilin@google.com/
v2..v3 notable changes:

  o (Alexei) change encoding to BPF_LOAD_ACQ=0x100, BPF_STORE_REL=0x110
  o add Acked-by: tags from Ilya and Eduard
  o make new selftests depend on:
    * __clang_major__ >= 18, and
    * ENABLE_ATOMICS_TESTS is defined (currently this means -mcpu=v3 or
      v4), and
    * JIT supports load_acq/store_rel (currenty only arm64)
  o work around llvm-17 CI job failure by conditionally define
    __arena_global variables as 64-bit if __clang_major__ < 18, to make
    sure .addr_space.1 has no holes
  o add Google copyright notice in new files

v1: https://lore.kernel.org/all/cover.1737763916.git.yepeilin@google.com/
v1..v2 notable changes:

  o (Eduard) for x86 and s390, make
             bpf_jit_supports_insn(..., /*in_arena=*/true) return false
	     for load_acq/store_rel
  o add Eduard's Acked-by: tag
  o (Eduard) extract LDX and non-ATOMIC STX handling into helpers, see
             PATCH v2 3/9
  o allow unpriv programs to store-release pointers to stack
  o (Alexei) make it clearer in the interpreter code (PATCH v2 4/9) that
             only W and DW are supported for atomic RMW
  o test misaligned load_acq/store_rel
  o (Eduard) other selftests/ changes:
    * test load_acq/store_rel with !atomic_ptr_type_ok() pointers:
      - PTR_TO_CTX, for is_ctx_reg()
      - PTR_TO_PACKET, for is_pkt_reg()
      - PTR_TO_FLOW_KEYS, for is_flow_key_reg()
      - PTR_TO_SOCKET, for is_sk_reg()
    * drop atomics/ tests
    * delete unnecessary 'pid' checks from arena_atomics/ tests
    * avoid depending on __BPF_FEATURE_LOAD_ACQ_STORE_REL, use
      __imm_insn() and inline asm macros instead

RFC v1: https://lore.kernel.org/all/cover.1734742802.git.yepeilin@google.com
RFC v1..v1 notable changes:

  o 1-2/8: minor verifier.c refactoring patches
  o   3/8: core/verifier changes
         * (Eduard) handle load-acquire properly in backtrack_insn()
         * (Eduard) avoid skipping checks (e.g.,
                    bpf_jit_supports_insn()) for load-acquires
         * track the value stored by store-releases, just like how
           non-atomic STX instructions are handled
         * (Eduard) add missing link in commit message
         * (Eduard) always print 'r' for disasm.c changes
  o   4/8: arm64/insn: avoid treating load_acq/store_rel as
           load_ex/store_ex
  o   5/8: arm64/insn: add load_acq/store_rel
         * (Xu) include Should-Be-One (SBO) bits in "mask" and "value",
                to avoid setting fixed bits during runtime (JIT-compile
                time)
  o   6/8: arm64 JIT compiler changes
         * (Xu) use emit_a64_add_i() for "pointer + offset" to optimize
                code emission
  o   7/8: selftests
         * (Eduard) avoid adding new tests to the 'test_verifier' runner
         * add more tests, e.g., checking mark_precise logic
  o   8/8: instruction-set.rst changes

[1] https://lore.kernel.org/all/20240729183246.4110549-1-yepeilin@google.com/

Thanks,
Peilin Ye (10):
  bpf/verifier: Factor out atomic_ptr_type_ok()
  bpf/verifier: Factor out check_atomic_rmw()
  bpf/verifier: Factor out check_load_mem() and check_store_reg()
  bpf: Introduce load-acquire and store-release instructions
  arm64: insn: Add BIT(23) to {load,store}_ex's mask
  arm64: insn: Add load-acquire and store-release instructions
  bpf, arm64: Support load-acquire and store-release instructions
  bpf, x86: Support load-acquire and store-release instructions
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions
  bpf, docs: Update instruction-set.rst for load-acquire and
    store-release instructions

 .../bpf/standardization/instruction-set.rst   |  78 ++++--
 arch/arm64/include/asm/insn.h                 |  12 +-
 arch/arm64/lib/insn.c                         |  29 ++
 arch/arm64/net/bpf_jit.h                      |  20 ++
 arch/arm64/net/bpf_jit_comp.c                 |  86 +++++-
 arch/s390/net/bpf_jit_comp.c                  |  14 +-
 arch/x86/net/bpf_jit_comp.c                   |  95 ++++++-
 include/linux/bpf.h                           |  15 +
 include/linux/filter.h                        |   2 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |  63 ++++-
 kernel/bpf/disasm.c                           |  12 +
 kernel/bpf/verifier.c                         | 234 +++++++++++-----
 tools/include/uapi/linux/bpf.h                |   3 +
 .../selftests/bpf/prog_tests/arena_atomics.c  |  66 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       | 121 +++++++-
 .../bpf/progs/verifier_load_acquire.c         | 197 +++++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  49 ++++
 .../bpf/progs/verifier_store_release.c        | 264 ++++++++++++++++++
 20 files changed, 1246 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

-- 
2.48.1.711.g2feabab25a-goog


