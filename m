Return-Path: <linux-kernel+bounces-550843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4706BA564F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068597A80C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B11212B38;
	Fri,  7 Mar 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvxRUljL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715520E32B;
	Fri,  7 Mar 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342676; cv=none; b=FRkrfYdrJvOE49jRaMmeCsrekMWAOxXBT4N6PYKIOAVNyVb7+rU1ta1BloP5/kQuBxclWjIpX0uZutzyspIpITPOkf2/Umou3cIcPacKDhiHl0JXAnriJUZe7QRY5NAiYbosvNYrH5CU1OvF1hY1k9ZAnc75E3F9HtCRj4jcGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342676; c=relaxed/simple;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHnNEElvCpVGv4N0zDGfjscO2tpZUK6kI2xNtNIWOUU4pY7qiw4dbAWjkfyi6DzKcwCu6vBH85Is3qW+TuBF4YykdjjHQamn/AFV77L1XNcm/l2rrJC6dv3/d3IrycchgJcFrfrV/6NYgn5lyJYYdCVAXYVnkLYrAWBBRM9TXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvxRUljL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A317AC4CEE5;
	Fri,  7 Mar 2025 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342676;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvxRUljLuTdFdA96RJHJ6c8A2PwUkuOMQcFX7Ujd87y03mySuPUPH3tu2c2DVavhg
	 lDqdR70HD3B7j30QJbM+kOZlu3jK9cNfqjLHQbcVQzZkifaJIiOW6uplmv5fOs4+IH
	 lYQD2yHeI9nuQCnR2/G+iBn6TiCyZY78qigbwRheJlFY56I8Zf4Yo9kq5xfUQVI2a3
	 yzEnilFHe4tlGCPyR+hcmKdcBhAUkKPvdAxz+C1dtd0pFytIsd8NjrmpcRiISzK2AL
	 Xym+BqxREi9LQFSi/2Fe8HiGwYlmiz6B2SDAYEUZnbbFvX0ycrYZ4GjJ22s7iJ1r1Y
	 vSoPp76E7cUDA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:54 +0100
Subject: [PATCH v10 09/13] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-9-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ+zINI/2+NRgYaa3ReFo1WGs8Q9MM2IHhWZ
 95z9nBsZWqJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGfgAKCRDhuBo+eShj
 d8tYD/9fPL+XND+jwp2KwS97M30WKcN7VpZfCHs5WCHeI/xqW4mV3gZSdduxpOWEVxuDX0lbnAd
 4A1NkKNVEQhWhjVtM++wVptgu3hoWxFASLH7V80TVCQHArZstWqof2K3i93CZyt9oTCQy4MHsXh
 uHdn8f1gPrt7aVg09/SlVyhRK+szxwAR2WNlitMAf7cHWvQZtCNIw3p5dgzcAXGYLn2b0S2qkxB
 MqJ1DgD86JHpfk+DnfHY+8LO9kGJvsW0SVKzxqJi+0hJYMD6XkpNe0oguaUkgaykfhopeXrqoqH
 bGpOuQHiEXiY1qPKa5HRjya6a4giwa2HNYWDtvU84dlwn9v2/4lPTihXzax8mcsoiDblnkwCGW6
 LjJiQsoRBaDtHvYPcei6C9Q1TzuIhp2t7kkdeW/um1GySJ0dM7sNsVVJ9R+Jcm5viv6+jfuaDeC
 uOMLfnV20dLvzurce2f0/Po7wvvH8FTUQxqH6q027LYkcJltwsjTHa7QvrKHv4VBfs15QiMkmwK
 9YmIcjRA5Pr8g6MTkxYUuqDA+A80X25elmdoXlJtcCgVLrsZk2IB8wrcsK+CstzLsczjbm46MCm
 b4hxQVKgJcvnrXhkjZTN7nvYKsTvBxwpr6kMENSB59tX9HYQ59rrCQ9mmIX9gG3IuRb00szJS45
 HTpUhbQEN7rA51g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
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



