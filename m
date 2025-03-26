Return-Path: <linux-kernel+bounces-577080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564CA71816
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27DE617006F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF41F1908;
	Wed, 26 Mar 2025 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Y0Hd/jYo"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920CD187876;
	Wed, 26 Mar 2025 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998033; cv=pass; b=eJ4Ibaw/lCj6w+VBVkmvKB9wFJTKeuF7LgCRWr+KlAzky0vPgvzEnNgJDpS1IMR0w6bAhrP18fBzbaUJRX+gEpUscp9/vujjDPeiSv9mQbGE8mP1u1UAbjU/7iMtw9JcgbyCyuL9DrnDLRdLX63VVI4xMkRXyiFzxiwT1JrXvf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998033; c=relaxed/simple;
	bh=SBLV0VJC/LnEEvBmOyWQROgZ89YKVg0CGQjMw5ekcxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g5fG5Zqd//rhM6NfHghAr7wr6L1Y1Bt6CvhTzh+gll954PwRuVj+xuFNXzhEMDbnH7ApWfgH9p/5zuHWyqPu07zYR1IsRxBEbduVKSgZ7VoPF5fCrhUuKwxlrevy4NxcrYDf+sZGjBU0N4vdyw1JE+D+DCiT6vl8Q2WHkUg9kEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Y0Hd/jYo; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742998000; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a6ZbH/fP0TXeV+gCcj7pb2rCecVxw0gzvKZnxTPhF0su2k4yESLDmIrhb109E+ooiwM7Llxrow2QkRupfbN+Kdsqkoc3aEPesJ5Wkusy5HJRKHHmPy89qND07QtmFjGN9eenAwvj/f+DiZGJOil6iQtCEirJULZV88QGF1s327g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742998000; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J4LCGwLp6spQjk9n9SscwRTpBKc1KoEtML4ye4gzsxI=; 
	b=Rg9hv1FcQYwp9/mIyiAa14deBefm6+WTPSrZFcfmO4VPCj1VxsMX4+JnS7nYQgFYrZeNEATTQ0wEAexlhc2gqAqOOxCihLaDZbnr5h8DuIh5uGv4IWik2RMEs7w3vEQRsQE5dwzyXVciIZbKwWQqBwYc3ypsCPHNhzCNNWyVZAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742998000;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=J4LCGwLp6spQjk9n9SscwRTpBKc1KoEtML4ye4gzsxI=;
	b=Y0Hd/jYoO0Jko14vfKqw09Bekb9j2Msw/L4P/nJloj0IpRUZQ4LssD7dhr8yN0bE
	269TByWf023oL8iEbOhA5mMYhDYTtvH1eFf3zHvEO5HnB/7Gmzhw6D4erZb0DendHR1
	OY7i71GZcHBRY0quX6J7oDWgyjv0fl+b1Ulhlzos=
Received: by mx.zohomail.com with SMTPS id 1742997998123534.8338467980343;
	Wed, 26 Mar 2025 07:06:38 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 26 Mar 2025 11:06:20 -0300
Subject: [PATCH v5] rust: kernel: add support for bits/genmask macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-topic-panthor-rs-genmask-v5-1-bfa6140214da@collabora.com>
X-B4-Tracking: v=1; b=H4sIANsJ5GcC/33NTQrCMBCG4atI1kaSTKLiynuIi+l0YoPalKQUp
 fTuRqG48Gf5fjDPjCJzCpzFbjGKxEPIIbYl3HIhqMH2xDLUpYVRxmplQPaxCyQ7bPsmJpmyPHF
 7xXyWHityG/DsLYhy3iX24faiD8fSTch9TPfXp8E81xm1v9HBSC23zsCGtFfEuKd4uWAVE64oX
 sUTHmDGnNJG/8GgYI6gqr3RxMp9w+wbA739g9mCgVPKesI10gc2TdMDRXDx5l4BAAA=
X-Change-ID: 20241023-topic-panthor-rs-genmask-fabc573fef43
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Fiona Behrens <me@kloenk.dev>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

In light of bindgen being unable to generate bindings for macros,
manually define the bit and genmask C macros in Rust.

Bit and genmask are frequently used in drivers, and are simple enough to
just be redefined. Their implementation is also unlikely to ever change.

These macros are converted from their kernel equivalent. Versions for
u64, u32, u16 and u8 are provided in order to reduce the number of casts
for callers.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v5:
- Added versions for u16 and u8 in order to reduce the amount of casts
  for callers. This came up after discussing the issue with Alexandre
  Courbot in light of his "register" abstractions.
- Link to v4: https://lore.kernel.org/r/20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com

Changes in v4:
- Split bits into bits_u32 and bits_u64
- Added r-b's
- Rebased on top of rust-next
- Link to v3: https://lore.kernel.org/r/20250121-topic-panthor-rs-genmask-v3-1-5c3bdf21ce05@collabora.com

Changes in v3:
- Changed from declarative macro to const fn
- Added separate versions for u32 and u64
- Link to v2: https://lore.kernel.org/r/20241024-topic-panthor-rs-genmask-v2-1-85237c1f0cea@collabora.com

Changes in v2:

- Added ticks around `BIT`, and `h >=l` (Thanks, Benno).
- Decided to keep the arguments as `expr`, as I see no issues with that
- Added a proper example, with an assert_eq!() (Thanks, Benno)
- Fixed the condition h <= l, which should be h >= l.
- Checked that the assert for the condition above is described in the
  docs.
---
 rust/kernel/bits.rs | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs  |  1 +
 2 files changed, 94 insertions(+)

diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
new file mode 100644
index 0000000000000000000000000000000000000000..ddae8a5be4698bb7df66ee2c42ac6c2bc07eae7e
--- /dev/null
+++ b/rust/kernel/bits.rs
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bit manipulation macros.
+//!
+//! C header: [`include/linux/bits.h`](srctree/include/linux/bits.h)
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u64(n: u32) -> u64 {
+    1u64 << n as u64
+}
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u32(n: u32) -> u32 {
+    1u32 << n
+}
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u16(n: u32) -> u16 {
+    1u16 << n as u16
+}
+
+/// Produces a literal where bit `n` is set.
+///
+/// Equivalent to the kernel's `BIT` macro.
+pub const fn bit_u8(n: u32) -> u8 {
+    1u8 << n as u8
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u64;
+///     let mask = genmask_u64(39, 21);
+///     assert_eq!(mask, 0x000000ffffe00000);
+/// ```
+///
+pub const fn genmask_u64(h: u32, l: u32) -> u64 {
+    assert!(h >= l);
+    (!0u64 - (1u64 << l) + 1) & (!0u64 >> (64 - 1 - h))
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u32;
+///     let mask = genmask_u32(9, 0);
+///     assert_eq!(mask, 0x000003ff);
+/// ```
+///
+pub const fn genmask_u32(h: u32, l: u32) -> u32 {
+    assert!(h >= l);
+    (!0u32 - (1u32 << l) + 1) & (!0u32 >> (32 - 1 - h))
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u16;
+///     let mask = genmask_u16(9, 0);
+///     assert_eq!(mask, 0x000003ff);
+/// ```
+///
+pub const fn genmask_u16(h: u32, l: u32) -> u16 {
+    assert!(h >= l);
+    (!0u16 - (1u16 << l) + 1) & (!0u16 >> (16 - 1 - h))
+}
+
+/// Create a contiguous bitmask starting at bit position `l` and ending at
+/// position `h`, where `h >= l`.
+///
+/// # Examples
+/// ```
+///     use kernel::bits::genmask_u8;
+///     let mask = genmask_u8(7, 0);
+///     assert_eq!(mask, 0x000000ff);
+/// ```
+///
+pub const fn genmask_u8(h: u32, l: u32) -> u8 {
+    assert!(h >= l);
+    (!0u8 - (1u8 << l) + 1) & (!0u8 >> (8 - 1 - h))
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c92497c7c655e8faefd85bb4a1d5b4cc696b8499..a90aaf7fe6755a5a42055b7b4008714fcafe6f6f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod bits;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20241023-topic-panthor-rs-genmask-fabc573fef43

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


