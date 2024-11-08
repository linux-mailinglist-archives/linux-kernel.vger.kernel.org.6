Return-Path: <linux-kernel+bounces-401907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F89C20EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB67284DF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DC21C16A;
	Fri,  8 Nov 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYGuYYq5"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E9E21B422;
	Fri,  8 Nov 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080802; cv=none; b=NCEMk/dRufvEINar0Sg8UsMis5LXM0cbdFXQXmRuHc6PmvvW6TNXqlqRmUsowgZsUo7dPqjPoM5rIqB8F0bmesW0RXOfGccGuE30+NUigtEXh1a4Fxyh4dIJExat4BcWpCZ42MOQTuX+nQRPJm/z9HaGPkht2WHU1wyJ7sy2gfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080802; c=relaxed/simple;
	bh=mVPg65e9gT1vxURcqZdglQZ53y2yUMaRs82BrD29FIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r767EmL0BoFZ/7aw1s+l+qLO9u4SEi8PoeNKEKec5rqH6Tg+ESqyVgaTDfENJKt86P7UySR+mxSG1VXV93epTeCBSevPfPY8cNR+3MGfQjeuBe/YSg12c7wvawFH+RvLdI8+Rg2ibthVMQXHMkaDK5SLbCEtNj2/3iSVjEXJZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYGuYYq5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d382677c92so12952266d6.3;
        Fri, 08 Nov 2024 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080800; x=1731685600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS/NMaAouw4ZZ0z6stITEGzGbTE7qQ4nR99gHkd2jPk=;
        b=WYGuYYq5m1QZFfZRV0Xgpwbq7OGFoZwzC8RTHE+cxiUfF1CrLS92cvy0Srzcl8E6+g
         XEIqTHxrlLEBAKmcJIL4mTvDU+1rAC2rwh4kppXk/DZ+vjwPyffKPcy9I+uBcGTKMFYu
         oCZjik7iuNyUGUJpV6frLNI5Fe3xVIrZX9jHCWgQ5xWPUG9Bes22R8chHJOnzkK3tqM8
         w/obP3TYsNyM4ELLm9c9nUbETaBJ5hSza05VBdEg6RW9y5EM57StWnY9cOpaVmTRs1RH
         YNm4FLqZcoJtJeCbBCqwYNZWHPlFNr0ClacT5WbHK2sqG4c5XaQg90zB9d0nFx66gTMR
         rEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080800; x=1731685600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS/NMaAouw4ZZ0z6stITEGzGbTE7qQ4nR99gHkd2jPk=;
        b=bPQzSTKidMSD7r7hiGS1uwRyzyDKSQwynZP+fmXt6/AIRG86mrbp0J+NHhH/XUXnil
         CDGXRj6ebSbUWvvhwbF9zFmflVqs9+u8PmHDEAdJXLsnImla6KNj/XXuHZe8hFqSeNFH
         qNNbQh+hivveVmCAa0OohxegqP7bkLNyhbaqGOVI2Qrly168atRqEx+9b+21ajNlOGxG
         j6uavXAjUwIIVPwzrCmQPMu/sc/H7mMnXTgRUpGiMl+bRg73uDCMT1GlfwsC4gGmjFBi
         X8D3dZkAiVZr4BsaYFg5ufa4gtR6mvFyuoDC6dFozVGz1X02+Zk3+LcrYrrsR0jDrwxB
         dcuA==
X-Forwarded-Encrypted: i=1; AJvYcCWXfCOJiqtlhdX4jL0K8L+31Z2HxxNe8WaTutob7BfJj7vNM60pBNHYHlHRadXlRRf7N8Q8edFhG4YjtYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvhbK9qaCI3d6ZU0dzuFu7b8JZdBP+eeBsNgK+NlZPWx9VFSF
	dlTz6LhMx7hBFIAU49Jipb2zjXUodXun+n4EhFkHAcZlQcgkfdRU
X-Google-Smtp-Source: AGHT+IGXt5flUp3p3gsulpcv3X35u1D4bibYthP2EOhjeW7urXZjXkCjc78QIIUxUQE8rKOUwaHdIw==
X-Received: by 2002:a05:6214:5885:b0:6ce:3ab7:adf3 with SMTP id 6a1803df08f44-6d39e1a98d7mr35964386d6.41.1731080799720;
        Fri, 08 Nov 2024 07:46:39 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:39 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:16 -0500
Subject: [PATCH v3 1/6] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-1-b7144945714e@gmail.com>
References: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
In-Reply-To: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

There is no need to check (and panic on violations of) the safety
requirements on `ForeignOwnable` functions. Avoiding the check is
consistent with the implementation of `ForeignOwnable` for `Box`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index db9da352d588f65348aa7a5204abbb165b70197f..2c9b7d4a2554278ce8608f4f4c7f9cfe87b21492 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,9 +337,9 @@ fn into_foreign(self) -> *const core::ffi::c_void {
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        // By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -347,10 +347,14 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
+        // call to `Self::into_foreign`.
+        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
         // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
+        unsafe { Self::from_inner(inner) }
     }
 }
 

-- 
2.47.0


