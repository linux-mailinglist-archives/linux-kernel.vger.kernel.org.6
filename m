Return-Path: <linux-kernel+bounces-198537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA6D8D79F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76DB0B21278
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E3E4A3F;
	Mon,  3 Jun 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qpmR0ZX/"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB44696
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379348; cv=none; b=oo9JkHH2NcerZCaYHXdvu+PB6vXPY9PTco6NWB/jjv4b8nKfciwtDq7EGjH1bnokiFlkYGnT6e4Bm2JFrwSRiU1JeFyulgjf1+jo0ruhnCfL+71jVwvohW9lE7iplz5UNVkyq+fGDwX6ag4j4rnAwPp49TbS8HOjxV0cg/2fOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379348; c=relaxed/simple;
	bh=sg/MaKEkNTcSYkhOqzw6C30ReoEJBzAJpq6wC5MeBZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9nYHx+yxDil3WNmVg7IzS73EqT7holwth8WqlbP+89HW4l4Fx8JmzAkw+knaKFSDS9RCXeiTJ84d7lUSqL0NAAkeQzugi7WJJcOn1zvFIy67LyhPjUR67vrhH5/YVCdDeruCI0HevOzHWB+zC9ZXWB503PLMda8oDu1xrRlBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qpmR0ZX/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717379343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuEN8PuEp5zAf5cuG+NcBuj/QAlTcY1rhuZq1w0IU2M=;
	b=qpmR0ZX/ZxljhCkopWDzQMovYtPE8Grn4aPV3cqGFGeCLNHckmBGNuCfdTW/qYso+DIoRf
	CpwJM8nBd/6wGl3MWtXHlSx02xDTZCmtggJzndpCA7sB+pV7bNr7ow4PMn/2bEwoNA4L0d
	zqXUSh3z1GYsqECwvr5fu0d/AXcPGGA=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] fs/direct-io: Remove linux/prefetch.h include
Date: Mon,  3 Jun 2024 09:48:34 +0800
Message-Id: <20240603014834.45294-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

After commit c22198e78d52 ("direct-io: remove random prefetches"), Nothing
in this file needs anything from `linux/prefetch.h`.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/direct-io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b0aafe640fa4..bbd05f1a2145 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -37,7 +37,6 @@
 #include <linux/rwsem.h>
 #include <linux/uio.h>
 #include <linux/atomic.h>
-#include <linux/prefetch.h>
 
 #include "internal.h"
 
@@ -1121,11 +1120,6 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
 
-	/*
-	 * Avoid references to bdev if not absolutely needed to give
-	 * the early prefetch in the caller enough time.
-	 */
-
 	/* watch out for a 0 len io from a tricksy fs */
 	if (iov_iter_rw(iter) == READ && !count)
 		return 0;
-- 
2.34.1


