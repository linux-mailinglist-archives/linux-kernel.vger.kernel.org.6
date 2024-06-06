Return-Path: <linux-kernel+bounces-204059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23E8FE375
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69D828223E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304817E8F1;
	Thu,  6 Jun 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l27xivrE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0E17DE1C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667545; cv=none; b=bMkEkBkCb0YwwYvmQtT0y/9mkrzaCYo6K8LDFQWkWOEM9Tjxl89E/MFtBpCogabccBrr9yzn1IazzClcUeFkHpkI4ULSyZ9SsAiEJcPEaxTk7nsRZXVHmc63mWOTn9Gt17SWkIb4E+MqDT0S3Kq0qO+tXHp0wSnnic61zxlX47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667545; c=relaxed/simple;
	bh=vpCESMH7oAFny3mUZ0bjEmQ2oG/eItdcKHHoG8MCYVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZhkukLr4zMwp8n7s+lZndkhHbNp2uVeKxbZUvro3updMSno1t8eTMsoV5c0D1jrNvIrrVmgwyVxdH8aISC3DBug1x6w1trbW8wVJveT5H+zqfS9cI7+OHQ1DuY9Pic0rMhVZ64YiEKVBXRp3tsTCu9omGfgjDyessNw1XhUZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l27xivrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEDEC32782;
	Thu,  6 Jun 2024 09:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717667545;
	bh=vpCESMH7oAFny3mUZ0bjEmQ2oG/eItdcKHHoG8MCYVk=;
	h=From:To:Cc:Subject:Date:From;
	b=l27xivrEPzpxVDgprs68EK4yUasJGbA3yLIIjSfpYXxi4LKXBtuHRk3WlVi8bFqBl
	 Fj1gX8Xt0d4KAY+1AYWagZ7etA/10ur6WFFgl6vdJiXexEemB1+im/tVI/QIrgzF3X
	 f1G/cARZ64LKcMhxzm8o0LiSm2H2CPd5p5PDCMp1zhJHceulunVb6iNrOpuuS2HQQY
	 G9LEs8KrwtxDcnWjuFxQ+OSkUTsv+Dsq2SIuLe8KqVaPL9Askqvx7yP//gUluOuOiV
	 uCwEk1RMO0OlCve3ITcXAab+usskbJA5oTG4IDZvoyRUN9AB0KhrafemKm2h9gNFmJ
	 ZK7RYlkSTtCsg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: fix to add missing sb_{start,end}_intwrite() for ckpt thread
Date: Thu,  6 Jun 2024 17:52:12 +0800
Message-Id: <20240606095213.4087668-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount
option"), checkpoint can be triggered in background thread, it missed
to cover f2fs inner checkpoint operation w/ sb_{start,end}_intwrite(),
fix it.

Fixes: 261eeb9c1585 ("f2fs: introduce checkpoint_merge mount option")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 55d444bec5c0..66eaad591b60 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1828,8 +1828,11 @@ static int issue_checkpoint_thread(void *data)
 	if (kthread_should_stop())
 		return 0;
 
-	if (!llist_empty(&cprc->issue_list))
+	if (!llist_empty(&cprc->issue_list)) {
+		sb_start_intwrite(sbi->sb);
 		__checkpoint_and_complete_reqs(sbi);
+		sb_end_intwrite(sbi->sb);
+	}
 
 	wait_event_interruptible(*q,
 		kthread_should_stop() || !llist_empty(&cprc->issue_list));
-- 
2.40.1


