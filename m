Return-Path: <linux-kernel+bounces-197874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B38D7042
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12431F220A2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF515252E;
	Sat,  1 Jun 2024 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="oPqFa7zT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B81514E2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249236; cv=none; b=KVRcYQhCcNvRiCY6z3W3WeSKFCjaDqy1jvadNps8uLVCLWgIFhE+TtWOVzmmTOdS4Kb0YWT8FFYirXdl/aLJK5NI5V2YnJKpFPhqB05e5T2avLH1lsy/hjyi4JnHxWZ9GsWmjvA8JPUIS1qjin5WQ5gGfOkTDCKLgkIOGrHTIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249236; c=relaxed/simple;
	bh=wyZWzeRtFIy/lfpFx/42Gg8uCjYL7fD92fkGg/GJRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVGZvMC3a+AN0GCjq8kegCVzAPX6kGNRzBnyhkndsgRxIqK0ErQgeVprJW12ne8O67Wgp2FeJuWSOlO2Y4lpw+lhjNbMU8niorZ9NodBG33dlHnHgrFGYL8Vya1m0OOCPj5UVCPaaC8pVfDCqXC8trP+i2+KI+Jtuip/CHXRSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=oPqFa7zT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68b334eb92so18935066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717249231; x=1717854031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbbL765+//qR9dgQ6VbCwr8fTmxpXU8nBqQZRURLzS8=;
        b=oPqFa7zTPcsuolwNuLCrS2BI2eJcmN2dr6a/+mHsA+GUmp5xZCjZOLVGGWax/enwdx
         BIrF9cOsQ2WDaBlRiOLLbV1s+3J+1sI+oS2kfZ4h2hcxCY0Pbtd8/CE0z5KJeGz+K4Rh
         DHIIr0XzS+mrf+0N4EWv5xbbjcpMuQGxW4ZbR5o6oMiO3FmQl39k04XY6kvNjgoKr5sM
         PGqqH26qHlNI/P62+r/R9gASP2ng128QnPrqD20cpBeUKfCdkh3Xf8uUD7UxNW6e9+zy
         oaba5e0uBf164EKAVpsdecJGCpvFMTrnC41qFoqO7C8RWwwnm/D591VU8oTCPlsIVitW
         h52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249231; x=1717854031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbbL765+//qR9dgQ6VbCwr8fTmxpXU8nBqQZRURLzS8=;
        b=GVKWR8yGDVJo9+TNdx+EUGHLFpHB709IT2Ei1Q9ytmmF/NVCSnQDd6h8uA3SnnF0/C
         yTBf+r+BpcgKPc4/t0pGwYFnQLX6fefU0PePztTr5cQ5OWyeHYzMo5QBujHOLlsbSaGh
         2CBWM1Lp1gFKVAbacwV+grECM+YVY62QdMlTnXYEyUuXjjHEnKsXG9jZUoVndaeHHEKA
         VbYX3HmQF2EJlo/M17Gdg1y+EYyZp5l2X6DJjYWs2pDy0SqWmTKHbZ9uRL9SkKooVNAF
         P/5DVEkKmu97A3YjWpMz7DsMvcE5tKl2ZP18k5Zt2/DAYXGV9jvWsT6m1ArT98dEevfl
         orJA==
X-Forwarded-Encrypted: i=1; AJvYcCUO/XMtgJpL+SOG9AUD6qUsRVNIZ+FKGJnzk1seFU19sFuzTLa7vaKR47wxn8bjI5N1qPYkViCBsxlMdj0pOLdnYdmZCQ+2qc5JuzSI
X-Gm-Message-State: AOJu0YwF33xbDUZv0UAtXdJq0xn1r9gWnzBw0T/BD6rv9o2Bf+tUZVIu
	gyF3B/FfnhERGf9PBMCiiNIEMuh2YBwMWQH7aHo5P+g8IVWenrAfWgx7JWX646E=
X-Google-Smtp-Source: AGHT+IGIzAQEiVZsK9mvFphUeSlFSnjwQw6G1YMEYHYxbAW1a3GF78ZFQGD5rzwDG2czpz7nBlb0lA==
X-Received: by 2002:a50:99d5:0:b0:579:be37:fa68 with SMTP id 4fb4d7f45d1cf-57a3638cde3mr3702735a12.20.1717249231423;
        Sat, 01 Jun 2024 06:40:31 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a4606f159sm1047164a12.43.2024.06.01.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:40:31 -0700 (PDT)
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
Subject: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Sat,  1 Jun 2024 15:40:04 +0200
Message-ID: <20240601134005.621714-3-nmi@metaspace.dk>
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

This patch adds an initial version of the Rust null block driver.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/Kconfig  |  9 +++++
 drivers/block/Makefile |  3 ++
 drivers/block/rnull.rs | 81 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
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
index 000000000000..f90808208936
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,81 @@
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
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
+
+        let disk = {
+            let block_size: u16 = 4096;
+            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
+                return Err(kernel::error::code::EINVAL);
+            }
+
+            let mut disk = gen_disk::GenDisk::try_new(tagset)?;
+            disk.set_name(format_args!("rnullb{}", 0))?;
+            disk.set_capacity_sectors(4096 << 11);
+            disk.set_queue_logical_block_size(block_size.into());
+            disk.set_queue_physical_block_size(block_size.into());
+            disk.set_rotational(false);
+            disk.add()?
+        };
+
+        let disk = Box::pin_init(new_mutex!(disk, "nullb:disk"), flags::GFP_KERNEL)?;
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
+            // We take no refcounts on the request, so we expect to be able to
+            // end the request. The request reference must be uniqueue at this
+            // point, and so `end_ok` cannot fail.
+            .expect("Fatal error - expected to be able to end request");
+
+        Ok(())
+    }
+
+    fn commit_rqs() {}
+}
-- 
2.45.1


