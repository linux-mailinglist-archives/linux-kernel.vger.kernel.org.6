Return-Path: <linux-kernel+bounces-197875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC58D7045
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D693B1C21CAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0581527AF;
	Sat,  1 Jun 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="qJVwFBJd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF82150985
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249237; cv=none; b=Tyyim1Wm3stLodUcMefmiZ+yWHAVfh7r0GZJ1lLPyNyRrdS9xkuTqrhECA7NAas5CxuXDLUJT0WZy2qbhPMOPbFKh3ssX33iWyblJcFHbXVWzTkljofFoemYwrFRF1g+F3YPbJWIKK73C4nhfv7vjFG/3ryhyOtFPSM+PdA+nOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249237; c=relaxed/simple;
	bh=IafjrFIt4e+Rs2t/YGsbIMt1KKtcWDUTwcCCT89NPBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F06xoeHvqTS8xAYBwbRTr+asW9PMn55Bj4UUUEe/0ZK5LgKonpkPWHc1lN6IBTvXVRWkoh7hAJ2NPYZvgvEpe9IG5x5yPdFk/sC8EWUZG4zLa/sWK6FP/zvK3knV8Nx7BlaLLwUsz/WuRa8wVywBfcksKrMkzJzYSLntkmCFbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=qJVwFBJd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6858bdc9ddso176424366b.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717249231; x=1717854031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckk82n9/fOsLEfKD2pNy3Djio50D8zT2LskYDn+7aBE=;
        b=qJVwFBJd2lJzFCi73VOPV5S9M2gEaCoEuSZvdo1qhaXPaKB7XJZixHFiCVSSWRaet0
         w3qdtib14YyXl4hQ3hCtNvnd8oFmdTgBwG5m73na9JIzJEvKsKlTwrXL/GQPJ9RoGY/F
         IlIHFht3AR9ml2V7wsHTueDnO3Y1Iwc1EcMq1ZgkkEgM4Mhe5Zf0R1VtPlUOkI4jNxeS
         fX5T0EtdNRlFqig+5KVNNkcLbvuhoh95Z5yC8pQI7CbVaVUIO2xaYFFWZfiCmGp5FE/9
         kMKp/JibOzSwc40Km67Pl1SRN364WZvVj4Nf/0D0Zu5NpmJmwmIJLPP0ARQMNQyvnl3k
         2alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249231; x=1717854031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckk82n9/fOsLEfKD2pNy3Djio50D8zT2LskYDn+7aBE=;
        b=MORFYwya7DnrXTbSQ8wzpf4mJIeFjEAhrV5bwfso8InZoaez3xI1yTcIawf7/l0aj5
         v3YBf9FdBvkHzHKHtNOUeQ5kg7y7QttX4zX6DzpSsE8/7eq92JYCPNfd86SGEk1Rnjx9
         fhmvDAEg0GT/i1xGG2MEN8ycXXKbO0FBsIlTEly1sSJhnBq7piVwok3/hPu6YDyE+Trm
         xks2+pUinyGb/VTmasu/LfxIzxiySKG5ZjHZTbDp6h3WtbwCFno2KepZRtGe7wRX941C
         lzGRDpxLQO2AHvq8m4rH9/ksOY3c4rqbihUGCGBcyjDvf7n8Mz1YdELBKWByA3knhnDY
         BRfA==
X-Forwarded-Encrypted: i=1; AJvYcCXv1G65BKWcfWNt0aK35CCBLivm6UjF3YtY8J5+gZ74QEVR6FvD3m2BT7GRHeTaTe8j/mwTGhWDGTS98vPvk60Tc/X3kBBRfsJZTSvR
X-Gm-Message-State: AOJu0YxeCyN7A0x+77rBponu4aJvChJmVkARzMyIgIDUq3iklj2ZCd5L
	S6EECzwUWvi9WHTZSW7XdHPAv/cYfzQkGCxted4haVitptjdkaLhuhJNJmcM0iE=
X-Google-Smtp-Source: AGHT+IEXf4UbjFRi7hnJqlKiB4zsUY/RMqXsZMgjpMwSBS+WyKG279amVXvRL6I5vX9ovY7TCl7uug==
X-Received: by 2002:a17:906:43d5:b0:a66:e009:eb5b with SMTP id a640c23a62f3a-a6821982899mr318522066b.52.1717249230079;
        Sat, 01 Jun 2024 06:40:30 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a53d38bdsm97471766b.172.2024.06.01.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:40:29 -0700 (PDT)
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
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: [PATCH v4 1/3] rust: block: introduce `kernel::block::mq` module
Date: Sat,  1 Jun 2024 15:40:03 +0200
Message-ID: <20240601134005.621714-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240601134005.621714-1-nmi@metaspace.dk>
References: <20240601134005.621714-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Add initial abstractions for working with blk-mq.

This patch is a maintained, refactored subset of code originally published
by Wedson Almeida Filho <wedsonaf@gmail.com> [1].

[1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs

Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  97 ++++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 222 ++++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 233 ++++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 241 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  85 ++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 11 files changed, 964 insertions(+)
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..68f937f8374f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,8 @@
  */
 
 #include <kunit/test.h>
+#include <linux/blk_types.h>
+#include <linux/blk-mq.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/jiffies.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..3df5217fb2ff 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -186,3 +186,19 @@ static_assert(
 	__alignof__(size_t) == __alignof__(uintptr_t),
 	"Rust code expects C `size_t` to match Rust `usize`"
 );
+
+// This will soon be moved to a separate file, so no need to merge with above.
+#include <linux/blk-mq.h>
+#include <linux/blkdev.h>
+
+void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
+{
+	return blk_mq_rq_to_pdu(rq);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_to_pdu);
+
+struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
+{
+	return blk_mq_rq_from_pdu(pdu);
+}
+EXPORT_SYMBOL_GPL(rust_helper_blk_mq_rq_from_pdu);
diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
new file mode 100644
index 000000000000..150f710efe5b
--- /dev/null
+++ b/rust/kernel/block.rs
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types for working with the block layer.
+
+pub mod mq;
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
new file mode 100644
index 000000000000..e6268d6d7f92
--- /dev/null
+++ b/rust/kernel/block/mq.rs
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides types for implementing block drivers that interface the
+//! blk-mq subsystem.
+//!
+//! To implement a block device driver, a Rust module must do the following:
+//!
+//! - Implement [`Operations`] for a type `T`
+//! - Create a [`TagSet<T>`]
+//! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
+//! - Add the disk to the system by calling [`GenDisk::add`]
+//!
+//! The types available in this module that have direct C counterparts are:
+//!
+//! - The [`TagSet`] type that abstracts the C type `struct tag_set`.
+//! - The [`GenDisk`] type that abstracts the C type `struct gendisk`.
+//! - The [`Request`] type that abstracts the C type `struct request`.
+//!
+//! The kernel will interface with the block device driver by calling the method
+//! implementations of the `Operations` trait.
+//!
+//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
+//! instances. The `Request` type is a wrapper around the C `struct request`.
+//! The driver must mark end of processing by calling one of the
+//! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
+//! errors. Please note that the C function `blk_mq_start_request` is implicitly
+//! called when the request is queued with the driver.
+//!
+//! The `TagSet` is responsible for creating and maintaining a mapping between
+//! `Request`s and integer ids as well as carrying a pointer to the vtable
+//! generated by `Operations`. This mapping is useful for associating
+//! completions from hardware with the correct `Request` instance. The `TagSet`
+//! determines the maximum queue depth by setting the number of `Request`
+//! instances available to the driver, and it determines the number of queues to
+//! instantiate for the driver. If possible, a driver should allocate one queue
+//! per core, to keep queue data local to a core.
+//!
+//! One `TagSet` instance can be shared between multiple `GenDisk` instances.
+//! This can be useful when implementing drivers where one piece of hardware
+//! with one set of IO resources are represented to the user as multiple disks.
+//!
+//! One significant difference between block device drivers implemented with
+//! these Rust abstractions and drivers implemented in C, is that the Rust
+//! drivers have to own a reference count on the `Request` type when the IO is
+//! in flight. This is to ensure that the C `struct request` instances backing
+//! the Rust `Request` instances are live while the Rust driver holds a
+//! reference to the `Request`. In addition, the conversion of an integer tag to
+//! a `Request` via the `TagSet` would not be sound without this bookkeeping.
+//!
+//! [`GenDisk`]: gen_disk::GenDisk
+//! [`GenDisk<T>`]: gen_disk::GenDisk
+//! [`GenDisk::add`]: gen_disk::GenDisk::add
+//!
+//! # Example
+//!
+//! ```rust
+//! use kernel::{
+//!     alloc::flags,
+//!     block::mq::*,
+//!     new_mutex,
+//!     prelude::*,
+//!     sync::{Arc, Mutex},
+//!     types::{ARef, ForeignOwnable},
+//! };
+//!
+//! struct MyBlkDevice;
+//!
+//! #[vtable]
+//! impl Operations for MyBlkDevice {
+//!
+//!     fn queue_rq(rq: ARef<Request<Self>>, _is_last: bool) -> Result {
+//!         Request::end_ok(rq);
+//!         Ok(())
+//!     }
+//!
+//!     fn commit_rqs() {}
+//! }
+//!
+//! let tagset: Arc<TagSet<MyBlkDevice>> =
+//!     Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
+//! let mut disk = gen_disk::GenDisk::try_new(tagset)?;
+//! disk.set_name(format_args!("myblk"))?;
+//! disk.set_capacity_sectors(4096);
+//! disk.add()?;
+//!
+//! # Ok::<(), kernel::error::Error>(())
+//! ```
+
+pub mod gen_disk;
+mod operations;
+mod raw_writer;
+mod request;
+mod tag_set;
+
+pub use operations::Operations;
+pub use request::Request;
+pub use tag_set::TagSet;
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
new file mode 100644
index 000000000000..480b1fb76352
--- /dev/null
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Generic disk abstraction.
+//!
+//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
+//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
+
+use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
+use crate::{bindings, error::from_err_ptr, error::Result, sync::Arc};
+use core::fmt::{self, Write};
+use core::marker::PhantomData;
+
+/// A generic block device.
+///
+/// # Invariants
+///
+///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
+pub struct GenDisk<T: Operations, S: GenDiskState = Added> {
+    tagset: Arc<TagSet<T>>,
+    gendisk: *mut bindings::gendisk,
+    _phantom: core::marker::PhantomData<S>,
+}
+
+// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `Arc` to a
+// `TagSet` It is safe to send this to other threads as long as T is Send.
+unsafe impl<T: Operations + Send, S: GenDiskState> Send for GenDisk<T, S> {}
+
+/// Disks in this state are allocated and initialized, but are not yet
+/// accessible from the kernel VFS.
+pub enum Initialized {}
+
+/// Disks in this state have been attached to the kernel VFS and may receive IO
+/// requests.
+pub enum Added {}
+
+mod seal {
+    pub trait Sealed {}
+}
+
+/// Typestate representing states of a `GenDisk`.
+///
+/// This trait cannot be implemented by downstream crates.
+pub trait GenDiskState: seal::Sealed {
+    /// Set to true if [`GenDisk`] should call `del_gendisk` on drop.
+    const DELETE_ON_DROP: bool;
+}
+
+impl seal::Sealed for Initialized {}
+impl GenDiskState for Initialized {
+    const DELETE_ON_DROP: bool = false;
+}
+impl seal::Sealed for Added {}
+impl GenDiskState for Added {
+    const DELETE_ON_DROP: bool = true;
+}
+
+impl<T: Operations> GenDisk<T, Initialized> {
+    /// Try to create a new `GenDisk`.
+    pub fn try_new(tagset: Arc<TagSet<T>>) -> Result<Self> {
+        let lock_class_key = crate::sync::LockClassKey::new();
+
+        // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
+        let gendisk = from_err_ptr(unsafe {
+            bindings::__blk_mq_alloc_disk(
+                tagset.raw_tag_set(),
+                core::ptr::null_mut(), // TODO: We can pass queue limits right here
+                core::ptr::null_mut(),
+                lock_class_key.as_ptr(),
+            )
+        })?;
+
+        const TABLE: bindings::block_device_operations = bindings::block_device_operations {
+            submit_bio: None,
+            open: None,
+            release: None,
+            ioctl: None,
+            compat_ioctl: None,
+            check_events: None,
+            unlock_native_capacity: None,
+            getgeo: None,
+            set_read_only: None,
+            swap_slot_free_notify: None,
+            report_zones: None,
+            devnode: None,
+            alternative_gpt_sector: None,
+            get_unique_id: None,
+            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_static feature to
+            // be merged (unstable in rustc 1.78 which is staged for linux 6.10)
+            // https://github.com/rust-lang/rust/issues/119618
+            owner: core::ptr::null_mut(),
+            pr_ops: core::ptr::null_mut(),
+            free_disk: None,
+            poll_bio: None,
+        };
+
+        // SAFETY: gendisk is a valid pointer as we initialized it above
+        unsafe { (*gendisk).fops = &TABLE };
+
+        // INVARIANT: `gendisk` was initialized above.
+        // INVARIANT: `gendisk.queue.queue_data` is set to `data` in the call to
+        // `__blk_mq_alloc_disk` above.
+        Ok(GenDisk {
+            tagset,
+            gendisk,
+            _phantom: PhantomData,
+        })
+    }
+
+    /// Register the device with the kernel. When this function returns, the
+    /// device is accessible from VFS. The kernel may issue reads to the device
+    /// during registration to discover partition information.
+    pub fn add(self) -> Result<GenDisk<T, Added>> {
+        crate::error::to_result(
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe {
+                bindings::device_add_disk(
+                    core::ptr::null_mut(),
+                    self.gendisk,
+                    core::ptr::null_mut(),
+                )
+            },
+        )?;
+
+        // We don't want to run the destuctor and remove the device from the VFS
+        // when `disk` is dropped.
+        let mut old = core::mem::ManuallyDrop::new(self);
+
+        let new = GenDisk {
+            tagset: old.tagset.clone(),
+            gendisk: old.gendisk,
+            _phantom: PhantomData,
+        };
+
+        // But we have to drop the `Arc` or it will leak.
+        // SAFETY: `old._tagset` is valid for write, aligned, non-null, and we
+        // have exclusive access. We are not accessing the value again after it
+        // is dropped.
+        unsafe { core::ptr::drop_in_place(&mut old.tagset) };
+
+        Ok(new)
+    }
+
+    /// Set the name of the device.
+    pub fn set_name(&mut self, args: fmt::Arguments<'_>) -> Result {
+        let mut raw_writer = RawWriter::from_array(
+            // SAFETY: By type invariant `self.gendisk` points to a valid and
+            // initialized instance. We have exclusive access, since the disk is
+            // not added to the VFS yet.
+            unsafe { &mut (*self.gendisk).disk_name },
+        )?;
+        raw_writer.write_fmt(args)?;
+        raw_writer.write_char('\0')?;
+        Ok(())
+    }
+
+    /// Set the logical block size of the device.
+    ///
+    /// This is the smallest unit the storage device can address. It is
+    /// typically 4096 bytes.
+    pub fn set_queue_logical_block_size(&mut self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`.
+        unsafe { bindings::blk_queue_logical_block_size((*self.gendisk).queue, size) };
+    }
+
+    /// Set the physical block size of the device.
+    ///
+    /// This is the smallest unit a physical storage device can write
+    /// atomically. It is usually the same as the logical block size but may be
+    /// bigger. One example is SATA drives with 4096 byte physical block size
+    /// that expose a 512 byte logical block size to the operating system.
+    pub fn set_queue_physical_block_size(&mut self, size: u32) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`.
+        unsafe { bindings::blk_queue_physical_block_size((*self.gendisk).queue, size) };
+    }
+}
+
+impl<T: Operations, S: GenDiskState> GenDisk<T, S> {
+    /// Call to tell the block layer the capacity of the device in sectors (512
+    /// bytes).
+    pub fn set_capacity_sectors(&self, sectors: u64) {
+        // SAFETY: By type invariant, `self.gendisk` points to a valid and
+        // initialized instance of `struct gendisk`. `set_capacity` takes a lock
+        // to synchronize this operation, so we will not race.
+        unsafe { bindings::set_capacity(self.gendisk, sectors) };
+    }
+
+    /// Set the rotational media attribute for the device.
+    pub fn set_rotational(&self, rotational: bool) {
+        if !rotational {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`. This operation uses a
+            // relaxed atomic bit flip operation, so there is no race on this
+            // field.
+            unsafe {
+                bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        } else {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`. This operation uses a
+            // relaxed atomic bit flip operation, so there is no race on this
+            // field.
+            unsafe {
+                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*self.gendisk).queue)
+            };
+        }
+    }
+}
+
+impl<T: Operations, S: GenDiskState> Drop for GenDisk<T, S> {
+    fn drop(&mut self) {
+        // We should not call `del_gendisk` if the gendis was not already added
+        // (it will WARN).
+        if <S as GenDiskState>::DELETE_ON_DROP {
+            // SAFETY: By type invariant, `self.gendisk` points to a valid and
+            // initialized instance of `struct gendisk`
+            unsafe { bindings::del_gendisk(self.gendisk) };
+        }
+    }
+}
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
new file mode 100644
index 000000000000..e6288df60c01
--- /dev/null
+++ b/rust/kernel/block/mq/operations.rs
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides an interface for blk-mq drivers to implement.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::request::RequestDataWrapper,
+    block::mq::Request,
+    error::{from_result, Result},
+    types::ARef,
+};
+use core::{marker::PhantomData, sync::atomic::AtomicU64, sync::atomic::Ordering};
+
+/// Implement this trait to interface blk-mq as block devices.
+///
+/// To implement a block device driver, implement this trait as described in the
+/// [module level documentation]. The kernel will use the implementation of the
+/// functions defined in this trait to interface a block device driver. Note:
+/// There is no need for an exit_request() implementation, because the `drop`
+/// implementation of the [`Request`] type will be invoked by automatically by
+/// the C/Rust glue logic.
+///
+/// [module level documentation]: kernel::block::mq
+#[macros::vtable]
+pub trait Operations: Sized {
+    /// Called by the kernel to queue a request with the driver. If `is_last` is
+    /// `false`, the driver is allowed to defer committing the request.
+    fn queue_rq(rq: ARef<Request<Self>>, is_last: bool) -> Result;
+
+    /// Called by the kernel to indicate that queued requests should be submitted.
+    fn commit_rqs();
+
+    /// Called by the kernel to poll the device for completed requests. Only
+    /// used for poll queues.
+    fn poll() -> bool {
+        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// A vtable for blk-mq to interact with a block device driver.
+///
+/// A `bindings::blk_mq_opa` vtable is constructed from pointers to the `extern
+/// "C"` functions of this struct, exposed through the `OperationsVTable::VTABLE`.
+///
+/// For general documentation of these methods, see the kernel source
+/// documentation related to `struct blk_mq_operations` in
+/// [`include/linux/blk-mq.h`].
+///
+/// [`include/linux/blk-mq.h`]: srctree/include/linux/blk-mq.h
+pub(crate) struct OperationsVTable<T: Operations>(PhantomData<T>);
+
+impl<T: Operations> OperationsVTable<T> {
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// - The caller of this function must ensure `bd` is valid
+    ///   and initialized. The pointees must outlive this function.
+    /// - This function must not be called with a `hctx` for which
+    ///   `Self::exit_hctx_callback()` has been called.
+    /// - (*bd).rq must point to a valid `bindings:request` for which
+    ///   `OperationsVTable<T>::init_request_callback` was called
+    unsafe extern "C" fn queue_rq_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        bd: *const bindings::blk_mq_queue_data,
+    ) -> bindings::blk_status_t {
+        // SAFETY: `bd.rq` is valid as required by the safety requirement for
+        // this function.
+        let request = unsafe { &*(*bd).rq.cast::<Request<T>>() };
+
+        // One refcount for the ARef, one for being in flight
+        request.wrapper_ref().refcount().store(2, Ordering::Relaxed);
+
+        // SAFETY: We own a refcount that we took above. We pass that to `ARef`.
+        // By the safety requirements of this function, `request` is a valid
+        // `struct request` and the private data is properly initialized.
+        let rq = unsafe { Request::aref_from_raw((*bd).rq) };
+
+        // SAFETY: We have exclusive access and we just set the refcount above.
+        unsafe { Request::start_unchecked(&rq) };
+
+        let ret = T::queue_rq(
+            rq,
+            // SAFETY: `bd` is valid as required by the safety requirement for this function.
+            unsafe { (*bd).last },
+        );
+
+        if let Err(e) = ret {
+            e.to_blk_status()
+        } else {
+            bindings::BLK_STS_OK as _
+        }
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn commit_rqs_callback(_hctx: *mut bindings::blk_mq_hw_ctx) {
+        T::commit_rqs()
+    }
+
+    /// This function is called by the C kernel. It is not currently
+    /// implemented, and there is no way to exercise this code path.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn complete_callback(_rq: *mut bindings::request) {}
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn poll_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _iob: *mut bindings::io_comp_batch,
+    ) -> core::ffi::c_int {
+        T::poll().into()
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. This
+    /// function may only be called onece before `exit_hctx_callback` is called
+    /// for the same context.
+    unsafe extern "C" fn init_hctx_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _tagset_data: *mut core::ffi::c_void,
+        _hctx_idx: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| Ok(0))
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure.
+    unsafe extern "C" fn exit_hctx_callback(
+        _hctx: *mut bindings::blk_mq_hw_ctx,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `set` must
+    /// point to an initialized `TagSet<T>`.
+    unsafe extern "C" fn init_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+        _numa_node: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The `blk_mq_tag_set` invariants guarantee that all
+            // requests are allocated with extra memory for the request data.
+            let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper>();
+
+            // SAFETY: The refcount field is allocated but not initialized, this
+            // valid for write.
+            unsafe { RequestDataWrapper::refcount_ptr(pdu).write(AtomicU64::new(0)) };
+
+            Ok(0)
+        })
+    }
+
+    /// This function is called by the C kernel. A pointer to this function is
+    /// installed in the `blk_mq_ops` vtable for the driver.
+    ///
+    /// # Safety
+    ///
+    /// This function may only be called by blk-mq C infrastructure. `rq` must
+    /// point to a request that was initialized by a call to
+    /// `Self::init_request_callback`.
+    unsafe extern "C" fn exit_request_callback(
+        _set: *mut bindings::blk_mq_tag_set,
+        rq: *mut bindings::request,
+        _hctx_idx: core::ffi::c_uint,
+    ) {
+        // SAFETY: The tagset invariants guarantee that all requests are allocated with extra memory
+        // for the request data.
+        let pdu = unsafe { bindings::blk_mq_rq_to_pdu(rq) }.cast::<RequestDataWrapper>();
+
+        // SAFETY: `pdu` is valid for read and write and is properly initialised.
+        unsafe { core::ptr::drop_in_place(pdu) };
+    }
+
+    const VTABLE: bindings::blk_mq_ops = bindings::blk_mq_ops {
+        queue_rq: Some(Self::queue_rq_callback),
+        queue_rqs: None,
+        commit_rqs: Some(Self::commit_rqs_callback),
+        get_budget: None,
+        put_budget: None,
+        set_rq_budget_token: None,
+        get_rq_budget_token: None,
+        timeout: None,
+        poll: if T::HAS_POLL {
+            Some(Self::poll_callback)
+        } else {
+            None
+        },
+        complete: Some(Self::complete_callback),
+        init_hctx: Some(Self::init_hctx_callback),
+        exit_hctx: Some(Self::exit_hctx_callback),
+        init_request: Some(Self::init_request_callback),
+        exit_request: Some(Self::exit_request_callback),
+        cleanup_rq: None,
+        busy: None,
+        map_queues: None,
+        #[cfg(CONFIG_BLK_DEBUG_FS)]
+        show_rq: None,
+    };
+
+    pub(crate) const fn build() -> &'static bindings::blk_mq_ops {
+        &Self::VTABLE
+    }
+}
diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/raw_writer.rs
new file mode 100644
index 000000000000..9222465d670b
--- /dev/null
+++ b/rust/kernel/block/mq/raw_writer.rs
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::fmt::{self, Write};
+
+use crate::error::Result;
+use crate::prelude::EINVAL;
+
+/// A mutable reference to a byte buffer where a string can be written into.
+///
+/// # Invariants
+///
+/// `buffer` is always null terminated.
+pub(crate) struct RawWriter<'a> {
+    buffer: &'a mut [u8],
+    pos: usize,
+}
+
+impl<'a> RawWriter<'a> {
+    /// Create a new `RawWriter` instance.
+    fn new(buffer: &'a mut [u8]) -> Result<RawWriter<'a>> {
+        *(buffer.last_mut().ok_or(EINVAL)?) = 0;
+
+        // INVARIANT: We null terminated the buffer above.
+        Ok(Self { buffer, pos: 0 })
+    }
+
+    pub(crate) fn from_array<const N: usize>(
+        a: &'a mut [core::ffi::c_char; N],
+    ) -> Result<RawWriter<'a>> {
+        Self::new(
+            // SAFETY: the buffer of `a` is valid for read and write as `u8` for
+            // at least `N` bytes.
+            unsafe { core::slice::from_raw_parts_mut(a.as_mut_ptr().cast::<u8>(), N) },
+        )
+    }
+}
+
+impl Write for RawWriter<'_> {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        let bytes = s.as_bytes();
+        let len = bytes.len();
+
+        // We do not want to overwrite our null terminator
+        if self.pos + len > self.buffer.len() - 1 {
+            return Err(fmt::Error);
+        }
+
+        // INVARIANT: We are not overwriting the last byte
+        self.buffer[self.pos..self.pos + len].copy_from_slice(bytes);
+
+        self.pos += len;
+
+        Ok(())
+    }
+}
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
new file mode 100644
index 000000000000..0dee7d0d7a14
--- /dev/null
+++ b/rust/kernel/block/mq/request.rs
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides a wrapper for the C `struct request` type.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use crate::{
+    bindings,
+    block::mq::Operations,
+    error::Result,
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::{
+    marker::PhantomData,
+    ptr::{addr_of_mut, NonNull},
+    sync::atomic::{AtomicU64, Ordering},
+};
+
+/// A wrapper around a blk-mq `struct request`. This represents an IO request.
+///
+/// # Implementation details
+///
+/// There are four states for a request that the Rust bindings care about:
+///
+/// A) Request is owned by block layer (refcount 0)
+/// B) Request is owned by driver but with zero `ARef`s in existence
+///    (refcount 1)
+/// C) Request is owned by driver with exactly one `ARef` in existence
+///    (refcount 2)
+/// D) Request is owned by driver with more than one `ARef` in existence
+///    (refcount > 2)
+///
+///
+/// We need to track A and B to ensure we fail tag to request conversions for
+/// requests that are not owned by the driver.
+///
+/// We need to track C and D to ensure that it is safe to end the request and hand
+/// back ownership to the block layer.
+///
+/// The states are tracked through the private `refcount` field of
+/// `RequestDataWrapper`. This structure lives in the private data area of the C
+/// `struct request`.
+///
+/// # Invariants
+///
+/// * `self.0` is a valid `struct request` created by the C portion of the kernel.
+/// * The private data area associated with this request must be an initialized
+///   and valid `RequestDataWrapper<T>`.
+/// * `self` is reference counted by atomic modification of
+///   self.wrapper_ref().refcount().
+///
+#[repr(transparent)]
+pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData<T>);
+
+impl<T: Operations> Request<T> {
+    /// Create an `ARef<Request>` from a `struct request` pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must own a refcount on `ptr` that is transferred to the
+    ///   returned `ARef`.
+    /// * The type invariants for `Request` must hold for the pointee of `ptr`.
+    pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
+        // INVARIANT: By the safety requirements of this function, invariants are upheld.
+        // SAFETY: By the safety requirement of this function, we own a
+        // reference count that we can pass to `ARef`.
+        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Self as *mut Self)) }
+    }
+
+    /// Notify the block layer that a request is going to be processed now.
+    ///
+    /// The block layer uses this hook to do proper initializations such as
+    /// starting the timeout timer. It is a requirement that block device
+    /// drivers call this function when starting to process a request.
+    ///
+    /// # Safety
+    ///
+    /// The caller must have exclusive ownership of `self`, that is
+    /// `self.wrapper_ref().refcount() == 2`.
+    pub(crate) unsafe fn start_unchecked(this: &ARef<Self>) {
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_start_request(this.0.get()) };
+    }
+
+    fn try_set_end(this: ARef<Self>) -> Result<ARef<Self>, ARef<Self>> {
+        // We can race with `TagSet::tag_to_rq`
+        match this.wrapper_ref().refcount().compare_exchange(
+            2,
+            0,
+            Ordering::Relaxed,
+            Ordering::Relaxed,
+        ) {
+            Err(_old) => Err(this),
+            Ok(_) => Ok(this),
+        }
+    }
+
+    /// Notify the block layer that the request has been completed without errors.
+    ///
+    /// This function will return `Err` if `this` is not the only `ARef`
+    /// referencing the request.
+    pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
+        let this = Self::try_set_end(this)?;
+        let request_ptr = this.0.get();
+        core::mem::forget(this);
+
+        // SAFETY: By type invariant, `self.0` is a valid `struct request`. By
+        // existence of `&mut self` we have exclusive access.
+        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as _) };
+
+        Ok(())
+    }
+
+    /// Return a pointer to the `RequestDataWrapper` stored in the private area
+    /// of the request structure.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must point to a valid allocation.
+    pub(crate) unsafe fn wrapper_ptr(this: *mut Self) -> NonNull<RequestDataWrapper> {
+        let request_ptr = this.cast::<bindings::request>();
+        let wrapper_ptr =
+            // SAFETY: By safety requirements for this function, `this` is a
+            // valid allocation.
+            unsafe { bindings::blk_mq_rq_to_pdu(request_ptr).cast::<RequestDataWrapper>() };
+        // SAFETY: By C api contract, wrapper_ptr points to a valid allocation
+        // and is not null.
+        unsafe { NonNull::new_unchecked(wrapper_ptr) }
+    }
+
+    /// Return a reference to the `RequestDataWrapper` stored in the private
+    /// area of the request structure.
+    pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
+        // SAFETY: By type invariant, `self.0` is a valid alocation. Further,
+        // the private data associated with this request is initialized and
+        // valid. The existence of `&self` guarantees that the private data is
+        // valid as a shared reference.
+        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
+    }
+}
+
+/// A wrapper around data stored in the private area of the C `struct request`.
+pub(crate) struct RequestDataWrapper {
+    /// The Rust request refcount has the following states:
+    ///
+    /// - 0: The request is owned by C block layer.
+    /// - 1: The request is owned by Rust abstractions but there are no ARef references to it.
+    /// - 2+: There are `ARef` references to the request.
+    refcount: AtomicU64,
+}
+
+impl RequestDataWrapper {
+    /// Return a reference to the refcount of the request that is embedding
+    /// `self`.
+    pub(crate) fn refcount(&self) -> &AtomicU64 {
+        &self.refcount
+    }
+
+    /// Return a pointer to the refcount of the request that is embedding the
+    /// pointee of `this`.
+    ///
+    /// # Safety
+    ///
+    /// - `this` must point to a live allocation of at least the size of `Self`.
+    pub(crate) unsafe fn refcount_ptr(this: *mut Self) -> *mut AtomicU64 {
+        // SAFETY: Because of the safety requirements of this function, the
+        // field projection is safe.
+        unsafe { addr_of_mut!((*this).refcount) }
+    }
+}
+
+// SAFETY: Exclusive access is thread-safe for `Request`. `Request` has no `&mut
+// self` methods and `&self` methods that mutate `self` are internally
+// synchronzied.
+unsafe impl<T: Operations> Send for Request<T> {}
+
+// SAFETY: Shared access is thread-safe for `Request`. `&self` methods that
+// mutate `self` are internally synchronized`
+unsafe impl<T: Operations> Sync for Request<T> {}
+
+/// Store the result of `op(target.load())` in target, returning new value of
+/// taret.
+fn atomic_relaxed_op_return(target: &AtomicU64, op: impl Fn(u64) -> u64) -> u64 {
+    let old = target.fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| Some(op(x)));
+
+    // SAFETY: Because the operation passed to `fetch_update` above always
+    // return `Some`, `old` will always be `Ok`.
+    let old = unsafe { old.unwrap_unchecked() };
+
+    op(old)
+}
+
+/// Store the result of `op(target.load)` in `target` if `target.load() !=
+/// pred`, returning true if the target was updated.
+fn atomic_relaxed_op_unless(target: &AtomicU64, op: impl Fn(u64) -> u64, pred: u64) -> bool {
+    target
+        .fetch_update(Ordering::Relaxed, Ordering::Relaxed, |x| {
+            if x == pred {
+                None
+            } else {
+                Some(op(x))
+            }
+        })
+        .is_ok()
+}
+
+// SAFETY: All instances of `Request<T>` are reference counted. This
+// implementation of `AlwaysRefCounted` ensure that increments to the ref count
+// keeps the object alive in memory at least until a matching reference count
+// decrement is executed.
+unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
+    fn inc_ref(&self) {
+        let refcount = &self.wrapper_ref().refcount();
+
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let updated = atomic_relaxed_op_unless(refcount, |x| x + 1, 0);
+
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if !updated {
+            panic!("Request refcount zero on clone")
+        }
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: The type invariants of `ARef` guarantee that `obj` is valid
+        // for read.
+        let wrapper_ptr = unsafe { Self::wrapper_ptr(obj.as_ptr()).as_ptr() };
+        // SAFETY: The type invariant of `Request` guarantees that the private
+        // data area is initialized and valid.
+        let refcount = unsafe { &*RequestDataWrapper::refcount_ptr(wrapper_ptr) };
+
+        #[cfg_attr(not(CONFIG_DEBUG_MISC), allow(unused_variables))]
+        let new_refcount = atomic_relaxed_op_return(refcount, |x| x - 1);
+
+        #[cfg(CONFIG_DEBUG_MISC)]
+        if new_refcount == 0 {
+            panic!("Request reached refcount zero in Rust abstractions");
+        }
+    }
+}
diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_set.rs
new file mode 100644
index 000000000000..1217f6594d7b
--- /dev/null
+++ b/rust/kernel/block/mq/tag_set.rs
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module provides the `TagSet` struct to wrap the C `struct blk_mq_tag_set`.
+//!
+//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
+
+use core::pin::Pin;
+
+use crate::{
+    bindings,
+    block::mq::{operations::OperationsVTable, request::RequestDataWrapper, Operations},
+    error,
+    prelude::PinInit,
+    try_pin_init,
+    types::Opaque,
+};
+use core::{convert::TryInto, marker::PhantomData};
+use macros::{pin_data, pinned_drop};
+
+/// A wrapper for the C `struct blk_mq_tag_set`.
+///
+/// `struct blk_mq_tag_set` contains a `struct list_head` and so must be pinned.
+///
+/// # Invariants
+///
+/// - `inner` is initialized and valid.
+#[pin_data(PinnedDrop)]
+#[repr(transparent)]
+pub struct TagSet<T: Operations> {
+    #[pin]
+    inner: Opaque<bindings::blk_mq_tag_set>,
+    _p: PhantomData<T>,
+}
+
+impl<T: Operations> TagSet<T> {
+    /// Try to create a new tag set
+    pub fn try_new(
+        nr_hw_queues: u32,
+        num_tags: u32,
+        num_maps: u32,
+    ) -> impl PinInit<Self, error::Error> {
+        // SAFETY: `blk_mq_tag_set` only contains integers and pointers, which all are allowed to be 0.
+        let tag_set: bindings::blk_mq_tag_set = unsafe { core::mem::zeroed() };
+        let tag_set = core::mem::size_of::<RequestDataWrapper>()
+            .try_into()
+            .map(|cmd_size| {
+                bindings::blk_mq_tag_set {
+                    ops: OperationsVTable::<T>::build(),
+                    nr_hw_queues,
+                    timeout: 0, // 0 means default which is 30Hz in C
+                    numa_node: bindings::NUMA_NO_NODE,
+                    queue_depth: num_tags,
+                    cmd_size,
+                    flags: bindings::BLK_MQ_F_SHOULD_MERGE,
+                    driver_data: core::ptr::null_mut::<core::ffi::c_void>(),
+                    nr_maps: num_maps,
+                    ..tag_set
+                }
+            });
+
+        try_pin_init!(TagSet {
+            inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set?), |tag_set| {
+                // SAFETY: we do not move out of `tag_set`.
+                let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
+                // SAFETY: `tag_set` is a reference to an initialized `blk_mq_tag_set`.
+                error::to_result( unsafe { bindings::blk_mq_alloc_tag_set(tag_set.get())})
+            }),
+            _p: PhantomData,
+        })
+    }
+
+    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
+    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl<T: Operations> PinnedDrop for TagSet<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: By type invariant `inner` is valid and has been properly
+        // initialised during construction.
+        unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 55280ae9fe40..145f5c397009 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -126,6 +126,12 @@ pub fn to_errno(self) -> core::ffi::c_int {
         self.0
     }
 
+    #[cfg(CONFIG_BLOCK)]
+    pub(crate) fn to_blk_status(self) -> bindings::blk_status_t {
+        // SAFETY: `self.0` is a valid error due to its invariant.
+        unsafe { bindings::errno_to_blk_status(self.0) }
+    }
+
     /// Returns the error encoded as a pointer.
     #[allow(dead_code)]
     pub(crate) fn to_ptr<T>(self) -> *mut T {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index fbd91a48ff8b..2cf7c6b6f66b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -27,6 +27,8 @@
 extern crate self as kernel;
 
 pub mod alloc;
+#[cfg(CONFIG_BLOCK)]
+pub mod block;
 mod build_assert;
 pub mod error;
 pub mod init;
-- 
2.45.1


