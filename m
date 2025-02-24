Return-Path: <linux-kernel+bounces-529304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B123A422F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77EA3A21E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68314884C;
	Mon, 24 Feb 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMioRrts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424F1386B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406450; cv=none; b=YMlAmaC8LQpWXmL8+OWoVqh7RXSbaivoxceOcbFrKocNQ263jiedjPhrX2H+oKA1KM2dHELH+5RPXqlAO0++NMGN6kzWTYeSzrv0+t/ZqMWQ4fQv1P0cOGJ0/t1sQc/JZd2SLg6Z1tON7JDUlnZZP/14lZSuPGnT9EtqABgdWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406450; c=relaxed/simple;
	bh=DKGjsCANAD2sHNCqw2vt8+l4X65ZIFI3H6CYNnRVlpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghWOjOlXM8rFQxlIFvHNYK6JLWxmFCbdyD4f9Sko4dOM81M5PnR+FuaYnI+nnV7716M4GJh305o1PHzuIsZx3K2s2WihdN/IHVtrXLtc23RV+K8PhvnaKPKjiS4s+C/xKeQsz7WYi5GnubKFGx240LXBhG65smInOiBeHGzk0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMioRrts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97828C4CEEA;
	Mon, 24 Feb 2025 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406449;
	bh=DKGjsCANAD2sHNCqw2vt8+l4X65ZIFI3H6CYNnRVlpg=;
	h=From:To:Cc:Subject:Date:From;
	b=FMioRrts11CTCwEjkAF3lTbUqeILAx+oxGgcGWGfIA5sDHIVh19o8OS9c0+n1RBKJ
	 qIPF/CfaRWasb4QVMlXWxd9lfMgge9oF9fdCjZYKVmldbNmFYPJln7nqfk0umjV0SO
	 /xgnm7mFPyrVFzTYIV1zrNFpQTyXG7fS/SdVLH01/4RQUQbZT2kUzUMOvt8L4fp+js
	 xcKG00v/9h/K0iUCO3d6Fw80tmPtZO251VH0FQYuBU0pEsF/NIS5s1Bvze+/ywvDW1
	 EvDAJxC2dcMamL7/uB6Huu64IGMioSJOj5rSwh/vv94OkCT26BFY6Ivk3lQrpzeLM8
	 AkBYDlnM7Ko3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] samples/vfs: fix printf format string for size_t
Date: Mon, 24 Feb 2025 15:14:00 +0100
Message-Id: <20250224141406.1400864-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

size_t needs a %z format string modifier instead of %l

samples/vfs/test-list-all-mounts.c:152:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
  152 |                                         printf("mnt_uidmap[%lu]:\t%s\n", idx, idmap);
      |                                                            ~~~           ^~~
      |                                                            %zu
samples/vfs/test-list-all-mounts.c:161:39: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
  161 |                                         printf("mnt_gidmap[%lu]:\t%s\n", idx, idmap);
      |                                                            ~~~           ^~~
      |                                                            %zu

Fixes: fa204a65f1b6 ("samples/vfs: add STATMOUNT_MNT_{G,U}IDMAP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 samples/vfs/test-list-all-mounts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-all-mounts.c
index bb3b83d8f1d7..713c174626aa 100644
--- a/samples/vfs/test-list-all-mounts.c
+++ b/samples/vfs/test-list-all-mounts.c
@@ -149,7 +149,7 @@ int main(int argc, char *argv[])
 				const char *idmap = stmnt->str + stmnt->mnt_uidmap;
 
 				for (size_t idx = 0; idx < stmnt->mnt_uidmap_num; idx++) {
-					printf("mnt_uidmap[%lu]:\t%s\n", idx, idmap);
+					printf("mnt_uidmap[%zu]:\t%s\n", idx, idmap);
 					idmap += strlen(idmap) + 1;
 				}
 			}
@@ -158,7 +158,7 @@ int main(int argc, char *argv[])
 				const char *idmap = stmnt->str + stmnt->mnt_gidmap;
 
 				for (size_t idx = 0; idx < stmnt->mnt_gidmap_num; idx++) {
-					printf("mnt_gidmap[%lu]:\t%s\n", idx, idmap);
+					printf("mnt_gidmap[%zu]:\t%s\n", idx, idmap);
 					idmap += strlen(idmap) + 1;
 				}
 			}
-- 
2.39.5


