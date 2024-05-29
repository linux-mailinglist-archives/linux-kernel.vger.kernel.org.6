Return-Path: <linux-kernel+bounces-193850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900F8D3317
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2EF11C23E50
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B70169AF2;
	Wed, 29 May 2024 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTXWrx/T"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F94B15AAB8
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975224; cv=none; b=u4OQ9N/e0g5fPNeb/IwbBhdvs8s1EFaQCWQenhQcnw52bNpYZsnauU/v56kD/opkRYwvnoH8ymsZDyZWtO3s2lTSgFQ4JoOuA0DkdSFd4VG1CDI/Y3XOoRxsCDJeQkE+8RwRaAnjpgJi3lcpKMB1gbAMjSYW/R4eqH5PI6vCoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975224; c=relaxed/simple;
	bh=oy2sM9E9I28X4sqiqOUHF7G+ZKdVaxkvEWZkR6GjuF0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qFm2H8WX38G2gn64PwW3zlOiaIorBm50zfo9/AlP/g70oUA381PcJtlrPvm+OlwL9xwDos9qEm8o/TtkHPemR+oc7+DN89rvTcZNKsXXCThZYsbMJLMGw4gaxicQCdwFda6z+jXwUMnBhUjJldfpNswXMSyIqrfTLtUQOT/WwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTXWrx/T; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a3dec382eso7726667b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716975222; x=1717580022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A7jFrnYLPr4qszl6iKNvj0kihvPlgpEbfCiq9QGfEb4=;
        b=MTXWrx/TTOh848PoKDFOKcbzSm4J7/r3PgJgTCHMO39eD3Y3rPafClGBFLxNwLIKIl
         ZVoKygkl5y3QGNEUXnSehKMDWhimYfp0BXOq5F5srZhNKrWQoz55dc/6LAB58sYviqe7
         biI6qejfRn1ZZ/6aOQWl818S4FXbOu1Lb/wAy9t09iMJCvJA3pIZbs8TY0mHWYa7AeSK
         QwcDnRGkxX0EJe11Oz2bv5izfdC0x14jTr3EvqwBu7bL2GuGlqLdzVCwQck2bH74K5ir
         qKHiAHnwm+C1q2FtaNvrZsZfEEP5DO61tTFDhnhbhpWuD9P609zb0RaKvgHNpHy7u0Il
         ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716975222; x=1717580022;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7jFrnYLPr4qszl6iKNvj0kihvPlgpEbfCiq9QGfEb4=;
        b=bx49m4ZGREwgwAPTjc1R7ophnzVfvK76dObrusvxsrxFwNScvWyxIp92/2ew7U/r76
         FAR9HG60OERGmU+uE+x2vmOMmDPdaOEt1M2CreCA5wSu6KmnYLVW9QLudPbXN979KmJU
         gb9oW29pLx/9L7AdBeMTJDPHk5UAZJDRPD/MN7EN6konX+OF0hhp/zecIu8piwHPZ7wM
         k/c7x1ZT6h/E8I6FSsqAPshWOp1IRfYBZib9wqirGEdfgEUTYRTzRbEwmF+28dC0CGLL
         aDKJ4WReMF92n+qx+ve2Nm8J2GkI93AWi4kksif/01TxXESON9KCMfkPDNqrHWzXODbi
         5zKA==
X-Forwarded-Encrypted: i=1; AJvYcCUJigQ3LdSMyFS44Hi67aGtGiZ2nNmHS6p6Mz9jyEl9kjR94xLyAEfizmlw9ltIC9r/CO4CfTsXddjlDnxE0M+qdo++Rkcx7SInPpVZ
X-Gm-Message-State: AOJu0YzS8W1CZhbW3SOCKnbdcNl1BGOp2miYS0f7K6POZRhbE3MD1Mft
	XXivYEdAvJN2tT2L8X2gtwbTbSTrCPIDwIOBpg8pe+7K4WTx0btCvHddD0dYay0CdsDdLD7xZWw
	F8D83UpcIww==
X-Google-Smtp-Source: AGHT+IHxdg2ya01s660665HE7gx0TzIhtq+AMegN495R/PRhtdyxXJThsqXUppWR5I/ihiLisAVQ7G09XOsdQg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a81:924c:0:b0:627:edcb:cbe2 with SMTP id
 00721157ae682-62c5d5d451bmr2897097b3.5.1716975222191; Wed, 29 May 2024
 02:33:42 -0700 (PDT)
Date: Wed, 29 May 2024 17:33:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529093336.4075206-1-davidgow@google.com>
Subject: [PATCH] arch: um: rust: Use the generated target.json again
From: David Gow <davidgow@google.com>
To: Rae Moar <rmoar@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

The Rust compiler can take a target config from 'target.json', which is
generated by scripts/generate_rust_target.rs. It used to be that all
Linux architectures used this to generate a target.json, but now
architectures must opt-in to this, or they will default to the Rust
compiler's built-in target definition.

This is mostly okay for (64-bit) x86 and UML, except that it can
generate SSE instructions, which we can't use in the kernel. So
re-instate the custom target.json, which disables SSE (and generally
enables the 'soft-float' feature). This fixes the following compile
error:

error: <unknown>:0:0: in function _RNvMNtCs5QSdWC790r4_4core3f32f7next_up float (float): SSE register return with SSE disabled

Fixes: f82811e22b48 ("rust: Refactor the build target to allow the use of builtin targets")
Signed-off-by: David Gow <davidgow@google.com>
---
 arch/x86/Makefile.um | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 2106a2bd152b..a46b1397ad01 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -9,6 +9,7 @@ core-y += arch/x86/crypto/
 #
 ifeq ($(CONFIG_CC_IS_CLANG),y)
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_RUSTFLAGS += --target=$(objtree)/scripts/target.json
 KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 endif
 
-- 
2.45.1.288.g0e0cd299f1-goog


