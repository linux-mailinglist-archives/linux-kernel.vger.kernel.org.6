Return-Path: <linux-kernel+bounces-197877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFD38D7044
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563AB282BFA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AE51527A0;
	Sat,  1 Jun 2024 13:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="1tz+sqM+"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806A41514FB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249238; cv=none; b=VUmKg3rGuGaKAzO6fTYfOHMGPTSpHNlB0VAMF4o8eO+NmVmnY9fF+hYnVeyPgzUBKZhvMNTLQFCtA1jphQbFhjx+nM6v/etm2lGsDvpL6Yf+HJc+5a9j7ChOPR2Ojfn5tmoGtU2WDaJv4T58wSRhYtVqjS0KLBwhoSP5H7MRAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249238; c=relaxed/simple;
	bh=aQ38ZhHYsrlwdR3vgqyHxmlopGuks4yflq18E5jTA4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWI5xFJY0/he8+8qwPWoBMKgCHXSungizvZMWrShBo5fK6MupOWKmZNurhl3UcjCf+0aOOYWQBf+Z8ByoA53xlq9h4W17GMFzPNNNuSa/a3ASML0SOrglC9e0Qp5Bf6YiSy+873RC3PCsQQi2XQTkz+3jgQAhUx5QZCIQ6gy3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=1tz+sqM+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5785199f7d1so1561693a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 06:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717249234; x=1717854034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyzuF3brQQkovopkloODG73sB5o5CxxgafSs5PeVkB4=;
        b=1tz+sqM+WGfQjUidz0FZkYuN7/Su8sMNGeEaEay9fkm5i7bVXjMyCBREh3x6sDAXZU
         HBjycbEPF45v8fcCgdRDwDY3/Sh+6tyiLuTqXwyDt7W1ZeaW7yd1Sam6c5KL8+nD0keR
         2+irnhxXySMeRmEyFx28cYRxKuNZ+IF/kUlfqCsCos34fIQwE32jQ+Ui2RYaiuFd9esW
         pcybF17AJ+qXlaGvTa1eNU8jl1tuRTDY+UdWDrFMIRmwIKTxZh2FhTtOOiW0X1yQUONk
         v5PvsBeMjxcGr08EFcUX93XyrKAgYy3ZR/RmRD+JBxV5AUFAoGq7r5sHPFtI/ChmhVzL
         Qmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249234; x=1717854034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyzuF3brQQkovopkloODG73sB5o5CxxgafSs5PeVkB4=;
        b=C5mcXMPRXuMSnzF88ykt13gjmIwEmbeK0pslg4EmwfJbpnvg8/PRUKTlDKIzcZVIZG
         KLVbyrR5SXloAZe5L87aK5X+TkW47/YksJQNG4nI7nDzXx0OkaAu2zFGMWs5xyR8BbUe
         AICvTyzhB1jUNMTgrTpgmZIY3kI8fSsvzhtQOtCzequ/OofY2YEudsrQxZOlEQZOJsbn
         n4HswPNsP7hQi5vwrcOqrE2qD/NIGE3Y94qb8Ax97LNCQg30p1ve87B6urVeP6oPfMVP
         IYbhd+Y1Z5IB9EVq64Jqm1roIHT7K6PN8frgy7NKL+LsLo2hul4C9Xl5kJP0VODjNbZn
         lX7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwkEcww3MNh5HJV0QjDywRFV6VUzwLGSDhPwphLaUpi3/8J7H+M2ATzN5ORxT7GdKZFTwGTmoNSRHZloOsmgPgWcakIo8pIjuzQDhs
X-Gm-Message-State: AOJu0YwdUjCpJJLG6i0UxFR55TaBPoTMFr5tooYYSpPSJ3l0FFvMIth1
	GKv1Y0Y1QxX6DNoz2gamwzohq7tWe4jnGlMI1pTdjtWh13S+DmW4KzBOv4Ba3EU=
X-Google-Smtp-Source: AGHT+IHm6iJQ5zWo9gmL/sApCYvn87FeI3FVoS60Bcoobcm9QG6YgSoaJbUyMU8f1sqs0HvKYas+uA==
X-Received: by 2002:a50:d7da:0:b0:57a:22b1:b02c with SMTP id 4fb4d7f45d1cf-57a363ffeffmr3839471a12.27.1717249233833;
        Sat, 01 Jun 2024 06:40:33 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9d5d5sm2234736a12.95.2024.06.01.06.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:40:33 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Rust block device driver API and null block driver
Date: Sat,  1 Jun 2024 15:40:02 +0200
Message-ID: <20240601134005.621714-1-nmi@metaspace.dk>
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

A few more fixes based on input from Benno. Earlier version here [1].

Changes from v3:

 - mq: rewrite `atomic_relaxed_op_unless` in terms of `atomicu64::fetch_update`
 - mq: fix docs for `atomic_relaxed_op_unless`
 - mq: rewrite initialization of `TagSet` to be more idiomatic
 - rnull: add a comment for error path
 - rnull: move a ? operator


Best regards,
Andreas Hindborg


Link: https://lore.kernel.org/all/20240601081806.531954-1-nmi@metaspace.dk/


Andreas Hindborg (3):
  rust: block: introduce `kernel::block::mq` module
  rust: block: add rnull, Rust null_blk implementation
  MAINTAINERS: add entry for Rust block device driver API

 MAINTAINERS                        |  14 ++
 drivers/block/Kconfig              |   9 ++
 drivers/block/Makefile             |   3 +
 drivers/block/rnull.rs             |  81 ++++++++++
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
 15 files changed, 1071 insertions(+)
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


