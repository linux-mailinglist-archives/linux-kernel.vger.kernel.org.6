Return-Path: <linux-kernel+bounces-185047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2BE8CAFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01DB1F22F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006667F7DA;
	Tue, 21 May 2024 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="b7/anavp"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900ED77117
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300125; cv=none; b=MNmCkP9agfmmdPsS6WENQyv9yW8X4J/6H8DfBW+CnCOyklQv4hPCaEOiFCJduSOnu4MpUrgPEIuwIiqVOJ3qduptX+4PTgZy7Cfr7MzDp2VGXLeaGG+pT2bcMqAzbb2eRBWpr9aVT0k9hTsOIia4cjRCu9pUFGUpe9lnSI4+InI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300125; c=relaxed/simple;
	bh=9QGBZCzlqj+FFJ1Y45J9aRl9xBFDHF+jLJOxIIOwF/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPx2wnJxCaarOzm6SkapztJA77OHZnFxzFCz2lrjdJQheoTKFa0uHHTH/0K9GBv8OOGpDN9qu5Dm2T2qmO15dK1WE4DlxJIvwUJsnH1E0BsUt/Uk/WNIHmLPwvzwN7wUbOar91qeZbhJ3KKE7J7+jQADGngmSsfE1RqhDuPwYzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=b7/anavp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so5094540e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1716300121; x=1716904921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAOewCQLgwWz0kHK72YTOt1hH5xfEC+UYb1BKwQbRIw=;
        b=b7/anavpfp7Q0tFuZWojlZKauaWewyVnUTjuGCZfA4IC9IfQaKk8lcmFnGxrKwnrwe
         IU3IwKZnaIlMlamGF2AP55mRS6ZyAnKt2SFhWR8b3RRXjcXrsM0PZlH18uMCyBqTT4bI
         hSnxTC2XPQO3GDGErp6sVa6Ma1GWZTlOWEPl1hzz0mjw+DUVs8r+YjzmhT6juzBd9q8j
         phQMdPzcMwAYrBYRQkKSdDhibeHf8DaPmnWHroHENzep6VmCucOewoNlybKQvfPe1WIi
         F/54rCBzqhTr48nEdSovfHDjCyqoG/251/x6KKdDx3l4N7f/J1vRPBiKC3YHxZk0JfBi
         DDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300121; x=1716904921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAOewCQLgwWz0kHK72YTOt1hH5xfEC+UYb1BKwQbRIw=;
        b=QbGOqY4QRLVVNW8iA1eaDx7kvnvUfbL1LymCKevJY/IYtoIASaJH2VbPCR/Go5SN6B
         fdd1lC3jwefcz2MQK3Rv+7g2Rg31eFlvYkKWi8UfHg8DzxgrIr2iYZeUYmy6PZdkijXK
         veatXzSD3XFcpjYh+asJZ/LWvYrL0aKpCJTPpKPTSsGaLfdutFu36n1XXBhO1E97I2QN
         rmNRvEevIRWYJNtdbKorHx5TOP08E9KKIKnsLmKQTGy1sRqQmGHaE4xv4SKtA9RT/Tw4
         jOQxd08kN1ROsEhi+CNm8ejujny3xyLcUSTkXe/nxZBVvNLa3M7LLEi1Q3WnYK1LmkVT
         FuLA==
X-Forwarded-Encrypted: i=1; AJvYcCWfmIPUiQPKkHWXaXGrQrxguIbTsJV90Ho2GboYfimdHAobvJrvZWAHeKvrDOluWQww2X8tTO3tl+fj+LpIC7oJoOXLXBplABy+onOt
X-Gm-Message-State: AOJu0YzZpVgMxparVqHbCZvRbFBvMbnyz2cBHj30H1nZ48gX/nLSph4A
	Rkg7rAiEXvsYLvZNXOrZWuQmSLwW901P0zXYkc5bmu4ByXYtTJHqcRxycBaK6ac=
X-Google-Smtp-Source: AGHT+IFUIWPmXj9+GXNdRE2OUazzO4sAHN+7BfxwiRRlyfE6BJecl0lNxlnzU790wHUbIwpl/QBBzA==
X-Received: by 2002:a05:6512:3da1:b0:51f:1bf8:610c with SMTP id 2adb3069b0e04-5220fb77569mr26213481e87.11.1716300120353;
        Tue, 21 May 2024 07:02:00 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed72bbsm16630154a12.57.2024.05.21.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:01:59 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Conor Dooley <conor@kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	=?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [PATCH v2 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Tue, 21 May 2024 16:03:21 +0200
Message-ID: <20240521140323.2960069-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240521140323.2960069-1-nmi@metaspace.dk>
References: <20240521140323.2960069-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

This patch adds an initial version of the Rust null block driver.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/Kconfig   |  9 +++++
 drivers/block/Makefile  |  3 ++
 drivers/block/rnull.rs  | 86 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/block/mq.rs |  4 +-
 4 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 drivers/block/rnull.rs

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 5b9d4aaebb81..ed209f4f2798 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -354,6 +354,15 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config BLK_DEV_RUST_NULL
+	tristate "Rust null block driver (Experimental)"
+	depends on RUST
+	help
+	  This is the Rust implementation of the null block driver. For now it
+	  is only a minimal stub.
+
+	  If unsure, say N.
+
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 101612cba303..1105a2d4fdcb 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -9,6 +9,9 @@
 # needed for trace events
 ccflags-y				+= -I$(src)
 
+obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull_mod.o
+rnull_mod-y := rnull.o
+
 obj-$(CONFIG_MAC_FLOPPY)	+= swim3.o
 obj-$(CONFIG_BLK_DEV_SWIM)	+= swim_mod.o
 obj-$(CONFIG_BLK_DEV_FD)	+= floppy.o
diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
new file mode 100644
index 000000000000..1d6ab6f0f26f
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This is a Rust implementation of the C null block driver.
+//!
+//! Supported features:
+//!
+//! - blk-mq interface
+//! - direct completion
+//! - block size 4k
+//!
+//! The driver is not configurable.
+
+use kernel::{
+    alloc::flags,
+    block::mq::{
+        self,
+        gen_disk::{self, GenDisk},
+        Operations, TagSet,
+    },
+    error::Result,
+    new_mutex, pr_info,
+    prelude::*,
+    sync::{Arc, Mutex},
+    types::ARef,
+};
+
+module! {
+    type: NullBlkModule,
+    name: "rnull_mod",
+    author: "Andreas Hindborg",
+    license: "GPL v2",
+}
+
+struct NullBlkModule {
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice, gen_disk::Added>>>>,
+}
+
+fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice, gen_disk::Added>> {
+    let block_size: u16 = 4096;
+    if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
+        return Err(kernel::error::code::EINVAL);
+    }
+
+    let mut disk = gen_disk::try_new(tagset)?;
+    disk.set_name(format_args!("rnullb{}", 0))?;
+    disk.set_capacity_sectors(4096 << 11);
+    disk.set_queue_logical_block_size(block_size.into());
+    disk.set_queue_physical_block_size(block_size.into());
+    disk.set_rotational(false);
+    disk.add()
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
+        let disk = Box::pin_init(
+            new_mutex!(add_disk(tagset)?, "nullb:disk"),
+            flags::GFP_KERNEL,
+        )?;
+
+        Ok(Self { _disk: disk })
+    }
+}
+
+struct NullBlkDevice;
+
+#[vtable]
+impl Operations for NullBlkDevice {
+    #[inline(always)]
+    fn queue_rq(rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            .expect("Failed to complete request");
+
+        Ok(())
+    }
+
+    fn commit_rqs() {}
+
+    fn complete(rq: ARef<mq::Request<Self>>) {
+        mq::Request::end_ok(rq)
+            .map_err(|_e| kernel::error::code::EIO)
+            .expect("Failed to complete request")
+    }
+}
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index efbd2588791b..54e032bbdffd 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -51,6 +51,7 @@
 //!
 //! ```rust
 //! use kernel::{
+//!     alloc::flags,
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
@@ -77,7 +78,8 @@
 //!     }
 //! }
 //!
-//! let tagset: Arc<TagSet<MyBlkDevice>> = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
+//! let tagset: Arc<TagSet<MyBlkDevice>> =
+//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
 //! let mut disk = gen_disk::try_new(tagset)?;
 //! disk.set_name(format_args!("myblk"))?;
 //! disk.set_capacity_sectors(4096);
-- 
2.44.0


