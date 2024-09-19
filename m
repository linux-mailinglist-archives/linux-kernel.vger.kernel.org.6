Return-Path: <linux-kernel+bounces-333345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4797C730
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9978AB2642B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335919D066;
	Thu, 19 Sep 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v0KQpTRn"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307E19ABAF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738790; cv=none; b=qlnBah6Rp4GFgeD2A+IsBSETqrnkm0s2runDxxrpqj23FNd/eUL3wK16viRofajZhgryeM49J9CjajW4CQtlv7T+YzQC/1zG6t97T3Z1TN3+bQqfeB5xk8AMb/VauC2bioJ7vHkQMXllAYigCpebcNxt5vWRs/0whVBm6p55qfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738790; c=relaxed/simple;
	bh=quLF4r0BPg/Lg56Pq4mAL3T/2KzHzxOAJO26kJYaM1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC+cfKFt3Xt2SBswcIgtFsj8V4hSGmf5APSGbjkTrWYSddBikKp/GeTKj8nNvXvfo4hePd2DaCDJq+J35ZgJsgDHUTYd66b8EfadU+p8BjCWRTO0+9BBDc6EonvK0NhbxsniV2Q6Il0ENtppqhQH8iXweqMV4DXD9Eargiv63MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v0KQpTRn; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726738762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgS97rYBis0paBZDtTgvMBnKTKUqe4gMl/tKEtgKQec=;
	b=v0KQpTRn2bRSXJivoqD9JMO2Q9lUFHzTQyCzC5w+u87Jh2qV5aM3Esc6c5/9GoPGdEt4cg
	LlYjyQ1IAm8iYoN6rl+cYuCgvJeomPWZk4J5uUx2aCoXo4RhEAQsoaMj/sR/1Ws/mFWUW6
	+18yvQZYF2vb47Q7yhNBARS7WN8chLk=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 2/2] ext4: mark fc as ineligible using an handle in ext4_xattr_set()
Date: Thu, 19 Sep 2024 10:38:48 +0100
Message-ID: <20240919093848.2330-3-luis.henriques@linux.dev>
In-Reply-To: <20240919093848.2330-1-luis.henriques@linux.dev>
References: <20240919093848.2330-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
in a fast-commit being done before the filesystem is effectively marked as
ineligible.  This patch reduces the risk of this happening in function
ext4_xattr_set() by using an handle if one is available.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..dbe4d11cd332 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2554,11 +2554,15 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 	handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
 	if (IS_ERR(handle)) {
 		error = PTR_ERR(handle);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					NULL);
 	} else {
 		int error2;
 
 		error = ext4_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
 		error2 = ext4_journal_stop(handle);
 		if (error == -ENOSPC &&
 		    ext4_should_retry_alloc(sb, &retries))
@@ -2566,7 +2570,6 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
 
 	return error;
 }

