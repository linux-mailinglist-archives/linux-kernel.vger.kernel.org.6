Return-Path: <linux-kernel+bounces-424785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216A9DB95B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3244E281F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C21B0F38;
	Thu, 28 Nov 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrpFqaOo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE71AA786
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803214; cv=none; b=LR4qqkMaUUFk3b/bqgo4WvC0lQmFRRLtDJmrgYa0VB/YdBt3izlmJfMnNhSH4GHvxgTynvp4vjJRZXPcQJiiRJ15x676bGjLUOkiXm+qaGy2mNuDRLkNAK2b/YPj3pyCW1U6I+3/8RdJuODRRpaHVhdBAcX26bNIYcRFQ51CGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803214; c=relaxed/simple;
	bh=SJh0Q+xP9tm3ci5BzCF7qILnNgyglrEBDytRma2l6/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK37YcXyToNRG97X5+YUUBjluT9jvgyS4YiavYqf0bT9OcNhOmjAlAYfexuMQm0cNYthhKxIwibNbzZ3+j0R3+kbGwW7XWbetJEiG1NJgsLF7mRR5DkO5VPu0TaBI9we0B/rfX0fct9MXIvTzT/TwYB9mVgqEIsR6RtomhhU3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrpFqaOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732803210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+ivnks9eHKc2cnO5lo7WNGX+jATBqoLL3Di+tggXlE=;
	b=GrpFqaOo/k8852V3ap++cE1vYjfUM4C+HS8KrrKV2TvPeScStov/K9n1joVGrDX/gdO8fe
	J0oeDU4vZPeQqvu7oQvj8zSf6xt42urb8JWKKnBSnzv/qNRQhBz0aSsNfPolBad8F8sapd
	InYC1t+9u1fFRqjWBSlcbjbXXDf+//o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Rr9OcyL4PLe5BNCDKPWoaA-1; Thu, 28 Nov 2024 09:13:29 -0500
X-MC-Unique: Rr9OcyL4PLe5BNCDKPWoaA-1
X-Mimecast-MFC-AGG-ID: Rr9OcyL4PLe5BNCDKPWoaA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38249bf9e82so431187f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732803208; x=1733408008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+ivnks9eHKc2cnO5lo7WNGX+jATBqoLL3Di+tggXlE=;
        b=ZPemR7Iz7yLifmATDlPQiZm0pyOokV4utOakoq9yY99LgCkAWah1nHxW0cvk5otFps
         ccyBtKX8gBOhKFdbGz2ren0/I3DsGysTgINGIggPELNjMrq7S4XxX8giEGhsaHSPKOQg
         eCf9BARNQmd4u09i1R8NO/sgf0vRyw5dd30v5I/WLO4hdXYVkgeoT4efeWldSQribECB
         W8Evfn0Wm++Icxs6W8tGFqoLj64CiFk6o6HIv+LkzuqoLwTbZ+fCgpuvwqqOD9Y2BVZ6
         vHOxYEowHDl5HJWJeEHj2ahjtj4N8KwVu/fFCdI0Eg7AR3CYMWp/kuIHduXsCL1qgWuB
         Li8g==
X-Forwarded-Encrypted: i=1; AJvYcCU4vgn68DbuTrrMfRxr+XaA2oFqxtpS5bBRIuyANe7RkVlnN8t19RpXKHs2jlsQkJJJv2Z0yVSsz6V3vMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0idp7TWYND+GZIwBeHO1Kcd16Oulc2k2zAgACN0dk/7lOOZF5
	om7LR37jaBPi72CimKyqIjzEPbALyAI6TQmUjQoaM2egzXlB8KrywtQx2pGhzX6H5UX1rC11I+e
	q65c8PrKQJYD9xG0b0tcc/dzx4CN5MoXiP2JYEUGXTEh8V5PSiJT4MkYmzHh6uQ==
X-Gm-Gg: ASbGncvnHmgI/arZWurhkwX5ocgs+WDFpAuAYLAKL04oU+Ko4dlze8DcTE5DnYlGSM3
	YTastkGUlzsxH8pXl9uZc8pp2Vn4IFXEW8aKwESr9YEMTB82ItfzyIFH//aWQatkmRRg2wPGDN/
	OJirZ3WPa0MydqGANDcSVUY4pJap62dNgdpqPDKzyvWGUVca5iuIw+OQrG6yqOevILQjgexZrpR
	jGyoUTQjZGI9JqL1FBLzdpvTEYSjV5CSxx+iq3NYngBB5RJHKKveg==
X-Received: by 2002:a5d:6d05:0:b0:382:4b80:abdd with SMTP id ffacd0b85a97d-385c6eb6ce2mr6248554f8f.21.1732803208165;
        Thu, 28 Nov 2024 06:13:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzs9kOwW4KCqCU83SaXXdsgyGIxgmc5Rib/xImsEnns56tdvoTIASvpFVBrLhP206OdnyeGg==
X-Received: by 2002:a5d:6d05:0:b0:382:4b80:abdd with SMTP id ffacd0b85a97d-385c6eb6ce2mr6248537f8f.21.1732803207812;
        Thu, 28 Nov 2024 06:13:27 -0800 (PST)
Received: from [192.168.10.3] ([151.49.236.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd92eabsm1714407f8f.111.2024.11.28.06.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:13:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: boqun.feng@gmail.com,
	ojeda@kernel.org,
	benno.lossin@proton.me,
	axboe@kernel.dk,
	tmgross@umich.edu,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org
Subject: [PATCH 1/2] rust: Zeroable: allow struct update syntax outside init macros
Date: Thu, 28 Nov 2024 15:13:22 +0100
Message-ID: <20241128141323.481033-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128141323.481033-1-pbonzini@redhat.com>
References: <20241128141323.481033-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zeroable trait is a marker trait, even though the various init macros
use a "fake" struct update syntax.  Sometimes, such a struct update
syntax can be useful even outside the init macros.  Add an associated
const that returns an all-zero instance of a Zeroable type.

The exact syntax used by the init macros cannot be reproduced without
forgoing the ability to use Zeroable::ZERO in const context.  However,
it might not be a good idea to add a fn zeroed() inside the
Zeroable trait, to avoid confusion with the init::zeroed() function
and because Zeroable::ZERO is unrelated to the Init and PinInit
traits.  In other words, let's treat this difference as a
feature rather than a bug.

The definition of the ZERO constant requires adding a Sized boundary, but
this is not a problem either because neither slices nor trait objects
are zeroable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/kernel/init.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletion(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index a17ac8762d8f..a00e7ff6a513 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1392,7 +1392,12 @@ pub unsafe trait PinnedDrop: __internal::HasPinData {
 /// ```rust,ignore
 /// let val: Self = unsafe { core::mem::zeroed() };
 /// ```
-pub unsafe trait Zeroable {}
+pub unsafe trait Zeroable: Sized {
+    /// Return a value of Self whose memory representation consists of all zeroes.
+    // SAFETY: the Zeroable trait itself is unsafe, and declaring it (whether
+    // manually or via derivation) implies that this is not undefined behavior.
+    const ZERO: Self = unsafe { core::mem::zeroed() };
+}
 
 /// Create a new zeroed T.
 ///
@@ -1444,7 +1444,7 @@ macro_rules! impl_zeroable {
     {<T>} Opaque<T>,
 
     // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
-    {<T: ?Sized + Zeroable>} UnsafeCell<T>,
+    {<T: Zeroable>} UnsafeCell<T>,
 
     // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
     Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,
-- 
2.47.0


