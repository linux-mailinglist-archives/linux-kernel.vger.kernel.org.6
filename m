Return-Path: <linux-kernel+bounces-566573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D45AA679EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A99189F9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B476211479;
	Tue, 18 Mar 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hvINDyZb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9422211474
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316163; cv=none; b=sZyB7aaQRaaUbB3ao4FlBsRo2Bg0HE9ToFG6mwsSH/e35ZHkKcUPrqvz7elHcw/t4rFovLsK0rZsCKQXpb/4+Nwke/Dwf533Bm+HqE4lM1+Sg9nn2R1d5TsO+JalnOKcwUo4oiWdzP94XVTVTsVtpOHhGzaxy+MroLZUcYo5uGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316163; c=relaxed/simple;
	bh=Tx5aQ+PVmDrcF9+jUJNNxs4VI+R5oe1v+QNiKKXCBWk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qKrGVrHYVvZH9iMNo1Pj9IGLglDYCbLZbe4G7UJGmiAjQMZQQLQEJNnfd3bL1KVHy1H83z27Sz5ddry2ahcVkjBGXzdk/+dPnZ/bYcge6CyrH7i6q4TAohveRy8/d8z5T60OG9vXowDWLpOru2RPX+oSgZLDkhCwFkL5oij4pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hvINDyZb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d01024089so28688075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742316160; x=1742920960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l6Nppss5FCn7ZoH1vyzC/3el/gHhCZzDSzNESdFmBmk=;
        b=hvINDyZb3m/JNcMtmRdwSpMpHq2UXFPmHq8KCpbRydfDRHw6LprgM78ojlHzf1Ydbd
         hPdhMgjZdORBTYTO+Vv7Xb/Fwin1lvGyf7tT/O8KTUIFZfTOXktPgt/G8SfGP4kjTmDS
         vTBLWGRa9OjEPgsqC7NcmyQEbm56pRL2C9XOlophi/qRQoWBIPc5vYhdnH90phzMfL3X
         3QBLoOZM4W0pHAoXdFOLOmXwu8U/kjsuZF3eFZCWEkdHvHRMHmYFdDuF3qqsmVQ9S33K
         Q4wguu8VvUiOTmFsR4rtpxmb/0smdw8b+y5E8Ubw45+tcf8mmF0HPoMMVwuWAHuTL/oE
         Oudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742316160; x=1742920960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6Nppss5FCn7ZoH1vyzC/3el/gHhCZzDSzNESdFmBmk=;
        b=b2Vg/dHAY7iwKt4Olgrtc9fcfH51n9/9rjd6zwDNlYhUykvGqMAvomn3BqmYQYZiYq
         kwVz88n+0pPvfeCJ6l85XIOOnKyIbUNbcPNLd33p92iqbopifDYa85i9Wwta/IJbHtSd
         y5mB4R6hDd3uxGWtneBflJ+XlRNc+L8aDH85dtHd4UNKbnAR1W1fu4eZb+VhbSWTp3YG
         pjOzODFgErDMTbbQrHreNRnMA1YC91ULXCLG4se0tJrEhogu26Szm5h5fRKrrFW2BwQx
         Hb0MlRNfCn1ckCgoyCWIQjs1+59m3LdReLvYeuHtMflESt5HTb5kr1SPL7mICc/asUSF
         Wf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjyhMpl+6RVcuTX00YjkBPSKpcZPIvVZnOsw2NLrPRxCZXcLxFycEY2QR10uiCy12Mmi70fU/wIi2/d+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQMuBXBY6e8r3mz41WG8FqsQ/nFnFF3Pua3ji5qMW5IjOYh67
	Yb34oAhggvNnB4RW4EonXl2Zx77oqtShLE4MhqOufDRUGnXnH3mFMkLIDahyospA9g==
X-Google-Smtp-Source: AGHT+IEHBI/fZpADMeHVYOqaZ6tun7dE6bqySMYHi07p/lh5A/1CTfFUIb7KNqN/LIuWMymeRaJR11A=
X-Received: from wmbay17.prod.google.com ([2002:a05:600c:1e11:b0:43b:c7e5:66e0])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4613:b0:43d:1b74:e89a
 with SMTP id 5b1f17b1804b1-43d3e14ff28mr18403955e9.9.1742316160124; Tue, 18
 Mar 2025 09:42:40 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:42:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318164221.1533590-1-bqe@google.com>
Subject: [PATCH v4 0/3] Rust: Add Rust bitmap API, ID pool and bindings.
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

Introduces bindings for the non-atomic variants __set_bit and
__clear_bit, and uses the _find_* variants instead of the find_*
wrappers which enable small size optimization in C. These C
small size optimizations do not carry over to Rust.

This series uses the usize type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

As requested, also adding the Rust equivalent of dbitmap.h now,
under the dynamic_id_pool.rs. Includes an example of usage
that requires releasing a spinlock, as expected in Binder driver.

This is v4 of a patch introducing Rust bitmap API [v3]. Thanks
for all the helpful comments!

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
Link [v3]: https://lore.kernel.org/lkml/20250310161947.1767855-2-bqe@google.com/



Burak Emir (3):
  Adds bitmap.c and bitops.c Rust bindings.
  Adds Rust Bitmap API.
  Add DynamicIdPool Rust API.

 MAINTAINERS                     |  14 ++
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/bitmap.c           |   9 ++
 rust/helpers/bitops.c           |  13 ++
 rust/helpers/helpers.c          |   2 +
 rust/kernel/bitmap.rs           | 234 ++++++++++++++++++++++++++++++++
 rust/kernel/dynamic_id_pool.rs  | 191 ++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 8 files changed, 466 insertions(+)
 create mode 100644 rust/helpers/bitmap.c
 create mode 100644 rust/helpers/bitops.c
 create mode 100644 rust/kernel/bitmap.rs
 create mode 100644 rust/kernel/dynamic_id_pool.rs

-- 
2.49.0.rc1.451.g8f38331e32-goog


