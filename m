Return-Path: <linux-kernel+bounces-362176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D0E99B1D2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B003EB22A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775C413D893;
	Sat, 12 Oct 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b="fH+hEjvm"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E9146D53;
	Sat, 12 Oct 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719622; cv=none; b=tqI08X/tWEheNSawv0p3Huwz5Unx03W9PpF66SNPhTQUoVCa3ZpKvhxlUY/tygXlLWObciuPePn5qMKmtO4TqtA2+z/zsoyY7Jkvn8OoDrhsfq0xbkKVOeMWPiAhKy0nwdDLpm9q6A15BiAqJMyOTqb8Tnnj11L4QWs6N3H1i5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719622; c=relaxed/simple;
	bh=Pb8NkB9WOpnJl5334t4n2NqLfaJ1MDIMdfOJANfH6xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZFCfryqQaw/xOK9Z5NOe8BsVN1560JWqf2eY65BIQFYNY9XGTTG/VIDN2/tsWD1m6PfUZA3ynadU1I+S8Oi3afDjMS91Dq6u5V0sF/RjCGbWjy/B0T4vGUTWitzG2sXVRr4gMKgDMXb2jr+UrUmLOsrPSjtYZ28/6GBmwBt/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de; spf=pass smtp.mailfrom=wiredspace.de; dkim=pass (1024-bit key) header.d=wiredspace.de header.i=@wiredspace.de header.b=fH+hEjvm; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiredspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiredspace.de
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiredspace.de;
	s=key1; t=1728719619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sn14ELv+RViJWynku1NOkoS5s8sOL4FNY73D6XE2og=;
	b=fH+hEjvmBCuyzz+zlgLCZfv7+GFdgGHUSK9Z0jEgsDPMejHHlpyOxj49wvauJPopcfnREM
	yLyDELsQ7yuYNkdPV16aL3Fh1A5qa5+2/BiK4DE89wdjaasCS10Zo520bahQEUJclDOO49
	pnsPd28UmvIH4ujgA/osDIXDG0piCX4=
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
Subject: [PATCH 3/7] drm/panic: prefer eliding lifetimes
Date: Sat, 12 Oct 2024 09:52:46 +0200
Message-ID: <20241012075312.16342-3-witcher@wiredspace.de>
In-Reply-To: <20241012075312.16342-1-witcher@wiredspace.de>
References: <20241012075312.16342-1-witcher@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Eliding lifetimes when possible instead of specifying them directly is
both shorter and easier to read. Clippy notes this in the
`needless_lifetimes` lint:

    error: the following explicit lifetimes could be elided: 'b
       --> drivers/gpu/drm/drm_panic_qr.rs:479:16
        |
    479 |     fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
        |                ^^                       ^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
        = note: `-D clippy::needless-lifetimes` implied by `-D warnings`
        = help: to override `-D warnings` add `#[allow(clippy::needless_lifetimes)]`
    help: elide the lifetimes
        |
    479 -     fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
    479 +     fn new<'a>(segments: &[&Segment<'_>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
        |

Remove the explicit lifetime annotation in favour of an elided lifetime.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1123
Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
---
 drivers/gpu/drm/drm_panic_qr.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
index 7adfaa3d6222..767a8eb0acec 100644
--- a/drivers/gpu/drm/drm_panic_qr.rs
+++ b/drivers/gpu/drm/drm_panic_qr.rs
@@ -476,7 +476,7 @@ struct EncodedMsg<'a> {
 /// Data to be put in the QR code, with correct segment encoding, padding, and
 /// Error Code Correction.
 impl EncodedMsg<'_> {
-    fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
+    fn new<'a>(segments: &[&Segment<'_>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
         let version = Version::from_segments(segments)?;
         let ec_size = version.ec_size();
         let g1_blocks = version.g1_blocks();
-- 
2.46.2


