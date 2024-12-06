Return-Path: <linux-kernel+bounces-435527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E69E7907
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBA0284FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC3E20E33A;
	Fri,  6 Dec 2024 19:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5Y3RBcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB005192B76;
	Fri,  6 Dec 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513724; cv=none; b=sBiuQTH3YlujwyREaaHFN2dF3MOg9RzVRMt7P9WkFV2YXdIWGX6QjGdUD2WotVmsXsLJxWiAkTdJrbBht65BMp5hDEMR1FMDMZiM8P0IGbXxUqaY4hOqDv7oQEDDSvU+g/QyFW2BJx9iu2cIX2+3hz4P6vAXN0P2dPhxd1Ygfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513724; c=relaxed/simple;
	bh=xS2xojV+RkeX5FfW1EiMY3iI+ynZ/ywVhO4sPQ3S9wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOL8T2a9bZj8l1gHHjeC4E42K22MUqRh9PWDN3b7+D6vVN/e5l9bk0r2hA6pLj4ez3Tll03QOYSz1DqfSiowpTMYrlCSaA1kj2Qm81NuahGtIWGQfxR4iGJJhaWg/Mk8EyqC/8xnK4kpCc5cOi9XnZy05MgETn0hxZgFcxaKqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5Y3RBcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73097C4CED1;
	Fri,  6 Dec 2024 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513723;
	bh=xS2xojV+RkeX5FfW1EiMY3iI+ynZ/ywVhO4sPQ3S9wI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p5Y3RBcjHn4XebV8SWVNKZTQZVklkNNldvM1X0GmbG+UTSzjwtoCmZO9kMWaAvlsx
	 ho/n0H+6YVUDSLLoh7srMxgHi27cJG74hbCZjFkFJK5N4JemXv0rFWQ2C55CVUsOaG
	 0VFOQtrYRjgcu6Q6iemOHMWrzkjSxZud+ClDtPcr13FB79MtOtA5Qi5y0aDusKIXdW
	 U5lvwZa4M5qeI5VjPaueQBXV0FzfzkXDOBJFp1h8RZXvVMbxmejnsg9+OchCEKl1xO
	 Nie4mkTY1gvmMFgiUzLLr5+gOsH/Ikh3E7MvAd0Da8qJ6wm7txRfkWvnhHW/F9AWAE
	 J7FrAdUQ/u75Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:53 +0100
Subject: [PATCH v4 01/14] rust: time: Add Ktime::from_ns()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-1-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hPq5VnqnzJbyEOMvhXAWGPbSPGHgBtCBC54UbM9eT0w=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVdtUG4rTnhXSHkrL2VwVktMOEZWbXVvCkFzNXVVUVJ1c3BjbXNHNjZN
 UDNXYm9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnB
 BQW9KRU9HNEdqNTVLR04zc1JRUC9ScFFSYU9vSkxUQnRqTGsvai94Rk5XZWNwSk5qWkV6Rm5BRw
 p6bnpxVm93OWpFbDBzTnlBYkhnTlVGMlE0THcwckxaZ3REbHZVcG5kcmFLZzN3R0lhc0RNTGVOV
 C9MTm9IUE9BCmRZSytUdDB2SFlKM2JSSFFLUS96eGJ0WWRCV2RISkhkekVlVkZKQ1MzNk44Z21s
 cUs4cEFySUdnUlZPRjJsdFAKanczRlFva2VUVFFPKzBnSXNiekZLZ2RkNDZDY3A2MmFERVB6dml
 uaVVJRlFOQWlhTFdBazJZQUlaT1ZqWmlQdQoyWWdpYkFEQjI2Ly9KWXNYckJ1aWlsRWZqUENOaz
 RURExIenNMZnpjZ3N4aDJOcm1ZbzUrOVR1Y3d5Uks1aDNNCnJEUm13TzZzZmJHeU9pQVZUcGZJY
 XJ6SFo0TDdiS2R3a3FCR01jZWovVXVWR2RaYUlpY05qSXpSMFd5d1o2eUMKaUdJbEJaZ0JIamFs
 anJNQzN4S0d6cHNCb05odlExVkhud0NrN1M4bzY5a0JDMkhYOXdvNjUwK2kvUDRLYklCSwpmVkJ
 Ic0FJVkFheGFPdkJZamk0Z2h3S0JpY3lWS3ZmWDVKcXduaUdqWEUvMTFzcndJTm9IUVArS0Y4cz
 htRUM3Cjl5dXZmZHBvWHVBVW9vcHA4d2xQL0NlS0NPZjhhSnJkdVdVQ3pvY3BZZDFtTlVNWHhMZ
 Xhza0dybWhFY2F4NkQKVEJ3UVlNRnU3R2VYWUJSeXF1cytuamc0c0tKMTg3eHVYTzBFWG84eSto
 dmlnYXlSWHpiR1RHS0ZYUEFmbGtCaApFRmlsV3VyQWRoMklQdS9ETWwwTHA4Q1I4c3diVVVMNU9
 5NHVaQkh0V3RSNGY5UUxSWVRaak4xakJPUFJLc2IyCmFXa1NLckdrVDdZanVnPT0KPWwveVcKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

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
index 379c0f5772e575c9ceacb9c85255b13501db8f30..f59e0fea79d3acfddd922f601f569353609aeec1 100644
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



