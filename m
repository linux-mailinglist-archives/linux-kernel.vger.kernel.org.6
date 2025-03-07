Return-Path: <linux-kernel+bounces-551998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E2A573DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D811E17849F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B4F25BAC1;
	Fri,  7 Mar 2025 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eesdVX97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39E2259499;
	Fri,  7 Mar 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383679; cv=none; b=m/iM8jEIHBRX+CUmmuubsBBSCq/sNrXJXJdElzIx+Oe4Un0+VbPp+yI0tYyw7pHJZ0F8frLfKosDZ8PE26TztKdUiXquAbhDd4Q6iFNnlLLLGtbU/JwZv0CBdZi/DyNU0xpP7Kk9atXUfVOsO2OuB8fdEKBQnP1pr+7Vaw1EOdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383679; c=relaxed/simple;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pkp6tN7gzaF5lQ+WPXJzj4Wa7/QN/bHQWmQBocLhCwCRj0IbMJ+RSlholr/UCmJTGu50wIPjA86/+Xg2lOF971Qi9jaA5mFwlsliqx4WQS2D66YqCshnBxsBHBcc+Masznc6V62aQBRfsKQcyqf9qeYjmT4zkYQeCFSZnBxvQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eesdVX97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A057C4CED1;
	Fri,  7 Mar 2025 21:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383679;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eesdVX970O1ZLcX1890CYzVzhQZskAHIXQQ+L8O48lgJfnQldu4G4s6G5nN0nW1a0
	 fbdEskiN9yQPIkTnG4Lzj2RQNTkxlv9BEACJZt8nl6AxikqXzMMY/srfUwGRldSWaf
	 Dxc2gZKZeKWahhAbsHF1oeHipASoqkfpy9lDvM0TOnDhaGTfBunEMLJvmoUTY+wmMl
	 yVXRV8t+LY37xhbFuCsGHc31UMmkiCuZAsqJzr6ru9ALfwqBhgI/gFWgZ4904IWZfX
	 vFHH0qbTnp0QWv+sDEoNrl6I/Q2PUJuSApXAi8WUcdpiGUetGDX4WQOI1uWRR8CdGw
	 r0ZmV5ObKIcVQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:50 +0100
Subject: [PATCH v11 09/13] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-9-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dxu/uhgLXT7ISorpd9dg7cQ6aCdcpzjSVD0
 hE6u7bqfmWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tncQAKCRDhuBo+eShj
 d3RkEACw0J7jf/OJbzg4z1iUe2dA9nuDP+2rFlcDoqbvi2uYACTPlOXgx72MhTE8C9KKGxvswUy
 D45WP+UEnVvxLwsWrHZxZWPl2KQExmrhsE/08x2/7W7HGDMI9Qc+mY7MtfOlI1gZZRf+85/hWOf
 EQ2EiY8a2AGvRs3mSCrmOyJFnZQMdEfUfQRufmCFuHGTvJt47tuz3EwkmAzd+UWJMouAB8TuT8O
 UaH6XWVWrwQbFQfhaDMhX/iOk0M6FbpodOZItKoD7nwv+Kde4GLYjdTCMlpJRdZo4uIg/K2iU5g
 6qAvUc0nxfP1ahIqPCe294HhMGAA/byZdfb8+bFzGDK2qMFKW8s1qIhZbxigEmt/reK7zu57zkz
 Na2bbpAVjOarCMWo/jH0ymhCxyeNos1M3rsGN4CDOpcSMchxdVS3Xt0cNkFaj/MohNKdYmEw1Tn
 VY/nxdzaTdxM3dKggAYC6BEE8MwDBsNSXAOn2ilbEQa7x3AFWPeKEw+h0oqe6DKmmILGaFx6jm5
 mHuKKogvyAWeA5iD3NUNVxfBt4JU6zLQasBzgY/01WidoRmUMRgjUrJ6joLZIlgDI2vsjDvDiBD
 T+3uNKhawh7+cKl06gBahMZ8iTLBuLqkE1ojcKUFvUlfAoNXyCKkmh7MMAK/d+ZLwwY7/VPXtLm
 SCElTRVrLjaeu1g==
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



