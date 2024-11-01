Return-Path: <linux-kernel+bounces-392003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F29B8E7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C051F25CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F3A15F330;
	Fri,  1 Nov 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irny/Uno"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759F158553
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455210; cv=none; b=ENGxBB2hpYHgugSri/oYdnuMjxQyV2elaUBrMzIX37x5H0kCWgRh+cjDum3E44Emk9dXC8gHx1Kswhs/HV3J4QP0HNl6EDDSjoQ0E2RD+LM166YTy1l5x1v7t4ElwXlgYEZdEmQQyyJqtEt/aPPIakyrwNLSb6kd1ivsQ+yNaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455210; c=relaxed/simple;
	bh=szirmOHLLGPT4Rpk5rV9+e7gy9gLSwyM1IEzBkLyjk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMPI5/V0FFXEzzxyDE7nHNlMXpj9sXd+HKCVyxBCIJAVaJrpEG3YPmUX7Fbro+CE8DgboLTIfaRLfqdHeSqAT3nWGR34jptQrhZvmwv7ATijD0ge4VeFdBXWNaSU+CrTs5a0TUPxp49tpxmqxLHGqYW32pwnCnfeTHS+1eXlmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irny/Uno; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c8b557f91so18537065ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 03:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730455208; x=1731060008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXE+qi0LSm8ODysTE3U4uCY5bjtR4TQVd3Ql3XOl3gw=;
        b=Irny/UnoKmAK6jtUTdzsAAOsLZIL/68bgiIh9VeI7LmTvAaN+KBZcsyT1+M5kTy9uM
         +oHgK4E6MpWeM+LagEJFGR5IM1WRXYI83KwSYJPYYv2goizhdQh/AB2O4Tcacas9F5yL
         7qg7VTbAOLAckFM+4XYwJ0gGPds0NYEPVA4GFEo4WJUb8yujA47Urv6aFkeA5aKS50rb
         ZwbhUcF81DCbQ2iDcBSrxmrPiE0axkyqqA5tZZBLm3A0fxPw2A7w4OaHIN4MD3XFMIsP
         t2i+RRY831FjwcVahQyhqqNg3KLx7bSJ7LiqXAub+IsSyxIEqlSz9bEOHYpMZgsRhUjq
         eXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730455208; x=1731060008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXE+qi0LSm8ODysTE3U4uCY5bjtR4TQVd3Ql3XOl3gw=;
        b=vNt8ypuESO93q6ItNRwTyCIV4K+Wm8VEoYhCOazvru743Q2eKfpLHZxK0swBwRVFgq
         EJWXlHfcaXllZTztAIzyWLiPGBRwsr5WAmpCPzwo9oPrgMUBSPxn+T2R+6fBBTrtZ5R2
         HwdjyCt8f2sA5nK0m3njbXbGmY58Wo+K01/s4vcsQMtIwZD/2+ZoEXpfqS+zvwlk67IK
         SP2VNTFYv9D/nsYwpdj65XANQRghQBvv4SpELbfX/c78J+Ow4IS/iT1rIgA9rRwh8jUC
         n20qjuOCb38rcc2Y/+jgd0+nMSuJVWLxu2DbgQf0XsyE3KOfhDgcgYAztXUW9XwfNYk+
         52oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBK1ialZHK2Df0RYD+IPZ5DYvMIDVx8oA2ZPGMV3oqMBjtTGnB4KgkxQZT+Fs+1uGkSLJ/UcDoVSQPYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx093banyN+xNFDjXJtrXc2oeC55QdXIl3OhBEkCssP0rYklY+C
	0GOIIQXQ/4YNz11uBg8FaTO6mNIh++Ltjd0dmGc6ruDvk3QCEY9a
X-Google-Smtp-Source: AGHT+IH+qDmPE014XFSIXoWs+bf29PK2M0J/yz6dZkz/5vEdYvX38kp2/2dRiZcLu/cOq6W9GxN86A==
X-Received: by 2002:a17:902:f684:b0:206:fd9d:b88d with SMTP id d9443c01a7336-210c6d291e5mr258001815ad.61.1730455207493;
        Fri, 01 Nov 2024 03:00:07 -0700 (PDT)
Received: from TW-MATTJAN1.eu.trendnet.org (61-216-130-235.hinet-ip.hinet.net. [61.216.130.235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4850esm4595553a91.27.2024.11.01.03.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:00:06 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shuan Khan <skhan@linuxfoundation.org>
Cc: Matt Jan <zoo868e@gmail.com>,
	syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Subject: [PATCH v4] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Fri,  1 Nov 2024 17:59:55 +0800
Message-Id: <20241101095955.9786-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
References: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure l2nb is less than BUDMIN by performing a sanity check in the caller.
Return -EIO if the check fails.

#syz test

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
Changes in v4: Thanks to Shaggy for the review. We now perform a sanity check instead of continuing as if nothing is wrong.
Changes in v3: Return the result earlier instead of assert it
Changes in v2: Test if the patch resolve the issue through syzbot and reference the reporter

 fs/jfs/jfs_dmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..89c22a18314f 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1217,7 +1217,7 @@ dbAllocNear(struct bmap * bmp,
 	int word, lword, rc;
 	s8 *leaf;
 
-	if (dp->tree.leafidx != cpu_to_le32(LEAFIND)) {
+	if (dp->tree.leafidx != cpu_to_le32(LEAFIND) || l2nb >= L2DBWORD) {
 		jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmap page\n");
 		return -EIO;
 	}
@@ -1969,7 +1969,7 @@ dbAllocDmapLev(struct bmap * bmp,
 	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, false))
 		return -ENOSPC;
 
-	if (leafidx < 0)
+	if (leafidx < 0 || l2nb >= L2DBWORD)
 		return -EIO;
 
 	/* determine the block number within the file system corresponding
-- 
2.25.1


