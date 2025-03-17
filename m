Return-Path: <linux-kernel+bounces-564065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C73A64D17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC9F1892E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132272376FF;
	Mon, 17 Mar 2025 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrIZI2kp"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA9233728;
	Mon, 17 Mar 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211755; cv=none; b=Ln1qvnQQB1emf11JCe/W9ANz1FOruIwq6t+7lDR+yfDxy+ap60Iw4Q6mTXL6WndH6MLdr1x6H4/ZUPmgoTprkg2/Ee5FVhomsYlr7OfzDHygWL5qp45RTV/rASPJVG67hVdzEmMUiUjyHiKqEYbCyt630ccT2zP3VUDXA+8HadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211755; c=relaxed/simple;
	bh=//vxIGqnKxX4L6Wot1kvwfy2PgPrZ+A4crmQWKHy2BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EMJuFhYrkm6+ppwbT5lJJftU8QMe0XTtMZXxMl+b62LLArs6LpU53ijDsexl5AV9VFO1ZjCh+YL1BxANKEeu6F7ysLAV/2YJ1At2UI8+hwQs7FyGPyuxsgddMoTMBnD2Vg8s84nI9LGN8hW9mxhbfJ+rFgK9He6mvMcjeXDxvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrIZI2kp; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8fca43972so40523216d6.1;
        Mon, 17 Mar 2025 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211752; x=1742816552; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39S3mS4hwmCD7YLvwbWlxuNVBuw4J8dUdZhCCUuBLsU=;
        b=BrIZI2kpI6hrx4UUy6lJ/Q3Qk3R70nhHmLp0WoiexD5kya5iFThIHukUmmDVKV8sTY
         BzG1xfvTl0KpXOdi6RHYB9cUaCXVOFBB+U7Ptrgd9s8Kz66N1twexE5ALqs9ZmyOsiRH
         7C/lBrueewVYd7n3C8ruHU2GQyjSlNui5KMc9AMscxcOwsWPnoqHtHkqncAfszHx9f39
         SNcEKjZjbgacNVzvC1tzi9v9/P/4Re4xkmlsgxC/QPQHrDXaMxS3L7dZULVZ1yxGj1SA
         6cfciOv0SNkHw8KP0aJF3AUc5UDWIVqIas48gjQbc+IM+JpMxknZ7BHJD2ny5+D8ATAY
         Tozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211752; x=1742816552;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39S3mS4hwmCD7YLvwbWlxuNVBuw4J8dUdZhCCUuBLsU=;
        b=i/+sLylx5pY3FqmSSAqMzt83B1PLRvA5/AK0pOnQh1UPjMCE8sWQGlLrg+sXwJTlFA
         N9dEYRS5AMGGsENLvPa3gTsPg8cX+YELwT50ILjRB84CiOdUCz/87OioCL0eH0gHz3bf
         PWzGGcd7lFmm3B3XQdp9fhraQHQ6Th5Vwq7FQ9oQ9Gput9K9kM1Fn3v7vUTCJxvKQzk1
         4f0Ng0RmlYUHh8Wdp4MU0BV7beu7U3VqdeKooiuckD+fZ2XSBBu1YUKkBwADlh3URAJJ
         zKVt0D65+haOsM/AZPA2b1Lv6XTsgozt1Q3xXEx3lUv5ucGPlolI+eU61Wtlyj3VFBnY
         VpOg==
X-Forwarded-Encrypted: i=1; AJvYcCU68Ff+w6OQlIe2D7VSEKBwUjwgPlDJ3CAL2IhXdPVZDIBw1B++wueggZeBiEinDrsZcwjWgoKn7fUGYWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4QN1p0u995v1CwsyumQ+xv5mzT0hIsEgsaZ6uUyxq2v6QIsey
	VpVjXDQHdBeE/vw6eDfmpI4C+zPnblsjFGoHHbcUJJ2y6GfDrBPPY7dO7OEjnk4=
X-Gm-Gg: ASbGncvJe5XtV7Bv+06uC8I4qCa8KfCU0GHMHhNJPTp/G/Bpi51KNHCr9UbunA/0TgL
	/UEJah36WUBh5rz+cDPiz1CFyNpJy/zj8RR+vUcS5UuTTOdGBrAfXvvYhXaSdq2i8Hi3fUNnTCA
	QpY4Kzg9JkXdcR1HS+vQLNhE73KareFjDx223WzpnY+wGpqF7WYQ84SuvtjhsSaHYNz4/V10pl9
	TK8Xh8YX8PQBZE4VMLlYjdNsVvJcu7m8/qolvS5UKCHsurwvvFxroLPClbFI+mBUoVTenXRMtWT
	cjuOrPGcDrUY7cG1svZyrAyj1AxSu4brSIdW1ZcgoUB5sSof4jd1u/3o/S1IcCdsSdwz3TZ8qA=
	=
X-Google-Smtp-Source: AGHT+IG4eUAbG2q19+R1IJNaTIqRbhDWmVRUB0OYLFlUOQsLGH+DLtgbhy8xaVehmC1/zuPiwBaSyw==
X-Received: by 2002:a05:6214:2426:b0:6e8:99bb:f061 with SMTP id 6a1803df08f44-6eaeaa081b8mr201616326d6.18.1742211751819;
        Mon, 17 Mar 2025 04:42:31 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:ac75:40f2:fdb1:31e5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade208e6bsm53849766d6.1.2025.03.17.04.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:42:31 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:42:28 -0400
Subject: [PATCH] rust: alloc: use `spare_capacity_mut` to reduce unsafe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vec-push-use-spare-v1-1-7e025ef4ae14@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKMK2GcC/x3MQQqAIBBA0avErBtQs6yuEi2kppxNiUMRhHdPW
 r7F/y8IJSaBsXoh0c3C51Gg6wqW4I+dkNdiMMq0qtEOb1owXhLwEkKJPhEaZ3u7rUp3foASxkQ
 bP/90mnP+AJcL+R5kAAAA
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

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..d2bc3d02179e 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -285,15 +285,8 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
     pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         self.reserve(1, flags)?;
 
-        // SAFETY:
-        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
-        //   guaranteed to be part of the same allocated object.
-        // - `self.len` can not overflow `isize`.
-        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
-
-        // SAFETY:
-        // - `ptr` is properly aligned and valid for writes.
-        unsafe { core::ptr::write(ptr, v) };
+        // The call to `reserve` was successful so the spare capacity is at least 1.
+        self.spare_capacity_mut()[0].write(v);
 
         // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
         // by 1. We also know that the new length is <= capacity because of the previous call to

---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250317-vec-push-use-spare-27484fd016a9

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


