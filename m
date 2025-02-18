Return-Path: <linux-kernel+bounces-519527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE495A39DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506B91894339
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3926A0E8;
	Tue, 18 Feb 2025 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoXYkXxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861A270EB2;
	Tue, 18 Feb 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885358; cv=none; b=hEJceVpDQRGwJMNfcIFcFCqlaJeMI1sJfSMdr8y1ngoazPueQwXIoZAUxSY6/cte5NdfE1FiJjTwFTZhSOB+LKTp+Z1wiUvzUWXKIybIyIj4F+CRHorpzJ2Mk5mJq7DMVzZd9Z0GEKKoENqYCGm8/xylg4rVUteQKbZUebGXzTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885358; c=relaxed/simple;
	bh=nwZNyOuiuprl7SMNik85pXwE5CG7wJ0i0TbeV7CGEdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUJd5sNAnWUiBw/X5LcsznBzl8q03p9+N467pRKPYpNNd5cUb1sI4rTBFJnnE5xeB9RV8XOk2RzsdfsW/wm/btbF2+nJ6JkKUO3ZeTD9SUh1CiufrviBnI1MmPRnBJqeWzb+LwGKz9HyrLgD8aJBCWCeP6oVdwgxFomvYRSCQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoXYkXxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8431C4CEE8;
	Tue, 18 Feb 2025 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885357;
	bh=nwZNyOuiuprl7SMNik85pXwE5CG7wJ0i0TbeV7CGEdQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JoXYkXxPyMu3iy5hwEg66jQ6u0cvQTiSiJLVOaO+PIA14hlaiVxbc6p/EX9hiJoQo
	 ZjG6fOEGbRfKdaBR4hf0l6+gQWmAomsMdwvUc5TB9t1W8KmYmJqjjC6gvIC8Q0mIyv
	 CmJNTvZ7qyRsRoeIhg3gNNWoLFyBu2AJh3XAWeTi2rK+MFaIavzeet/uTdiE8X9Cap
	 T1yx5pW7cZq/XffY+a/8ItjRkmDlU8mxYeDnSZvQYebe+wClJz1+Of5Nb8BLULHyTO
	 /oOBiTQ9xIZbZdd3nD5qsXsG5SOZ2Iro8YMfnbZ2huOpq76hMQtUCH18eoqJr+I079
	 W+CCrTjrlks/Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:15 +0100
Subject: [PATCH v8 10/14] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-10-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=nwZNyOuiuprl7SMNik85pXwE5CG7wJ0i0TbeV7CGEdQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq4n7RTCoXhS7u6DlebG7p92eiZABT4YHP5x
 7oX1G8mO2OJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKuAAKCRDhuBo+eShj
 d4DVEACCRkXBowHgAhVf9vblwxpFJ08MKHX/n5XuydtczVTxeVxJy0PzSJc6vzvHwmlLa16KeIi
 IST+3WPFNSsMi9IlgjelLF7w7qBS94ohS9uiQgX9B5HZmUUEvYaQzqfkiNcLhu3A/bw9RlSY4il
 TD+OErdZnCd3t8oZ4PcfpIhVozWT7HCYHvkk5hOVaS7fKCfA1AVxcXWOcYq+Y7+U1k59qGybvyj
 Zy2Xta4gNKKzXoezfFipFcoUDbI1J/1WXOgV/uVPzO3EqRxzeHuVAgdiA2fbhHUbbMncPft/XYD
 yYWZfElKrlfZ4n52aLGp3AqaD/QB8g2+15f1Bac8LSvL5mrFXJJCpIvndzhrhuTutHxfjvTAokd
 3108VGr4YHqYXD7Q4P2yZko0z7AC6zPDgg27u+9HxGiIQsk07ogbRnYHNUQJwBX3K9CfxXVl3P9
 jCW2DPFzlNGKynpyyvM8eGyatjyfPEldA4MvJnlZGbRhfTv0RO5/2gsC20Ls/+ZYxE0Uij3MSbB
 t2IA4RyIWw87+EORCGNtRX6WZujuWxuus022vM9qaOS79zB3S/9WGo/3S9AFMjWbCcFGmuEosfd
 j5RRCDdHXVmFbiMsLFZMiJRFo702xNyHGNXePui3Z30rqLRlGmqdte3kSEL+iQRYnMtNcz4mEzq
 s67gzzN+BwyDzKg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index cb4ebea3b0742..9da4a32e60bc3 100644
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



