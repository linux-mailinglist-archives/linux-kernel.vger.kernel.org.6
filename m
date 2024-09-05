Return-Path: <linux-kernel+bounces-317208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244196DAF1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B31F25C04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BB19DF94;
	Thu,  5 Sep 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vstipNWd"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036719D8A6
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544637; cv=none; b=KZMtTqkAG2LH46J+QQiSF9VcN1Sc437odRanPChUE8O9pYb3hh6Jmiqah0SXCNj2UIKBb/SybKZdzWLiWmfxyXBO5GlJDypeiykqClOsdR+3GhXpeAai1xAaa5OyaVUfZLFwEi9i3uoa0Pn6eZQm40DaOOuOEaD/1CHvuzrD9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544637; c=relaxed/simple;
	bh=FzYo35LLTxDc7Hwb6+woJCKFW+Ga1xZxvVSAbKrDsok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHZqOVfd2HoY/mRCtlAE1XCR790YzccB7fcT52gONOTtHIjyWM2MIl4c7WBZixVW1LzZBXLmjBIORar+3+TIrFH6iLQDFu35B/GOfLdJoq01u7OZLcmJFdnh2u1p8Y/gGNBVRdJWQdPeIEwxebQQot63ubEmHNIqR8AIxooWBtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vstipNWd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725544633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FVuIJCT209bF1zsxBrnTXUH3tk328yVBQnxL1a5/8R4=;
	b=vstipNWdLUeNwVQwkw0gPA895/5S4s3GwtAwpaYXEYLahGKyqhB0s7ChxVJqd0dCGXtbGN
	FFPf5yGdHJmnkMoAMG3Q6Q/zLi84Ufikh+r0/TVPJhuVtu+AAgNoLuLzjwn0QwvrTBjP6M
	hdODbatqHnyJaZjkHvK9IL06wKcP9hc=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH v2] ceph: ceph: fix out-of-bound array access when doing a file read
Date: Thu,  5 Sep 2024 14:57:00 +0100
Message-ID: <20240905135700.16394-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__ceph_sync_read() does not correctly handle reads when the inode size is
zero.  It is easy to hit a NULL pointer dereference by continuously reading
a file while, on another client, we keep truncating and writing new data
into it.

The NULL pointer dereference happens when the inode size is zero but the
read op returns some data (ceph_osdc_wait_request()).  This will lead to
'left' being set to a huge value due to the overflow in:

	left = i_size - off;

and, in the loop that follows, the pages[] array being accessed beyond
num_pages.

This patch fixes the issue simply by checking the inode size and returning
if it is zero, even if there was data from the read op.

Link: https://tracker.ceph.com/issues/67524
Fixes: 1065da21e5df ("ceph: stop copying to iter at EOF on sync reads")
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ceph/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..41d4eac128bb 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1066,7 +1066,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
-	if (!len)
+	if (!len || !i_size)
 		return 0;
 	/*
 	 * flush any page cache pages in this range.  this
@@ -1154,6 +1154,9 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		doutc(cl, "%llu~%llu got %zd i_size %llu%s\n", off, len,
 		      ret, i_size, (more ? " MORE" : ""));
 
+		if (i_size == 0)
+			ret = 0;
+
 		/* Fix it to go to end of extent map */
 		if (sparse && ret >= 0)
 			ret = ceph_sparse_ext_map_end(op);

