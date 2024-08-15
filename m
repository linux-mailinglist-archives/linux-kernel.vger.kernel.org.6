Return-Path: <linux-kernel+bounces-287632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08149952A29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22161F223E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6319D068;
	Thu, 15 Aug 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="Gn6fAWTu"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520621991AF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708191; cv=none; b=MyecVVsnYzNczYDbV65r9vynAVp/BHBX5JwG7gTd21w8desfXQV2PDecifn26Pfimqk3k9D+4q1wOTufezjzLceZNRaGi6DVJLn3XTdXB88VZWP+QeaNDB7bCZT5Bph9MmbiSpbqBHXMZHf2ZDgzGyEnj76zgHsZs6TsZrF4onE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708191; c=relaxed/simple;
	bh=J5y8uAimX4xtr2yE+uLu/aFPB+ejQEqX9bmDJAkAXiQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOG2L+d2ateHQwn7J9q6ilr7bcB2V8BhVxF3zxG1r0umORPtSwNMFl2qKQQRYsE+NTi0/0eJjQypZAGbpnmRNvgUS+N7Kkd/e0ym0Y/Ud/nQnPEdAdnK1hZTnHRgn76Gp29qu/vzTQXoDY0AAYh7ECTqK5GDIfay1sqo7JNFStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=Gn6fAWTu; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1723708187; x=1723967387;
	bh=tMjFdwYIY6C6jB1odGF7Z3jQj5z8jwdgu9RMhv9fvok=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Gn6fAWTuWn5k1JjallCtmi4z6szjz9LNdtgGbnQElbUsRGlClLQPiAuBs36UxNyct
	 18SFPrg0mgp11BXhJLfa9Zr5Ok/3Zzfy1an1d2RmM9OILRK/mpEETJwHTOF/Z35EFA
	 n1sXv5gl4pAdO0NIw+W2syh5/PCk73RQmj2CH+gglDxeEYn5vyZ1GdPhok6hFnx1aX
	 HXSh+UvSRnovW2W+7XGawx8/tsq7rhi9zI3knJMMINNfyRaUBibEkFZAwjv/lXdvWv
	 TmEotzHZMQe5tfyS0cKv0ejzNmj3Nka7Wg02IQzwDADjhsWXRALzNO8oMYdLUKq8p3
	 6b1zePNN/phKA==
Date: Thu, 15 Aug 2024 07:49:43 +0000
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: block: fix wrong usage of lockdep API
Message-ID: <20240815074519.2684107-3-nmi@metaspace.dk>
In-Reply-To: <20240815074519.2684107-1-nmi@metaspace.dk>
References: <20240815074519.2684107-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: a38f9a24aeb93474486611d5e3c90e014f6b1790
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Andreas Hindborg <a.hindborg@samsung.com>

When allocating `struct gendisk`, `GenDiskBuilder` is using a dynamic lock
class key without registering the key. This is incorrect use of the API,
which causes a `WARN` trace. This patch fixes the issue by using a static
lock class key, which is more appropriate for the situation anyway.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Reported-by: "Behme Dirk (XC-CP/ESB5)" <Dirk.Behme@de.bosch.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/=
topic/6.2E11.2E0-rc1.3A.20rust.2Fkernel.2Fblock.2Fmq.2Ers.3A.20doctest.20lo=
ck.20warning
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block/mq/gen_disk.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_di=
sk.rs
index f548a6199847..dbe560b09953 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -6,7 +6,7 @@
 //! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
=20
 use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
-use crate::error;
+use crate::{error, static_lock_class};
 use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
 use core::fmt::{self, Write};
=20
@@ -93,8 +93,6 @@ pub fn build<T: Operations>(
         name: fmt::Arguments<'_>,
         tagset: Arc<TagSet<T>>,
     ) -> Result<GenDisk<T>> {
-        let lock_class_key =3D crate::sync::LockClassKey::new();
-
         // SAFETY: `bindings::queue_limits` contain only fields that are v=
alid when zeroed.
         let mut lim: bindings::queue_limits =3D unsafe { core::mem::zeroed=
() };
=20
@@ -110,7 +108,7 @@ pub fn build<T: Operations>(
                 tagset.raw_tag_set(),
                 &mut lim,
                 core::ptr::null_mut(),
-                lock_class_key.as_ptr(),
+                static_lock_class!().as_ptr(),
             )
         })?;
=20
--=20
2.46.0




