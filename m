Return-Path: <linux-kernel+bounces-438618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C89EA38E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D735188219B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A71B7494;
	Tue, 10 Dec 2024 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0UiLFrc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290029A5;
	Tue, 10 Dec 2024 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789953; cv=none; b=S+lbvNLpIQgoPLVU0hLe9TI76dHcMY5SjtpZd8e7Y8kNapSXZpilWPhbC572UNZLzV2InQvVrGvE1LtA5t+SWXFn0EKVST6dZ9HXJFM4J3NXzHRcMIN5tqDJu1uXHne+KgIdqXfcW1karaK4qY8sQ0d0pVHZ9h+P24+v7GgKCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789953; c=relaxed/simple;
	bh=+dWai1xx8b2AwAgDP3O1hmszP+7eXk+xWu+a5qgwJ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbjwM6ChfDB9KGsR1Sgk8iZn31lz+gkO1zgS7uIzRdeUSx/YS1fzuWtbXvCfQgLI8NbpgacMl7KmEHcmJjpIPpp9Fnzct1o3pR5KkZ2xurr9J5ycUnUhuQUkhO+jrRSWt12Uy2wPZ29E8iU/oKnk7BZb+wm6Nr45VoLXn+ZRDxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0UiLFrc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f4623df7so1243649b3a.2;
        Mon, 09 Dec 2024 16:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733789951; x=1734394751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yyn8QNTH7wqJjjw/QfPOjCU2TP5ahhHLckRiqYVzfDY=;
        b=i0UiLFrcpPwVMz9Kr8RG87V5K3mqyVOS9Le3k+YHcO0b7E7BPNwK14XGo7nMfYhL4S
         5aQJWdcDeArML+9BBVIDywy+Go+W+af+lafb36P5GJqGslJwCuyhbLn4AljotKj6T76W
         4QGvBggEoCcy8gq0UWmGqPMJhhsL7NL3YnAq7JnNiDBlJ0E1LznpphWyu6ICvm+CQbqO
         aOmwAOragqfCyx1DSy8v0BhLzeaLFVTg33HFb8bafDGvWTcTNFF8oT8fcMIQu23qLjAE
         TR4GKwfFM3c0le3w+TGifA3dLURIanZTxwMYNEyINVX8VPIU95cTP7wok41NkA3cNs8z
         QbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733789951; x=1734394751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyn8QNTH7wqJjjw/QfPOjCU2TP5ahhHLckRiqYVzfDY=;
        b=YjnKLJGG6em8N8OlpEARkU7J7ZJuKM9BTL9V+qKPfs3VYIE2w/in5LZ2PGv3AA6cpz
         uFvnB9vu/kn2JojRXUP5z2bCPCnw2My/o+lupng+bNMCSxEM/HCmilfy3njLH29KAApo
         E3lPZSocpx2cH3exUWUP29/AeppyHcLMSwI5deIAJD9EYsxsK7PEkiA8qSy1hH1lyrMc
         CR/4W8Qh+jtvFMjs3MwG5Dt7nix/hXGip+EW0kdUwQXjNHXPzt2uayBvcVrcu5cZE3i/
         a3Efk4RbEniBrpHWpw7tRxuARtc24Q2AozOaJEy8WtuoZvZVbrkLKMFdj3ggjlftRIe0
         73EA==
X-Forwarded-Encrypted: i=1; AJvYcCW2wiHyEpGEMRSgW57d3qx468tzRyDKn54GlfcSfXBeWpNwJJLxMR+Hz5U2O4G0A8wy8vlPt5PtxfYlffOGng==@vger.kernel.org
X-Gm-Message-State: AOJu0YxibrxwcfL6vR3Pu29P9MoctZwgAmkdn/wtBj4WFw8YDKUoeALo
	Z4H1XtPUNJYzB0AcI0Cea09/mGgdKtGVD6ihPgonjEyGdZ+KAPyGUEmQ/RTi
X-Gm-Gg: ASbGnctoPVo3k+1vUnbTzZMHqp9ctLU3CT87VToTRjb7d49l30L7KY9UwVExcqIgc0P
	kbi/eAp5kpO61T4yQHn3IIEeQiu/BW9eX7BcpzLUVGWOX09rxHifx2L9r8DwLEmZWhf8vAR8Pk9
	ijd5qVNhDDpPgenpxldH8LtbVWF9lOkj2u+h4QYXdF9jsyaFaDkV+ZHgtVvL0MsQnjnnQ2Sn1Y7
	Yvk+tgI2Q36gn3h529pmzuBniY5UpG0Y8MWq1H4/xruVUCA7wFU5/DGfUa560nLZSpPI0wTFrBz
	axp9mUO2t3ef1aZ/H8+dF9XRlaIZ
X-Google-Smtp-Source: AGHT+IEdFPEBCVbMfoJezZOTVqCwhcFvYK07D7Yq/Bkx4KQFK9L3M9HsZHOxAW7D+XoXG/7mHHQLwg==
X-Received: by 2002:a05:6a00:928b:b0:725:9f02:489a with SMTP id d2e1a72fcca58-7273cb72984mr3417048b3a.17.1733789950934;
        Mon, 09 Dec 2024 16:19:10 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725f1fba027sm2005005b3a.3.2024.12.09.16.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 16:19:10 -0800 (PST)
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
Subject: [PATCH v1 0/5] rust: Add bug/warn abstractions
Date: Tue, 10 Dec 2024 09:17:56 +0900
Message-ID: <20241210001802.228725-1-fujita.tomonori@gmail.com>
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

Wrapping C's BUG/WARN macros does not work the same way on
architectures that support Rust (x86, RISC-V, ARM64, LoongArch). Rust
code needs to directly execute the same assembly code used on the C
side. To avoid duplicating the assembly code, this approach mirrors
what the static branch code does: it dynamically generates the
assembly code for Rust using the C preprocessor.

The 1st to 4th patches export the BUG/WARN assembly code for Rust on
each architecture, with no functional changes on the C side. The
changes for x86 and RISC-V are straightforward. However, the ARM64 and
LoongArch assembly code are designed differently; they are used by
both C inline assembly and assembly code. As a result, sharing this
code with Rust is complicated.

The last patch adds the bug abstraction. Seems that an unused named
argument in Rust inline assembly can't be allowed so we need multiple
#[cfg].

This has been tested on x86, ARM64, and RISC-V (QEMU), with only a
compile test performed for LoongArch.

The assembly code can be used for both BUG and WARN, but currently
only supports warn_on and warn_on_once. I will work on the remaining
functionality after this abstraction is merged.


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

 arch/arm64/include/asm/asm-bug.h              |  31 ++++-
 arch/loongarch/include/asm/bug.h              |  31 ++++-
 arch/riscv/include/asm/bug.h                  |  35 +++--
 arch/x86/include/asm/bug.h                    |  51 ++++---
 rust/Makefile                                 |   8 ++
 rust/kernel/.gitignore                        |   2 +
 rust/kernel/bug.rs                            | 131 ++++++++++++++++++
 rust/kernel/generated_arch_reachable_asm.rs.S |   7 +
 rust/kernel/generated_arch_warn_asm.rs.S      |   7 +
 rust/kernel/lib.rs                            |   1 +
 10 files changed, 255 insertions(+), 49 deletions(-)
 create mode 100644 rust/kernel/bug.rs
 create mode 100644 rust/kernel/generated_arch_reachable_asm.rs.S
 create mode 100644 rust/kernel/generated_arch_warn_asm.rs.S


base-commit: 7503345ac5f5e82fd9a36d6e6b447c016376403a
-- 
2.43.0


