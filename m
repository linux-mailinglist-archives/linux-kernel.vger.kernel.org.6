Return-Path: <linux-kernel+bounces-329900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC145979742
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20D6EB20E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2D1C7B76;
	Sun, 15 Sep 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1LNfT3s"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D91EB35
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726411295; cv=none; b=Hl3pkYoUWiH3rs2UaSI7b/9lSvPj9fPMHNw9L1/D1j+OtpwzCoBrUb1IULOB5ay/0LhGl9IDoeGcl8xxR6cxX13N6hjxWQQ6c8WAh3uj/7/7RV9mUAXUBL2zUGhbc38T/bcXOo3KgOstiYOjB4QsMegnDdQq68/IxublYXRzv8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726411295; c=relaxed/simple;
	bh=3WcMNrZ0tsoHg+qzEqC8I515GwoTWxUcB94qskQiDls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T/3R/KTIZN0QUbmhuDPOPIk0iXoZQcZvza4G8bOfElTgNOVnppAqFG+tayuCEU14NiXFdw/Zx0PCoVehSKq/ibPlKHoe+rJY1BJHadKuY4wz8zBsd+g96AmsTaqe12mW3wHGCRKwKZtAB7IhLGqxMAOoW57qCwcOsr3OKprK418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1LNfT3s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so18332545e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726411292; x=1727016092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/O8x7VJ554ueyy+hbUwWFKRcP1g4JZ3yxvjNVEBW2I=;
        b=G1LNfT3sAgPIOlM2/fU7DbTQqtREmOtCy0ybMdHFkNU9T+nPcwsBQbJklxNYD9TvtD
         GMiq09+qdmyzG7/m1Lk31C1fHmrBQomVKTe9TFkfAyvQBFsxKm2erkTHg/nwvspY5L5B
         ikD1/SZISKmWGQFAbUwRCQjjmrNRsRfCWppAph+kBSXoHLChPwJ8/Ub6E3XS6w78CptB
         OUq2/jYJRZbpYMhOt7+RIXEm6iuPgYOrda06OIPkCs8063FaLJdTXN9YAlG1LoUvbrTX
         3SEq5Hv4RU/Unrp3s/HRMaDTAnQxB8qDZAruM8EV/Xj6nGEwLCtDfdPnQxiPVQRlhxmT
         M2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726411292; x=1727016092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/O8x7VJ554ueyy+hbUwWFKRcP1g4JZ3yxvjNVEBW2I=;
        b=ZXppP2eJldP8Wfz70OPvk8ginLdLJzbUAwwIssgWT+7A+KJLIWF/+jHcSDAZz4yV1u
         4Z0/WBTgJFb0dVRrx8jjtacBbAFiXf3xhivhOdQVpq5xNpZ1xmNwTIuP0zCX5Df+5imA
         gxjfUX3sU9DsQtBHX+7onbf9EoXw9ka5XbcTQ4a6bs0d57FbF5kfXP89d21G6mgh2Hij
         ND45kxd6x8PQuu+0EdjSFATZU9OvUOxWhjBqXNWC1C/8CSibYmYOjoh6GE4+bhipYZp/
         iIZp6GGOnlm9qIMInAjjqROneLduTR/14AruLhh27ZiNvtm/F/B1eRQ/YMrw25Xuutsb
         5ngQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0nHrdPK8EBJnspd4vA8fukZpXJuMVFiKfbrr7kN896xA1SwZEPDOUHnmoEKCkdgipV/AWv/YEEVhWhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmu5nUn43cwo5nZOMbMviZB8sZ+bwVOFsDIBxBot/+aJi5yGX
	gFWdTxbZt656rLx8sXSptMo3f/yURuBWOjfBlZ9KZJiirzMBn2BdZ2f/XCVPOSecod8dhzRoOhx
	XgaWLcCyOt4wfsw==
X-Google-Smtp-Source: AGHT+IF6tbgP24fOhUCyIFJUdfk1J1lsm3emGm3kIkIAo9VgaODWeLcdjdRZMS5qXJKsI5d95ieOiuRPkZ0IYuM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:2318:b0:42c:b026:4525 with SMTP
 id 5b1f17b1804b1-42cdc88d08bmr1412005e9.1.1726411292105; Sun, 15 Sep 2024
 07:41:32 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:41:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABfy5mYC/32NTQ6CMBBGr0Jm7Zh2wJ+68h6GhUyH0ojUtKaRE
 O5u5QAu30u+9y2QJHpJcKkWiJJ98mEqQLsKeLhPTtDbwkCKGmU04Rj4IRa7GdM8Mfb+g+qkTW3
 7A/XmDGX4ilL0Fr21hQef3iHO20fWP/s3lzVqpGNT19wxd5auLgQ3yp7DE9p1Xb9YmzwBtQAAA A==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3347; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3WcMNrZ0tsoHg+qzEqC8I515GwoTWxUcB94qskQiDls=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5vIZzbcn43lhxpnxChoTQ4UlOIGXoizh9RPck
 GOqCSjJT/+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubyGQAKCRAEWL7uWMY5
 RjlhD/47qaRnFhoeeKcGD65fEJvXyOsg6UlWoXkHdTIqzdWc+gD5xYKrax+0CQRTYhLTbjxHbfE
 wmAiz1ApmJw6QFuVbfFb8eZfArOIkbuxU03K3mU0EWQ8GQxsl/UzAtJnCtuIneUoWjSQaXQOLlY
 vb5mhfJMWSvcxCLCVKVpi2IAHPI8aVaD/DZ2y35btYOqzOHjzHTyoy3UmPbx6D60m5q2qY58vmW
 5jH/NzV1JEOiQ9P/OsdUwbKxTHxpUJtrmSBuKzUEcurZpirT3PGqB0+snRQPEAp3UwYBi0iF0TV
 Pov70T51EJMisFa+GHAY2yTgH4Eq+TSvqHOCr5cbmzQRF+dqyMetDLbZsBnf2/bS63Uo2cIqi4O
 1oGVEnIKCntj3HriNyhmFwbvLLhN6svYAcQVb/Y9NBWRUvamckq73oNOg+3P5/nSNnc8JZ8FmVM
 5+j7la/1LNeceFYZEEV+ZsGKNoYoouTojtEIZzQr//hP7/o4QqctaRlg6ZGxiH9ttehN7N/+nyN
 FZu40e9L4/z3AlW9VlZlpFB47nxkP15UY16w8I/05HISn270zlx55k76Vz79I2V0JOHpgvSCRUb
 rKspVY9zpp2gufT5HWhZfPLIlDHTS7TqxplBtXi4VjCYPywZPxUq8iUb8vwHLFxy0YSKIjhzqdQ IdRtLCV4s56hzBA==
X-Mailer: b4 0.13.0
Message-ID: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
Subject: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Trevor Gross <tmgross@umich.edu>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The `LockedBy::access` method only requires a shared reference to the
owner, so if we have shared access to the `LockedBy` from several
threads at once, then two threads could call `access` in parallel and
both obtain a shared reference to the inner value. Thus, require that
`T: Sync` when calling the `access` method.

An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
This patch does not choose that approach as it gives up the ability to
use `LockedBy` with `!Sync` types, which is okay as long as you only use
`access_mut`.

Cc: stable@vger.kernel.org
Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Use a `where T: Sync` on `access` instead of changing `impl Sync for
  LockedBy`.
- Link to v1: https://lore.kernel.org/r/20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com
---
 rust/kernel/sync/locked_by.rs | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
index babc731bd5f6..ce2ee8d87865 100644
--- a/rust/kernel/sync/locked_by.rs
+++ b/rust/kernel/sync/locked_by.rs
@@ -83,8 +83,12 @@ pub struct LockedBy<T: ?Sized, U: ?Sized> {
 // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
 
-// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
-// data it protects is `Send`.
+// SAFETY: If `T` is not `Sync`, then parallel shared access to this `LockedBy` allows you to use
+// `access_mut` to hand out `&mut T` on one thread at the time. The requirement that `T: Send` is
+// sufficient to allow that.
+//
+// If `T` is `Sync`, then the `access` method also becomes available, which allows you to obtain
+// several `&T` from several threads at once. However, this is okay as `T` is `Sync`.
 unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
 
 impl<T, U> LockedBy<T, U> {
@@ -118,7 +122,10 @@ impl<T: ?Sized, U> LockedBy<T, U> {
     ///
     /// Panics if `owner` is different from the data protected by the lock used in
     /// [`new`](LockedBy::new).
-    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
+    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
+    where
+        T: Sync,
+    {
         build_assert!(
             size_of::<U>() > 0,
             "`U` cannot be a ZST because `owner` wouldn't be unique"
@@ -127,7 +134,10 @@ pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
             panic!("mismatched owners");
         }
 
-        // SAFETY: `owner` is evidence that the owner is locked.
+        // SAFETY: `owner` is evidence that there are only shared references to the owner for the
+        // duration of 'a, so it's not possible to use `Self::access_mut` to obtain a mutable
+        // reference to the inner value that aliases with this shared reference. The type is `Sync`
+        // so there are no other requirements.
         unsafe { &*self.data.get() }
     }
 

---
base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
change-id: 20240912-locked-by-sync-fix-07193df52f98

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


