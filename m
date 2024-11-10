Return-Path: <linux-kernel+bounces-403221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6E49C32BC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5340B1F21F38
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168ED4B5AE;
	Sun, 10 Nov 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT5ChYVu"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5602347C7;
	Sun, 10 Nov 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248053; cv=none; b=Mu1AO22ojixy7IUAEf9nq6sWM4+Dl+aaxssbDejw/KlE+O4B6EhEl2ESjuPKEIF4at2BdfwSwYJ2FsAbaFRXEfv4ca0RdXmxoSNeF9vNVlZwVrn/hym4G0UgB0TLsGYPvnA1GsYBuD7AwJyeHRetF51SYRnanRxpLX635F7u66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248053; c=relaxed/simple;
	bh=mVPg65e9gT1vxURcqZdglQZ53y2yUMaRs82BrD29FIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgYaKIS27vPRutbYRLs9n/zmurE2J0WM3f5OEy2T0Oe3Ubne12UtMy8C4pCUmpK+s9H1ttWlO4f1xSaJdoXrn43RR0GztZVdZ74hA1gem4UJJk3Sc20qCjCMKy1507yT6NAgUYytoNgq1vaLfpR8mZSgD8O0aVTkoqRRsKLnOH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT5ChYVu; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d382677c92so26213286d6.3;
        Sun, 10 Nov 2024 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248051; x=1731852851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PS/NMaAouw4ZZ0z6stITEGzGbTE7qQ4nR99gHkd2jPk=;
        b=KT5ChYVuBk3w3icaPg9XsT1GG+NRYgfGT5RqHK/8onLdHjUR2FVICBiKW4zbjIVypr
         ZugUYKLUAceiuii8JhRYgEPj4KqxWv93iBaJmjhSwkKd0xtxbHRgssduSxVRbZTbp2CQ
         sowzZzsf/lpm2b8a0A8tUFi4OQpM+5vckwo7EdgZKEU9MunkS2rAJNdV2mbNrGtybzzm
         mbs5pJJDnnV9EhuulLj4UwYMaxX58Kn3Mc1RLH62FqhNcjy5J9jeEH6Stb/oh0DdszGi
         1a9mBFjjqR5kAloCS+F4vEefprxLIXijtzCjOStTiu/AvSUtJlw4QBh9M5XdWa6h/uJY
         YslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248051; x=1731852851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS/NMaAouw4ZZ0z6stITEGzGbTE7qQ4nR99gHkd2jPk=;
        b=g+E/L8iKiKkAmI9jz269dBfH2OksP7U7/0H6sIEBpsqG12qlXCmFzCGuVOWP2k/tv/
         6B6SX3Zc62jLkK6pRbMQ8dEc74xII3GLl4oay42OTFyzmx0ze2XBIKbokSymXkziBWiA
         s0d+Lysd6lnHA3P2ahcw+T9j2xOjdjiF2Y9OYfnqkBRymIX6x/oSBb7g6OBOB9t5HM+W
         nkHE0JZqFqPtsvIsf0cv2yZ1WHEEeZdPkrM6HIe5pAfuQSsFU2Ytv/b/X33cFJN+qjz1
         78B6/nyseM1B7G/So45yh38ahgD2U3MRTPYTnCcXAGBUXd81xWYbFDeY185FKlWdf58q
         SJVg==
X-Forwarded-Encrypted: i=1; AJvYcCV3rOYAdHeflzy3JSkQ91hnhGyxoHFZ2XyaJyatngqKucvLC2T0KGaLO5PweAcHTywZoUnvg5k+7erI/VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPs8lpjOodAEXghkoilrRTLO1qL6YNdVRtwuq5NUks50W2j5m
	B7BnZa9N13sSiekvAm5aQeXJCUmT+FWWKK365TyQew+k2GVrvmi1
X-Google-Smtp-Source: AGHT+IHeHvqHRlF5eKZJFXYDdi2VCt7t3uVjrA2sFEopCKiRWxTVgI3GgZKiaAmbVsnnsMDufM7yZw==
X-Received: by 2002:a05:6214:3d9c:b0:6cb:ec68:aa70 with SMTP id 6a1803df08f44-6d39e114bd5mr140738186d6.18.1731248050931;
        Sun, 10 Nov 2024 06:14:10 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:3d4c:5fc2:8f61:bb43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfa0csm44570046d6.14.2024.11.10.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:14:09 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 Nov 2024 09:14:02 -0500
Subject: [PATCH v4 1/6] rust: arc: use `NonNull::new_unchecked`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-borrow-mut-v4-1-053976068215@gmail.com>
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
In-Reply-To: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
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


