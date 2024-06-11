Return-Path: <linux-kernel+bounces-209802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A07903B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F281F22F62
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00B817E459;
	Tue, 11 Jun 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="yJI1pI/c"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048817C205
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106371; cv=none; b=a088KlInDPqNnIYH3mLUL+Z655XG2dRloSCtXDm2XO1FtXaFZ+CXcnUSjnx0oWsTgJL5/BH/eNzdplXSTk2PO3OH7I8MIX0H/h/+z4wSx5SSIJgml5kzi20Ej5+yG0bIFgvofWLWWgfYOljbOLMgpBpacQZWo1ob0HWAG8ReCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106371; c=relaxed/simple;
	bh=lPk0DHo0qn2ngIxulPs6rImg+UVgHo9sWl8XWBY8tX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5IMvoDvQjyx24QXWdEsdsDBr3WrIlylHA0QwpLDSZR/ke4Br8b/KX+1d0WxyigFK4HVT9SZiQ0sr6+nOxdqyl7PqfHrPUJ/pHpVKcJy6p5onqmFWznuwMr0Q4yU2MuW/hUq5maHrJxkbt1mtFYQtrmv2p7c44Q3fdJYZgx01MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=yJI1pI/c; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so108863851fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718106366; x=1718711166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNx00mxi5pBwMfCPuGqeNzsaOgfcJX2bZVPG62r30rM=;
        b=yJI1pI/c2+3YN3q0w+LujFD2uMzICShBFLOUTOwFrEKT2diCez/cHRUgpu6QWQ3bkF
         Yxi1wcYoZJ3x6hhovfesi6NWALq23jIyRFlAVH3lPslb/K66L+NQodQdZ0XXasp6nJvE
         977/FNpCTjuB9xlfkiUicPvUajBwRuv1Cr9zjYQnIBuimXNZsOZeKlAejvffcik6MPh5
         yix/G+oUthz6O+mNsPr4JC0jayxRAcXNJQ4G8YiE9dr+/oQuZoi/Datr5AuJq0Fqk0sf
         VF53qowrkU2Qm9+BqjojeVmdiGoPh3oSRtL09LXtbiapM4T9wBPWbz3OVoCQjTCKjFn7
         itwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106366; x=1718711166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNx00mxi5pBwMfCPuGqeNzsaOgfcJX2bZVPG62r30rM=;
        b=un+KkshWApGX1Ub/rAChRHMoIdKHM2rEFeCiUPTSjq7XD91Bz0iqb5chIkZ48F/5Oq
         3JkpOMJlURRnbzCvE3QfHWjfP1JbE+Z9Tl46GDbfXza31GN71Jd5MReoiBqApwwAi5bU
         nN5EU7ElBMQICXOnJelFnSJ2aaZWgzsEucCb9TjbqC+MkDUuVAJkyusQ1oUJoTOfaMzP
         B7dQjJYPknxQEpnBSwX+EtiChqUqhQ6damHr9lQIvmmX16WQgckYKDjSkz6WDj2TnXY5
         n3rCjuBfoBRsJKnnd+lMw+9+S0Rx5sgB4qACm7zIHqXSNeuTskMNSxVWAlx0a5A5Et2t
         k+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUhXil04F6T6Y3NkKnvcGHsMPLeybQ+joOvewtG18sKt0tSZO0O0bXhh2ILm6Rv0x0hFgzKajyOn0H8P9RDWcSRcFVyiu0xCmG5k50C
X-Gm-Message-State: AOJu0Yy9XuxtAJZrNhH5KsXFFuZ0FCW/pNGMzV/l5k7IBEthE9hdQyBj
	dM/P52DtEKUDV/rOu+/FhhOwQcxERZcqQhfv8fRknL5YcUv5luQF2lB+CwNBEj8=
X-Google-Smtp-Source: AGHT+IHgpG5CsbD+dAu/3bc1p58dYePXUyNLZtxPwjK2XZy9iEWocrxe9YoH3sLm0LJ0jMbPHQIzHg==
X-Received: by 2002:a2e:8717:0:b0:2eb:eb25:81f4 with SMTP id 38308e7fff4ca-2ebeb25868dmr35702261fa.6.1718106366157;
        Tue, 11 Jun 2024 04:46:06 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1c2b1e80sm290850966b.145.2024.06.11.04.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:46:05 -0700 (PDT)
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
	Benno Lossin <benno.lossin@proton.me>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
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
Subject: [PATCH v6 2/3] rust: block: add rnull, Rust null_blk implementation
Date: Tue, 11 Jun 2024 13:45:50 +0200
Message-ID: <20240611114551.228679-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611114551.228679-1-nmi@metaspace.dk>
References: <20240611114551.228679-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705; i=a.hindborg@samsung.com;
 h=from:subject; bh=kjItG6yERTCWNvess/5I9t6qK6ZC0wX9SHch+CVZfT4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR1pvTnJ2MGdOaUV6Y2xZcGE1d2xmZHhqOWlFClpncFg4S1hoZE1kcHk2a3RM
 NnNvcllrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbWFEYTd
 BQW9KRU9HNEdqNTVLR04zeVNJUC8zSWFnRlYrdXdpV0VVYXNJQzZRTFRCRVlOQklaaGEwN1crZA
 pkNXYzcytFbTRSMmltOWpyK3JHVTRIc0tvV2J5UWs3cmxkM2VxeUVHMTlaZlYvVEszck5xYThMY
 kZFektOZFhQCnREbHNoRzlYNGZyR1ZUbnBuVmdqMG9TZUV3ZnBvaW1DdUE1MXF1dURYZW1DTFlS
 SW1BRFhCRWQyckV0cFV4dFYKZkFWelhNYnhUekJha3RjWm9HaDVPaEZicUI2TXFVdkxGTjRoZk1
 pMTk5b2picDFuNTJFclZ3N2dIWnc2WUVxVwpESzJpWjlkWWYySW9GUFpHa0hkelZjWWc3VGFNOC
 s3eDI1SGhCNTVXWURXUWhGTytLeVFQQStCT25UNzlZeVNWClFDRlA5b1JkRFBlckMzQ3l5U2EwY
 kFuN01RQkwwTFVSS2x6Ny8rUHIvRGtFNGlJb3hhNVVIbzhyWjltVEVVUmQKeDIyQURaM1poRS84
 Z3YxR1M1VFVQTG10NkN4UFVVQUpzYlduNlIza0M0eTloYi9XeHAwcWFmZDM3WlM4WU5zNgp5Q2d
 2Y2hWVVZKZllKNGZWYzFFTWFWbnFDcnBDNGsrU2wzR3JhMXF1MzBhUjZheTM2RUU2NDd1R055MU
 0rZjM0CjN5U1hlMThUNG5uTld5RGJVU2RGcE8wNktyWU93ejB2Rm4wZ0tHWFRSaVRJTHVEaVJoe
 G1ucDg0UVBLMk8yUjkKeVVUVTFnR2dRL3RmY3VBODdGV3N5OCtUckgzVVV2WDZIOCthdkNOQ2xq
 UXY2amtzTGpoSitWQWhDMGt1NFFCUgoyZTZpTVg1aDFLRVF0MUtBeEFwYmxlcDluOGhCYkhBZnd
 CdW9xRjJLUWwrenVYRS9uRFdmU3pKV20rN2dSaXQvCkZMby93TUhnNFBJbjNnPT0KPTVHazQKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@samsung.com; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

This patch adds an initial version of the Rust null block driver.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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
2.45.2


