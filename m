Return-Path: <linux-kernel+bounces-554978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA59A5A417
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5286D174C02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5021DDA36;
	Mon, 10 Mar 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="tcPcy/DZ"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BB1D90C8;
	Mon, 10 Mar 2025 19:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636310; cv=none; b=eY5tf4AjEaFvhvLBJM1HnbcluMwzrQKFg2qgq8AQihzSJpFeKBBN27RIzUdCROZ6SCfBd0xHROId/Z+viyjWsIFgoGYei8lFmPdsHfym7r+PXG0b4f+kdY7tdD9xbd43KtYlRcZ1GtSgFEWx8ZkSoJ3N0tsgt9aphA9sjLTnYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636310; c=relaxed/simple;
	bh=aD+sDt1ciaV119MjNuVJLFWgQduPhmrVJV35QOG6p+8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KqdihBYJI3RGO3126LT6pSLamMOnLW8Zb9T989k5Bm5vTr7Nyfa2t5Sbhw6CqyEFenml7+5IsSeHtZ2aVDLluJEruY07Y/4ft3XF5/pdBeS63VMbL8FYQqyPOMVARjvy+d+6HpzM0DzYzHOOY/NoHigrrAeYJrWJhM8FFgj58EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=tcPcy/DZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZBSFq21YDz9t1w;
	Mon, 10 Mar 2025 20:51:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1741636303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gv+550w/d+lXAHcItL5V3U21dqpQZG15UW/W7rQZH1s=;
	b=tcPcy/DZPBAG5uqdt6nK+gR3DIMtN0wjp5BACaXLTXS8RDlIb3KTfMz9+dKwMvTpEaHdEx
	34unUgAfVqVk50lMP5FsUnoFAHKpp3hLXPYM0nBPIrVfPZ8qq+5NXG4JiwIKoHqKMgWzfz
	1wwUOiCbou30K6ZbIUUYFkmhKJjHcEZdxEjjl9tOG0QDaGfC4219raAWkAotkUyp6p8VM0
	IS1+FCS+Db11WZbsPOiYACRJPTiBS99Cj+BeWWmH9WzuJ1U3DTZvDUeX76afBc4CCIGmaW
	YWN29mr4xC/p15H9+d5CTiq8ZgBj+CIWupkOnUSrhFw5l5nk8kzvDn/WnfWGpg==
Date: Mon, 10 Mar 2025 15:51:38 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?PT91dGYtOD9xP0JqPUMzPUI2cm5fUm95X0Jhcm9uPz0=?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, ethan@ethancedwards.com
Subject: [PATCH v2] rust/kernel/faux: mark Registration methods inline
Message-ID: <jesg4yu7m6fvzmgg5tlsktrrjm36l4qsranto5mdmnucx4pvf3@nhvt4juw5es3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When building the kernel on Arch Linux using on x86_64 with tools:
$ rustc --version
rustc 1.84.0 (9fc6b4312 2025-01-07)
$ cargo --version
cargo 1.84.0 (66221abde 2024-11-19)
$ clang --version
clang version 19.1.7
Target: x86_64-pc-linux-gnu

The following symbols are generated:
$ nm vmlinux | rg ' _R' | rustfilt | rg faux
ffffffff81959ae0 T <kernel::faux::Registration>::new
ffffffff81959b40 T <kernel::faux::Registration as core::ops::drop::Drop>::drop

However, these Rust symbols are wrappers around bindings in the C faux
code. Inlining these functions removes the middle-man wrapper function
After applying this patch, the above function signatures disappear.

Link: https://github.com/Rust-for-Linux/linux/issues/1145
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
v2: rebase on linux-next-20250307
---
 rust/kernel/faux.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 3277f35c3f79..8a50fcd4c9bb 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -23,6 +23,7 @@
 
 impl Registration {
     /// Create and register a new faux device with the given name.
+    #[inline]
     pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
@@ -58,6 +59,7 @@ fn as_ref(&self) -> &device::Device {
 }
 
 impl Drop for Registration {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: `self.0` is a valid registered faux_device via our type invariants.
         unsafe { bindings::faux_device_destroy(self.as_raw()) }
-- 
2.48.1


