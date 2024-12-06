Return-Path: <linux-kernel+bounces-435525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7349E7905
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B2528467F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733F20626A;
	Fri,  6 Dec 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9ObnEFJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A37192B76;
	Fri,  6 Dec 2024 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513715; cv=none; b=NI03eAe8YARcbEKQhmQhXhgUJqK7MPSJrSFlGfkAH9Htr3vPppivYMnMj2gAPO/OTG3+uk7lSSkNdDcA093NyHo+0Gq8egIUlvQn6/5VcWeyKhBy4fJdq2vpNPuJOKXcLRu6PLGmdA3fqae9Qtq8sbv1SUUfz63Fia7lWLsm86U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513715; c=relaxed/simple;
	bh=6xLEbR0EIB8Nn0LgnN+aKPyBmaJP6NyFspAESdf3mNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS3oqXKEvKcnzZmYf0RVNcs10cy85rGxHZRadGK1gqfKP/Rzrfiq6x5x3IjbI5Eh8YwVmBW8vMCPiqeGqw+iWOov0GIfd/vBH6g1H6biPETmqFg9xm4VncLCMBi7+41GIl4W3wkrpS9lsimEpQb5rqNVuCcGMyVj27HavvxVu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9ObnEFJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0A0C4CED1;
	Fri,  6 Dec 2024 19:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513714;
	bh=6xLEbR0EIB8Nn0LgnN+aKPyBmaJP6NyFspAESdf3mNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l9ObnEFJr0DlDWafnqrUCs0s4pYo9sP/F6Xm1ofs2vUGmneEuf9zPG0XCCioNORQC
	 4X32/ZfGlf444ffh59oDK0pTEaziyzoPtipKw56MKGEFk6zWyw+AltHPrsWqwbRWRY
	 Rv0gK0Bm1rlsgGhJPgjIGWZSOhZFHp+lnpPWxtKsv0QwkhfaT5HFT1LQGnGTGrt3Qq
	 fycuitNrQf9jCQ4z6H/PPyU6HWnzHRt0rW9x2O4jSO4yiFxSoneHgjKLVu1oO3vNTF
	 PqHLHshwSIt31VxUREn8Ja7qWsopngh+Huth46p/EsQx2QuaFK7b1lZBw8gM8A5sGY
	 xyrf/jKO/Ntxw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:02 +0100
Subject: [PATCH v4 10/14] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-10-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6xLEbR0EIB8Nn0LgnN+aKPyBmaJP6NyFspAESdf3mNM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVhHSitJZ3dHNEx1TEZzTTR1c1RNZmc4CjJjNnhkS1RjdTJEQVJyWW5h
 MEorM0lrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnh
 BQW9KRU9HNEdqNTVLR04zMmdNUC9pQk5qTm9FME5nLzJnbnZyaWlCNDBqalpTcVFid3NZcWRLUg
 pLbDh6bEszT0UwQjBCTDM4eU02YXNiYjhXYlJqdVZDU0hVQ0ZFWEVYNTNvUm5hU2QvRU1oMWVWQ
 lNLcE5qZmR0CjEyMllKcmpJQlRGNjdyYkR2NzlkLzlncVNhTlRONTBOQ0NhNmowUHEwN1U1OG0x
 UHlMdFpEVmwvek1HQmV3QkIKMjcrUi9jMlZBM1FpSXNJUWpHYnFHVkcrRDlrVjZGaVo4Mmc1Z1B
 aZEhBRHp1MnZzRmlUSWNucmJGZjh0Nm5vMwphRURlaUM3c0d6SXNPL09seXQ0WU5mSzdxWHlKcl
 VXT08vRTJBM05mZ0doRzQzalZzcGZhMUo2NFhtVTlwN0FVClNrcytPZGY0cFVneWJjL0VMUy9Qd
 Uk4MGVRWEtCS29vSzFlTWQ2WmQ1cFc4Y09xQ1cvbm01cUlTQ3FEQThuQlYKRkQzbXlnSU5DbXFN
 NjhaMTBCL3ppYldHMjc3Tm54T2F4eWNWTlhMT0MzRjBZMnM3QmZma1NHU1hYbHpNTENVVApTWFN
 UZWdpRWYxUWlYRUhwVGxlM3hCUS9WK0RTbU8rVmhhVEVHSEZqd0JiaDdpcVlpaFN1Z2wvenJKci
 tvNG5XCjQ2QWRWenRVcWtia3lTRGdYeElrUVF2NzdSS0l2RldTdU9ISVh6UGwzODFkT1ZKNkdpV
 HNrY2pydVZocnhLZk4KaTE2U0tqSEwvWTFPcWdCTTZ3eGdXY2FTZXZrMWtTcENDKzNZd0FLNHUy
 WnY3aHgzNmZ1TndRRkh4cjdwcUpxLwplNzVSQXdSWUNEbElNUFRlUVM0YlNUOWc4TlR2MmM0SmR
 yNVRFc0g3MmUveFpMZ1lodmxuZ3dYYjVIZlYydmJoCkNheUh6TWlrRXlNdDlRPT0KPTFLV24KLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 9ce414361c2c6dd8eea09b11041f6c307cbc7864..1a993ec8602b37041c192458d8b6acff30769a04 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -245,6 +245,16 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
+    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
+    pub fn into_pin(boxed: Self) -> Pin<Self> {
+        // SAFETY: `Self` is guaranteed to be the only pointer to the boxed
+        // value. Thus, if `T: !Unpin`, `T` is guaranteed to stay pinned; there
+        // is no way to get rid of the `Pin` and move out of the returned
+        // `Pin<Box<T>>`.
+        unsafe { Pin::new_unchecked(boxed) }
+    }
+
     /// Forgets the contents (does not run the destructor), but keeps the allocation.
     fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
         let ptr = Self::into_raw(this);

-- 
2.46.0



