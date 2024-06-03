Return-Path: <linux-kernel+bounces-199629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA68D89CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFBCB24EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4413CF9B;
	Mon,  3 Jun 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="fkZMaWbe"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2913CA80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442113; cv=none; b=S/A94ajEMzs0vQU8qbt4N2kqYPwm71EYYQrcDS04XglI1WEWi6AhV0vCCLasbkG6GdgiAsiWDIk77Hc5vFnjK0NN31mKIM6r1QKMR51tgthcaBF3UFyqc9rm8/F0b6SJdtcOiIBZmTbhnDgsiB/BbIG4xq3wQS38IzhC1cbv0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442113; c=relaxed/simple;
	bh=qc6pEF7RUK+6H2CQ8rZ3p7kYl8fLqlSHhg1GGU3Rb4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1Fhb8zMLcbm7mehOecWMfYnjY/Q+In5tuMfou5RlCFoQPHwJEBFioHl/ygqEorSyzMAUxE6eCo70jRCGxxXNx+koEshLVUjsQwFf4ORbxsyLz74yoCp/LqpQIDNiXKndexWQGndfLZik1ABI/LYEJEXXFZgqXFR42xScerV0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=fkZMaWbe; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-579fa270e53so5205492a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442109; x=1718046909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tUpFHhiF2nyw1IxV5EDxG66GkJExfgKKAw3iF807fE=;
        b=fkZMaWbexVmsKA6qFpafp8+tfilne1t/Mzl3eZsQDtMwpWHEo7Sy5NRzVfnlO3CPve
         xdrcwJpQHv2gk87HOLcbx00vcsK5gIdBwpK9LFTcuDAZjZY1qHbalrBPh7iFO7MITv14
         Gt4yVB6s81ebJLDgpJucfaViePhYE8OS8dAvbMD9ndCrAOB5Jr/duCfWoN7H7+6fPGBA
         vG+9ra/7by8SAgo2dFRra3Idrw/o0iOAFJ+JELFAheH4hPZD2FswPVCt+E/VxgGl4SJ4
         PVs3CdOfOmMAGJIFA3x5sPpNOoo4pwgsL2YaEjoTzgRMbfOK7dkY6G/BvhUJ1OUzp73i
         mWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442109; x=1718046909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tUpFHhiF2nyw1IxV5EDxG66GkJExfgKKAw3iF807fE=;
        b=iqyezZTseYD63R6sTwmwpYJ3NKNmfevAdaamjR52tiSl8TK+09+7W0nRepQd/spSoZ
         jh7a2ad+b/bpqR3VT2GaV2mPPx9L2NFZRaA6asGTZO3WKbP96w39XHyeDF7R8uxZh7f/
         elXhjQKpIux5D/UxOWZ4pgDGfm/rP2ahtHdxlrUgKjn1O1ZeGlYc4+fNQpt1cLU6QaGn
         OriSnVnwLtREeQwDh8ZJuzfrCVeqqJ1E3BDsUp2CSnIL6vEmJOO0ie484igxtJO/L0I4
         URuqIe9QCtmT/5auH7mHxZJ1JQcndCVsqrwn+9DCBvyCMFCdZo/j24mnLjmFNvubwRPz
         9YAA==
X-Forwarded-Encrypted: i=1; AJvYcCXYV1xeW9sLX7cU25yiyrVbBiXm9J/Nsd5+nZORLgVObKs44Zgw3+SttnXWX51EkqDMW5/g2pXy3jRnPruzndQskkXUofEFGDtAICmS
X-Gm-Message-State: AOJu0Ywq34zgRv61TDRNidxcskUSBnZoXMZtxSrpC8vKYQNxw/qDWtvu
	oUJzMIjq9y5jfwbu8BJFan32ZvnMzeBWGkOV3VopoVPg/Y476Ca6RCZ/xFe875g=
X-Google-Smtp-Source: AGHT+IEoqbuKYFvpOCuiH+8gNDCu/4aFEkYl2XoFeTC/yOfQKa78lw9IaRZ8gAnH0Tr0AvYERBtSVw==
X-Received: by 2002:a17:906:d044:b0:a59:c833:d274 with SMTP id a640c23a62f3a-a68209f7b4dmr785722366b.37.1717442109264;
        Mon, 03 Jun 2024 12:15:09 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fb54esm525980566b.61.2024.06.03.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:15:08 -0700 (PDT)
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
Subject: [PATCH v5 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Mon,  3 Jun 2024 21:14:54 +0200
Message-ID: <20240603191455.968301-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603191455.968301-1-nmi@metaspace.dk>
References: <20240603191455.968301-1-nmi@metaspace.dk>
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
 drivers/block/Kconfig  |  9 ++++++
 drivers/block/Makefile |  3 ++
 drivers/block/rnull.rs | 73 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
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
index 000000000000..b0227cf9ddd3
--- /dev/null
+++ b/drivers/block/rnull.rs
@@ -0,0 +1,73 @@
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
+    _disk: Pin<Box<Mutex<GenDisk<NullBlkDevice>>>>,
+}
+
+impl kernel::Module for NullBlkModule {
+    fn init(_module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust null_blk loaded\n");
+        let tagset = Arc::pin_init(TagSet::new(1, 256, 1), flags::GFP_KERNEL)?;
+
+        let disk = gen_disk::GenDiskBuilder::new()
+            .capacity_sectors(4096 << 11)
+            .logical_block_size(4096)?
+            .physical_block_size(4096)?
+            .rotational(false)
+            .build(format_args!("rnullb{}", 0), tagset)?;
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
+            // end the request. The request reference must be unique at this
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


