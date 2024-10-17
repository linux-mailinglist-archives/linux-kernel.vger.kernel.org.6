Return-Path: <linux-kernel+bounces-369829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E7E9A2335
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1198E283273
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F61DF96A;
	Thu, 17 Oct 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjXHgz3I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9061DED4A;
	Thu, 17 Oct 2024 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170602; cv=none; b=B6FVk4IAJsP8LU/x+STfOgis89dnkAX/KXQOxnMIjTscrIAJfVwQEyH6xl7KL05IOeai1FQwmQFj8Qx0AWAr9BpPtVtmwiQfDjTLC3yluWAPygHpq/zpY4veJ4QRKjxSOlL2uk27NY0YvO1LalgA7n9KBnGmnntAsTgyNo78o2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170602; c=relaxed/simple;
	bh=thj1T8GZG78if/h67vxds3HK/7SEb5HLjMwJifphF9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hdj3wcx+VOWOgkx1AV/yReEXO5ByRe7TBg1dbKkGcUvx8kjO8QsIqsHTU7lyqsO5DYxBRjuoD+qVnTzrpq5N96+oBEtjdkd2h+IsmneoQ7sZ1xvi7cf8drkz8xlowhjEEX/8UDHETyALVNVzE2FAWZ8NFrCU2J35hR1UfLy74+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjXHgz3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD88C4CEC3;
	Thu, 17 Oct 2024 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170600;
	bh=thj1T8GZG78if/h67vxds3HK/7SEb5HLjMwJifphF9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sjXHgz3I47Fe4Q46fTPIQ624SSSNddSi9yCyXxh5YCvxboAtF7rDfm9knhR5fLlj4
	 sXEFtn02uVTC/0y2TLjaBVEjZgmh1A1Kgf6+5GK4ZLpcfmFeUJi8GKsmWloBMQfQZE
	 7jTm6VTtlvzKowIYqDaGB7acXHOKHry9WDDV+Aw6V363eyjjxsGNKRD4lDFMlhh4zn
	 hYNbDjSI3JWlr2agG5OWhP3QvP99eacXnguuuOBH3bWrM0Sr+m6KtpW8lMDNkpAviY
	 iS3pg/4Q9D2QzW91iUWHiK1epVyNryH/b01ceZnVrcnRADiWiP3mS+125VlvXfHvZY
	 mpjHNflgIrbnQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:28 +0200
Subject: [PATCH v3 01/13] rust: time: Add Ktime::from_ns()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-1-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

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
index e3bb5e89f88dac423e2c0083de8fdfe5ac9a272f..1e02eee09f22b08d4f3ab160e8b31b341b5d015c 100644
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



