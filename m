Return-Path: <linux-kernel+bounces-360907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5447E99A13A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79B11F21CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DF6212F06;
	Fri, 11 Oct 2024 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n8isfaSX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9420C476
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642301; cv=none; b=HLItUIlSYz+lWMmcHXT7poa2EqQ5YRVcNH0g8BSefQq9/TNBkdCvppAGBr6wAeCypVg9nUhC3omuc4PSs+FjEWxH+q/0r2phlwOA+RBfYkGkKB8cnKCHNVTPsMYtXJyP01VYt8N4ppokv0B2QptwFB8ywbYVh9EORLheutcn860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642301; c=relaxed/simple;
	bh=lNmpjyy3NbJcexF0zfFZIhkhxowSBnVHLFNaeSt/6QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mAh7QldK8GOfJkxAIhIqVVlP7SMPyHXoT98ZhHy8jF3eNtW4Hjgw2eOiZM7MvCmcyhMArokeY4JE6h8cBE+Y77aFSAb80sdcHI7nGJ4fG62g1o5bG6l+hoozIfIQqO9Taf+D8m6cPvHmYTGYWdNIVmaEJdIrQHL8owR9bInpxn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n8isfaSX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728642295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OPU/lolIfM/2nS2HuFVcR3b/p8zFVUIDLipi7/SZskY=;
	b=n8isfaSXaEpZcvLvJbBh9V/W7aNpxzht3LjGPjDhU6QskNsvtivWkDc/y1t9ndT6MGbZjE
	zHPz0nUa6cYus+wMpHrsD984iDLXics9C6wKiu7vue47N1ihicrlu0wbQj7peHOH5a+qUr
	2VBZpS8qsTGTnfLBE1XP+5B+osLkYew=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [RFC PATCH] ext4: don't wipe data when reading inode with inlined data
Date: Fri, 11 Oct 2024 11:24:45 +0100
Message-ID: <20241011102445.13305-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a filesystem has inlined data feature enabled, the ->read_folio()
callback will need to check if the read is being done within the range where
the inline data actually is.  Since the inline data can only occur on the
first page, this verification is done by checking if the folio index is
zero.

However, if the index isn't zero, this callback is also zero'ing the folio,
effectively wiping the data that was there.  This is a bug reported in the
link bellow, and the reproducer described there can easily trigger it in a
filesystem created with inline_data and a small block size (e.g. 1024).

This patch fixes this issue by falling back to a regular readpages when the
folio index isn't zero.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200681
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/inline.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..d2e519920252 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -516,22 +516,18 @@ int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 	int ret = 0;
 
 	down_read(&EXT4_I(inode)->xattr_sem);
-	if (!ext4_has_inline_data(inode)) {
-		up_read(&EXT4_I(inode)->xattr_sem);
-		return -EAGAIN;
-	}
 
 	/*
-	 * Current inline data can only exist in the 1st page,
-	 * So for all the other pages, just set them uptodate.
+	 * Current inline data can only exist in the 1st page; for all the
+	 * other pages simply revert to regular readpages
 	 */
-	if (!folio->index)
-		ret = ext4_read_inline_folio(inode, folio);
-	else if (!folio_test_uptodate(folio)) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		folio_mark_uptodate(folio);
+	if (!ext4_has_inline_data(inode) || folio->index) {
+		up_read(&EXT4_I(inode)->xattr_sem);
+		return -EAGAIN;
 	}
 
+	ret = ext4_read_inline_folio(inode, folio);
+
 	up_read(&EXT4_I(inode)->xattr_sem);
 
 	folio_unlock(folio);

