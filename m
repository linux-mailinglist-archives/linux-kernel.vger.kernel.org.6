Return-Path: <linux-kernel+bounces-546647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9352A4FD42
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931F61885D19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D31232392;
	Wed,  5 Mar 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmccNY89"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3515A214A68;
	Wed,  5 Mar 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173010; cv=none; b=TBxDDohKvgdUyPwRtrjXM0geX6fAE/vq0Jj3J55cA5vTR1iwRpD+7Cywiu5NPn1GaGY6mnxzZ7Z+fYnaQ2X5g8nrIgM+VEenDGAtt983gtNDVEOUNMpxDlMRLAgCA49w2QpN1p5qWZvI2ZLLEvgknT3hyt0fwXvcgHwzGwQWASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173010; c=relaxed/simple;
	bh=p1h54BOh8Q9XBTfcRZnJQ9PmT0Z8qvm1fYbU8PCxoBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5YgMkJCiXGh/sqoajeW0sva9obL7c39s5dRBOHrGY1N7v7ppagnIK7JUVJrg9XOKM9vRa/qxXp9MeFpBWQYEjqC8SxxmzIzs3Wdc8fwgkP9ZDw1ouYiXgUGrEqnFSFVG6fZMTaAWvNmNPr6VaFE0OcbpddgCZOc7865eTZ5lx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmccNY89; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2feaca4e99cso9862746a91.0;
        Wed, 05 Mar 2025 03:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741173008; x=1741777808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMVkt8VvD9u0w9McePyp8QpG5OxxVEdJnPN4xngSa2I=;
        b=VmccNY89vD6MDTzcHbNuM6mCkQbZ9rI8uv9fZVvTBwaWRJgmOVeziyIhXQ8f0XM1mE
         Prczn78qj0Lk2rK5/6VA7rZwvEvAjcUKoXG7mEVuNSP5rtFgcKbaeRtGdsfUxDgSeeUy
         9bjMBJW/BBvuF0yvyrf8/c3LSTmeMtWHEnacexO+HhVMIfZXqGMJWbodPtrD1SQrnSAO
         mccncik3AGa61hzfIIBvE2TYSCnEJ1o6uqag3T4IYIlWOlrCVI5hL2BsUWicVi2aau/2
         ucqfAoaLcjzj0O0S+sLbM9t0GGkp9HhtMRKd7bCqLVWpCZQ7Pr0xHbtYzg/RkYNK88eo
         qszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173008; x=1741777808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMVkt8VvD9u0w9McePyp8QpG5OxxVEdJnPN4xngSa2I=;
        b=NyXSv4l26koyjujc7bRH21qQLe+mfmuHxIYPUFzVgBleyYvIx+3RVIklT+eb3LSpwI
         CH+daM8rCtAJcl5UzjxzD9g0gfbjiAPmHie3gEmAvCtcy78D2mK5feMhoOA439D8VqHW
         La7eZfxJ5P00qHHGy9qd8qSQgxma96AcVbgkN9p0ZwSfymXFj0MDuBSsuVwAoj8h12j3
         2U1fZ0v/v8EUamQhOQGsoHMnSQ4d0/almhGH1CKlqOsMAHKjtm+B6XYbMzNUFPjH5l7J
         uPpQuxEdVT1goUYdtUMvtc5Lc+zPysgzs66LP+bKyNh8nxE4ZEvNwQePG2gHmabN2K+2
         4Jkw==
X-Forwarded-Encrypted: i=1; AJvYcCXZD/l1p8mlxBviQvVK/OUgmVdWChcH2DHLSVYZlI6mPyadv0JSYnOE5i/xRnCWfzBVV28rlUfXRpdyTiwsPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylJTET0wWdaZis7cC5AnLJkJiDJ8iTSWrYN6LaW4p3xwY4a2l0
	1QdR2tWivKmM53LNe35Sb7xQCF8OF5OxEag/JBGbwjerNiQnQ9RcPBTYi4FD
X-Gm-Gg: ASbGncs0eG9lgRX8paL605W19aNyw3XT/+IF5H6E2Q8czzDI2lx2pwRo5ODrlMGFzVM
	Osz9byEeQoYsjqtewiHF1MW22HdX7/Qumkl00u4JGQ5U87lxY5gejwHXhN3h2E9cp5r0YI11wMK
	12Ksj4OS6zA0Q63Vi1fX6pkpQWeC8GZ6V/3q39CJI35FcpCNt3jUOMZQluMBD3VGhoT8SgUMzQ1
	7Jxh/6qD7jDhKXaIX/FOBuyzThZ/ZF1OnESY3mJV+ChkQsiyb3czbYdLI8k9RcIkmLU7aQNtIFU
	MPof3x0CJt0m9ddnZMsBBRcHiU/3+E7Cfk2bTd+YzE2LPmUh9XJhKboPzctRJM1afrXPWtUhXwI
	keV4ZKha2QbvETnSOsieDfw==
X-Google-Smtp-Source: AGHT+IFluiMV7JrX1O1X/v1UbVS/X37LSME/ig8/X1xAoOdMRtTxpinwMPddXbT0s26nxPYJt9KENA==
X-Received: by 2002:a17:90a:d2c3:b0:2ff:502e:62d4 with SMTP id 98e67ed59e1d1-2ff502e645cmr1921672a91.32.1741173007728;
        Wed, 05 Mar 2025 03:10:07 -0800 (PST)
Received: from mew.. (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7737a5sm1060925a91.13.2025.03.05.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:10:07 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	peterz@infradead.org,
	hpa@zytor.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tangyouling@loongson.cn,
	hejinyang@loongson.cn,
	yangtiezhu@loongson.cn,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Subject: [PATCH v4 0/4] rust: Add bug/warn abstractions
Date: Wed,  5 Mar 2025 20:08:10 +0900
Message-ID: <20250305110814.272792-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds warn_on macro with the bug/warn abstraction that
utilizes the kernel's BUG/WARN feature via assembly.

Currently, Rust code simply wraps BUG() macro; however the approach
doesn't provide the proper debug information. For example, I added
bindings::BUG() to rnull's init method and got the following output:

# insmod /root/rnull_mod.ko
rnull_mod: Rust null_blk loaded
------------[ cut here ]------------
kernel BUG at rust/helpers/bug.c:7!
Oops: invalid opcode: 0000 [#1] SMP CPU: 0 UID: 0 PID: 31 Comm: insmod Not tainted 6.14.0-rc1+ #103
RIP: 0010:rust_helper_BUG+0x8/0x10
(snip)

The kernel's BUG/WARN feature (lib/bug.c) can only be used from
assembly. Rust code needs to directly execute the same assembly code
used on the C side. To avoid duplicating the assembly code, this
approach follows the same strategy as the static branch code: it
generates the assembly code for Rust using the C preprocessor at
compile time.

The 1st to 3th patches export the BUG/WARN assembly code for Rust on
x86, RISC-V, and ARM64 architecture, with no functional changes on the
C side. They have already been acked by the maintainers of their
respective architectures.

The change for LoongArch assembly hasn't been acked yet so the v4
doesnt' include it. LoongArch still uses the current approach; just
wrapping C's macro.

UML doesn't use the assembly BUG/WARN feature; just wrapping generic
BUG/WARN functions implemented in C works.

The last patch adds warn_on implementation on the top of the
abstraction. To make the patchset easier to review, the remaining
features such as bug() are not included in this patchset. These
features will be added after this patchset is merged.

This has been tested on x86, ARM64, and RISC-V (QEMU), with only a
compile test performed for LoongArch and UML.

v4:
- added Acked-by tag to the RISC-V and ARM64 asm change
- simplify the asm code
- use the cfgs on the macro rather in its expansion
- use a const fn for bugflag_taint over macro
- dropped LoongArch assembly change
- dropped warn_on_once; make the patch easier to review
v3: https://lore.kernel.org/rust-for-linux/20250213135759.190006-1-fujita.tomonori@gmail.com/
- rebased on rust-next
- use ANNOTATE_REACHABLE macro (replaced ASM_REACHABLE)
- added Acked-by tag to the x86 change
v2: https://lore.kernel.org/linux-arm-kernel/20241218062009.2402650-1-fujita.tomonori@gmail.com/
- remove target_arch cfg by using asm comment
- clean up the changes to loongarch asm
v1: https://lore.kernel.org/linux-arm-kernel/20241210001802.228725-1-fujita.tomonori@gmail.com/


FUJITA Tomonori (4):
  x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  rust: Add warn_on macro

 arch/arm64/include/asm/asm-bug.h              |  33 ++++-
 arch/riscv/include/asm/bug.h                  |  37 +++---
 arch/x86/include/asm/bug.h                    |  56 ++++-----
 rust/Makefile                                 |   8 ++
 rust/helpers/bug.c                            |   5 +
 rust/kernel/.gitignore                        |   2 +
 rust/kernel/bug.rs                            | 113 ++++++++++++++++++
 rust/kernel/generated_arch_reachable_asm.rs.S |   7 ++
 rust/kernel/generated_arch_warn_asm.rs.S      |   7 ++
 rust/kernel/lib.rs                            |   1 +
 10 files changed, 222 insertions(+), 47 deletions(-)
 create mode 100644 rust/kernel/bug.rs
 create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
 create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


