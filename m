Return-Path: <linux-kernel+bounces-535693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E8A47618
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB293B12F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99F21D5A6;
	Thu, 27 Feb 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRv8q+LV"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE41EB5C3;
	Thu, 27 Feb 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740639269; cv=none; b=QFMAeXzmLSYcY3U4vnPoLz43k6M6avn1jkWPUfmS2SuNTCb6jEHoFxed2vWtYefFd7bh+x1K2SWhkALHRcPax9KG9egJ0FiJyP8Zd9sPunsM70xGaczPkxkF2wp5VeifJxpWJxvdyjyHQDjQQK4Gj5UIa3WpwyDI9LQZdKb2CVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740639269; c=relaxed/simple;
	bh=n0B/1XV3Zb7SGgPpaEn1A2d9Yhckeog7XvRX+HT5X/0=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XcWDez32xU4wzFronNFuWUsNq8vQtOrF5lO608DeIImir9t4XG8Uwc2ndq1d/XFR0cSu7yzEZEJtR7yZjLuptmqRVa/ipevfWD6yIpJaficNZ6of+4I22Hk/hDp1DJMxfZ0czDrTWGD3rJs3LDz5JpyvGf0u9KUART+l0d0pKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRv8q+LV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fe848040b1so1277635a91.3;
        Wed, 26 Feb 2025 22:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740639267; x=1741244067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgyTSFeHFjA7K6c7bMlzYp5hJ4ivyZJhPS3wek+zZXw=;
        b=nRv8q+LVDGk8VRS6XEe7Ow5RPLK1Co6iJq17yYnvKDUzYoRD/0ODbJpmM/MPXO2fJK
         WAA53WnzN3aQsiY6jJhv9Cn2PSw5LMoF5p7BV575CuinpwLjgMIJ8xTQ647HqlxhCwbY
         D0Z28GQFS1q6sNPWcIZTwj5x9gRgJhhXWd0cDRGFw6gojCnz7tu4x+vGdyAkRXwnc8Q7
         HJgVwS2X4kcgYG0od5bTw9Ld3PMLQGSt/dfZkA5iPcetvApJSbDgMLx9gxN9aiwndIVA
         XtXfNAdR7Tkl9mtngbAhNHoPrS5yrpn7ufWczGJtLkHQa6eFRBqKddoTAf9MGp6SGu5I
         8G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740639267; x=1741244067;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JgyTSFeHFjA7K6c7bMlzYp5hJ4ivyZJhPS3wek+zZXw=;
        b=YBq02jWhmzPKDsXJiL+brbEXxoHOOtaRg5rhUz1+YZaRd68hGcwcFuSm6peLEr1xmE
         wYhsYPOndH+g5M8xiRefYwMpu2lfrb38z7tfzRXTTEq/NwznRKl33NpB08sj2zYwczSQ
         LJiyynOHj0Uz1IQyCj0hjVfAMgSdWsIxABvgIeSdNhLKSLZE5t3yHJoa9IGYCc9sEC6D
         kXWoJyUcXHy9xxeO+CkjtzKWwC2ONOUbZyWldz+ux+FUhkY8VRpGcMikiJKTsuFfLhtk
         taxo1kSbK/NKpZ9jDnccTTb6JNJS4BNA+o00BzyyP6MtUtVe4KLEPMSIgcDzuiHx7rNn
         3zvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHC67iX8wIsVK3CBStpVkiz8bAq2AV3GgD3oZp14OymxB+DYupLM6A7uJ6hFOUvajLxpxWQFLUjjsxGCY=@vger.kernel.org, AJvYcCWBv2R+26dppSfoJatACqbZb/hculNIE/pUWnGt9kfAKAaarPdRm7CUmi8Xz2dkRlbtkj3zg7LMxKpR4NlsG2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGf7qaxrnTQ1cExm8ZUIHBB9EZlginaeoy3po1O26bkhiwGc+V
	9cvGSWjxNSq+1nt1HBX1/2ZB7xCllLEeAgg22aLdmFaHcY7iveRh
X-Gm-Gg: ASbGncsmSXe0zio8hwNYioFD/k5uZdFeAY+P0NavHHvhq1rYqRdoyOV3mjOqOV4SSqM
	8RcZrIKl8hvcDcbm1aAtmJWu6rrfqOMRdD2s1uNSRgqBDUUW7/94ZxH2cn8msFnTztbqAaJUtRv
	eGTuvV0TiNuT2tDLwP2FRvh/5HVyxWzffWwn2dAA8mTH6PV7y83oZqCvj2Q0879UC1gsSuShSZa
	KaDBv0FdpjFusFw7bYCc0UsZxxNwAeKyUuc3pJgFKA4ZQZF+gi7rXfQ/PZ8zjBRjtOQRfsgkZ7r
	4PrfqRaygm9Vp64CZXM9CJBei6IKyneQrsm4i7Jrbd379HLPzTUmC5NTyO6agMYaAPNzNRWYm9E
	0jT4yHKU=
X-Google-Smtp-Source: AGHT+IGjuaF9lCedEwwvhGXZ/MFEnt3SPMlo5RufsTcV9FkuM7vYd2x/lrwZ+ktjsfsepkbI2prS3A==
X-Received: by 2002:a17:90a:d802:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-2fe8c22614fmr7028655a91.15.1740639267130;
        Wed, 26 Feb 2025 22:54:27 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f972esm7386905ad.58.2025.02.26.22.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 22:54:26 -0800 (PST)
Date: Thu, 27 Feb 2025 15:54:17 +0900 (JST)
Message-Id: <20250227.155417.1610168537890385926.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
 hpa@zytor.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, tangyouling@loongson.cn,
 hejinyang@loongson.cn, yangtiezhu@loongson.cn, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com,
 tmgross@umich.edu
Subject: Re: [PATCH v3 0/5] rust: Add bug/warn abstractions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <8734g0v6ke.fsf@kernel.org>
References: <yy_ESUuchCjlaGIJHzCPAcP_d9ucSD0CGXaoZNNkY7BmN5Ch1J8avsA9QpKO5LkTjlGpu99jl8NrFl5NFSQXuw==@protonmail.internalid>
	<20250213135759.190006-1-fujita.tomonori@gmail.com>
	<8734g0v6ke.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 20:39:45 +0100
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> How does this series compare/overlap with [1] ?
> 
> [1] https://lore.kernel.org/all/20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io/

No overlap. Each solves a different problem. Both are necessary.

This patchset enables Rust code to call C's BUG/WARN properly.

Currently, Rust's BUG() is a simple wrapper for C's BUG()
(rust/helpers/bug.c). I added BUG() to rnull's init() and got the
following:

# insmod /root/rnull_mod.ko
rnull_mod: Rust null_blk loaded
------------[ cut here ]------------
kernel BUG at rust/helpers/bug.c:7!
Oops: invalid opcode: 0000 [#1] SMP
CPU: 0 UID: 0 PID: 31 Comm: insmod Not tainted 6.14.0-rc1+ #103
RIP: 0010:rust_helper_BUG+0x8/0x10
(snip)

This is NOT debug information that we expect. The problem is that
BUG/WARN feature (lib/bug.c) can only be used from assembly.

This patchset includes only warn() but with bug() implementation on
top of this patchset, I got:

# insmod /root/rnull_mod.ko
rnull_mod: Rust null_blk loaded
------------[ cut here ]------------
WARNING: CPU: 0 PID: 31 at /home/fujita/git/linux-rust/drivers/block/rnull.rs:46 _RNvXCsafUg3oOYix8_5rnullNtB2_13NullBlkModu]
Modules linked in: rnull_mod(+)
CPU: 0 UID: 0 PID: 31 Comm: insmod Not tainted 6.14.0-rc1+ #104
RIP: 0010:_RNvXCsafUg3oOYix8_5rnullNtB2_13NullBlkModuleNtCsaYBeKL739Xz_6kernel13InPlaceModule4init+0x71/0x4f0 [rnull_mod]


The [1] patchset adds an abstraciton for include/linux/once_lite.h,
'call a function once' feature, with pr_*_once() implementation.

pr_*_once() just calls printk() once. Unlike BUG/WARN, no debug
information (call place, registers, stack trace, etc).


The only connection between two patchset is that WARN_ONCE() can be
built on top of both like the C side.

