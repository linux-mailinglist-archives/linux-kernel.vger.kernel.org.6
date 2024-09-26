Return-Path: <linux-kernel+bounces-340639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C294D987626
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5470F1F273E7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD54156C6F;
	Thu, 26 Sep 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEXTgxq4"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0AE56A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727362782; cv=none; b=r08z6XjnO1dL3r+8kF1Y3iaddIiCfI1aO7H7uuYMulqz5gtvT/UmDDXrzgiuSpsUQ4KZB/OdyAIA1j7cq9ry8xMlNRwIjehq1IiH2rsauAJomMskJ94SHQ4rA4cAO0b17lRoAzoVLvTXsFkMlQSahmCgD0b892vbssGz5grzUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727362782; c=relaxed/simple;
	bh=Eg4ozalPfp9Dq+G3RNTBq09+vqD1HxtxrCxKQ7R9a6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rSAi+Z+BbQCSeDxe1uUjWmroMOOFnSkZXk62nQRnyCv3VE+Mxg+smQXiU1UprTm1trhocSygWi1iPfqOxPqoz3GJCZIsvGJIVTmvt5WgrKt9rjqLprMlqc8yrkR08PXmI8jDgu8kioCsJaiBYqxefeadOuYncA4B6+8SaRho4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEXTgxq4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d3e062dbeeso13622197b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727362780; x=1727967580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NeV1KHW77gl2ixtTigXOOKfMDho4UiCgTf2SV63cy/Q=;
        b=OEXTgxq4sKMvvAy67Dh8YjizLVbOJ5k1gUFzDMBwx5RpDYP1FqjJaWKv36U5shCBUv
         3JiETjDfPDsFX16kB6kUOUD4xdxOXHnyXyXMk/3friP6Ufr3QC1+idjlyqRaJit6UV2W
         jsaBfF0L+wfZcUuHRBe7M35hGgUAeqpnvTdW8A4tG7eSpfn+hvIn7AMTwPjS6gTVdzEO
         qi8pybyfCUeS7KWd1Iw2X+CEV6l/pJlvxIzsmc5+qKxBgibG3x14H6vmYTcb0+2+Bhxk
         MyNKd04/gVhxGvY7xggMbANzGtHwbVhqu1uTgDHUIz3Nzlw8QeqVA411lrkwAGJG15mu
         Q4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727362780; x=1727967580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeV1KHW77gl2ixtTigXOOKfMDho4UiCgTf2SV63cy/Q=;
        b=R5x4zzhVxD2c1eWhGG5NrRnC6oWTJ/C+KZ/iVjtN01Jq+DlfqOhFuXbXbQhsJi6kDy
         GAzlTC+4CQ1MftZDIm1ckI1WtaZXLznEf/0Bwe5G3y8mFOb3wgR6MWr2AdFRm/nIGneM
         4seUWgbrTO0a1RbuLI0tRCVZq0c3FMrlHNwzMqToKzcvwjzREX1O0o6OOGhwqhqeawT5
         2jLHKNnPUojaDGlr7BW4XlP+EPYt5Ffp5QZd080uNgyMfYGIe1FRvXEYs6tifwLFa7wB
         IUh4xOOO2yvUGplXwUF9KuGAQTjOa9zck5wacklHbmfJS2m1KujDSImOhfrzJQYNikYz
         L5cA==
X-Forwarded-Encrypted: i=1; AJvYcCX+3HVX3tLgf/pTog/c+HSE0eLAE06KAyK7jwl1g6efpwOggMqy/PGApQbttHOAhAAmEiR7IWceRXysMSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCOtO5B8ppdXDwn4+xdRbDbaMYR+0BsuAZ6guugjScvi8BJFw6
	YkOB5aMYfaNHI9MCEV4/oCbkI/Bps/A4/2b09tKufATJ+aeTul4sJfdw9d19XeEGZriVYYbJmDq
	ENGCUX4omBKy/gg==
X-Google-Smtp-Source: AGHT+IFXzXcQGkkg6miI4lRR5aDTs+z8nxuijS5MIlaFFi6hc9IleFgTZI1r0Pf/fM7aCAkUF4CI+a3V4yd3vaM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:3405:b0:6d9:d865:46c7 with SMTP
 id 00721157ae682-6e22eddb5d4mr290447b3.2.1727362780176; Thu, 26 Sep 2024
 07:59:40 -0700 (PDT)
Date: Thu, 26 Sep 2024 14:58:56 +0000
In-Reply-To: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Eg4ozalPfp9Dq+G3RNTBq09+vqD1HxtxrCxKQ7R9a6k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm9XbTowpCdvo26oRjUrDd2SCJfZSsqtQXyf1e6
 aNmADjn0mqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvV20wAKCRAEWL7uWMY5
 RrmiEACSG2C7yeB3qHx86arzRAzmg9UQ6670GsCB4hPpsLd5PJPnl8TwUULgOTX7eXcKEhOPuUp
 uThZFejvJD+T3SSZMsh9OwbIZEkBbGm/HOO6MCaEjmK+v4+d1Mn8NRT2rfwifU2juxsubMRN5H8
 RBhCu+w9oPkFw9RRw5PKE9KQdO8h+zuOSf90pXOYDVHQ6jiwM3tdtrS7gjhD44eq0wwCVTzaVBL
 cS7c9owyotQ7SqY87HJQA5cp85DO+0ann56qTE+2PXZVc/SaQDuMdzwmKypdbBBHfbACD4ICP9L
 uuCq75U8+DlZr9Dx1xCatEybfz8Q2TWQBrflphbJtMs0NhHL1cWoYwDBXNgiWd8WBORQIeLZHdb
 wnVGRgbOAu2+OIt2FXjjmyMEse63ZGVyoYFOqm8oHQL1Dg0/sNw9cK1XCOn1iaJpyCcud9F67dV
 uMRCacwi/HN/Rs4CqTfSLamBTppC1MWSvkaXnDpY5jI5yNNiWpXrg1etF+AcPDg9Syh/czy+Aoq
 x0cP0IlNTyTn0dLbJybbXPUtVgMUOlNd0jj/B/sFlEPymXHCT0YdkBzPeDhFdTRXfrf8S0uZLO7
 9A2JGCx3J0lAysqYfW36wJhlrZwLpi6jSzGXuiyPWmpofby1KBRRuR4DngYqVXhfsYrJdewTB4E ArpTcxpmLl4b9JA==
X-Mailer: b4 0.13.0
Message-ID: <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
Subject: [PATCH 2/3] rust: file: add f_pos and set_f_pos
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add accessors for the file position. Most of the time, you should not
use these methods directly, and you should instead use a guard for the
file position to prove that you hold the fpos lock. However, under
limited circumstances, files are allowed to choose a different locking
strategy for their file position. These accessors can be used to handle
that case.

For now, these accessors are the only way to access the file position
within the llseek and read_iter callbacks.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/fs/file.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e03dbe14d62a..c896a3b1d182 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -333,6 +333,26 @@ pub fn flags(&self) -> u32 {
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
     }
+
+    /// Read the file position.
+    ///
+    /// # Safety
+    ///
+    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
+    #[inline]
+    pub unsafe fn f_pos(&self) -> i64 {
+        unsafe { (*self.as_ptr()).f_pos }
+    }
+
+    /// Set the file position.
+    ///
+    /// # Safety
+    ///
+    /// You must hold the fpos lock or otherwise ensure that no data race will happen.
+    #[inline]
+    pub unsafe fn set_f_pos(&self, value: i64) {
+        unsafe { (*self.as_ptr()).f_pos = value };
+    }
 }
 
 impl File {

-- 
2.46.0.792.g87dc391469-goog


