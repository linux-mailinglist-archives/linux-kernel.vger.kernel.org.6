Return-Path: <linux-kernel+bounces-199632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF38D89D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09AF28B88F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DBC13D26A;
	Mon,  3 Jun 2024 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="hDlmctC0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81EC13D24F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442119; cv=none; b=as5+1/zkTcRAECcz9L53JSBLbFcT2MPxdufn3PPlsKUUPkvoF5Qr5aHD6tkKjmrd/rVar+bKGOMCccOcvMl5cPosC2eOwZEtBym9Oljnzn57D+3o9Vp5eeK3J/jnaUpV5o4Cz7hfXa0lBhz6Ws6iKIBRdKpzuAQj+aC3hqrMJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442119; c=relaxed/simple;
	bh=u3t0ocUfsdb3hvZ3j1iQpvNqlGBmE9PoE/Vra50k+lM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlcCQrmQ5FN2qskY2nGevFRKfCRzC+VvsdIg7KEFLxbZptyyWLYXPItm0qRsnuyAVQBfWVLtwenQ7Wpb+ADMo1MPrxL1HXJECiNXRinKTs1gaykJ/EnWDjbF5Pf8o/wOVIMvvLWuLdfXSAEK8kCQ5IYnjB+BhDhs+SX3jXhuZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=hDlmctC0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a634e03339dso521476266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717442115; x=1718046915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3gYSeR22FHk/H63N5QKIzZFhN7radWE7HTLdWSrTW4=;
        b=hDlmctC0QQgNQQqIpppS/6l+ka0eMmKm5ZpnmXIpYEr2YTmY+9ug3jMw2demcoAe5N
         jh73dUfD61yL1VJumFFXNOXZVoCEov3fc7bj31JkgtNo64MQ+YXnGXmTwuEmwAEN2K0U
         1r0438FkyVVQxpa9EN6LBFZzyG+w4HRWLVcUwMaFyQgpBUK0PHOxwgBOpGE6pqduyTJ2
         CFz0OlkffTpOjuFSLJ6cgmqEXkeWBljS6sBGt7zT1GHdt6XPheVRAFkpA/yb0UT4fO/r
         euX5CC6c3yp5o4TUbqHf3kn2JOIFCwwzB7V6wQUhHdtfgQgIiT2n9t5iOwaTpws4aumC
         S4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442115; x=1718046915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3gYSeR22FHk/H63N5QKIzZFhN7radWE7HTLdWSrTW4=;
        b=vCCHoIWx7fGMdEtpIP3B169MjbJf9KiLY2eiLT7g/bLM2WDT4zQY7THrOsqu2O6Pqr
         RSMcFNOxB2lm7XNkIGdOpdaboLPV11wWOrimZZljv1yBgHKbo0D7sny4ygiRJHfIGylS
         NU4ljqtf3f5eE3O0lXADI7fP/MJN+FQ87oxLOVY5gCTaFzLWqLbxPnufzLygBPDYWGoc
         2n5IwF1V8ePV3yUUiquEbrhWyJnQO6raJ9cQ7LKgFX0iOZRK5NqOlo366KDndc3HNh7J
         DUC+8UZm/QRSy3pJVULdyGCKcdQMAWP3M/LhoLX8/G1aG5fHLjM4pMG4m83hAAPt4zI2
         YvAg==
X-Forwarded-Encrypted: i=1; AJvYcCUhUtsjbYw/kY+iwQWOUTDXIaQNQe8dsTkKqyGfns99aRdDUUDLK0yxoK6nPsO5VMRh9EApWgsPgp4XdvJwNCQ2xf6A0OwXN8+aMlsm
X-Gm-Message-State: AOJu0Yy15robPUXjxVygQ2kgnXt1SyydbiZJIJUoWJMfiWVLCf9iXqGM
	xQsUrqlB6kqJYpfd6dPrBq52zZW5+gKLIJ8cA0DkBs2KWM+5SOjO6OMJFxaxA6k=
X-Google-Smtp-Source: AGHT+IHtgHIBlj0zS7xLzxbXE82m/ijZzbggdzdL/HGAffnhu1YIh6Q7lAgz14EYizsTYU1kolggXw==
X-Received: by 2002:a17:906:ca57:b0:a68:a117:2635 with SMTP id a640c23a62f3a-a68a117287fmr493697166b.22.1717442115351;
        Mon, 03 Jun 2024 12:15:15 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68c38b3803sm362409466b.112.2024.06.03.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:15:15 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Rust block device driver API and null block driver
Date: Mon,  3 Jun 2024 21:14:52 +0200
Message-ID: <20240603191455.968301-1-nmi@metaspace.dk>
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

Here is the fifth iteration!. This revision includes a check to validate the
block size in the abstractions rather than in the driver. Also, the `GenDisk`
type state was changed to a builder pattern.

V4 is here [1].

Changes from v4:

 - validate block size in abstractions instead of in driver code
 - refactor `GenDisk` to builder pattern instead of type state
 - refactor `Request::try_end` and `Request::end_ok` methods`
 - fix formatting errors
 - fix and clarify a number of safety comments
 - fix typos in documentation

Thanks to all those who had spare cycles to suggest improvements!

Best regards,
Andreas Hindborg


Link: https://lore.kernel.org/all/20240601134005.621714-1-nmi@metaspace.dk/ [1]


Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 ++
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  73 +++++++++
 rust/bindings/bindings_helper.h    |   3 +
 rust/helpers.c                     |  16 ++
 rust/kernel/block.rs               |   5 +
 rust/kernel/block/mq.rs            |  98 +++++++++++
 rust/kernel/block/mq/gen_disk.rs   | 215 ++++++++++++++++++++++++
 rust/kernel/block/mq/operations.rs | 237 +++++++++++++++++++++++++++
 rust/kernel/block/mq/raw_writer.rs |  55 +++++++
 rust/kernel/block/mq/request.rs    | 252 +++++++++++++++++++++++++++++
 rust/kernel/block/mq/tag_set.rs    |  85 ++++++++++
 rust/kernel/error.rs               |   6 +
 rust/kernel/lib.rs                 |   2 +
 15 files changed, 1073 insertions(+)
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


