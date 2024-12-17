Return-Path: <linux-kernel+bounces-449451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0A9F4F43
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147307A8913
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED1C1F890D;
	Tue, 17 Dec 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g73mysGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04951F756A;
	Tue, 17 Dec 2024 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448789; cv=none; b=EuddusZaHdl58mGuBThJXXAjoRV/KL8Y3elQ9goK7De9FFPqcfFvINFEKXiYvjRGxpfK/6q9CESHS2lRuf+16x4404+w0bBjqJ/SEfDBp9b932VZb/yCWjulGuJoVw2/5XqirHE9ER1ge86l902k68Bw9bQ40uXY3ykb/Rd0M78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448789; c=relaxed/simple;
	bh=tQDyXQBkG1q5qjeehMfyrhkTdqTA2BWMVmg+Cs7DewM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiVB460ern+XS1JbzDCBCXRIyHeo1eqCGNWEErdPURaHSVyJuR+IikfgAf6QXGEycu4E3bPO85ZNFOcfs2q0G8fh03CfE5irWYzXekQ18z3XoLU2uqXXR6dBX1LBaPxh3EcnYOeYauyrpTToE4qS/r7R2HbbIlMf8vuUrZklfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g73mysGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E98C4CED3;
	Tue, 17 Dec 2024 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448789;
	bh=tQDyXQBkG1q5qjeehMfyrhkTdqTA2BWMVmg+Cs7DewM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g73mysGzY4FlzIF/yXDocP6p6QPDOIltz9Z63FUBi2YT7QjK5dZus0UFra4KHbtcM
	 h3LLo3OGh7VwAI+dIlVabRGl3x0X9RgBRSQ2hh26IjeJ4CLbzflqqdS1HNEOdR0dgo
	 4icpWoga0DKPJTDH4L2DVXs0oABe+wcw9V/TqZ441uRGWhdgjQ+u/EZo35Rt7YDN3+
	 UtKbQPAbR3gG//MUXmbtpJrW4UBIRR7VeCm9a4QiFIL7jyiJddT9qETgPQibICg0DI
	 LpSQLZ5bBHfTkz7YzeJFl6df1dgOnZVnF7FFGDrIcO3zMqE636PhxkOpBe2FmYdWnO
	 bf3jhi2oyOwzA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:41 +0100
Subject: [PATCH v5 10/14] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-10-b34c20ac2cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=tQDyXQBkG1q5qjeehMfyrhkTdqTA2BWMVmg+Cs7DewM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYa8FW1fCsxZGSXIoOnApX+Ctiyu18dNwdOD
 tIhiDcX7YCJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWGgAKCRDhuBo+eShj
 d1YeD/9iWxBXfT7oNlagXsQrkPOKezGkUUCsvIrHvGRLU4pup1NktEhrtqZ6hxUxxC6X3VLh1P8
 1rCRAKEZDwdZ2acgwEefH+qhF2ARQ5Jc6JVkBQ2mBH/qSaxniFg/002Klz7FqatgQyIGl8G9MsR
 XNXb6vgPzjx6HUXLKjUwOo4Cb5neHOCjKkwOHbxdW6xAx5OUZTvItv72FyvYBcT/4E2JFZPUbLu
 pn7DxxvgSVNvY2taDG2tYy0GyNRHTNAO1jiC0ir3dQNlsW5dLI2YattkS6iXFR9WfEDiBKjme7E
 yUTsiqXw6xMZ4UhjjC/tq/Z1FtXWEjf83G2w91cV6FGXp7K5/mwAevpqckZTBvoascY/1bC4BXF
 +Gy4fTN7A6Jmyj1pV3EyIYAbGxusbhE4MuyJCxb9iiqllkNedCL4TMq14qSSwoqTBa3q37PH9My
 6uvhfFx4honW1niDKMJfGSGIbcN6udyONqsggiHwusQZfyJTtZlCvnHZCM1vzIty90Wai9CH8hy
 Sy+87htlJypAkrPsoUqRpcpa6os2k+symoNAMT2dA6fTKWhC9PQpp0VzsLYI4Mtgl03xDIN1CPe
 T/adAoNnoce7KDCKXbwIvDpRKQM/axCNGDulAI90GC76SirDxbabTP+cnT3InwBmDoKQDssbmsg
 jWciMDnZTXhChRg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 9ce414361c2c6dd8eea09b11041f6c307cbc7864..76f29e2ac085e19871f18653cfddf11d2594682c 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -245,6 +245,12 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
+    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
+    pub fn into_pin(boxed: Self) -> Pin<Self> {
+        boxed.into()
+    }
+
     /// Forgets the contents (does not run the destructor), but keeps the allocation.
     fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
         let ptr = Self::into_raw(this);

-- 
2.47.0



