Return-Path: <linux-kernel+bounces-566373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E561A67707
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10ED71884AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B13320F086;
	Tue, 18 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak9DBRlL"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF720FAB6;
	Tue, 18 Mar 2025 14:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309571; cv=none; b=dUiTqrrhoKK+oENoG27bnVGNEHWBU5/qToflDjYXCXkjKhc1eI2cul2L9VQDo6EDS0vu+0DLnxn1qp7CpqDJAVwFY9Lkow/xQ1kOPPD/6gu1O5fwXgbJ8FB9cYZBRbnKluqzWdAJFEvsv/ghTBwlH4XgsF/c33X14sLvhu7hbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309571; c=relaxed/simple;
	bh=jhdYduB08vMcvK+n7n7kk7gvV2VFtq1KBexVwfFXt/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GWaZc4IUc5szs919X6l5zgsgsiwbYg37+7ZkCjYQ2O7myEzm5NESlrOTyH7Yq3VWofGdNOVo3QLIIt9vm8G8rMZM4A+uI7OdzhWtk4aFxoO0CXVYZLpM1B90hAoGRXBXIR2RQWCPGedVRcsWSLMfmshjh66ApmU3SEaoaHc+dgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak9DBRlL; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e900a7ce55so78627396d6.3;
        Tue, 18 Mar 2025 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742309564; x=1742914364; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlkC1TMRL0WKywfXtAZhYM1FPaZOF5JeoqEk55iXZWc=;
        b=Ak9DBRlLqN28LzpJmJF5QUuBr2BeXHkX/vlIBbhRwrYyQMDlog14w+mH979FZskt5i
         pycvVO4ooe6MNtqITkokws2xnW4ouMEJPXuSD4EiCazeJFQxGF3ofPVLiz0ceoowDdOa
         /8T0sYbdFOF6oSvCzpAxRTFNEm/bVL2l/57VVvn2ZKUpVHS8P7Dm9G134Zjn6rWtvh8l
         Z13gEdawl+ez9Zwa6ceIZYrqdWrogQUMc6QJgPicxEGNTHaF9kAm2QdD9aL9SnHazLeo
         l5eg6TdXDhzD/Y8YUiHTefhYPo0B76zthsDtIqnkPjy7EYZzlNluFzrhBowHO38KAngA
         yzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309564; x=1742914364;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlkC1TMRL0WKywfXtAZhYM1FPaZOF5JeoqEk55iXZWc=;
        b=No0oIGrEdMcY53ODZ4fzjPujSN/kx+RfX2quUF6+D9n100UPC5SVe9Qe/8g8ulpWHA
         sq6CY19SZTVU5Ey0Oz+FwWEUCst3xz/y5Bt9iCGMQGUc85JW94yUkbns/5jy89uv2nyF
         77XTt1Pr/sV2W9s+iv6zGP8/CD+i/pCfycDJsbRusSV9j4MRaII34eiJc3+ZEFDhTOW8
         zqBz30t43Uv1xd1ktd1d9AsVab+oBVZP5iN8aa5DzCXmFiIkFEJDE6m+DcUEl/un3djE
         5FBSw+iIIHwSmWT0F6Wp80/5L3jDeTJrceU6RfmNl7L3HVHDigzBHXIonP1RR2Q43iNK
         fU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR72/1pMQOg9HTo92/vR1HtYPrjqhOxWH9nhKJszSMUHr7PSEuC2vZsLtyCnDQuGydN+lJR3XmFn4kQgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmb9ZM8iKrfhlexlWqYaTSt3W12zN4MGGj27siZckolOkOAJs
	Ww4IR6PtQusrn7A2yBoo2t6He49L46qFmuAuMW6ezejbVzcxM4cC+2jmnR5Fmac=
X-Gm-Gg: ASbGncumSxoKcO7cUYsjRHEA0Oy1PkW+uXjp6AXgCjI5DKboYmmlcqpHsNwpZH+19il
	ov4zTSLNDMT+i+CtfJegCmvN/gMAey28bI/6KsLwjGrBQzRTW77iHV2j6S3f2FcyZs5059jI6XG
	k7Sq45w3qNG4aZZOubLuXi1jCH5g4QljDxPcx6sR43RU/mfXTqDQ5kjlKACINH0/VrDu9hpYS0k
	yd4oykJzBdI0uwG+SgY4ftKezF7L1B1DXmsEkq4IIKnV0d+Qxx29FUaqeSo7e/64tfNQ4ZxZ1uw
	MOrgk9iqxde5RNuT3NZ9xmrZnEZgE1SLVI79dtHwGVQzcNWO08SRq3xGpPmgkg==
X-Google-Smtp-Source: AGHT+IG5q2ctphJNXtpsFqjE3xP/i87wbvAi2YL+7clt1/gn5Eeey3RkZfu8RZ0gBaSPkcLlJkGF4Q==
X-Received: by 2002:a05:6214:b64:b0:6ea:d69c:a247 with SMTP id 6a1803df08f44-6eaea9e88a0mr295632796d6.4.1742309563829;
        Tue, 18 Mar 2025 07:52:43 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:45a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c5f7sm68375376d6.96.2025.03.18.07.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:52:43 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 10:52:42 -0400
Subject: [PATCH v3] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-vec-push-use-spare-v3-1-68741671d1af@gmail.com>
X-B4-Tracking: v=1; b=H4sIALmI2WcC/4XNzQ6CMAzA8VchO1vDPmDoyfcwHpbRQRMRssqiI
 by7g5MnPf6b9tdFMEZCFudiERETMY2PHPpQCN+7R4dAbW6hSlWVWlpI6GGauYeZEXhyEUFZ05j
 QlrJ2J5EPp4iBXjt6veXuiZ9jfO8/ktymP7kkQYLFvIHBOJTm0g2O7kc/DmLjkvpPqExUra+rR
 gerlf8m1nX9AE8tDhr3AAAA
X-Change-ID: 20250317-vec-push-use-spare-27484fd016a9
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Use `spare_capacity_mut` in the implementation of `push` to reduce the
use of `unsafe`. Both methods were added in commit 2aac4cd7dae3 ("rust:
alloc: implement kernel `Vec` type").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v3:
- Clarify unsafe operation by factoring out safe call. (Benno Lossin)
- Link to v2: https://lore.kernel.org/r/20250317-vec-push-use-spare-v2-1-5dc6583f732c@gmail.com

Changes in v2:
- Use `slice::get_unchecked_mut` to ensure we avoid a bounds check.
  (Benno Lossin)
- Link to v1: https://lore.kernel.org/r/20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com
---
 rust/kernel/alloc/kvec.rs | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..f5b1f201a80a 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -285,15 +285,10 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
     pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         self.reserve(1, flags)?;
 
-        // SAFETY:
-        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
-        //   guaranteed to be part of the same allocated object.
-        // - `self.len` can not overflow `isize`.
-        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
+        let spare = self.spare_capacity_mut();
 
-        // SAFETY:
-        // - `ptr` is properly aligned and valid for writes.
-        unsafe { core::ptr::write(ptr, v) };
+        // SAFETY: The call to `reserve` was successful so the spare capacity is at least 1.
+        unsafe { spare.get_unchecked_mut(0) }.write(v);
 
         // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
         // by 1. We also know that the new length is <= capacity because of the previous call to

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250317-vec-push-use-spare-27484fd016a9

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


