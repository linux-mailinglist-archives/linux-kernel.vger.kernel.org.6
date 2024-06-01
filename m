Return-Path: <linux-kernel+bounces-197763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC28D6ED3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 10:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CB51C23E27
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD12D03B;
	Sat,  1 Jun 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="Q2LJ6MxG"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F351BF37
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 08:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717229928; cv=none; b=Pay7LtqnArtTvvOS5sfV1l8cyIiw4TJHsHX9VFq2I7IiP+yXmnFNFxYb3hIFYMooiRJun+iP+irnpJWFerI98EQgxVbDwRAGVigmngf+rljEa1p0SOBO57+v9R72vykfVipwtVvc1fZXwpyklDglTIlBvh/SM727YeBFuhaRjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717229928; c=relaxed/simple;
	bh=97vqWiRz/4WudPl9NVnJPUx380vb6H8qrelZ05oFnck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OuEQlY5YCez2Zf3fI46l/cOK33M/TXsn43YhrzCE/6ZrwaDsQLILZJMzS0NXdmrNZvKARztNI2uIcH8ExskzDNgH8w1OE0yuR3lSOl784sND9FmVEmF9xs2f92xytrts79HEBQCZ2bOt4EVVtTFYdwHG+9wSm6LSNNRdJ0XDpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=Q2LJ6MxG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so28490995e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717229925; x=1717834725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8oXzqoqzC1jj2s3HB6B17KnN0ZXhFvh9dHdw9fUwwU=;
        b=Q2LJ6MxGW8LdZ2Zha8dK0mNOwQf4PjoVN2qx8mut2mnxVrTaMnqyw5pRBk1JuAV9bd
         ht94I5J6UqlcHbSMr6dtdPU3iVI22H35QKv8g2+4XPAUaVYXyyW/cv257DD4yCHYAlYS
         SyFK3IIXAft0/mN5yuchU15hOma3g+INZ0bnPITu6FMbTMGgQo1iiSRjFpfYxQdv0Dds
         eBhuYL3cAvXlCCCowfgmMp2FUAl9ns2ZDuYDbqzwL/QMmt4xEF+7R3gdctMG9Ij8Ste/
         /dzhj40bUCYg8+wR14igiYexSdOd6BhbCtttoqjLnExTWQC0XzMd9KQUg/O/k+Rv8JML
         +Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717229925; x=1717834725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8oXzqoqzC1jj2s3HB6B17KnN0ZXhFvh9dHdw9fUwwU=;
        b=GFE6g2RFK/DNEoQLJB9X/bU/e4YsX1Z0aGpqkZhBlqR9MRIxEtncmkLHJVlArN4Kti
         B9S4BkI4c0rmwBD4s4QVAemz0DAjKiytGZxEG4Ld/A5Lp31o+PKxgqGHOcaleGoZIxUa
         aw2R6Bfj4nus5a3qQxGNVAz6XsE71RuUBUTeLP+tiFtOx4oqH7PRLQGPUhQ23diuGzt6
         XfH/BfiStBVHe0tTEzTEdwOJDJvar0qQaaFjDQ0UhlJyomD4YzfXO1PHJgUrqokIMyL2
         xIZxk6Jnc9e7NpQN5lHCfNTFe9cJCc5kuFvepHTagZDKcoIrAEuYBu+rCF1vO/h115ht
         En6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWems8X7RDzhJjLD2hpUGiLF20Q5afw8CiLWWZpjVfLxTHA+CjeBy3X++sptd937FXAkWcieYNi/RZR9pmFbS2pxa48cq59HLi7ebC
X-Gm-Message-State: AOJu0YyXKZQHfHnzmzOoJ9DO+VKgluCOgJkmEykk2tiEEdQko3kvLQJJ
	+9vBW3tnBASM2RhnBGBK8aHQQrfbiblhjJpVy6GIus1yXDhkZshZj4Avh3Gv7kk=
X-Google-Smtp-Source: AGHT+IHOjJD1FDj9KV1S+ZRW3wSuZC5DIELE42B4EytbWbUF+T1bVdC2cqj2yzvkv1dtXA3iOPMTpw==
X-Received: by 2002:a05:600c:1383:b0:421:2711:cddb with SMTP id 5b1f17b1804b1-4212e06fefbmr31123385e9.21.1717229925519;
        Sat, 01 Jun 2024 01:18:45 -0700 (PDT)
Received: from localhost ([194.62.217.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062edbcsm3542331f8f.84.2024.06.01.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 01:18:45 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Rust block device driver API and null block driver
Date: Sat,  1 Jun 2024 10:18:03 +0200
Message-ID: <20240601081806.531954-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi!

Rebased on v6.10-rc1 and implemented a ton of improvements suggested by Benno. v2 is here [2]

Changes from v2:

 - implement `atomic_relaxed_op_return` in terms of `AtomicU64::fetch_update`.
 - update `Request` docs with state tracking info
 - link all types in docs
 - add invariant to `TagSet`
 - do not unwrap pin in `TagSet::drop`
 - remove references to `try_ffi_init` from comments
 - numerous typo fixes
 - code formatting fixes
 - remove remote completion logic
 - move `gen_disk::try_new` into `GenDisk` impl
 - make `GenDiskState` sealed
 - add a default state for `GenDisk`
 - conditionally call `del_gendisk` on `GenDisk` drop
 - move `add_disk` into `init` functon in rnull module
 - improve error message in request completion assertion
 - rebased on v6.10-rc1

Best regards,
Andreas Hindborg


Link: https://lore.kernel.org/all/20240521140323.2960069-1-nmi@metaspace.dk/ [1]


Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 ++
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  78 +++++++++
 rust/bindings/bindings_helper.h    |   2 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  97 ++++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 222 ++++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 233 +++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 246 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  97 ++++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 15 files changed, 1085 insertions(+)
 create mode 100644 drivers/block/rnull.rs
 create mode 100644 rust/kernel/block.rs
 create mode 100644 rust/kernel/block/mq.rs
 create mode 100644 rust/kernel/block/mq/gen_disk.rs
 create mode 100644 rust/kernel/block/mq/operations.rs
 create mode 100644 rust/kernel/block/mq/raw_writer.rs
 create mode 100644 rust/kernel/block/mq/request.rs
 create mode 100644 rust/kernel/block/mq/tag_set.rs


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


