Return-Path: <linux-kernel+bounces-528970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B95A41E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A93189FB13
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FE205AAF;
	Mon, 24 Feb 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssYWvRPD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D32571AF;
	Mon, 24 Feb 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398752; cv=none; b=TYdLay5bXNVa+2Ou8eG0EBL4H048WY8k/e8SWsO7FkKwfj/vgQFrOnUUc+2ULSd+QDNX0BLmQLS24tfK9IC34XTiFYMAuRrTtlphEQuItqdno8Rbi7/+yjjAaRLhjBLejTLHUcKYgFQzsDg3WxPyLQ3jWmjbyB729XhZJzAroBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398752; c=relaxed/simple;
	bh=KyRv9U8051weSTZd8kIi5Ms6sAzIrGz2/6k73qD/frk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PomKGbuGMVR/5mn4n3h60+R2pZjlPoFvCgeQ3OGR6xwicEAHr8MbCaQYgWw7FfFUDD4L728dka8Un8bftSRF5Sb6tTPJkPGjkzky1oiCGrmJVAqVIscjDpJQxdyovzOUpK1QTSaorYpj79V2TlRcy04bH4H4FvR69ZMIiyNGgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssYWvRPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52782C4CEE6;
	Mon, 24 Feb 2025 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398751;
	bh=KyRv9U8051weSTZd8kIi5Ms6sAzIrGz2/6k73qD/frk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ssYWvRPDbY2189UpnKSqy2Y9jwstzajC7ELmwVXefkKNG3aP1C7csCTqiOgKn+nIC
	 fFmSwAd++NqhxVtkss7FSxkMchO7xS0yRql8h/wn47/5oCnCXbf2svgsqzlkpKZlCE
	 VBvijNHSipxWT6uZJrFA1eSv9B9mxId0mDTeRqvXWakN3F/RBdsnzpt/efTg/2rIZP
	 MKZNl9A53pn43BaXGFLv43W5LSCa0iqTO54wppId0iOh9BuA0xgbR7WQVieOb3pio0
	 Oy9Bn9MfEEY6yDFNTM/5YlZ/YarDjlZcTWmViEUpzwM2fs2zqA8otNZQOdiFDe0tK6
	 EI43k7IrXXUIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:43 +0100
Subject: [PATCH v9 09/13] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-9-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=KyRv9U8051weSTZd8kIi5Ms6sAzIrGz2/6k73qD/frk=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAkQWtjGodQLW4tALY0jSA9lpLHTC5fOUlpG
 360ZMN5d/iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgJAAKCRDhuBo+eShj
 d71jEACrVO9TMxmnAzqxlZrqLpnLqpP2/pPRzcrGxh3mwLMJ/Pz7+Hgq9rk8bmVD5tRUeVqMNxd
 UN9K3I2XCSUs2CztGW4C1IbCjrvvNM7JXteaUj3/1+78YlhmRU+dEzDpiahLpx2wXlCTw7LZDfO
 Dv+tV6X+8hUDG87vB1K26DpE3efB+cQ4kSXJOs0dp5iywteG5dEl/cZysdlxBGDmyId++uPTW3K
 qBoer+QT+zk4fg1ajsSB2ZldX2ND0wcvlti1k+0yS9gIpZroAK+PdsDpLN119C63AsBmKxuSXzH
 SRTWJmfqxpAxgtqa8jyD5efOZPSqROJPugBNgqN4aoY+OmisiyXrW81nV7isj4tBJGGJi6W3HGT
 9/BxjShNvHrlgz/XcM2cjjvr9x6NowPLQWRAfceOs7h0LDdXfxY+yWv103bmkQ4NphtoOmTbbJT
 XYAQORmCWnGE2x+eEsBP3Kecya0p0ISaSWjwrfiK+Y0l7qIXBOceaOVbpeT2kCoaQ2gHrUIzApt
 yq2eMBFlhUCQNpAHduHpVdHTKn/3jHw5sZZ8VU4SYugneKGyWhSMOHEkhyzJ13FTmoehfiuwtHp
 Wsc2AVciSJQ3XJ0jVwaPjCVmgoLJccOj5k8Vy0ZuAAp0p8pisHz8SRXvhJOV9rRCvcxPFvqpVzU
 GCzRoIOC8fSTbhw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index cb4ebea3b074..9da4a32e60bc 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -245,6 +245,12 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
+    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
+    pub fn into_pin(this: Self) -> Pin<Self> {
+        this.into()
+    }
+
     /// Forgets the contents (does not run the destructor), but keeps the allocation.
     fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
         let ptr = Self::into_raw(this);

-- 
2.47.0



