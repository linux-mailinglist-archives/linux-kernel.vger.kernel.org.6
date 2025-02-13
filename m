Return-Path: <linux-kernel+bounces-513077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC01A3415B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9B916DFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C224BC0C;
	Thu, 13 Feb 2025 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3IPWWei"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1995241680;
	Thu, 13 Feb 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455243; cv=none; b=n4uNnUWKdKQizs2rjSTXyjlnM4AnCpIHtyLSWYikrs9ImMFEoVfe93mJS/PYdbeMJ/IenpaEFSU9UHOafYLhzXAZcgO9arDPwnuXU+F5IW3Olo456Z3iTCpP+oiMcmdefptakHeqs0Cjv1QK/bDtckGVzqAOMJ1Cx3q7trYukIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455243; c=relaxed/simple;
	bh=YpdB58uyq8tH7ERH2NdQvCyZMv332LF5vwPEXd91SCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XkUwrKhzOPvo79M0K/AQ9FpNYKf9t+1V2HGpZyFDLDVU6lRHWDlPo5+Osk/ynk+WRrhX9nvg6ZAyrQviR8WpbhjGMZNRlkxVSxxsoJqHg+cRtZJweTMrZ4SjD2fOX5gyZWjrcuVVY6vaTYwAFhoSVaiOYL29VCUM+DPADXu/8Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3IPWWei; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21c2f1b610dso20816535ad.0;
        Thu, 13 Feb 2025 06:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739455241; x=1740060041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3CnYIC1jW8Yb7MVQSsYlSkO9EcP0G/PW7oItTF3TCFk=;
        b=d3IPWWeicp3J0Jcviz6wLHLxmocgysJRkglXD7Rg9ZbSbG7sUslMnM7Q88V6dRfTh4
         sWXA42ulpknChKWpHtXHQIHKl2c6wc6bDzbiMWKAPMhNZiDfVOBEc+y27YLBC5OE0Stv
         MV7b36Kf41Pe80sBE9D9Mc8LL+62Ix9eqbtnMtc82BzT++hmud0uxCc05jh9S2NVNfoJ
         aSMiB9bk0l2O9X5eunszS002+u0eXPonn6k/e+yr/hXaHKV6HT/KhcNn+y3h4ECJkxbV
         bvv8ajqHGgHDHAUyMaCp0d93QnBJUB6LQTN7DY/mqoo7qLerS49qfXyP16pqfBiBlrMS
         MYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739455241; x=1740060041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CnYIC1jW8Yb7MVQSsYlSkO9EcP0G/PW7oItTF3TCFk=;
        b=QNGvBgMXSrDDS9ReMzrOQKrczj8g9iIH+K092nq47tIU+TzF1IHGLrwfYKmG9DzoNn
         JU9JZ9UF24B/KCqfRRClwF4bLenNqJPQdT4h/kr233DW9M7gMpPSQwYDSJAgxNwInOmn
         YWG1pgBPRV6lyJ54Mxwwk8k8hrrAdG9PecPwb9y30G3qaGCLPVJvREK1pbEZRwQ11FG+
         jSQbdPIU0DQce6D7MVqnySlVEb84S7hfKpM2kbSP5qKuLTMw3JO/FeHzolSOE89qJEuT
         ro6wDWIw2mhE61XlaBNrwqBzST94ji0gre+ARTj7a3rU7yCK3A5DlNYzjutfkaVjWdSa
         72UA==
X-Forwarded-Encrypted: i=1; AJvYcCViCktk41ChWn8yxOt9WLg6lw3nHvCQCMAgEiPtJqudvc3OpKJaGVgx/m9vIKyFzztG7oLbjSnLbxRmhYsKqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfJV7u7afr3hJ8FzX4H6mD5ApRsSLHB7oKG/9qx/lLWkXFiRFX
	/+BFbZ2hcTN3kRJbOgX4IFWY74iWX4SkvdBx78GwerfKEsqbdxznGfcMR9or
X-Gm-Gg: ASbGncskRolmkib9UWpnKj6unVYQxsny/iTKC1rzwS4REjaUmqCjOYvr+dsNTjfHSxV
	IL4QcrObxBG9p+SpJTGEGAL/PxGo5B5TcKmSp5+PFyhiLf/ZyT6sZfsooB1GHp3gGCJVxONl65V
	jKaxxM+puke7HK9MErANDXHU3NKRy4kMX+piRxrVoPDo6QakmRDQV65BG/4d8l2EA1egqpxeDO/
	sHMeqFA6eO/nNVnnwwuujwmZE2YwjZ7SZbcYFWmfcmCjZgZrvIGfvk3GgZS6Viat3TCkpLCV7uT
	g3W58Vb7cxzdBPLIwQRGTXNXQQ7s0oVZsFtbZ+S49FQb7lvnhx1jW6t8fK6cBmukGOs=
X-Google-Smtp-Source: AGHT+IFiybmklIR6sXPe5dOMXPko9nq/OxURSSt8JQfw095Ue+kPgwqj+3k15eW2uamc5z4ID2izMg==
X-Received: by 2002:a17:902:e850:b0:21f:78f:c178 with SMTP id d9443c01a7336-220d1ec1f7bmr52326585ad.3.1739455240643;
        Thu, 13 Feb 2025 06:00:40 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm12565225ad.223.2025.02.13.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 06:00:40 -0800 (PST)
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
Subject: [PATCH v3 0/5] rust: Add bug/warn abstractions
Date: Thu, 13 Feb 2025 22:57:54 +0900
Message-ID: <20250213135759.190006-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds warn_on and warn_on_once macros with the bug/warn
abstraction.

Wrapping C's BUG/WARN macros does not work well for x86, RISC-V,
ARM64, and LoongArch. Rust code needs to directly execute the same
assembly code used on the C side. To avoid duplicating the assembly
code, this approach mirrors what the static branch code does: it
generates the assembly code for Rust using the C preprocessor at
compile time.

The 1st to 4th patches export the BUG/WARN assembly code for Rust on
each architecture, with no functional changes on the C side. The
changes for x86 and RISC-V are straightforward. However, the ARM64 and
LoongArch assembly code are designed differently; they are used by
both C inline assembly and assembly code. As a result, sharing this
code with Rust is complicated.

The last patch adds the bug abstraction with warn_on and warn_on_once
implementations.

This has been tested on x86, ARM64, and RISC-V (QEMU), with only a
compile test performed for LoongArch.

The assembly code can be used for both BUG and WARN, but currently
only supports warn_on and warn_on_once. I will work on the remaining
functionality after this abstraction is merged.

v3:
- rebased on rust-next
- use ANNOTATE_REACHABLE macro (replaced ASM_REACHABLE)
- added Acked-by tag to the x86 change
v2: https://lore.kernel.org/linux-arm-kernel/20241218062009.2402650-1-fujita.tomonori@gmail.com/
- remove target_arch cfg by using asm comment
- clean up the changes to loongarch asm
v1: https://lore.kernel.org/linux-arm-kernel/20241210001802.228725-1-fujita.tomonori@gmail.com/

FUJITA Tomonori (5):
  x86/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  riscv/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  arm64/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing with
    Rust
  loongarch/bug: Add ARCH_WARN_ASM macro for BUG/WARN asm code sharing
    with Rust
  rust: Add warn_on and warn_on_once

 arch/arm64/include/asm/asm-bug.h              |  33 +++++-
 arch/loongarch/include/asm/bug.h              |  35 +++++-
 arch/riscv/include/asm/bug.h                  |  37 ++++---
 arch/x86/include/asm/bug.h                    |  56 +++++-----
 rust/Makefile                                 |   8 ++
 rust/kernel/.gitignore                        |   2 +
 rust/kernel/bug.rs                            | 100 ++++++++++++++++++
 rust/kernel/generated_arch_reachable_asm.rs.S |   7 ++
 rust/kernel/generated_arch_warn_asm.rs.S      |   7 ++
 rust/kernel/lib.rs                            |   1 +
 10 files changed, 235 insertions(+), 51 deletions(-)
 create mode 100644 rust/kernel/bug.rs
 create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
 create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


