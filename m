Return-Path: <linux-kernel+bounces-372706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A04959A4C14
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 10:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A73EB22D4B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779301DF275;
	Sat, 19 Oct 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="elMYD0Ul"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CF38FB0
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729327281; cv=none; b=iVLpbJJv1ziBojT9V/m9FLW2Wo+FWKgtL4niMXCmQctx0irPnR04x85M9HhlPh3H+BTWOaIqJrrALIDsAUVCFf7LG3OM3WmWp4rKT4hhhdtfMFDf+3wws+9qQIuldfzzudnPW536ZOcQoyUAMvpIqafd05n/hTFRspvAZj0HzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729327281; c=relaxed/simple;
	bh=er4PjG88WtdHMGxq4I2UcqzhmfHX2ibGY4X4NDNYNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dr0d/0Z8QUUXhjcYso32ddyblxoBM5Q/u/FD5IV7HJjd4KKvUguEvs0IVWO4Jm/CmCJ8+dGl9F1dJPbCaKtvTTT6+Q3fE6iU9imF5qhNMH1fAFMl+jArMM+QMowjmVgij5isSjakog8426yar2UZmnXVl90LB7sHZJ8/5EiP/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=elMYD0Ul; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1729327276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5h88aRCX075gQyacCBN//xbLtbJ+w9Ld3N3jt4xAwmA=;
	b=elMYD0Ulyk0Ph6cf+QJs8Gb5ybPcrTxhHxPtJxdXOERuk4TzCZt85jgcGI02gA2eO9rnOy
	ZHaIxZmXqamLRy7xXhUt7Lshwb/1UyddIaGj4f2TcPOnvqV/yRTERoMxf0nMjD0nMOQsuV
	SQuTBf4WV/+Rs8eQnQtC5HIELNW9QOU=
From: =?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Jocelyn Falempe <jfalempe@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thomas=20B=C3=B6hler?= <witcher@wiredspace.de>
Subject: [PATCH v2 1/7] drm/panic: avoid reimplementing Iterator::find
Date: Sat, 19 Oct 2024 10:22:46 +0200
Message-ID: <20241019084048.22336-2-witcher@wiredspace.de>
In-Reply-To: <20241019084048.22336-1-witcher@wiredspace.de>
References: <20241019084048.22336-1-witcher@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rust's standard library's `std::iter::Iterator` trait provides a function
`find` that finds the first element that satisfies a predicate.
The function `Version::from_segments` is doing the same thing but is
implementing the same logic itself.

Clippy complains about this in the `manual_find` lint:

    error: manual implementation of `Iterator::find`
       --> drivers/gpu/drm/drm_panic_qr.rs:212:9
        |
    212 | /         for v in (1..=40).map(|k| Version(k)) {
    213 | |             if v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum() {
    214 | |                 return Some(v);
    215 | |             }
    216 | |         }
    217 | |         None
        | |____________^ help: replace with an iterator: `(1..=40).map(|k| Version(k)).find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())`
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#manual_find
        = note: `-D clippy::manual-find` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::manual_find)]`

Use `Iterator::find` instead to make the intention clearer.

Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1123
Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic_qr.rs | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 1ef56cb07dfb..76decf49e678 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -209,12 +209,9 @@
 impl Version {
     /// Returns the smallest QR version than can hold these segments.
     fn from_segments(segments: &[&Segment<'_>]) -> Option<Version> {
-        for v in (1..=40).map(|k| Version(k)) {
-            if v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum() {
-                return Some(v);
-            }
-        }
-        None
+        (1..=40)
+            .map(Version)
+            .find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())
     }
 
     fn width(&self) -> u8 {
-- 
2.46.2


