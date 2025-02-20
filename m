Return-Path: <linux-kernel+bounces-522788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15BA3CE85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C257A71C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6AC18DF93;
	Thu, 20 Feb 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxWF3k/d"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6D286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014381; cv=none; b=UmwxEAp+gyZn8cprqRWHpcgL9A2McYxEWM6VRScQNRlmJRfJAPnAA/DnKX8rZYtMHOHAzR+P1MixK1YVVbrgXdvZ2RuAXPyUr5HwlHWnIpazjJ/U20BiRHsvJRilZWqwFLTVeZvb1JvdvHg0agECRfmKItUqHgmTGdaCQBUnFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014381; c=relaxed/simple;
	bh=68PALQCn4GZXaMAk1aLisnfmMzWgQ+ys526kWmI63g0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ii2WuKue7jsapXwLWeHcMYJv6aSvvJaOsiHHBdJswaLfnOgYl1KqW+a42pNXbKLNTL1W+wCLqJkcxCILG+g/TZ95UItI8eAAkUAUXIampUpwNTTIisjV3MZYvW2UFQj96HZZ88yeki6el1pLbroB4AvkD6OafNZB1MeCSZjUWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxWF3k/d; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so1071306a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740014379; x=1740619179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=90DsHdVzBzjp5RPvlkSTbOgHqDCYIc4EKhmpQ2T52VA=;
        b=jxWF3k/dx7RYp+Gz7MuzQy2gRYXQaR79d3X2v+rrYLssejTtuayarnzfx6UikRt2Qt
         6i7VfEnLTkNyDTXtMnDXqJ0SIieTaY0EebKq9J82pzsLG6Zop+Rfd4SeI9fN/HT97MGp
         uXLERB02YfJj4L94M8GawnYTja4bMJrvhgUrlX/2gH+IH1mMQcL7QMohCE84D3wEp1YV
         3gmdVci+w2n0co0TujjLgVOk5yYxsy4SD2wPzgA6uO7xLUro2t05sm/NiTAqD9zFrbOU
         ujDb4mMgSYenSB1a4qBsHkh/ATdWVu66yDLYo8awcLjpglIu8Ov0HkXrXpa10roeX+Ai
         AeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740014379; x=1740619179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90DsHdVzBzjp5RPvlkSTbOgHqDCYIc4EKhmpQ2T52VA=;
        b=NBFZcZcB4CF0svasi3dF4Fw5Ym6zoyolaIwpFCr72f3SbDFrOjiyn5ty6tge4aJbSF
         qS8jeRDhMPrS65RwDFuIlGkAVPag4cBne2UXc0H1jhRWPyL7XUw1qEKCcWj4fkScW5P7
         t+mHOiJm/ml+rcMqHGHPS9isFwhC8ophUM1OUf59c9gWQSG1pL0vuwzJCe2ZmPHTy26I
         IhvtxtNBVpZhWPCzVlwAFPkJNER/xvQF5W1dcnT1ZeeTPsM9KwUC1dxYGaoklQIT13I5
         Z1gIHf4tpqNZN3UDM2mOBNFNdzmtRTBI3T4tFaPoUcElE16oWbRiKQf/1l2tq2elANc5
         voJg==
X-Forwarded-Encrypted: i=1; AJvYcCV7LzL/s7HhuQDg3mmLHqy8p5QYpPt4FeS346sevGVcTzkl5HUp4/J0GaP7fshkKVxsW9cmjhZhVGhjF2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1YadrSlqKcBMUaOtVUbP2ICSooP95A0/1T/kvELquKByF3be
	/gY2/dthMCm3E49XNIAT3cdkdD1h7Belq9Xs9wqX0okiMS9LJNBOvlalWnmWjS8xNk9pa7QaosM
	C939+Q8ko0Q==
X-Google-Smtp-Source: AGHT+IHTZJIfwdAPmaRcC/AMICF8Oev4ATVZBir52JFY3k0h8M5BqldtCyuNDkfc9kCd9Vz6uKu+/MDd0uXK1g==
X-Received: from pjbpv10.prod.google.com ([2002:a17:90b:3c8a:b0:2d8:8340:8e46])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2887:b0:2f9:bcd8:da33 with SMTP id 98e67ed59e1d1-2fc40f23246mr28257178a91.21.1740014378820;
 Wed, 19 Feb 2025 17:19:38 -0800 (PST)
Date: Thu, 20 Feb 2025 01:19:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <cover.1740009184.git.yepeilin@google.com>
Subject: [PATCH bpf-next v3 0/9] Introduce load-acquire and store-release BPF instructions
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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
instructions (for background, please see [1]), mainly including
core/verifier, arm64 JIT compiler, and Documentation/ changes.  x86-64
and riscv64 are also planned to be supported.  The corresponding LLVM
changes can be found at:

  [2] https://github.com/llvm/llvm-project/pull/108636

Tested using PLATFORM=aarch64 CROSS_COMPILE=aarch64-linux-gnu-
vmtest.sh, with llvm-17, llvm-18 and [2].

Please refer to the LLVM PR and individual kernel patches for details.
Feedback is much appreciated!

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
Peilin Ye (9):
  bpf/verifier: Factor out atomic_ptr_type_ok()
  bpf/verifier: Factor out check_atomic_rmw()
  bpf/verifier: Factor out check_load_mem() and check_store_reg()
  bpf: Introduce load-acquire and store-release instructions
  arm64: insn: Add BIT(23) to {load,store}_ex's mask
  arm64: insn: Add load-acquire and store-release instructions
  bpf, arm64: Support load-acquire and store-release instructions
  selftests/bpf: Add selftests for load-acquire and store-release
    instructions
  bpf, docs: Update instruction-set.rst for load-acquire and
    store-release instructions

 .../bpf/standardization/instruction-set.rst   |  78 ++++--
 arch/arm64/include/asm/insn.h                 |  12 +-
 arch/arm64/lib/insn.c                         |  29 ++
 arch/arm64/net/bpf_jit.h                      |  20 ++
 arch/arm64/net/bpf_jit_comp.c                 |  87 +++++-
 arch/s390/net/bpf_jit_comp.c                  |  14 +-
 arch/x86/net/bpf_jit_comp.c                   |   4 +
 include/linux/bpf.h                           |  15 +
 include/linux/filter.h                        |   2 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/core.c                             |  63 ++++-
 kernel/bpf/disasm.c                           |  12 +
 kernel/bpf/verifier.c                         | 234 +++++++++++-----
 tools/include/uapi/linux/bpf.h                |   3 +
 .../selftests/bpf/prog_tests/arena_atomics.c  |  66 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/arena_atomics.c       | 118 +++++++-
 .../bpf/progs/verifier_load_acquire.c         | 197 +++++++++++++
 .../selftests/bpf/progs/verifier_precision.c  |  48 ++++
 .../bpf/progs/verifier_store_release.c        | 264 ++++++++++++++++++
 20 files changed, 1165 insertions(+), 108 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_load_acquire.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_store_release.c

-- 
2.48.1.601.g30ceb7b040-goog


