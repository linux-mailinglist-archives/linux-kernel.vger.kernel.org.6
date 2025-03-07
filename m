Return-Path: <linux-kernel+bounces-551202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B1A5695B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797A83A91C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BD421ADCB;
	Fri,  7 Mar 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1eVYFfU"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100352770B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355386; cv=none; b=MLmkDiHtEyXSpQrKx1mE7oq/V2IgERGgt1XStvMMbK2tuXub5kAZjt7EA22G6+KlmN2BaEuJwANfpsIMfo06g+wrP4tPeXk1a99H+pnVLXxqVsVUEJEC//n5WFeEENUtwwqTgH0JLRkLg6FwcpTSzFUcdG7ncPsMB9AIWS5TOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355386; c=relaxed/simple;
	bh=uHfIl+XtJQaM2mwQ2nmLKVutMlRrkvXxNhGAJWUVCag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SArfeADYHrZ5Tj4CYhJX2qebvRlnoBXwPT/QlHfM9Xnu1EmtkfSbxbi8lSAFU+OvBwsuWHUe+dx5BQsVQdw8911ZLXBYiU6N0XO1kmVhcq7AC+rDecJfNvv6n+sWtLbN4TrlcW3voFj1974Peg8WBE1cpNS85GeehIINdqTwIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1eVYFfU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741355382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c535oA3Yx9kl5Xew9DyL4TIYFQS0wpeyp4RaMoxr9dc=;
	b=O1eVYFfUHOolbCOF8mXDENoV4syM6fmyl3g9K4cjZrhhOpa7ss/5x6CAWppBusrU8jeDmD
	8u5FHO+ESj+Z3uhoc8wqIeKhqHyboEo4AJuj8ups6syh9owif8VWYunlYXs3Zw7e9nIHIi
	gHMUvNGpMrsIuD/7HLXD3GngkU3WRv0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 2/7] bcachefs: Stash a pointer to the filesystem for blk_holder_ops
Date: Fri,  7 Mar 2025 08:49:26 -0500
Message-ID: <20250307134933.1033872-3-kent.overstreet@linux.dev>
In-Reply-To: <20250307134933.1033872-1-kent.overstreet@linux.dev>
References: <20250307134933.1033872-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Note that we open block devices before we allocate bch_fs, but once
attached to a filesystem they will be closed before the bch_fs is torn
down - so stashing a pointer without a refcount looks incorrect but it's
not.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/super-io.c    | 2 +-
 fs/bcachefs/super.c       | 7 +++++++
 fs/bcachefs/super_types.h | 8 +++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index 28724aee2c09..bd24b4f7eeb6 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -748,7 +748,7 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 	memset(sb, 0, sizeof(*sb));
 	sb->mode	= BLK_OPEN_READ;
 	sb->have_bio	= true;
-	sb->holder	= kmalloc(1, GFP_KERNEL);
+	sb->holder	= kzalloc(sizeof(*sb->holder), GFP_KERNEL);
 	if (!sb->holder)
 		return -ENOMEM;
 
diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 10c281ad96eb..b653dd480591 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -1431,6 +1431,13 @@ static int __bch2_dev_attach_bdev(struct bch_dev *ca, struct bch_sb_handle *sb)
 	ca->disk_sb = *sb;
 	memset(sb, 0, sizeof(*sb));
 
+	/*
+	 * Stash pointer to the filesystem for blk_holder_ops - note that once
+	 * attached to a filesystem, we will always close the block device
+	 * before tearing down the filesystem object.
+	 */
+	ca->disk_sb.holder->c = ca->fs;
+
 	ca->dev = ca->disk_sb.bdev->bd_dev;
 
 	percpu_ref_reinit(&ca->io_ref);
diff --git a/fs/bcachefs/super_types.h b/fs/bcachefs/super_types.h
index 368a63d938cf..3a899f799d1d 100644
--- a/fs/bcachefs/super_types.h
+++ b/fs/bcachefs/super_types.h
@@ -2,13 +2,19 @@
 #ifndef _BCACHEFS_SUPER_TYPES_H
 #define _BCACHEFS_SUPER_TYPES_H
 
+struct bch_fs;
+
+struct bch_sb_handle_holder {
+	struct bch_fs		*c;
+};
+
 struct bch_sb_handle {
 	struct bch_sb		*sb;
 	struct file		*s_bdev_file;
 	struct block_device	*bdev;
 	char			*sb_name;
 	struct bio		*bio;
-	void			*holder;
+	struct bch_sb_handle_holder *holder;
 	size_t			buffer_size;
 	blk_mode_t		mode;
 	unsigned		have_layout:1;
-- 
2.47.2


