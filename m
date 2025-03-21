Return-Path: <linux-kernel+bounces-571817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00C6A6C2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F001B6136B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0770B225A20;
	Fri, 21 Mar 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GeD8eRh1"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93506182D7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582916; cv=none; b=rR1JjgwIOHTrAleKx0DDPvOCDYFBtW1pZaqgkZ+VIiNPYvIeQSd1bNmR/r9fdphLDvws/oVYEqWFeEM8+yV3LfioyKrerwsKFbAhcotFVm40oOrmtTNI19bGDp6C7x8+aDTJwUksnPeX2GVJ4g5Z1lB5n7sQlNGDC4VtDMFas1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582916; c=relaxed/simple;
	bh=6AzoF/Ua5e+W0pbqITq3gdd8+FkMv4UUD2h/rIjjbfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZIMmpfvN2cd1Vi2cAWjUx+XDec2UkDejI+t1I1SOgJ2AMSALtbPEBdMriIc6x7JvIFYAS8A02Z22T1CqYDScFNP+7TJBR/fzkagvaPcCXu0x4eZTIkw1ouHHr8KOxU4hwH7mzw8djUhzK7nnQ/d8O7TgwNviCiEHdc8zvkCzUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GeD8eRh1; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3cce58350afso714215ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582913; x=1743187713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHccgnyGjmXgT4aBmP5V5Ck7Nqm5/kAs+bF2mszWGKw=;
        b=GeD8eRh1277u5DbojD1w6Xwrk4LvnZT8OeLW7rzO+VERXspOo5+3pusJGujSKToZkQ
         vtUgy49gWfzhwR6bNFE8nA3oF5qPD45BZWDd0qNkyMOaBgJojHmPrR21lhbOxuehabma
         YOOs3wDkZcsx6usegGHYqaFoveNLsyOrmkTS6QmM/t0Wrh2RbSgHFov4JVLhVqq2KA24
         JgAwW+E2/sggso/COVOIyBR7FJwPb7lKoo8IB7cwM7yHQOPTqf/r0qM1ccvGna3dr6nG
         Yk7H7uTt69WLVu2o3IWdZ2Urgvc8T6eRrFE/Tvy4FlXc7RiT3s7PWqo3xVMtbqtH3fQO
         91Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582913; x=1743187713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHccgnyGjmXgT4aBmP5V5Ck7Nqm5/kAs+bF2mszWGKw=;
        b=NlJWP+KIPZGxnDC1pEFt1Moqj3I2urki/+7TpSRA6VVNYWIaz2pzQ/8mTtE9tuhbYZ
         SJz1TnkNp3PHt07xfgTTaysvPbPLUTJNJYM91BaTdfWpseU6A9A6ktn2IhfpajYDVNIP
         iBp4623yMIdLOA2GOrdb9dlXxHz/N9HmHvJ7SKnSxX4F7PGTk3GSTbMoCh8/4gfBIFQB
         fwxiOpmSzz4Gp6x/vjU5biZMgskr2O16cnHdEseFl3fchR8B/ZNJ1xzFl3IOLCL5XKyS
         ipCZOy2X3kmmcwdh4uybeZxGwFp9FxY5GJCipQah/jlkfw6S7d0r0JW/THG0z79LFsU2
         VRKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPW8r7mxjEeJDGA84JLQfu01ds7ldg4xxNsWhKUnM4nENgwDM20K70oLrogZ0I6E1TEQN7JyoNbNc9hzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFBqykxJGZnwZ5gvP0maKQYBaXAzQamMC+3ZY2d/yPRxbTull
	BXdgaKqSrS1VIY6y8EBpf9Vp57RJ2LMHDqhmluEmoone9lQwxValXPmeghppGscLEnXbs9fmE1n
	lPqXKX1z+z1GNS+0cVCw7RLr+6lLoctS9
X-Gm-Gg: ASbGncvQ9YDtOAuDXbZjPTwPQH15hgZ5mTPcNjvi/sjMDIRvaTGleaIx95ngw/xASap
	nUEUXI2QBhsSMXNsQRiKChl3KqTmIn4S7DOlhu3AeyeJ1ieXoL9G20G35Fw1Meu72BJFYIyum9N
	u2wZSIsyXJQtPnApzB1K5DXY1NANMDQ5Z1tlRy0ULE/mrTHqchMUKxQHJel9MTIJy0uDebZSCWV
	5NL5Vz01dZVxQnB05gPe38/KkfAKuavgwwq+U/soBELnYyMymgTH3qiPRqBvpMfyzBZYKL8bD9o
	FP0BQ28JwCRHKp5wqq/Qgviv391p/t9/cGHoTHiYlK0Ul8d0
X-Google-Smtp-Source: AGHT+IE2gq8VfE7y0u8ZE/y1UaXhkIL7UtIv5Dn35ylqA63nyjKdHBiBzbQoseHLAnZkyIwqHMeuICy9o9u5
X-Received: by 2002:a05:6e02:1fc7:b0:3d4:2db:326f with SMTP id e9e14a558f8ab-3d5961853b9mr13368595ab.6.1742582913368;
        Fri, 21 Mar 2025 11:48:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f2cbf03526sm103702173.56.2025.03.21.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:48:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B430F340245;
	Fri, 21 Mar 2025 12:48:32 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ADE5DE4192A; Fri, 21 Mar 2025 12:48:32 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/3] Consistently look up fixed buffers before going async
Date: Fri, 21 Mar 2025 12:48:16 -0600
Message-ID: <20250321184819.3847386-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To use ublk zero copy, an application submits a sequence of io_uring
operations:
(1) Register a ublk request's buffer into the fixed buffer table
(2) Use the fixed buffer in some I/O operation
(3) Unregister the buffer from the fixed buffer table

The ordering of these operations is critical; if the fixed buffer lookup
occurs before the register or after the unregister operation, the I/O
will fail with EFAULT or even corrupt a different ublk request's buffer.
It is possible to guarantee the correct order by linking the operations,
but that adds overhead and doesn't allow multiple I/O operations to
execute in parallel using the same ublk request's buffer. Ideally, the
application could just submit the register, I/O, and unregister SQEs in
the desired order without links and io_uring would ensure the ordering.
This mostly works, leveraging the fact that each io_uring SQE is prepped
and issued non-blocking in order (barring link, drain, and force-async
flags). But it requires the fixed buffer lookup to occur during the
initial non-blocking issue.

This patch series fixes the 2 gaps where the initial issue can return
EAGAIN before looking up the fixed buffer:
- IORING_OP_SEND_ZC using IORING_RECVSEND_POLL_FIRST
- IORING_OP_URING_CMD, of which NVMe passthru is currently the only
  fixed buffer user. blk_mq_alloc_request() can return EAGAIN before
  io_uring_cmd_import_fixed() is called to look up the fixed buffer.

Caleb Sander Mateos (3):
  io_uring/net: only import send_zc buffer once
  io_uring/net: import send_zc fixed buffer before going async
  io_uring/uring_cmd: import fixed buffer before going async

 drivers/nvme/host/ioctl.c    | 10 ++++------
 include/linux/io_uring/cmd.h |  6 ++----
 io_uring/net.c               | 13 ++++++++-----
 io_uring/rsrc.c              |  6 ++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 10 +++++++---
 6 files changed, 29 insertions(+), 18 deletions(-)

-- 
2.45.2


