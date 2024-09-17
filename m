Return-Path: <linux-kernel+bounces-332127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542D97B5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D174D1F24F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D81990B7;
	Tue, 17 Sep 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIVYGCcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBFB1990C2;
	Tue, 17 Sep 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612154; cv=none; b=lt2ZtfozZYIWBn6wr7hVuuNuK+Li0G593dFXGmEcDsrxkpqhBx+yRWkWZ7E7X1gTlwZXfzQ/98HWSqf0uDwb8AUjTuIaaum7fk8RQJ64y3bkyEg8dYE/LJv7A/EbMe0WW2DidIr26AlhBrW9733/evQ0eCDpbTP9SLEnQEtusbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612154; c=relaxed/simple;
	bh=QoToNYKM5P+hCZzBsqEar3hV8ugDLwq+6nZGBAtQAu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ9Ba/vhxkcTr+OYmFbOxZJO7rEHRSA4b2F0Wo8dZEkiDXDB8XZus4AXGS/nQFWGcleEBMQP/vmgfrUdRQrlcLULUmhSsHMHZt02hima5OFg+KGpaf2RM6EyT5LFyR/aystDHeNDpHQ47iBWyfFazXjazOUlmBpjwm9tGwp1vKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIVYGCcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592FCC4CECF;
	Tue, 17 Sep 2024 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612153;
	bh=QoToNYKM5P+hCZzBsqEar3hV8ugDLwq+6nZGBAtQAu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIVYGCcB75U5Gz5wc/R6uqc8b1dH88tHEAaXrWzrWLyWPfqop0OdQjz2f0s17uURR
	 X9UGyfDkRzATb23NAcmd8Ou6PL8kHBExqYkBh5W/DYtrx1heIu+T2XGAialS3ieZ9E
	 vIguVsWPQjMFtzx3eV7EEL9xs6MA84xYdLnOo9mQuQ1EOEf4zfItECCBVpadTkIHQ0
	 JJ/9E5cMGzphYk90To9bEAz0cCa7BBaoyEcABvfxx6DtRKN4RGGy+bQ0KAwFoz39mx
	 IxS2EZPNVYeplv/ggkKQuO6nyCFXiTIX7sYuneZP3vyVnCS+n/cN6Wwcy8mWYS7tIL
	 FatqICA+lCJdQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Lyude Paul <lyude@redhat.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] rust: time: Add Ktime::from_ns()
Date: Wed, 18 Sep 2024 00:27:25 +0200
Message-ID: <20240917222739.1298275-2-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=a.hindborg@kernel.org; h=from:subject; bh=7NIyQ7Ry9zbDnUQEZUNPDU6fCOWXJskfOgDh+J4/n6I=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZVaCt4eG5PS0lNejVDaTAwRmNvZjJWCjFCeThJcWlIVDNzUGZvQUdq UzJZKzRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDF BQW9KRU9HNEdqNTVLR04zSHdjUC8zUmFOQWpqZzFuTlZZZ2hkdzFveE9uelJWTGxNZFFlalZFaw pwcEtvY0ZuYzR0WWdHNzR0czFGajNTeWpEQjFHRFRnN0EwR1UrN1prM2JtdUZVdk40M01Id3RYQ mVDb3QrdGxPCmYxQkE5WHIwWk5GOTg1WStaM3hGSnJvNUxjYnlEWXZoWjN4LzRUNkIzdE0wYWdz M1NLaWlrWGsxc3ZyakhLeFIKV0djMllOM0hoMzJKM2xSYWpXR1J1QjFUeFY0QXY3NVNsQTdWWGM xRlBOM2FmMkVxckZQZ0Q3dTg3dnU4WDl5cApnWXRNdCtxbkYvY3R6THk1REljd1dzL3hBWkJtUG U3SE1rZXg2djZVZVM2cDZaRjlTZ25rZ1M4VmlYRWpGejRvCng5WCtUeVBDZ2FEY1lTZVFYcDU4O DdFeC9pbGZDd1VTVm1PT3hETkx1aXRDMlNvc3kxbGlXalRaWHFnQURLRlIKdDFxTTc2bm9PTDhi NVE0eUxjQmRlYkFIRmtsN1BwVnFnK3JyVDZMZjlxQU1hcWdSQTM5ZHgrdWhKODROaG5JeQowbEd ib3Z1cXJZdWx2NkN2R
 HUvTFQvMmNqbHlCYkdWOERTYm55b0VNOE5hNlYyekgyZUpWRDJLSlV1c2 pIZ2JhCmdXT2xBMFpTOWh3aVFuUDI1ZWtHeU1MOEVNZjUrQ0lhT1F0UmpwMkpvdVBSdFNRWXNsd HZkQUI3cFovTkxPcUgKSjVmVTBxSFlsbXM0QUVGMGs4UXkwclN2U0RIeVZBOEczN1U0b1JNV3pp ZDBqWVVDWE1wZzIyM0lVMUpZSVdRbQpkcTJCelduV0xsdEFuN1Z2RjNIQ2o2ZElKU2NKRUgwaDR rZ3VwSmVZYVpLV3Fna3VhMFpyYmxBaXlwVXVnZ0NwCmR3dnhqYmo1YWhZaHNRPT0KPS9IWDAKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

A simple function to turn the provided value in nanoseconds into a Ktime
value. We allow any type which implements Into<bindings::ktime_t>, which
resolves to Into<i64>.

This is useful for some of the older DRM APIs that never got moved to Ktime

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..1e02eee09f22 100644
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
+    /// Creates a new Ktime from the given duration in nanoseconds
+    #[inline]
+    pub fn from_ns(ns: impl Into<bindings::ktime_t>) -> Self {
+        Self { inner: ns.into() }
+    }
 }
 
 /// Returns the number of milliseconds between two ktimes.
-- 
2.46.0



