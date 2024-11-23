Return-Path: <linux-kernel+bounces-419021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0027E9D689E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 11:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8892C281B68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187C118A6DD;
	Sat, 23 Nov 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="xxvVxoK1"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949517ADE8;
	Sat, 23 Nov 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732357808; cv=none; b=svp2IVfgVUzSItgLwAP4IkKvhlAwIrCIhexLIMjbzRio8JrpJhsz5WHNcA7gtqthZ68ktW2uL8Mg/75FEBEqD5N25RsCDc/Xds1n/QsiOJ/DbI2B9ucFNDA8yrUFhbUUjqRgenlLtLBFEPPPMfiOSl/OlgT69gOcWOUPLJWPK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732357808; c=relaxed/simple;
	bh=uWB+JZqwCwSXbMcgHUdQRUsFjjPuBPxc4/FB8kCfG7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oTACpml3CGRDATfumwYV6ydcI5Pq6ksxAqvSIW3JpcOeYousXPxPQ8ahO/ntmFYKZft8fCsl8Fvr279W+r9Jq/eYdJ7aJ3vPUxmC7c7QAe+UW3T3Sdla3JkCqO7rtWpqRqexqyKAvrC81BLjDWiOyg24iFsEd7whngKc0sgnHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=xxvVxoK1; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 773B043567;
	Sat, 23 Nov 2024 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1732357801;
	bh=uWB+JZqwCwSXbMcgHUdQRUsFjjPuBPxc4/FB8kCfG7Q=;
	h=From:Date:Subject:To:Cc;
	b=xxvVxoK1pcuTOjR46ms40ZbChVbMVHHVMvTBAeLuX+guaUA5Mrx6vDMcnep9Ch+iX
	 JSAfSBqZxVI/VKWu1cWfSQdK30OewDf0Le+AC7UeM/wtXOHMPVnTYeSYStLcXGVy3R
	 OksBCUFxW3C2C9MoGziETRhgi6qh5b/cVtxHpE3O7/SJChPtSB2uD3mBHfOn6NVCFU
	 1nWN9ipTUprrlPYOV3yxn3zCROrHq0BrAdNtSSdyIdhmp0tUZG7Y4XfL61L/foFBBN
	 cKEHkKcBZ8iDi704J05Tw+RrK5WCNdAMs6EQjQjquiGY5pDBvF0BuFYBIdoma7IXau
	 lYEi3EifCtUeg==
From: Asahi Lina <lina@asahilina.net>
Date: Sat, 23 Nov 2024 19:29:38 +0900
Subject: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAJGuQWcC/x2MSQqAMAwAvyI5G2ir4PIV8VA1akBUUisW6d8tH
 gdm5gVHwuSgzV4QutnxsSfQeQbjaveFkKfEYJQptTYFincXzvygFbFhs+HwF6pBK9VMdTMPFaT
 0FErKv+36GD9US/XjZgAAAA==
X-Change-ID: 20241123-rust-fix-arraylayout-0b1009d89fb7
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: Janne Grunau <j@jannau.net>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732357800; l=1319;
 i=lina@asahilina.net; s=20240902; h=from:subject:message-id;
 bh=uWB+JZqwCwSXbMcgHUdQRUsFjjPuBPxc4/FB8kCfG7Q=;
 b=BamdecePrlTYdf5brTAkFQLgQNgrgjvqsDib/ra31cu//I78XbUwWAcggWaRQA9Sdn1szJgGX
 So4wO2068NfA6ezDC3EABOdDVGuPjv5hLRM0gLwx8AYjXV/v3ymnz9i
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=tpv7cWfUnHNw5jwf6h4t0gGgglt3/xcwlfs0+A/uUu8=

We were accidentally allocating a layout for the *square* of the object
size due to a variable shadowing mishap.

Fixes memory bloat and page allocation failures in drm/asahi.

Reported-by: Janne Grunau <j@jannau.net>
Fixes: 9e7bbfa18276 ("rust: alloc: introduce `ArrayLayout`")
Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/alloc/layout.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
index 7e0c2f46157b772248450a77ff445091e17fdfd7..4b3cd7fdc816c158e63ac74014cbfc0794547e81 100644
--- a/rust/kernel/alloc/layout.rs
+++ b/rust/kernel/alloc/layout.rs
@@ -45,7 +45,7 @@ pub const fn empty() -> Self {
     /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
     pub const fn new(len: usize) -> Result<Self, LayoutError> {
         match len.checked_mul(core::mem::size_of::<T>()) {
-            Some(len) if len <= ISIZE_MAX => {
+            Some(size) if size <= ISIZE_MAX => {
                 // INVARIANT: We checked above that `len * size_of::<T>() <= isize::MAX`.
                 Ok(Self {
                     len,

---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241123-rust-fix-arraylayout-0b1009d89fb7

Cheers,
~~ Lina


