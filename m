Return-Path: <linux-kernel+bounces-358042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA0997984
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DAF1F24AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA0A59;
	Thu, 10 Oct 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKxhkrmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805663D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518965; cv=none; b=UnrqLoLAEtEQsEfJsQ3EPKGFMWa9Sb9TaOd8tytF918VCSQnrZI7Blaaiym2F3zRZ8lx3R4AxVJVjvvi0TLmNkLv9zoNl4b/yiRlHe5mAYUOW55UHvlmJ0jioudtSvisIIPsSGOX2h66MP7VYViMF79Wfdc6zP1q7Qu3curzFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518965; c=relaxed/simple;
	bh=OtpXj8J4F6+wI9FEKWHzOxE+ev3W7YLJgXZJCUcNHkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8TKeSqSnwRznQBoEYA8fuHNAki09ejFdOMkeBVgy3HUyaFVuos3BeSHNEOd7RY8X2mPc9GudD/myLc1NnGGCYs8S3BEGlk4N8ygXCBsFWGeA+t/r2Vu41EiPwxUrPCk27vtF+FI7vz31CWGSTPN9LRskdX7VxI7r/E0j4AbMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKxhkrmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB22C4CEC3;
	Thu, 10 Oct 2024 00:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728518965;
	bh=OtpXj8J4F6+wI9FEKWHzOxE+ev3W7YLJgXZJCUcNHkI=;
	h=From:To:Cc:Subject:Date:From;
	b=VKxhkrmceFXbrQGe2EM3+5ozAmEvcs98O/cTrqvpUFwnfKhq85+P62O+1GgSfO1Mw
	 44d4QqF38ygZAdWir/cUetQ6ZKcDr6s1zC5Novp4RvrsXjH9jbCpU3IH8ANnXKyg7U
	 yfVYBbB2x2Z5+Pp9H/nLbhPaeSfPK1o3yyes3Nso2jRtLMHpGCrOd5DB6zHg/zHKkH
	 Ex5+ytzcyBl9b+/Y9/hGr3GtMF2Xt8XWWr3/SjnmuEkHuaJFywfcG0IS4nwi2T9Ks7
	 3VLBS/BNaGXnrKRb9NTg2LtkvjkPQ/isKFjTVyd9wjYXUDsI9fVgFPx4thyAgKLxQI
	 LbSfGzVujT6rw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: allow parallel DIO reads
Date: Thu, 10 Oct 2024 00:09:23 +0000
Message-ID: <20241010000923.1278817-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a regression which prevents parallel DIO reads.

Fixes: 0cac51185e65 ("f2fs: fix to avoid racing in between read and OPU dio write")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 71d5ded9eeda..adc7d64a6f47 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4647,7 +4647,8 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 					iov_iter_count(to), READ);
 
 	/* In LFS mode, if there is inflight dio, wait for its completion */
-	if (f2fs_lfs_mode(F2FS_I_SB(inode)))
+	if (f2fs_lfs_mode(F2FS_I_SB(inode)) &&
+	    get_pages(F2FS_I_SB(inode), F2FS_DIO_WRITE))
 		inode_dio_wait(inode);
 
 	if (f2fs_should_use_dio(inode, iocb, to)) {
-- 
2.47.0.rc1.288.g06298d1525-goog


