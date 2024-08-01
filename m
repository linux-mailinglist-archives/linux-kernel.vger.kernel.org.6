Return-Path: <linux-kernel+bounces-270450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62063943FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016411F22005
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BB315218F;
	Thu,  1 Aug 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRykYGsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73A1514F2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474824; cv=none; b=p8mAGsqcxiM5CqalGYV+3z8OM+T+YtC4UwA4Ir5B2aVeemVjvSY8JFTD1Xh8MtY45A7cEUFXbsaP7BkldyHSXMTQcv1pnGXwNkQQHRrLTbXtqXwLN7Xy09Ko+utnHMypNPFdKlWM42sfTzkhQri2PEJ3jYXhbdJ4J7rqoKrAv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474824; c=relaxed/simple;
	bh=iCaY9gvrzLDG4TQIuFc0e8gdyx5az7aETYFhapG+6hM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHTBNrW3EUYCigDsgHj5pNCFh07XwqU8mJoGAe0TgBpeOLE3MyZaJUzERY9nIlnJ1IjwWrnXsYdwdOI7i7zom3jleAKGhfVckH9YmSD5s2woysgRfMGdXzzRiq4Cqpfy6FJSYoRpGB/uPb6htVUWmSjr7NjKZViVY/14YpI/yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRykYGsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AD7C116B1;
	Thu,  1 Aug 2024 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474823;
	bh=iCaY9gvrzLDG4TQIuFc0e8gdyx5az7aETYFhapG+6hM=;
	h=From:To:Cc:Subject:Date:From;
	b=FRykYGspBkyvG+rqUcywUTjNX3prk4q2/jRufiOKTukRhyAowsZ0phbLGSeYyjixy
	 BX0cG3ZfFMJ4Auf71b9NJ2z32isp0mtkUVkN/9ejwjwhxrs1TzZ9HDqePyFiAx6wzt
	 h3Kqp3wpne08KlcuEMEH2qoIbAT0aSZRIuBpxJicUopYGXq5ItCcyf6rqjz7CmoQMC
	 BApx8h/FX4C0pvBhjZIVXKiAXuzgHdFtm+IyiKgNv5bu5a9MbFeys/DAcIAxj3ebF+
	 PGeQHpnLxD+gOlUBgNe3VA46BKvQvYiH6R2JdKQZcw7S5GKonnVLLMV8bqnrlmWzn0
	 /kMJgbbHW3H+Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/4] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
Date: Thu,  1 Aug 2024 09:13:37 +0800
Message-Id: <20240801011337.3772536-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- check dirty page before truncation
- use invalidate_mapping_pages() instead of truncate_inode_pages()
- set i_size to zero after truncation
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac61c88f7688..a316c21539d1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2199,11 +2199,17 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 			goto out;
 		}
+
+		i_size_write(fi->cow_inode, 0);
 	}
 
 	f2fs_write_inode(inode, NULL);
-- 
2.40.1


