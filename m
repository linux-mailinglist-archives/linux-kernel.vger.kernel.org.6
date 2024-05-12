Return-Path: <linux-kernel+bounces-176974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4D88C3805
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B118D1F21285
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390ED5337D;
	Sun, 12 May 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="2FoCPYHA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879841C93
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539129; cv=none; b=DhDm5KERZP3WVTUyiuYBNHuw65pc7OK9smORglQqe1hDTRZy0BmRx9+h1VgwSFf1V5c8Xu6/wcZ6E42IgVSfAy6heUG2uDXzfR6+l77kXbsWuwPRf7egBlg//Utb9l6qrRVlOIfowLj5T9nMwAFkPz5posPTXQX1BYARU+QFeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539129; c=relaxed/simple;
	bh=zQhfFMtf/32xi+lYgTG1ULLlEVWmIik5yzTYXylWDOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acABlQlsI7psS104vcxHhqKY6nMF91H4Vc6JDxZfbHi/0MLfhg1zz23o5VLEV6AgsRvJ3zEfeUXTpd1E4pPzDEvYjoO7uoiLFEYQsNtOnsTqv5MqD/8lo2NRZ5LpxRry97OnEyH806cwR/Tye4DapH7sGz0ig/iYePqAmKI3R7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=2FoCPYHA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so2536298a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1715539126; x=1716143926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEs+Uy+D6yRLJ6uVdcGDdXVWWb0Ye6WAdIDQbGkZrM4=;
        b=2FoCPYHAqXOoD5KsQOx9WOsfZJadt8Et6fSsgmLIbI/fcqLjn8ZLtLfues+3w4tAaW
         nWmbeOctmqsIE1PPyFLXyeALWcntAF0iMPM6SkH8GS5OLeE1A3kcjYEwFbi3lYeq2wOO
         2/uDv1HZCp1MHYmcNa+1E1ipRTpm1FbCSgr0jTSfs2ne/jNWM226GejUxwsB96J6Q0AZ
         RE2h4RtOIouGpC7ew2HwpYZw7cuQh+mjUjPhjDMq3N6bP11aSq9dH5qzuxw7wunOHkEF
         AwfNsqHqEKSdNWEhvbp3I7rkywKyr/yWFt8O4UcrrAmochkYaOTN005ESzxLdayb0VSy
         4G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715539126; x=1716143926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEs+Uy+D6yRLJ6uVdcGDdXVWWb0Ye6WAdIDQbGkZrM4=;
        b=nUU26mTrta/C4rkryYJqUUg/JByY7YqiGP1vXoAtTdebtegljoCmyONI1N/AJdEcK2
         ZmQnm0lu/bGfj0hnX04AhcTskrc/63bw9FUw7BibaoI4VHYNKtH2Bdh0WuQ/piyInWYL
         ks3TfdGG7ZUyhK3lok2LkPxmzyVsAJJpYFRV08JEsf7lAV4Ujp59hPPxzDqYYO9r8HLh
         7KYo3+RU0FYzE08byVHvoXG4jFnWv5XFOcS0L5b6aUA2qh65YM+Vgnlwg5fPNY2OsCu0
         IBEzsMDp9RDWpe7/E1Ey/XpzjHVCP/fF5SAacxQNWVMdtX3jKx8tJn8vzsvFVf9gDrZ6
         DRUg==
X-Forwarded-Encrypted: i=1; AJvYcCWxNJ1IQepTLw0Szl/DOt2gvFgBYy/UrxkAo4X8jVHNHDKNccFoTryoRddQzFoBVVwdTNPb6mtKUjF5FY9zVtejt7v70vhReG48XDwq
X-Gm-Message-State: AOJu0YyekOeixj9ctfZ6hVjvGGLY73rL68GCfJvIOlp8tCOLSMrAjFa8
	YVbn184ibOATejBo2IZKhmqc6sgukE6ajNS7mj6wjraMe36BwDjjaKKoBKyIVIw=
X-Google-Smtp-Source: AGHT+IFzxn8oM9sRHT5lPi1yaMqFudJyCRrmgvRN7lZpQ2U2sZg3XiNi4QXfSNB23XmaVSG/z9g+3Q==
X-Received: by 2002:a17:903:41c4:b0:1eb:50fd:7875 with SMTP id d9443c01a7336-1ef43e2323cmr102491605ad.33.1715539125697;
        Sun, 12 May 2024 11:38:45 -0700 (PDT)
Received: from localhost ([50.204.89.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136a59sm65200835ad.237.2024.05.12.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 11:38:45 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
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
Subject: [PATCH 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Sun, 12 May 2024 12:39:47 -0600
Message-ID: <20240512183950.1982353-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240512183950.1982353-1-nmi@metaspace.dk>
References: <20240512183950.1982353-1-nmi@metaspace.dk>
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
 drivers/block/rnull.rs | 82 ++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build |  2 +-
 4 files changed, 95 insertions(+), 1 deletion(-)
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
index 000000000000..80e240a95446
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,82 @@
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
+        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1))?;
+        let disk = Box::pin_init(new_mutex!(add_disk(tagset)?, "nullb:disk"))?;
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
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index baf86c0880b6..603dee4b66c4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -263,7 +263,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit,offset_of
+rust_allowed_features := new_uninit,offset_of,allocator_api
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.44.0


