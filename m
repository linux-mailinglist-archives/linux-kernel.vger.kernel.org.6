Return-Path: <linux-kernel+bounces-403223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4E9C32BE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893CB1F225FE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EC384A5E;
	Sun, 10 Nov 2024 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9Mb2TTu"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAD77111;
	Sun, 10 Nov 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248059; cv=none; b=hfhFh2ORC97vM8kHZnC137kXcpHQD5OeATHLsRqhYb3lYhp7rXgI21Sblx0tdQGgYYjiPReUSZKh6SmhAH121nRAT+7bYytjH8QB6g6wmjhUxzN59LYNlhFJpN+NehtDnwo6PNzDuSeK7ulaK8a7RP40gRocpVACV+UIdicnz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248059; c=relaxed/simple;
	bh=hzWQGxu/rAZiOTQu/+JUEORWlJV/Ou14e6oi0kPUT14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Set1r4QE/6aLQ/6y1Y4RRSrBUXOUvWHDTwHMyu1wp3Y5y5rfUKCsoZvkM5mkMXJZ7gziEjTnrE/4plYGX4jDkPldXYw5jLvJMgD0JbZ7A5AI2NcoXlimdMCz/pASrnE3MTHNs1+u0e5j7ga4teWBgh7+vA8KINcd13sdu5M8BBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9Mb2TTu; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so25439246d6.1;
        Sun, 10 Nov 2024 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248056; x=1731852856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vakRcIHXfxkcLdpFkEpbbfACXypHGD3cMUux1BxabFY=;
        b=i9Mb2TTunyOZ4UcYaoMJPJHaKPyVm87/yLTOCBJVwlkawEsdx6DDZdRKAQAhO9ZFAa
         xssryW48PlNPT0bBK3CqR4I9G1o6vsO1xPY4KKEq2LFo8X2GDq2ge/LDUXwekRN7VovY
         fbPKfff2ezPDGFhWHYa7iX65WX/vlcjeIxnPaLlHZ2GX5A5rteNn63PgNXsuTAB8obYO
         tD78TDJHHGN211ZhzWK3XMCfM0fZvd6lPscCIqzKaMTfEwXbTt8fMdEMmytxVcbbKhJp
         NfjdrOjhyBcExmG8EW4szTlo8TitAM6h9nAPHp8oXr7ibHFlhS6j8XgYuF9Xj1qA4AES
         No/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248056; x=1731852856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vakRcIHXfxkcLdpFkEpbbfACXypHGD3cMUux1BxabFY=;
        b=ksfNVvzjx3dzz2uYbWlwsqlscGDD3GLZPIkDDfCsuXzT2X3RA9U5rAQqHMk0vwLDtz
         BW/MvjqJTQVhdgK7brLVMkvakhk1nUexOb7blO5CLt0rG7eMuJ+3oWYbP1gtI8cpjo+g
         V+zU3G3o4WcKkRgSW+aTxuJ0aTx+8M9kJwOfKsH1f5e4m4dicqNelqXgLlZ1qPRjGI0T
         M/rgeAA7tsPUu4+nhZf6Q0Iskq3YQzHrYoWUqR/ACslwKBdPS1NoTAwgxZBeG4xb8v5t
         khe5Ghtiza90lg9a0Y/0dv4d37U3tFzkHycaetM0KGXiH3ZeMXnK/Mhqpr1GBb9alp/b
         Tj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUTMNUasRNoFXAd3w1I0dzBU6UEKFeS+xX0hNtzrlqlRgum7ZXbh0TuXWItqebsYI6lk5ZgtP9+merNqZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy21KcOpt1+uVe8IPHiJKaT+JaLjwNROXZtR4mAhjp9bYs+mSh
	Ytcco2IMINKqw1U0oZpHBlDlYFF+/sBLEJZiUsl+HOj+P5OWw/17
X-Google-Smtp-Source: AGHT+IGm/xEUnBlpPMII9+xdE9kvblHpfvhJz1oW96P27QZqoiKVWixeUlTdFcdNRZYNR3Tnhb2Zog==
X-Received: by 2002:a05:6214:4411:b0:6cb:ee0b:47ba with SMTP id 6a1803df08f44-6d39e101bb6mr126340816d6.10.1731248056362;
        Sun, 10 Nov 2024 06:14:16 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:3d4c:5fc2:8f61:bb43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfa0csm44570046d6.14.2024.11.10.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:14:15 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 Nov 2024 09:14:04 -0500
Subject: [PATCH v4 3/6] rust: arc: split unsafe block, add missing comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-borrow-mut-v4-3-053976068215@gmail.com>
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

The new SAFETY comment style is taken from existing comments in `deref`
and `drop.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index bbb6ca8ff7d0e079c7f0efa7702a91622759cbd7..6f5fe24f0e1bad5ca141091e8945b8d2f94e16aa 100644
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


