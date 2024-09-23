Return-Path: <linux-kernel+bounces-335755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FC397EA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016C71C212CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349C2197A77;
	Mon, 23 Sep 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vhlOKH5w"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD56D198852
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088574; cv=none; b=qw6PBHeJhCEdNJMSz48NkZHckRg4hZ3zaG1ynAI9ZM5PJEp5m256sg7jHzA9AlIvMsuSCIBVkJbpvE0t6tUXlC97s5fE0NMiW7eLCjBsjGIt/9zP5pHxilmb/SNFX/zN44pd2pVUHtk04C7imYzm0ExK0QV+BxDGezpBYGwEtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088574; c=relaxed/simple;
	bh=I2CnKuu2Uv7vhpRKiK0wqZI4jJoCqN9SGJidJoCPvN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4b8QC59Jjaf3e5BJ0CUfjxLv9GnKH6nXXZXlAWAFGOP4WEzBiW6PuuPDLYNBASTorqqL/GbnEVLrStijQOCJ4rRjKNAEbEK/wCHNSD3eyi/iDBpZ34P4+g0LoNTW3pYbO775VX1fqoey6s7L7Np8B37jnIq/knyVD1BuUWgDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vhlOKH5w; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727088569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B7NTCO8xwKE6PoRVYTk0JVzux063/kz2KYFXLVwzRBU=;
	b=vhlOKH5wDWitz2nzyeokLmABTqgDHXfUSH+LXihoZZ+C4JudpwI4Htb35/nBTJDkCE3GQM
	x8QZLBYeODfrpL21ERBGrtpJ33leddA/5yjnUg25taEe7YRyTD3JPGyGCY1GZ3kr9N1yCG
	Xuy7PKsefzW26Wv3Osg4PO7j+fMAHoI=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 2/2] ext4: mark fc as ineligible using an handle in ext4_xattr_set()
Date: Mon, 23 Sep 2024 11:49:09 +0100
Message-ID: <20240923104909.18342-3-luis.henriques@linux.dev>
In-Reply-To: <20240923104909.18342-1-luis.henriques@linux.dev>
References: <20240923104909.18342-1-luis.henriques@linux.dev>
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
ineligible.  This patch moves the call to this function so that an handle
can be used.  If a transaction fails to start, then there's not point in
trying to mark the filesystem as ineligible, and an error will eventually be
returned to user-space.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..aea9e3c405f1 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2559,6 +2559,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 
 		error = ext4_xattr_set_handle(handle, inode, name_index, name,
 					      value, value_len, flags);
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
 		error2 = ext4_journal_stop(handle);
 		if (error == -ENOSPC &&
 		    ext4_should_retry_alloc(sb, &retries))
@@ -2566,7 +2568,6 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
 		if (error == 0)
 			error = error2;
 	}
-	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
 
 	return error;
 }

