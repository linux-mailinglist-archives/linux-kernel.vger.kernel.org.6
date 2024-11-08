Return-Path: <linux-kernel+bounces-401909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BA9C20EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273B81F2474C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE84921F4B9;
	Fri,  8 Nov 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqTndn5p"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301F21C17F;
	Fri,  8 Nov 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080805; cv=none; b=dx5WRlXtWwM8wvPAfmsnaw6KKR8c3c6Dbz9eVmaWyqX2TP/44kVsr1wYKGBhRcGtrkd+jvOie/jWHx0SxwUZGnE7vd8910FOMKrOKwFhxtDgHcQce0RsCEssEvUTN0n8jVCFLJPPNEZcBxzoaFyLSLH2uY3COUvYzvgVDahp+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080805; c=relaxed/simple;
	bh=0PUCDqRECIsSc7WP7EJgJ2Z68b97T/vjCk3CjolRV2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqSYzo95rzA89Szw1yAP2EUP4okIf8obtCp/vCNlpPM83l9BIO8aj+lsmDJHvx2XHbXjX/NwwcYLVWwGHEVolTMDbm/kwgUDZI/zaBA9fDfk034ZsA40RgGPMuUpxRc5+aceDBwufNwsicP4aNrl6q36sKVwEXu5rw8+I3MXKw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqTndn5p; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe68f787dso13706476d6.2;
        Fri, 08 Nov 2024 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080803; x=1731685603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVzlBkM+Wc876Gp5SkfK423mmdncVXf8VEuEJTdHg/g=;
        b=ZqTndn5p67sM7b3Tf03wzI8H/YNhR4aBFecgPLdO2/B9pNgfTHqLKld5wBqJ3NXmFa
         unaveAyz1jF8qYDJ69jCwWo9b2yFb4oBv5QesUvILMriy3BFnBJ7mzTnyidNDKSGCSv2
         1r7cRwmbGnDmsYiAvjlCDWZb64VF6SaSX4U52VPRzIjPrquec7eIFEvG7sm0ci2bPIsd
         fFX+NG7vlzYUSaNISYQaFv9lwbQbW1UJ1F+8UFJ7YwJmBn4AlctGV7VTpoZAKzjOyFxw
         HQoi8vICij3mwp3pwZJ3pMrV7Q020KpsxRn6iB3xWvNWGBnPRmANyxNuE/WxvHk3NHNO
         jozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080803; x=1731685603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVzlBkM+Wc876Gp5SkfK423mmdncVXf8VEuEJTdHg/g=;
        b=lnpqH7KHwNlI2RpGwpn5I6vUKz6F/gwwzYfzMgw5lVQqlZvV4DnYKDkbsfg/NsmVKJ
         T6IITrrDu1MKGcQ6MnLndP+2Bjf1B+NRjnVjW8yM/6vxl1IW4AMvZnVpueZ3NSfjxC6y
         cysQtbMIePUoUZgozzSIffSk6PkptKscFjyC7rpvqx/Dru51b0zVXvk0KUAx92SsMHeU
         5t9xp4e27JfkA5XKftC1txDSMrnMwmVCvyBw7MavRycad349lsY1gW299r+18dKYqqlp
         PLTfZ0ALF1qBozN39lzZR8z9acmeOZrQBYEgaAj8cX6csSFoeV2BJ+AnuvM8iCPDBsG9
         41SA==
X-Forwarded-Encrypted: i=1; AJvYcCVISm5HOKVrLEVSuoOuXkLwSs0gBcgkFGqsRRqjoT0R93AQsDHOHRJFd6Sb1joEtEHZC0486HEW03/RqBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypR5OpoQYnv/BWGpaj+A7XxWQoHfO1O9oLMmXpILEYgaj+oERE
	b55yz/7Kys/G7GtH80uZ1TAkQdZhnSxhEUHGHCxTxOaeqKNIFzd1
X-Google-Smtp-Source: AGHT+IESGeF16hp3lQvUiFUuFCNgF97breOCox9NCsZVBK1UPuiznIgptG8W43mATPiC8+RfDy4Rzg==
X-Received: by 2002:a05:6214:449c:b0:6cb:ee7b:7abd with SMTP id 6a1803df08f44-6d39e165b28mr41411356d6.27.1731080802684;
        Fri, 08 Nov 2024 07:46:42 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:42 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:18 -0500
Subject: [PATCH v3 3/6] rust: arc: split unsafe block, add missing comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-3-b7144945714e@gmail.com>
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

The new SAFETY comment style is taken from existing comments in `deref`
and `drop.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index af383bcd003e1122ebe1b62a49fe40279458e379..9adea755a5ad1a7b03f7fc30a7abc76c1f966c6c 100644
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


