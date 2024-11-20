Return-Path: <linux-kernel+bounces-415681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0981C9D39D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38512815B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB21AA1C3;
	Wed, 20 Nov 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5x3M8S/"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B21A7265;
	Wed, 20 Nov 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103183; cv=none; b=rpUoRr2sZUDibqEIZ1pXVW8gfT/nxbp7Zv3/W//AxkM97UVAippXTOo3jm432x0owIXAQrIcb5YFceBGHocyR34WPbSrewE1U46f0YXtBLr6AnHA9ErByGkHAptyGcZpKiDDBdt6uGlFHhT7FuL96nICbSsBLhCeujx1e3nBp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103183; c=relaxed/simple;
	bh=akhMarqEAGs2r0ixu78494NfI3AtdtjayQYRt4CjG88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkqqQRqYvsONTsB2HFQSpXDUwbCS24i77LI8vZ629nlqaZwKE/BYk84jIj8Q4ofzXMD73ZDWmaPezolfjn1vYgfMbWQ3LanqZsesoWrAhoh3xeFds0jBBnJaBU7Kt5uXwPmoej2lskEAUDCOKoVv5CejaeZIJHsByA18YjmQ8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5x3M8S/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d41d46162eso19192056d6.0;
        Wed, 20 Nov 2024 03:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103180; x=1732707980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PwKabn9mlzVsv9jDUI6+PuwLrpvjcn+d7aup2iIUyE=;
        b=g5x3M8S/2zxdzNqsKhUxKNq5OhIlA6le6bZ6Fip9CcTKxQqDxwd3H7Teu57GAc9oG+
         NmnODjEhYce7hQsRlQayaae62P+DSI2OCqRBVob8WD2K+Ra4BgZM/LRv8H2Jbic0eke0
         vL+uYS4G30Sxf77lPSpatIkVB+LHGIrWLZqB9Cf0JkIMTk5x8znb59pTLQXTexX0xdry
         a93O6cTzComf4o/k9AN/6Cr/qKLNLhZKXHwAsbZiNXbFsGJwze94J1+7XsNl3JyyiO5G
         Vyol6Ejs/I2jj7ec2p7ZdA8lGTPp0sTtEAEZLEL2/f54mRkJRGXGoFN48xE6CWCjc9mC
         4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103180; x=1732707980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PwKabn9mlzVsv9jDUI6+PuwLrpvjcn+d7aup2iIUyE=;
        b=K55XZceqiwKOsgatOfUgT102zjrupCHR7mnWVk0SRvKogGfo+kOSph7mwn1V/OVLEx
         kUizQNAxBA0t9AisaUeBSCXiy+ZbWaETsMOZPhO1AVsIuAFjNOqOYVt6EBtlsDx5PG7r
         FNJUo9JL1niJuvyGxvyw1Ah9cIoDn2QJ9E6kH3Fj6709skKRS03GOlMhidLyRqHl8cMG
         uZsHOnmoQQ+hpXG7xmLRTYco37ARMmAUEPwfTFK2kWsKSUwtJM77Z8uvR72lZtEYcSD8
         zWXpcR2vX1heMh3BpkmnsiGDSnxxM1Evnw/v1LJNkNca1qf2e6/mLgGT/WkYhMT8J7XC
         1Mag==
X-Forwarded-Encrypted: i=1; AJvYcCVCAeZwUfoqwhdweF3Oj9PEj3SmEZEGZtSEnb1bYQqtvZGcdwweBwAEN8Dg3HtTK2n4vQDfP4hzKTDQVKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKi/edSBGgFuF6FN1VGdp0Bgbh7YPE9nMWB7zBN3uIPW2AylA
	WQ6TDJp8/VAmla0bRP3eBsdssLy+HtBOHkvgrlXzALTZcpQsd5uu
X-Google-Smtp-Source: AGHT+IEjkLvjpxcldh0B1LlHeA+ZV6tzfkCqXOkEyNLzsS6AVw2cEL9Qe2YHPAjXVazcSJW7ctOMKg==
X-Received: by 2002:a05:6214:2127:b0:6d4:586:6291 with SMTP id 6a1803df08f44-6d437825009mr40752366d6.25.1732103180512;
        Wed, 20 Nov 2024 03:46:20 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:19 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:02 -0500
Subject: [PATCH v6 3/6] rust: arc: split unsafe block, add missing comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-3-80dbadd00951@gmail.com>
References: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
In-Reply-To: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The new SAFETY comment style is taken from existing comments in `deref`
and `drop.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 50645660a9c33cb121ee1b2469003b325000d840..a11f267ce5d40b987f1f3c459271e5317ea0bae8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -377,10 +377,14 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { bindings::refcount_inc(refcount) };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }

-- 
2.47.0


