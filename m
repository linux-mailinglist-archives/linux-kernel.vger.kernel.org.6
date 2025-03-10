Return-Path: <linux-kernel+bounces-553895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9683A59056
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3362216BBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609D2253ED;
	Mon, 10 Mar 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x4mX5j1e"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348021D585
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600511; cv=none; b=nFeCYBHCXWeAXiAumc07eWp7XUDm70D0b8KU05HKjCpzubvuM9/Nhd7ljK497a9AqeTSRRZB4DKW3Iz9hwGePafIYBgZ6Cg5yIOgvYKASzY0b+8CV2c8dysJ+8wIJ4buywWbP2ktDOxqTDnwzjEKgCHYyDHWfza9tXnjXJQIYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600511; c=relaxed/simple;
	bh=9qLcUTgDOtr7F0Rf4V9h6zxgl+pjpEZVf1/2gdGEq1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD6FQkAIBAp6b8ZC4Nk1nuQIpUiJPk89RsuAM3FkhVxowd+NtRCry92EK2bY4E70+Bqp0WiNhglDt/IBXvgE4kUwfPShRiEMSucImjAM2aaBuiRJ8ZQBHrs9l/TrhNMa/Dmttazz4N/0/kx3F4thZUfksnweDG9cHEyPvkr0x9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x4mX5j1e; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600504; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bZhSrM1L07Py6ctqUAfultvaxatD2fvpBC6cnUPSk6Y=;
	b=x4mX5j1eedTUEIrLTI/bGI/5SoZJ4PyIjSVrncV3f1CBrxacuvDlLd6qLLA0keyvA/xyS+5ZSsu3aa4CBr/3M7VOukuH+uKdl41vqYg+SQIT5K97cFqzlj22eBJLwAQMQ/nMd/l+J4IwsQBrA2o41VvAl3kecMEZPORK2s/uNI0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3up_1741600500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 00/10] erofs: 48-bit layout support
Date: Mon, 10 Mar 2025 17:54:50 +0800
Message-ID: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

The current 32-bit block addressing limits EROFS to a 16TiB maximum
volume size with 4KiB blocks.  However, several new use cases now
require larger capacity support:
 - Massive datasets for model training to boost random sampling
   performance for each epoch;
 - Object storage clients using EROFS direct passthrough.

This extends core on-disk structures to support 48-bit block addressing,
such as inodes, device slots, and inode chunks.

In addition, it introduces an mtime field to 32-byte compact inodes for
basic timestamp support, as well as expands the superblock root NID to
an 8-byte rootnid_8b for out-of-place update incremental builds.

In order to support larger images beyond 32-bit block addressing and
efficient indexing of large compression units for compressed data, and
to better support popular compression algorithms (mainly Zstd) that
still lack native fixed-sized output compression support, introduce
byte-oriented encoded extents, so that these compressors are allowed
to retain their current methods.

Therefore, it speeds up Zstd image building a lot by using:
Processor: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz * 96
Dataset: enwik9
Build time Size Type Command Line
3m52.339s 266653696 FO -C524288 -zzstd,22
3m48.549s 266174464 FO -E48bit -C524288 -zzstd,22
0m12.821s 272134144 FI -E48bit -C1048576 --max-extent-bytes=1048576 -zzstd,22

It has been stress-tested on my local setup for a while without any
strange happens.

Thanks,
Gao Xiang

Gao Xiang (10):
  erofs: get rid of erofs_map_blocks_flatmode()
  erofs: simplify erofs_{read,fill}_inode()
  erofs: add 48-bit block addressing on-disk support
  erofs: implement 48-bit block addressing for unencoded inodes
  erofs: support dot-omitted directories
  erofs: initialize decompression early
  erofs: add encoded extent on-disk definition
  erofs: implement encoded extent metadata
  erofs: support unaligned encoded data
  erofs: enable 48-bit layout support

 fs/erofs/Kconfig             |  14 +--
 fs/erofs/data.c              | 133 +++++++++++-------------
 fs/erofs/decompressor.c      |   2 +-
 fs/erofs/dir.c               |   7 +-
 fs/erofs/erofs_fs.h          | 191 ++++++++++++++++-------------------
 fs/erofs/inode.c             | 126 +++++++++++------------
 fs/erofs/internal.h          |  30 +++---
 fs/erofs/super.c             |  49 ++++-----
 fs/erofs/sysfs.c             |   2 +
 fs/erofs/zdata.c             |  96 +++++++++---------
 fs/erofs/zmap.c              | 166 +++++++++++++++++++++++++-----
 include/trace/events/erofs.h |   2 +-
 12 files changed, 455 insertions(+), 363 deletions(-)

-- 
2.43.5


