Return-Path: <linux-kernel+bounces-571138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C17A6B9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4B31888FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FF22157B;
	Fri, 21 Mar 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3eL+UbO"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD62C1F03C1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555741; cv=none; b=uPPaJQPRMmouFrVcEUkDEhJioGJeupIdKzJE6TBYFA9tJMgkhGYc4x1QKD6EIasPMtjLcJtVltrf49CNYNReqphQD2V0V1krbJDnYEAYE6MjndXNIykNx7B7x4bA2eSQSq7MXmVLy4ivmZl32MmG+/T2Otuq3eZl6PdolzG1ay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555741; c=relaxed/simple;
	bh=LyjkH2QySCOSXFplZGe3Yr1geWyES/LDmYVnuE8oHAw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MPgZ3E6X9xuFIpeHKnVveL+p1MumyZAiP7mqNVkN/SSSLBOsM46HaqJYStXGAMCJQLKN5JaYNhKc+eRnRO/kwF/9vX5VPyDTiHY9O/01HZPM6tJhHmZTGVb8N6a8C7Nmc972sVqZsARZJt3yvrPUn7HJDky3u72Q91WqLS2nDJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3eL+UbO; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-39134c762ebso850139f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742555738; x=1743160538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBvkAQAnHQym5/2Fqa0WauNlKK3Lda/hKmXyAeHcCFE=;
        b=I3eL+UbOHZZCjxqzbFONrw+eD5eJccRsqLPxh9U6yzNdfZX1UDzxbfje12AozYqSLG
         IMiho81RAjncxriUgbiDrLgYTcmNLAieGdzGdVv7xcxjcGAnw4RkTdfBZ7ILK96bYmQ3
         Op/MYBmd0ruwYiLvvXY5wKAkca+8Az7D+8fh0aTwBYz7CV2dCqncyEQPkgpxgFNRy7/c
         j89LTCla1xUHiwrc9xbWTCfO89kn3B9JJunHpUmDdNzMGTNJpeDaxof1NNYeELTzIEtJ
         fv2A53xjGoGysSZ7je9EEQ2vNjFubE4enUUCyWxWQDo8t0opPf4tNR+V6H/yi9Od1fkv
         rNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555738; x=1743160538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBvkAQAnHQym5/2Fqa0WauNlKK3Lda/hKmXyAeHcCFE=;
        b=IcukaqsR9tpMMI7yTTGAakuhv4Nv146xO7hV23X7gVMNVie8ZnNeOH/G/iC9FF3gwM
         p8EHhqjCkpz+EGzIfP3BpZV5D7xuV0VPLlBkHOBAo9leZkKrkc9Ak7kTK1lL6Wvquvts
         9wn2NbyshmmYwkGXPImnuS+fJsucDvAsEnYr9SnKO0KzqnPptrqrHFQYAX28GfRC/MgP
         XVTvoZxaOxGiKXsJepTzOD3kkHL1ZPEPKGqcjpAKFXzpsduVmUu20zs+Vs4Hi8gvXuZv
         AfF+ngWH7l5vreJ88GlWwTxvAIsmDO4CAYqsxlnFTaQhA1UCX/qTfS7BNpLyQPWGHwRR
         v3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVCfJZRpaBnxMO0JZxaer5X6B0qwTRdRMHGpEU8cqh8RbO0jYeJWBPcHpk2ehVYR5ZcNxQf9D9bT/OshDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6YdD8cyHH7WEcYEHR2JzCWgZDuOPb0xaAXaUbCzIhP9OnUJ/
	ZpoYY6wwMIpTJPhqARGPLOWJc2E1Ac+LG+u05WXCseIcezO08N+WCKvMuTw4AQJKFA==
X-Google-Smtp-Source: AGHT+IGvGCNRv4Fwv9/22IwIwHSyIDpU5GhOukXbyPHIPAvB/yrxhXrGXLFYgGlFBizZci8CUEfYuBU=
X-Received: from wmbbd5.prod.google.com ([2002:a05:600c:1f05:b0:43c:f6c0:3375])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6da1:0:b0:391:10c5:d1c6
 with SMTP id ffacd0b85a97d-3997f8ed9c9mr2425752f8f.2.1742555738222; Fri, 21
 Mar 2025 04:15:38 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:15:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321111535.3740332-1-bqe@google.com>
Subject: [PATCH v5 0/4] rust: adds Bitmap API, ID pool and bindings
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series adds a Rust bitmap API for porting the approach from 
commit 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
to Rust. The functionality in dbitmap.h makes use of bitmap and bitops.

The Rust bitmap API provides a safe abstraction to underlying bitmap
and bitops operations. For now, only includes method necessary for 
dbitmap.h, more can be added later. We perform bounds checks for 
hardening, violations are programmer errors that result in panics.

This version includes an optimization to represent the bitmap inline,
as suggested by Yury.

The Rust equivalent of dbitmap.h is included as id_pool.rs, which is
tightly coupled to the bitmap API. Includes an example of usage
that requires releasing a spinlock, as expected in Binder driver.

This is v5 of a patch introducing Rust bitmap API [v4]. Thanks
for all the helpful comments, this series has improved significantly
as a result of your work.

Changes v4 --> v5: (suggested by Yury and Alice)
- rebased on next-20250318
- split MAINTAINERS changes
- no dependencies on [1] and [2] anymore - Viresh,
  please do add a separate section if you want to maintain cpumask.rs
  separately.
- imports atomic and non-atomic variants, introduces a naming convention
  set_bit and set_bit_atomic on the Rust side.
- changed naming and comments. Keeping `new`.
- change dynamic_id_pool to id_pool
- represent bitmap inline when possible
- add some more tests
- add bqe@google.com as M: for the Rust abstractions

Changes v3 --> v4:
- Rebased on Viresh's v3 [2].
- split into multiple patches, separate Rust and bindings. (Yury)
- adds dynamic_id_pool.rs to show the Binder use case. (Yury)
- include example usage that requires release of spinlock (Alice)
- changed bounds checks to `assert!`, shorter (Yury)
- fix param names in binding helpers. (Miguel)
- proper rustdoc formatting, and use examples as kunit tests. (Miguel)
- reduce number of Bitmap methods, and simplify API through
  use Option<usize> to handle the "not found" case.
- make Bitmap pointer accessors private, so Rust Bitmap API
  provides an actual abstraction boundary (Tamir)
- we still return `AllocError` in `Bitmap::new` in case client code
  asks for a size that is too large. Intentionally
  different from other bounds checks because it is not about
  access but allocation, and we expect that client code need
  never handle AllocError and nbits > u32::MAX situations
  differently.

Changes v2 --> v3:
- change `bitmap_copy` to `copy_from_bitmap_and_extend` which
  zeroes out extra bits. This enables dbitmap shrink and grow use
  cases while offering a consistent and understandable Rust API for
  other uses (Alice)

Changes v1 --> v2:
- Rebased on Yury's v2 [1] and Viresh's v3 [2] changes related to
  bitmap.
- Removed import of `bindings::*`, keeping only prefix (Miguel)
- Renamed panic methods to make more explicit (Miguel)
- use markdown in doc comments and added example/kunit test (Miguel)
- Added maintainer section for BITOPS API BINDINGS [RUST] (Yury)
- Added M: entry for bitmap.rs which goes to Alice (Viresh, Alice)
- Changed calls from find_* to _find_*, removed helpers (Yury)
- Use non-atomic __set_bit and __clear_bit from Bitmap Rust API (Yury)

Link [1] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/
Link [2] https://lore.kernel.org/rust-for-linux/cover.1742296835.git.viresh.kumar@linaro.org/
Link [v4]: https://lore.kernel.org/lkml/20250318164221.1533590-1-bqe@google.com/

Burak Emir (4):
  rust: add bindings for bitmap.h
  rust: add bindings for bitops.h
  rust: add bitmap API.
  rust: add dynamic ID pool abstraction for bitmap

 MAINTAINERS                     |  14 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/bitmap.c           |   9 +
 rust/helpers/bitops.c           |  23 +++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 293 ++++++++++++++++++++++++++++++++
 rust/kernel/id_pool.rs          | 201 ++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 8 files changed, 545 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/id_pool.rs

-- 
2.49.0.395.g12beb8f557-goog


