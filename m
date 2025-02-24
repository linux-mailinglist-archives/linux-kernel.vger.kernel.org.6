Return-Path: <linux-kernel+bounces-528234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471DDA41545
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC043B2229
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485241C84B5;
	Mon, 24 Feb 2025 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9A8gXtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589B28DB3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378045; cv=none; b=Ow+hVOQXkyreGFPEW5L5xQgg5BIy/IDc9e9JFzyhWtEM2Vgk45hAvp9lM7RxBZ8j3VclF8Yz5oBTEXEFWOvEkvz9FHys/nWUkc9mVrXWjCtb4zEFheYpV/eY7gfO7m5kzGeuh9speXXLA/5M+skU/nuwacrDl5TsWeftMqPpiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378045; c=relaxed/simple;
	bh=7OtZJfqDd0ZrnQtT/O2ih4YwberR7j86G/2C/12j1BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrGH7HS+JzZ+/jOOghBpZqLOslk+OrssOXBMtQrco+geLg4JxZQim/goObFQjNtZekQztrNeBFhqkPnPiVXvL12NoGnunPSPCJ1eGqeI8v4uu/FLzFc0nNXNu1f2sBKua3WDLhC4F/epjRz7WnmRJmE7AtASGzyMmirc9+lPiJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9A8gXtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D980C4CED6;
	Mon, 24 Feb 2025 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740378045;
	bh=7OtZJfqDd0ZrnQtT/O2ih4YwberR7j86G/2C/12j1BE=;
	h=From:To:Cc:Subject:Date:From;
	b=R9A8gXtRMyEOrT96mcStzZ6V40YMpw2B3JohNiCQ6NX1CLsLlBcaemiAs+2q+apLo
	 uze9RkxGyxbuUBT1tidHi4p8A4j8T2Lp+p2ltQlyYMuJyGR31FWO3fpCvF9PtGJaqF
	 7/GKvzz4pSG3pQhQG0vNI3zJxuwKzJz2Bap9bhbCcoRYYYa6iSjvMv10E0PWJmq2F+
	 ipwE5uw7zFuJe7TBgnGf+5TuvN7UetXoGieiuN+vPt+sqb6zIf33XQEvY+wLmahTEv
	 MxBOEfTzIjgrN3Fc7iTR+hqs/C5vIH/ZluIG9TUKPBIn90tLiGGt4C517t/k1Mx+PX
	 VdeXnvFUKGF9Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: fix to set .discard_granularity correctly
Date: Mon, 24 Feb 2025 14:20:07 +0800
Message-ID: <20250224062007.1324623-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
a bug, when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
w/ any granularity to issue.

Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Yohan Joung <yohan.joung@sk.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ebe25eafafa..2b415926641f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT ||
+		F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);
 
 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.48.1.601.g30ceb7b040-goog


