Return-Path: <linux-kernel+bounces-449453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 226479F4F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429DA16B29A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887DB1F8AD9;
	Tue, 17 Dec 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nc3/LszT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DD1F75A6;
	Tue, 17 Dec 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448801; cv=none; b=q83DrBTpTpSBE8FCR7cH/hFjii5/C12/NGamjbhm8SIRXhswSWwOK26vG25KI1Y6pNpwFB5IY6/AoTKA3C84yqmHFR39gcQfNv0CrAIpUXIjc6I23YO9eDegkHEWkz530ea6dGckV3wNc3wpI3ThdT6gGra66IRJUXZ2/uhPqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448801; c=relaxed/simple;
	bh=/ybNIO+z0YMt7NQe0O7P3cxsv0vraqHKkL76VnTITTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7zV+nEtYX+22LWOosTAcvo1rgVAlC4cE33AiOADyW9tGvA/dsrztsbyxj7tj/fYHwHIU/wChuFtXzl/6GrZohRrhtYsacG2oSOWNF2N2M435jpEARd4NQUP1chjFq99UF3lRzW9SOhzt/teuhTdjHblRJFtungeNRjClL0T5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nc3/LszT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBD5C4CEE0;
	Tue, 17 Dec 2024 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448801;
	bh=/ybNIO+z0YMt7NQe0O7P3cxsv0vraqHKkL76VnTITTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nc3/LszTi9GWy0K9sTjN6vOuCsKLUT/FL0BazaU7V3G8WbmuirrbJVFAlXSeuNjN/
	 w4Ow30LPsglg2W1GnDd8eit8hjoAEJUzp7O2TSwtr2wB79r5AhQdpMRmriy8z8mt0y
	 Ce96eJhjUEA4bHIjmzCNP3v5Sy51MUyzSIqrG6fucjBb2C2gj79DZp7RCLyak7jH2Y
	 yZPA/PyAJ11MiEXaEPC47VjEkffxFx+cB+M+6zrKmaMezhjqzkEgEdKTdKbOLzUP1c
	 qkZ4Ljs+LBfZrUCHW56G8RpeGgrh1hVXiXLupN8nxKSVa+hLEVQjkjEiqWKMHjMFV9
	 2cWZBbit5WP+A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:32 +0100
Subject: [PATCH v5 01/14] rust: time: Add Ktime::from_ns()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-1-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=zvxjVReWexH5OF8VhuSFOtSXv8mRCanz1tBYjzejoHo=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYRnvVPrMLQSBo9/TW28kFLLIJnJQRiXNwI5
 EjBOqQGQ2iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWEQAKCRDhuBo+eShj
 d8GxD/wJZIeTygsVvsTFdKxvI/6oExJIZfJsVNodXip5ZpNxljXmHLxQqAZF/1NzdDeduYzG65k
 QfbUfa4OM4zxOWsyqWwEGkGK66qvvPpGdgUsQsOHQ+pfmOdMQ/BFhM5sSfOnr5sebHb5qB1/UES
 WSM5yDP4U422Z06V9HH4RuzeBpUOdv/o3YMnWa4KF8G5CAVk6E/HSy9JYE5gxdW5/kKoIPn6c/x
 vVBYnhOC/uV85PjLGTQbdQ1j2nyqrgruGefvbyrz07+7I5Z5w0gN39kmKaekmTWp3y3vR13MaAl
 5i97WM81nEreHcQ4FrCzp6V7DC4lHDJQJ6tgep4NZzeEVowgCxIcl1PEbCPGDpe3U6QURCtVrY4
 fuS14NJbOGnAVsWYDTSHMHhWvtdPtPAcgKYfzG4V1uE1I0YRhTJPQ4k4jpasD0sg/S581ZAMqiw
 sXDDt+ykQ+pukSh+Iq7zsahSXhDxH9sG/lcKAhYyWCte5pqAlnQH4qBsbv3vd6jJn9WtT6n62XY
 nMxunbss0O/lQuLxdUicYlqZoH6LaJhVZERTuT3iPGHVKR9xv9c0plplxJNcBSKc+y4QDAi3yK7
 +4SwQj3WfQnPlmKCc5eL+/kNwWhqyqYLZFywtBxaIY5GYBkNr5L7qzyt4LpTWTKYcdubquiekln
 87H6r1Q2Y2M89FA==
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
2.47.0



