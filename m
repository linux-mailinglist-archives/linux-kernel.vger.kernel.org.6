Return-Path: <linux-kernel+bounces-569056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E34A69E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419BA8841D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEEC1E492D;
	Thu, 20 Mar 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="LA8+8Zl6"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7141E25F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436492; cv=none; b=Dg1qXMEch58BkQTwmI/fKLLUw3Zm6r5fPTkj30w5E+7MneCaQE5wkZ5JHvCVUqj+AttbkOt1MHC3oEigME+Z7KGHVHW6mKiSNTpq74Bj0cJ5eLvSiuZFHnLiltXrFAkOdagIBqd+2tuUEOj3l5Kj476ak04u9qxOP0njVBHTnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436492; c=relaxed/simple;
	bh=ah5CkFIufoEB+BMpraIZ5rL3Qiv6ikZJrMLUSXWac1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPutmfJ6ruYcYuQAvXWhsseYNLuMRsgy+KUFlGf+78/vcg5DZTXhWb4jqTuxv/j+kyCgI+isbJstWBTuCr9AthQhFCSzljCRIuJ+HcaHLS0rDCwOjfAyk3HoIq/+RvH69deJQFIdAfHTWqlsQHiPa+kSU0F02WgPJMq43ia2FuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=LA8+8Zl6; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f47ed1f40dso2074737b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436490; x=1743041290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m30hK/WpmHc3oOKJEstrimV4bd9HKKE6GgYF61+TWU=;
        b=LA8+8Zl6K6GCKEi6w61XnP4NBDsT0mTergnkJoKiTwKqZ5xQKuFB2MEBMOc3Cv1wEa
         zTbQ4EgmFz1nWSYxiAcNHodGk0oyEUSHaTTLr9bk3ZCqJaTNo8LQ+oiN20gaBQwk9Wx8
         g4kEoPL6Gck05L7AHfwoyewPsa8cejUxR0Jb/BaoMriwsA3I/olt0LQVcQEb+EVjGi6E
         PrBJauekebJNa4TiiEXcQP6gsPEXsBT5aHFG7TQdL1BkaBERwEaOlhQLWqTWl2C2EmUG
         ymCc+a0BWvyAU9XDdbaKRHgE1woJkh8b43DWjaod2bEPh02uumemlUTir8U//q5YdYDM
         5Lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436490; x=1743041290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m30hK/WpmHc3oOKJEstrimV4bd9HKKE6GgYF61+TWU=;
        b=rPiMjWYQqXWzlgqij048fFTmhf9v0oG8lMbjmKEihLUfk11KgSlLKU0Gotv9icxgsl
         Z1yr7zh666gtl9vu3Hm+LYtA6J7atSXNPiN9fByelMiGma5qW3hqp+WcDbLNi3cAGgr+
         O/tabs/mM/gZIh62oj6aa9ipejWLEVnN4NwhQXyAxmHfOXMYp1CYXMLBmxiGr54qHVzM
         Jaf0D+5dI6z+g52wVznPtFSY1riJkTnhMRS23/WY4OlClwhwdez6vKFdGKH9Z6RIm78X
         nycd3+JGca/Ck2PkIOJygYlpYUpvqvravgP7nHEbdhen3pgugmz4tQxlYYAtfv1xNwV0
         F0XA==
X-Forwarded-Encrypted: i=1; AJvYcCU/dBmf2DvFaPjHbx0FaTbM850xLjKlEpcKxCpzNLxzExSAnYCc23m28PpiOLFC3bMiLSQ8z62d+f5PVm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmJgaQiRJHi8S47cW/Ev5G1hIap96g7RWeeL6AYW1NHKs5XYu
	DWaUeeqH8CICf2CnC0tD3v7XWS6Ewy0UxOXrzrSd9HwEoJyRQSQVByb5MjzqsrE=
X-Gm-Gg: ASbGncuTBlwC69YFubMMdp+08dvu+BxTtWfYlkUHA0hHZ8FD9A2d3FCWKwkBIyB4xSo
	qzBfpGu3VBsipxOWVLxO5sAlYr9z2OykkBu7iGahPeXbQCUugI8kcptNTkqwGpyrpj5xbFj6JPA
	AF1ZntpafNb3bl/au0HNV246lvtcUCOB7eFUABsfiY/oXf2QjAMhZZ8M1DLb7qZzwcm8rmaWCgb
	H81B8ku+00PShHHkcBKOqgNUNOJD8RqsZbe3uS1t8ktIVCAzWqN3EeZUSjSyg6/JUaPmVYq6NZf
	RXQpEkzRgV4fZGMmifaqOszulLV/vA79tLe3gGDjMWITzIUXjLripfuap5YZHXhfnS9MQxEkB9w
	DFeJbT+aCfHCnQ0oDisIpXDbPD8Piow==
X-Google-Smtp-Source: AGHT+IEg4JwxOP7K3Nu29ZjFLF8R2BzHBsPXgJIubBIhclHdAN12cQy7377cZeX+JtynbbEJweeJjQ==
X-Received: by 2002:a05:690c:6ac7:b0:6fe:c803:b471 with SMTP id 00721157ae682-7009bf8152amr80373857b3.16.1742436490153;
        Wed, 19 Mar 2025 19:08:10 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:09 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/17] rust: faux: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:24 -0400
Message-ID: <20250320020740.1631171-6-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/faux.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 5acc0c02d451..11e56fcbb6ed 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -7,7 +7,7 @@
 //! C header: [`include/linux/device/faux.h`]
 
 use crate::{bindings, device, error::code::*, prelude::*};
-use core::ptr::{addr_of_mut, null, null_mut, NonNull};
+use core::ptr::{null, null_mut, NonNull};
 
 /// The registration of a faux device.
 ///
@@ -45,7 +45,7 @@ impl AsRef<device::Device> for Registration {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: The underlying `device` in `faux_device` is guaranteed by the C API to be
         // a valid initialized `device`.
-        unsafe { device::Device::as_ref(addr_of_mut!((*self.as_raw()).dev)) }
+        unsafe { device::Device::as_ref(&raw mut (*self.as_raw()).dev) }
     }
 }
 

