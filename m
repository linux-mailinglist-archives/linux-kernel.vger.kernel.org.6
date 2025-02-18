Return-Path: <linux-kernel+bounces-519509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC7A39D78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4AF7A28CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0A26B0A8;
	Tue, 18 Feb 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNR9a4Yu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342AE269B15;
	Tue, 18 Feb 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885288; cv=none; b=Pm9MSkMGkSlKuTiY0bQW+bSSPFzbe99oBTOH/pGFhYG6RYDKG40ngt8O9ntxoo9FXHgxcRWJYHYVBz+EkhpNB4uwR/yzyE+VnTE2jx2TJNhf71Mmov/SG2glQv/fgMyE4uBodVaiZdF5RGNsytWwT0qECuoBgdIKBasj9aJHogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885288; c=relaxed/simple;
	bh=fv9JapopXp9S0KlZSEhULwSrLVlfd4Fs0oJ269tvLlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrEnNYCYqAHX60FtdnkzQEWmoknFrrM/Y17DBfNkTwtuARIRScJdvnUhpEL4BAVZDhywqh+/RzRRdjmoiUcD4DHSxxIrho2D545iMxmPVvn5resvi7RaXqmImdpNihpCszpYlwixKJY1ZdKVnba22SNzAvmibrRkfEodxYcPGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNR9a4Yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8773FC4CEE8;
	Tue, 18 Feb 2025 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885288;
	bh=fv9JapopXp9S0KlZSEhULwSrLVlfd4Fs0oJ269tvLlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iNR9a4Yu9Wu0C3DfmRPaveT6+6+TROwQ9VvGmhAiy7ddv2ezBy1NwlA8PQu1x8lzb
	 1DQztneGSo1VvoyuXC7n1GM8n/L1PIYozujnGLaV4ojP5KW8JR7kQhV+pdYaofG6C7
	 lTPthF4+aVUWfqzr/H6wyBGvWyquE7moHSsiK54CWO3ykbtzdTk1f9OLR4Jl0ejReb
	 rrBbz6KAEeQC+M2EK2q71vIs8DE/ODU5eVnadmPzbRUmWW2nd5bFIb7FUhxN46H/Dx
	 RMVO8RkIztBRnXcLg0Kk7mUMwJ5AEIPMgo0RqtEW1qMvHWFm3kxShCzbZM62YOEGEl
	 +y1lfNcG9D8Lg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:06 +0100
Subject: [PATCH v8 01/14] rust: time: Add Ktime::from_ns()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-1-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ZTiCs0Q48kNHhodERi8HFfU/OwlrOIEVdq8syuCNH4A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIqvibbhkMUmTWZVYPx6A8d60jatjWh01z7kq
 cO+DllDjEGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKrwAKCRDhuBo+eShj
 d0xMEACXJOI9grvtZQ7HYMKKNVDqL6iFv5zp207TikCuv8eqrerf4N84wrGMaNnfCkFPSOYPuZV
 8zeF2EHqRYD/7x6BEsg4weueFtpVCz74bYYxCp4uDcxTMiauRnx8WnXIh5oU7+Ne+Nf+t/QiDsZ
 yciKMHq/S5D2IOamWyv02tsSZS3nZThpeVYZ0fAOG8DCetb/lrAgRskLEUZ2q5en7wIc3yiCe6X
 8yXTDHuKKu+v2wWc3CUnJlvSvM63Pf5+HcQyrsyi7c9zVWiKemFR4sRZMix098REFj3bU6vUKVN
 QH+XTrIrssKqyj4mIKBAIuKVmwxcX6klRks2e/pHPqRqSwz7cBSD3yJbdet01YQ4B26kzCMQlOJ
 Juw8p3ATKSmWAR0NauuCobxfyM3zNOjX6LWZln5SW9CRk2fqE+dwdWvhe8U/Q8DrpTiJhN9KUW/
 RT6iSbW6XjrD/c3Dj+cyGHRqCGjZFsqmI9Wwt7+tvXmfQ0crJPWkzdHEW+ytjkWSnBKjIQ8OCek
 XX4ySmK0+esRVF5DkirbHMvlfCAF8YYSQ/ZtAhMWkMyaXUdoLrVIE+dPJAyveCi+Lm2FgdUokTE
 6ip7RoNQt0F//2sXNlF3ymLMYtVaGusb0w9LLH6L1GpAMW0S7wV5Ey+oV8447rMV+EeI7CrDcEa
 LxXWANaPrLioMaA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

From: Lyude Paul <lyude@redhat.com>

A simple function to turn the provided value in nanoseconds into a Ktime
value. We allow any type which implements Into<bindings::ktime_t>, which
resolves to Into<i64>.

This is useful for some of the older DRM APIs that never got moved to
Ktime.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 379c0f5772e57..87e47f2f5618d 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -8,6 +8,8 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+use core::convert::Into;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
@@ -63,6 +65,12 @@ pub fn to_ns(self) -> i64 {
     pub fn to_ms(self) -> i64 {
         self.divns_constant::<NSEC_PER_MSEC>()
     }
+
+    /// Creates a new Ktime from the given duration in nanoseconds.
+    #[inline]
+    pub fn from_nanos(ns: impl Into<bindings::ktime_t>) -> Self {
+        Self { inner: ns.into() }
+    }
 }
 
 /// Returns the number of milliseconds between two ktimes.

-- 
2.47.0



