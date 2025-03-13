Return-Path: <linux-kernel+bounces-559010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F424A5EE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D5B17CE52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FD1260A3F;
	Thu, 13 Mar 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WciwiNyG"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71B020EB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855588; cv=none; b=cuXEEzCiiWvVidmIf26QTkL8TzyVYtbJ+FNvyAVaLnjJGbdZ1Dq1C5mOlW5VEvmo95qSxojRwRVzv8DFJ6wsqTNIKLePQgwhhqplYRgwdAdpIis/dqNOMTXfEH8L/p8ghB1rXsRv/mbrif5HvukS513vTpsHk7mq9VzQ/7JL8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855588; c=relaxed/simple;
	bh=fq6ekP8eUxjdXANo/WduXK/rQgvhx776zl5jczANHmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PINZ2wYOzC6gbyuhfDcdMVr3D0oM+lCgwehWQkMbTOPiOpaYC/LwY67qwa2ALO4+1fb9HAMFwDab+LBdLE8E33t7F1EuJe2FMvQxpce+KeqPNecAI9Uzn0BaMHYL1+FNQtVsVPwAIaoN3T4/WYc/kZTP2RVQ2od+fDX7585TvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WciwiNyG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741855573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3RZVs3JN10EHFOTt3fszpgtp+DbwIIZsS1/By/a7Fow=;
	b=WciwiNyGA6z5mcJyiULh3LKXXDPuJlOeeASqPiBNoLM6HWNdstKiphch+an7hcUmEn/6Fy
	vuL7ku0bVGXXTdau+KmZVdbUu07Y1lHz72FoAjfVagDKiyNVGfi45WMPSxqssMyQMQOgTp
	GdNVVa5w79sR43/k0SnWC9f+ZdNszMU=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Grace Deng <Grace.Deng006@Gmail.com>
Subject: [PATCH] rust: file: optimize rust symbol generation for FileDescriptorReservation
Date: Thu, 13 Mar 2025 16:45:25 +0800
Message-ID: <20250313084525.773620-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <kunwu.chan@hotmail.com>

When build the kernel using the llvm-18.1.3-rust-1.85.0-x86_64
with ARCH=arm64, the following symbols are generated:

$ nm vmlinux | grep ' _R'.*FileDescriptorReservation | rustfilt
ffff8000805b6ef0 T <kernel::fs::file::FileDescriptorReservation>
						::fd_install
ffff8000805b6e60 T <kernel::fs::file::FileDescriptorReservation>
						::get_unused_fd_flags
ffff8000805b6f08 T <kernel::fs::file::FileDescriptorReservation
					 as core::ops::drop::Drop>::drop

These Rust symbols are trivial wrappers around the C functions
fd_install, put_unused_fd and put_task_struct.It
doesn't make sense to go through a trivial wrapper for these
functions, so mark them inline.

After doing so, the above symbol will not in output.

Signed-off-by: Kunwu Chan <kunwu.chan@hotmail.com>
Co-developed-by: Grace Deng <Grace.Deng006@Gmail.com>
Signed-off-by: Grace Deng <Grace.Deng006@Gmail.com>
---
 rust/kernel/fs/file.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index e03dbe14d62a..3dda2bfca1a6 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -392,6 +392,7 @@ pub struct FileDescriptorReservation {
 
 impl FileDescriptorReservation {
     /// Creates a new file descriptor reservation.
+    #[inline]
     pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
         // SAFETY: FFI call, there are no safety requirements on `flags`.
         let fd: i32 = unsafe { bindings::get_unused_fd_flags(flags) };
@@ -413,6 +414,7 @@ pub fn reserved_fd(&self) -> u32 {
     ///
     /// The previously reserved file descriptor is bound to `file`. This method consumes the
     /// [`FileDescriptorReservation`], so it will not be usable after this call.
+    #[inline]
     pub fn fd_install(self, file: ARef<File>) {
         // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`. We have not yet used
         // the fd, so it is still valid, and `current` still refers to the same task, as this type
@@ -433,6 +435,7 @@ pub fn fd_install(self, file: ARef<File>) {
 }
 
 impl Drop for FileDescriptorReservation {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants of this type, `self.fd` was previously returned by
         // `get_unused_fd_flags`. We have not yet used the fd, so it is still valid, and `current`
-- 
2.43.0


